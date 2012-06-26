require 'mvmv/version'
require 'mvmv/command'
require 'ansi'

class Mvmv
  def initialize color = true, outstream = $stdout, instream = $stdin
    @color     = color
    @outstream = outstream
    @instream  = instream
  end

  def convert_filenames symb, *args
    unless Mvmv::Command.respond_to?(symb)
      error "Invalid command: #{symb}"
    end

    arg_arity = Mvmv::Command.method(symb).arity - 1
    if arg_arity >= args.length
      error "Invalid number of parameters for #{symb.to_s.gsub('_', '-')}", ArgumentError
    end

    files = args[arg_arity..-1]
    files.zip Mvmv::Command.send(symb, *(args[0, arg_arity] + [files]))
  end

  def rename symb, *args
    rename_impl false, symb, *args
  end

  def rename! symb, *args
    rename_impl true, symb, *args
  end

private
  def rename_impl force, symb, *args
    pairs = convert_filenames symb, *args

    flen = pairs.map(&:first).map(&:length).max
    tlen = pairs.map(&:last).map(&:length).max

    pairs.each do |pair|
      from, to = pair
      next if from == to || to.empty?
      skip = false
      while true
        log [
          ansi('[', :bold),
          from.ljust(flen),
          ansi('=>', :bold),
          ansi(to.ljust(tlen), :blue, :bold),
          ansi(']', :bold),
          force ? nil : ansi('(', :yellow) +
                        ansi('y', :yellow, :bold) + 
                        ansi('/', :yellow) +
                        'n' +
                        ansi(')? ', :yellow)
        ].compact.join(' ')

        unless force
          case @instream.gets
          when nil
            puts
            next
          when /^n/i
            skip = true
            break
          when /^[^y\n]/i
            next
          end
        end
        
        unless File.exists?(from)
          error "  File not found: #{from}"
          break
        end

        if !force && File.exists?(to)
          skip = true
          while true
            log ansi("  #{to} already exists. Overwrite " + 
                          ansi('(', :yellow) +
                          'y' +
                          ansi('/', :yellow) +
                          ansi('n', :yellow, :bold) +
                          ansi(')? ', :yellow)
                    )

            unless
              case $stdin.gets
              when nil
                puts
                next
              when /^[n\n]/i
                break
              when /^y/i
                skip = false
                break
              else
                next
              end
            end
          end
        end

        unless skip
          begin
            File.rename from, to
            logln "  Renamed", :green
          rescue Exception => e
            error "  Failed to rename #{from}"
          end
        end
        break
      end
    end
  end

  def ansi msg, *colors
    (@color && !colors.empty?) ? ANSI::Code.ansi(*colors) { msg } : msg
  end

  def log msg, *colors
    @outstream.print ansi(msg, *colors)
  end

  def logln msg, *colors
    @outstream.puts ansi(msg, *colors)
  end

  def error message, x = Exception
    logln message, :red, :bold
    raise x.new(message)
  end
end

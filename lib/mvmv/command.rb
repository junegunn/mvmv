class Mvmv
  module Command
    class Sequencer
      def initialize n = 1
        @n = n - 1
      end

      def convert str
        @n += 1
        str.gsub(/#+/) { |x| @n.to_s.rjust(x.length, '0') }
      end
    end

    class << self
      def name n, files
        seq = Sequencer.new
        files.map { |file|
          seq.convert(n) + File.extname(file)
        }
      end

      def prefix p, files
        seq = Sequencer.new
        files.map { |file| seq.convert(p) + file }
      end

      def suffix s, files
        seq = Sequencer.new
        files.map { |file| file + seq.convert(s) }
      end

      def name_suffix s, files
        seq = Sequencer.new
        files.map { |file|
          ext = File.extname(file)
          file.chomp(ext) + seq.convert(s) + ext
        }
      end

      def ext x, files
        files.map { |file|
          ext = File.extname(file)
          file.chomp(ext) + x
        }
      end

      def upper files
        files.map(&:upcase)
      end

      def lower files
        files.map(&:downcase)
      end

      def regexpi f, t, files
        seq = Sequencer.new
        files.map { |file|
          seq.convert file.gsub(Regexp.compile(f, Regexp::IGNORECASE), t)
        }
      end

      def regexp f, t, files
        seq = Sequencer.new
        files.map { |file|
          seq.convert file.gsub(Regexp.compile(f), t)
        }
      end

      def name_regexpi f, t, files
        regexpi(f, t, files.map { |file|
          file.chomp(File.extname file)
        }).zip(files.map { |file| File.extname file }).map(&:join)
      end

      def name_regexp f, t, files
        regexp(f, t, files.map { |file|
          file.chomp(File.extname file)
        }).zip(files.map { |file| File.extname file }).map(&:join)
      end
    end
  end#Command
end


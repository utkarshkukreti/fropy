module Fropy
  class CLI
    Doc = <<DOC
Fropy - Process memory and cpu time benchmarker

Usage:
  fropy <command> [--dev-null] [--poll-interval=POLL]
  fropy -h | --help
  fropy -v | --version

Options:
  -h --help            Show this help
  --dev-null           Redirect output of the command to /dev/null
  --poll-interval=POLL Time in seconds to poll memory usage and process
                       status [default: 0.05]
DOC

    def initialize(argv)
      require "pp"
      begin
        options = Docopt::docopt(Doc)
        if options["-v"] || options["--version"]
          puts "Fropy #{Fropy::VERSION}"
          exit
        end
        benchmark = Benchmark.new options["<command>"],
                   poll_interval: options["--poll-interval"].to_f,
                        dev_null: options["--dev-null"]
        benchmark.measure
      rescue Docopt::Exit => e
        puts e.message
      end
    end
  end
end

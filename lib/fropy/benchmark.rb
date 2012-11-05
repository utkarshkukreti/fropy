module Fropy
  class Benchmark
    def initialize(command, options)
      @command = command
      @options = {
        poll_interval: 0.05,
        dev_null: false,
        log: true,
        verbose: false
      }.merge(options)
    end

    def measure
      log "Benchmarking #{@command}"
      log "Polling with interval of #{@options[:poll_interval]}s"
      log "Redirecting output to /dev/null" if @options[:dev_null]
      @max_memory = -1

      r_out, w_out = IO.pipe

      cmd = @command
      if @options[:dev_null]
        cmd << " > /dev/null"
      end

      @start_time = Time.now
      pid = Process.spawn cmd, out: w_out
      log "Spawned with pid: #{pid}"

      loop do
        status = Process.getpgid(pid) rescue nil
        break if status == nil
        current_memory = `ps -o rss= -p #{pid}`.to_i #kb
        puts "Using #{mem}kb" if @options[:verbose]
        @max_memory = current_memory if current_memory > @max_memory
        sleep @options[:poll_interval]
      end

      @end_time = Time.now
      @time = @end_time - @start_time

      w_out.close
      output = r_out.read
      r_out.close

      log "      Time: #{@time}s"
      log "Max Memory: #{@max_memory}"
    end

    private
    def log(message)
      puts message if @options[:log]
    end
  end
end

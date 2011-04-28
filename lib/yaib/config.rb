module YAIB
    class Config
        attr_accessor :nick, :name, :channels, :server, :port, :log, :host, :pass, :listeners, :prefix, :commands
        
        def initialize
            @nick = "yaib-bot"
            @name = "yaib-bot"
            @channels = []
            @port = 6667
            @host = "arcath.net"
            @log = Logger.new("log/yaib.log", "weekly")
            @listeners = []
            @prefix = "!"
        end
    end
end
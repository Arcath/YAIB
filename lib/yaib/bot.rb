module YAIB
    class Bot
        attr_accessor :channels
        attr_reader :channels, :irc, :config
        
        def initialize(conf)
            @config = conf
            @config.log.info("Connecting to IRC Server")
            @irc = IRC.new(config.server, config.port, config.nick, config.name, config.host, config.pass, config.log)
            @channels = {}
            @users = {}
            @listeners = []
            @commands = []
            @config.listeners.each do |responder|
                @listeners.push responder.new(config)
            end
            @config.commands.each do |responder|
                @commands.push responder.new(config)
            end
            @config.log.info("Joining Channels")
            config.channels.each do |channel|
                @channels[channel] = Channel.new(channel, self)
            end
            loop do
                recv
            end
        end
        
        def recv
            msg = @irc.recv
            @config.log.info("Recieved: #{msg}")
            if msg =~ /PING/
                @irc.send("PONG #{@config.host}")
            else
                if msg.privmsg?
                    msg = YAIB::Message.new(msg, self)
                    @listeners.each do |listen|
                        listen.listen(msg)
                    end
                    @commands.each do |cmd|
                        if msg.message =~ /^#{config.prefix}#{cmd.matcher}/
                            cmd.execute(msg)
                        end
                    end
                end
            end
        end
        
        def return_user(inick, chan)
            user = @users[inick]
            unless user
                user = User.new(inick, self)
                @users[inick] = user
            end
            user.channel = chan
            user
        end
    end
end
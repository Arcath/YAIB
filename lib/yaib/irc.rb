module YAIB
    class IRC
        require 'socket'
        
        def initialize(server, port, nick, name, host, pass, log)
            @log = log
            @log.info("Creating Connection")
            @con = TCPSocket.new(server, port)
            @log.info("Sending Identification")
            send("USER #{nick} #{host} bla :#{name}")
            send("NICK #{nick}")
            @log.info("Getting Response")
            msg = recv
            while msg !~ /^:.* 001.*/
                @log.info("Received: #{msg}")
                if msg =~ /433/
                    @log.info("Nickname was taken adding a _")
                    nick += "_"
                    send("NICK #{nick}")
                end
                msg = @con.recv(512)
            end
            @log.info("Setting nickname variable")
            @nick = nick
        end
        
        def recv
            @con.recv(512)
        end
        
        def send(s)
            s = s.gsub(/\n/,'').gsub(/\r/,'')
            @log.info("Sending: #{s}")
            @con.send(s + "\n", 0)
        end
        
        def join(channel)
            @log.info("Joining #{channel}")
            send("JOIN #{channel}")
            msg = recv
            while msg =~ /25[0-5]/
                msg = nil
                msg = recv unless msg =~ /255/
            end
        end
        
        def part(channel)
            send("PART #{channel}")
        end
    end
end
module YAIB
    class Responder
        def initialize(config)
            @config = config
            config.log.info("Created new responder")
        end
    end
end
module Capistrano
  module GitTags
    class Configuration
      attr_accessor :production_stage, :staging_stage

      def initialize
        @production_stage = :production
        @staging_stage = :staging
      end
    end
  end
end

# Ensure deploy tasks are loaded before we run
require 'capistrano/deploy'

# Load extra tasks into the deploy namespace
load File.expand_path("../tasks/git_tags.rake", __FILE__)

module Capistrano
  module GitTags
    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end

    class Helper

      def self.git(cmd)
        `git #{cmd} 2>&1`.chomp
      end

      def self.publish_tag(tag_name)
        git "tag -a #{tag_name} -m \"Auto created deploy tag\""
        git "push origin --tags"

        "#{tag_name}"
      end

      def self.current_branch
        git "rev-parse --abbrev-ref HEAD"
      end

    end
  end
end

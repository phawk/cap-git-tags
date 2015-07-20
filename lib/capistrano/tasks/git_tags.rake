namespace :gittags do

  task :create_tag do |t, args|
    # Don't run any of this for rollbacks etc
    if fetch(:deploying)
      run_locally do
        current_stage = fetch(:stage)

        if current_stage == :production
          # Production deploys use the latest staging tag or passed in ENV['TAG']
          if ENV['TAG']
            latest_staging_tag = production_tag = ENV['TAG']
          else
            latest_staging_tag = `git describe --match "staging*" --abbrev=4 HEAD`.chomp
            production_tag = latest_staging_tag.sub(/^staging/, "production")
          end

          info "You are about to deploy: #{latest_staging_tag} to production"
          ask :"‘yes’ to confirm deploy", "n"

          if fetch(:"‘yes’ to confirm deploy")[0].downcase != "y"
            abort "You didn't confirm the deployment"
          end

          info "Checking out '#{latest_staging_tag}' locally"
          Capistrano::GitTags::Helper.git "checkout #{latest_staging_tag}"

          unless ENV['TAG']
            info "Publishing tag: #{production_tag}"
            Capistrano::GitTags::Helper.publish_tag production_tag
          end

          set :branch, production_tag
        elsif current_stage == :staging
          # Staging deploys create a new tag based on user input
          time = Time.new

          ask :a_description_of_what_you_are_deploying, "latest changes"

          safe_tag = fetch(:a_description_of_what_you_are_deploying).downcase.gsub(/[^a-z0-9]/, "-").gsub(/staging/, "stage")
          staging_tag = "staging-#{time.year}-#{time.strftime('%m')}-#{time.strftime('%d')}-#{time.strftime('%H')}-#{time.strftime('%M')}-#{safe_tag}"

          info "Publishing tag: #{staging_tag}"
          Capistrano::GitTags::Helper.publish_tag staging_tag

          info "Deploying: #{staging_tag} to staging"
          set :branch, staging_tag
        else
          # dev environments allow any branch to be pushed and don't create a tag
          info "About to deploy your current branch, enter a different branch name to override"
          ask :branch, proc { Capistrano::GitTags::Helper.current_branch }
        end
      end
    end
  end

  before 'deploy:starting', 'gittags:create_tag'
end

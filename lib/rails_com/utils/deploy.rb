# frozen_string_literal: true
require 'open3'

module Deploy
  SHARED_DIRS = [
    'log',
    'tmp',
    'storage',
    'node_modules',
    'public/assets',
    'public/packs',
    'vendor/bundle'
  ].freeze
  SHARED_FILES = [
    'config/database.yml',
    'config/master.key'
  ].freeze
  INIT_DIRS = [
    'config',
    'tmp/sockets',
    'tmp/dirs'
  ].freeze
  extend self

  def restart

  end

  def github_hmac(data)
    OpenSSL::HMAC.hexdigest('sha1', RailsCom.config.github_hmac_key, data)
  end

  def shared_paths
    SHARED_DIRS + SHARED_FILES
  end

  def init_shared_paths(root = '../shared')
    SHARED_DIRS.map do |dir|
      `mkdir -p #{root}/#{dir}`
    end
    INIT_DIRS.map do |dir|
      `mkdir #{root}/#{dir}`
    end
    SHARED_FILES.map do |path|
      `touch #{root}/#{path}`
    end
  end

  def ln_shared_paths
    shared_paths.map do |path|
      [
        "rm -rf #{path}",
        "ln -s #{'../' * path.split('/').size}shared/#{path} ./#{path}"
      ]
    end.flatten
  end

  def prepare_commands(env = Rails.env, skip_precompile: false)
    r = []
    r << "git pull"
    r += ln_shared_paths
    r << "bundle install --without development test --path vendor/bundle --deployment"
    r << "RAILS_ENV=#{env} bundle exec rake assets:precompile" unless skip_precompile
    r << "RAILS_ENV=#{env} bundle exec rake db:migrate"
    r << "bundle exec pumactl restart"
    r
  end

  def works(env = Rails.env, options = {})
    prepare_commands(env, **options).each do |cmd|
      exec_cmd(cmd)
    end
  end

  def exec_cmd(cmd)
    puts "doing: #{cmd}"
    Open3.popen2e(cmd) do |_input, output_or_error, _wait_thr|
      while (line = output_or_error.gets)
        puts line
      end
    end
  end

end

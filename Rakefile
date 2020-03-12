require 'bundler'
require 'yaml'
require 'erb'
require 'tempfile'
require 'logger'
Bundler.require

namespace :workflow do
  def logger
    @logger ||= Logger.new(STDOUT)
  end

  def source_dirs
    ['paste_in_android', 'clear_notification']
  end

  def copy_for_build(from: ,to:)
    dirname = to.split('/').slice(0 ... -1).join('/')
    FileUtils.mkdir_p(dirname)
    FileUtils.cp(from, to)
  end

  desc '#'
  task :clean do
    Pathname.glob(['build/*', 'dest/*']).each do |path|
      FileUtils.rm_rf(path)
    end
  end

  desc '#'
  task :build do
    source_dirs.each do |workflow_name|
      files = Pathname.glob("#{workflow_name}/*").map { |path|
        case File.extname(path)
        when '.erb'
          erb = File.read(path)
          new_text = ERB.new(erb, nil, "%").result(binding)
          destination = 'build/' + path.to_s.gsub(/\.erb$/, '')
          File.write(destination, new_text)

          destination
        else
          destination = "build/#{path.to_s}"
          copy_for_build(from: path, to: "build/#{path.to_s}")

          destination
        end
      }

      FileUtils.mkdir_p('./dest')
      `zip -j dest/#{workflow_name}.alfredworkflow #{files.join(' ')}`

      logger.info "#{workflow_name} is built!"
    end
  end
end

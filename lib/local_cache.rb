require "local_cache/version"

require "digest/md5"
require "tmpdir"

module LocalCache
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def use_cache(method_name)
      prepend(Module.new do
        define_method(method_name) do |*args, &block|
          LocalCache.fetch do
            super(*args, &block)
          end
        end
      end)
    end
  end

  def self.fetch(key: Digest::MD5.hexdigest(caller.first), expires_in: 300)
    path = File.expand_path(key, cache_dir)
    return Marshal.load(File.read(path)) if use_cache?(path, expires_in)
    dump(path, yield)
  end

  def self.all_clear
    FileUtils.rm_r(cache_dir, secure: true) if File.exist? cache_dir
  end

  private

  def self.cache_dir
    File.expand_path("local_cache", Dir.tmpdir)
  end

  def self.use_cache?(path, expires_in)
    File.exist?(path) && (Time.now - File::Stat.new(path).mtime) <= expires_in
  end

  def self.dump(path, obj)
    FileUtils.mkdir_p(cache_dir) unless File.exist? cache_dir
    File.open(path, "w") { |f| f.write(Marshal.dump(obj)) }
    obj
  end

  def self.paths
    @paths ||= []
  end
end

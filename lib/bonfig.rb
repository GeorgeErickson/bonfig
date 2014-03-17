module Bonfig
  class BlankConfig < BasicObject
    def initialize(&block)
      @_data = ::Hash.new
      instance_eval(&block)
    end

    def config(name, options = {}, &block)
      name = name.to_sym
      if block
        _nested(name, &block)
      else
        @_data[name] = options[:default]
        define_method("#{name}=") { |value| @_data[name] = value }
        define_method(name) { @_data[name] }
      end

      define_method("#{name}?") { @_data.key?(name) }
    end

    def [](key)
      @_data[key]
    end

    def to_hash
      @_data.reduce({}) do |accum, (k, val)|
        accum[k] = val.instance_of?(BlankConfig) ? val.to_hash : val
        accum
      end
    end

    def instance_of?(klass)
      klass == BlankConfig
    end

    protected

    def _update(data)
      @_data.update(data)
    end

    def _nested(name, &block)
      nested = @_data[name] = BlankConfig.new(&block)

      define_method(name) do |&b|
        if b
          b.call(nested)
        else
          @_data[name]
        end
      end

      define_method("#{name}=") do |val|
        if val.is_a?(::Hash)
          nested._update(val)
        else
          fail 'Can\'t assign value to nested config.'
        end
      end
    end

    def define_method(name, &block)
      name = name.to_sym
      (class << self; self; end).class_eval do
        define_method(name, &block)
      end
    end
  end

  def bonfig(&block)
    @config ||= BlankConfig.new(&block)
  end

  def config(data = nil, &block)
    yield(@config) if block_given?
    @config
  end
end

require 'spec_helper'

module Helper
  def bonfig_subject(&block)
    subject do
      Module.new do
        extend Bonfig
        bonfig(&block)
      end
    end
  end
end

RSpec.configure do |config|
  config.extend Helper
end

PROTECTED_WORDS = [:size, :method_missing, :new]

describe Bonfig do
  context 'simple' do
    bonfig_subject do
      config :name
      config :name_default, default: 1
    end

    it 'uses a default if given or nil' do
      expect(subject.config.name).to be_nil
      expect(subject.config.name_default).to eq(1)
    end

    it 'allows overide' do
      subject.config do |c|
        c.name = 1
        c.name_default = 2
      end

      expect(subject.config.name).to eq(1)
      expect(subject.config.name_default).to eq(2)
      expect(subject.config.to_hash).to eq(name: 1, name_default:  2)
    end

    it 'to_hash' do
      expect(subject.config.to_hash).to eq(name: nil, name_default:  1)
    end
  end

  context 'protected words should be valid configs' do
    bonfig_subject do
      PROTECTED_WORDS.each do |meth|
        config meth, default: meth
      end
    end

    PROTECTED_WORDS.each do |meth|
      it meth.to_s do
        expect(subject.config[meth]).to eq(meth)
      end
    end
  end

  context 'nested assignment' do
    bonfig_subject do
      config :redis do
        config :port, default: 6379
        config :host, default: 'localhost'
      end
    end

    it 'allows nested block assignment' do
      subject.config do |c|
        c.redis do |r|
          r.port = 1
        end
        expect(subject.config.redis.port).to eq(1)
        expect(subject.config.redis.host).to eq('localhost')
        expect(subject.config.to_hash).to eq(redis: { port: 1, host: 'localhost' })
      end
    end

    it 'allows attribute assignment' do
      subject.config do |c|
        c.redis.port = 1
      end

      expect(subject.config.redis.port).to eq(1)
      expect(subject.config.redis.host).to eq('localhost')
    end

    it 'allows hash assignment' do
      subject.config do |c|
        c.redis = { port: 1 }
      end

      expect(subject.config.redis.port).to eq(1)
      expect(subject.config.redis.host).to eq('localhost')
    end
  end
end

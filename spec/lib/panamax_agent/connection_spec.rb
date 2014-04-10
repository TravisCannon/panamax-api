require 'spec_helper'

describe PanamaxAgent::Connection do

  describe "registered middleware" do

    context 'when the default request_type is used' do
      subject { PanamaxAgent::Client.new.connection }

      handlers = [
        FaradayMiddleware::EncodeJson,
        FaradayMiddleware::ParseJson,
        Faraday::Adapter::NetHttp
      ]

      handlers.each do |handler|
        it { expect(subject.builder.handlers).to include handler }
      end

      it "includes exactly #{handlers.count} handlers" do
        expect(subject.builder.handlers.count).to eql handlers.count
      end
    end

    context 'when the request_type is overriden' do
      subject { PanamaxAgent::Client.new.connection(:url_encoded) }

      handlers = [
        Faraday::Request::UrlEncoded,
        FaradayMiddleware::ParseJson,
        Faraday::Adapter::NetHttp
      ]

      handlers.each do |handler|
        it { expect(subject.builder.handlers).to include handler }
      end

      it "includes exactly #{handlers.count} handlers" do
        expect(subject.builder.handlers.count).to eql handlers.count
      end
    end

  end
end
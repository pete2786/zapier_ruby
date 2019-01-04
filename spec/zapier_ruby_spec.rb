require 'spec_helper'

 describe 'ZapierRuby' do
  let(:zapper) { ZapierRuby::Zapper }
  let(:catch_url) { 'https://zapier.com/hooks/catch/webhook_id/' }

  it '#zap_url' do
    expect(zapper.new(:example_zap).send(:zap_url)).to eq catch_url
  end

   it '.base_uri' do
    expect(ZapierRuby.config.base_uri).to eq "https://zapier.com/hooks/catch/"
  end
end

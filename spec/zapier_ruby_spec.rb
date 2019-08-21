require 'spec_helper'

 describe 'ZapierRuby' do
  let(:body) { { message: 'Hey zapier' } }
  let(:result) do
    {
      "status": "success",
      "attempt": "5c304977-e06d-4580-86a3-xxxxxxxxxx",
      "id": "096e7041-5510-4f5b-9597-xxxxxxxxxx",
      "request_id": "5c304977-e06d-4580-86a3-xxxxxxxxxx"
    }
  end

  describe 'Zapper' do
    let(:zapper) { ZapierRuby::Zapper }
    let(:catch_url) { 'https://hooks.zapier.com/hooks/catch/webhook_id/' }
    let(:instance) { zapper.new(:example_zap) }

    describe '#zap_url' do
      it { expect(instance.send(:zap_url)).to eq catch_url }

      it 'web_hook_id has val' do
        url = zapper.new(:nil, 'webhook_id/uuiq').send(:zap_url)

        expect(url).to eq 'https://hooks.zapier.com/hooks/catch/webhook_id/uuiq/'
      end
    end

    it '.base_uri' do
      expect(ZapierRuby.config.base_uri).to eq "https://hooks.zapier.com/hooks/catch/"
    end

    describe '#zap' do
      it 'ZapierMisConfiguration'do
        expect {
          zapper.new(:typo_zap_name).zap
        }.to raise_error(ZapierRuby::ZapierMisConfiguration)
      end

      it 'http require' do
        stub_request(:post, catch_url).with(body: body).to_return(body: result.to_json)
        response = instance.zap(body)

        expect(response.code).to eq "200"
        expect(JSON.parse(response.body)['status']).to eq 'success'
      end
    end
  end
end

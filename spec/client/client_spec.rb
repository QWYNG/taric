require 'spec_helper'

describe Taric::Client do
  describe '.operation_values' do
    it 'returns a hash with api_key and region' do
      hash = Taric::Client.operation_values(region: :na)
      expect(hash[:region]).to eq('na')
    end

    it 'returns memoized values' do
      hash = Taric::Client.operation_values(region: :na)
      hash2 = Taric::Client.operation_values(region: :na)
      expect(hash.object_id).to eq(hash2.object_id)
    end
  end

  describe '.expand_template' do
    it 'returns an expanded Addressable template' do
      template = Taric::Client.expand_template(region: :na, operation: Taric::Operation::Champion::CHAMPION_ROTATIONS.template_url)
      expect(template).to be_an Addressable::URI
      expect(template.to_s).to eq('https://na1.api.riotgames.com/lol/platform/v3/champion-rotations')
    end
  end

  describe Taric::Client::ParallelClient do
    let(:parallel_client) {Taric.client(api_key:'test').in_parallel}
    describe '#in_parallel' do
      it 'returns a parallel client' do
        expect(parallel_client).to be_a Taric::Client::ParallelClient
      end

      it 'operation methods return itself' do
        expect(parallel_client.featured_games).to be_a Taric::Client::ParallelClient
      end

      it 'chained operation methods return itself' do
        expect(parallel_client.featured_games.featured_games).to be_a Taric::Client::ParallelClient
      end
    end

    describe '#execute!' do
      let (:url) {expand_template(Taric::Operation::LolStatus::SHARD.template_url, region: 'na')}
      before {stub_get(url).to_return(body: fixture('shard.json'), headers: {content_type: 'application/json; charset=utf-8'})}
      let (:url2) {expand_template(Taric::Operation::Spectator::FEATURED_GAMES_V3.template_url, region: 'na')}
      before {stub_get(url2).to_return(body: fixture('featured_games.json'), headers: {content_type: 'application/json; charset=utf-8'})}

      it 'returns empty array for no operations' do
        expect(parallel_client.execute!).to eq []
      end

      it 'makes multiple calls' do
        parallel_client.shard_data.featured_games.execute!
        expect(a_get(url)).to have_been_made
        expect(a_get(url2)).to have_been_made
      end

      it 'returns an array of hashes' do
        responses = parallel_client.shard_data.shard_data.execute!
        expect(responses).to be_an Array
        expect(responses.first.body).to be_a Hash
      end

      it 'clears operations after being called' do
        parallel_client.shard_data.shard_data.execute!
        expect(parallel_client.execute!).to eq []
      end
    end
  end


end

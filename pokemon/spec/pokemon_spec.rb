# require 'rspec/autorun'
require 'pry'
require_relative '../pokemon'

RSpec.describe do
  let(:magikarp) { Pokemon.new(name: 'magikarp') }

  describe '#status_at/1' do
    context 'effects' do
      it 'handles one effect at a time' do
        magikarp.apply('sleep', 1)
        magikarp.apply('paralyze', 9)

        aggregate_failures do
          expect(magikarp.status_at(1)).to eq('sleep')
          expect(magikarp.status_at(2)).to eq('sleep')
          expect(magikarp.status_at(3)).to eq('sleep')
          expect(magikarp.status_at(4)).to eq('sleep')
          expect(magikarp.status_at(5)).to eq('sleep')
          expect(magikarp.status_at(6)).to eq('sleep')
          expect(magikarp.status_at(7)).to eq('sleep')
          expect(magikarp.status_at(8)).to eq(nil)
          expect(magikarp.status_at(9)).to eq('paralyze')
          expect(magikarp.status_at(10)).to eq('paralyze')
          expect(magikarp.status_at(11)).to eq('paralyze')
          expect(magikarp.status_at(12)).to eq('paralyze')
          expect(magikarp.status_at(13)).to eq(nil)
          expect(magikarp.status_at(60)).to eq(nil)
        end
      end

      it 'handles two effects' do
        magikarp.apply('confusion', 1)
        magikarp.apply('paralyze', 4)

        aggregate_failures do
          expect(magikarp.status_at(1)).to eq('confusion')
          expect(magikarp.status_at(2)).to eq('confusion')
          expect(magikarp.status_at(3)).to eq('confusion')
          expect(magikarp.status_at(4)).to eq('paralyze')
          expect(magikarp.status_at(5)).to eq('paralyze')
          expect(magikarp.status_at(6)).to eq('paralyze')
          expect(magikarp.status_at(7)).to eq('paralyze')
          expect(magikarp.status_at(8)).to eq('confusion')
          expect(magikarp.status_at(9)).to eq('confusion')
          expect(magikarp.status_at(10)).to eq('confusion')
          expect(magikarp.status_at(11)).to eq(nil)
        end
      end

      it 'handles multiple effects' do
        magikarp.apply('confusion', 2)
        magikarp.apply('sleep', 3)
        magikarp.apply('paralyze', 7)

        aggregate_failures do
          expect(magikarp.status_at(1)).to eq(nil)
          expect(magikarp.status_at(2)).to eq('confusion')
          expect(magikarp.status_at(3)).to eq('sleep')
          expect(magikarp.status_at(4)).to eq('sleep')
          expect(magikarp.status_at(5)).to eq('sleep')
          expect(magikarp.status_at(6)).to eq('sleep')
          expect(magikarp.status_at(7)).to eq('sleep')
          expect(magikarp.status_at(8)).to eq('sleep')
          expect(magikarp.status_at(9)).to eq('sleep')
          expect(magikarp.status_at(10)).to eq('paralyze')
          expect(magikarp.status_at(11)).to eq('confusion')
          expect(magikarp.status_at(12)).to eq(nil)
        end
      end

      it 'handles effects cast multiple times' do
        magikarp.apply('confusion', 1)
        magikarp.apply('paralyze', 7)
        magikarp.apply('confusion', 9)

        aggregate_failures do
          expect(magikarp.status_at(1)).to eq('confusion')
          expect(magikarp.status_at(2)).to eq('confusion')
          expect(magikarp.status_at(3)).to eq('confusion')
          expect(magikarp.status_at(4)).to eq('confusion')
          expect(magikarp.status_at(5)).to eq('confusion')
          expect(magikarp.status_at(6)).to eq('confusion')
          expect(magikarp.status_at(7)).to eq('paralyze')
          expect(magikarp.status_at(8)).to eq('paralyze')
          expect(magikarp.status_at(9)).to eq('paralyze')
          expect(magikarp.status_at(10)).to eq('paralyze')
          expect(magikarp.status_at(11)).to eq('confusion')
          expect(magikarp.status_at(12)).to eq('confusion')
          expect(magikarp.status_at(13)).to eq('confusion')
          expect(magikarp.status_at(14)).to eq('confusion')
          expect(magikarp.status_at(15)).to eq('confusion')
          expect(magikarp.status_at(16)).to eq('confusion')
          expect(magikarp.status_at(17)).to eq('confusion')
          expect(magikarp.status_at(18)).to eq('confusion')
          expect(magikarp.status_at(19)).to eq(nil)
        end
      end

      it 'handles multiple effects cast multiple times' do
        magikarp.apply('confusion', 1)
        magikarp.apply('paralyze', 3)
        magikarp.apply('sleep', 4)
        magikarp.apply('confusion', 5)
        magikarp.apply('sleep', 6)
        magikarp.apply('confusion', 8)
        magikarp.apply('paralyze', 10)

        aggregate_failures do
          expect(magikarp.status_at(1)).to eq('confusion')
          expect(magikarp.status_at(2)).to eq('confusion')
          expect(magikarp.status_at(3)).to eq('paralyze')
          expect(magikarp.status_at(4)).to eq('sleep')
          expect(magikarp.status_at(5)).to eq('sleep')
          expect(magikarp.status_at(6)).to eq('sleep')
          expect(magikarp.status_at(7)).to eq('sleep')
          expect(magikarp.status_at(8)).to eq('sleep')
          expect(magikarp.status_at(9)).to eq('sleep')
          expect(magikarp.status_at(10)).to eq('sleep')
          expect(magikarp.status_at(11)).to eq('sleep')
          expect(magikarp.status_at(12)).to eq('sleep')
          expect(magikarp.status_at(13)).to eq('paralyze')
          expect(magikarp.status_at(14)).to eq('confusion')
          expect(magikarp.status_at(15)).to eq('confusion')
          expect(magikarp.status_at(16)).to eq('confusion')
          expect(magikarp.status_at(17)).to eq('confusion')
          expect(magikarp.status_at(18)).to eq(nil)
        end
      end
    end

    context 'special effects' do
      # Poison duration 6
      # Faint duration -

      it 'handles poison' do
        magikarp.apply('confusion', 1)
        magikarp.apply('poison', 6)
        magikarp.apply('confusion', 8)
        magikarp.apply('poison', 9)
        magikarp.apply('sleep', 10)

        aggregate_failures do
          expect(magikarp.status_at(1)).to eq('confusion')
          expect(magikarp.status_at(2)).to eq('confusion')
          expect(magikarp.status_at(3)).to eq('confusion')
          expect(magikarp.status_at(4)).to eq('confusion')
          expect(magikarp.status_at(5)).to eq('confusion')
          expect(magikarp.status_at(6)).to eq(['confusion', 'poison'])
          expect(magikarp.status_at(7)).to eq(['confusion', 'poison'])
          expect(magikarp.status_at(8)).to eq(['confusion', 'poison'])
          expect(magikarp.status_at(9)).to eq(['confusion', 'poison'])
          expect(magikarp.status_at(10)).to eq(['sleep', 'poison'])
          expect(magikarp.status_at(11)).to eq(['sleep', 'poison'])
          expect(magikarp.status_at(12)).to eq(['sleep', 'poison'])
          expect(magikarp.status_at(13)).to eq(['sleep', 'poison'])
          expect(magikarp.status_at(14)).to eq(['sleep', 'poison'])
          expect(magikarp.status_at(15)).to eq('sleep')
          expect(magikarp.status_at(16)).to eq('sleep')
          expect(magikarp.status_at(17)).to eq('confusion')
          expect(magikarp.status_at(18)).to eq(nil)
        end
      end

      it 'handles faint' do
        magikarp.apply('confusion', 1)
        magikarp.apply('poison', 6)
        magikarp.apply('faint', 8)
        magikarp.apply('poison', 12)
        magikarp.apply('sleep', 14)

        aggregate_failures do
          expect(magikarp.status_at(1)).to eq('confusion')
          expect(magikarp.status_at(2)).to eq('confusion')
          expect(magikarp.status_at(3)).to eq('confusion')
          expect(magikarp.status_at(4)).to eq('confusion')
          expect(magikarp.status_at(5)).to eq('confusion')
          expect(magikarp.status_at(6)).to eq(['confusion', 'poison'])
          expect(magikarp.status_at(7)).to eq(['confusion', 'poison'])
          expect(magikarp.status_at(8)).to eq('faint')
          expect(magikarp.status_at(9)).to eq('faint')
          expect(magikarp.status_at(10)).to eq('faint')
          expect(magikarp.status_at(11)).to eq('faint')
          expect(magikarp.status_at(12)).to eq('faint')
          expect(magikarp.status_at(13)).to eq('faint')
          expect(magikarp.status_at(14)).to eq('faint')
          expect(magikarp.status_at(15)).to eq('faint')
          expect(magikarp.status_at(16)).to eq('faint')
          expect(magikarp.status_at(17)).to eq('faint')
          expect(magikarp.status_at(18)).to eq('faint')
          expect(magikarp.status_at(19)).to eq('faint')
          expect(magikarp.status_at(20)).to eq('faint')
          expect(magikarp.status_at(21)).to eq('faint')
          expect(magikarp.status_at(22)).to eq('faint')
        end
      end
    end

    context 'more special effects' do
      # Burn duration 3
      # Freeze duration 2

      it 'handles burn' do
        magikarp.apply('confusion', 1)
        magikarp.apply('poison', 3)
        magikarp.apply('burn', 5)

        aggregate_failures do
          expect(magikarp.status_at(1)).to eq('confusion')
          expect(magikarp.status_at(2)).to eq('confusion')
          expect(magikarp.status_at(3)).to eq(['confusion', 'poison'])
          expect(magikarp.status_at(4)).to eq(['confusion', 'poison'])
          expect(magikarp.status_at(5)).to eq(['confusion', 'burn', 'poison'])
          expect(magikarp.status_at(6)).to eq(['confusion', 'burn', 'poison'])
          expect(magikarp.status_at(7)).to eq(['confusion', 'burn', 'poison'])
          expect(magikarp.status_at(8)).to eq(['confusion', 'poison'])
          expect(magikarp.status_at(9)).to eq('confusion')
          expect(magikarp.status_at(10)).to eq('confusion')
          expect(magikarp.status_at(11)).to eq(nil)
        end
      end

      it 'handles freeze' do
        magikarp.apply('paralyze', 2)
        magikarp.apply('poison', 3)
        magikarp.apply('freeze', 4)

        aggregate_failures do
          expect(magikarp.status_at(1)).to eq(nil)
          expect(magikarp.status_at(2)).to eq('paralyze')
          expect(magikarp.status_at(3)).to eq(['paralyze', 'poison'])
          expect(magikarp.status_at(4)).to eq('freeze')
          expect(magikarp.status_at(5)).to eq('freeze')
          expect(magikarp.status_at(6)).to eq('poison')
          expect(magikarp.status_at(7)).to eq('poison')
          expect(magikarp.status_at(8)).to eq('poison')
          expect(magikarp.status_at(9)).to eq(nil)
        end
      end

      it 'handles freeze after burn' do
        magikarp.apply('sleep', 1)
        magikarp.apply('burn', 2)
        magikarp.apply('freeze', 3)

        aggregate_failures do
          expect(magikarp.status_at(1)).to eq('sleep')
          expect(magikarp.status_at(2)).to eq(['sleep', 'burn'])
          expect(magikarp.status_at(3)).to eq('freeze')
          expect(magikarp.status_at(4)).to eq('freeze')
          expect(magikarp.status_at(5)).to eq('sleep')
          expect(magikarp.status_at(6)).to eq('sleep')
          expect(magikarp.status_at(7)).to eq('sleep')
          expect(magikarp.status_at(8)).to eq(nil)
        end
      end

      it 'handles burn after freeze' do
        magikarp.apply('paralyze', 1)
        magikarp.apply('freeze', 2)
        magikarp.apply('burn', 3)

        aggregate_failures do
          expect(magikarp.status_at(1)).to eq('paralyze')
          expect(magikarp.status_at(2)).to eq('freeze')
          expect(magikarp.status_at(3)).to eq(['paralyze', 'burn'])
          expect(magikarp.status_at(4)).to eq(['paralyze', 'burn'])
          expect(magikarp.status_at(5)).to eq('burn')
          expect(magikarp.status_at(6)).to eq(nil)
        end
      end
    end
  end
end
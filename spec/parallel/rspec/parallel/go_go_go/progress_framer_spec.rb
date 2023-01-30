# frozen_string_literal: true

RSpec.describe RSpec::Parallel::GoGoGo::ProgressFramer do
  let(:counter) { RSpec::Parallel::GoGoGo::ProgressCounter.new(10) }

  context "when no progress" do
    it "The number of executions and failures should be displayed." do
      expect(described_class.result(counter)).to eq "0 examples, 0 failures"
    end

    it "progress rate must be 0" do
      expect(described_class.rate(counter)).to eq "  0%"
    end
  end

  context "when in progress" do
    before do
      counter.passed
      counter.passed
      counter.passed
      counter.failed
      counter.failed
    end

    it "The number of executions and failures should be displayed." do
      expect(described_class.result(counter)).to eq "5 examples, 2 failures"
    end

    it "progress rate must be 50%" do
      expect(described_class.rate(counter)).to eq " 50%"
    end
  end

  context "when completed progress" do
    before do
      counter.passed
      counter.passed
      counter.passed
      counter.failed
      counter.failed
      counter.passed
      counter.passed
      counter.passed
      counter.failed
      counter.failed
    end

    it "The number of executions and failures should be displayed." do
      expect(described_class.result(counter)).to eq "10 examples, 4 failures"
    end

    it "progress rate must be 0" do
      expect(described_class.rate(counter)).to eq "100%"
    end
  end

  describe "bar" do
    let(:counter) { RSpec::Parallel::GoGoGo::ProgressCounter.new(100) }

    before do
      allow(RSpec::Core::Formatters::ConsoleCodes).to receive(:wrap) { |text, *| text }
    end

    # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
    it "The bar must be animated." do
      expect(described_class.bar(counter)).to eq "|     |"
      counter.passed
      expect(described_class.bar(counter)).to eq "|o    |"
      counter.passed
      expect(described_class.bar(counter)).to eq "|Go   |"
      counter.passed
      expect(described_class.bar(counter)).to eq "|oGo  |"
      counter.passed
      expect(described_class.bar(counter)).to eq "| oGo |"
      counter.passed
      expect(described_class.bar(counter)).to eq "|  oGo|"
      counter.passed
      expect(described_class.bar(counter)).to eq "|   oG|"
      counter.passed
      expect(described_class.bar(counter)).to eq "|    o|"
      counter.passed
      expect(described_class.bar(counter)).to eq "|     |"
      counter.passed
      expect(described_class.bar(counter)).to eq "|    o|"
      counter.passed
      expect(described_class.bar(counter)).to eq "|   oG|"
      counter.passed
      expect(described_class.bar(counter)).to eq "|  oGo|"
      counter.passed
      expect(described_class.bar(counter)).to eq "| oGo |"
      counter.passed
      expect(described_class.bar(counter)).to eq "|oGo  |"
      counter.passed
      expect(described_class.bar(counter)).to eq "|Go   |"
      counter.passed
      expect(described_class.bar(counter)).to eq "|o    |"
      counter.passed
      expect(described_class.bar(counter)).to eq "|     |"
    end
    # rubocop:enable RSpec/MultipleExpectations, RSpec/ExampleLength
  end
end

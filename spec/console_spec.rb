require 'spec_helper'

module Blackjack
  describe Console do
    let(:something) { 'something' }
    let(:question?) { 'question' }
    let(:answer) { 'yes' }

    let(:in_out) {
      io = StringIO.new
      io.stub(:gets).and_return(answer)
      io
    }
    let(:console) { Console.new(in_out) }

    context '.say' do
      it 'shows a message' do
        console.say something
        in_out.string.should == something
      end
    end

    context '.ask' do
      it 'asks a question' do
        console.ask question?
        in_out.string.should == question?
      end

      it 'waits for an answer' do
        in_out.should_receive(:gets)
        console.ask.should == answer
      end
    end
  end
end



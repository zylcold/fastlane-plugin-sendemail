describe Fastlane::Actions::SendemailAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The sendemail plugin is working!")

      Fastlane::Actions::SendemailAction.run(nil)
    end
  end
end

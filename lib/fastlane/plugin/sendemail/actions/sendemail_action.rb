require 'fastlane/action'
require_relative '../helper/sendemail_helper'

module Fastlane
  module Actions
    class SendemailAction < Action
      def self.run(params)
        system "echo #{params[:send_content]} | mail -s #{params[:subject]} #{params[:send_list]}"
      end

      def self.description
        "send a email"
      end

      def self.authors
        ["yunlongzhu"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "send a email"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :send_list,
                                  env_name: "SENDEMAIL_SEND_LIST",
                               description: "发信列表",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :subject,
                                  env_name: "SENDEMAIL_SEND_SUBJECT",
                               description: "发信主题",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :send_content,
                                  env_name: "SENDEMAIL_SEND_CONTENT",
                               description: "发信内容",
                                  optional: false,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end

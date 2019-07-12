require 'fastlane/action'
require_relative '../helper/sendemail_helper'
require 'rqrcode'
module Fastlane
  module Actions
    class SendemailAction < Action
      def self.run(params)
        msg = <<-EOF
<body style="margin: 10; padding: 10;">
　<table border="0" cellpadding="0" cellspacing="20">
　　<tr> 
　　　<td> 名称 </td>　　　<td> #{params[:send_app_name]} </td>
　　</tr>
   <tr> 
　　　<td> 版本 </td>　　　<td> #{params[:send_app_version]} </td>
　　</tr>
    <tr> 
　　　<td> 提交记录 </td>　　　<td> #{params[:send_app_commit]} </td>
　　</tr>
    <tr> 
　　　<td> 下载 </td>　　　<td> #{params[:send_app_url]} </td>
　　</tr>
　</table>
    <img src="#{getQRCode(params[:send_app_url])}" />
</body>
        EOF
        File.write("sketch.html", msg)
        puts "mail -s '#{params[:subject]}\nContent-Type: text/html' #{params[:send_list]} < sketch.html"
        File.delete( "sketch.html" ) if system "mail -s '#{params[:subject]}\nContent-Type: text/html' #{params[:send_list]} < sketch.html"
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
          FastlaneCore::ConfigItem.new(key: :send_list, env_name: "SENDEMAIL_SEND_LIST", description: "发信列表", optional: false, type: String),
          FastlaneCore::ConfigItem.new(key: :subject, env_name: "SENDEMAIL_SEND_SUBJECT", description: "发信主题", optional: true, type: String),
          FastlaneCore::ConfigItem.new(key: :send_app_name, env_name: "SENDEMAIL_SEND_APP_NAME", description: "App名称", optional: false, type: String),
          FastlaneCore::ConfigItem.new(key: :send_app_version, env_name: "SENDEMAIL_SEND_APP_VERSION", description: "App版本", optional: false, type: String),
          FastlaneCore::ConfigItem.new(key: :send_app_commit, env_name: "SENDEMAIL_SEND_APP_COMMIIT", description: "App提交记录", optional: false, type: String),
          FastlaneCore::ConfigItem.new(key: :send_app_url, env_name: "SENDEMAIL_SEND_APP_URL", description: "AppURL", optional: false, type: String)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac, :android].include?(platform)
      end
    end
  end
end

def getQRCode(url) 
  qrcode = RQRCode::QRCode.new(url)
  png = qrcode.as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: 'white',
      color: 'black',
      size: 200,
      border_modules: 4,
      module_px_size: 6,
      file: nil
  )
  return png.to_data_url
end
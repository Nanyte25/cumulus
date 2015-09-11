require "conf/Configuration"

require "aws-sdk"

module Cumulus
  module SecurityGroups
    class << self
      @@client = Aws::EC2::Client.new(region: Configuration.instance.region)

      def id_security_groups
        @id_security_groups ||= Hash[security_groups.map { |a| [a.group_id, a] }]
      end

      def name_security_groups
        @name_security_groups ||= Hash[security_groups.map { |a| [a.group_name, a] }]
      end

      def security_groups
        @security_groups ||= @@client.describe_security_groups.security_groups
      end

    end
  end
end
require_dependency 'issue'

module ForcedNotificationToOwner
  module Patches
    module IssuePatch
      def self.included(base)
        base.send :include, InstanceMethods
        base.class_eval do
          alias_method_chain :visible?, :forced_owner
        end
      end

      module InstanceMethods
        def visible_with_forced_owner?(usr=nil)
          return true if self.author == (usr || User.current)
          visible_without_forced_owner?
        end
      end
    end
  end
end

Issue.send :include, ForcedNotificationToOwner::Patches::IssuePatch

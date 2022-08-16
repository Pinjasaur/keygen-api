# frozen_string_literal: true

module Groups
  class GroupOwnerPolicy < ApplicationPolicy
    authorize :group

    def index?
      verify_permissions!('group.owners.read')

      case bearer
      in role: { name: 'admin' | 'developer' | 'sales_agent' | 'support_agent' | 'read_only' | 'product' }
        allow!
      in role: { name: 'user' } if group.id == bearer.group_id || group.id.in?(bearer.group_ids)
        allow!
      in role: { name: 'license' } if group.id == bearer.group_id
        allow!
      else
        deny!
      end
    end

    def show?
      verify_permissions!('group.owners.read')

      case bearer
      in role: { name: 'admin' | 'developer' | 'sales_agent' | 'support_agent' | 'read_only' | 'product' }
        allow!
      in role: { name: 'user' } if group.id == bearer.group_id || group.id.in?(bearer.group_ids)
        allow!
      in role: { name: 'license' } if group.id == bearer.group_id
        allow!
      else
        deny!
      end
    end

    def attach?
      verify_permissions!('group.owners.attach')

      case bearer
      in role: { name: 'admin' | 'developer' | 'product' }
        allow!
      else
        deny!
      end
    end

    def detach?
      verify_permissions!('group.owners.detach')

      case bearer
      in role: { name: 'admin' | 'developer' | 'product' }
        allow!
      else
        deny!
      end
    end
  end
end
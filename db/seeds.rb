PublicActivity.enabled = false
admin_user_1 = User.new email: 'rakesh@verma.com', password: 'password', is_admin: true
admin_user_1.save validate: false
site_role1 = SiteRole.create name: 'Tenant', site_accesses_attributes: SiteAccess::RESOURCES.map {|k,v| {access_for: k, read: true, write: true}}
site_role2 = SiteRole.create name: 'Site Admin', site_accesses_attributes: [{access_for: 'sites', read: true, write: true}, {access_for: 'vouchers', read: true, write: true}, {access_for: 'templates', read: true, write: true}, {access_for: 'reports', read: true, write: true}]
site_role3 = SiteRole.create name: 'Guest Ambassador', site_accesses_attributes: [{access_for: 'analytics', read: true, write: false}]


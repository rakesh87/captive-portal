desc "Create tenants users"
task :create_tenants, [:number_integer] => :environment do |t, args|
  PublicActivity.enabled = false
  tennat_count = Tenant.all.count + 1
  number_of_tenant_to_create = args[:number_integer].to_i + tennat_count
  super_user = User.where(is_admin: true).first
  site_roles = SiteRole.all
  while(tennat_count < number_of_tenant_to_create) do
    tenant_name = "tenant_#{tennat_count}"
    tenant_admin_user_email = "#{tenant_name}@mailinator.com"
    tenant = Tenant.create(name: tenant_name)
    puts "************* Tenat created with name : #{tenant_name} ***************"
    user = User.new(email: tenant_admin_user_email, password: tenant_name, tenant: tenant, site_role: site_roles.first)
    user.save!
    puts "************* User is created for Tennat name : #{tenant_name} with email : #{user.email} Id: #{user.id}***************"
    user.available_roles.create({site_role: site_roles.second})
    user.available_roles.create({site_role: site_roles.third})
    puts "************* User is created for Tennat name : #{tenant_name} with email : #{user.email} Id: #{user.id} and available_roles count : #{user.available_roles.count} ***************"
    tennat_count += 1
  end
end
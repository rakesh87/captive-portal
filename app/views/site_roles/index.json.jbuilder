json.array!(@site_roles) do |site_role|
  json.extract! site_role, :id, :name
  json.url site_role_url(site_role, format: :json)
end

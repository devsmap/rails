################################################################################
# Config
################################################################################
PASSWORD_EMPLOYEE = "B@ta74"
SPECIAL_KEY_TABLE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_'

################################################################################
# Create Employee
################################################################################
employess = [{name: "Daniel Regis", email: "daniel@devsmap.com", password:"B@ta74"}] 
employess.each do |employee|
  unless Employee.find_by_email(employee[:email]).present?
    Employee.create(name: employee[:name], 
      email: employee[:email],
      role: :master,
      password: employee[:password],
      password_confirmation: employee[:password])  
  end
end

################################################################################
# Create Languages
################################################################################
categories = [
  {id:1,  name:"React",             parent_id: nil}, 
  {id:2,  name:"Python",            parent_id: nil},
  {id:3,  name:"Java",              parent_id: nil}, 
  {id:4,  name:"C#",                parent_id: nil},
  {id:5,  name:"PHP",               parent_id: nil}, 
  {id:6,  name:"Ruby on Rails",     parent_id: nil},
  {id:7,  name:"UX/UI",             parent_id: nil}, 
  {id:8,  name:"QA",                parent_id: nil},
  {id:9,  name:"Quality Assurance", parent_id: 8}, 
  {id:10, name:"DevOps",            parent_id: nil},
]
categories.each do |category|
  unless Category.find_by_id(category[:id]).present?
    parent_id = category[:parent_id].present? ? category[:parent_id] : nil
    Category.create(id: category[:id], 
                    name: category[:name], 
                    parent_id: parent_id,
                    is_active: true
                    )    
  end
end

################################################################################
# Create Countries, States and Cities
# Languages: https://www.fincher.org/Utilities/CountryLanguageList.shtml
# Timezones: https://gist.github.com/eikes/5a64b661022c756bd6522ed94770e2a6
################################################################################
# Country.unscope(:where).destroy_all
directory_countries_enable = "/app/db/seed/countries"
json_enabled_countries     = JSON.parse(open("/app/db/seed/countries.json").read)
json_enabled_countries.each do |enabled_country|

  unless Country.find_by_id(enabled_country["id"]).present?

    directory_country = "#{directory_countries_enable}/#{enabled_country["name"].downcase}"
    country_file      = "#{directory_country}/country.json"
    states_file       = "#{directory_country}/states.json"
    cities_file       = "#{directory_country}/cities.json"
  
    if File.file?(country_file) && File.file?(states_file) && File.file?(cities_file)
      
      ##########################################################################
      # Create Countries
      ##########################################################################     
      country_json = JSON.parse(open(country_file).read)
      country_json.each do |country|
        uule_name = country["name"]
        encode_uule = "#{SPECIAL_KEY_TABLE[uule_name.force_encoding("US-ASCII").size]}#{Base64.strict_encode64(uule_name)}"
        encode_uule = encode_uule.gsub(/[=]/, '')

        Country.create(id: country["id"],
          name: country["name"], 
          region: country["region"], 
          subregion: country["subregion"], 
          latitude: country["latitude"], 
          longitude: country["longitude"], 
          emoji: country["emoji"], 
          google_uule: "w+CAIQICI#{encode_uule}", 
          google_hl: enabled_country["language"], 
          google_gl: country["iso2"].downcase,
          time_zone: enabled_country["time_zone"],
          is_active: true)
      end

      ##########################################################################
      # Create States
      ##########################################################################          
      state_json = JSON.parse(open(states_file).read)
      state_json.each do |state|
        unless state["latitude"].nil? || state["longitude"].nil? 
          uule_name = state["name"] + ', ' + enabled_country["name"]
          encode_uule = "#{SPECIAL_KEY_TABLE[uule_name.force_encoding("US-ASCII").size]}#{Base64.strict_encode64(uule_name)}"
          encode_uule = encode_uule.gsub(/[=]/, '')
          State.create(id: state["id"],
                      country_id: state["country_id"],
                      name: state["name"], 
                      state_code: state["state_code"], 
                      latitude: state["latitude"], 
                      longitude: state["longitude"],
                      google_uule: "w+CAIQICI#{encode_uule}", 
                      is_active: true)
        end
      end

      ##########################################################################
      # Create Cities
      ##########################################################################        
      city_json = JSON.parse(open(cities_file).read)
      city_json.each do |city|
        unless city["latitude"].nil? || city["longitude"].nil?
          City.create(id: city["id"],
                      state_id: city["state_id"],
                      name: city["name"], 
                      latitude: city["latitude"], 
                      longitude: city["longitude"],
                      is_active: true)
        end
      end

    end
  end
end

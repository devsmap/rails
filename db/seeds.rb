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
                    is_active: true)    
  end
end

################################################################################
# Create Countries
################################################################################
countries = JSON.parse(open("/app/db/seed/countries.json").read)
if countries.count != Country.count
  countries.each do |country|
    unless country["latitude"].nil? || country["longitude"].nil? 
      unless Country.find_by_id(country["id"]).present?
        uule_name   = country["name"]
        encode_uule = "#{SPECIAL_KEY_TABLE[uule_name.force_encoding("US-ASCII").size]}#{Base64.strict_encode64(uule_name)}"
        encode_uule = encode_uule.gsub(/[=]/, '')
        
        Country.create!(id: country["id"],
                        name: country["name"], 
                        region: country["region"], 
                        subregion: country["subregion"], 
                        latitude: country["latitude"], 
                        longitude: country["longitude"], 
                        emoji: country["emoji"], 
                        google_uule: "w+CAIQICI#{encode_uule}", 
                        google_gl: country["iso2"].downcase,
                        is_active: false,
                        is_collected: false)
      end
    end
  end
end 

# update states set
#     is_active = true,
#  	is_collected  = true
# from (values
#     (233, 'Kano State'), -- United States
#     (233, 'Lagos'), -- United States
#     (233, 'Kaduna State'), -- United States
#     (233, 'Katsina State'), -- United States
#     (233, 'Oyo State'), -- United States
#     (233, 'Bauchi State'), -- United States
#     (233, 'Jigawa State'), -- United States
#     (233, 'Benue State'), -- United States
#     (233, 'Anambra State'), -- United States
#     (233, 'Borno State') -- United States                         
# ) as aux(country_id, name) 
# where aux.name = states.name and aux.country_id = states.country_id;

# ##############################################################################
# # Create States
# ##############################################################################
states = JSON.parse(open("/app/db/seed/states.json").read)
if states.count != State.count
  states.each do |state|
    unless state["latitude"].nil? || state["longitude"].nil? 
      unless State.find_by_id(state["id"]).present?

        country = Country.find_by_id(state["country_id"])

        uule_name = state["name"] + ', ' + country.name
        encode_uule = "#{SPECIAL_KEY_TABLE[uule_name.force_encoding("US-ASCII").size]}#{Base64.strict_encode64(uule_name)}"
        encode_uule = encode_uule.gsub(/[=]/, '')
        State.create!(id: state["id"],
                      country_id: state["country_id"],
                      name: state["name"], 
                      state_code: state["state_code"], 
                      latitude: state["latitude"], 
                      longitude: state["longitude"],
                      google_uule: "w+CAIQICI#{encode_uule}", 
                      is_active: false,
                      is_collected: false)

      end
    end               
  end
end

################################################################################
# Create Cities
################################################################################
cities = JSON.parse(open("/app/db/seed/cities.json").read)
cities.each do |city|
  unless city["latitude"].nil? || city["longitude"].nil? 
    unless City.find_by_id(city["id"]).present?
      if State.find_by_id(city["state_id"]).present?
        City.create!(id: city["id"],
                    state_id: city["state_id"],
                    name: city["name"], 
                    latitude: city["latitude"], 
                    longitude: city["longitude"],
                    is_active: true)
      end                   
    end
  end
end

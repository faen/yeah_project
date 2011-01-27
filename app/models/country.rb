# == Schema Information
# Schema version: 20110119171126
#
# Table name: countries
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  fips104              :string(2)       not null
#  iso2                 :string(2)       not null
#  iso3                 :string(3)       not null
#  ison                 :string(4)       not null
#  internet             :string(2)       not null
#  capital              :string(25)
#  map_reference        :string(50)
#  nationality_singular :string(35)
#  nationaiity_plural   :string(35)
#  currency             :string(30)
#  currency_code        :string(3)
#  population           :integer
#  title                :string(50)
#  comment              :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

# files downloaded from http://www.geobytes.com/GeoWorldMap.zip
require "csv"
class Country < ActiveRecord::Base
  has_many :regions
  
  validates :name, :presence => true
  validates :iso2, :presence => true
  validates :iso3, :presence => true
  validates :ison, :presence => true, :numericality => true
  
  def self.import
    self.destroy_all
    Region.destroy_all
    import_countries_and_regions
  end
  
  private 
    def self.import_countries_and_regions
      c_reader = CSV.open(countries_file, "r", :col_sep => ",")
      c_head = c_reader.shift
      r_reader = CSV.open(regions_file, "r", :col_sep => ",")
      r_head = r_reader.shift
      r_reader = r_reader.read
      c_reader.each do |row|
        c_id = row[c_head.index("CountryId")]
        c = Country.new :name => row[c_head.index("Country")],
                        :fips104 => row[c_head.index("FIPS104")],
                        :iso2 => row[c_head.index("ISO2")],
                        :iso3 => row[c_head.index("ISO3")],
                        :ison => row[c_head.index("ISON")],
                        :internet => row[c_head.index("Internet")]
        regions = r_reader.map {|r| r if r[r_head.index("CountryID")] == c_id}.compact
        if( c.save )
          regions.each do |region|
            c.regions.build :name => region[r_head.index("Region")],
                            :code => region[r_head.index("Code")],
                            :adm1code => region[r_head.index("ADM1Code")],
                            :country_ison => row[c_head.index("ISON")]
            c.save
          end
        else
          puts "did not save country for row: #{row}"
          puts "thus not saving regions: #{regions}"
        end
        r_reader = r_reader - regions     
      end
    end
    
    def self.static_data_path
      "#{RAILS_ROOT}/db/data_sources/geo_world_map/"
    end
    
    def self.countries_file
      static_data_path + "countries.csv"
    end
    
    def self.regions_file
      static_data_path + "regions.csv"
    end
end

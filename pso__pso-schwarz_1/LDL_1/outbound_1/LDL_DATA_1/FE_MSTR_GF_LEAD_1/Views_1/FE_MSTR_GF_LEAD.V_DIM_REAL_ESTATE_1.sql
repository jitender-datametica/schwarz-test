CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_real_estate_1 (real_estate_sid
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
real_estate_nr
OPTIONS(description='The number which uniquely identifies a real estate object within a country_1 organization.'),
real_estate_name OPTIONS(description='The name for the real estate object.'), real_estate_type_cd
OPTIONS(description='The code identifying the subtype discriminator for real estate objects.'), real_estate_type_descr
OPTIONS(description='A textual description for the subtype discriminator for real estate objects. (Description in group language, i.e. in German)'),
real_estate_status_cd
OPTIONS(description='The code identifying the lifecycle status_1 for real estate objects. (This is the business lifecycle, so it might differ from the status_1 code shown in the source system.)'),
real_estate_status_descr
OPTIONS(description='A textual description for the lifecycle status_1 for real estate objects. (Description in group language, i.e. in German)'),
int_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the internal organization, which is located in this real estate object.'),
curr_int_org_nr
OPTIONS(description='The current number of the internal organization, which is located in this real estate object.. (This number may change over time)'),
int_org_name OPTIONS(description='The name of the internal organization, which is located in this real estate object.'),
int_org_type_cd
OPTIONS(description='The code identifying the discriminators for the internal organization, which is located in this real estate object.'),
int_org_type_descr
OPTIONS(description='A textual description for the discriminators for internal organizations. (Description in group language, i.e. in German)'),
ownership_type_cd
OPTIONS(description='The code identifying the ownership type of a real estate object, i.e. if it has been bought or if it is rented.'),
ownership_type_descr
OPTIONS(description='A textual description for the ownership type of a real estate object, (Description in group language, i.e. in German)'),
ownership_ratio_type_cd
OPTIONS(description='The code identifying the ownership ratio of a real estate object, i.e. if it is fully owned or partly owned.'),
ownership_ratio_type_descr
OPTIONS(description='A textual description for the ownership ratio of a real estate object, (Description in group language, i.e. in German)'),
own_acquisition_fg
OPTIONS(description='An indicator showing, if the real estate object was acquired by the Schwarz Group without involvement of a third party.'),
real_estate_usg_type_cd
OPTIONS(description='The code for the way, how a real estate object is used. An object may be used by the organization or by a third party.'),
real_estate_usg_type_descr
OPTIONS(description='A textual description for the way, how a real estate object is used. An object may be used by the organization or by a third party. (Description in group language, i.e. in German)'),
replacement_real_estate_sid
OPTIONS(description='The unique identifier (surrogate key) of the real estate object which replaces this object.'),
replacement_real_estate_nr
OPTIONS(description='The number which uniquely identifies the real estate object which replaces this object.'),
replacement_real_estate_name OPTIONS(description='The name for the real estate object which replaces this object.'),
real_estate_replacement_type_cd
OPTIONS(description='The code identifying the way, how a real estate object can replace another object. There are two types of replacments: Relocations and demolition and a new construction.'),
real_estate_replacement_type_descr
OPTIONS(description='A textual description for the way, how a real estate object can replace another object. (Description in group language, i.e. in German)'),
wh_building_type_cd OPTIONS(description='The code for the subtype discriminator for warehouse building.'),
wh_building_type_descr
OPTIONS(description='A textual description for the subtype discriminator for warehouse buildings. (Description in group language, i.e. in German)'),
wh_purpose_cd OPTIONS(description='The code identifying the purpose of a warehouse.'), wh_purpose_descr
OPTIONS(description='A textual description for the purpose of a warehouse. (Description in group language, i.e. in German)'),
shared_usg_fg OPTIONS(description='An indicator showing, if the warehouse is used by multiple parties.'), iso_country_cd
OPTIONS(description='The code according to ISO 3166 identifying the country_1, in which the real estate object is located,'),
country_name OPTIONS(description='The name of the country_1, in which the real estate object is located,'), city_name
OPTIONS(description='The name of the city, in which the real estate object is located,'), district_name
OPTIONS(description='The name of the district, in which the real estate object is located,'), zip
OPTIONS(description='The zip code for the address_1 of the real estate object.'), street_name
OPTIONS(description='The name of the street, in which the real estate object is located. (This includes names of squares and similar locations.)'),
house_nr OPTIONS(description='The house number for the real estate object.'), lon
OPTIONS(description='The longitude component of the geographical coordinates of the address_1 of the real estate object.'),
lat
OPTIONS(description='The latitude component of the geographical coordinates of the address_1 of the real estate object.'),
po_box_nr OPTIONS(description='The number of a post office box, which is used for this real estate object.'), phone_nr
OPTIONS(description='The telephone number for that real estate object.'), fax_nr
OPTIONS(description='The fax number for that real estate object.'), email_addr_txt
OPTIONS(description='An email address_1 for that real estate object.'), reporting_country_cd
OPTIONS(description='The code which identifies the reporting country_1 in which the real estate object is located.'),
reporting_country_name
OPTIONS(description='The name the reporting country. (i.e. a country_1 definition which is different from a geographical country_1) The name in in group lanuage, i.e. in German. (Name in group language, i.e. in German)'),
sales_area_meas
OPTIONS(description='The space which can be used for sales_1, in the unit_1 indicated by the unit_1 of measure code (e.g. m2).'),
storage_area_meas
OPTIONS(description='The space which can be used for storing goods, in the unit_1 indicated by the unit_1 of measure code (e.g. m2).'),
total_sublet_area_meas
OPTIONS(description='The total space which can be sublet, in the unit_1 indicated by the unit_1 of measure code (e.g. m2).'),
rented_sublet_area_meas
OPTIONS(description='The space which is currently rented out, in the unit_1 indicated by the unit_1 of measure code.'),
uom_cd OPTIONS(description='The code identifying the unit_1 of measure for the sales_1 area.'), sales_area_m2_meas
OPTIONS(description='The space in square meters which can be used for sales.'), storage_area_m2_meas
OPTIONS(description='The space in square meters, which can be used for storing goods.'), total_sublet_area_m2_meas
OPTIONS(description='The total space in square meters, which can be sublet.'), rented_sublet_area_m2_meas
OPTIONS(description='The space in square meters, which is currently rented out.'), total_parking_space_cnt
OPTIONS(description='The total number of parking spaces that are assigned to this building.'), own_parking_space_cnt
OPTIONS(description='The number of parking spaces that are assigned to this building and which are owned by the Schwarz Group.'),
underground_parking_space_cnt
OPTIONS(description='The total number of parking spaces in an underground parking garage that are assigned to this building.'),
rental_cost_val
OPTIONS(description='The rental cost for this real estate object per year. (in the currency indicated by the currency code)'),
rental_income_val
OPTIONS(description='The rental income for this real estate object per year. (in the currency indicated by the currency code)'),
curr_cd OPTIONS(description='The code identifying the currency according to ISO-4217.'), rental_cost_eur_val
OPTIONS(description='The rental cost in Euro for this real estate object per year.'), rental_income_eur_val
OPTIONS(description='The rental income in Euro for this real estate object per year.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `REAL ESTATE IS PROPERTY IN THE FORM OF LAND_1 OR BUILDINGS.`) AS SELECT *
FROM ldl_data_core_dim.t_dim_real_estate_1 AS MAIN
WHERE dwh_valid_fg;
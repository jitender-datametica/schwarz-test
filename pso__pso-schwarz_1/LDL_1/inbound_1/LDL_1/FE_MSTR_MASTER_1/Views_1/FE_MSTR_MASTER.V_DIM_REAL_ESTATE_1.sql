CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_DIM_REAL_ESTATE_1 (
real_estate_sid COMMENT 'The unique identifier (surrogate key) for the real estate object.'
,dwh_valid_from_tmsp COMMENT 'The point in time when this record became valid.'
,dwh_valid_to_tmsp COMMENT 'The point in time when this record was no longer valid.'
,dwh_valid_fg COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'
,real_estate_nr COMMENT 'The number which uniquely identifies a real estate object within a country_1 organization.'
,real_estate_name COMMENT 'The name for the real estate object.'
,real_estate_type_cd COMMENT 'The code identifying the subtype discriminator for real estate objects.'
,real_estate_type_descr COMMENT 'A textual description for the subtype discriminator for real estate objects. (Description in group language, i.e. in German)'
,real_estate_status_cd COMMENT 'The code identifying the lifecycle status_1 for real estate objects. (This is the business lifecycle, so it might differ from the status_1 code shown in the source system.)'
,real_estate_status_descr COMMENT 'A textual description for the lifecycle status_1 for real estate objects. (Description in group language, i.e. in German)'
,int_org_sid COMMENT 'The unique identifier (surrogate key) for the internal organization, which is located in this real estate object.'
,curr_int_org_nr COMMENT 'The current number of the internal organization, which is located in this real estate object.. (This number may change over time)'
,int_org_name COMMENT 'The name of the internal organization, which is located in this real estate object.'
,int_org_type_cd COMMENT 'The code identifying the discriminators for the internal organization, which is located in this real estate object.'
,int_org_type_descr COMMENT 'A textual description for the discriminators for internal organizations. (Description in group language, i.e. in German)'
,ownership_type_cd COMMENT 'The code identifying the ownership type of a real estate object, i.e. if it has been bought or if it is rented.'
,ownership_type_descr COMMENT 'A textual description for the ownership type of a real estate object, (Description in group language, i.e. in German)'
,ownership_ratio_type_cd COMMENT 'The code identifying the ownership ratio of a real estate object, i.e. if it is fully owned or partly owned.'
,ownership_ratio_type_descr COMMENT 'A textual description for the ownership ratio of a real estate object, (Description in group language, i.e. in German)'
,own_acquisition_fg COMMENT 'An indicator showing, if the real estate object was acquired by the Schwarz Group without involvement of a third party.'
,real_estate_usg_type_cd COMMENT 'The code for the way, how a real estate object is used. An object may be used by the organization or by a third party.'
,real_estate_usg_type_descr COMMENT 'A textual description for the way, how a real estate object is used. An object may be used by the organization or by a third party. (Description in group language, i.e. in German)'
,replacement_real_estate_sid COMMENT 'The unique identifier (surrogate key) of the real estate object which replaces this object.'
,replacement_real_estate_nr COMMENT 'The number which uniquely identifies the real estate object which replaces this object.'
,replacement_real_estate_name COMMENT 'The name for the real estate object which replaces this object.'
,real_estate_replacement_type_cd COMMENT 'The code identifying the way, how a real estate object can replace another object. There are two types of replacments: Relocations and demolition and a new construction.'
,real_estate_replacement_type_descr COMMENT 'A textual description for the way, how a real estate object can replace another object. (Description in group language, i.e. in German)'
,wh_building_type_cd COMMENT 'The code for the subtype discriminator for warehouse building.'
,wh_building_type_descr COMMENT 'A textual description for the subtype discriminator for warehouse buildings. (Description in group language, i.e. in German)'
,wh_purpose_cd COMMENT 'The code identifying the purpose of a warehouse.'
,wh_purpose_descr COMMENT 'A textual description for the purpose of a warehouse. (Description in group language, i.e. in German)'
,shared_usg_fg COMMENT 'An indicator showing, if the warehouse is used by multiple parties.'
,iso_country_cd COMMENT 'The code according to ISO 3166 identifying the country_1, in which the real estate object is located,'
,country_name COMMENT 'The name of the country_1, in which the real estate object is located,'
,city_name COMMENT 'The name of the city, in which the real estate object is located,'
,district_name COMMENT 'The name of the district, in which the real estate object is located,'
,zip COMMENT 'The zip code for the address_1 of the real estate object.'
,street_name COMMENT 'The name of the street, in which the real estate object is located. (This includes names of squares and similar locations.)'
,house_nr COMMENT 'The house number for the real estate object.'
,lon COMMENT 'The longitude component of the geographical coordinates of the address_1 of the real estate object.'
,lat COMMENT 'The latitude component of the geographical coordinates of the address_1 of the real estate object.'
,po_box_nr COMMENT 'The number of a post office box, which is used for this real estate object.'
,phone_nr COMMENT 'The telephone number for that real estate object.'
,fax_nr COMMENT 'The fax number for that real estate object.'
,email_addr_txt COMMENT 'An email address_1 for that real estate object.'
,reporting_country_cd COMMENT 'The code which identifies the reporting country_1 in which the real estate object is located.'
,reporting_country_name COMMENT 'The name the reporting country. (i.e. a country_1 definition which is different from a geographical country_1) The name in in group lanuage, i.e. in German. (Name in group language, i.e. in German)'
,sales_area_meas COMMENT 'The space which can be used for sales_1, in the unit_1 indicated by the unit_1 of measure code (e.g. m2).'
,storage_area_meas COMMENT 'The space which can be used for storing goods, in the unit_1 indicated by the unit_1 of measure code (e.g. m2).'
,total_sublet_area_meas COMMENT 'The total space which can be sublet, in the unit_1 indicated by the unit_1 of measure code (e.g. m2).'
,rented_sublet_area_meas COMMENT 'The space which is currently rented out, in the unit_1 indicated by the unit_1 of measure code.'
,uom_cd COMMENT 'The code identifying the unit_1 of measure for the sales_1 area.'
,sales_area_m2_meas COMMENT 'The space in square meters which can be used for sales.'
,storage_area_m2_meas COMMENT 'The space in square meters, which can be used for storing goods.'
,total_sublet_area_m2_meas COMMENT 'The total space in square meters, which can be sublet.'
,rented_sublet_area_m2_meas COMMENT 'The space in square meters, which is currently rented out.'
,total_parking_space_cnt COMMENT 'The total number of parking spaces that are assigned to this building.'
,own_parking_space_cnt COMMENT 'The number of parking spaces that are assigned to this building and which are owned by the Schwarz Group.'
,underground_parking_space_cnt COMMENT 'The total number of parking spaces in an underground parking garage that are assigned to this building.'
,rental_cost_val COMMENT 'The rental cost for this real estate object per year. (in the currency indicated by the currency code)'
,rental_income_val COMMENT 'The rental income for this real estate object per year. (in the currency indicated by the currency code)'
,curr_cd COMMENT 'The code identifying the currency according to ISO-4217.'
,rental_cost_eur_val COMMENT 'The rental cost in Euro for this real estate object per year.'
,rental_income_eur_val COMMENT 'The rental income in Euro for this real estate object per year.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'Real Estate is property in the form of land_1 or buildings.' AS SELECT
main.real_estate_sid AS real_estate_sid
,main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,main.real_estate_nr AS real_estate_nr
,main.real_estate_name AS real_estate_name
,main.real_estate_type_cd AS real_estate_type_cd
,main.real_estate_type_descr AS real_estate_type_descr
,main.real_estate_status_cd AS real_estate_status_cd
,main.real_estate_status_descr AS real_estate_status_descr
,main.int_org_sid AS int_org_sid
,main.curr_int_org_nr AS curr_int_org_nr
,main.int_org_name AS int_org_name
,main.int_org_type_cd AS int_org_type_cd
,main.int_org_type_descr AS int_org_type_descr
,main.ownership_type_cd AS ownership_type_cd
,main.ownership_type_descr AS ownership_type_descr
,main.ownership_ratio_type_cd AS ownership_ratio_type_cd
,main.ownership_ratio_type_descr AS ownership_ratio_type_descr
,main.own_acquisition_fg AS own_acquisition_fg
,main.real_estate_usg_type_cd AS real_estate_usg_type_cd
,main.real_estate_usg_type_descr AS real_estate_usg_type_descr
,main.replacement_real_estate_sid AS replacement_real_estate_sid
,main.replacement_real_estate_nr AS replacement_real_estate_nr
,main.replacement_real_estate_name AS replacement_real_estate_name
,main.real_estate_replacement_type_cd AS real_estate_replacement_type_cd
,main.real_estate_replacement_type_descr AS real_estate_replacement_type_descr
,main.wh_building_type_cd AS wh_building_type_cd
,main.wh_building_type_descr AS wh_building_type_descr
,main.wh_purpose_cd AS wh_purpose_cd
,main.wh_purpose_descr AS wh_purpose_descr
,main.shared_usg_fg AS shared_usg_fg
,main.iso_country_cd AS iso_country_cd
,main.country_name AS country_name
,main.city_name AS city_name
,main.district_name AS district_name
,main.zip AS zip
,main.street_name AS street_name
,main.house_nr AS house_nr
,main.lon AS lon
,main.lat AS lat
,main.po_box_nr AS po_box_nr
,main.phone_nr AS phone_nr
,main.fax_nr AS fax_nr
,main.email_addr_txt AS email_addr_txt
,main.reporting_country_cd AS reporting_country_cd
,main.reporting_country_name AS reporting_country_name
,main.sales_area_meas AS sales_area_meas
,main.storage_area_meas AS storage_area_meas
,main.total_sublet_area_meas AS total_sublet_area_meas
,main.rented_sublet_area_meas AS rented_sublet_area_meas
,main.uom_cd AS uom_cd
,main.sales_area_m2_meas AS sales_area_m2_meas
,main.storage_area_m2_meas AS storage_area_m2_meas
,main.total_sublet_area_m2_meas AS total_sublet_area_m2_meas
,main.rented_sublet_area_m2_meas AS rented_sublet_area_m2_meas
,main.total_parking_space_cnt AS total_parking_space_cnt
,main.own_parking_space_cnt AS own_parking_space_cnt
,main.underground_parking_space_cnt AS underground_parking_space_cnt
,main.rental_cost_val AS rental_cost_val
,main.rental_income_val AS rental_income_val
,main.curr_cd AS curr_cd
,main.rental_cost_eur_val AS rental_cost_eur_val
,main.rental_income_eur_val AS rental_income_eur_val
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_REAL_ESTATE_1 main 
WHERE main.dwh_valid_fg = TRUE;
CREATE OR REPLACE VIEW fe_mstr_master.v_dim_country_group_organization_1 (country_grp_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the organizational unit_1 which oversees the business in a group of countries.'),
dwh_valid_from_tmsp OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
country_grp_org_nr
OPTIONS(description='The number which identifies the organizational unit_1 which oversees the business in a group of countries.'),
country_grp_org_name
OPTIONS(description='The name for the organizational unit_1 which oversees the business in a group of countries.'),
int_org_status_cd OPTIONS(description='The code for the lifecycle status_1 of an internal organization.'),
int_org_status_descr
OPTIONS(description='A textual description for the lifecycle status_1 of an internal organization in group language, i.e. in German.'),
iso_country_cd
OPTIONS(description='The code according to ISO 3166 identifying the country_1, in which the head office for the country_1 group organization is located,'),
country_name
OPTIONS(description='The name of the country_1, in which the head office for the country_1 group organization is located,'),
city_name
OPTIONS(description='The name of the city where the head office for the country_1 group organization is located.'),
district_name
OPTIONS(description='The name of the district, in which the head office for the country_1 group organization is located,'),
zip OPTIONS(description='The postal code of the address_1 of the head office for the country_1 group organization.'),
street_name
OPTIONS(description='The name of the street where the head office for the country_1 group organization is located.'),
house_nr
OPTIONS(description='The number of the building within the street where the head office for the country_1 group organization is located.'),
lon OPTIONS(description='The geographical longitude of the head office for the country_1 group organization.'), lat
OPTIONS(description='The geographical latitude of the head office for the country_1 group organization.'),
country_grp_org_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee_1 who is responsible for this group of countries.'),
country_grp_org_mgr_emp_nr
OPTIONS(description='The employee_1 number of the manager who is responsible for this group of countries.'),
country_grp_org_mgr_name OPTIONS(description='The name of the manager who is responsible for this group of countries.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `AN ORGANIZATIONAL UNIT_1 WHICH OVERSEES THE BUSINESS IN A GROUP OF COUNTRIES. (THE DEFINITION OF A COUNTRY_1 IN THAT CONTEXT DOES NOT NECESSARILY MATCH EXACT GEOGRAPHICAL COUNTRY_1 BORDERS.)`)
AS SELECT country_grp_org_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 country_grp_org_nr,
 country_grp_org_name,
 int_org_status_cd,
 int_org_status_descr,
 iso_country_cd,
 country_name,
 city_name,
 district_name,
 zip,
 street_name,
 house_nr,
 lon,
 lat,
 country_grp_org_mgr_emp_sid,
 country_grp_org_mgr_emp_nr,
 country_grp_org_mgr_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_core_dim.t_dim_internal_organization_1 AS MAIN
WHERE dwh_valid_fg
 AND (int_org_type_cd = 'COUNTRY_GRP' OR int_org_sid = - 1);
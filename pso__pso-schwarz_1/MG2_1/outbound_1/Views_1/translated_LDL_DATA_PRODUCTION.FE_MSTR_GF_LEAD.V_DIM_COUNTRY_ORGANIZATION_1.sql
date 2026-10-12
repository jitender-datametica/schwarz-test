CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_dim_country_organization_1 (country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
country_org_cd
OPTIONS(description='The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)'),
country_org_nr OPTIONS(description='The number which identifies the country_1 organization.'), country_org_name
OPTIONS(description='The name for the country_1 organization.'), legal_name
OPTIONS(description='The official name of the company which acts as the country_1 organization, as shown in the company register.'),
int_org_status_cd OPTIONS(description='The code for the lifecycle status_1 of an internal organization.'),
int_org_status_descr
OPTIONS(description='A textual description for the lifecycle status_1 of an internal organization in group language, i.e. in German.'),
iso_country_cd
OPTIONS(description='The code according to ISO 3166 identifying the country_1, in which the head office for the country_1 organization is located,'),
country_name
OPTIONS(description='The name of the country_1, in which the head office for the country_1 organization is located,'),
city_name OPTIONS(description='The name of the city where the head office for the country_1 organization is located.'),
district_name
OPTIONS(description='The name of the district, in which the head office for the country_1 organization is located,'), zip
OPTIONS(description='The postal code of the address_1 of the head office for the country_1 organization.'), street_name
OPTIONS(description='The name of the street where the head office for the country_1 organization is located.'), house_nr
OPTIONS(description='The number of the building within the street where the head office for the country_1 organization is located.'),
lon OPTIONS(description='The geographical longitude of the head office for the country_1 organization.'), lat
OPTIONS(description='The geographical latitude of the head office for the country_1 organization.'),
country_org_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee_1 who is responsible for the country_1 organization.'),
country_org_mgr_emp_nr
OPTIONS(description='The employee_1 number of the manager who is responsible for the country_1 organization.'),
country_org_mgr_name OPTIONS(description='The name of the manager who is responsible for the country_1 organization.'),
country_grp_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the related organizational unit_1 which oversees the business in a group of countries.'),
country_grp_org_nr
OPTIONS(description='The number which identifies the related organizational unit_1 which oversees the business in a group of countries.'),
country_grp_org_name
OPTIONS(description='The name for the related organizational unit_1 which oversees the business in a group of countries.'),
country_grp_org_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee_1 who is responsible for the related group of countries.'),
country_grp_org_mgr_emp_nr
OPTIONS(description='The employee_1 number of the manager who is responsible for the related group of countries.'),
country_grp_org_mgr_name
OPTIONS(description='The name of the manager who is responsible for the related group of countries.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE ORGANIZATIONAL UNIT_1 WHICH OVERSEES THE BUSINESS IN A COUNTRY. (THE DEFINITION OF A COUNTRY_1 IN THAT CONTEXT DOES NOT NECESSARILY MATCH EXACT GEOGRAPHICAL COUNTRY_1 BORDERS.)`)
AS SELECT int_org_sid AS country_org_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 country_org_cd,
 country_org_nr,
 country_org_name,
 legal_name,
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
 country_org_mgr_emp_sid,
 country_org_mgr_emp_nr,
 country_org_mgr_name,
 country_grp_org_sid,
 country_grp_org_nr,
 country_grp_org_name,
 country_grp_org_mgr_emp_sid,
 country_grp_org_mgr_emp_nr,
 country_grp_org_mgr_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_internal_organization_1 AS main
WHERE dwh_valid_fg
 AND (int_org_type_cd = 'COMPANY' AND is_country_org_fg OR int_org_sid = - 1)
 AND int_org_status_cd NOT IN ('PRE-PROCESS');
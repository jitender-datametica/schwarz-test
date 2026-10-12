CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_DIM_COUNTRY_ORGANIZATION (
country_org_sid COMMENT 'The unique identifier (surrogate key) for the country organization.'
,dwh_valid_from_tmsp COMMENT 'The point in time when this record became valid.'
,dwh_valid_to_tmsp COMMENT 'The point in time when this record was no longer valid.'
,dwh_valid_fg COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'
,country_org_cd COMMENT 'The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)'
,country_org_nr COMMENT 'The number which identifies the country organization.'
,country_org_name COMMENT 'The name for the country organization.'
,legal_name COMMENT 'The official name of the company which acts as the country organization, as shown in the company register.'
,int_org_status_cd COMMENT 'The code for the lifecycle status of an internal organization.'
,int_org_status_descr COMMENT 'A textual description for the lifecycle status of an internal organization in group language, i.e. in German.'
,iso_country_cd COMMENT 'The code according to ISO 3166 identifying the country, in which the head office for the country organization is located,'
,country_name COMMENT 'The name of the country, in which the head office for the country organization is located,'
,city_name COMMENT 'The name of the city where the head office for the country organization is located.'
,district_name COMMENT 'The name of the district, in which the head office for the country organization is located,'
,zip COMMENT 'The postal code of the address of the head office for the country organization.'
,street_name COMMENT 'The name of the street where the head office for the country organization is located.'
,house_nr COMMENT 'The number of the building within the street where the head office for the country organization is located.'
,lon COMMENT 'The geographical longitude of the head office for the country organization.'
,lat COMMENT 'The geographical latitude of the head office for the country organization.'
,country_org_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee who is responsible for the country organization.'
,country_org_mgr_emp_nr COMMENT 'The employee number of the manager who is responsible for the country organization.'
,country_org_mgr_name COMMENT 'The name of the manager who is responsible for the country organization.'
,country_grp_org_sid COMMENT 'The unique identifier (surrogate key) for the related organizational unit which oversees the business in a group of countries.'
,country_grp_org_nr COMMENT 'The number which identifies the related organizational unit which oversees the business in a group of countries.'
,country_grp_org_name COMMENT 'The name for the related organizational unit which oversees the business in a group of countries.'
,country_grp_org_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee who is responsible for the related group of countries.'
,country_grp_org_mgr_emp_nr COMMENT 'The employee number of the manager who is responsible for the related group of countries.'
,country_grp_org_mgr_name COMMENT 'The name of the manager who is responsible for the related group of countries.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'The organizational unit which oversees the business in a country. (The definition of a country in that context does not necessarily match exact geographical country borders.)' AS SELECT
main.int_org_sid AS country_org_sid
,main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,main.country_org_cd AS country_org_cd
,main.country_org_nr AS country_org_nr
,main.country_org_name AS country_org_name
,main.legal_name AS legal_name
,main.int_org_status_cd AS int_org_status_cd
,main.int_org_status_descr AS int_org_status_descr
,main.iso_country_cd AS iso_country_cd
,main.country_name AS country_name
,main.city_name AS city_name
,main.district_name AS district_name
,main.zip AS zip
,main.street_name AS street_name
,main.house_nr AS house_nr
,main.lon AS lon
,main.lat AS lat
,main.country_org_mgr_emp_sid AS country_org_mgr_emp_sid
,main.country_org_mgr_emp_nr AS country_org_mgr_emp_nr
,main.country_org_mgr_name AS country_org_mgr_name
,main.country_grp_org_sid AS country_grp_org_sid
,main.country_grp_org_nr AS country_grp_org_nr
,main.country_grp_org_name AS country_grp_org_name
,main.country_grp_org_mgr_emp_sid AS country_grp_org_mgr_emp_sid
,main.country_grp_org_mgr_emp_nr AS country_grp_org_mgr_emp_nr
,main.country_grp_org_mgr_name AS country_grp_org_mgr_name
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_INTERNAL_ORGANIZATION main 
WHERE main.dwh_valid_fg = TRUE 
AND ((main.int_org_type_cd='COMPANY' AND main.is_country_org_fg ) OR main.int_org_sid = -1
)AND main.int_org_status_cd NOT IN ('PRE-PROCESS');
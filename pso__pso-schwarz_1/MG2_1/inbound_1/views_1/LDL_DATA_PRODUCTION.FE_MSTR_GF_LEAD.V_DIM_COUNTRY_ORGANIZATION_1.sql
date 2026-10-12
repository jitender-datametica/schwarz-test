create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_COUNTRY_ORGANIZATION_1(
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country_1 organization.',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)',
	COUNTRY_ORG_NR COMMENT 'The number which identifies the country_1 organization.',
	COUNTRY_ORG_NAME COMMENT 'The name for the country_1 organization.',
	LEGAL_NAME COMMENT 'The official name of the company which acts as the country_1 organization, as shown in the company register.',
	INT_ORG_STATUS_CD COMMENT 'The code for the lifecycle status_1 of an internal organization.',
	INT_ORG_STATUS_DESCR COMMENT 'A textual description for the lifecycle status_1 of an internal organization in group language, i.e. in German.',
	ISO_COUNTRY_CD COMMENT 'The code according to ISO 3166 identifying the country_1, in which the head office for the country_1 organization is located,',
	COUNTRY_NAME COMMENT 'The name of the country_1, in which the head office for the country_1 organization is located,',
	CITY_NAME COMMENT 'The name of the city where the head office for the country_1 organization is located.',
	DISTRICT_NAME COMMENT 'The name of the district, in which the head office for the country_1 organization is located,',
	ZIP COMMENT 'The postal code of the address_1 of the head office for the country_1 organization.',
	STREET_NAME COMMENT 'The name of the street where the head office for the country_1 organization is located.',
	HOUSE_NR COMMENT 'The number of the building within the street where the head office for the country_1 organization is located.',
	LON COMMENT 'The geographical longitude of the head office for the country_1 organization.',
	LAT COMMENT 'The geographical latitude of the head office for the country_1 organization.',
	COUNTRY_ORG_MGR_EMP_SID COMMENT 'The unique identifier (surrogate key) for the employee_1 who is responsible for the country_1 organization.',
	COUNTRY_ORG_MGR_EMP_NR COMMENT 'The employee_1 number of the manager who is responsible for the country_1 organization.',
	COUNTRY_ORG_MGR_NAME COMMENT 'The name of the manager who is responsible for the country_1 organization.',
	COUNTRY_GRP_ORG_SID COMMENT 'The unique identifier (surrogate key) for the related organizational unit_1 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_NR COMMENT 'The number which identifies the related organizational unit_1 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_NAME COMMENT 'The name for the related organizational unit_1 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_MGR_EMP_SID COMMENT 'The unique identifier (surrogate key) for the employee_1 who is responsible for the related group of countries.',
	COUNTRY_GRP_ORG_MGR_EMP_NR COMMENT 'The employee_1 number of the manager who is responsible for the related group of countries.',
	COUNTRY_GRP_ORG_MGR_NAME COMMENT 'The name of the manager who is responsible for the related group of countries.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='The organizational unit_1 which oversees the business in a country. (The definition of a country_1 in that context does not necessarily match exact geographical country_1 borders.)'
 as SELECT
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
FROM CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_1 main 
WHERE main.dwh_valid_fg = TRUE 
AND ((main.int_org_type_cd='COMPANY' AND main.is_country_org_fg ) OR main.int_org_sid = -1
)AND main.int_org_status_cd NOT IN ('PRE-PROCESS');
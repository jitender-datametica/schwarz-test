CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_SALES_ORGANIZATIONAL_REGION_2(
dwh_valid_from_tmsp COMMENT 'the point in time when this record became valid.'
,dwh_valid_to_tmsp COMMENT 'the point in time when this record was no longer valid.'
,dwh_valid_fg COMMENT 'an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'
,int_org_type_cd COMMENT 'the internal company type like store,company...'
,int_org_status_cd COMMENT 'the code for the lifecycle status_2 of an internal organization.'
,int_org_status_descr COMMENT 'a textual description for the lifecycle status_2 of an internal organization in group language, i.e. in german.'
,iso_country_cd COMMENT 'the code according to iso 3166 identifying the country_2, in which the head office for the organizational region_2 is located,'
,country_name COMMENT 'the name of the country_2, in which the head office for the organizational region_2 is located,'
,city_name COMMENT 'the name of the city where the head office for the organizational region_2 is located.'
,district_name COMMENT 'the name of the district, in which the head office for the organizational region_2 is located,'
,zip COMMENT 'the postal code of the address_2 of the head office for the organizational region.'
,street_name COMMENT 'the name of the street where the head office for the organizational region_2 is located.'
,house_nr COMMENT 'the number of the building within the street where the head office for the organizational region_2 is located.'
,lon COMMENT 'the geographical longitude of the head office for the organizational region.'
,lat COMMENT 'the geographical latitude of the head office for the organizational region.'
,country_org_sid COMMENT 'the unique identifier (surrogate key) for the country_2 organization to which this organizational region_2 reports.'
,country_org_cd COMMENT 'the code of the business country_2 for which this country_2 organization is responsible. (the business country_2 is not identical to a political country.)'
,country_org_nr COMMENT 'the number which identifies the country_2 organization to which this organizational region_2 reports.'
,country_org_name COMMENT 'the name for the country_2 organization to which this organizational region_2 reports. (name in group language, i.e. in german). (the country_2 organization is not necessarily identical with a political country_2,)'
,legal_name COMMENT 'the name for the related organizational unit_2 which oversees the business in a group of countries.'
,country_org_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_2 who is responsible for the related country_2 organization.'
,country_org_mgr_emp_nr COMMENT 'the employee_2 number of the manager who is responsible for the related country_2 organization.'
,country_org_mgr_name COMMENT 'the name of the manager who is responsible for the related country_2 organization.'
,country_grp_org_sid COMMENT 'the unique identifier (surrogate key) for the related organizational unit_2 which oversees the business in a group of countries.'
,country_grp_org_nr COMMENT 'the number which identifies the related organizational unit_2 which oversees the business in a group of countries.'
,country_grp_org_name COMMENT 'the name for the related organizational unit_2 which oversees the business in a group of countries.'
,country_grp_org_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_2 who is responsible for the related group of countries.'
,country_grp_org_mgr_emp_nr COMMENT 'the employee_2 number of the manager who is responsible for the related group of countries.'
,country_grp_org_mgr_name COMMENT 'the name of the manager who is responsible for the related group of countries.'
,dwh_created_tmsp COMMENT 'the point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'the point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'the code for the source system (or slice of source system) from which this record was loaded.'
,sales_region_mgr_emp_nr COMMENT 'the employee_2 number of the person who is currently filling the role of the manager of the related sales_2 region.'
,sales_region_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_2 who is currently filling the role of the manager of the related sales_2 region.'
,sales_region_mgr_name COMMENT 'the name of the manager of the related sales_2 region.'
,sales_region_name COMMENT 'the name of the related sales_2 region.'
,sales_region_nr COMMENT 'the number which identifies the related sales_2 region.'
,sales_region_sid COMMENT 'the unique identifier (surrogate key) for the related sales_2 region_2'
) COMMENT='An organizational unit_2 which oversees the business in a region. A region_2 is typically a part of a country.'
 AS SELECT
 main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,DECODE(main.int_org_sid,
        main.country_org_sid,'COUNTRY_2',
        main.int_org_type_cd) AS int_org_type_cd
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
,main.country_org_sid AS country_org_sid
,main.country_org_cd AS country_org_cd
,main.country_org_nr AS country_org_nr
,main.country_org_name AS country_org_name
,main.legal_name AS legal_name
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
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_emp_nr,
        main.sales_region_mgr_emp_nr) AS sales_region_mgr_emp_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.sales_region_mgr_emp_sid) AS sales_region_mgr_emp_sid       
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_name,
        main.sales_region_mgr_name) AS sales_region_mgr_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_name,
        main.sales_region_name) AS sales_region_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.sales_region_nr) AS sales_region_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.sales_region_sid) AS sales_region_sid
FROM CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_2 main 
WHERE main.dwh_valid_fg = TRUE  
AND ( main.int_org_type_cd='REGION_2' 
     OR (main.int_org_type_cd='COMPANY' AND main.int_org_sid = main.country_org_sid)
    )
	AND main.int_org_status_cd NOT IN ('PRE-PROCESS');
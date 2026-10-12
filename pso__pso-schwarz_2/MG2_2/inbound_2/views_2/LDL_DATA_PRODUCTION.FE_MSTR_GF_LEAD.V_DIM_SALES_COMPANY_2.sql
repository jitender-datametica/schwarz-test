create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_SALES_COMPANY_2(
	SALES_COMPANY_SID COMMENT 'the unique identifier (surrogate key) for a sales_2 company (vges).',
	INT_ORG_TYPE_CD COMMENT 'the internal organization type like store,company...',
	DWH_VALID_FROM_TMSP COMMENT 'the point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'the point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SALES_COMPANY_NR COMMENT 'the number which identifies the sales_2 company.',
	SALES_COMPANY_NAME COMMENT 'the name of the sales_2 company.',
	INT_ORG_STATUS_CD COMMENT 'the code for the lifecycle status_2 of an internal organization.',
	INT_ORG_STATUS_DESCR COMMENT 'a textual description for the lifecycle status_2 of an internal organization in group language, i.e. in german.',
	OPEN_DT COMMENT 'the date when the sales_2 company has started its regular operation. (this date may be different from the planned opening date.)',
	PLANNED_OPEN_DT COMMENT 'the expected opening date of the sales_2 company.',
	CLOSE_DT COMMENT 'the date when the sales_2 company has stopped its regular operation.',
	ISO_COUNTRY_CD COMMENT 'the code identifying the country_2 according to iso 3166.',
	COUNTRY_NAME COMMENT 'the name of the country_2, in which the sales_2 company is located,',
	CITY_NAME COMMENT 'the name of the city where the sales_2 company is located.',
	DISTRICT_NAME COMMENT 'the name of the district, in which the sales_2 company is located,',
	ZIP COMMENT 'the postal code of the address_2 of the sales_2 company.',
	STREET_NAME COMMENT 'the name of the street where the sales_2 company is located.',
	HOUSE_NR COMMENT 'the number of the building within the street where the sales_2 company is located.',
	LON COMMENT 'the geographical longitude of the address_2 of the sales_2 company.',
	LAT COMMENT 'the geographical latitude of the address_2 of the sales_2 company.',
	PO_BOX_NR COMMENT 'the post box number of the sales_2 company. (null if it does not have post box.)',
	PHONE_NR COMMENT 'the telephone number of the sales_2 company.',
	FAX_NR COMMENT 'the telefax number of the sales_2 company.',
	EMAIL_ADDR_TXT COMMENT 'an email address_2 for that sales_2 company.',
	SALES_COMPANY_DIRECTOR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_2, who is currently filling the role of the director of the sales_2 company.',
	SALES_COMPANY_DIRECTOR_EMP_NR COMMENT 'the employee_2 number of the person who is currently filling the position of the director of the sales_2 company.',
	SALES_COMPANY_DIRECTOR_NAME COMMENT 'the name of the person who is currently filling the position of the director of the sales_2 company.',
	COUNTRY_ORG_SID COMMENT 'the unique identifier (surrogate key) for the related country_2 organization.',
	COUNTRY_ORG_CD COMMENT 'the code of the business country_2 for which this country_2 organization is responsible. (the business country_2 is not identical to a political country.)',
	COUNTRY_ORG_NR COMMENT 'the number which identifies the related country_2 organization.',
	COUNTRY_ORG_NAME COMMENT 'the name for the related country_2 organization. (name in group language, i.e. in german). (the country_2 organization is not necessarily identical with a political country_2,)',
	COUNTRY_ORG_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_2 who is responsible for the related country_2 organization.',
	COUNTRY_ORG_MGR_EMP_NR COMMENT 'the employee_2 number of the manager who is responsible for the related country_2 organization.',
	COUNTRY_ORG_MGR_NAME COMMENT 'the name of the manager who is responsible for the related country_2 organization.',
	COUNTRY_GRP_ORG_SID COMMENT 'the unique identifier (surrogate key) for the related organizational unit_2 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_NR COMMENT 'the number which identifies the related organizational unit_2 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_NAME COMMENT 'the name for the related organizational unit_2 which oversees the business in a group of countries.',
	LEGAL_NAME COMMENT 'the name for the related organizational unit_2 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_2 who is responsible for the related group of countries.',
	COUNTRY_GRP_ORG_MGR_EMP_NR COMMENT 'the employee_2 number of the manager who is responsible for the related group of countries.',
	COUNTRY_GRP_ORG_MGR_NAME COMMENT 'the name of the manager who is responsible for the related group of countries.',
	DWH_CREATED_TMSP COMMENT 'the point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'the point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'the code for the source system (or slice of source system) from which this record was loaded.',
	SALES_REGION_MGR_EMP_NR COMMENT 'The employee_2 number of the person who is currently filling the role of the manager of the related sales_2 region.',
	SALES_REGION_MGR_EMP_SID COMMENT 'The unique identifier (surrogate key) for the employee_2 who is currently filling the role of the manager of the related sales_2 region.',
	SALES_REGION_MGR_NAME COMMENT 'The name of the manager of the related sales_2 region.',
	SALES_REGION_NAME COMMENT 'The name of the related sales_2 region.',
	SALES_REGION_NR COMMENT 'The number which identifies the related sales_2 region.',
	SALES_REGION_SID COMMENT 'The unique identifier (surrogate key) for the related sales_2 region_2'
) COMMENT='The sales_2 company handles all retail-related aspects of a regional company. It is part of the sales_2 hierarchy.. Also known AS VGES.'
 as SELECT
main.int_org_sid AS sales_company_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,'COUNTRY_2',
        main.int_org_type_cd) AS int_org_type_cd
,main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,main.curr_int_org_nr AS sales_company_nr
,main.int_org_name AS sales_company_name
,main.int_org_status_cd AS int_org_status_cd
,main.int_org_status_descr AS int_org_status_descr
,main.open_dt AS open_dt
,main.planned_open_dt AS planned_open_dt
,main.close_dt AS close_dt
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
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_mgr_emp_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.sales_mgr_emp_sid) AS sales_company_director_emp_sid
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_mgr_emp_nr,
        main.country_org_sid,main.country_org_mgr_emp_nr,
        main.sales_mgr_emp_nr) AS sales_company_director_emp_nr
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_mgr_name,
        main.country_org_sid,main.country_org_mgr_name,
        main.sales_company_director_name) AS sales_company_director_name
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
AND ( (main.int_org_type_cd ='COMPANY' AND  main.is_sales_company_fg) 
      OR main.int_org_type_cd='REGION_2'
      OR (main.int_org_type_cd='COMPANY' AND main.int_org_sid = main.country_org_sid)
) AND main.int_org_status_cd NOT IN ('PRE-PROCESS');
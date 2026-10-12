CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_DIM_SALES_COMPANY_1(
sales_company_sid COMMENT 'the unique identifier (surrogate key) for a sales_1 company (vges).'
,int_org_type_cd COMMENT 'the internal organization type like store,company...'
,dwh_valid_from_tmsp COMMENT 'the point in time when this record became valid.'
,dwh_valid_to_tmsp COMMENT 'the point in time when this record was no longer valid.'
,dwh_valid_fg COMMENT 'an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'
,sales_company_nr COMMENT 'the number which identifies the sales_1 company.'
,sales_company_name COMMENT 'the name of the sales_1 company.'
,int_org_status_cd COMMENT 'the code for the lifecycle status_1 of an internal organization.'
,int_org_status_descr COMMENT 'a textual description for the lifecycle status_1 of an internal organization in group language, i.e. in german.'
,open_dt COMMENT 'the date when the sales_1 company has started its regular operation. (this date may be different from the planned opening date.)'
,planned_open_dt COMMENT 'the expected opening date of the sales_1 company.'
,close_dt COMMENT 'the date when the sales_1 company has stopped its regular operation.'
,iso_country_cd COMMENT 'the code identifying the country_1 according to iso 3166.'
,country_name COMMENT 'the name of the country_1, in which the sales_1 company is located,'
,city_name COMMENT 'the name of the city where the sales_1 company is located.'
,district_name COMMENT 'the name of the district, in which the sales_1 company is located,'
,zip COMMENT 'the postal code of the address_1 of the sales_1 company.'
,street_name COMMENT 'the name of the street where the sales_1 company is located.'
,house_nr COMMENT 'the number of the building within the street where the sales_1 company is located.'
,lon COMMENT 'the geographical longitude of the address_1 of the sales_1 company.'
,lat COMMENT 'the geographical latitude of the address_1 of the sales_1 company.'
,po_box_nr COMMENT 'the post box number of the sales_1 company. (null if it does not have post box.)'
,phone_nr COMMENT 'the telephone number of the sales_1 company.'
,fax_nr COMMENT 'the telefax number of the sales_1 company.'
,email_addr_txt COMMENT 'an email address_1 for that sales_1 company.'
,sales_company_director_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_1, who is currently filling the role of the director of the sales_1 company.'
,sales_company_director_emp_nr COMMENT 'the employee_1 number of the person who is currently filling the position of the director of the sales_1 company.'
,sales_company_director_name COMMENT 'the name of the person who is currently filling the position of the director of the sales_1 company.'
,country_org_sid COMMENT 'the unique identifier (surrogate key) for the related country_1 organization.'
,country_org_cd COMMENT 'the code of the business country_1 for which this country_1 organization is responsible. (the business country_1 is not identical to a political country.)'
,country_org_nr COMMENT 'the number which identifies the related country_1 organization.'
,country_org_name COMMENT 'the name for the related country_1 organization. (name in group language, i.e. in german). (the country_1 organization is not necessarily identical with a political country_1,)'
,country_org_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_1 who is responsible for the related country_1 organization.'
,country_org_mgr_emp_nr COMMENT 'the employee_1 number of the manager who is responsible for the related country_1 organization.'
,country_org_mgr_name COMMENT 'the name of the manager who is responsible for the related country_1 organization.'
,country_grp_org_sid COMMENT 'the unique identifier (surrogate key) for the related organizational unit_1 which oversees the business in a group of countries.'
,country_grp_org_nr COMMENT 'the number which identifies the related organizational unit_1 which oversees the business in a group of countries.'
,country_grp_org_name COMMENT 'the name for the related organizational unit_1 which oversees the business in a group of countries.'
,legal_name COMMENT 'the name for the related organizational unit_1 which oversees the business in a group of countries.'
,country_grp_org_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_1 who is responsible for the related group of countries.'
,country_grp_org_mgr_emp_nr COMMENT 'the employee_1 number of the manager who is responsible for the related group of countries.'
,country_grp_org_mgr_name COMMENT 'the name of the manager who is responsible for the related group of countries.'
,dwh_created_tmsp COMMENT 'the point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'the point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'the code for the source system (or slice of source system) from which this record was loaded.'
,sales_region_mgr_emp_nr COMMENT 'The employee_1 number of the person who is currently filling the role of the manager of the related sales_1 region.'
,sales_region_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee_1 who is currently filling the role of the manager of the related sales_1 region.'
,sales_region_mgr_name COMMENT 'The name of the manager of the related sales_1 region.'
,sales_region_name COMMENT 'The name of the related sales_1 region.'
,sales_region_nr COMMENT 'The number which identifies the related sales_1 region.'
,sales_region_sid COMMENT 'The unique identifier (surrogate key) for the related sales_1 region_1'
) COMMENT='The sales_1 company handles all retail-related aspects of a regional company. It is part of the sales_1 hierarchy.. Also known AS VGES.' AS SELECT
main.int_org_sid AS sales_company_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,'COUNTRY_1',
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
FROM CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_1 main 
WHERE main.dwh_valid_fg = TRUE 
AND ( (main.int_org_type_cd ='COMPANY' AND  main.is_sales_company_fg) 
      OR main.int_org_type_cd='REGION_1'
      OR (main.int_org_type_cd='COMPANY' AND main.int_org_sid = main.country_org_sid)
);
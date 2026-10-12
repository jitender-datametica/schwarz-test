CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_DIM_DELIVERY_COMPANY(
deliv_company_sid COMMENT 'the unique identifier (surrogate key) for delivery company.'
,int_org_type_cd COMMENT 'the internal company type like store,company...'
,dwh_valid_from_tmsp COMMENT 'the point in time when this record became valid.'
,dwh_valid_to_tmsp COMMENT 'the point in time when this record was no longer valid.'
,dwh_valid_fg COMMENT 'an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'
,deliv_company_nr COMMENT 'the number which identifies the delivery company.'
,deliv_company_name COMMENT 'the name of the delivery company.'
,int_org_status_cd COMMENT 'the code for the lifecycle status of an internal organization.'
,int_org_status_descr COMMENT 'a textual description for the lifecycle status of an internal organization in group language, i.e. in german.'
,open_dt COMMENT 'the date when the delivery company has started its regular operation. (this date may be different from the planned opening date.)'
,planned_open_dt COMMENT 'the expected opening date of the delivery company.'
,close_dt COMMENT 'the date when the delivery company has stopped its regular operation.'
,iso_country_cd COMMENT 'the code identifying the country according to iso 3166.'
,country_name COMMENT 'the name of the country, in which the delivery company is located,'
,city_name COMMENT 'the name of the city where the delivery company is located.'
,district_name COMMENT 'the name of the district, in which the delivery company is located,'
,zip COMMENT 'the postal code of the address of the delivery company.'
,street_name COMMENT 'the name of the street where the delivery company is located.'
,house_nr COMMENT 'the number of the building within the street where the delivery company is located.'
,lon COMMENT 'the geographical longitude of the address of the delivery company.'
,lat COMMENT 'the geographical latitude of the address of the delivery company.'
,po_box_nr COMMENT 'the post box number of the delivery company (null if it does not have post box.)'
,phone_nr COMMENT 'the telephone number of the delivery company.'
,fax_nr COMMENT 'the telefax number of the delivery company.'
,email_addr_txt COMMENT 'an email address for that delivery company.'
,deliv_company_director_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee, who is currently filling the role of the director of the delivery company.'
,deliv_company_director_emp_nr COMMENT 'the employee number of the person who is currently filling the position of the director of the delivery company-'
,deliv_company_director_name COMMENT 'the name of the person who is currently filling the position of the director of the delivery company.'
,country_org_sid COMMENT 'the unique identifier (surrogate key) for the related country organization.'
,country_org_cd COMMENT 'the code of the business country for which this country organization is responsible. (the business country is not identical to a political country.)'
,country_org_nr COMMENT 'the number which identifies the related country organization.'
,country_org_name COMMENT 'the name for the related  country organization (name in group language, i.e. in german). (the country organization is not necessarily identical with a political country,)'
,legal_name COMMENT 'the official name of the company which acts as the country organization, as shown in the company register.'
,country_org_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee who is responsible for the related country organization.'
,country_org_mgr_emp_nr COMMENT 'the employee number of the manager who is responsible for the related country organization.'
,country_org_mgr_name COMMENT 'the name of the manager who is responsible for the related country organization.'
,country_grp_org_sid COMMENT 'the unique identifier (surrogate key) for the related organizational unit which oversees the business in a group of countries.'
,country_grp_org_nr COMMENT 'the number which identifies the related organizational unit which oversees the business in a group of countries.'
,country_grp_org_name COMMENT 'the name for the related organizational unit which oversees the business in a group of countries.'
,country_grp_org_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee who is responsible for the related group of countries.'
,country_grp_org_mgr_emp_nr COMMENT 'the employee number of the manager who is responsible for the related group of countries.'
,country_grp_org_mgr_name COMMENT 'the name of the manager who is responsible for the related group of countries.'
,dwh_created_tmsp COMMENT 'the point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'the point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'the code for the source system (or slice of source system) from which this record was loaded.'
,deliv_region_mgr_emp_nr COMMENT 'the employee number of the person who is currently filling the role of the manager of the related delivery region.'
,deliv_region_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee who is currently filling the role of the manager of the related delivery region.'
,deliv_region_mgr_name COMMENT 'the name of the manager of the related delivery region.'
,deliv_region_name COMMENT 'the name of the related delivery region.'
,deliv_region_sid COMMENT 'the unique identifier (surrogate key) for the related delivery region'
,deliv_region_nr COMMENT 'the number which identifies the related delivery region.'
) COMMENT='The delivery company is responsible for providing items to the stores. It operates a warehouse. The delivery company is part of the delivery hierarchy. Also known as BGES.' AS SELECT
main.int_org_sid AS deliv_company_sid
,main.int_org_type_cd AS int_org_type_cd
,main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,main.curr_int_org_nr AS deliv_company_nr
,main.int_org_name AS deliv_company_name
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
        main.deliv_region_sid,main.deliv_region_mgr_emp_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.deliv_company_director_emp_sid) AS deliv_company_director_emp_sid
,DECODE(main.int_org_sid,
        main.deliv_region_sid,main.deliv_region_mgr_emp_nr,
        main.country_org_sid,main.country_org_mgr_emp_nr,
        main.deliv_company_director_emp_nr) AS deliv_company_director_emp_nr
,DECODE(main.int_org_sid,
        main.deliv_region_sid,main.deliv_region_mgr_name,
        main.country_org_sid,main.country_org_mgr_name,
        main.deliv_company_director_name) AS deliv_company_director_name
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
        main.deliv_region_mgr_emp_nr) AS deliv_region_mgr_emp_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.deliv_region_mgr_emp_sid) AS deliv_region_mgr_emp_sid       
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_name,
        main.deliv_region_mgr_name) AS deliv_region_mgr_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_name,
        main.deliv_region_name) AS deliv_region_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.deliv_region_nr) AS deliv_region_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.deliv_region_sid) AS deliv_region_sid
FROM CORE_DIM.T_DIM_INTERNAL_ORGANIZATION main 
WHERE main.dwh_valid_fg = TRUE 
AND  ( (int_org_type_cd ='COMPANY' AND  is_deliv_company_fg) 
        OR int_org_type_cd ='REGION'
        OR (int_org_type_cd ='COMPANY' AND int_org_sid = country_org_sid)
     );
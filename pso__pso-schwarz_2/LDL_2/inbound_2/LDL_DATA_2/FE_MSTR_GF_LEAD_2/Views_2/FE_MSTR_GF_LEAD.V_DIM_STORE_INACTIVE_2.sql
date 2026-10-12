CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_STORE_INACTIVE_2(
store_sid COMMENT 'the unique identifier (surrogate key) for a store.'
,int_org_type_cd COMMENT 'the internal organanisation type like store, company...'
,dwh_valid_from_tmsp COMMENT 'the point in time when this record became valid.'
,dwh_valid_to_tmsp COMMENT 'the point in time when this record was no longer valid.'
,dwh_valid_fg COMMENT 'an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'
,curr_store_nr COMMENT 'the number by which the store is currently known to business. the store number is identical to the real estate number of the object which currently houses the store. in case the building changes, the store_sid remains unchanged, but the store number gets updated.'
,init_store_nr COMMENT 'the initial store number, i.e. the number which was assigned to the store before the first relocation or demolition. this number does not change, in case the building changes.'
,store_name COMMENT 'the name of the store.'
,int_org_status_cd COMMENT 'the code for the retail status_2 of a store. the status_2 codes for <open> and <closed> are strictly connected with the store open date and the store close date, AS they are derived from these attributes.'
,int_org_status_descr COMMENT 'a textual description for the retail status_2 (open / closed) of a store in group language, i.e. in german.'
,store_real_estate_type_cd COMMENT 'The code identifying the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. '
,store_real_estate_type_descr COMMENT 'A textual description for the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. (Description in group language, i.e. in German)'
,open_dt COMMENT 'the date when the store has started its regular operation. (this date may be different from the planned opening date.)'
,planned_open_dt COMMENT 'the expected opening date of the store.'
,close_dt COMMENT 'the closing date of the store AS set by wawi. (null if the store is open.)'
,country_cd COMMENT 'the code according to iso 3166 identifying the country_2, in which the store is located,'
,country_name COMMENT 'the name of the country_2, in which the store is located,'
,reporting_country_cd COMMENT 'the code according to iso 3166 identifying the country_2, in which the store is located,'
,reporting_country_name COMMENT 'the name of the country_2, in which the store is located,'
,city_name COMMENT 'the name of the city where the store is located.'
,district_name COMMENT 'the name of the district, in which the store is located,'
,zip COMMENT 'the postal code of the store address.'
,street_name COMMENT 'the name of the street where the store is located.'
,house_nr COMMENT 'the number of the building within the street where the store is located.'
,lon COMMENT 'the geographical longitude of the store address.'
,lat COMMENT 'the geographical latitude of the store address.'
,po_box_nr COMMENT 'the post box number of the store. (null if the store does not have post box.)'
,phone_nr COMMENT 'the telephone number of the store.'
,fax_nr COMMENT 'the telefax number of the store.'
,email_addr_txt COMMENT 'an email address_2 for that store.'
,sales_mgr_district_sid COMMENT 'the unique identifier (surrogate key) for the organizational unit_2 for which the related sales_2 manager is responsible.'
,sales_mgr_district_nr COMMENT 'the number which identifies the organizational unit_2 for which the related sales_2 manager is responsible.'
,sales_mgr_district_name COMMENT 'the name of the related sales_2 manager district.'
,sales_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_2, who is currently filling the position of the related sales_2 manager.'
,sales_mgr_emp_nr COMMENT 'the employee_2 number of the person who is currently filling the position of the related sales_2 manager.'
,sales_mgr_name COMMENT 'the name of the person who is currently filling the position of the related sales_2 manager.'
,acct_mgr_district_sid COMMENT 'the unique identifier (surrogate key) for the organizational unit_2 for which the related account_2 manager is responsible.'
,acct_mgr_district_nr COMMENT 'the number which identifies the organizational unit_2 for which the related account_2 manager is responsible.'
,acct_mgr_district_name COMMENT 'the name of the related account_2 manager district.'
,acct_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_2, who is currently filling the positon of the related account_2 manager.'
,acct_mgr_emp_nr COMMENT 'the employee_2 number of the person who is currently filling the position of the related account_2 manager.'
,acct_mgr_name COMMENT 'the name of the person who is currently filling the position of the related account_2 manager.'
,sales_company_sid COMMENT 'the unique identifier (surrogate key) for the sales_2 company (vges) to which this store is related.'
,sales_company_nr COMMENT 'the number which identifies the sales_2 company (vges) to which this store is related.'
,sales_company_name COMMENT 'the name of the sales_2 company to which this store is related..'
,sales_company_director_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_2, who is the director of the related sales_2 company.'
,sales_company_director_emp_nr COMMENT 'the employee_2 number of the director of the related sales_2 company.'
,sales_company_director_name COMMENT 'the name of the manager of the related sales_2 company.'
,deliv_company_sid COMMENT 'surrogate key for     the delivery company which is responsible for this store.'
,deliv_company_nr COMMENT 'the number which identifies the delivery company which is responsible for this store.'
,deliv_company_name COMMENT 'the name of the delivery company which is responsible for this store..'
,deliv_company_director_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_2, who is the director of the related delivery company.'
,deliv_company_director_emp_nr COMMENT 'the employee_2 number of the director of the related delivery company.'
,deliv_company_director_name COMMENT 'the name of the manager of the related delivery company.'
,expansion_company_sid COMMENT 'the unique identifier (surrogate key) for the expansion company which is responsible for this store.'
,expansion_company_nr COMMENT 'the number which identifies the expansion company which is responsible for this store.'
,expansion_company_name COMMENT 'the name of the expansion company which is responsible for this store.'
,bal_sheet_company_sid COMMENT 'the unique identifier (surrogate key) for the balance sheet company, which is responsible for this store..'
,bal_sheet_company_nr COMMENT 'the number which identifies the balance sheet company, which is responsible for this store..'
,bal_sheet_company_name COMMENT 'the name of the balance sheet company, which is responsible for this store..'
,owner_company_sid COMMENT 'the unique identifier (surrogate key) for the owner company, which is responsible for this store..'
,owner_company_nr COMMENT 'the number which identifies the owner company, which is responsible for this store..'
,owner_company_name COMMENT 'the name of the owner company, which is responsible for this store..'
,country_org_sid COMMENT 'the unique identifier (surrogate key) for the related country_2 organization.'
,country_org_cd COMMENT 'the code of the business country_2 for which this country_2 organization is responsible. (the business country_2 is not identical to a political country.)'
,country_org_nr COMMENT 'the number which identifies the related country_2 organization.'
,country_org_name COMMENT 'the name for the related country_2 organization. (name in group language, i.e. in german). (the country_2 organization is not necessarily identical with a political country_2,)'
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
,deliv_region_mgr_emp_nr COMMENT 'the employee_2 number of the person who is currently filling the role of the manager of the related delivery region.'
,deliv_region_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_2 who is currently filling the role of the manager of the related delivery region.'
,deliv_region_mgr_name COMMENT 'the name of the manager of the related delivery region.'
,deliv_region_name COMMENT 'the name of the related delivery region.'
,deliv_region_nr COMMENT 'the number which identifies the related delivery region.'
,deliv_region_sid COMMENT 'the unique identifier (surrogate key) for the related delivery region_2'
,sales_region_mgr_emp_nr COMMENT 'the employee_2 number of the person who is currently filling the role of the manager of the related sales_2 region.'
,sales_region_mgr_emp_sid COMMENT 'the unique identifier (surrogate key) for the employee_2 who is currently filling the role of the manager of the related sales_2 region.'
,sales_region_mgr_name COMMENT 'the name of the manager of the related sales_2 region.'
,sales_region_name COMMENT 'the name of the related sales_2 region.'
,sales_region_nr COMMENT 'the number which identifies the related sales_2 region.'
,sales_region_sid COMMENT 'the unique identifier (surrogate key) for the related sales_2 region_2'
) COMMENT='A store, seen AS an internal organization unit_2 of the Schwarz Group. A store is located at a physical address. Its purpose is to offer goods to customers. Online-stores are not covered by this definition of a store. Note that the building that houses the store, is a resource item.' AS  SELECT 
main.int_org_sid AS store_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,'COUNTRY_2',
        main.int_org_type_cd) AS int_org_type_cd
,main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,main.curr_int_org_nr AS curr_store_nr
,main.init_int_org_nr AS init_store_nr
,main.int_org_name AS store_name
,main.int_org_status_cd AS int_org_status_cd
,main.int_org_status_descr AS int_org_status_descr
,CASE WHEN main.int_org_sid=main.country_org_sid THEN 'Country_2' WHEN main.int_org_type_cd='STORE' THEN main.store_real_estate_type_cd ELSE 'n/a' END AS store_real_estate_type_cd
,CASE WHEN main.int_org_sid=main.country_org_sid THEN 'Country_2' WHEN main.int_org_type_cd='STORE' THEN main.store_real_estate_type_descr ELSE 'n/a' END AS store_real_estate_type_descr	
,main.open_dt AS open_dt
,main.planned_open_dt AS planned_open_dt
,main.close_dt AS close_dt
,main.iso_country_cd AS iso_country_cd
,main.country_name AS country_name
,main.reporting_country_cd AS reporting_country_cd
,main.reporting_country_name AS reporting_country_name
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
        main.acct_mgr_district_sid,main.acct_mgr_district_sid,
        main.sales_company_sid,main.sales_company_sid,
        main.sales_region_sid,main.sales_region_sid,
        main.country_org_sid,main.country_org_sid,
        main.sales_mgr_district_sid) AS sales_mgr_district_sid
,DECODE(main.int_org_sid,
        main.acct_mgr_district_sid,main.acct_mgr_district_nr,
        main.sales_company_sid,main.sales_company_nr,
        main.sales_region_sid,main.sales_region_nr,
        main.country_org_sid,main.country_org_nr,
        main.sales_mgr_district_nr) AS sales_mgr_district_nr
,DECODE(main.int_org_sid,
        main.acct_mgr_district_sid,main.acct_mgr_district_name,
        main.sales_company_sid,main.sales_company_name ,
        main.sales_region_sid,main.sales_region_name,
        main.country_org_sid,main.country_org_name,
        main.sales_mgr_district_name) AS sales_mgr_district_name
,DECODE(main.int_org_sid,
        main.acct_mgr_district_sid,main.acct_mgr_emp_sid,
        main.sales_company_sid,main.sales_mgr_emp_sid ,
        main.sales_region_sid,main.sales_region_mgr_emp_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.sales_mgr_emp_sid) AS sales_mgr_emp_sid
,DECODE(main.int_org_sid,
        main.acct_mgr_district_sid,main.acct_mgr_emp_nr,
        main.sales_company_sid,main.sales_mgr_emp_nr,
        main.sales_region_sid,main.sales_region_mgr_emp_nr,
        main.country_org_sid,main.country_org_mgr_emp_nr,
        main.sales_mgr_emp_nr) AS sales_mgr_emp_nr
,DECODE(main.int_org_sid,
        main.acct_mgr_district_sid,main.acct_mgr_name,
        main.sales_company_sid,main.sales_mgr_name,
        main.sales_region_sid,main.sales_region_mgr_name,
        main.country_org_sid,main.country_org_mgr_name,
        main.sales_mgr_name) AS sales_mgr_name
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_company_sid,
        main.sales_region_sid,main.sales_region_sid,
        main.country_org_sid,main.country_org_sid,
        main.acct_mgr_district_sid) AS acct_mgr_district_sid
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_company_nr,
        main.sales_region_sid,main.sales_region_nr,
        main.country_org_sid,main.country_org_nr,
        main.acct_mgr_district_nr) AS acct_mgr_district_nr
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_company_name ,
        main.sales_region_sid,main.sales_region_name,
        main.country_org_sid,main.country_org_name,
        main.acct_mgr_district_name) AS acct_mgr_district_name
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_company_director_emp_sid ,
        main.sales_region_sid,main.sales_region_mgr_emp_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.acct_mgr_emp_sid) AS acct_mgr_emp_sid
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_mgr_emp_nr,
        main.sales_region_sid,main.sales_region_mgr_emp_nr,
        main.country_org_sid,main.country_org_mgr_emp_nr,
        main.acct_mgr_emp_nr) AS acct_mgr_emp_nr
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_mgr_name,
        main.sales_region_sid,main.sales_region_mgr_name,
        main.country_org_sid,main.country_org_mgr_name,
        main.acct_mgr_name) AS acct_mgr_name
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_sid,
        main.country_org_sid,main.country_org_sid,
        main.sales_company_sid) AS sales_company_sid
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_nr,
        main.country_org_sid,main.country_org_nr,
        main.sales_company_nr) AS sales_company_nr
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_name,
        main.country_org_sid,main.country_org_name,
        main.sales_company_name) AS sales_company_name
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
,DECODE(main.int_org_sid,
        main.deliv_region_sid,main.deliv_region_sid,
        main.country_org_sid,main.country_org_sid,
        main.deliv_company_sid) AS deliv_company_sid
,DECODE(main.int_org_sid,
        main.deliv_region_sid,main.deliv_region_nr,
        main.country_org_sid,main.country_org_nr,
        main.deliv_company_nr) AS deliv_company_nr
,DECODE(main.int_org_sid,
        main.deliv_region_sid,main.deliv_region_name,
        main.country_org_sid,main.country_org_name,
        main.deliv_company_name) AS deliv_company_name
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
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.expansion_company_sid) AS expansion_company_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.expansion_company_nr) AS expansion_company_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_name,
        main.expansion_company_name) AS expansion_company_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.bal_sheet_company_sid) AS bal_sheet_company_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.bal_sheet_company_nr) AS bal_sheet_company_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_name,
        main.bal_sheet_company_name) AS bal_sheet_company_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.owner_company_sid) AS owner_company_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.owner_company_nr) AS owner_company_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_name,
        main.owner_company_name) AS owner_company_name
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
FROM  CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_2 main 
WHERE main.dwh_valid_fg = TRUE 
AND main.int_org_type_cd NOT IN ('COUNTRY_GRP','TRUST');
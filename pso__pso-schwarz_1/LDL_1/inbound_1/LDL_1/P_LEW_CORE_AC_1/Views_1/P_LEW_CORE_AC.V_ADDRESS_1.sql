create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_ADDRESS_1(
	CLIENT_ID,
	ADDR_SID,
	SRC_ADDRNUMBER,
	SRC_OBJECT_NO,
	SRC_ORIG_STORE_NR,
	SRC_ORIG_WH_NR,
	SRC_VENDOR_DOC_REF,
	LONGITUDE,
	LATITUDE,
	COUNTRY_POL_SID,
	COUNTRY_POL_CD,
	CITY_GROUP_NAME,
	CITY_GROUP_SID,
	CITY_NAME,
	DISTRICT_NAME,
	ZIP,
	STREET_NAME,
	STREET_ADD1_NAME,
	HOUSE_NR,
	POSTBOX_NR,
	PHONE_NR,
	FAX_NR,
	LANG_SID,
	LANG_CD,
	NAME,
	NAME1,
	NAME2,
	NAME3,
	SORT1,
	STREET,
	HOUSE_NUMBER1,
	HOUSE_NUMBER2,
	CITY,
	POSTBOX,
	ZIP_CODE,
	PHONE_NUMBER,
	FAX_NUMBER,
	SALES_ZIP,
	SALES_CITY,
	SALES_STREET,
	SALES_STREET2,
	SALES_HOUSE_NUMBER,
	PHONE_NUMBER2,
	FAX_NUMBER2,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
     v.client_id
   , v.addr_sid
   , v.src_addrnumber
   , v.src_object_no
   , v.src_orig_store_nr
   , v.src_orig_wh_nr
   , v.src_vendor_doc_ref
   , v.longitude
   , v.latitude
   , v.country_pol_sid
   , v.country_pol_cd
   , v.city_group_name
   , v.city_group_sid
   , v.city_name
   , v.district_name
   , v.zip
   , v.street_name
   , v.street_add1_name
   , v.house_nr
   , v.postbox_nr
   , v.phone_nr
   , v.fax_nr
   , v.lang_sid
   , v.lang_cd
   , v.NAME
   , v.name1
   , v.name2
   , v.name3
   , v.sort1
   , v.street
   , v.house_number1
   , v.house_number2
   , v.city
   , v.postbox
   , v.zip_code
   , v.phone_number
   , v.fax_number
   , v.sales_zip
   , v.sales_city
   , v.sales_street
   , v.sales_street2
   , v.sales_house_number
   , v.phone_number2
   , v.fax_number2
   , v.dwh_load_id
   , v.dwh_created
   , v.dwh_updated
   FROM p_lew_core.t_address_1 AS v
   ;

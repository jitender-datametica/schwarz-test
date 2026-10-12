create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_DIM_SUPPLIER_1(
	SUP_SID COMMENT 'The unique identifier (surrogate key) for the supplier.',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SUP_NAME COMMENT 'The name by which the supplier_1 is known.',
	LEGAL_NAME COMMENT 'The official name of the supplier_1, as shown in the company register.',
	VAT_NR COMMENT 'The VAT identification number of the supplier.',
	SUP_STATUS_CD COMMENT 'The code for the lifecycle status_1 of a supplier.',
	SUP_STATUS_DESCR COMMENT 'A textual description for the lifecycle status_1 of a supplier_1 in group language, i.e. in German.',
	ISO_COUNTRY_CD COMMENT 'The code according to ISO 3166 identifying the country_1, in which the supplier_1 is located,',
	COUNTRY_NAME COMMENT 'The name of the country_1, in which the supplier_1 is located,',
	CITY_NAME COMMENT 'The name of the city where the supplier_1 is located.',
	DISTRICT_NAME COMMENT 'The name of the district, in which the supplier_1 is located,',
	ZIP COMMENT 'The postal code of the address_1 of the supplier.',
	STREET_NAME COMMENT 'The name of the street where the supplier_1 is located.',
	HOUSE_NR COMMENT 'The number of the building within the street where the supplier_1 is located.',
	LON COMMENT 'The geographical longitude of the address_1 of the supplier.',
	LAT COMMENT 'The geographical latitude of the address_1 of the supplier.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A supplier_1 is a company that delivers products to the Schwarz Group. Supplier_1 is one out of possibly several roles that can be played by a company.'
 as SELECT 
   main.sup_sid 
   , main.dwh_valid_from_tmsp
   , main.dwh_valid_to_tmsp
   , main.dwh_valid_fg
   , main.sup_name
   , main.legal_name
   , main.vat_nr
   , main.sup_status_cd
   , main.sup_status_descr
   , main.iso_country_cd
   , main.country_name
   , main.city_name
   , main.district_name
   , main.zip
   , main.street_name
   , main.house_nr
   , main.lon
   , main.lat
   , main.dwh_created_tmsp
   , main.dwh_updated_tmsp
   , main.dwh_load_id
   , main.dwh_node_cd
FROM CORE_DIM.T_DIM_SUPPLIER_1 main WHERE main.dwh_valid_fg;
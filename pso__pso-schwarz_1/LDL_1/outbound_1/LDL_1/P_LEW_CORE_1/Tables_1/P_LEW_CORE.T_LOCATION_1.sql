/* --------------------------------------------------------------------------------
   DDL for table: t_location_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_location_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier of the DWH client / slice.'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION_1 (eindeutig ueber alle Laender / Mandanten hinweg).'),
src_werks STRING(20) OPTIONS(description='Techn. identifier of warehouses / stores in SAP Retail source system.'),
src_orig_store_nr BIGNUMERIC(38,0) OPTIONS(description='Techn. identifier of stores in WAWI source system.'),
src_orig_wh_nr BIGNUMERIC(38,0) OPTIONS(description='Techn. identifier of warehouses in WAWI source system.'),
src_store_id BIGNUMERIC(38,0) OPTIONS(description='Techn. identifier of stores in WAWI DWH (surrogate key).'),
src_wh_id BIGNUMERIC(38,0) OPTIONS(description='Techn. identifier of warehouses in WAWI DWH (surrogate key).'),
src_assoc_id STRING(100) COLLATE 'und:ci'
OPTIONS(description='Techn. identifier of warehouses in IMS source system: IMS_ESB: associations.association.id'),
loc_type_cd STRING(2) COLLATE 'und:ci'
OPTIONS(description='Code for the discriminator values for locations (store vs. warehouse).'),
loc_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='The number by which the store or warehouse is known to the business.'),
loc_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Name of the Organization / WH / Store (w/i Retail-System).'),
wh_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Name of the Organization / WH (w/i Immo-Mgmt-System); association.assoc_name'),
wh_add1_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Additional name part of the Organization / WH (w/i Immo-Mgmt-System); association.assoc_name2'),
wh_txt STRING(1000)
OPTIONS(description='Free text comment regarding Organization / WH (w/i Immo-Mgmt-System); association.comments'),
loc_status_cd STRING(5) COLLATE 'und:ci'
OPTIONS(description='A code for the status_1 of a location_1 (active, closed, ...).'),
country_pol_sid BIGNUMERIC(38,0)
OPTIONS(description='The surrogate key of the country_1 (political) in which the Organization / WH / Store is located.'),
country_pol_cd STRING(20)
OPTIONS(description='The code for the country_1 (political) in which the Organization / WH / Store is located.'),
opening_dt DATE OPTIONS(description='Opening-Date (Retail perspective)'),
real_opening_dt DATE OPTIONS(description='(deprecated) The real opening date. (only relevant for GB)'),
closing_dt DATE
OPTIONS(description='Closing-Date (Retail perspective); SAP-Retail: wrf1.schld; SAP-BW: 0rt_wrf1_attr.schld; ELWIS: t_s_loc_wrf1.close_dat'),
wh_store_mark STRING(20)
OPTIONS(description='(deprecated) Organization-Type - Code; SAP-Retail: t001w.vlfkz; SAP-BW: t_bw_0plant_attr.vlfkz'),
wh_store_label STRING(100) COLLATE 'und:ci'
OPTIONS(description='(deprecated) Organization-Type - Descr.: A = Store; B = Warehouse'),
storetype_mark STRING(20)
OPTIONS(description='(deprecated) Store-Type - Code; SAP-Retail: t001w.storetype; SAP-BW: t_bw_0plant_attr.storetype;'),
storetype_label STRING(100) COLLATE 'und:ci'
OPTIONS(description='(deprecated) Store-Type - Descr.: 0 = Filiale; 1 = Warenhaus; 2 = Shop'),
customer_cd STRING(20)
OPTIONS(description='(deprecated) Kundennummer des Betriebs / der Lokation; SAP-Retail: t001w.kunnr; SAP-BW: t_bw_0plant_attr.kunnr;'),
global_loc_ctry_cd STRING(20)
OPTIONS(description='(deprecated) Laendercode der Location_1; SAP-Retail: string_substring(t001w.zkebnr, 1, 2); SAP-BW: t_bw_0plant_attr.zkebnr;'),
global_loc_id STRING(20)
OPTIONS(description='(deprecated) Klarname - Werksnummer; SAP-Retail: t001w.zkebnr; SAP-BW: t_bw_0plant_attr.zkebnr;'),
global_loc_id_length BIGNUMERIC(38,0)
OPTIONS(description='(deprecated) Laenge der Werksnummer; SAP-Retail: string_length(t001w.zkebnr); SAP-BW: t_bw_0plant_attr.zkebnr;'),
global_loc_type_cd STRING(20)
OPTIONS(description='(deprecated) ; SAP-Retail: t001w.string_substring(t001w.zkebnr,3,1); SAP-BW: t_bw_0plant_attr.zkebnr; '),
loc_name2 STRING(100) COLLATE 'und:ci'
OPTIONS(description='Alternative name of the Organization / WH / Store; SAP-Retail: ?; SAP-BW: t_bw_0plant_text.txtmd;'),
loc_sid_successor_act BIGNUMERIC(38,0) OPTIONS(description='(deprecated) see t_location_hist.loc_sid_successor'),
longitude NUMERIC(9,6) OPTIONS(description='(deprecated) see t_address_1'),
latitude NUMERIC(9,6) OPTIONS(description='(deprecated) see t_address_1'),
sap_creation_wrf1_dt DATE
OPTIONS(description='(deprecated) (?) Datum, an dem der Satz in SAP-Retail-Tabelle WRF1_1 hinzugefuegt wurde; SAP-Retail: wrf1.erdat;'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. Stores and Warehouses (Organizational View - not the physical buildings).             Warehouses may represent Sales_1 Org. (VGES), Delivery Org. (BGES), Expansion Org., Owner Org., Balance Sheet Org., Country_1 Org.');
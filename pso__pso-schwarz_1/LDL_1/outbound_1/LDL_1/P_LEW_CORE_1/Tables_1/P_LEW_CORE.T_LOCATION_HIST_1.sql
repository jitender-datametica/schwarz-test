/* --------------------------------------------------------------------------------
   DDL for table: t_location_hist_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_location_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key LOCATION_1'),
loc_type_cd STRING(2) COLLATE 'und:ci'
OPTIONS(description='Code for the discriminator values for locations. (store vs. warehouse)'),
loc_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='The number by which the store or warehouse is known to business.'),
loc_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='name of the Organization/WH/Store (w/i Retail-System); SAP-Retail: t001w.name1; SAP-BW: t_bw_0plant_attr.name1'),
loc_status_cd STRING(5) COLLATE 'und:ci'
OPTIONS(description='A code for the status_1 of a location. (active, closed, ...)'),
wh_active_fg BIGNUMERIC(38,0) OPTIONS(description='indicating, whether Warehouse is active'),
closed_fg BIGNUMERIC(38,0) OPTIONS(description='An indicator showing, whether the store is closed.'),
test_store_fg BIGNUMERIC(38,0) OPTIONS(description='indicating, whether Store is a Test_1 Store'),
dummy_store_fg BIGNUMERIC(38,0)
OPTIONS(description='An indicator showing, if this store is classified as a dummy_1 store. (Dummy_1 stores are created either by the source or the load process and represent warehouses and countries. So ultimately, they should not be present in this table.)'),
template_store_fg BIGNUMERIC(38,0)
OPTIONS(description='An indicator showing, if this store is used as a template for new stores.'),
sales_wh_fg BIGNUMERIC(38,0)
OPTIONS(description='WH is Sales_1 WH ("Vertriebsgesellschaft (VGES)"); IMS_ESB: associations.association.is-sal (Vertriebsgesellschaft (VGES))'),
delivery_wh_fg BIGNUMERIC(38,0)
OPTIONS(description='WH is Delivery WH ("beliefernde Gesellschaft (BGES)"); IMS_ESB: associations.association.is-del (beliefernde Gesellschaft (BGES))'),
expansion_wh_fg BIGNUMERIC(38,0)
OPTIONS(description='WH is Expansion WH ("Expansionsgesellschaft"); IMS_ESB: associations.association.is-exp (Expansionsgesellschaft)'),
balance_sheet_wh_fg BIGNUMERIC(38,0)
OPTIONS(description='WH is Balance Sheet WH ("Bilanzgesellschaft"); IMS_ESB: associations.association.is-bal (Bilanzgesellschaft)'),
owner_wh_fg BIGNUMERIC(38,0)
OPTIONS(description='WH is Owner WH ("Eigentumsgesellschaft"); IMS_ESB: associations.association.is-owner (Eigentumsgesellschaft)'),
country_wh_fg BIGNUMERIC(38,0)
OPTIONS(description='WH is Country_1 WH ("Landesdienstleistung"); IMS_ESB: associations.association.is-cty (Landesdienstleistung)'),
opening_dt DATE
OPTIONS(description='Opening-Date (Retail perspective); SAP-Retail: wrf1.eroed; SAP-BW: 0rt_wrf1_attr.eroed;'),
real_opening_dt DATE
OPTIONS(description='The actual opening date. (This might be different from the planned opening date.)'),
closing_dt DATE
OPTIONS(description='Closing-Date (Retail perspective); SAP-Retail: wrf1.schld; SAP-BW: 0rt_wrf1_attr.schld; ELWIS: t_s_loc_wrf1.close_dat'),
addr_sid BIGNUMERIC(38,0) OPTIONS(description='address_1 of the Warehouse/Store;'),
global_location_nr STRING(13) COLLATE 'und:ci'
OPTIONS(description='A 13-digit number identifying a geographical location_1 or a legal entity. A global location_1 number (GLN) consists of a company prefix, a location_1 identifier and a check digit.'),
legal_entity_name STRING(100) COLLATE 'und:ci' OPTIONS(description='The official company name of this organizatation.'),
vat_ident_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='The VAT identification number of the warehouse. (Umsatzsteuer-Identifikationsnummer)'),
loc_sid_sales_wh BIGNUMERIC(38,0)
OPTIONS(description='assigned Sales_1 WH for the Store; IMS_ESB: loc_sid associated with the t_location.assoc_id (IMS_ESB: associations.association.id)'),
loc_sid_delivery_wh BIGNUMERIC(38,0)
OPTIONS(description='assigned Delivery WH for the Store; IMS_ESB: loc_sid associated with the t_location.assoc_id (IMS_ESB: associations.association.id)'),
loc_sid_expansion_wh BIGNUMERIC(38,0)
OPTIONS(description='assigned Expansion WH for the Store; IMS_ESB: loc_sid associated with the t_location.assoc_id (IMS_ESB: associations.association.id)'),
loc_sid_balance_sheet_wh BIGNUMERIC(38,0)
OPTIONS(description='assigned Balance Sheet WH for the Store; IMS_ESB: loc_sid associated with the t_location.assoc_id (IMS_ESB: associations.association.id)'),
loc_sid_owner_wh BIGNUMERIC(38,0)
OPTIONS(description='assigned Owner WH for the Store; IMS_ESB: IMS_ESB: loc_sid associated with the t_location.assoc_id (IMS_ESB: associations.association.id)'),
loc_sid_country_wh BIGNUMERIC(38,0)
OPTIONS(description='assigned Country_1 WH for the Store; IMS_ESB: loc_sid associated with the t_location.assoc_id (IMS_ESB: associations.association.id)'),
loc_sid_successor BIGNUMERIC(38,0)
OPTIONS(description='the succeeding Store/Warehouse, after the Store/Warehouse is closed'),
cost_center_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='The number of the cost center which is associated to this warehouse.'),
store_lang_cd STRING(2) COLLATE 'und:ci' OPTIONS(description='The ISO code of the language that is used in this store.'),
default_order_unit_fg BIGNUMERIC(38,0)
OPTIONS(description='Default Order Unit_1 is valid for this Store; T008_Store.C008_ORD_UNIT_DFLT'),
default_min_order_unit_fg BIGNUMERIC(38,0)
OPTIONS(description='globally defined minimum order quantity is valid for this Store; T008_STORE.C008_MIN_QTY_DFLT'),
order_buying_list_seq BIGNUMERIC(38,0)
OPTIONS(description='sort order on the buying list; Wawi source field: T010_Warehouse.C010_Order_EKList'),
sales_org_sid BIGNUMERIC(38,0)
OPTIONS(description='(deprecated) Verkaufsorganisation fur interne Verrechnung; FK auf SALES_1 ORG; SAP-Retail: t001w.VKORG'),
pur_org_sid BIGNUMERIC(38,0)
OPTIONS(description='(deprecated) Einkaufsorganisation; FK auf PURCHASE ORG; SAP-Retail: t001w.EKORG'),
bus_cal_cd STRING(20)
OPTIONS(description='(deprecated) Logistikkalenderschlussel; SAP-Retail: t001w.FABKL; Zielentitat noch nicht vorhanden'),
customer_district_cd STRING(20) OPTIONS(description='(deprecated) Kundenbezirk; SAP-Retail: t001w.BZIRK '),
region_cd STRING(20)
OPTIONS(description='(deprecated) Region_1 (Bundesstaat, Bundesland, Provinz, Grafschaft); SAP-Retail: t001w.REGIO'),
archive_fg BIGNUMERIC(38,0)
OPTIONS(description='(deprecated) Zentrale Archivierungsvormerkung fur Stammsatz; SAP-Retail: t001w.ACHVM'),
demand_plan_active_fg BIGNUMERIC(38,0)
OPTIONS(description='(deprecated) Aktivierung der Bedarfsplanung; SAP-Retail: t001w.BEDPL'),
distribution_channel_cd STRING(20)
OPTIONS(description='(deprecated) Vertriebsweg fur interne Verrechnung; SAP-Retail: t001w.VTWEG; ELWIS: sales_chn_id'),
assessment_area_cd STRING(20)
OPTIONS(description='(deprecated) Bewertungskreis; SAP-Retail: t001w.BWKEY; ELWIS: ases_area_id'),
division_cd STRING(20)
OPTIONS(description='(deprecated) Sparte fur interne Verrechnung; SAP-Retail: t001w.SPART; ELWIS: div_cd'),
mon_opening_tm TIME OPTIONS(description='The time when the stores opens on Mondays. E.g. 08:00; Time is in local time.'),
mon_closing_tm TIME
OPTIONS(description='The time when the stores closes on Mondays. E.g. 20:00; Time is in local time. In case the store is closed during lunch time, this is the final closing time in the evening.'),
mon_break_start_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the begin time of the break for a Monday.'),
mon_break_end_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the end time of the break for a Monday.'),
tue_opening_tm TIME
OPTIONS(description='The time when the stores opens on Tuesdays. E.g. 08:00; Time is in local time.'),
tue_closing_tm TIME
OPTIONS(description='The time when the stores closes on Tuesdays. E.g. 20:00; Time is in local time. In case the store is closed during lunch time, this is the final closing time in the evening.'),
tue_break_start_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the begin time of the break for a Tuesday.'),
tue_break_end_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the end time of the break for a Tuesday.'),
wed_opening_tm TIME
OPTIONS(description='The time when the stores opens on Wednesdays. E.g. 08:00; Time is in local time.'),
wed_closing_tm TIME
OPTIONS(description='The time when the stores closes on Wednesdays. E.g. 20:00; Time is in local time. In case the store is closed during lunch time, this is the final closing time in the evening.'),
wed_break_start_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the begin time of the break for a Wednesday.'),
wed_break_end_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the end time of the break for a Wednesday.'),
thu_opening_tm TIME
OPTIONS(description='The time when the stores opens on Thursdays. E.g. 08:00; Time is in local time.'),
thu_closing_tm TIME
OPTIONS(description='The time when the stores closes on Thursdays. E.g. 20:00; Time is in local time. In case the store is closed during lunch time, this is the final closing time in the evening.'),
thu_break_start_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the begin time of the break for a Thursday.'),
thu_break_end_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the end time of the break for a Thursday.'),
fri_opening_tm TIME OPTIONS(description='The time when the stores opens on Fridays. E.g. 08:00; Time is in local time.'),
fri_closing_tm TIME
OPTIONS(description='The time when the stores closes on Fridays. E.g. 20:00; Time is in local time. In case the store is closed during lunch time, this is the final closing time in the evening.'),
fri_break_start_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the begin time of the break for a Friday.'),
fri_break_end_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the end time of the break for a Friday.'),
sat_opening_tm TIME
OPTIONS(description='The time when the stores opens on Saturdays. E.g. 08:00; Time is in local time.'),
sat_closing_tm TIME
OPTIONS(description='The time when the stores closes on Saturdays. E.g. 20:00; Time is in local time. In case the store is closed during lunch time, this is the final closing time in the evening.'),
sat_break_start_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the begin time of the break for a Saturday.'),
sat_break_end_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the end time of the break for a Saturday.'),
sun_opening_tm TIME OPTIONS(description='The time when the stores opens on Sundays. E.g. 08:00; Time is in local time.'),
sun_closing_tm TIME
OPTIONS(description='The time when the stores closes on Sundays. E.g. 20:00; Time is in local time. In case the store is closed during lunch time, this is the final closing time in the evening.'),
sun_break_start_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the begin time of the break for a Sunday.'),
sun_break_end_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the end time of the break for a Sunday.'),
open_on_holidays_fg BIGNUMERIC(38,0)
OPTIONS(description='An indicator showing, if the store is open on public holidays.'),
opening_hours_per_week_cnt NUMERIC(9,5) OPTIONS(description='The total number of hours the store is open per week.'),
opening_hours_txt STRING(1000) COLLATE 'und:ci'
OPTIONS(description='A textual description of the opening hours of the store for each weekday.             E.g.: Monday: 08:00 - 21:00, Tuesday: 08:00:21:00, ...'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. Stores and Warehouses (Organizational View - not the physical buildings)             Warehouses may represent Sales_1 Org. (VGES), Delivery Org. (BGES), Expansion Org., Owner Org., Balance Sheet Org., Country_1 Org');
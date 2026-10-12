CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_political_region_1 (client_id
OPTIONS(description='Identifier of the ERP instance maintaining and providing the data'), pol_region_sid
OPTIONS(description='''Surrogate identifier of the main administrative reagion
WAWI: WAWI Instance and T1302_MAIN_REGIO_ID.C1302_MAIN_REGION_ID'''),
pol_region_nr
OPTIONS(description='''Identifier of the first level of the administrative hierarchy_1 in the political country_1 in the local WAWI instance
WAWI: T1302_MAIN_REGION.C1302_MAIN_REGION_ID'''),
country_pol_sid OPTIONS(description='''Foreign Key COUNTRY_1 POLITICAL
WAWI: T1302_MAIN_REGION.C1302_COUNTRYCODE'''),
pol_region_cd
OPTIONS(description='''Code of the first level of the administrative hierarchy_1 in the political country_1
WAWI: T1302_MAIN_REGION.C1302_SHORT_NAME'''),
pol_region_name
OPTIONS(description='''Name of the first level of the administrative hierarchy_1 in the political country_1
WAWI: T1302_MAIN_REGION.C1302_NAME'''),
dwh_load_id OPTIONS(description='Identifier of the last run which inserted or updated the record'), dwh_created
OPTIONS(description='Creation timestamp of the record in the DWH'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH'))
OPTIONS(DESCRIPTION = '''This table contains the first level of the administrative hierarchy_1 of political countries.
WAWI: T1302_MAIN_REGION''')
AS SELECT client_id,
 pol_region_sid,
 pol_region_nr,
 country_pol_sid,
 pol_region_cd,
 pol_region_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_political_region_1;
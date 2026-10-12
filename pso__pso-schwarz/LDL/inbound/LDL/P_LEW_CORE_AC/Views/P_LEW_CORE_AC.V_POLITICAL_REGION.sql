CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_POLITICAL_REGION (
   client_id                                COMMENT 'Identifier of the ERP instance maintaining and providing the data'
  ,pol_region_sid                           COMMENT 'Surrogate identifier of the main administrative reagion
WAWI: WAWI Instance and T1302_MAIN_REGIO_ID.C1302_MAIN_REGION_ID'
  ,pol_region_nr                            COMMENT 'Identifier of the first level of the administrative hierarchy in the political country in the local WAWI instance
WAWI: T1302_MAIN_REGION.C1302_MAIN_REGION_ID'
  ,country_pol_sid                          COMMENT 'Foreign Key COUNTRY POLITICAL
WAWI: T1302_MAIN_REGION.C1302_COUNTRYCODE'
  ,pol_region_cd                            COMMENT 'Code of the first level of the administrative hierarchy in the political country
WAWI: T1302_MAIN_REGION.C1302_SHORT_NAME'
  ,pol_region_name                          COMMENT 'Name of the first level of the administrative hierarchy in the political country
WAWI: T1302_MAIN_REGION.C1302_NAME'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH'
)
COMMENT = 'This table contains the first level of the administrative hierarchy of political countries.
WAWI: T1302_MAIN_REGION'
AS SELECT
   client_id
  ,pol_region_sid
  ,pol_region_nr
  ,country_pol_sid
  ,pol_region_cd
  ,pol_region_name
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_POLITICAL_REGION
;
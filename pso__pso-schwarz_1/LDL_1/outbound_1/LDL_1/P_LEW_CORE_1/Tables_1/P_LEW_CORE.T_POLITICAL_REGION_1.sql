/* --------------------------------------------------------------------------------
   DDL for table: t_political_region_1
   generated from Powerdesigner on Freitag, 26. Januar 2024 20:55:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_political_region_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the ERP instance maintaining and providing the data'),
pol_region_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate identifier of the main administrative reagion            WAWI: WAWI Instance and T1302_MAIN_REGIO_ID.C1302_MAIN_REGION_ID'),
pol_region_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the first level of the administrative hierarchy_1 in the political country_1 in the local WAWI instance            WAWI: T1302_MAIN_REGION.C1302_MAIN_REGION_ID'),
country_pol_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Foreign Key COUNTRY_1 POLITICAL            WAWI: T1302_MAIN_REGION.C1302_COUNTRYCODE'),
pol_region_cd STRING(100)
OPTIONS(description='Code of the first level of the administrative hierarchy_1 in the political country_1            WAWI: T1302_MAIN_REGION.C1302_SHORT_NAME'),
pol_region_name STRING(100) NOT NULL
OPTIONS(description='Name of the first level of the administrative hierarchy_1 in the political country_1            WAWI: T1302_MAIN_REGION.C1302_NAME'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH'),
PRIMARY KEY (pol_region_sid) NOT ENFORCED
)
OPTIONS(description='This table contains the first level of the administrative hierarchy_1 of political countries.             WAWI: T1302_MAIN_REGION');
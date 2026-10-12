/* --------------------------------------------------------------------------------
   DDL for table: t_political_region_1
   generated from Powerdesigner on Freitag, 26. Januar 2024 20:55:38
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_POLITICAL_REGION_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the ERP instance maintaining and providing the data',
   pol_region_sid                      NUMBER(38,0)     NOT NULL COMMENT 'Surrogate identifier of the main administrative reagion
            WAWI: WAWI Instance and T1302_MAIN_REGIO_ID.C1302_MAIN_REGION_ID',
   pol_region_nr                       VARCHAR(100)     NOT NULL COMMENT 'Identifier of the first level of the administrative hierarchy_1 in the political country_1 in the local WAWI instance
            WAWI: T1302_MAIN_REGION.C1302_MAIN_REGION_ID',
   country_pol_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key COUNTRY_1 POLITICAL
            WAWI: T1302_MAIN_REGION.C1302_COUNTRYCODE',
   pol_region_cd                       VARCHAR(100)     COMMENT 'Code of the first level of the administrative hierarchy_1 in the political country_1
            WAWI: T1302_MAIN_REGION.C1302_SHORT_NAME',
   pol_region_name                     VARCHAR(100)     NOT NULL COMMENT 'Name of the first level of the administrative hierarchy_1 in the political country_1
            WAWI: T1302_MAIN_REGION.C1302_NAME',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_POLITICAL_REGION PRIMARY KEY (pol_region_sid) NOT ENFORCED 
)  COMMENT = 'This table contains the first level of the administrative hierarchy_1 of political countries.
             WAWI: T1302_MAIN_REGION';

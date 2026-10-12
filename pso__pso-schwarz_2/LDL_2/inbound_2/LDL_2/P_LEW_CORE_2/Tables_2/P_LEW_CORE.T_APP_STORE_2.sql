/* --------------------------------------------------------------------------------
   DDL for table: t_app_store_2
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_APP_STORE_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   app_store_sid                       NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the app store (surrogate key)',
   app_store_nr                        VARCHAR(20)      COLLATE 'en-ci' COMMENT 'identifier of the app store (known to the business)',
   app_store_name                      VARCHAR(100)     COLLATE 'en-ci' COMMENT 'name of the app store',
   sales_channel_sid                   NUMBER(38,0)     COMMENT 'unique identifier of the sales_2 channel (in this case App-Store)',
   country_sid                         NUMBER(38,0)     COMMENT 'unique identifier of the country_2 for the which the app store serves (surrogate key)',
   country_cd                          VARCHAR(2)       COLLATE 'en-ci' COMMENT 'two letter code for the country_2 for which the app store serves',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_APP_STORE PRIMARY KEY (app_store_sid) NOT ENFORCED 
)  COMMENT = 'An App-Store is a place where app can be bought / sold / offered. An AppStore is a sales_2 channel for a retailer where it can offer its apps.';


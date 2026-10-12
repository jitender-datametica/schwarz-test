/* --------------------------------------------------------------------------------
   DDL for table: t_agg_app_store_events_per_day
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_AGG_APP_STORE_EVENTS_PER_DAY CLUSTER BY (
     CAL_DT,
     APP_STORE_SID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   app_sid                             NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the app (surrogate key)',
   app_store_sid                       NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the app store (surrogate key)',
   cal_dt                              DATE             NOT NULL COMMENT 'date, when the events happened',
   country_pol_sid                     NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the Country in which the events happened, i.e. where the user had been when he/she downloaded, uninstalled, etc.',
   country_pol_cd                      VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'code identifier of the Country in which the events happened, i.e. where the user had been when he/she downloaded, uninstalled, etc.',
   download_cnt                        NUMBER(38,0)     COMMENT 'how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before ',
   redownload_cnt                      NUMBER(38,0)     COMMENT 'how often the app was downloaded again, after the customer had deinstalled the app',
   update_cnt                          NUMBER(38,0)     COMMENT 'how often the app was updated',
   uninstall_cnt                       NUMBER(38,0)     COMMENT 'how often the app was uninstalled',
   return_cnt                          NUMBER(38,0)     COMMENT 'how often the app was “returned” (only relevant for apps that the customer needs to pay for)',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_AGG_APP_STORE_EVENTS_PER_DAY PRIMARY KEY (cal_dt, country_pol_sid, app_sid, app_store_sid) NOT ENFORCED 
)  COMMENT = 'The aggregate summarizes certain KPIs that track the performance of an app.';


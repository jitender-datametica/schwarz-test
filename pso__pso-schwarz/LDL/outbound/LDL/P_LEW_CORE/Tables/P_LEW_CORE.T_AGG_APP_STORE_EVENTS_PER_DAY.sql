/* --------------------------------------------------------------------------------
   DDL for table: t_agg_app_store_events_per_day
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_agg_app_store_events_per_day (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
app_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the app (surrogate key)'),
app_store_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the app store (surrogate key)'),
cal_dt DATE NOT NULL OPTIONS(description='date, when the events happened'),
country_pol_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='unique identifier of the Country in which the events happened, i.e. where the user had been when he/she downloaded, uninstalled, etc.'),
country_pol_cd STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='code identifier of the Country in which the events happened, i.e. where the user had been when he/she downloaded, uninstalled, etc.'),
download_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded by a customer for the first time, i.e. the customer did not download it before '),
redownload_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was downloaded again, after the customer had deinstalled the app'),
update_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was updated'),
uninstall_cnt BIGNUMERIC(38,0) OPTIONS(description='how often the app was uninstalled'),
return_cnt BIGNUMERIC(38,0)
OPTIONS(description='how often the app was “returned” (only relevant for apps that the customer needs to pay for)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cal_dt, country_pol_sid, app_sid, app_store_sid) NOT ENFORCED
) CLUSTER BY cal_dt, app_store_sid
OPTIONS(description='The aggregate summarizes certain KPIs that track the performance of an app.');
/* --------------------------------------------------------------------------------
   DDL for table: t_app_store_2
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_app_store_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
app_store_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the app store (surrogate key)'),
app_store_nr STRING(20) COLLATE 'und:ci' OPTIONS(description='identifier of the app store (known to the business)'),
app_store_name STRING(100) COLLATE 'und:ci' OPTIONS(description='name of the app store'),
sales_channel_sid BIGNUMERIC(38,0)
OPTIONS(description='unique identifier of the sales_2 channel (in this case App-Store)'),
country_sid BIGNUMERIC(38,0)
OPTIONS(description='unique identifier of the country_2 for the which the app store serves (surrogate key)'),
country_cd STRING(2) COLLATE 'und:ci'
OPTIONS(description='two letter code for the country_2 for which the app store serves'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (app_store_sid) NOT ENFORCED
)
OPTIONS(description='An App-Store is a place where app can be bought / sold / offered. An AppStore is a sales_2 channel for a retailer where it can offer its apps.');
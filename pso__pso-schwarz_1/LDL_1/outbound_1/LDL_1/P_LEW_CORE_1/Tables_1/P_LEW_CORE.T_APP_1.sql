/* --------------------------------------------------------------------------------
   DDL for table: t_app_1
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_app_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
app_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the app (surrogate key)'),
app_name STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (app_sid) NOT ENFORCED
)
OPTIONS(description='An app is a software application designed to run on a mobile device such as a phone, tablet, or watch. Apps are generally downloaded from application distribution platforms which are operated by the owner of the mobile operating system, such as the App Store (iOS) or Google Play Store. Some apps are free, and others have a price.');
/* --------------------------------------------------------------------------------
   DDL for table: t_app_version_1
   generated from Powerdesigner on Tuesday, January 28, 2025 1:44:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_app_version_1 (
app_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The app SID is the identification of the app used, for example Lidl Plus.'),
app_version_os_nr STRING(100) NOT NULL
OPTIONS(description='The app version OS is the name of the operating system that the app can be installed on, i.e. iOS, Android.'),
app_version_nr STRING(100) NOT NULL
OPTIONS(description='The app version is the technical version of the app for a particular OS.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (app_sid, app_version_os_nr, app_version_nr) NOT ENFORCED
)
OPTIONS(description='An App version is defined by: App, OS and version number. An app version is the software application differentiated by the OS it is running on and the technical version on this OS.');
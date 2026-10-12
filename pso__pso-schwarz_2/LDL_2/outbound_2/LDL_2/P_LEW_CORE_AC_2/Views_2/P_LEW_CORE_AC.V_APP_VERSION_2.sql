CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_app_version_2 (app_sid
OPTIONS(description='The app SID is the identification of the app used, for example Lidl Plus.'), app_version_os_nr
OPTIONS(description='The app version OS is the name of the operating system that the app can be installed on, i.e. iOS, Android.'),
app_version_nr OPTIONS(description='The app version is the technical version of the app for a particular OS.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `AN APP VERSION IS DEFINED BY: APP, OS AND VERSION NUMBER. AN APP VERSION IS THE SOFTWARE APPLICATION DIFFERENTIATED BY THE OS IT IS RUNNING ON AND THE TECHNICAL VERSION ON THIS OS.`)
AS SELECT app_sid,
 app_version_os_nr,
 app_version_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_app_version_2;
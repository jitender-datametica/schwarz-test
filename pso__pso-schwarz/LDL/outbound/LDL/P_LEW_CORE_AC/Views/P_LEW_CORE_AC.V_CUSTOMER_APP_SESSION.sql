CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_app_session (app_session_sid
OPTIONS(description='Unique identifier (Surrogate Key) of the session.'), customer_sid
OPTIONS(description='Unique identifier of the customer (surrogate key). Derived from customer_id.'), src_app_session_id
OPTIONS(description='The app session ID is part of the technical identifier of sessions in the source system Firebase, source: ga_sesion_id.'),
app_sid OPTIONS(description='The app SID is the identification of the app used, for example Lidl Plus.'),
app_version_os_nr
OPTIONS(description='The app version OS is the name of the operating system that the app can be installed on, i.e. iOS, Android.'),
app_version_nr OPTIONS(description='The app version is the technical version of the app for a particular OS.'),
app_session_start_tmsp OPTIONS(description='Timestamp when the session started.'), app_session_end_tmsp
OPTIONS(description='Timestamp when the session ended.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `A CUSTOMER APP-SESSION IS A PROLONGED BUT NOT NECESSARILY CONTINUOUS CUSTOMER INTERACTION WITH THEIR APP. A NEW SESSION STARTS AFTER A TIME GAP GREATER THAN THE THRESHOLD OF 30 MINUTES BETWEEN THE PREVIOUS ONE (IF IT EXISTS). ONE SESSION CAN BE DIVIDED INTO MANY ACTIVITY PHASES THAT ARE SEPARATED BY A TIME GAP GREATER THAN 5 MINUTES OR 300 SECONDS. A CUSTOMER APP-SESSION IS IDENTIFIED VIA THE COMBINATION OF CUSTOMER_SID (DERIVED FROM CUSTOMER_ID) AND SESSION_ID. `)
AS SELECT app_session_sid,
 customer_sid,
 src_app_session_id,
 app_sid,
 app_version_os_nr,
 app_version_nr,
 app_session_start_tmsp,
 app_session_end_tmsp,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_app_session;
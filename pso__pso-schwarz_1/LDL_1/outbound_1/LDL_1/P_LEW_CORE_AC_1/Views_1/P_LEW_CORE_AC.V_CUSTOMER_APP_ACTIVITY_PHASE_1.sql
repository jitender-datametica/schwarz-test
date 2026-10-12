CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_app_activity_phase_1 (app_activity_phase_sid
OPTIONS(description='Unique identifier of a customer activity phase (surrogate key).'), customer_sid
OPTIONS(description='Unique identifier of the customer (surrogate key). Derived from customer_id.'), src_app_session_id
OPTIONS(description='The app session ID is part of the technical identifier of sessions in the source system Firebase, source: ga_sesion_id.'),
src_app_activity_phase_id
OPTIONS(description='Technical sequence of subsessions inside a session and day. It resets if a subsequent activity phase starts on a new day (from 00:00:00).'),
app_activity_phase_start_dt
OPTIONS(description='Date when the customer app activity phase started. Can change if a session lasts into the next day.'),
app_activity_phase_seq
OPTIONS(description='Logical sequence of the activity phases inside a session. Turns technical subsessions that restart on a new day into a sequence which orders activity phases by occurence, independent of a change in the day.'),
app_session_sid
OPTIONS(description='Unique identifier (Surrogate Key) of the session that the activity_phase belongs to'), app_sid
OPTIONS(description='The app SID is the identification of the app used, for example Lidl Plus.'), app_version_os_nr
OPTIONS(description='The app version OS is the name of the operating system that the app can be installed on, i.e. iOS, Android.'),
app_version_nr OPTIONS(description='The app version is the technical version of the app for a particular OS.'),
first_known_geo_area_sid
OPTIONS(description='Unique identifier of the geographical area (surrogate key). The first recorded geo area during a set of events in the activity phase. A customer app activity phase can have zero to many geo areas associated to it.'),
first_known_geo_area_cd
OPTIONS(description='Code of the first known geographical area in an activity phase. A customer app activity phase can have zero to many geo areas associated to it.'),
app_activity_phase_start_tmsp OPTIONS(description='Timestamp of when the activity phase started.'),
app_activity_phase_end_tmsp OPTIONS(description='Timestamp of when the activity phase ended.'),
app_activity_phase_sec_meas OPTIONS(description='Measured duration of an activity phase in seconds.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `A CUSTOMER APP-SESSION ACTIVITY PHASE IS A CUSTOMER INTERACTION WITH AN APP THAT CAN ONLY BE INTERRUPTED FOR UP TO 300 SECONDS. DIFFERENT ACTIVITY PHASES ARE DIVIDED BY A TIME GAP GREATER THAN THE THRESHOLD OF 300 SECONDS AND LESS THAN 30 MINUTES, AFTER WHICH A NEW SESSION WOULD START. A CUSTOMER APP-SESSION GROUPS THIS SET OF CONSECUTIVE INTERACTIONS.`)
AS SELECT app_activity_phase_sid,
 customer_sid,
 src_app_session_id,
 src_app_activity_phase_id,
 app_activity_phase_start_dt,
 app_activity_phase_seq,
 app_session_sid,
 app_sid,
 app_version_os_nr,
 app_version_nr,
 first_known_geo_area_sid,
 first_known_geo_area_cd,
 app_activity_phase_start_tmsp,
 app_activity_phase_end_tmsp,
 app_activity_phase_sec_meas,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_app_activity_phase_1;
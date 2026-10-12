/* --------------------------------------------------------------------------------
   DDL for table: t_customer_app_activity_phase_2
   generated from Powerdesigner on Tuesday, January 28, 2025 1:42:25 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_app_activity_phase_2 (
app_activity_phase_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of a customer activity phase (surrogate key).'),
customer_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of the customer (surrogate key). Derived from customer_id.'),
src_app_session_id BIGNUMERIC(38,0)
OPTIONS(description='The app session ID is part of the technical identifier of sessions in the source system Firebase, source: ga_sesion_id.'),
src_app_activity_phase_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Technical sequence of subsessions inside a session and day. It resets if a subsequent activity phase starts on a new day (from 00:00:00).'),
app_activity_phase_start_dt DATE NOT NULL
OPTIONS(description='Date when the customer app activity phase started. Can change if a session lasts into the next day.'),
app_activity_phase_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Logical sequence of the activity phases inside a session. Turns technical subsessions that restart on a new day into a sequence which orders activity phases by occurence, independent of a change in the day.'),
app_session_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier (Surrogate Key) of the session that the activity_phase belongs to'),
app_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The app SID is the identification of the app used, for example Lidl Plus.'),
app_version_os_nr STRING(100)
OPTIONS(description='The app version OS is the name of the operating system that the app can be installed on, i.e. iOS, Android.'),
app_version_nr STRING(100)
OPTIONS(description='The app version is the technical version of the app for a particular OS.'),
first_known_geo_area_sid BIGNUMERIC(38,0)
OPTIONS(description='Unique identifier of the geographical area (surrogate key). The first recorded geo area during a set of events in the activity phase. A customer app activity phase can have zero to many geo areas associated to it.'),
first_known_geo_area_cd STRING(5) COLLATE 'und:ci'
OPTIONS(description='Code of the first known geographical area in an activity phase. A customer app activity phase can have zero to many geo areas associated to it.'),
app_activity_phase_start_tmsp DATETIME NOT NULL OPTIONS(description='Timestamp of when the activity phase started.'),
app_activity_phase_end_tmsp DATETIME NOT NULL OPTIONS(description='Timestamp of when the activity phase ended.'),
app_activity_phase_sec_meas BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Measured duration of an activity phase in seconds.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (app_activity_phase_sid) NOT ENFORCED
) CLUSTER BY app_activity_phase_start_dt
OPTIONS(description='A customer app-session activity phase is a customer interaction with an app that can only be interrupted for up to 300 seconds. Different activity phases are divided by a time gap greater than the threshold of 300 seconds and less than 30 minutes, after which a new session would start. A customer app-session groups this set of consecutive interactions.');
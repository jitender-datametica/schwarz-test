CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CUSTOMER_APP_ACTIVITY_PHASE_2 (
   app_activity_phase_sid                   COMMENT 'Unique identifier of a customer activity phase (surrogate key).'
  ,customer_sid                             COMMENT 'Unique identifier of the customer (surrogate key). Derived from customer_id.'
  ,src_app_session_id                       COMMENT 'The app session ID is part of the technical identifier of sessions in the source system Firebase, source: ga_sesion_id.'
  ,src_app_activity_phase_id                COMMENT 'Technical sequence of subsessions inside a session and day. It resets if a subsequent activity phase starts on a new day (from 00:00:00).'
  ,app_activity_phase_start_dt              COMMENT 'Date when the customer app activity phase started. Can change if a session lasts into the next day.'
  ,app_activity_phase_seq                   COMMENT 'Logical sequence of the activity phases inside a session. Turns technical subsessions that restart on a new day into a sequence which orders activity phases by occurence, independent of a change in the day.'
  ,app_session_sid                          COMMENT 'Unique identifier (Surrogate Key) of the session that the activity_phase belongs to'
  ,app_sid                                  COMMENT 'The app SID is the identification of the app used, for example Lidl Plus.'
  ,app_version_os_nr                        COMMENT 'The app version OS is the name of the operating system that the app can be installed on, i.e. iOS, Android.'
  ,app_version_nr                           COMMENT 'The app version is the technical version of the app for a particular OS.'
  ,first_known_geo_area_sid                 COMMENT 'Unique identifier of the geographical area (surrogate key). The first recorded geo area during a set of events in the activity phase. A customer app activity phase can have zero to many geo areas associated to it.'
  ,first_known_geo_area_cd                  COMMENT 'Code of the first known geographical area in an activity phase. A customer app activity phase can have zero to many geo areas associated to it.'
  ,app_activity_phase_start_tmsp            COMMENT 'Timestamp of when the activity phase started.'
  ,app_activity_phase_end_tmsp              COMMENT 'Timestamp of when the activity phase ended.'
  ,app_activity_phase_sec_meas              COMMENT 'Measured duration of an activity phase in seconds.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'A customer app-session activity phase is a customer interaction with an app that can only be interrupted for up to 300 seconds. Different activity phases are divided by a time gap greater than the threshold of 300 seconds and less than 30 minutes, after which a new session would start. A customer app-session groups this set of consecutive interactions.'
AS SELECT 
   app_activity_phase_sid
  ,customer_sid
  ,src_app_session_id
  ,src_app_activity_phase_id
  ,app_activity_phase_start_dt
  ,app_activity_phase_seq
  ,app_session_sid
  ,app_sid
  ,app_version_os_nr
  ,app_version_nr
  ,first_known_geo_area_sid
  ,first_known_geo_area_cd
  ,app_activity_phase_start_tmsp
  ,app_activity_phase_end_tmsp
  ,app_activity_phase_sec_meas
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_CUSTOMER_APP_ACTIVITY_PHASE_2
;
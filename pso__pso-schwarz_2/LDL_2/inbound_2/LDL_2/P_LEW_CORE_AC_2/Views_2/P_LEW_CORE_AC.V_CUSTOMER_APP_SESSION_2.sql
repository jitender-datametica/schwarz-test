CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CUSTOMER_APP_SESSION_2 (
   app_session_sid                          COMMENT 'Unique identifier (Surrogate Key) of the session.'
  ,customer_sid                             COMMENT 'Unique identifier of the customer (surrogate key). Derived from customer_id.'
  ,src_app_session_id                       COMMENT 'The app session ID is part of the technical identifier of sessions in the source system Firebase, source: ga_sesion_id.'
  ,app_sid                                  COMMENT 'The app SID is the identification of the app used, for example Lidl Plus.'
  ,app_version_os_nr                        COMMENT 'The app version OS is the name of the operating system that the app can be installed on, i.e. iOS, Android.'
  ,app_version_nr                           COMMENT 'The app version is the technical version of the app for a particular OS.'
  ,app_session_start_tmsp                   COMMENT 'Timestamp when the session started.'
  ,app_session_end_tmsp                     COMMENT 'Timestamp when the session ended.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'A customer app-session is a prolonged but not necessarily continuous customer interaction with their app. A new session starts after a time gap greater than the threshold of 30 minutes between the previous one (if it exists). One session can be divided into many activity phases that are separated by a time gap greater than 5 minutes or 300 seconds. A customer app-session is identified via the combination of customer_sid (derived from customer_id) and session_id. '
AS SELECT 
   app_session_sid
  ,customer_sid
  ,src_app_session_id
  ,app_sid
  ,app_version_os_nr
  ,app_version_nr
  ,app_session_start_tmsp
  ,app_session_end_tmsp
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_CUSTOMER_APP_SESSION_2
;
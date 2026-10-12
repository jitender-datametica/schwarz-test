/* --------------------------------------------------------------------------------
   DDL for table: t_customer_app_session_1
   generated from Powerdesigner on Tuesday, January 28, 2025 1:43:20 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CUSTOMER_APP_SESSION_1 CLUSTER BY (TO_DATE(APP_SESSION_START_TMSP)) (
   app_session_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Unique identifier (Surrogate Key) of the session.',
   customer_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Unique identifier of the customer (surrogate key). Derived from customer_id.',
   src_app_session_id                  NUMBER(38,0)     COMMENT 'The app session ID is part of the technical identifier of sessions in the source system Firebase, source: ga_sesion_id.',
   app_sid                             NUMBER(38,0)     NOT NULL COMMENT 'The app SID is the identification of the app used, for example Lidl Plus.',
   app_version_os_nr                   VARCHAR(100)     COMMENT 'The app version OS is the name of the operating system that the app can be installed on, i.e. iOS, Android.',
   app_version_nr                      VARCHAR(100)     COMMENT 'The app version is the technical version of the app for a particular OS.',
   app_session_start_tmsp              TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp when the session started.',
   app_session_end_tmsp                TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp when the session ended.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CUSTOMER_APP_SESSION PRIMARY KEY (app_session_sid) NOT ENFORCED
)  COMMENT = 'A customer app-session is a prolonged but not necessarily continuous customer interaction with their app. A new session starts after a time gap greater than the threshold of 30 minutes between the previous one (if it exists). One session can be divided into many activity phases that are separated by a time gap greater than 5 minutes or 300 seconds. A customer app-session is identified via the combination of customer_sid (derived from customer_id) and session_id. ';

/* --------------------------------------------------------------------------------
   DDL for table: t_app_version
   generated from Powerdesigner on Tuesday, January 28, 2025 1:44:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_APP_VERSION (
   app_sid                             NUMBER(38,0)     NOT NULL COMMENT 'The app SID is the identification of the app used, for example Lidl Plus.',
   app_version_os_nr                   VARCHAR(100)     NOT NULL COMMENT 'The app version OS is the name of the operating system that the app can be installed on, i.e. iOS, Android.',
   app_version_nr                      VARCHAR(100)     NOT NULL COMMENT 'The app version is the technical version of the app for a particular OS.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_APP_VERSION PRIMARY KEY (app_sid, app_version_os_nr, app_version_nr) NOT ENFORCED
)  COMMENT = 'An App version is defined by: App, OS and version number. An app version is the software application differentiated by the OS it is running on and the technical version on this OS.';

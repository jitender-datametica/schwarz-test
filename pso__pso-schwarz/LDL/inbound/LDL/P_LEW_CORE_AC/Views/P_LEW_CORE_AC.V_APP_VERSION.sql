CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_APP_VERSION (
   app_sid                                  COMMENT 'The app SID is the identification of the app used, for example Lidl Plus.'
  ,app_version_os_nr                        COMMENT 'The app version OS is the name of the operating system that the app can be installed on, i.e. iOS, Android.'
  ,app_version_nr                           COMMENT 'The app version is the technical version of the app for a particular OS.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'An App version is defined by: App, OS and version number. An app version is the software application differentiated by the OS it is running on and the technical version on this OS.'
AS SELECT 
   app_sid
  ,app_version_os_nr
  ,app_version_nr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_APP_VERSION
;
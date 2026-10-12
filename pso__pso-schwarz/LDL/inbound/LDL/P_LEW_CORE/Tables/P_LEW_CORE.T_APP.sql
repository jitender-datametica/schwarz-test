/* --------------------------------------------------------------------------------
   DDL for table: t_app
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_APP (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   app_sid                             NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the app (surrogate key)',
   app_name                            VARCHAR(100)     COLLATE 'en-ci',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_APP PRIMARY KEY (app_sid) NOT ENFORCED 
)  COMMENT = 'An app is a software application designed to run on a mobile device such as a phone, tablet, or watch. Apps are generally downloaded from application distribution platforms which are operated by the owner of the mobile operating system, such as the App Store (iOS) or Google Play Store. Some apps are free, and others have a price.';


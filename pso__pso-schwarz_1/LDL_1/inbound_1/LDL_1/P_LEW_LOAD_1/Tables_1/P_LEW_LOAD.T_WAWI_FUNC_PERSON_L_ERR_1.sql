CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_FUNC_PERSON_L_ERR_1
(
  COUNTRY_ISO_CD        VARCHAR(3) COLLATE 'en-ci'    NOT NULL   COMMENT 'Landeskürzel',
  WH_ID                 VARCHAR(3) COLLATE 'en-ci'    NOT NULL   COMMENT 'Gesellschafts-Nummer',
  ORIG_STORE_NR         NUMBER(38)                    NOT NULL   COMMENT 'Fachlicher Schlüssel des Stores',
  SALES_MANAGER_ID      NUMBER(38)                    NOT NULL   COMMENT 'Bezirksleiter-Nr.',
  SALES_MANAGER_NAME    VARCHAR(50) COLLATE 'en-ci'   NULL       COMMENT 'Bezirksleiter-Name',
  ACCOUNT_MANAGER_ID    NUMBER(38)                    NOT NULL   COMMENT 'Vertriebsleiter-Nr.',
  ACCOUNT_MANAGER_NAME  VARCHAR(50) COLLATE 'en-ci'   NULL       COMMENT 'Vertriebsleiter-Name',
  STORE_MANAGER_ID      NUMBER(38)                    NOT NULL   COMMENT 'Store-Manager - ID; WAWI: store_manager_id',
  STORE_MANAGER_NAME    VARCHAR(50) COLLATE 'en-ci'   NULL       COMMENT 'Store-Manager - Name; WAWI: store_manager_name',
  ORGANISATION_ID       NUMBER(38)                    NOT NULL   COMMENT 'Organisation - ID; WAWI: organisation_id',
  GENERAL_MANAGER_ID    VARCHAR(9) COLLATE 'en-ci'    NOT NULL   COMMENT 'General-Manager - ID; WAWI: general_manager_id',
  GENERAL_MANAGER_NAME  VARCHAR(32) COLLATE 'en-ci'   NULL       COMMENT 'General-Manager - Name; WAWI: general_manager_name',
  DISTRICT_ID           VARCHAR(200) COLLATE 'en-ci'  NOT NULL   COMMENT 'district_id',
  DAT_VALID_FROM        DATE                          NOT NULL   COMMENT 'Gultigkeitsbeginn der Artikelnummer (WAWI)',
  DAT_VALID_UNTIL       DATE                          NULL       COMMENT 'Gültig bis, wird vom Vorsystem Wawi geliefert',
  DAT_DAYEND            DATE                          NULL       COMMENT 'Tagesabschlussdatum dayend date from file',
  LOAD_ID               NUMBER(38)                    NOT NULL   COMMENT 'ID der Transformation',
  DWH_UPDATED           TIMESTAMP_NTZ(6)              NOT NULL   COMMENT 'Datawarehouse aktualisiertes Datum'
);
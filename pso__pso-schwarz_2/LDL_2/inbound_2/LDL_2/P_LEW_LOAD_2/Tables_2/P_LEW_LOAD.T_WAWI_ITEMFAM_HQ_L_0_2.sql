CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEMFAM_HQ_L_0_2
(
  COUNTRY_ISO_CD          VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  ITEM_FAMILYGROUP_ID     NUMBER(38)                    NOT NULL,
  SUBITEMGROUP_ID         NUMBER(38)                    NOT NULL,
  MAINITEMGROUP_ID        NUMBER(38)                    NOT NULL,
  FAMILY_CD               NUMBER(38)                    NOT NULL,
  ITEM_FAMILY_DESC        VARCHAR(120) COLLATE 'en-ci'  NOT NULL,
  ITEM_FAMILY_SHORT_DESC  VARCHAR(15) COLLATE 'en-ci'   NULL,
  DAT_DAYEND              DATE                          NULL,
  LOAD_ID                 NUMBER(38)                    NULL,
  DC_SERVER_ID            NUMBER(38)                    NOT NULL,
  BIC_ZMLILA              VARCHAR(20)                   NULL,
  EXTRACTION_TS           TIMESTAMP_NTZ(6)              NULL,
  RECORD_ID               NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM           VARCHAR(20) COLLATE 'en-ci'   NULL
);
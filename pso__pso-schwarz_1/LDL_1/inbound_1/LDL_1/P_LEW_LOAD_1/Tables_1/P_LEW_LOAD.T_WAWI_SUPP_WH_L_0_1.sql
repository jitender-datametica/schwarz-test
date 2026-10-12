CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUPP_WH_L_0_1
(
  COUNTRY_ISO_CD    VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID             VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  ORIG_SUPPLIER_NR  VARCHAR(7) COLLATE 'en-ci'    NOT NULL,
  DISPO_INFO        VARCHAR(254) COLLATE 'en-ci'  NULL,
  FAX               VARCHAR(35) COLLATE 'en-ci'   NULL,
  NAME_CONT_PERSON  VARCHAR(35) COLLATE 'en-ci'   NULL,
  PHONE             VARCHAR(35) COLLATE 'en-ci'   NULL,
  FAX_CONTACT_FG    NUMBER(1,0)                   NULL,
  DAT_DAYEND        DATE                          NULL,
  LOAD_ID           NUMBER(38)                    NULL,
  DC_SERVER_ID      NUMBER(38)                    NOT NULL,
  BIC_ZMLILA        VARCHAR(20)                   NULL,
  EXTRACTION_DATE   DATE                          NULL,
  EXTRACTION_TS     TIMESTAMP_NTZ(6)              NULL,
  RECORD_ID         NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM     VARCHAR(20) COLLATE 'en-ci'   NULL
);
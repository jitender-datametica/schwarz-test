CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_DISCOUNTS_HQ_L_0
(
  COUNTRY_ISO_CD            VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                  VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  DISCOUNT_NR_WAWI          NUMBER(38)                    NOT NULL,
  DAT_VALID_FROM            DATE                          NOT NULL,
  DAT_VALID_UNTIL           DATE                          NOT NULL,
  DISCOUNT_DESC             VARCHAR(50) COLLATE 'en-ci'   NOT NULL,
  DISCOUNT_TYPE_ID          NUMBER(38)                    NOT NULL,
  DISCOUNT_BOOKING_TYPE_ID  NUMBER(38)                    NOT NULL,
  DAT_LAST_EXPORT           TIMESTAMP_NTZ(0)              NULL,
  DAT_STORNO                TIMESTAMP_NTZ(0)              NULL,
  DAT_DAYEND                DATE                          NOT NULL,
  LOAD_ID                   NUMBER(38)                    NOT NULL,
  DC_SERVER_ID              NUMBER(38)                    NOT NULL,
  BIC_ZMLILA                VARCHAR(20)                   NULL,
  EXTRACTION_TS             TIMESTAMP_NTZ(6)              NULL,
  RECORD_ID                 NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM             VARCHAR(20) COLLATE 'en-ci'   NULL
);
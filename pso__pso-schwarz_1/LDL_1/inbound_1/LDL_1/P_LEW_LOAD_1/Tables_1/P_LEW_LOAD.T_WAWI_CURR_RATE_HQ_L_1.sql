CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_CURR_RATE_HQ_L_1
(
  COUNTRY_ISO_CD          VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  CURRENCY_NR             NUMBER(3,0)                   NOT NULL,
  DAT_VALID_FROM          DATE                          NOT NULL,
  UNIT_CURRENCY_EXCHANGE  NUMBER(6,2)                   NOT NULL,
  RATE_CURRENCY_EXCHANGE  NUMBER(18,4)                  NULL,
  FILE_NAME               VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  TIMESTAMP_FN            TIMESTAMP_NTZ(0)              NOT NULL,
  DAT_DAYEND              DATE                          NOT NULL,
  LOAD_ID                 NUMBER(38)                    NOT NULL
);
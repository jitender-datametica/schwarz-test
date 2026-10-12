CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUPP_VAT_HQ_L
(
  COUNTRY_ISO_CD        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ              VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  ORIG_SUPPLIER_NR      VARCHAR(7) COLLATE 'en-ci'    NOT NULL,
  VAT_IDENT_NR          VARCHAR(20) COLLATE 'en-ci'   NOT NULL,
  SUPPLIER_CATEGORY_ID  VARCHAR(25) COLLATE 'en-ci'   NULL,
  DAT_MODIFICATION      DATE                          NULL,
  FILE_NAME             VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  TIMESTAMP_FN          TIMESTAMP_NTZ(0)              NOT NULL,
  DAT_DAYEND            DATE                          NOT NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL
);
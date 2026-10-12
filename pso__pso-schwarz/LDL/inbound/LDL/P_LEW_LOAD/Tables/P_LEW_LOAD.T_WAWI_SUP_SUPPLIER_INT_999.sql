CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUP_SUPPLIER_INT_999
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  SUP_SID_INT       VARCHAR(10) COLLATE 'en-ci'   NOT NULL,
  SUP_SID           NUMBER(38)                    NOT NULL,
  DAT_REC_START     DATE                          NOT NULL,
  DAT_REC_END       DATE                          NOT NULL,
  SUPPLIER_DESC_INT VARCHAR(50) COLLATE 'en-ci'   NULL,
  LANGUAGE_ID       NUMBER(38)                    NOT NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);
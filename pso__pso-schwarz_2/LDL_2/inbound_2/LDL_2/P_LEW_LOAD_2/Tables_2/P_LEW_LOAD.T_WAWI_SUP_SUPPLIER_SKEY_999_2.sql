CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUP_SUPPLIER_SKEY_999_2
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  SUP_SID           NUMBER(38)                    NOT NULL,
  DAT_REC_START     DATE                          NOT NULL,
  DAT_REC_END       DATE                          NOT NULL,
  ORIG_SUPPLIER_NR  VARCHAR(7) COLLATE 'en-ci'    NOT NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);
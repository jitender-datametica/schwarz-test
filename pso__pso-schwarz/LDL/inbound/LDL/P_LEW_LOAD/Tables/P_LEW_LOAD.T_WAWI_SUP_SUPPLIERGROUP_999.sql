CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUP_SUPPLIERGROUP_999
(
  CLIENT_ID           NUMBER(38)                    NOT NULL,
  SUPPLIERGROUP_ID    NUMBER(38)                    NOT NULL,
  DAT_REC_START       DATE                          NOT NULL,
  DAT_REC_END         DATE                          NOT NULL,
  SUPPLIERGROUP_DESC  VARCHAR(35) COLLATE 'en-ci'   NOT NULL,
  LANGUAGE_ID         NUMBER(38)                    NOT NULL,
  LOAD_ID             NUMBER(38)                    NOT NULL
);
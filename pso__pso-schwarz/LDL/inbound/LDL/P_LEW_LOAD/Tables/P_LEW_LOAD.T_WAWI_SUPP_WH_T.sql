CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUPP_WH_T
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  WH_LOC_SID        NUMBER(38)                    NOT NULL,
  SUP_SID           NUMBER(38)                    NOT NULL,
  DAT_REC_START     DATE                          NOT NULL,
  DAT_REC_END       DATE                          NOT NULL,
  DISPO_INFO        VARCHAR(254) COLLATE 'en-ci'  NULL,
  FAX               VARCHAR(35) COLLATE 'en-ci'   NULL,
  PHONE             VARCHAR(50) COLLATE 'en-ci'   NULL,
  NAME_CONT_PERSON  VARCHAR(35) COLLATE 'en-ci'   NULL,
  FAX_CONTACT_FG    NUMBER(38)                    NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);
CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITM_CONSOLIDATIONGROUP_999_2
(
  CLIENT_ID         NUMBER(38)                    NOT NULL   COMMENT 'Mandant_2',
  WH_LOC_SID        NUMBER(38)                    NOT NULL,
  ITM_CONSGRP_ID    NUMBER(38)                    NOT NULL,
  DAT_REC_START     DATE                          NOT NULL,
  DAT_REC_END       DATE                          NOT NULL,
  ITM_CONSGRP_DESC  VARCHAR(50) COLLATE 'en-ci'   NULL,
  DAT_MODIFICATION  DATE                          NULL,
  TIMESTAMP_FN      TIMESTAMP_NTZ(0)              NOT NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);
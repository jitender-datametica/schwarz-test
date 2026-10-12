CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITM_ITEM_CONSOLIDATION_999_1
(
  CLIENT_ID         NUMBER(38)                    NOT NULL   COMMENT 'Mandant_1',
  WH_LOC_SID        NUMBER(38)                    NOT NULL,
  ITEM_SID          NUMBER(38)                    NOT NULL,
  ITM_CONSGRP_ID    NUMBER(38)                    NOT NULL,
  DAT_REC_START     DATE                          NOT NULL,
  DAT_REC_END       DATE                          NOT NULL,
  DAT_MODIFICATION  DATE                          NULL,
  TIMESTAMP_FN      TIMESTAMP_NTZ(0)              NOT NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);
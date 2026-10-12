CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_PROCESS_MSTR_LIL_LYLTY_CLUS_SOC_DMGR_2_LIL_LYLTY_CLUS_SOC_DMGR
(
  LCSD_ID         NUMBER(38)                    NOT NULL,
  LCSD_DESC       VARCHAR(100) COLLATE 'en-ci'  NULL,
  LCSD_SHORT_DESC VARCHAR(100) COLLATE 'en-ci'  NULL,
  SRT_CD          NUMBER(38)                    NOT NULL,
  LCSD_GROUP_ID   NUMBER(38)                    NOT NULL,
  ACTIVE_FG       NUMBER(38)                    NULL,
  EXTRACTION_DT   DATE                          NULL,
  DWH_MAPPING_DT  DATE                          NOT NULL,
  TF_ERROR_FG     NUMBER(1,0)                   NULL,
  RECORD_ID       VARCHAR(300)                  NOT NULL,
  FILENAME        VARCHAR(1000)                 NOT NULL
);
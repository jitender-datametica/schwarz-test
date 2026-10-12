CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_APT_ITEM_PROMOTION_REGION_2_ITEM_PROMOTION_REGION_2
(
  CLIENT_ID                             NUMBER(38)                    NULL,
  LIDL_COUNTRY                          VARCHAR(40)                   NULL,
  APT_ITEM_PROMOTION_REGION_ITEM        NUMBER(38,0)                  NOT NULL,
  APT_ITEM_PROMOTION_REGION_LAND        VARCHAR(300)                  NULL,
  APT_ITEM_PROMOTION_REGION_WERBETAG    VARCHAR(300)                  NULL,
  APT_ITEM_PROMOTION_REGION_WERBEREGION VARCHAR(300)                  NULL,
  ITEM_2                                  NUMBER(10,0)                  NOT NULL,
  PROMOTION_DT                          DATE                          NULL,
  REGION_CD                             VARCHAR(100) COLLATE 'en-ci'  NULL,
  DELETED_FG                            NUMBER(38)                    NULL,
  EXTRACTION_DT                         DATE                          NULL,
  DWH_MAPPING_DT                        DATE                          NULL,
  TF_ERROR_FG                           NUMBER(1,0)                   NULL,
  RECORD_ID                             NUMBER(10,0)                  NULL,
  FILENAME                              VARCHAR(1000)                 NULL
);
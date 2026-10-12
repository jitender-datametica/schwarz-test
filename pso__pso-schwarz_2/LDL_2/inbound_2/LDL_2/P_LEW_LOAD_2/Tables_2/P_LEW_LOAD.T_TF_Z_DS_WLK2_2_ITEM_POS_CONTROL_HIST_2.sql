CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_WLK2_2_ITEM_POS_CONTROL_HIST_2
(
  CLIENT_ID               NUMBER(38)                    NULL,
  LIDL_COUNTRY            VARCHAR(40)                   NULL,
  Z_DS_WLK2_MATNR         VARCHAR(36)                   NULL,
  Z_DS_WLK2_VKORG         VARCHAR(8)                    NULL,
  Z_DS_WLK2_VTWEG         VARCHAR(4)                    NULL,
  Z_DS_WLK2_WERKS         VARCHAR(8)                    NULL,
  SRC_MATNR               VARCHAR(40)                   NULL,
  SRC_VKORG               VARCHAR(40)                   NULL,
  SRC_WERKS               VARCHAR(40)                   NULL,
  DISTRIBUTION_CHANNEL_CD VARCHAR(20)                   NULL,
  SCALE_AREA              VARCHAR(20)                   NULL,
  DELETED_FG              NUMBER(38)                    NULL,
  EXTRACTION_DT           DATE                          NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  TF_ERROR_FG             NUMBER(1,0)                   NULL,
  RECORD_ID               NUMBER(10,0)                  NULL,
  FILENAME                VARCHAR(1000)                 NULL
);
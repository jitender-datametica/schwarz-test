CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_0RT_PROMO_TEXT_2_PROMOTION
(
  CLIENT_ID             NUMBER(38)                    NULL,
  LIDL_COUNTRY          VARCHAR(40)                   NULL,
  RT_PROMO_TEXT_AKTNR   VARCHAR(20)                   NULL,
  RT_PROMO_TEXT_LANGU   VARCHAR(4)                    NULL,
  SRC_AKTNR             VARCHAR(20)                   NULL,
  PROM_NAME             VARCHAR(100) COLLATE 'en-ci'  NULL,
  PROMOTION_CLASS_MARK  VARCHAR(20)                   NULL,
  PROMOTION_CLASS_LABEL VARCHAR(100) COLLATE 'en-ci'  NULL,
  PROMOTION_TYPE_MARK   VARCHAR(20)                   NULL,
  PROMOTION_TYPE_LABEL  VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT         DATE                          NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  TF_ERROR_FG           NUMBER(1,0)                   NULL,
  RECORD_ID             NUMBER(10,0)                  NULL,
  FILENAME              VARCHAR(1000)                 NULL
);
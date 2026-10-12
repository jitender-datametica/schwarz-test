CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_SUPPLIER_SHIPPINGTERMS_2_REF_MDM_SUP_SHIP_TERMS
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  SUP_SHIP_TERMS_CD VARCHAR(20) COLLATE 'en-ci'   NULL,
  SUP_SHIP_TERMS    VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);
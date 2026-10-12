CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUP_SUPPLIER_CONTACT_999
(
  CLIENT_ID             NUMBER(38)                    NOT NULL,
  SUP_SID               NUMBER(38)                    NOT NULL,
  SUPPLIER_CONTACT_NAME VARCHAR(35) COLLATE 'en-ci'   NULL,
  DAT_REC_START         DATE                          NOT NULL,
  DAT_REC_END           DATE                          NOT NULL,
  STREET                VARCHAR(70) COLLATE 'en-ci'   NULL,
  STREET2               VARCHAR(150) COLLATE 'en-ci'  NULL,
  ZIPCODE               VARCHAR(15) COLLATE 'en-ci'   NULL,
  CITY                  VARCHAR(70) COLLATE 'en-ci'   NULL,
  COUNTY                VARCHAR(50) COLLATE 'en-ci'   NULL,
  POST_OFFICE_BOX       VARCHAR(35) COLLATE 'en-ci'   NULL,
  POST_OFFICE_BOX_ZIP   VARCHAR(15) COLLATE 'en-ci'   NULL,
  COUNTRY_CD            VARCHAR(3) COLLATE 'en-ci'    NULL,
  POSTBOX_TOWN          VARCHAR(50) COLLATE 'en-ci'   NULL,
  PHONE                 VARCHAR(50) COLLATE 'en-ci'   NULL,
  FAX                   VARCHAR(50) COLLATE 'en-ci'   NULL,
  MDE_RECORD_FG         NUMBER(38)                    NULL,
  MDE_PHONE             VARCHAR(35) COLLATE 'en-ci'   NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL
);
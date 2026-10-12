CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUPP_WH_C
(
  ERR_ID            NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE       NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER      VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE          DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD            NUMBER(38)                    NULL,
  COUNTRY_ISO_CD    VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID             VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  ORIG_SUPPLIER_NR  VARCHAR(7) COLLATE 'en-ci'    NOT NULL,
  DISPO_INFO        VARCHAR(254) COLLATE 'en-ci'  NULL,
  FAX               VARCHAR(35) COLLATE 'en-ci'   NULL,
  NAME_CONT_PERSON  VARCHAR(35) COLLATE 'en-ci'   NULL,
  PHONE             VARCHAR(35) COLLATE 'en-ci'   NULL,
  FAX_CONTACT_FG    NUMBER(1,0)                   NULL,
  DAT_DAYEND        DATE                          NULL,
  LOAD_ID           NUMBER(38)                    NULL
)
;
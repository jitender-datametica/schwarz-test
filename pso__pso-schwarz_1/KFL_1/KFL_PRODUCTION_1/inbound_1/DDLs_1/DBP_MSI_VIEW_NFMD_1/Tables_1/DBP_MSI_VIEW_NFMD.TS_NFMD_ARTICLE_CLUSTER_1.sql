--==============================================================
-- Table: ts_nfmd_article_cluster_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_article_cluster_1
   generated from Powerdesigner on Dienstag, 26. April 2022 19:53:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_CLUSTER_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   article_cluster_id                  NUMBER(38,0)    NOT NULL COMMENT 'Atricle cluster unique identifier',
   article_cluster_descr               VARCHAR(255)    COMMENT 'Article cluster description in DE',
   article_cluster_descr_bg            VARCHAR(255)    COMMENT 'Article cluster description in BG',
   article_cluster_descr_cz            VARCHAR(255)    COMMENT 'Article cluster description in CZ',
   article_cluster_descr_en            VARCHAR(255)    COMMENT 'Article cluster description in EN',
   article_cluster_descr_hr            VARCHAR(255)    COMMENT 'Article cluster description in HR',
   article_cluster_descr_pl            VARCHAR(255)    COMMENT 'Article cluster description in PL',
   article_cluster_descr_ro            VARCHAR(255)    COMMENT 'Article cluster description in RO',
   article_cluster_descr_sk            VARCHAR(255)    COMMENT 'Article cluster description in SK',
   article_cluster_descr_native        VARCHAR(255)    COMMENT 'Article cluster description in native language (based on mandant_1 id)',
   active_fg                           NUMBER(38,0)    COMMENT 'flag indicating if article cluster is active',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NFMD_ARTICLE_CLUSTER PRIMARY KEY (mandant_id, article_cluster_id) NOT ENFORCED
)  COMMENT = 'This table defines the existing article clusters (for non-food markdonw needs)';

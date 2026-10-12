--==============================================================
-- Table: ts_nfmd_selected_article_cluster
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_selected_article_cluster
   generated from Powerdesigner on Montag, 4. Juli 2022 13:44:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_SELECTED_ARTICLE_CLUSTER (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp when the record was created',
   article_cluster_id                  INTEGER    COMMENT 'ausgewaehltes Artikelcluster ID - Pflege uebers Frontend',
   user_id                             VARCHAR(255)    COMMENT 'AD name of the user who created the record',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NFMD_SELECTED_ARTICLE_CLUSTER PRIMARY KEY (mandant_id, dwh_created_tmsp) NOT ENFORCED
)  COMMENT = 'When user selects a cluster in the fronted for configurations, the article_customer_id is inserted here.';

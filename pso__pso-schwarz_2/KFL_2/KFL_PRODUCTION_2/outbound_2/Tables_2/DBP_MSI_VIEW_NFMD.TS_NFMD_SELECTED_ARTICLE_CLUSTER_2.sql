--==============================================================
-- Table: ts_nfmd_selected_article_cluster_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_selected_article_cluster_2
   generated from Powerdesigner on Montag, 4. Juli 2022 13:44:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_nfmd.ts_nfmd_selected_article_cluster_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dwh_created_tmsp DATETIME NOT NULL OPTIONS(description='timestamp when the record was created'),
article_cluster_id BIGNUMERIC(38,0) OPTIONS(description='ausgewaehltes Artikelcluster ID - Pflege uebers Frontend'),
user_id STRING(255) OPTIONS(description='AD name of the user who created the record'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dwh_created_tmsp) NOT ENFORCED
)
OPTIONS(description='When user selects a cluster in the fronted for configurations, the article_customer_id is inserted here.');
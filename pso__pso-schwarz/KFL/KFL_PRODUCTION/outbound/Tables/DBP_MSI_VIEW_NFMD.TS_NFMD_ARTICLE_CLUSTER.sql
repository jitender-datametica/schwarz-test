--==============================================================
-- Table: ts_nfmd_article_cluster
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_article_cluster
   generated from Powerdesigner on Dienstag, 26. April 2022 19:53:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_nfmd.ts_nfmd_article_cluster (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
article_cluster_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Atricle cluster unique identifier'),
article_cluster_descr STRING(255) OPTIONS(description='Article cluster description in DE'),
article_cluster_descr_bg STRING(255) OPTIONS(description='Article cluster description in BG'),
article_cluster_descr_cz STRING(255) OPTIONS(description='Article cluster description in CZ'),
article_cluster_descr_en STRING(255) OPTIONS(description='Article cluster description in EN'),
article_cluster_descr_hr STRING(255) OPTIONS(description='Article cluster description in HR'),
article_cluster_descr_pl STRING(255) OPTIONS(description='Article cluster description in PL'),
article_cluster_descr_ro STRING(255) OPTIONS(description='Article cluster description in RO'),
article_cluster_descr_sk STRING(255) OPTIONS(description='Article cluster description in SK'),
article_cluster_descr_native STRING(255)
OPTIONS(description='Article cluster description in native language (based on mandant id)'),
active_fg BIGNUMERIC(38,0) OPTIONS(description='flag indicating if article cluster is active'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, article_cluster_id) NOT ENFORCED
) OPTIONS(description='This table defines the existing article clusters (for non-food markdonw needs)');
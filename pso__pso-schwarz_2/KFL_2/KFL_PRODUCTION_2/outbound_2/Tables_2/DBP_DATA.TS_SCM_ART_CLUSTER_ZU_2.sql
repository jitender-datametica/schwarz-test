--==============================================================
-- Table: ts_scm_art_cluster_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_art_cluster_zu_2
   generated from Powerdesigner on Freitag, 30. April 2021 16:18:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_scm_art_cluster_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_cluster_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelcluster ID'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2 ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Artikelcluster (Zuordnung) fuer KL_SCM');
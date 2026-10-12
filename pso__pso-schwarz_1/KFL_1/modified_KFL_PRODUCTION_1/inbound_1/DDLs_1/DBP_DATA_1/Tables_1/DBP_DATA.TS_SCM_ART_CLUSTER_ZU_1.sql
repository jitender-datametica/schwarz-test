--==============================================================
-- Table: ts_scm_art_cluster_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_art_cluster_zu_1
   generated from Powerdesigner on Freitag, 30. April 2021 16:18:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ts_scm_art_cluster_zu_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   art_cluster_id                      INTEGER    NOT NULL COMMENT 'Artikelcluster ID',
   art_id                              INTEGER    NOT NULL COMMENT 'Artikel_1 ID'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Artikelcluster (Zuordnung) fuer KL_SCM';

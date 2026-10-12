--==============================================================
-- Table: ts_scm_art_cluster_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_art_cluster_zu
   generated from Powerdesigner on Freitag, 30. April 2021 16:18:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ts_scm_art_cluster_zu (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   art_cluster_id                      INTEGER    NOT NULL COMMENT 'Artikelcluster ID',
   art_id                              INTEGER    NOT NULL COMMENT 'Artikel ID'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Artikelcluster (Zuordnung) fuer KL_SCM';

--==============================================================
-- Table: ts_scm_wup_cluster_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_wup_cluster_zu_1
   generated from Powerdesigner on Freitag, 30. April 2021 16:24:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ts_scm_wup_cluster_zu_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER    NOT NULL COMMENT 'Marktnummer',
   wup_cluster_id                      INTEGER    NOT NULL COMMENT 'Marktcluster ID',
   nb_id                               INTEGER    NOT NULL COMMENT 'Nebenbetrieb'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Marktcluster (Zuordnung) für KL_SCM';
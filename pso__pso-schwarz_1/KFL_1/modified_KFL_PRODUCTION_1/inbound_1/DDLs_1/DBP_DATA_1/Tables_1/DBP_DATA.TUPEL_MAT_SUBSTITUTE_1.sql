CREATE TABLE DBP_DATA.TUPEL_MAT_SUBSTITUTE_1 (
   tupel_mat_substitute_id             INTEGER    NOT NULL COMMENT 'Automatical generated key , like column "kl_listung_id" in table dbp_msi_data.kl_listung_1',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   kjwo_update                         INTEGER    NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   matching_id_parent                  INTEGER    NOT NULL COMMENT 'Matching_id auf die sich die Substitute beziehen',
   matching_id_substitute              INTEGER    NOT NULL COMMENT 'Matching_id die als Substitute geeignet sind',
   rank_substitute                     INTEGER    NOT NULL COMMENT 'Absteigendes Ranking der Wahrscheinlichkeit dass es sich um ein relevantes Substitut handelt'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Quelle dbp_data.fanquote_1, Aufschlüsselung der Substitute';

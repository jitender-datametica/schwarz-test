--==============================================================
-- Table: lagerort_lagersortiment_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerort_lagersortiment_zu
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:53:42
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.lagerort_lagersortiment_zu (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   lagerort_id                         VARCHAR(4)      NOT NULL COMMENT 'Lagernummer',
   lagersortiment_id                   VARCHAR(1)      NOT NULL COMMENT 'Lagersortiment ID',
   wup_id                              INTEGER    NOT NULL COMMENT 'Betrieb',
   nb_id                               INTEGER    NOT NULL COMMENT 'Nebenbetrieb'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Zuordnung Lagernummer / Lagersortiment';
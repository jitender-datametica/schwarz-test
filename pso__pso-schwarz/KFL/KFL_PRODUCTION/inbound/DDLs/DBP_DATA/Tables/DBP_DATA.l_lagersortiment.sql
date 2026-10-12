--==============================================================
-- Table: l_lagersortiment
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lagersortiment
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:11:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.l_lagersortiment (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   lagernummer_id                      VARCHAR(4)      NOT NULL COMMENT 'Lagernummer',
   lagersortiment_id                   VARCHAR(1)      NOT NULL COMMENT 'Lagersortiment ID',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Betrieb',
   nb_id                               NUMBER(38,0)    NOT NULL COMMENT 'Nebenbetrieb'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lagersortimente';

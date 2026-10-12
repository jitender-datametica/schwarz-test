--==============================================================
-- Table: lagersortiment_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagersortiment_spr_zu
   generated from Powerdesigner on Mittwoch, 21. April 2021 14:24:07
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.lagersortiment_spr_zu (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   lagernummer_id                      VARCHAR(4)      collate 'en-ci' NOT NULL COMMENT 'Lagernummer',
   lagersortiment_id                   VARCHAR(1)      collate 'en-ci' NOT NULL COMMENT 'Lagersortiment ID',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'Sprachschlüssel',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Betrieb',
   nb_id                               NUMBER(38,0)    NOT NULL COMMENT 'Nebenbetrieb',
   lagersortiment_bez                  VARCHAR(40)     collate 'en-ci' COMMENT 'Lagersortiment Name'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lagersortiment Bezeichnung';
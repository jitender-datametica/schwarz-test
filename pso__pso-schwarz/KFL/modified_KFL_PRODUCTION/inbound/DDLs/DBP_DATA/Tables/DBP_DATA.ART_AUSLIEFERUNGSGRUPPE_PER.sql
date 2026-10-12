--==============================================================
-- Table: art_auslieferungsgruppe_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_auslieferungsgruppe_per
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:41:35
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_AUSLIEFERUNGSGRUPPE_PER (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant',
   art_id                              INTEGER    NOT NULL COMMENT 'Artikelnummer',
   auslieferungsgruppe_id              VARCHAR(4)      NOT NULL COMMENT 'Auslieferungsgruppe',
   dat_von                             DATE            NOT NULL COMMENT 'gültig von',
   dat_bis                             DATE            NOT NULL COMMENT 'gültig bis',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'This table is used to define the Auslieferungsgruppe for an article and date';

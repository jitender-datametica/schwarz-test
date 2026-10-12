--==============================================================
-- Table: auslager_steuerung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: auslager_steuerung_spr_zu
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:20:33
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AUSLAGER_STEUERUNG_SPR_ZU (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Lagernummer/Lagerkomplex',
   auslager_steuerung_id               VARCHAR(4)      NOT NULL COMMENT 'Auslagerungssteuerung',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'ID der Sprache
            ',
   auslager_steuerung_bez              VARCHAR(40)     COMMENT 'Auslagerungssteuerung Bezeichnung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Description of Stock Removal Strategy (EWM)';

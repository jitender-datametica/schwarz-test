--==============================================================
-- Table: einlager_steuerung_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: einlager_steuerung_spr_zu_2
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:16:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EINLAGER_STEUERUNG_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Lagernummer/Lagerkomplex',
   einlager_steuerung_id               VARCHAR(4)      NOT NULL COMMENT 'Einlagerungssteuerung',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'ID der Sprache
            ',
   einlager_steuerung_bez              VARCHAR(40)     COMMENT 'Einlagerungssteuerung Bezeichnung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Description of Putaway Strategy (EWM)';

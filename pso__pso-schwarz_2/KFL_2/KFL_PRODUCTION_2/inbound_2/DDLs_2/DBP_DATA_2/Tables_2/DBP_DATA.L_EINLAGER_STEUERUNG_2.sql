--==============================================================
-- Table: l_einlager_steuerung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_einlager_steuerung_2
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:13:34
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_EINLAGER_STEUERUNG_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Lagernummer/Lagerkomplex',
   einlager_steuerung_id               VARCHAR(4)      NOT NULL COMMENT 'Einlagerungssteuerung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lookup of Putaway Strategy (EWM)';

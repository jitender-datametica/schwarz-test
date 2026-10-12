--==============================================================
-- Table: l_auslager_steuerung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_auslager_steuerung
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:18:25
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_AUSLAGER_STEUERUNG (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Lagernummer/Lagerkomplex',
   auslager_steuerung_id               VARCHAR(4)      NOT NULL COMMENT 'Auslagerungssteuerung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Stock Removal Strategy (EWM)';

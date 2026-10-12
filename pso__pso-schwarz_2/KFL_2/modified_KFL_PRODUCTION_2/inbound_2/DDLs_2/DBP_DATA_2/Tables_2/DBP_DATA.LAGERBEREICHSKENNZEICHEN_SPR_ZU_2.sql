--==============================================================
-- Table: lagerbereichskennzeichen_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerbereichskennzeichen_spr_zu_2
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:11:32
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LAGERBEREICHSKENNZEICHEN_SPR_ZU_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Lagernummer/Lagerkomplex',
   lagerbereichskennzeichen_id         VARCHAR(4)      NOT NULL COMMENT 'Lagerbereichskennzeichen',
   spr_id                              INTEGER    NOT NULL COMMENT 'ID der Sprache
            ',
   lagerbereichskennzeichen_bez        VARCHAR(40)     COMMENT 'Lagerbereichskennzeichen Bezeichnung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Bezeichnungen Lagerbereichskennzeichen (EWM)';

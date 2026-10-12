--==============================================================
-- Table: l_lagerbereichskennzeichen
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lagerbereichskennzeichen
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:08:06
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_LAGERBEREICHSKENNZEICHEN (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Lagernummer/Lagerkomplex',
   lagerbereichskennzeichen_id         VARCHAR(4)      NOT NULL COMMENT 'Lagerbereichskennzeichen',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lookup Lagerbereichskennzeichen (EWM)';

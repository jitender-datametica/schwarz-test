--==============================================================
-- Table: blocklagertyp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: blocklagertyp_spr_zu
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:26:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BLOCKLAGERTYP_SPR_ZU (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Lagernummer/Lagerkomplex',
   blocklagertyp_id                    VARCHAR(4)      NOT NULL COMMENT 'Blocklager',
   spr_id                              INTEGER    NOT NULL COMMENT 'ID der Sprache
            ',
   blocklagertyp_bez                   VARCHAR(40)     COMMENT 'Auslagerungssteuerung Bezeichnung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Description of Bulk Storage Indicators (EWM)';

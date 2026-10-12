--==============================================================
-- Table: artikelrolle_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artikelrolle_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTIKELROLLE_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   artikelrolle_id                     VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Artikelrolle international ID',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache',
   artikelrolle_bez                    VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Artikelrolle Bezeichnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTIKELROLLE_SPR_ZU PRIMARY KEY (mandant_id, artikelrolle_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnung der Artikelrolle';


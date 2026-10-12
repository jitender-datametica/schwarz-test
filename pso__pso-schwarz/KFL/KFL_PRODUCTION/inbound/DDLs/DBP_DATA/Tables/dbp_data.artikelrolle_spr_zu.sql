--==============================================================
-- Table: artikelrolle_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artikelrolle_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTIKELROLLE_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   artikelrolle_id                     VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Artikelrolle international ID',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprache',
   artikelrolle_bez                    VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Artikelrolle Bezeichnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTIKELROLLE_SPR_ZU PRIMARY KEY (mandant_id, artikelrolle_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnung der Artikelrolle';


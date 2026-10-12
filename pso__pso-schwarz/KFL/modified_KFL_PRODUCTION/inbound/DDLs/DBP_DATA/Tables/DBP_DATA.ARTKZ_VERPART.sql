--==============================================================
-- Table: artkz_verpart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_verpart
   generated from Powerdesigner on Sonntag, 4. Februar 2024 12:03:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTKZ_VERPART (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   verpart_id                          VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Verpackungsart, z.Bsp DS',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache.',
   verpart_bez                         VARCHAR(40)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Sprachabhaengige Bezeichnung der Verpackungsart, z.Bsp. Dose',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTKZ_VERPART PRIMARY KEY (verpart_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Lookuptabelle des Artikelkennzeichens Verpackungsart';

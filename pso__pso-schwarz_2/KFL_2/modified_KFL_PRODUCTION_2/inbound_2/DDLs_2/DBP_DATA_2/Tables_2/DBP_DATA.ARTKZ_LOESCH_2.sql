--==============================================================
-- Table: artkz_loesch_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_loesch_2
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:47:25
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTKZ_LOESCH_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   loesch_id                           VARCHAR(2)       NOT NULL COMMENT 'ID des Loeschkennzeichens, z.Bsp. L fuer logisch geloeschte Artikel_2',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache.',
   loesch_bez                          VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhaengige Bezeichnung des Loeschkennzeichens',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTKZ_LOESCH PRIMARY KEY (mandant_id, loesch_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Lookuptabelle des Artikelkennzeichens Loeschartikel';

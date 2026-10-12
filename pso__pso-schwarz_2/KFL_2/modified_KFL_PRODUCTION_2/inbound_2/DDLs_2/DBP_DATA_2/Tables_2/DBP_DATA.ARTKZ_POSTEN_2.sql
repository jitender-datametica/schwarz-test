--==============================================================
-- Table: artkz_posten_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_posten_2
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:45:01
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTKZ_POSTEN_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   posten_id                           VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache.',
   posten_bez                          VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhaengige Bezeichnung des Postenkennzeichens.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTKZ_POSTEN PRIMARY KEY (posten_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Lookuptabelle fuer das Artikelkennzeichen Postenartikel';

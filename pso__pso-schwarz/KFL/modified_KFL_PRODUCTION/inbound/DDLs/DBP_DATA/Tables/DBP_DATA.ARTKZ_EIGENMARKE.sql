--==============================================================
-- Table: artkz_eigenmarke
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_eigenmarke
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:58:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTKZ_EIGENMARKE (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   eigenmarke_id                       VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Eigenmarken-Kennzeichen (z.Bsp. C für Kaufland Klassikartikel)',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   eigenmarke_bez                      VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Eigenmarkenkennzeichens',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTKZ_EIGENMARKE PRIMARY KEY (eigenmarke_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Lookuptabelle fuer Artikelkennzeichen  Eigenmarke';

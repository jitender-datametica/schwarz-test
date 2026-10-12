--==============================================================
-- Table: artkz_lead_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_lead_2
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:29:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTKZ_LEAD_2 (
   lead_id                             INTEGER     NOT NULL COMMENT 'Artikelkennzeichen leader 1 ist Leader, sonst 0',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   lead_bez                            VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung Leader',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTKZ_LEAD PRIMARY KEY (lead_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Lookuptabelle des Artikelkennzeichens Leaderartikel';

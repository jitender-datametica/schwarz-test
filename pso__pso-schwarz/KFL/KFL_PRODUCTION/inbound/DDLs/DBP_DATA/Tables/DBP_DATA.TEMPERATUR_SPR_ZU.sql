--==============================================================
-- Table: temperatur_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: temperatur_spr_zu
   generated from Powerdesigner on Donnerstag, 13. Februar 2025 16:55:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TEMPERATUR_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   temperatur_id                       VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen für den Temperaturbereich, z.Bsp. 3',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   temperatur_bez                      VARCHAR(200)     COMMENT 'Bezeichnung für den Temperaturbereich, z.Bsp. Gefrierware',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TEMPERATUR_SPR_ZU PRIMARY KEY (mandant_id, temperatur_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Sprachabhängige Bezeichnungen der Temperaturkennzeichen';

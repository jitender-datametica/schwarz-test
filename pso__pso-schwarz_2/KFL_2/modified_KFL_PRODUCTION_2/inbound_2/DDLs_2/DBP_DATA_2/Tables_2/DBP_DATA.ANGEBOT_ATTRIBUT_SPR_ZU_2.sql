--==============================================================
-- Table: angebot_attribut_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_attribut_spr_zu_2
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:32:45
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANGEBOT_ATTRIBUT_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   angebot_attribut_id                 INTEGER     NOT NULL COMMENT 'ID des Attributs',
   angebot_attribut_bez                VARCHAR(200)     NOT NULL COMMENT 'Sprachabhängige Bezeichnung des Attributs',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANGEBOT_ATTRIBUT_SPR_ZU PRIMARY KEY (mandant_id, spr_id, angebot_attribut_id) NOT ENFORCED
)  COMMENT = 'Tabelle für sprachabhängige Bezeichnungen der Attribute zum Angebot.';

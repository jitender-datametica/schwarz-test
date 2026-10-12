--==============================================================
-- Table: in_ekorg_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_ekorg_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_EKORG_SPR_ZU_2 (
   einkaufsorganisation_id             INTEGER     NOT NULL COMMENT 'Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   einkaufsorganisation_bez            VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Einkaufsorganisation aus ekotx',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_EKORG_SPR_ZU PRIMARY KEY (einkaufsorganisation_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'BIS - Sprachabhängige Bezeichnung der Einkaufsorganisation aus t024e_2 Industrie';

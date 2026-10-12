--==============================================================
-- Table: gp_teilsortiment_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_teilsortiment_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GP_TEILSORTIMENT_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   gp_teilsortiment_id                 VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Teilsortiment aus SAP ltsnr',
   einkaufsorganisation_id             INTEGER     NOT NULL COMMENT 'Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache ID',
   gp_teilsortiment_bez                VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Kurzbezeichnung aus ltsbz',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GP_TEILSORTIMENT_SPR_ZU PRIMARY KEY (mandant_id, gp_id, gp_teilsortiment_id, einkaufsorganisation_id, spr_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO- Sprachabhängige Bezeichnungen der Teilsortimente pro Lieferant aus der Quelle SAP wyt1t';

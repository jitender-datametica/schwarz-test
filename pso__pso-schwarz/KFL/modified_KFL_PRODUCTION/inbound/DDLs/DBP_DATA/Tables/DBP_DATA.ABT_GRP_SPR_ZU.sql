--==============================================================
-- Table: abt_grp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abt_grp_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABT_GRP_SPR_ZU (
   abt_grp_id                          INTEGER     NOT NULL COMMENT 'Abteilungsgruppe (z.B. Markt Gesamt, Markt vergleichbar, Food Frische, etc.)',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   abt_grp_bez                         VARCHAR(50)      COLLATE 'en-ci',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABT_GRP_SPR_ZU PRIMARY KEY (abt_grp_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Abteilungsgruppe Sprachzuordnung';

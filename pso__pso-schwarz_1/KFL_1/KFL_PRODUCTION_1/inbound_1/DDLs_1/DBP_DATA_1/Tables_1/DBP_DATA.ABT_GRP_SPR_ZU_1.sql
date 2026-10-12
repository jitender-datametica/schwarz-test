--==============================================================
-- Table: abt_grp_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abt_grp_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABT_GRP_SPR_ZU_1 (
   abt_grp_id                          NUMBER(38,0)     NOT NULL COMMENT 'Abteilungsgruppe (z.B. Markt Gesamt, Markt vergleichbar, Food Frische, etc.)',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   abt_grp_bez                         VARCHAR(50)      COLLATE 'en-ci',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABT_GRP_SPR_ZU PRIMARY KEY (abt_grp_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Abteilungsgruppe Sprachzuordnung';

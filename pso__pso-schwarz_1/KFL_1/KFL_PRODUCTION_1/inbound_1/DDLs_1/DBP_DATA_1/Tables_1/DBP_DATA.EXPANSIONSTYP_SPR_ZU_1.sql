--==============================================================
-- Table: expansionstyp_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: expansionstyp_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EXPANSIONSTYP_SPR_ZU_1 (
   expansionstyp_id                    NUMBER(38,0)     NOT NULL COMMENT 'Der Expansionstyp legt den Typ der Expansionssicht fest  (z.B. 1 bedeutet Expansion für EIS auf Tagesebene, 2 dasselbe auf Wochenebene).',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   expansionstyp_bez                   VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Expansionstyps',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EXPANSIONSTYP_SPR_ZU PRIMARY KEY (expansionstyp_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Expansionstyp Sprachzuordnung';


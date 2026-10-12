--==============================================================
-- Table: l_rohstoff_blend_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_rohstoff_blend_1
   generated from Powerdesigner on Mittwoch, 1. Oktober 2025 11:03:06
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_ROHSTOFF_BLEND_1 (
   rohstoff_blend_kfl_cd               VARCHAR(100)      NOT NULL COMMENT 'Kaufland interne Code des Blends.',
   rohstoff_blend_kfl_name             VARCHAR(100)     COMMENT 'Kaufland interne Name des Blends.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_ROHSTOFF_BLEND PRIMARY KEY (rohstoff_blend_kfl_cd) NOT ENFORCED
)  COMMENT = 'Lookup Tabelle für Kaufland definierte Blend : gemischtes Mineralölprodukt, das aus verschiedene Rohstoffe entsteht.';

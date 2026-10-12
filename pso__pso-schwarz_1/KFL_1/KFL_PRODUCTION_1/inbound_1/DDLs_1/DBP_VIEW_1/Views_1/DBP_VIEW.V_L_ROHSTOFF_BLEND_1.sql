CREATE OR REPLACE VIEW DBP_VIEW.V_L_ROHSTOFF_BLEND_1 (
   rohstoff_blend_kfl_cd                    COMMENT 'Kaufland interne Code des Blends.'
  ,rohstoff_blend_kfl_name                  COMMENT 'Kaufland interne Name des Blends.'
)
COMMENT = 'Lookup Tabelle für Kaufland definierte Blend : gemischtes Mineralölprodukt, das aus verschiedene Rohstoffe entsteht.'
 AS 
    SELECT 
        rohstoff_blend_kfl_cd,
        rohstoff_blend_kfl_name

FROM DBP_DATA.L_ROHSTOFF_BLEND_1 ;
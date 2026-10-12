
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_PROMOTION
 (
  prom_id 
 ,prom_desc
 ,prom_desc_EN
 ,prom_short_desc
 ,prom_short_desc_EN
 ,prom_lvl 
 ,liam1_srt_cd 
 ,lift1_srt_cd
 )
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL__DYNAMIC_TABLE_P_LEW_MART_CM
 AS 
 SELECT 
  promc.promotion_brand_id
 ,CAST(COALESCE(trde.trans_text, promp.promotion_brand_descr) AS VARCHAR(256)) AS prom_desc
 ,CAST(COALESCE(tren.trans_text, promp.promotion_brand_descr) AS VARCHAR(256)) AS prom_desc_EN
 ,CAST(COALESCE(dsde.promotion_brand_short_descr, promc.promotion_brand_short_descr) AS VARCHAR(256)) AS prom_short_desc
 ,CAST(COALESCE(dsen.promotion_brand_short_descr, promc.promotion_brand_short_descr) AS VARCHAR(256)) AS prom_short_desc_EN
 ,CAST(promc.promotion_brand_level AS SMALLINT) AS prom_lvl
 ,promp.liam1_srt_cd 
 ,promp.lift1_srt_cd
 FROM P_LEW_CORE_AC.v_ref_lil_promotion_brand AS promc
 INNER JOIN P_LEW_PROCESS_MSTR_AC.v_ref_lil_promotion_brand AS promp
  ON promp.promotion_brand_id = promc.promotion_brand_id
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trde
  ON trde.context = 'PROM_IND_DESC'
 AND trde.trans_id = promc.promotion_brand_id
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS tren
  ON tren.context = 'PROM_IND_DESC'
 AND tren.trans_id = promc.promotion_brand_id
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1
 LEFT OUTER JOIN P_LEW_CORE_AC.v_ref_lil_promotion_brand_descr AS dsde
  ON dsde.promotion_brand_id = promc.promotion_brand_id
 AND dsde.lang_cd = 'DE'
 LEFT OUTER JOIN P_LEW_CORE_AC.v_ref_lil_promotion_brand_descr AS dsen
  ON dsen.promotion_brand_id = promc.promotion_brand_id
 AND dsen.lang_cd = 'EN';

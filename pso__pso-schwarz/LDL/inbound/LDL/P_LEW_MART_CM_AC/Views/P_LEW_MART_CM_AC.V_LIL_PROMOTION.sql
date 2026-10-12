CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_PROMOTION
(
  prom_id 
 ,prom_desc
 ,prom_desc_EN
 ,prom_short_desc
 ,prom_short_desc_EN
 ,prom_lvl 
 ,liam1_srt_cd 
 ,lift1_srt_cd
) AS
SELECT
  prom_id 
 ,prom_desc
 ,prom_desc_EN
 ,prom_short_desc
 ,prom_short_desc_EN
 ,prom_lvl 
 ,liam1_srt_cd 
 ,lift1_srt_cd
FROM P_LEW_MART_CM.V_LIL_PROMOTION ;

CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_LYLTY_CLUS_SOC_DMGR
(
  lcsd_id
 ,lcsd_desc
 ,lcsd_desc_EN
 ,lcsd_short_desc
 ,lcsd_short_desc_EN
 ,sort
 ,lcsd_group
 ,explanation
 ,explanation_EN
) AS
SELECT
  lcsd_id
 ,lcsd_desc
 ,lcsd_desc_EN
 ,lcsd_short_desc
 ,lcsd_short_desc_EN
 ,sort
 ,lcsd_group
 ,explanation
 ,explanation_EN
FROM P_LEW_MART_CM.V_LIL_LYLTY_CLUS_SOC_DMGR ;


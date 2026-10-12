
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_LYLTY_CLUS_SOC_DMGR_2
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
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT 
 CAST(lp.lcsd_id AS SMALLINT) AS lcsd_id
,CAST(COALESCE(dsde.lcsd_descr, lp.lcsd_desc) AS VARCHAR(128)) AS lcsd_desc
,CAST(COALESCE(dsen.lcsd_descr, lp.lcsd_desc) AS VARCHAR(128)) AS lcsd_desc_EN
,CAST(COALESCE(dsde.lcsd_short_descr, lp.lcsd_short_desc) AS VARCHAR(128)) AS lcsd_short_desc
,CAST(COALESCE(dsen.lcsd_short_descr, lp.lcsd_short_desc) AS VARCHAR(128)) AS lcsd_short_desc_EN
,lp.srt_cd AS sort
,lp.lcsd_group_id AS lcsd_group
,CAST(COALESCE(dsde.lcsd_explain, lc.lcsd_explain) AS VARCHAR(128)) AS lcsd_explain
,CAST(COALESCE(dsen.lcsd_explain, lc.lcsd_explain) AS VARCHAR(128)) AS lcsd_explain_EN
FROM P_LEW_PROCESS_MSTR_AC.v_lil_lylty_clus_soc_dmgr_2 AS lp
INNER JOIN P_LEW_CORE_AC.v_ref_lil_lcsd_2 AS lc
   ON lc.lcsd_id = lp.lcsd_id
LEFT OUTER JOIN P_LEW_CORE_AC.v_ref_lil_lcsd_descr_2 AS dsde
   ON dsde.lcsd_id = lc.lcsd_id
  AND dsde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_CORE_AC.v_ref_lil_lcsd_descr_2 AS dsen
   ON dsen.lcsd_id = lc.lcsd_id
  AND dsen.lang_cd = 'EN';

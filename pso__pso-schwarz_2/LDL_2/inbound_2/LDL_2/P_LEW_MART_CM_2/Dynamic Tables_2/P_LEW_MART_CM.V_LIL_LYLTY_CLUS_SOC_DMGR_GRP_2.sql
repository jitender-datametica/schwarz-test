
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_LYLTY_CLUS_SOC_DMGR_GRP_2
(
     lcsd_group_id
    ,lcsd_group_desc
    ,lcsd_group_desc_EN
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT 
     CAST(lcsd.lcsd_group_id AS SMALLINT) AS lcsd_group_id
    ,CAST(COALESCE(trde.trans_text, lcsd.lcsd_group_desc) AS VARCHAR(128)) AS lcsd_group_desc
    ,CAST(COALESCE(tren.trans_text, lcsd.lcsd_group_desc) AS VARCHAR(128)) AS lcsd_group_desc_EN
FROM P_LEW_PROCESS_MSTR_AC.v_lil_lylty_clus_soc_dmgr_grp_2 AS lcsd
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS trde
  ON trde.context = 'LCSD_GROUP_DESC'
 AND trde.trans_id = lcsd.lcsd_group_id
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS tren
  ON tren.context = 'LCSD_GROUP_DESC'
 AND tren.trans_id = lcsd.lcsd_group_id
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;

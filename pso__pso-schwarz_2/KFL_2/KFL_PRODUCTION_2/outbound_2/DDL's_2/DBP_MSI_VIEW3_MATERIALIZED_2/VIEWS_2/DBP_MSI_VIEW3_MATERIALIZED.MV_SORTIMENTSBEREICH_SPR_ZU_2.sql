-- 2024-03-22, AP0212955, SPEC0242926, dknop, initial
 -- ON t01.spr_id = v02.spr_id
 -- missing WG_HIERARCHIE_ID='-1'

-- use spr_2 ID 22 as fallback for all languages if local language is not maintained (which is currently the case)

-- INNER JOIN KFL_PRODUCTION.DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 --dbp_msi.akt_msi_user_spr_zu_2 v03

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_sortimentsbereich_spr_zu_2 (spr_id,
sortimentsbereich_id, sortimentsbereich_bez) AS SELECT spr_id,
 wg_hierarchie_id AS sortimentsbereich_id,
 wg_hierarchie_bez AS sortimentsbereich_bez
FROM kfl_production_dbp_view.v_wg_hierarchie_spr_zu_2 AS T01
WHERE arthiertyp_id = 13
 AND wg_hierarchie_ebene_id = 1
 AND spr_id = 22
GROUP BY sortimentsbereich_id,
 sortimentsbereich_bez,
 spr_id
UNION DISTINCT
SELECT 22,
 -1,
 'Keine Zuordnung';
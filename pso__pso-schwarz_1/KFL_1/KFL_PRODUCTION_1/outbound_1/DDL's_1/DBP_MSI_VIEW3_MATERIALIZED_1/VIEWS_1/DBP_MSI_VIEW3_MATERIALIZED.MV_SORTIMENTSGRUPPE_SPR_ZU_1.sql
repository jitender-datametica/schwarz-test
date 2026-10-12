-- use spr_1 ID 22 as fallback for all languages if local language is not maintained (which is currently the case)

-- missing WG_HIERARCHIE_ID='-1'

-- INNER JOIN KFL_PRODUCTION.DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 --dbp_msi.akt_msi_user_spr_zu_1 v03

-- ON t01.spr_id = v02.spr_id
 -- 2023-08-07, AP0182383, SPEC0207712, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_sortimentsgruppe_spr_zu_1 (spr_id, sortimentsgruppe_id
, sortimentsgruppe_bez) AS SELECT spr_id,
 wg_hierarchie_id AS sortimentsgruppe_id,
 wg_hierarchie_bez AS sortimentsgruppe_bez
FROM kfl_production_dbp_view.v_wg_hierarchie_spr_zu_1 AS T01
WHERE arthiertyp_id = 11
 AND wg_hierarchie_ebene_id = 1
 AND spr_id = 22
GROUP BY sortimentsgruppe_id,
 sortimentsgruppe_bez,
 spr_id
UNION DISTINCT
SELECT 22,
 -1,
 'Keine Zuordnung';
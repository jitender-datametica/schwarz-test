CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_sortimentsgruppe_spr_zu (spr_id, sortimentsgruppe_id,
sortimentsgruppe_bez) AS SELECT spr_id,
 wg_hierarchie_id AS sortimentsgruppe_id,
 wg_hierarchie_bez AS sortimentsgruppe_bez
FROM kfl_production_dbp_view.v_wg_hierarchie_spr_zu AS T01
WHERE arthiertyp_id = 11
 AND wg_hierarchie_ebene_id = 1
 AND spr_id = 22
GROUP BY sortimentsgruppe_id,
 sortimentsgruppe_bez,
 spr_id
UNION DISTINCT
SELECT 22,
 - 1,
 'Keine Zuordnung';
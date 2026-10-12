CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_hwg_spr_zu_1 (hwg_id, arthiertyp_id, mandant_id, spr_id, hwg_bez
, system_id) AS SELECT hwg_id,
 arthiertyp_id,
 mandant_id,
 spr_id,
 hwg_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_hwg_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;
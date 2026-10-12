CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_hwg_spr_zu (hwg_id, arthiertyp_id, mandant_id, spr_id, hwg_bez
, hwg_id_bez) AS SELECT hwg_id,
 arthiertyp_id,
 mandant_id,
 spr_id,
 hwg_bez,
   TRIM(CAST(hwg_id AS STRING FORMAT '000')) || ' ' || hwg_bez AS hwg_id_bez
FROM kfl_production_dbp_view.v_hwg_spr_zu AS V01
WHERE spr_id = 22
 AND arthiertyp_id = 2
 AND hwg_id >= 0;
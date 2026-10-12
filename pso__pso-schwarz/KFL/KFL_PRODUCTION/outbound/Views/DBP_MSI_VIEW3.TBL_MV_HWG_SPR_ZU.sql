CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_hwg_spr_zu (hwg_id, hwg_bez, hwg_id_bez, mandant_id,
arthiertyp_id, spr_id) AS SELECT hwg_id,
 hwg_bez,
   TRIM(CAST(hwg_id AS STRING FORMAT '000')) || ' ' || hwg_bez AS hwg_id_bez,
 mandant_id,
 arthiertyp_id,
 spr_id
FROM kfl_production_dbp_view.v_hwg_spr_zu AS V01
WHERE arthiertyp_id = 2;
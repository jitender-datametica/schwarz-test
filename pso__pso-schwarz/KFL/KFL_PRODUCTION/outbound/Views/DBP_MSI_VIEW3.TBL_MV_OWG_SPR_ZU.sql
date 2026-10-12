CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_owg_spr_zu AS SELECT owg_id,
 owg_bez,
   TRIM(CAST(owg_id AS STRING FORMAT '0000')) || ' ' || owg_bez AS owg_id_bez,
 mandant_id,
 arthiertyp_id,
 spr_id
FROM kfl_production_dbp_view.v_owg_spr_zu AS V01
WHERE arthiertyp_id = 2;
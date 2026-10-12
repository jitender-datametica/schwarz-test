CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_owg_spr_zu_bg (owg_id, arthiertyp_id, mandant_id, spr_id,
owg_bez, owg_id_bez) AS SELECT owg_id,
 arthiertyp_id,
 mandant_id,
 spr_id,
 owg_bez,
   TRIM(CAST(owg_id AS STRING FORMAT '0000')) || ' ' || owg_bez AS owg_id_bez
FROM kfl_production_dbp_view.v_owg_spr_zu AS V01
WHERE spr_id = 18
 AND arthiertyp_id = 2
 AND owg_id >= 0;
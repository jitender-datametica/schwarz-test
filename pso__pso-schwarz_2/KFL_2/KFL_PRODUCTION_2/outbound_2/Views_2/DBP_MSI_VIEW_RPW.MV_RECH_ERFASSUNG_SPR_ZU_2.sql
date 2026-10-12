CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_rech_erfassung_spr_zu_2 (mandant_id, erfassung_id, spr_id,
erfassung_bez, system_id) AS SELECT mandant_id,
 erfassung_id,
 spr_id,
 erfassung_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_rech_erfassung_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;
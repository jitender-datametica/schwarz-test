CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_vorgangsart_ag08_2 (system_id, mandant_id, vorgangsart_ag08_id
) AS SELECT 7 AS system_id,
 mandant_id,
 vorgangsart_ag08_id
FROM kfl_production_dbp_view.v_l_vorgangsart_ag08_2
WHERE mandant_id = 1;
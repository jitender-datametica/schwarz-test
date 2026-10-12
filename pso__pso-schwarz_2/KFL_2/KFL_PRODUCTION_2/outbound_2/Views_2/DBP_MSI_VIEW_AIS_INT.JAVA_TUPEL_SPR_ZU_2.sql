CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_tupel_spr_zu_2 (mandant_id, a500, matching_id, a12, spr_id
) AS SELECT mandant_id,
 kjwo_update AS a500,
 matching_id,
 tupel_bez AS a12,
 spr_id
FROM kfl_production_dbp_view.v_tupel_spr_zu_2;
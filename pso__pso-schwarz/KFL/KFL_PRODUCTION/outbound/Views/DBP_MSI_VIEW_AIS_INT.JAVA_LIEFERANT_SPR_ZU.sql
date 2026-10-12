CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_lieferant_spr_zu (mandant_id, a500, a16, spr_id, a418)
AS SELECT mandant_id,
 kjwo_update AS a500,
 akt_lieferant_id AS a16,
 spr_id,
 akt_lieferant_bez AS a418
FROM kfl_production_dbp_view.v_sort_lieferant_spr_zu;
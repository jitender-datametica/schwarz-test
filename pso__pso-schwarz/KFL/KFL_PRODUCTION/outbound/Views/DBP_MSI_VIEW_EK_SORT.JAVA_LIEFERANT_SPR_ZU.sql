CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_lieferant_spr_zu AS SELECT mandant_id,
 kjwo_update AS a500,
 akt_lieferant_id AS a16,
 spr_id,
 akt_lieferant_bez AS a418
FROM kfl_production_dbp_view.v_sort_lieferant_spr_zu;
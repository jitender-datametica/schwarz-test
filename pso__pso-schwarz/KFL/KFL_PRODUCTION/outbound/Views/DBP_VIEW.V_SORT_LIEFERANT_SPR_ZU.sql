CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sort_lieferant_spr_zu AS SELECT mandant_id,
 kjwo_update,
 akt_lieferant_id,
 spr_id,
 akt_lieferant_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.sort_lieferant_spr_zu;
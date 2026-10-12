CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_lieferant_ekorg_zu AS SELECT flw_lief_id,
 einkaufsorganisation_id,
 mandant_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_lieferant_ekorg_zu;
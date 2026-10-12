CREATE OR REPLACE VIEW kfl_production_dbp_view.v_preis_aenderung_spr_zu AS SELECT mandant_id,
 preis_aend_grund_id,
 spr_id,
 preis_aend_grund_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.preis_aenderung_spr_zu;
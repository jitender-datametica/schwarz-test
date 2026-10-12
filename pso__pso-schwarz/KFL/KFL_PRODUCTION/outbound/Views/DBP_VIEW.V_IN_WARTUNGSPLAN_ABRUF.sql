CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_wartungsplan_abruf AS SELECT mandant_id,
 wart_plan_id,
 wart_plan_abruf_id,
 wart_plan_pos_id,
 auftrag_id,
 dat_start_geplant,
 dat_start,
 dat_abschluss,
 qual_meldung_id
FROM kfl_production_dbp_data.in_wartungsplan_abruf;
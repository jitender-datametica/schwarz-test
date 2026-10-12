CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_wartungsplan_det_2 AS SELECT mandant_id,
 wart_plan_pos_id,
 wart_plan_id,
 wart_plan_pos_bez,
 tp_objekt_id,
 plantyp_id,
 plangruppe_id,
 plangruppenzaehler,
 werk_id,
 wart_plan_status,
 standort_kontierung_id,
 instandhaltung_leistungsart_id,
 qual_meldung_id
FROM kfl_production_dbp_data.in_wartungsplan_det_2;
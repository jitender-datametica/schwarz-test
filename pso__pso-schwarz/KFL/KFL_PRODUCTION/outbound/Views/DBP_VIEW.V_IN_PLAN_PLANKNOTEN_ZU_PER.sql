CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_plan_planknoten_zu_per AS SELECT mandant_id,
 plantyp_id,
 plangruppe_id,
 plangruppenzaehler,
 planknoten_id,
 planknotenzaehler_int,
 planfolge_id,
 dat_von,
 dat_bis,
 dat_gueltig_ab,
 loesch_fg,
 dat_anlage,
 dat_aenderung
FROM kfl_production_dbp_data.in_plan_planknoten_zu_per;
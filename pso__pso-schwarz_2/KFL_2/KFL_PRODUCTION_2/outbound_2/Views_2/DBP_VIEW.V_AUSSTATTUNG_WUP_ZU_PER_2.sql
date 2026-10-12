CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ausstattung_wup_zu_per_2 AS SELECT mandant_id,
 wup_id,
 ausstattung_id,
 dat_von,
 dat_bis,
 anzahl
FROM kfl_production_dbp_data.ausstattung_wup_zu_per_2;
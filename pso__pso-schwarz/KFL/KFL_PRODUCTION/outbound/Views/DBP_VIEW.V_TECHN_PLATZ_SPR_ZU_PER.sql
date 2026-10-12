CREATE OR REPLACE VIEW kfl_production_dbp_view.v_techn_platz_spr_zu_per AS SELECT techn_platz_id,
 spr_id,
 dat_von,
 dat_bis,
 tech_platz_bez
FROM kfl_production_dbp_data.techn_platz_spr_zu_per;
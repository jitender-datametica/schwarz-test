CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aufgabenart_spr_zu_per_2 AS SELECT aufgabenart_id,
 spr_id,
 dat_von,
 dat_bis,
 aufgabenart_bez
FROM kfl_production_dbp_data.aufgabenart_spr_zu_per_2;
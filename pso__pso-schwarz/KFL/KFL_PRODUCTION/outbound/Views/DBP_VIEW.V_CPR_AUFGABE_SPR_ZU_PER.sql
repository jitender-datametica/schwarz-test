CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cpr_aufgabe_spr_zu_per AS SELECT cpr_aufgabe_id,
 spr_id,
 dat_von,
 dat_bis,
 aufgabe_bez,
 aufgabe_langtext,
 td_update,
 td_insert
FROM kfl_production_dbp_data.cpr_aufgabe_spr_zu_per;
CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cpr_projekt_spr_zu_per_1 AS SELECT projekt_id,
 spr_id,
 dat_von,
 dat_bis,
 cpr_projekt_bez,
 cpr_projekt_langtext,
 td_update,
 td_insert
FROM kfl_production_dbp_data.cpr_projekt_spr_zu_per_1;
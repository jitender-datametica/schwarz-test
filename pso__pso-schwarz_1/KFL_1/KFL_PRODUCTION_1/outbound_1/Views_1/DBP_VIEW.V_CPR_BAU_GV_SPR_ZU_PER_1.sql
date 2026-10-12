CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cpr_bau_gv_spr_zu_per_1 AS SELECT projekt_id,
 dat_von,
 bau_gv_dok_id,
 spr_id,
 dat_bis,
 dokument_bez,
 dokument_bez_lang,
 td_update,
 td_insert
FROM kfl_production_dbp_data.cpr_bau_gv_spr_zu_per_1;
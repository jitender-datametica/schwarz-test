CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kl_art_kat_nielsen AS SELECT mandant_id,
 kl_art_kat_id,
 kl_art_kat_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.kl_art_kat_nielsen;
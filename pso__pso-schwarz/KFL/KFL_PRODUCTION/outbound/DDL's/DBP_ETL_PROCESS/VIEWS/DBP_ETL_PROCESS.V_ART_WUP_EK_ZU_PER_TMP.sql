CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.v_art_wup_ek_zu_per_tmp (art_id, mandant_id, wup_id, nb_id,
dat_von, dat_bis, ek_netto, ek_netto_bnk, ek_mep, einstandspreis, komponentenmenge, wrg_id, ek_nettonetto, kein_zekp_fg
, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_process.art_wup_ek_zu_per_tmp;
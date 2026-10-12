CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.bf_hit_the_actions (mandant_id, wup_id, kjwo,
aktion_thema_gruppe_id, art_id, kl_art_id, muki, dat_bis, mengen_faktor, posten_id, vk_brutto, td_update, td_insert) AS
SELECT *
FROM kfl_production_dbp_process.bf_hit_the_actions;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_max_listung_markt_kw_1 (mandant_id, art_id, wg_id, wup_id,
nb_id, kjwo, listung) AS SELECT mandant_id,
 art_id,
 wg_id,
 wup_id,
 nb_id,
 kjwo,
 listung_id AS listung
FROM kfl_production_dbp_view.v_art_wup_listung_kjwo_1 AS V01
WHERE mandant_id > 1;
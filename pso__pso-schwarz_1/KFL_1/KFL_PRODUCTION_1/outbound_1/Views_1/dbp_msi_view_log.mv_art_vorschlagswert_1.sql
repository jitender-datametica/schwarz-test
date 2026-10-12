CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_art_vorschlagswert_1 AS SELECT mandant_id,
 art_id,
 ausg_menge_einh_id,
 paletten_faktor_einh_id,
 sortimentslistenart_id,
 zl_kolli_menge_einh_id,
 lage_faktor_einh_id,
 auspack_fg
FROM kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS V01
WHERE dat_bis = PARSE_DATE('%F', '9999-12-31');
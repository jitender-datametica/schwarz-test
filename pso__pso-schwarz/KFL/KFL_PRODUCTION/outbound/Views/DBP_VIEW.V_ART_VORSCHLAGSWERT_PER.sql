CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_vorschlagswert_per AS SELECT mandant_id,
 art_id,
 dat_von,
 ausg_menge_einh_id,
 paletten_faktor_einh_id,
 dat_bis,
 sortimentslistenart_id,
 zl_kolli_menge_einh_id,
 lage_faktor_einh_id,
 auspack_fg
FROM kfl_production_dbp_data.art_vorschlagswert_per;
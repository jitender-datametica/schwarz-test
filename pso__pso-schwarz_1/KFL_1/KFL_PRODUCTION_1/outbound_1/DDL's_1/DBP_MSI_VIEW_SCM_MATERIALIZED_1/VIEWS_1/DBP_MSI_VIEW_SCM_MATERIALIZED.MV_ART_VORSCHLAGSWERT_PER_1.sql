CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_vorschlagswert_per_1 (mandant_id, art_id,
dat_von, ausg_menge_einh_id, paletten_faktor_einh_id, dat_bis, sortimentslistenart_id, zl_kolli_menge_einh_id,
lage_faktor_einh_id, auspack_fg) AS SELECT mandant_id,
 art_id,
 dat_von,
 TRIM(CASE
   WHEN ausg_menge_einh_id <> ''
   THEN ausg_menge_einh_id
   ELSE '1'
   END) AS ausg_menge_einh_id,
 paletten_faktor_einh_id,
 dat_bis,
 sortimentslistenart_id,
 zl_kolli_menge_einh_id,
 lage_faktor_einh_id,
 auspack_fg
FROM kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS V01
WHERE dat_bis = DATE '9999-12-31';
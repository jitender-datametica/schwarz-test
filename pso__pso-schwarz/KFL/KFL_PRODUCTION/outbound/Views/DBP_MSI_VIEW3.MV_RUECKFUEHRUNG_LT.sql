CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_rueckfuehrung_lt (mandant_id, tour_id, wup_id, nb_id, art_id,
lagerbew_beleg_id, kj, lfnr, dat_buch, wup_id_lager, nb_id_lager, rueck_grund_id, menge_bme, mandant_id_lager) AS SELECT
 V01.mandant_id,
 V01.tour_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V01.lagerbew_beleg_id,
 V01.kj,
 V01.lfnr,
 V01.dat_buch,
 V01.wup_id_lager,
 V01.nb_id_lager,
 COALESCE(V02.rueck_grund_id, - 1) AS rueck_grund_id,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), V01.tour_id, CAST(V01.wup_id AS STRING), CAST(V01.nb_id AS STRING)
       , CAST(V01.art_id AS STRING), V01.lagerbew_beleg_id, CAST(V01.kj AS STRING), CAST(V01.lfnr AS STRING), V01.dat_buch
       ORDER BY V02.rueck_grund_id IS NULL, V02.rueck_grund_id)) = 1
  THEN V01.menge_bme
  ELSE 0
  END AS menge_bme,
 V01.mandant_id_lager
FROM kfl_production_dbp_view.v_rueckfuehrung_lt AS V01
 LEFT JOIN kfl_production_dbp_view.v_rueckfuehrung_lt_grund AS V02 ON V01.mandant_id = V02.mandant_id AND V01.tour_id =
          V02.tour_id AND V01.wup_id = V02.wup_id AND V01.nb_id = V02.nb_id AND V01.art_id = V02.art_id AND V01.lagerbew_beleg_id
       = V02.lagerbew_beleg_id AND V01.kj = V02.kj AND V01.lfnr = V02.lfnr AND V01.dat_buch = V02.dat_buch;
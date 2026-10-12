CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_kolli_faktor_dz_zl (mandant_id, art_id, kolli_faktor_dz,
koll_faktor_zl) AS SELECT bw.mandant_id,
 bw.art_id,
 SUM(CASE
   WHEN bw.bezugsweg_id = 1
   THEN COALESCE(kolli.umrech_faktor, 1)
   ELSE 0
   END) AS kolli_faktor_dz,
 SUM(CASE
   WHEN bw.bezugsweg_id = 4
   THEN COALESCE(kolli.umrech_faktor, 1)
   ELSE 0
   END) AS koll_faktor_zl
FROM (SELECT art_id,
   mandant_id,
   menge_einh_id,
   bezugsweg_id
  FROM (SELECT art_id,
      mandant_id,
      best_menge_einh_id AS menge_einh_id,
      1 AS bezugsweg_id
     FROM kfl_production_dbp_view.v_art
     WHERE dat_bis = DATE '9999-12-31'
     UNION ALL
     SELECT art_id,
      mandant_id,
      ausg_menge_einh_id AS menge_einh_id,
      4 AS bezugsweg_id
     FROM kfl_production_dbp_view.v_art_vorschlagswert_per
     WHERE dat_bis = DATE '9999-12-31') AS subs) AS bw
 LEFT JOIN (SELECT art_id,
   mandant_id,
   altnv_menge_einh_id,
   umrech_faktor
  FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per
  WHERE dat_bis = DATE '9999-12-31') AS kolli ON bw.art_id = kolli.art_id AND bw.mandant_id = kolli.mandant_id AND bw.menge_einh_id
    = kolli.altnv_menge_einh_id
GROUP BY bw.mandant_id,
 bw.art_id;
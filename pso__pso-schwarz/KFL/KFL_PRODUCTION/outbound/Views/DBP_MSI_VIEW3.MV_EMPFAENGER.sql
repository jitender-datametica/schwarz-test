CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_empfaenger (empfaenger_id, aktuell_wup_id, is_akt_wup_id_fg,
nb_id, mandant_id_empfaenger, dat_von, empfaenger_bez, dat_bis, buchungskreis_id, verkaufsorganisation_id, wup_typ_id,
breitengrad, laengengrad, vkl_id, vs_id) AS SELECT COALESCE(W.wup_id, G.gp_id) AS wup_id,
 COALESCE(W.aktuell_wup_id, G.gp_id) AS aktuell_wup_id,
  CASE
  WHEN W.aktuell_wup_id = W.wup_id
  THEN 1
  ELSE 0
  END AS is_akt_wup_id_fg,
 COALESCE(W.nb_id, - 111) AS nb_id,
 COALESCE(W.mandant_id, G.mandant_id) AS mandant_id,
 COALESCE(W.dat_von, G.dat_von) AS dat_von,
  CASE
  WHEN W.nb_id = - 1
  THEN '---'
  ELSE COALESCE(W.wup_standort, G.gp_name)
  END AS empfaenger_bez,
 COALESCE(W.dat_bis, G.dat_bis) AS dat_bis,
 COALESCE(W.buchungskreis_id, - 1) AS buchungskreis_id,
 COALESCE(W.verkaufsorganisation_id, CAST(G.einkaufsorganisation_id AS STRING)) AS verkaufsorganisation_id,
 COALESCE(W.wup_typ_id, - 1) AS wup_typ_id,
 COALESCE(W.breitengrad, G.breitengrad) AS breitengrad,
 COALESCE(W.laengengrad, G.laengengrad) AS laengengrad,
 COALESCE(W.vkl_id, - 1) AS vkl_id,
 COALESCE(W.vs_id, - 1) AS vs_id
FROM kfl_production_dbp_view.v_gp AS G
 FULL JOIN kfl_production_dbp_view.v_wup AS W ON G.mandant_id = W.mandant_id AND G.gp_id = W.wup_id
WHERE W.nb_id IN (2, 0, - 111) AND W.wup_id > 0
 OR W.nb_id = - 1 AND W.wup_id = 0
 OR W.nb_id IS NULL
UNION ALL
SELECT - 1 AS wup_id,
 - 1 AS aktuell_wup_id,
 1 AS is_akt_wup_id_fg,
 nb_id,
 mandant_id,
 dat_von,
  CASE
  WHEN nb_id = - 1
  THEN '---'
  ELSE wup_standort
  END AS empfaenger_bez,
 dat_bis,
 buchungskreis_id,
 verkaufsorganisation_id,
 wup_typ_id,
 breitengrad,
 laengengrad,
 vkl_id,
 vs_id
FROM kfl_production_dbp_view.v_wup
WHERE nb_id = - 1
 AND wup_id = 0;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_ek_infosatz_2 (mandant_id, ek_infosatz_id, art_id, gp_id,
crossdocking_id, einkaufsorganisation_id, dat_erstellung, gp_art_id, dat_von, dat_bis, lieferbar_fg, regel_gp_fg,
loesch_fg, max_ek_infosatz_fg, gp_teilsortiment_id, konditionsgruppe_id, apollo_ian) AS SELECT V01.mandant_id,
 V01.ek_infosatz_id,
 V01.art_id,
 V01.gp_id,
 V01.crossdocking_id,
 V01.einkaufsorganisation_id,
 V01.dat_erstellung,
 V01.gp_art_id,
 V01.dat_von,
 V01.dat_bis,
  CASE
  WHEN DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN V01.dat_von AND V01.dat_bis
  THEN 'X'
  ELSE ' '
  END AS lieferbar_fg,
  CASE
  WHEN V01.regel_gp_fg = 1
  THEN 'X'
  ELSE ' '
  END AS regel_gp_fg,
  CASE
  WHEN V01.loesch_fg = 1
  THEN 'X'
  ELSE ' '
  END AS loesch_fg,
  CASE
  WHEN v02.max_ek_infosatz_id IS NOT NULL
  THEN 'X'
  ELSE ' '
  END AS max_ek_infosatz_fg,
 COALESCE(V01.gp_teilsortiment_id, '999999') AS gp_teilsortiment_id,
 V01.konditionsgruppe_id,
 V01.apollo_ian
FROM kfl_production_dbp_view.v_ek_infosatz_2 AS V01
 LEFT JOIN (SELECT mandant_id,
   art_id,
   MAX(ek_infosatz_id) AS max_ek_infosatz_id
  FROM kfl_production_dbp_view.v_ek_infosatz_2
  WHERE mandant_id = 1
  GROUP BY mandant_id,
   art_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.art_id = v02.art_id AND V01.ek_infosatz_id = v02.max_ek_infosatz_id
   
WHERE V01.mandant_id = 1
QUALIFY (RANK() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.art_id AS STRING), CAST(V01.gp_id AS STRING)
      ORDER BY V01.ek_infosatz_id IS NULL, V01.ek_infosatz_id)) = 1;
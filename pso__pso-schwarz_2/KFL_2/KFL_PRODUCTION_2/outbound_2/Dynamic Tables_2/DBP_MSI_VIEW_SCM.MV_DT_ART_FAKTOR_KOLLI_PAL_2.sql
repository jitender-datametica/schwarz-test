CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_scm.mv_dt_art_faktor_kolli_pal_2
AS
SELECT MAW1.mandant_id,
 MAW1.art_id,
  CASE
  WHEN TRIM(MAW1.ausg_menge_einh_id) = ''
  THEN MARA.basismenge_einh_id
  ELSE MAW1.ausg_menge_einh_id
  END AS einh_kolli,
  CASE
  WHEN MARA.basismenge_einh_id = 'KG' AND MARA.mandant_id = 1 AND kol_dispo.kollifaktor_dispo IS NOT NULL
  THEN CAST(kol_dispo.kollifaktor_dispo AS NUMERIC)
  WHEN MARM_KOL.umrech_zaehler IS NOT NULL AND MARM_KOL.umrech_nenner IS NOT NULL
  THEN CAST(MARM_KOL.umrech_zaehler AS NUMERIC) / CAST(MARM_KOL.umrech_nenner AS NUMERIC)
  ELSE 1
  END AS faktor_kolli,
  CASE
  WHEN TRIM(MARA.best_menge_einh_id) <> ''
  THEN MARA.best_menge_einh_id
  ELSE MARA.basismenge_einh_id
  END AS einh_best,
  CASE
  WHEN TRIM(MARA.best_menge_einh_id) <> ''
  THEN MARM_BEST.umrech_zaehler / MARM_BEST.umrech_nenner
  ELSE 1
  END AS faktor_best,
 MAW1.paletten_faktor_einh_id AS einh_pal,
 CAST(MARM_PAL.umrech_zaehler / MARM_PAL.umrech_nenner AS NUMERIC) AS faktor_pal,
 MAW1.lage_faktor_einh_id AS einh_lag,
 CAST(MARM_LAG.umrech_zaehler / MARM_LAG.umrech_nenner AS NUMERIC) AS faktor_lag,
 MARM_KOL.laenge AS laenge_kolli,
 MARM_KOL.breite AS breite_kolli,
 MARM_KOL.hoehe AS hoehe_kolli
FROM kfl_production_dbp_view.v_art_2 AS MARA_2
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_2 AS MAW1_2 ON MARA.mandant_id = MAW1.mandant_id AND MARA.art_id
    = MAW1.art_id
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS MARM_KOL ON MARM_KOL.dat_bis = DATE '9999-12-31' AND
     MAW1.ausg_menge_einh_id = MARM_KOL.altnv_menge_einh_id AND MAW1.mandant_id = MARM_KOL.mandant_id AND MAW1.art_id =
   MARM_KOL.art_id
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS MARM_PAL ON MARM_PAL.dat_bis = DATE '9999-12-31' AND
     MAW1.paletten_faktor_einh_id = MARM_PAL.altnv_menge_einh_id AND MAW1.mandant_id = MARM_PAL.mandant_id AND MAW1.art_id
    = MARM_PAL.art_id
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS MARM_LAG ON MARM_LAG.dat_bis = DATE '9999-12-31' AND
     MAW1.lage_faktor_einh_id = MARM_LAG.altnv_menge_einh_id AND MAW1.mandant_id = MARM_LAG.mandant_id AND MAW1.art_id =
   MARM_LAG.art_id
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS MARM_BEST ON MARM_BEST.dat_bis = DATE '9999-12-31' AND
     MARA.best_menge_einh_id = MARM_BEST.altnv_menge_einh_id AND MAW1.mandant_id = MARM_BEST.mandant_id AND MAW1.art_id
   = MARM_BEST.art_id
 LEFT JOIN (SELECT mandant_id,
   art_id,
   MAX(umrech_faktor_best_bme) AS kollifaktor_dispo
  FROM kfl_production_dbp_view.v_art_gp_dispo_tag_2
  WHERE mandant_id = 1
   AND dat_plan = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
   AND menge_einh_lam_id = 'KG'
  GROUP BY mandant_id,
   art_id) AS kol_dispo ON MARA.mandant_id = kol_dispo.mandant_id AND MARA.art_id = kol_dispo.art_id
WHERE MAW1.dat_bis = DATE '9999-12-31';


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_f_ods_bon_verkauf_1 (bon_id, bon_dat, bon_booking,
dat_booking, wup_id, nb_id, mandant_id, wrg_id, kl_art_id, art_id, ean_kasse, wg_id, vk_menge, vk_menge_sa, vk_menge_af
, einh_id, umsatz_brutto, umsatz_brutto_sa, umsatz_brutto_af, mwst, aktion_id, heute_zeit_bis) AS
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
 -- currency conversion

/* JOIN KFL_PRODUCTION.dbp_view.v_kurs_1 v07
  ON v01.bon_dat BETWEEN v07.dat_von AND v07.dat_bis
  AND v01.wrg_id = v07.von_wrg_id
  AND v07.kurstyp_id = 9
  AND v07.nach_wrg_id ='EUR' */
-- CROSS JOIN aktueller Berichtskurs
 SELECT V01.bon_id,
 V01.bon_dat,
 V01.bon_booking,
 V01.dat_booking,
 V01.wup_id,
 0 AS nb_id,
 V01.mandant_id,
  CASE
  WHEN V06.wrg_typ_id = 0
  THEN V200.nach_wrg_id
  ELSE V08.default_wrg
  END AS wrg_id,
 V02.kl_art_id,
 V05.art_id,
 V02.ean_kasse,
 V02.wg_id,
 SUM(V02.menge) AS vk_menge,
  CASE
  WHEN V02.aktion_id <> ''
  THEN SUM(V02.menge)
  ELSE NULL
  END AS menge_sa,
  CASE
  WHEN V02.aktion_id = ''
  THEN SUM(V02.menge)
  ELSE NULL
  END AS menge_af,
 V02.einh_id,
 SUM(CASE
   WHEN V01.wrg_id <> 'EUR' AND V08.default_wrg = 'EUR' OR V06.wrg_typ_id = 0 AND V06.berichtskurs_typ_id = 0
   THEN V02.umsatz_brutto * V200.umrechnungskurs
   WHEN V06.wrg_typ_id = 0 AND V06.berichtskurs_typ_id = 1
   THEN V02.umsatz_brutto * V300.umrechnungskurs
   ELSE V02.umsatz_brutto
   END) AS umsatz_brutto,
  CASE
  WHEN V02.aktion_id <> ''
  THEN SUM(CASE
    WHEN V01.wrg_id <> 'EUR' AND V08.default_wrg = 'EUR' OR V06.wrg_typ_id = 0 AND V06.berichtskurs_typ_id = 0
    THEN V02.umsatz_brutto * V200.umrechnungskurs
    WHEN V06.wrg_typ_id = 0 AND V06.berichtskurs_typ_id = 1
    THEN V02.umsatz_brutto * V300.umrechnungskurs
    ELSE V02.umsatz_brutto
    END)
  ELSE NULL
  END AS umsatz_brutto_sa,
  CASE
  WHEN V02.aktion_id = ''
  THEN SUM(CASE
    WHEN V01.wrg_id <> 'EUR' AND V08.default_wrg = 'EUR' OR V06.wrg_typ_id = 0 AND V06.berichtskurs_typ_id = 0
    THEN V02.umsatz_brutto * V200.umrechnungskurs
    WHEN V06.wrg_typ_id = 0 AND V06.berichtskurs_typ_id = 1
    THEN V02.umsatz_brutto * V300.umrechnungskurs
    ELSE V02.umsatz_brutto
    END)
  ELSE NULL
  END AS umsatz_brutto_af,
 V03.mwst,
 V02.aktion_id,
 v09.heute_zeit_bis
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_1 AS V01
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_verkauf_1 AS V02 ON V01.bon_id = V02.bon_id AND V01.wup_id = V02.wup_id AND
     V01.mandant_id = V02.mandant_id AND V01.bon_dat = V02.bon_dat AND V01.bon_dat BETWEEN DATE_SUB(CURRENT_DATE,
    INTERVAL 14 DAY) AND (CURRENT_DATE -- AP0242994/SPEC0276113 Filtern von wg_id = 961 / sschuecke 18.10.2024
)
 INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.mwst_id = V03.mwst_id
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V05 ON V02.mandant_id = V05.mandant_id AND V02.kl_art_id = V05.kl_art_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V06 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V200 ON V01.wrg_id = V200.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V300 ON V01.bon_dat BETWEEN V300.dat_von AND V300.dat_bis AND V01.wrg_id =
   V300.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V08 ON V01.mandant_id = V08.mandant_id
  -- Schließungszeitraum pro Filiale

 INNER JOIN (SELECT mandant_id,
   wup_id,
   MAX(snowconvert_public.time_to_int_udf(zeit_bis)) AS heute_zeit_bis
  FROM kfl_production_dbp_view.v_vaus_wup_oeffnung_zu_per_1
  WHERE mandant_id > 1
  GROUP BY mandant_id,
   wup_id) AS v09 ON V01.mandant_id = v09.mandant_id AND V01.wup_id = v09.wup_id
WHERE V300.kurstyp_id = 3
 AND V300.nach_wrg_id = 'EUR'
 AND V200.dat_bis = DATE '9999-12-31'
 AND V200.kurstyp_id = 3
 AND V200.nach_wrg_id = 'EUR' -- CROSS JOIN historischer Berichtskurs

 AND V05.dat_bis = DATE '9999-12-31'
 AND V03.dat_bis = DATE '9999-12-31'
 AND V01.mandant_id > 1
 AND V02.wg_id <> 961
 AND (V01.bon_id, V01.wup_id, V01.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno_1 AS V04)
GROUP BY V01.bon_id,
 V01.bon_dat,
 V01.bon_booking,
 V01.dat_booking,
 V01.wup_id,
 V01.mandant_id,
 wrg_id,
 V02.kl_art_id,
 V05.art_id,
 V02.ean_kasse,
 V02.wg_id,
 V02.einh_id,
 V03.mwst,
 V02.aktion_id,
 v09.heute_zeit_bis;

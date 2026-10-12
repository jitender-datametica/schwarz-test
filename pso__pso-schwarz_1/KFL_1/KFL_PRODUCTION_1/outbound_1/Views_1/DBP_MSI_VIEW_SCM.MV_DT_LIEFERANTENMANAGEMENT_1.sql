CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_scm.mv_dt_lieferantenmanagement_1 (
MANDANT_ID BIGNUMERIC(38,0),
BEST_BELEG_ID INTEGER,
BEST_BELEG_POS_ID BIGNUMERIC(38,0),
DAT_BUCH DATE,
ENDLIEF_FG BIGNUMERIC(38,0),
ZEIT_ENDLIEF_FG BIGNUMERIC(38,0),
BEST_MENGE_ORIG_FG BIGNUMERIC(38,0),
ANNAHMEVERWEIGERUNG_ID BIGNUMERIC(38,0),
NB_ID BIGNUMERIC(38,0),
ART_ID BIGNUMERIC(38,0),
BELEG_GP_ID BIGNUMERIC(38,0),
WUP_ID BIGNUMERIC(38,0),
BESTELLART_ID STRING(4),
DAT_BEST_BELEG DATE,
DAT_LIEF_WUNSCH DATE,
DAT_LIEF_BEWERTUNG DATE,
MENGE_LIEF NUMERIC(18,3),
BETRAG_LAGERBEW_EK_N NUMERIC(18,4),
BETRAG_BEST_EK_N NUMERIC(18,4),
MENGE_BEST_BME NUMERIC(18,3),
MENGE_BEST_ORIG BIGNUMERIC(38,3),
MENGE_BEST_KOLLI_ORIG BIGNUMERIC(38,3),
EKBE_WE_MENGE_KOLLI BIGNUMERIC(38,0),
MENGE_IST_KOLLI_ORIG BIGNUMERIC(38,0),
LAGERORT_ID STRING(4),
GP_ID BIGNUMERIC(38,0),
LOESCH_FG_EKKO BIGNUMERIC(38,0),
LOESCH_FG_EKPO BIGNUMERIC(38,0),
SELBSTABHOL_FG BIGNUMERIC(38,0),
ANZAHL_LIEF BIGNUMERIC(38,0),
ANZAHL_LIEF_POS BIGNUMERIC(38,0),
LAGER_BEWART_ID STRING(3),
MENGE_GESAMT BIGNUMERIC(38,0),
MENGE_NORMAL BIGNUMERIC(38,0),
MENGE_IWT BIGNUMERIC(38,0),
MENGE_WERBUNG BIGNUMERIC(38,0),
MENGE_BEVORRATUNG BIGNUMERIC(38,0),
WRG_ID STRING(3),
VK_NETTO_LIEF_SOLL NUMERIC(18,4),
VK_NETTO_LIEF_IST NUMERIC(18,4),
MENGE_LIEF_SOLL_KOLLI NUMERIC(18,3),
MENGE_LIEF_IST_KOLLI BIGNUMERIC(38,0),
SOLL_IST_LIEFERDATUM_DIFF_ABS INTEGER,
SOLL_IST_LIEFERDATUM_DIFF INTEGER,
IWT_ID STRING(1),
NEUER_ARTIKEL_FG BIGNUMERIC(38,0),
PLANLIEFERZEIT INTEGER,
GP_TEILSORTIMENT_ID STRING(10),
REICHWEITE NUMERIC(16,5),
GP_DISPO_MULTI_ID INTEGER,
RATIO BIGNUMERIC(38,0),
BEDARFSNUMMER STRING(10),
ENDLIEF_FG_EKPO BIGNUMERIC(38,0)
) AS
SELECT v01.mandant_id,
 v01.best_beleg_id,
 v01.best_beleg_pos_id,
 v01.dat_buch AS dat_buch_,
 v01.endlief_fg,
  CASE
  WHEN v01.dat_buch IN (DATE '1900-01-01', DATE '9999-12-31')
  THEN CAST(- 2 AS BIGNUMERIC)
  ELSE v01.zeit_endlief_fg
  END AS zeit_endlief_fg,
  CASE
  WHEN v01.mandant_id = 1
  THEN v01.best_menge_orig_fg
  WHEN v01.mandant_id > 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(v01.mandant_id AS STRING), v01.best_beleg_id, CAST(v01.best_beleg_pos_id AS STRING)
        ORDER BY CASE
         WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
         THEN DATE '9999-12-31'
         ELSE v01.dat_buch
         END IS NULL, CASE
         WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
         THEN DATE '9999-12-31'
         ELSE v01.dat_buch
         END, v01.lager_bewart_id IS NULL, v01.lager_bewart_id)) = 1
  THEN 1
  ELSE 0
  END AS best_menge_orig_fg_,
 v01.annahmeverweigerung_id,
 v01.nb_id,
 v01.art_id,
 v01.gp_id AS beleg_gp_id,
 v01.wup_id,
 v01.bestellart_id,
 v01.dat_best_beleg,
 v01.dat_lief_wunsch,
 v01.dat_lief_bewertung,
 v01.menge_lief,
 v01.betrag_lagerbew_ek_n,
 v01.betrag_best_ek_n,
 v01.menge_best_bme,
  v01.menge_best_bme * CASE
   WHEN v01.mandant_id = 1
   THEN v01.best_menge_orig_fg
   WHEN v01.mandant_id > 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(v01.mandant_id AS STRING), v01.best_beleg_id, CAST(v01.best_beleg_pos_id AS STRING)
         ORDER BY CASE
          WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
          THEN DATE '9999-12-31'
          ELSE v01.dat_buch
          END IS NULL, CASE
          WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
          THEN DATE '9999-12-31'
          ELSE v01.dat_buch
          END, v01.lager_bewart_id IS NULL, v01.lager_bewart_id)) = 1
   THEN 1
   ELSE 0
   END AS menge_best_orig,
  v01.menge_lief_soll_kolli * CASE
   WHEN v01.mandant_id = 1
   THEN v01.best_menge_orig_fg
   WHEN v01.mandant_id > 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(v01.mandant_id AS STRING), v01.best_beleg_id, CAST(v01.best_beleg_pos_id AS STRING)
         ORDER BY CASE
          WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
          THEN DATE '9999-12-31'
          ELSE v01.dat_buch
          END IS NULL, CASE
          WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
          THEN DATE '9999-12-31'
          ELSE v01.dat_buch
          END, v01.lager_bewart_id IS NULL, v01.lager_bewart_id)) = 1
   THEN 1
   ELSE 0
   END AS menge_best_kolli_orig,
  CASE
  WHEN (v01.mandant_id, v01.art_id) IN (SELECT (mandant_id, art_id)
    FROM kfl_production_dbp_data.art_1
    WHERE basismenge_einh_id = 'KG'
     AND mandant_id = 1)
  THEN NULL
  ELSE EKBE.we_menge_kolli
  END AS ekbe_we_menge_kolli,
  COALESCE(CASE
    WHEN (v01.mandant_id, v01.art_id) IN (SELECT (mandant_id, art_id)
      FROM kfl_production_dbp_data.art_1
      WHERE basismenge_einh_id = 'KG'
       AND mandant_id = 1)
    THEN NULL
    ELSE EKBE.we_menge_kolli
    END, v01.menge_lief_ist_kolli) * CASE
   WHEN v01.mandant_id = 1
   THEN v01.best_menge_orig_fg
   WHEN v01.mandant_id > 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(v01.mandant_id AS STRING), v01.best_beleg_id, CAST(v01.best_beleg_pos_id AS STRING)
         ORDER BY CASE
          WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
          THEN DATE '9999-12-31'
          ELSE v01.dat_buch
          END IS NULL, CASE
          WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
          THEN DATE '9999-12-31'
          ELSE v01.dat_buch
          END, v01.lager_bewart_id IS NULL, v01.lager_bewart_id)) = 1
   THEN 1
   ELSE 0
   END AS menge_ist_kolli_orig,
 v01.lagerort_id,
 v01.gp_id,
 v01.loesch_fg_ekko,
 v01.loesch_fg_ekpo,
 v01.selbstabhol_fg,
 v01.anzahl_lief,
 v01.anzahl_lief_pos,
 v01.lager_bewart_id,
  CASE
  WHEN V03.menge_normal IS NOT NULL
  THEN V03.menge_normal
  ELSE 0.000
  END AS menge_gesamt,
  CASE
  WHEN V03.menge_normal IS NOT NULL
  THEN (V03.menge_normal - V03.menge_iwt - V03.menge_werbung - V03.menge_bevorratung) * CASE
    WHEN v01.mandant_id = 1
    THEN v01.best_menge_orig_fg
    WHEN v01.mandant_id > 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(v01.mandant_id AS STRING), v01.best_beleg_id, CAST(v01.best_beleg_pos_id AS STRING)
          ORDER BY CASE
           WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
           THEN DATE '9999-12-31'
           ELSE v01.dat_buch
           END IS NULL, CASE
           WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
           THEN DATE '9999-12-31'
           ELSE v01.dat_buch
           END, v01.lager_bewart_id IS NULL, v01.lager_bewart_id)) = 1
    THEN 1
    ELSE 0
    END
  ELSE 0.000
  END AS menge_normal,
  CASE
  WHEN V03.menge_iwt IS NOT NULL
  THEN V03.menge_iwt * CASE
    WHEN v01.mandant_id = 1
    THEN v01.best_menge_orig_fg
    WHEN v01.mandant_id > 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(v01.mandant_id AS STRING), v01.best_beleg_id, CAST(v01.best_beleg_pos_id AS STRING)
          ORDER BY CASE
           WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
           THEN DATE '9999-12-31'
           ELSE v01.dat_buch
           END IS NULL, CASE
           WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
           THEN DATE '9999-12-31'
           ELSE v01.dat_buch
           END, v01.lager_bewart_id IS NULL, v01.lager_bewart_id)) = 1
    THEN 1
    ELSE 0
    END
  ELSE 0.000
  END AS menge_iwt,
  CASE
  WHEN V03.menge_werbung IS NOT NULL
  THEN V03.menge_werbung * CASE
    WHEN v01.mandant_id = 1
    THEN v01.best_menge_orig_fg
    WHEN v01.mandant_id > 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(v01.mandant_id AS STRING), v01.best_beleg_id, CAST(v01.best_beleg_pos_id AS STRING)
          ORDER BY CASE
           WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
           THEN DATE '9999-12-31'
           ELSE v01.dat_buch
           END IS NULL, CASE
           WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
           THEN DATE '9999-12-31'
           ELSE v01.dat_buch
           END, v01.lager_bewart_id IS NULL, v01.lager_bewart_id)) = 1
    THEN 1
    ELSE 0
    END
  ELSE 0.000
  END AS menge_werbung,
  CASE
  WHEN V03.menge_bevorratung IS NOT NULL
  THEN V03.menge_bevorratung * CASE
    WHEN v01.mandant_id = 1
    THEN v01.best_menge_orig_fg
    WHEN v01.mandant_id > 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(v01.mandant_id AS STRING), v01.best_beleg_id, CAST(v01.best_beleg_pos_id AS STRING)
          ORDER BY CASE
           WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
           THEN DATE '9999-12-31'
           ELSE v01.dat_buch
           END IS NULL, CASE
           WHEN v01.dat_buch = CAST('1900-01-01' AS DATE)
           THEN DATE '9999-12-31'
           ELSE v01.dat_buch
           END, v01.lager_bewart_id IS NULL, v01.lager_bewart_id)) = 1
    THEN 1
    ELSE 0
    END
  ELSE 0.000
  END AS menge_bevorratung,
 v01.wrg_id,
 v01.vk_netto_lief_soll,
 v01.vk_netto_lief_ist,
 v01.menge_lief_soll_kolli,
 COALESCE(CASE
   WHEN (v01.mandant_id, v01.art_id) IN (SELECT (mandant_id, art_id)
     FROM kfl_production_dbp_data.art_1
     WHERE basismenge_einh_id = 'KG'
      AND mandant_id = 1)
   THEN NULL
   ELSE EKBE.we_menge_kolli
   END, v01.menge_lief_ist_kolli) AS menge_lief_ist_kolli,
  CASE
  WHEN v01.dat_buch IN (DATE '1900-01-01', DATE '9999-12-31') AND V001.endlief_fg = 0
  THEN ABS(DATE_DIFF(DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY), v01.dat_lief_bewertung, DAY))
  WHEN v01.dat_buch IN (DATE '1900-01-01', DATE '9999-12-31') AND V001.endlief_fg = 1
  THEN 0
  ELSE ABS(DATE_DIFF(v01.dat_buch, v01.dat_lief_bewertung, DAY))
  END AS soll_ist_lieferdatum_diff_abs,
  CASE
  WHEN v01.dat_buch IN (DATE '1900-01-01', DATE '9999-12-31') AND V001.endlief_fg = 0
  THEN DATE_DIFF(DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY), v01.dat_lief_bewertung, DAY)
  WHEN v01.dat_buch IN (DATE '1900-01-01', DATE '9999-12-31') AND V001.endlief_fg = 1
  THEN 0
  ELSE DATE_DIFF(v01.dat_buch, v01.dat_lief_bewertung, DAY)
  END AS soll_ist_lieferdatum_diff,
 COALESCE(v045.iwt_id, '') AS iwt_id,
 COALESCE(v045.neuer_artikel_fg, 0) AS neuer_artikel_fg,
 COALESCE(v045.planlieferzeit, - 1) AS planlieferzeit,
  CASE
  WHEN v045.gp_teilsortiment_id = '999999'
  THEN ''
  ELSE COALESCE(v045.gp_teilsortiment_id, '')
  END AS gp_teilsortiment_id,
 COALESCE(v045.reichweite, - 1) AS reichweite,
 COALESCE(v045.gp_dispo_multi_id, - 1) AS gp_dispo_multi_id,
 COALESCE(v045.ratio, - 1) AS ratio,
 V001.bedarfsnummer,
 V001.endlief_fg AS endlief_fg_ekpo
FROM (SELECT mandant_id,
   best_beleg_id,
   best_beleg_pos_id,
    CASE
    WHEN dat_buch = DATE '1900-01-01'
    THEN DATE '9999-12-31'
    ELSE dat_buch
    END AS dat_buch,
   annahmeverweigerung_id,
   nb_id,
   art_id,
   gp_id AS beleg_gp_id,
   wup_id,
   bestellart_id,
   dat_best_beleg,
   dat_lief_wunsch,
   dat_lief_bewertung,
   lagerort_id,
   gp_id,
   loesch_fg_ekko,
   loesch_fg_ekpo,
   selbstabhol_fg,
   wrg_id,
   MAX(zeit_endlief_fg) AS zeit_endlief_fg,
   MIN(lager_bewart_id) AS lager_bewart_id,
   MAX(lager_bewart_id) AS lager_bewart_id_max,
   MAX(endlief_fg) AS endlief_fg,
   MAX(best_menge_orig_fg) AS best_menge_orig_fg,
   MAX(menge_best_bme) AS menge_best_bme,
   SUM(menge_lief) AS menge_lief,
   SUM(menge_lief_ist_kolli) AS menge_lief_ist_kolli,
   SUM(betrag_lagerbew_ek_n) AS betrag_lagerbew_ek_n,
   MAX(betrag_best_ek_n) AS betrag_best_ek_n,
   MAX(vk_netto_lief_soll) AS vk_netto_lief_soll,
   MAX(vk_netto_lief_ist) AS vk_netto_lief_ist,
   MAX(menge_lief_soll_kolli) AS menge_lief_soll_kolli,
   MAX(anzahl_lief) AS anzahl_lief,
   MAX(anzahl_lief_pos) AS anzahl_lief_pos
  FROM kfl_production_dbp_view.v_besch_best_lief_lbs_1 AS LBS
  WHERE nb_id <> 99
   AND bestellart_id IN ('ZLLF', 'ZBCZ', 'ZBPL', 'ZBSK', 'ZBHR', 'ZBRO', 'ZBBG', 'ZNL', 'ZNLP', 'ZNLS', 'ZNLW')
   AND lager_bewart_id IN ('101', '102', '-1', '915', '916')
   AND EXTRACT(YEAR FROM dat_lief_bewertung) >= EXTRACT(YEAR FROM CURRENT_DATE) - 1
   AND EXTRACT(YEAR FROM dat_best_beleg) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
  GROUP BY mandant_id,
   best_beleg_id,
   best_beleg_pos_id,
   LBS.dat_buch,
   annahmeverweigerung_id,
   nb_id,
   art_id,
   beleg_gp_id,
   wup_id,
   bestellart_id,
   dat_best_beleg,
   dat_lief_wunsch,
   dat_lief_bewertung,
   lagerort_id,
   gp_id,
   loesch_fg_ekko,
   loesch_fg_ekpo,
   selbstabhol_fg,
   wrg_id) AS v01
 LEFT JOIN (SELECT t8.mandant_id_,
   t8.best_beleg_id_,
   t8.best_beleg_pos_id_,
   t8.dat_buch_,
   SUM(t8.`A11867`) AS we_menge_kolli
  FROM (SELECT EKBE.mandant_id AS mandant_id_,
     EKBE.best_beleg_id AS best_beleg_id_,
     EKBE.best_beleg_pos_id AS best_beleg_pos_id_,
      CASE
      WHEN EKBE.lager_bewart_id IN ('916', '915') AND check_101.check_101 IS NULL
      THEN COALESCE(MIN(EKBE.dat_buch) OVER (PARTITION BY CAST(EKBE.mandant_id AS STRING), CAST(EKBE.best_beleg_id AS STRING)
          , CAST(EKBE.best_beleg_pos_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), EKBE.dat_buch
       )
      ELSE EKBE.dat_buch
      END AS dat_buch_,
       CASE
       WHEN EKBE.soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * EKBE.menge_basis AS `A11867`
    FROM kfl_production_dbp_data.best_belegfluss_1 AS EKBE
     LEFT JOIN (SELECT mandant_id,
       best_beleg_id,
       best_beleg_pos_id,
       dat_buch,
       1 AS check_101
      FROM kfl_production_dbp_data.best_belegfluss_1
      WHERE best_entw_typ_id = 'E'
       AND mandant_id = 1
       AND lager_bewart_id = '101'
      GROUP BY mandant_id,
       best_beleg_pos_id,
       best_beleg_id,
       dat_buch) AS check_101 ON EKBE.mandant_id = check_101.mandant_id AND EKBE.best_beleg_id = check_101.best_beleg_id
          AND EKBE.best_beleg_pos_id = check_101.best_beleg_pos_id AND EKBE.dat_buch = check_101.dat_buch
    WHERE EKBE.best_entw_typ_id = 'E'
     AND EKBE.mandant_id = 1
     AND EKBE.lager_bewart_id IN ('916', '915', '101', '102')
     AND EXTRACT(YEAR FROM EKBE.dat_buch) >= EXTRACT(YEAR FROM CURRENT_DATE) - 1) AS t8
  GROUP BY t8.mandant_id_,
   t8.best_beleg_id_,
   t8.best_beleg_pos_id_,
   t8.dat_buch_) AS EKBE ON v01.mandant_id = EKBE.mandant_id_ AND v01.best_beleg_id = EKBE.best_beleg_id_ AND v01.best_beleg_pos_id
     = EKBE.best_beleg_pos_id_ AND v01.dat_buch = EKBE.dat_buch_
 INNER JOIN kfl_production_dbp_view.v_besch_best_det_1 AS V001 ON v01.mandant_id = V001.mandant_id AND v01.best_beleg_id =
      V001.best_beleg_id AND v01.best_beleg_pos_id = V001.best_beleg_pos_id AND v01.dat_best_beleg = V001.dat_best_beleg
     AND EXTRACT(YEAR FROM V001.dat_best_beleg) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
 LEFT JOIN kfl_production_dbp_view.v_vz_best_split_1 AS V03 ON v01.best_beleg_id = V03.best_beleg_id AND v01.best_beleg_pos_id
      = V03.best_beleg_pos_id AND v01.mandant_id = V03.mandant_id AND v01.gp_id = V03.gp_id
 LEFT JOIN (SELECT V04.mandant_id,
   V04.dat_plan,
   V04.art_id,
   V05.wup_id,
   V05.gp_id,
    CASE
    WHEN V05.gp_teilsortiment_id = ''
    THEN '999999'
    ELSE V05.gp_teilsortiment_id
    END AS gp_teilsortiment_id,
   MAX(V04.iwt_id) AS iwt_id,
   MAX(V04.neuer_artikel_fg) AS neuer_artikel_fg,
   MAX(V05.planlieferzeit) AS planlieferzeit,
   MAX(V04.reichweite) AS reichweite,
   MAX(V04.ratio) AS ratio,
   MAX(V04.gp_dispo_multi_id) AS gp_dispo_multi_id
  FROM kfl_production_dbp_view.v_art_gp_dispo_tag_1 AS V04
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS V06 ON V04.dat_plan = V06.dat AND V06.akt_kj BETWEEN - 1 AND 0
   INNER JOIN kfl_production_dbp_view.v_gp_dispo_vz_tag_1 AS V05 ON V04.mandant_id = V05.mandant_id AND V04.dat_plan = V05
      .dat_plan AND V04.gp_dispo_id = V05.gp_dispo_id
  WHERE V04.augeblendet_fg = 0
  GROUP BY V04.mandant_id,
   V04.art_id,
   V04.dat_plan,
   V05.wup_id,
   V05.gp_id,
   V05.gp_teilsortiment_id) AS v045 ON v01.mandant_id = v045.mandant_id AND v01.art_id = v045.art_id AND v01.wup_id =
      v045.wup_id AND v01.dat_lief_bewertung = v045.dat_plan AND v01.gp_id = v045.gp_id AND V001.gp_teilsortiment_id =
   v045.gp_teilsortiment_id;
-- 2023-09-13, dknop, changing coalesce for iwt_id fom '0' to ''

-- 2023-07-25, dknop, adding fehllieferung_menge_last_value

-- 2023-05-11, dknop, adding menge_lief_ist_kolli_kum, fehllieferung_menge, fehllieferung_menge_case, menge_lief_ist_kolli_kum

-- 2023-06-22, dknop, updating join to v_tag_1, correcting case condition for gp_teilsortiment_id

-- 2023-07-20, dknop, change dbp_data.besch_best_det_1 to dbp_view.v_besch_best_det_1

-- 2023-06-01, nwag, refactoring, aktkj -2 instead of last 90 days

-- 2023-06-26, dknop, adding v01.bestellart_id in ('ZLLF', 'ZBCZ', 'ZBPL', 'ZBSK', 'ZBHR', 'ZBRO', 'ZBBG'), including dat_best_beleg in join to besch_best_det_1

-- 2024-06-18, dknop, changing definition of wrg_id, set 'EUR' when user_wrg.wrg_typ_id=0

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm_materialized.mv_lieferantenmanagement_1(USERID STRING) AS -- to be done in ETL:

-- wird benoetig wenn teillieferungen vorhanden sind -> umbenennung durch feldliste oben!
 -- ,v01.best_menge_orig_fg

-- Werbung, Prio 1
 -- Bestellmenge Gesamt = Liefermenge Gesamt: Verteilung auf Kategorien gem?? Bestellung

-- Sortiment (normal), Prio 2
 -- Bestellmenge Gesamt = Liefermenge Gesamt: Verteilung auf Kategorien gem. Bestellung

-- Bevorratung, Prio 3
 -- IWT, Prio 4
 -- ,v05.gp_teilsortiment_id
 -- ,v04.dat_lief
 SELECT DISTINCT V01.mandant_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.dat_buch,
 V01.endlief_fg,
  CASE
  WHEN V01.dat_buch IN (DATE '1900-01-01', DATE '9999-12-31')
  THEN CAST(-2 AS BIGNUMERIC)
  ELSE V01.zeit_endlief_fg
  END AS zeit_endlief_fg,
  CASE
  WHEN V01.mandant_id = 1
  THEN V01.best_menge_orig_fg
  WHEN V01.mandant_id > 1 AND (ROW_NUMBER() OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
      ORDER BY V01.dat_buch IS NULL, V01.dat_buch)) = 1
  THEN 1
  ELSE 0
  END AS best_menge_orig_fg,
 V01.annahmeverweigerung_id,
 V01.nb_id,
 V01.art_id,
 V01.gp_id AS beleg_gp_id,
 V01.wup_id,
 V01.bestellart_id,
 V01.dat_best_beleg,
 V01.dat_lief_wunsch,
 V01.dat_lief_bewertung,
 V01.menge_lief,
 V01.betrag_lagerbew_ek_n,
 V01.betrag_best_ek_n,
 V01.menge_best_bme,
  V01.menge_best_bme * V01.best_menge_orig_fg AS menge_best_orig,
  V01.menge_lief_soll_kolli * V01.best_menge_orig_fg AS menge_best_kolli_orig,
  V01.menge_lief_ist_kolli * V01.best_menge_orig_fg AS menge_ist_kolli_orig,
 V01.lagerort_id,
 V01.gp_id,
 V01.loesch_fg_ekko,
 V01.loesch_fg_ekpo,
 V01.selbstabhol_fg,
 V01.anzahl_lief,
 V01.anzahl_lief_pos,
 V01.lager_bewart_id,
  CASE
  WHEN V03.menge_normal IS NOT NULL
  THEN V03.menge_normal
  ELSE 0.000
  END AS menge_gesamt,
  CASE
  WHEN V03.menge_normal IS NOT NULL
  THEN (V03.menge_normal - V03.menge_iwt - V03.menge_werbung - V03.menge_bevorratung) * V01.best_menge_orig_fg
  ELSE 0.000
  END AS menge_normal,
  CASE
  WHEN V03.menge_iwt IS NOT NULL
  THEN V03.menge_iwt * V01.best_menge_orig_fg
  ELSE 0.000
  END AS menge_iwt,
  CASE
  WHEN V03.menge_werbung IS NOT NULL
  THEN V03.menge_werbung * V01.best_menge_orig_fg
  ELSE 0.000
  END AS menge_werbung,
  CASE
  WHEN V03.menge_bevorratung IS NOT NULL
  THEN V03.menge_bevorratung * V01.best_menge_orig_fg
  ELSE 0.000
  END AS menge_bevorratung,
  CASE
  WHEN USER_WRG.wrg_typ_id = 0
  THEN 'EUR'
  ELSE V01.wrg_id
  END AS wrg_id,
  CASE
  WHEN USER_WRG.wrg_typ_id = 0
  THEN V01.vk_netto_lief_soll * KURS.umrechnungskurs
  ELSE V01.vk_netto_lief_soll
  END AS vk_netto_lief_soll,
  CASE
  WHEN USER_WRG.wrg_typ_id = 0
  THEN V01.vk_netto_lief_ist * KURS.umrechnungskurs
  ELSE V01.vk_netto_lief_ist
  END AS vk_netto_lief_ist,
 V01.menge_lief_soll_kolli,
 V01.menge_lief_ist_kolli,
 SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id,
    V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
 AS menge_lief_ist_kolli_kum,
   (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id
      , V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW)) - V01.menge_lief_soll_kolli AS fehllieferung_menge,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id
       , V01.art_id ORDER BY V01.dat_buch IS NULL DESC, V01.dat_buch DESC)) = 1
  THEN CASE
   WHEN (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id, V01
         .wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND
       CURRENT ROW)) - V01.menge_lief_soll_kolli > 0
   THEN 0
   ELSE (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id, V01
        .wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND
      CURRENT ROW)) - V01.menge_lief_soll_kolli
   END
  ELSE 0
  END AS fehllieferung_menge_last_value,
  CASE
  WHEN V01.endlief_fg IN (-1, -2) AND V01.zeit_endlief_fg <> -1
    /* AND v01.menge_lief_ist_kolli<v01.menge_lief_soll_kolli */
  THEN (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id
       , V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW)) - V01.menge_lief_soll_kolli
  ELSE 0
  END AS fehllieferung_menge_case,
 ABS(DATE_DIFF(V01.dat_buch, V01.dat_lief_bewertung, DAY)) AS soll_ist_lieferdatum_diff,
 COALESCE(v045.iwt_id, '') AS iwt_id,
 COALESCE(v045.neuer_artikel_fg, 0) AS neuer_artikel_fg,
 v045.planlieferzeit,
  CASE
  WHEN v045.gp_teilsortiment_id = '999999'
  THEN ''
  ELSE COALESCE(v045.gp_teilsortiment_id, '      ')
  END AS gp_teilsortiment_id,
 v045.reichweite,
 v045.gp_dispo_multi_id,
 v045.ratio,
 V001.bedarfsnummer,
  V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
      , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW)) AS menge_werbung_offen_kum,
  V01.menge_lief_soll_kolli - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
      , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW)) AS menge_lief_offen_kum,
  CASE
  WHEN V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
        , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING
      AND CURRENT ROW)) > 0
  THEN V01.menge_lief_ist_kolli
  ELSE V01.menge_lief_ist_kolli + (V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
         , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL,
         V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
  END AS menge_lief_ist_werbung_calc,
  V01.menge_lief_ist_kolli - CASE
   WHEN V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
         , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN
       UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
   THEN V01.menge_lief_ist_kolli
   ELSE V01.menge_lief_ist_kolli + (V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
          , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL,
          V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
   END AS menge_lief_ist_normal_calc,
   V01.menge_lief_ist_kolli - CASE
    WHEN V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
          , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN
        UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
    THEN V01.menge_lief_ist_kolli
    ELSE V01.menge_lief_ist_kolli + (V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
           , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL,
           V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
    END - (V01.menge_lief_ist_kolli - CASE
     WHEN V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
           , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN
         UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
     THEN V01.menge_lief_ist_kolli
     ELSE V01.menge_lief_ist_kolli + (V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
            , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL
            , V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
     END) AS menge_lief_ist_bevorratung_calc,
    V01.menge_lief_ist_kolli - CASE
     WHEN V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
           , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch ROWS BETWEEN
         UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
     THEN V01.menge_lief_ist_kolli
     ELSE V01.menge_lief_ist_kolli + (V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
            , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL
            , V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
     END - (V01.menge_lief_ist_kolli - CASE
      WHEN V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01
            .best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
      THEN V01.menge_lief_ist_kolli
      ELSE V01.menge_lief_ist_kolli + (V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
             , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL
             , V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
      END) - (V01.menge_lief_ist_kolli - CASE
      WHEN V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01
            .best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
      THEN V01.menge_lief_ist_kolli
      ELSE V01.menge_lief_ist_kolli + (V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
             , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL
             , V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
      END - (V01.menge_lief_ist_kolli - CASE
       WHEN V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01
             .best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch IS NULL, V01.dat_buch
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
       THEN V01.menge_lief_ist_kolli
       ELSE V01.menge_lief_ist_kolli + (V03.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
              , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch
              IS NULL, V01.dat_buch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
       END)) AS menge_lief_ist_iwt_calc
FROM kfl_production_dbp_view.v_besch_best_lief_lbs_1 AS V01
 INNER JOIN kfl_production_dbp_msi_view_scm_materialized.mv_kurs_1 AS KURS_1 ON V01.wrg_id = KURS.von_wrg_id
 INNER JOIN kfl_production_dbp_msi_view_scm_materialized.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS USER_WRG ON TRUE
 INNER JOIN kfl_production_dbp_view.v_besch_best_det_1 AS V001 ON V01.mandant_id = V001.mandant_id AND V01.best_beleg_id =
     V001.best_beleg_id AND V01.best_beleg_pos_id = V001.best_beleg_pos_id -- AND v01.art_id = v001.art_id
 AND V01.dat_best_beleg
    = V001.dat_best_beleg
 LEFT JOIN kfl_production_dbp_view.v_vz_best_split_1 AS V03 ON V01.best_beleg_id = V03.best_beleg_id AND V01.best_beleg_pos_id
      = V03.best_beleg_pos_id AND V01.mandant_id = V03.mandant_id AND V01.gp_id = V03.gp_id
   -- AND v001.gp_teilsortiment_id = CASE WHEN v03.gp_teilsortiment_id = '' THEN '999999' ELSE v03.gp_teilsortiment_id END

   -- geht nur als subsselect da INNER JOIN zwischen den beiden Tabellen notwendig:

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
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS V06 ON V04.dat_plan = V06.dat AND V06.akt_kj BETWEEN -2 AND 0
   INNER JOIN kfl_production_dbp_view.v_gp_dispo_vz_tag_1 AS V05 ON V04.mandant_id = V05.mandant_id AND V04.dat_plan = V05
      .dat_plan AND V04.gp_dispo_id = V05.gp_dispo_id
  WHERE V04.augeblendet_fg = 0 -- AND v04.dat_plan >= CURRENT_DATE - 90

  GROUP BY V04.mandant_id,
   V04.dat_plan,
   V04.art_id,
   V05.wup_id,
   V05.gp_id,
   V05.gp_teilsortiment_id) AS v045 ON V01.mandant_id = v045.mandant_id -- AND v01.dat_best_beleg = v045.dat_plan
 AND
       V01.art_id = v045.art_id AND V01.wup_id = v045.wup_id AND V01.dat_lief_bewertung = v045.dat_plan AND V01.gp_id =
    v045.gp_id AND V001.gp_teilsortiment_id = v045.gp_teilsortiment_id
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V07 ON V01.dat_lief_bewertung = V07.dat -- and v045.dat_plan=v07.dat

WHERE V07.akt_kj BETWEEN -2 AND 0
 AND V01.nb_id <> 99
 AND V01.bestellart_id IN ('ZLLF', 'ZBCZ', 'ZBPL', 'ZBSK', 'ZBHR', 'ZBRO', 'ZBBG');
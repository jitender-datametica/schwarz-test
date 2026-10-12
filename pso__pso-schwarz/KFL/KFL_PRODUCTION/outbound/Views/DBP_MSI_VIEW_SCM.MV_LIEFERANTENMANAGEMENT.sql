CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm.mv_lieferantenmanagement(USERID STRING)  AS SELECT V01.mandant_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.dat_buch,
 V01.endlief_fg,
 V01.endlief_fg_ekpo,
 V01.zeit_endlief_fg,
 V01.best_menge_orig_fg AS best_menge_orig_fg_,
 V01.annahmeverweigerung_id,
 V01.nb_id,
 V01.art_id,
 V01.beleg_gp_id,
 V01.wup_id,
 V01.bestellart_id,
 V01.dat_best_beleg,
 V01.dat_lief_wunsch,
 V01.dat_lief_bewertung,
 V01.menge_lief,
 V01.betrag_lagerbew_ek_n,
 V01.betrag_best_ek_n,
 V01.menge_best_bme,
 V01.menge_best_orig,
 V01.menge_best_kolli_orig,
 V01.menge_ist_kolli_orig,
 V01.lagerort_id,
 V01.gp_id,
 V01.loesch_fg_ekko,
 V01.loesch_fg_ekpo,
 V01.selbstabhol_fg,
 V01.anzahl_lief,
 V01.anzahl_lief_pos,
 V01.lager_bewart_id,
 V01.menge_gesamt,
 V01.kollifaktor,
 V01.menge_iwt,
 V01.menge_werbung,
 V01.menge_nonwbs,
 V01.menge_normal,
 V01.werbung_fg,
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
    V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS menge_lief_ist_kolli_kum,
   (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id
      , V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW)) - V01.menge_lief_soll_kolli AS fehllieferung_menge,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id
       , V01.art_id ORDER BY V01.dat_buch DESC NULLS FIRST, V01.lager_bewart_id DESC NULLS FIRST)) = 1
  THEN CASE
   WHEN (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id, V01
         .wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN
       UNBOUNDED PRECEDING AND CURRENT ROW)) - V01.menge_lief_soll_kolli > 0
   THEN 0
   ELSE (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id, V01
        .wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN
      UNBOUNDED PRECEDING AND CURRENT ROW)) - V01.menge_lief_soll_kolli
   END
  ELSE 0
  END AS fehllieferung_menge_last_value,
  CASE
  WHEN V01.endlief_fg IN (-1, -2) AND V01.zeit_endlief_fg <> -1
  THEN (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id
       , V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW)) - V01.menge_lief_soll_kolli
  ELSE 0
  END AS fehllieferung_menge_case,
 V01.soll_ist_lieferdatum_diff_abs AS soll_ist_lieferdatum_diff,
 V01.soll_ist_lieferdatum_diff AS soll_ist_lieferdatum_diff_saldo,
 V01.iwt_id,
 V01.neuer_artikel_fg,
 V01.planlieferzeit,
 V01.gp_teilsortiment_id,
 V01.reichweite,
 V01.gp_dispo_multi_id,
 V01.ratio,
 V01.bedarfsnummer,
  V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
      , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW)) AS menge_werbung_offen_kum,
  V01.menge_lief_soll_kolli - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
      , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW)) AS menge_lief_offen_kum,
  CASE
  WHEN V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
        , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
  THEN V01.menge_lief_ist_kolli
  ELSE V01.menge_lief_ist_kolli + (V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
         , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST
         , V01.lager_bewart_id NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
  END AS menge_lief_ist_werbung_calc,
  V01.menge_lief_ist_kolli - CASE
   WHEN V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
         , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
   THEN V01.menge_lief_ist_kolli
   ELSE V01.menge_lief_ist_kolli + (V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
          , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST
          , V01.lager_bewart_id NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
   END AS menge_lief_ist_normal_calc,
   V01.menge_lief_ist_kolli - CASE
    WHEN V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
          , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
    THEN V01.menge_lief_ist_kolli
    ELSE V01.menge_lief_ist_kolli + (V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
           , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch
           NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
    END - (V01.menge_lief_ist_kolli - CASE
     WHEN V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
           , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
     THEN V01.menge_lief_ist_kolli
     ELSE V01.menge_lief_ist_kolli + (V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
            , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch
            NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
     END) AS menge_lief_ist_bevorratung_calc,
    V01.menge_lief_ist_kolli - CASE
     WHEN V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01.best_beleg_pos_id
           , V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id NULLS LAST
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
     THEN V01.menge_lief_ist_kolli
     ELSE V01.menge_lief_ist_kolli + (V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
            , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch
            NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
     END - (V01.menge_lief_ist_kolli - CASE
      WHEN V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01
            .best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id
            NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
      THEN V01.menge_lief_ist_kolli
      ELSE V01.menge_lief_ist_kolli + (V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
             , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch
             NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
      END) - (V01.menge_lief_ist_kolli - CASE
      WHEN V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01
            .best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id
            NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
      THEN V01.menge_lief_ist_kolli
      ELSE V01.menge_lief_ist_kolli + (V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
             , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch
             NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
      END - (V01.menge_lief_ist_kolli - CASE
       WHEN V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id, V01
             .best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id
             NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) > 0
       THEN V01.menge_lief_ist_kolli
       ELSE V01.menge_lief_ist_kolli + (V01.menge_werbung - (SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id
              , V01.best_beleg_id, V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch
              NULLS LAST, V01.lager_bewart_id NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)))
       END)) AS menge_lief_ist_iwt_calc,
  CASE
  WHEN V01.menge_lief_soll_kolli - ((SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id
          , V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id
          NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) - V01.menge_lief_ist_kolli) < 0
  THEN 0
  ELSE V01.menge_lief_soll_kolli - ((SUM(V01.menge_lief_ist_kolli) OVER (PARTITION BY V01.mandant_id, V01.best_beleg_id
         , V01.best_beleg_pos_id, V01.wup_id, V01.nb_id, V01.art_id ORDER BY V01.dat_buch NULLS LAST, V01.lager_bewart_id
         NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) - V01.menge_lief_ist_kolli)
  END AS menge_offen_vor_dieser_lieferung
FROM kfl_production_dbp_msi_view_scm.mv_dt_lieferantenmanagement AS V01
 INNER JOIN kfl_production_dbp_msi_view_scm.mv_kurs AS KURS ON V01.wrg_id = KURS.von_wrg_id
 INNER JOIN kfl_production_dbp_msi_view_scm.mv_akt_msi_user_prj_wrg_typ_zu(USERID) AS USER_WRG ON TRUE;
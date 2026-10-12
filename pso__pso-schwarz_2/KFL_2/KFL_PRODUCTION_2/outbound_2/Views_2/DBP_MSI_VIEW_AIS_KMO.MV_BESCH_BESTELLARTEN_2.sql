CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_besch_bestellarten_2 (mandant_id, best_beleg_id,
best_beleg_pos_id, art_id, wup_id, nb_id, lagerort_id, loesch_fg, menge_best_bme, menge_best_kolli, menge_best,
dat_best_beleg, betrag_pos_netto_best_wrg, wrg_id, gp_id, bestellart_id, dat_buch, dat_lief_wunsch, dat_lief_bewertung,
betrag_ekn, wewa_menge, wewa_betrag, anforderer_name) AS SELECT T1.mandant_id,
 T1.best_beleg_id,
 T1.best_beleg_pos_id,
 T1.art_id,
 T1.wup_id,
 T1.nb_id,
 T1.lagerort_id,
 T1.loesch_fg_ekpo AS loesch_fg,
 MAX(T1.menge_best_bme) AS menge_best_bme,
 MAX(T1.menge_best_kolli) AS menge_best_kolli,
 SUM(T1.menge_best) AS menge_best,
 T1.dat_best_beleg,
 MAX(CASE
   WHEN T1.endlief_fg = 1
   THEN CAST(CASE
      WHEN T2.wrg_typ_id = 1
      THEN T1.betrag_best_ek_n
      WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
      THEN T1.betrag_best_ek_n * T1.umrechnungskurs_akt
      WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
      THEN T1.betrag_best_ek_n * T1.umrechnungskurs_hist
      ELSE NULL
      END AS NUMERIC) * - 1
   ELSE CAST(CASE
     WHEN T2.wrg_typ_id = 1
     THEN T1.betrag_best_ek_n
     WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
     THEN T1.betrag_best_ek_n * T1.umrechnungskurs_akt
     WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
     THEN T1.betrag_best_ek_n * T1.umrechnungskurs_hist
     ELSE NULL
     END AS NUMERIC)
   END) AS betrag_pos_netto_best_wrg,
 T1.wrg_id,
 T1.gp_id,
 T1.bestellart_id,
 MAX(T1.dat_buch) AS dat_buch,
 T1.dat_lief_wunsch,
 T1.dat_lief_bewertung,
 MAX(CAST(CASE
    WHEN T2.wrg_typ_id = 1
    THEN T1.betrag_lagerbew_ek_n
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
    THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_akt
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
    THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_hist
    ELSE NULL
    END AS NUMERIC)) AS betrag_ekn,
 SUM(T1.menge_lief_ist_kolli) AS wewa_menge,
 SUM(CASE
   WHEN CAST(T1.lager_bewart_id AS INTEGER) IN (102, 161, 902) AND T1.nb_id IN (- 111, 0) AND T1.endlief_fg = 1
   THEN CASE
    WHEN CAST(T1.lager_bewart_id AS INTEGER) IN (102, 161, 902) AND CAST(CASE
        WHEN T2.wrg_typ_id = 1
        THEN T1.betrag_lagerbew_ek_n
        WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
        THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_akt
        WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
        THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_hist
        ELSE NULL
        END AS NUMERIC) = 0
    THEN NULL
    ELSE CAST(CASE
       WHEN T2.wrg_typ_id = 1
       THEN T1.betrag_lagerbew_ek_n
       WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
       THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_akt
       WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
       THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_hist
       ELSE NULL
       END AS NUMERIC) * - 1
    END
   WHEN CAST(T1.lager_bewart_id AS INTEGER) IN (641, 647) AND T1.nb_id IN (- 111, 0) AND T1.endlief_fg = 1
   THEN CASE
    WHEN CAST(T1.lager_bewart_id AS INTEGER) IN (101, 162, 901) AND CAST(CASE
        WHEN T2.wrg_typ_id = 1
        THEN T1.betrag_lagerbew_ek_n
        WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
        THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_akt
        WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
        THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_hist
        ELSE NULL
        END AS NUMERIC) = 0
    THEN NULL
    ELSE CAST(CASE
      WHEN T2.wrg_typ_id = 1
      THEN T1.betrag_lagerbew_ek_n
      WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
      THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_akt
      WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
      THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_hist
      ELSE NULL
      END AS NUMERIC)
    END
   WHEN CAST(T1.lager_bewart_id AS INTEGER) IN (101, 162, 901) AND T1.nb_id IN (- 111, 0) AND T1.endlief_fg <> 1
   THEN CASE
    WHEN CAST(T1.lager_bewart_id AS INTEGER) IN (101, 162, 901) AND CAST(CASE
        WHEN T2.wrg_typ_id = 1
        THEN T1.betrag_lagerbew_ek_n
        WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
        THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_akt
        WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
        THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_hist
        ELSE NULL
        END AS NUMERIC) = 0
    THEN NULL
    ELSE CAST(CASE
      WHEN T2.wrg_typ_id = 1
      THEN T1.betrag_lagerbew_ek_n
      WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
      THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_akt
      WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
      THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_hist
      ELSE NULL
      END AS NUMERIC)
    END
   WHEN CAST(T1.lager_bewart_id AS INTEGER) IN (642, 648) AND T1.nb_id IN (- 111, 0) AND T1.endlief_fg <> 1
   THEN CASE
    WHEN CAST(T1.lager_bewart_id AS INTEGER) IN (102, 161, 902) AND CAST(CASE
        WHEN T2.wrg_typ_id = 1
        THEN T1.betrag_lagerbew_ek_n
        WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
        THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_akt
        WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
        THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_hist
        ELSE NULL
        END AS NUMERIC) = 0
    THEN NULL
    ELSE CAST(CASE
       WHEN T2.wrg_typ_id = 1
       THEN T1.betrag_lagerbew_ek_n
       WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
       THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_akt
       WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
       THEN T1.betrag_lagerbew_ek_n * T1.umrechnungskurs_hist
       ELSE NULL
       END AS NUMERIC) * - 1
    END
   ELSE NULL
   END) AS wewa_betrag,
 T1.anforderer_name
FROM kfl_production_dbp_msi_view_ais_kmo.tbl_mv_besch_bestellarten_2 AS T1_2
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS T2 ON TRUE
GROUP BY T1.mandant_id,
 T1.best_beleg_id,
 T1.best_beleg_pos_id,
 T1.art_id,
 T1.wup_id,
 T1.nb_id,
 T1.lagerort_id,
 loesch_fg,
 T1.dat_best_beleg,
 T1.wrg_id,
 T1.gp_id,
 T1.bestellart_id,
 T1.dat_lief_wunsch,
 T1.dat_lief_bewertung,
 T1.anforderer_name;
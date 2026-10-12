
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_l_unter_kategorie_wup_monat_2 AS -- nicht mehr benötigt

-- 10 audimax - AMX IST (beantwortete Hauptfragen)
 SELECT mandant_id,
 wup_id,
 kjmo,
 kmr_unter_kategorie_id,
 1 AS kmr_count_fg,
 MAX(CASE
   WHEN kmr_haupfrage > 0
   THEN kmr_unter_kategorie_id
   ELSE NULL
   END) AS kmr_unter_kategorie_id_gj,
 MAX(CASE
   WHEN kmr_haupfrage_kvj > 0
   THEN kmr_unter_kategorie_id
   ELSE NULL
   END) AS kmr_unter_kategorie_id_vj,
 MAX(kmr_haupfrage) AS kmr_anz_ist,
 MAX(kmr_haupfrage_kvj) AS kmr_anz_kvj,
 MAX(amx_feststell) AS amx_festellungen_ist,
 MAX(amx_gesamt) AS amx_gesamt_ist,
 MAX(amx_feststell_kvj) AS amx_festellungen_kvj,
 MAX(amx_gesamt_kvj) AS amx_gesamt_kvj,
 MAX(mcx_feststell) AS mcx_festellungen_ist,
 MAX(mcx_gesamt_tb) AS mcx_gesamt_ist,
 MAX(mcx_feststell_kvj) AS mcx_festellungen_kvj,
 MAX(mcx_gesamt_tb_kvj) AS mcx_gesamt_kvj,
 MAX(geku_chance) AS geku_chancen_ist,
 MAX(geku_gesamt_cnp) AS geku_gesamt_ist,
 MAX(geku_chance_kvj) AS geku_chanchen_kvj,
 MAX(geku_gesamt_cnp_kvj) AS geku_gesamt_kvj,
 0 AS kvst_potential_ist,
 0 AS kvst_anz_gesamt,
 0 AS kvst_potential_kvj,
 0 AS kvst_gesamt_kvj
FROM (SELECT A14.mandant_id,
    A14.wup_id,
    A15.kjmo,
    A16.kmr_unter_kategorie_id,
    1 AS kmr_haupfrage,
    0 AS kmr_haupfrage_kvj,
    CAST(CASE
      WHEN A11.antwort_wert IN (1, 4)
      THEN 1
      ELSE 0
      END AS BIGNUMERIC) AS amx_feststell,
    CAST(CASE
      WHEN A11.antwort_wert IN (0, 1, 4)
      THEN 1
      ELSE 0
      END AS BIGNUMERIC) AS amx_gesamt,
    CAST(NULL AS BIGINT) AS mcx_feststell,
    CAST(NULL AS BIGINT) AS mcx_gesamt_tb,
    CAST(NULL AS BIGINT) AS geku_chance,
    CAST(NULL AS BIGINT) AS geku_gesamt_cnp,
    CAST(NULL AS BIGNUMERIC) AS amx_feststell_kvj,
    CAST(NULL AS BIGNUMERIC) AS amx_gesamt_kvj,
    CAST(NULL AS BIGINT) AS mcx_feststell_kvj,
    CAST(NULL AS BIGINT) AS mcx_gesamt_tb_kvj,
    CAST(NULL AS BIGINT) AS geku_chance_kvj,
    CAST(NULL AS BIGINT) AS geku_gesamt_cnp_kvj
   FROM kfl_production_dbp_msi_view_vis.mv_amx_frage_2 AS A11
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_frage_katalog_2 AS A12 ON A11.amx_frage_katalog_id = A12.amx_frage_katalog_id
       AND A11.kmr_quelle_id = A12.kmr_quelle_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruef_kapitel_2 AS A13 ON A11.pruef_kapitel_id = A13.pruef_kapitel_id
     
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruefung_2 AS A14 ON A13.pruefung_id = A14.pruefung_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS A15 ON A14.dat_ende = A15.dat
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_frage_2 AS A16 ON A12.amx_frage_katalog_id = A16.kmr_frage_id AND
      A12.kmr_quelle_id = A16.kmr_quelle_id
    INNER JOIN kfl_production_dbp_view.v_wup_2 AS A17 ON A14.mandant_id = A17.mandant_id AND A14.wup_id = A17.wup_id
   WHERE A12.amx_handlung_typ_id IN (1, 50000)
    AND A11.antwort_wert IN (0, 1, 4)
    AND A15.akt_gj = - 1
    AND A17.nb_id IN (- 1, 0) -- 11 audimax - AMX VJ (beantwortete Hauptfragen)

   UNION ALL
   SELECT A14.mandant_id,
    A14.wup_id,
     A15.kjmo + 100 AS kjmo,
    A16.kmr_unter_kategorie_id,
    0 AS kmr_haupfrage,
    1 AS kmr_haupfrage_kvj,
    CAST(NULL AS BIGNUMERIC) AS amx_feststell,
    CAST(NULL AS BIGNUMERIC) AS amx_gesamt,
    CAST(NULL AS BIGINT) AS mcx_feststell,
    CAST(NULL AS BIGINT) AS mcx_gesamt_tb,
    CAST(NULL AS BIGINT) AS geku_chance,
    CAST(NULL AS BIGINT) AS geku_gesamt_cnp,
    CAST(CASE
      WHEN A11.antwort_wert IN (1, 4)
      THEN 1
      ELSE 0
      END AS BIGNUMERIC) AS amx_feststell_kvj,
    CAST(CASE
      WHEN A11.antwort_wert IN (0, 1, 4)
      THEN 1
      ELSE 0
      END AS BIGNUMERIC) AS amx_gesamt_kvj,
    CAST(NULL AS BIGINT) AS mcx_feststell_kvj,
    CAST(NULL AS BIGINT) AS mcx_gesamt_tb_kvj,
    CAST(NULL AS BIGINT) AS geku_chance_kvj,
    CAST(NULL AS BIGINT) AS geku_gesamt_cnp_kvj
   FROM kfl_production_dbp_msi_view_vis.mv_amx_frage_2 AS A11
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_frage_katalog_2 AS A12 ON A11.amx_frage_katalog_id = A12.amx_frage_katalog_id
       AND A11.kmr_quelle_id = A12.kmr_quelle_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruef_kapitel_2 AS A13 ON A11.pruef_kapitel_id = A13.pruef_kapitel_id
     
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruefung_2 AS A14 ON A13.pruefung_id = A14.pruefung_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS A15 ON A14.dat_ende = A15.dat
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_frage_2 AS A16 ON A12.amx_frage_katalog_id = A16.kmr_frage_id AND
      A12.kmr_quelle_id = A16.kmr_quelle_id
    INNER JOIN kfl_production_dbp_view.v_wup_2 AS A17 ON A14.mandant_id = A17.mandant_id AND A14.wup_id = A17.wup_id
   WHERE A12.amx_handlung_typ_id IN (1, 50000)
    AND A11.antwort_wert IN (0, 1, 4)
    AND A15.akt_gj = - 2
    AND A17.nb_id IN (- 1, 0) -- 20 maritz - MCX IST (Alle Hauptfragen)

   UNION ALL
   SELECT kmr.mandant_id,
    kmr.wup_id,
    kmr.kjmo,
    kmr.kmr_unter_kategorie_id,
    1 AS kmr_haupfrage,
    0 AS kmr_haupfrage_kvj,
    CAST(NULL AS BIGNUMERIC) AS amx_feststell,
    CAST(NULL AS BIGNUMERIC) AS amx_gesamt,
    MCX1.mcx_feststell,
    MCX2.mcx_gesamt_tb,
    CAST(NULL AS BIGINT) AS geku_chance,
    CAST(NULL AS BIGINT) AS geku_gesamt_cnp,
    CAST(NULL AS BIGNUMERIC) AS amx_feststell_kvj,
    CAST(NULL AS BIGNUMERIC) AS amx_gesamt_kvj,
    CAST(NULL AS BIGINT) AS mcx_feststell_kvj,
    CAST(NULL AS BIGINT) AS mcx_gesamt_tb_kvj,
    CAST(NULL AS BIGINT) AS geku_chance_kvj,
    CAST(NULL AS BIGINT) AS geku_gesamt_cnp_kvj
   FROM (SELECT *
     FROM (SELECT DISTINCT S01.kmr_unter_kategorie_id,
        S01.kmr_count_fg
       FROM kfl_production_dbp_view.v_kmr_l_unter_kategorie_2 AS S01
        INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu_2 AS S02 ON S01.kmr_unter_kategorie_id = S02.kmr_unter_kategorie_id
         
       WHERE S01.kmr_count_fg = 1
        AND S02.kmr_quelle_id = 2 -- MCX (Maritz)
) AS v01
      INNER JOIN (SELECT mandant_id,
        wup_id,
        nb_id
       FROM kfl_production_dbp_view.v_wup_2
       WHERE nb_id IN (- 1, 0)) AS v02 ON TRUE
      INNER JOIN (SELECT kjmo
       FROM kfl_production_dbp_view.v_monat_2
       WHERE akt_gj = - 1) AS v03 ON TRUE) AS kmr
    LEFT JOIN (SELECT A12.kjmo,
      A14.kmr_unter_kategorie_id,
      A11.wup_id,
      A11.mandant_id,
      COUNT(DISTINCT A11.befragter_id) AS mcx_feststell
     FROM kfl_production_dbp_msi_view_vis.mv_mcx_feedback_2 AS A11
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS A12 ON A11.dat = A12.dat
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_mcx_l_antwort_2 AS A13 ON A11.antwort_id = A13.antwort_id AND A11.kmr_quelle_id
         = A13.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_frage_2 AS A14 ON A13.antwort_id = A14.kmr_frage_id AND A13.kmr_quelle_id
         = A14.kmr_quelle_id
     WHERE A11.ok_fg = 0
      AND A12.akt_gj = - 1
      AND A11.nb_id IN (- 1, 0)
     GROUP BY A12.kjmo,
      A14.kmr_unter_kategorie_id,
      A11.wup_id,
      A11.mandant_id) AS MCX1 ON kmr.mandant_id = MCX1.mandant_id AND kmr.wup_id = MCX1.wup_id AND kmr.kjmo = MCX1.kjmo
     AND kmr.kmr_unter_kategorie_id = MCX1.kmr_unter_kategorie_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_unter_kategorie_2 AS A130 ON kmr.kmr_unter_kategorie_id = A130.kmr_unter_kategorie_id
     
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_kategorie_2 AS A140 ON A130.kmr_kategorie_id = A140.kmr_kategorie_id
     
    LEFT JOIN (SELECT A15.kmr_teilbereich_uk_id,
      A120.kjmo,
      A16.kmr_bereich_id,
      A110.wup_id,
      A110.mandant_id,
      COUNT(DISTINCT A110.befragter_id) AS mcx_gesamt_tb
     FROM kfl_production_dbp_msi_view_vis.mv_mcx_feedback_2 AS A110
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS A120 ON A110.dat = A120.dat
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_mcx_l_antwort_2 AS A131 ON A110.antwort_id = A131.antwort_id AND A110
        .kmr_quelle_id = A131.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_frage_2 AS A141 ON A131.antwort_id = A141.kmr_frage_id AND A131
        .kmr_quelle_id = A141.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_unter_kategorie_2 AS A15 ON A141.kmr_unter_kategorie_id = A15.kmr_unter_kategorie_id
       
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_kategorie_2 AS A16 ON A15.kmr_kategorie_id = A16.kmr_kategorie_id
       
     WHERE A131.gesamt_fg = 1
      AND A120.akt_gj = - 1
      AND A110.nb_id IN (- 1, 0)
     GROUP BY A15.kmr_teilbereich_uk_id,
      A120.kjmo,
      A16.kmr_bereich_id,
      A110.wup_id,
      A110.mandant_id) AS MCX2 ON kmr.mandant_id = MCX2.mandant_id AND kmr.wup_id = MCX2.wup_id AND kmr.kjmo = MCX2.kjmo
         AND A130.kmr_teilbereich_uk_id = MCX2.kmr_teilbereich_uk_id AND A140.kmr_bereich_id = MCX2.kmr_bereich_id
      -- 21 maritz - MCX VJ (Alle Hauptfragen)

   UNION ALL
   SELECT kmr.mandant_id,
    kmr.wup_id,
     kmr.kjmo + 100 AS kjmo,
    kmr.kmr_unter_kategorie_id,
    0 AS kmr_haupfrage,
    1 AS kmr_haupfrage_kvj,
    CAST(NULL AS BIGNUMERIC) AS amx_feststell,
    CAST(NULL AS BIGNUMERIC) AS amx_gesamt,
    CAST(NULL AS BIGINT) AS mcx_feststell,
    CAST(NULL AS BIGINT) AS mcx_gesamt_tb,
    CAST(NULL AS BIGINT) AS geku_chance,
    CAST(NULL AS BIGINT) AS geku_gesamt_cnp,
    CAST(NULL AS BIGNUMERIC) AS amx_feststell_kvj,
    CAST(NULL AS BIGNUMERIC) AS amx_gesamt_kvj,
    MCX1.mcx_feststell AS mcx_feststell_kvj,
    MCX2.mcx_gesamt_tb AS mcx_gesamt_tb_kvj,
    CAST(NULL AS BIGINT) AS geku_chance_kvj,
    CAST(NULL AS BIGINT) AS geku_gesamt_cnp_kvj
   FROM (SELECT *
     FROM (SELECT DISTINCT S01.kmr_unter_kategorie_id,
        S01.kmr_count_fg
       FROM kfl_production_dbp_view.v_kmr_l_unter_kategorie_2 AS S01
        INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu_2 AS S02 ON S01.kmr_unter_kategorie_id = S02.kmr_unter_kategorie_id
         
       WHERE S01.kmr_count_fg = 1
        AND S02.kmr_quelle_id = 2 -- MCX (Maritz)
) AS v01
      INNER JOIN (SELECT mandant_id,
        wup_id,
        nb_id
       FROM kfl_production_dbp_view.v_wup_2
       WHERE nb_id IN (- 1, 0)) AS v02 ON TRUE
      INNER JOIN (SELECT kjmo
       FROM kfl_production_dbp_view.v_monat_2
       WHERE akt_gj = - 2) AS v03 ON TRUE) AS kmr
    LEFT JOIN (SELECT A12.kjmo,
      A14.kmr_unter_kategorie_id,
      A11.wup_id,
      A11.mandant_id,
      COUNT(DISTINCT A11.befragter_id) AS mcx_feststell
     FROM kfl_production_dbp_msi_view_vis.mv_mcx_feedback_2 AS A11
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS A12 ON A11.dat = A12.dat
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_mcx_l_antwort_2 AS A13 ON A11.antwort_id = A13.antwort_id AND A11.kmr_quelle_id
         = A13.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_frage_2 AS A14 ON A13.antwort_id = A14.kmr_frage_id AND A13.kmr_quelle_id
         = A14.kmr_quelle_id
     WHERE A11.ok_fg = 0
      AND A12.akt_gj = - 2
      AND A11.nb_id IN (- 1, 0)
     GROUP BY A12.kjmo,
      A14.kmr_unter_kategorie_id,
      A11.wup_id,
      A11.mandant_id) AS MCX1 ON kmr.mandant_id = MCX1.mandant_id AND kmr.wup_id = MCX1.wup_id AND kmr.kjmo = MCX1.kjmo
     AND kmr.kmr_unter_kategorie_id = MCX1.kmr_unter_kategorie_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_unter_kategorie_2 AS A132 ON kmr.kmr_unter_kategorie_id = A132.kmr_unter_kategorie_id
     
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_kategorie_2 AS A142 ON A132.kmr_kategorie_id = A142.kmr_kategorie_id
     
    LEFT JOIN (SELECT A15.kmr_teilbereich_uk_id,
      A121.kjmo,
      A16.kmr_bereich_id,
      A111.wup_id,
      A111.mandant_id,
      COUNT(DISTINCT A111.befragter_id) AS mcx_gesamt_tb
     FROM kfl_production_dbp_msi_view_vis.mv_mcx_feedback_2 AS A111
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS A121 ON A111.dat = A121.dat
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_mcx_l_antwort_2 AS A133 ON A111.antwort_id = A133.antwort_id AND A111
        .kmr_quelle_id = A133.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_frage_2 AS A143 ON A133.antwort_id = A143.kmr_frage_id AND A133
        .kmr_quelle_id = A143.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_unter_kategorie_2 AS A15 ON A143.kmr_unter_kategorie_id = A15.kmr_unter_kategorie_id
       
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_kategorie_2 AS A16 ON A15.kmr_kategorie_id = A16.kmr_kategorie_id
       
     WHERE A133.gesamt_fg = 1
      AND A121.akt_gj = - 2
      AND A111.nb_id IN (- 1, 0)
     GROUP BY A15.kmr_teilbereich_uk_id,
      A121.kjmo,
      A16.kmr_bereich_id,
      A111.wup_id,
      A111.mandant_id) AS MCX2 ON kmr.mandant_id = MCX2.mandant_id AND kmr.wup_id = MCX2.wup_id AND kmr.kjmo = MCX2.kjmo
         AND A132.kmr_teilbereich_uk_id = MCX2.kmr_teilbereich_uk_id AND A142.kmr_bereich_id = MCX2.kmr_bereich_id
      -- 30 geku - GEKU (Alle Hauptfragen)

   UNION ALL
   SELECT kmr.mandant_id,
    kmr.wup_id,
    kmr.kjmo,
    kmr.kmr_unter_kategorie_id,
    1 AS kmr_haupfrage,
    0 AS kmr_haupfrage_kvj,
    CAST(NULL AS BIGNUMERIC) AS amx_feststell,
    CAST(NULL AS BIGNUMERIC) AS amx_gesamt,
    CAST(NULL AS BIGINT) AS mcx_feststell,
    CAST(NULL AS BIGINT) AS mcx_gesamt_tb,
    GEKU1.geku_chance,
    GEKU2.geku_gesamt_cnp,
    CAST(NULL AS BIGNUMERIC) AS amx_feststell_kvj,
    CAST(NULL AS BIGNUMERIC) AS amx_gesamt_kvj,
    CAST(NULL AS BIGINT) AS mcx_feststell_kvj,
    CAST(NULL AS BIGINT) AS mcx_gesamt_tb_kvj,
    CAST(NULL AS BIGINT) AS geku_chance_kvj,
    CAST(NULL AS BIGINT) AS geku_gesamt_cnp_kvj
   FROM (SELECT *
     FROM (SELECT DISTINCT S01.kmr_unter_kategorie_id,
        S01.kmr_count_fg
       FROM kfl_production_dbp_view.v_kmr_l_unter_kategorie_2 AS S01
        INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu_2 AS S02 ON S01.kmr_unter_kategorie_id = S02.kmr_unter_kategorie_id
         
       WHERE S01.kmr_count_fg = 1
        AND S02.kmr_quelle_id = 3 -- GEKU
) AS v01
      INNER JOIN (SELECT mandant_id,
        wup_id,
        nb_id
       FROM kfl_production_dbp_view.v_wup_2
       WHERE nb_id IN (- 1, 0)) AS v02 ON TRUE
      INNER JOIN (SELECT kjmo
       FROM kfl_production_dbp_view.v_monat_2
       WHERE akt_gj = - 1) AS v03 ON TRUE) AS kmr
    LEFT JOIN (SELECT A12.kjmo,
      A15.kmr_unter_kategorie_id,
      A11.wup_id,
      A11.mandant_id,
      COUNT(DISTINCT A11.geku_ticket_id) AS geku_chance
     FROM kfl_production_dbp_msi_view_vis.mv_geku_f_ticket_2 AS A11
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS A12 ON A11.dat_start = A12.dat
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_geku_l_artikel_2 AS A13 ON A11.geku_artikel_uid = A13.geku_artikel_uid
       
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_geku_l_dwh_artikel_2 AS A14 ON A13.geku_dwh_artikel_id = A14.geku_dwh_artikel_id
         AND A13.kmr_quelle_id = A14.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_frage_2 AS A15 ON A14.geku_dwh_artikel_id = A15.kmr_frage_id AND
        A14.kmr_quelle_id = A15.kmr_quelle_id
     WHERE A11.geku_emotion_id IN (101669)
      AND A12.akt_gj = - 1
      AND A11.nb_id IN (- 1, 0)
     GROUP BY A12.kjmo,
      A15.kmr_unter_kategorie_id,
      A11.wup_id,
      A11.mandant_id) AS GEKU1 ON kmr.kjmo = GEKU1.kjmo AND kmr.kmr_unter_kategorie_id = GEKU1.kmr_unter_kategorie_id
      AND kmr.mandant_id = GEKU1.mandant_id AND kmr.wup_id = GEKU1.wup_id
    LEFT JOIN (SELECT A16.kjmo,
      A112.wup_id,
      A112.mandant_id,
      COUNT(A112.geku_ticket_id) AS geku_gesamt_cnp
     FROM kfl_production_dbp_msi_view_vis.mv_geku_f_ticket_2 AS A112
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_geku_l_artikel_2 AS A122 ON A112.geku_artikel_uid = A122.geku_artikel_uid
       
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_geku_l_dwh_artikel_2 AS A134 ON A122.geku_dwh_artikel_id = A134.geku_dwh_artikel_id
         AND A122.kmr_quelle_id = A134.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_frage_2 AS A144 ON A134.geku_dwh_artikel_id = A144.kmr_frage_id
       AND A134.kmr_quelle_id = A144.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_unter_kategorie_2 AS A150 ON A144.kmr_unter_kategorie_id = A150
       .kmr_unter_kategorie_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS A16 ON A112.dat_start = A16.dat
     WHERE A112.geku_emotion_id IN (101669, 101667, 101668)
      AND A150.kmr_kategorie_id <> - 1
      AND A16.akt_gj = - 1
      AND A112.nb_id IN (- 1, 0)
     GROUP BY A16.kjmo,
      A112.wup_id,
      A112.mandant_id) AS GEKU2 ON kmr.kjmo = GEKU2.kjmo AND kmr.mandant_id = GEKU2.mandant_id AND kmr.wup_id = GEKU2.wup_id
      -- 31 geku - GEKU VJ (Alle Hauptfragen)

   UNION ALL
   SELECT kmr.mandant_id,
    kmr.wup_id,
     kmr.kjmo + 100 AS kjmo,
    kmr.kmr_unter_kategorie_id,
    0 AS kmr_haupfrage,
    1 AS kmr_haupfrage_kvj,
    CAST(NULL AS BIGNUMERIC) AS amx_feststell,
    CAST(NULL AS BIGNUMERIC) AS amx_gesamt,
    CAST(NULL AS BIGINT) AS mcx_feststell,
    CAST(NULL AS BIGINT) AS mcx_gesamt_tb,
    CAST(NULL AS BIGINT) AS geku_chance,
    CAST(NULL AS BIGINT) AS geku_gesamt_cnp,
    CAST(NULL AS BIGNUMERIC) AS amx_feststell_kvj,
    CAST(NULL AS BIGNUMERIC) AS amx_gesamt_kvj,
    CAST(NULL AS BIGINT) AS mcx_feststell_kvj,
    CAST(NULL AS BIGINT) AS mcx_gesamt_tb_kvj,
    GEKU1.geku_chance AS geku_chance_kvj,
    GEKU2.geku_gesamt_cnp AS geku_gesamt_cnp_kvj
   FROM (SELECT *
     FROM (SELECT DISTINCT S01.kmr_unter_kategorie_id,
        S01.kmr_count_fg
       FROM kfl_production_dbp_view.v_kmr_l_unter_kategorie_2 AS S01
        INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu_2 AS S02 ON S01.kmr_unter_kategorie_id = S02.kmr_unter_kategorie_id
         
       WHERE S01.kmr_count_fg = 1
        AND S02.kmr_quelle_id = 3 -- GEKU
) AS v01
      INNER JOIN (SELECT mandant_id,
        wup_id,
        nb_id
       FROM kfl_production_dbp_view.v_wup_2
       WHERE nb_id IN (- 1, 0)) AS v02 ON TRUE
      INNER JOIN (SELECT kjmo
       FROM kfl_production_dbp_view.v_monat_2
       WHERE akt_gj = - 2) AS v03 ON TRUE) AS kmr
    LEFT JOIN (SELECT A12.kjmo,
      A15.kmr_unter_kategorie_id,
      A11.wup_id,
      A11.mandant_id,
      COUNT(DISTINCT A11.geku_ticket_id) AS geku_chance
     FROM kfl_production_dbp_msi_view_vis.mv_geku_f_ticket_2 AS A11
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS A12 ON A11.dat_start = A12.dat
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_geku_l_artikel_2 AS A13 ON A11.geku_artikel_uid = A13.geku_artikel_uid
       
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_geku_l_dwh_artikel_2 AS A14 ON A13.geku_dwh_artikel_id = A14.geku_dwh_artikel_id
         AND A13.kmr_quelle_id = A14.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_frage_2 AS A15 ON A14.geku_dwh_artikel_id = A15.kmr_frage_id AND
        A14.kmr_quelle_id = A15.kmr_quelle_id
     WHERE A11.geku_emotion_id IN (101669)
      AND A12.akt_gj = - 2
      AND A11.nb_id IN (- 1, 0)
     GROUP BY A12.kjmo,
      A15.kmr_unter_kategorie_id,
      A11.wup_id,
      A11.mandant_id) AS GEKU1 ON kmr.kjmo = GEKU1.kjmo AND kmr.kmr_unter_kategorie_id = GEKU1.kmr_unter_kategorie_id
      AND kmr.mandant_id = GEKU1.mandant_id AND kmr.wup_id = GEKU1.wup_id
    LEFT JOIN (SELECT A16.kjmo,
      A113.wup_id,
      A113.mandant_id,
      COUNT(A113.geku_ticket_id) AS geku_gesamt_cnp
     FROM kfl_production_dbp_msi_view_vis.mv_geku_f_ticket_2 AS A113
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_geku_l_artikel_2 AS A123 ON A113.geku_artikel_uid = A123.geku_artikel_uid
       
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_geku_l_dwh_artikel_2 AS A135 ON A123.geku_dwh_artikel_id = A135.geku_dwh_artikel_id
         AND A123.kmr_quelle_id = A135.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_frage_2 AS A145 ON A135.geku_dwh_artikel_id = A145.kmr_frage_id
       AND A135.kmr_quelle_id = A145.kmr_quelle_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_kmr_l_unter_kategorie_2 AS A151 ON A145.kmr_unter_kategorie_id = A151
       .kmr_unter_kategorie_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS A16 ON A113.dat_start = A16.dat
     WHERE A113.geku_emotion_id IN (101669, 101667, 101668)
      AND A151.kmr_kategorie_id <> - 1
      AND A16.akt_gj = - 2
      AND A113.nb_id IN (- 1, 0)
     GROUP BY A16.kjmo,
      A113.wup_id,
      A113.mandant_id) AS GEKU2 ON kmr.kjmo = GEKU2.kjmo AND kmr.mandant_id = GEKU2.mandant_id AND kmr.wup_id = GEKU2.wup_id
      ) AS KMR
WHERE (mandant_id, kmr_unter_kategorie_id) NOT IN (SELECT (mandant_id, kmr_unter_kategorie_id)
   FROM kfl_production_dbp_msi_v_view.v_ts_kmr_mandant_unter_kategorie_ausschluss_2)
GROUP BY mandant_id,
 wup_id,
 kjmo,
 kmr_unter_kategorie_id,
 kmr_count_fg;





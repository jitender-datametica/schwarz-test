CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_L_UNTER_KATEGORIE_WUP_MONAT
AS
   SELECT DISTINCT
   mandant_id,
   wup_id,
   kjmo,
   kmr_unter_kategorie_id,
   1 AS kmr_count_fg -- nicht mehr benötigt
   ,
   MAX(CASE WHEN KMR_HAUPFRAGE > 0 THEN kmr_unter_kategorie_id END) AS kmr_unter_kategorie_id_gj,
   MAX(CASE WHEN KMR_HAUPFRAGE_KVJ >0 THEN kmr_unter_kategorie_id END) AS kmr_unter_kategorie_id_vj,
   MAX(KMR_HAUPFRAGE)       AS kmr_anz_ist,
   MAX(KMR_HAUPFRAGE_KVJ)   AS kmr_anz_kvj,
   MAX(AMX_FESTSTELL)       AS amx_festellungen_ist,
   MAX(AMX_GESAMT)          AS amx_gesamt_ist,
   MAX(AMX_FESTSTELL_KVJ)   AS amx_festellungen_kvj,
   MAX(AMX_GESAMT_KVJ)      AS amx_gesamt_kvj,
   MAX(MCX_FESTSTELL)       AS mcx_festellungen_ist,
   MAX(MCX_GESAMT_TB)       AS mcx_gesamt_ist,
   MAX(MCX_FESTSTELL_KVJ)   AS mcx_festellungen_kvj,
   MAX(MCX_GESAMT_TB_KVJ)   AS mcx_gesamt_kvj,
   MAX(GEKU_CHANCE)         AS geku_chancen_ist,
   MAX(GEKU_GESAMT_CNP)     AS geku_gesamt_ist,
   MAX(GEKU_CHANCE_KVJ)     AS geku_chanchen_kvj,
   MAX(GEKU_GESAMT_CNP_KVJ) AS geku_gesamt_kvj,
   0 AS kvst_potential_ist,
   0 AS kvst_anz_gesamt,
   0 AS kvst_potential_kvj,
   0 AS kvst_gesamt_kvj

  FROM (

  -- 10 audimax - AMX IST (beantwortete Hauptfragen)
  SELECT
  a14.mandant_id,
   a14.wup_id,
   a15.kjmo,
   a16.kmr_unter_kategorie_id,
   1 KMR_HAUPFRAGE,
   0 KMR_HAUPFRAGE_KVJ,
   CAST(CASE WHEN a11.antwort_wert IN (1, 4) THEN 1 ELSE 0 END AS NUMBER(38,5))      AS AMX_FESTSTELL,
   CAST(CASE WHEN a11.antwort_wert IN (0, 1, 4) THEN 1 ELSE 0 END AS NUMBER(38,5))  AS AMX_GESAMT,
   NULL MCX_FESTSTELL,
   NULL MCX_GESAMT_TB,
   NULL GEKU_CHANCE,
   NULL GEKU_GESAMT_CNP,
   NULL AMX_FESTSTELL_KVJ,
   NULL AMX_GESAMT_KVJ,
   NULL MCX_FESTSTELL_KVJ,
   NULL MCX_GESAMT_TB_KVJ,
   NULL GEKU_CHANCE_KVJ,
   NULL GEKU_GESAMT_CNP_KVJ
  FROM dbp_msi_view_vis.mv_amx_frage a11
   JOIN dbp_msi_view_vis.mv_amx_frage_katalog a12
   ON  (a11.amx_frage_katalog_id = a12.amx_frage_katalog_id AND a11.kmr_quelle_id = a12.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_amx_pruef_kapitel a13
   ON  (a11.pruef_kapitel_id = a13.pruef_kapitel_id)
   JOIN dbp_msi_view_vis.mv_amx_pruefung a14
   ON  (a13.pruefung_id = a14.pruefung_id)
   JOIN dbp_msi_view_vis.mv_tag a15
   ON  (a14.dat_ende = a15.dat)
   JOIN dbp_msi_view_vis.mv_kmr_l_frage a16
   ON  (a12.amx_frage_katalog_id = a16.kmr_frage_id AND a12.kmr_quelle_id = a16.kmr_quelle_id)
   JOIN dbp_view.v_wup   a17
   ON (a14.mandant_id = a17.mandant_id AND a14.wup_id = a17.wup_id)
   WHERE a12.amx_handlung_typ_id IN (1, 50000)
   AND     a11.antwort_wert IN (0, 1, 4)
   AND     a15.akt_gj = -1
   AND     a17.nb_id IN (-1, 0)

   -- 11 audimax - AMX VJ (beantwortete Hauptfragen)
   UNION ALL
   SELECT
   a14.mandant_id,
   a14.wup_id,
   a15.kjmo + 100 AS kjmo,
   a16.kmr_unter_kategorie_id,
   0 KMR_HAUPFRAGE,
   1 KMR_HAUPFRAGE_KVJ,
   NULL AMX_FESTSTELL,
   NULL AMX_GESAMT,
   NULL MCX_FESTSTELL,
   NULL MCX_GESAMT_TB,
   NULL GEKU_CHANCE,
   NULL GEKU_GESAMT_CNP,
   CAST( CASE WHEN a11.antwort_wert IN (1, 4) THEN 1 ELSE 0 END AS NUMBER(38,5))     AS AMX_FESTSTELL_KVJ,
   CAST( CASE WHEN a11.antwort_wert IN (0, 1, 4) THEN 1 ELSE 0 END AS NUMBER(38,5))  AS AMX_GESAMT_KVJ,
   NULL MCX_FESTSTELL_KVJ,
   NULL MCX_GESAMT_TB_KVJ,
   NULL GEKU_CHANCE_KVJ,
   NULL GEKU_GESAMT_CNP_KVJ
  FROM dbp_msi_view_vis.mv_amx_frage a11
   JOIN dbp_msi_view_vis.mv_amx_frage_katalog a12
   ON  (a11.amx_frage_katalog_id = a12.amx_frage_katalog_id AND a11.kmr_quelle_id = a12.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_amx_pruef_kapitel a13
   ON  (a11.pruef_kapitel_id = a13.pruef_kapitel_id)
   JOIN dbp_msi_view_vis.mv_amx_pruefung a14
   ON  (a13.pruefung_id = a14.pruefung_id)
   JOIN dbp_msi_view_vis.mv_tag a15
   ON  (a14.dat_ende = a15.dat)
   JOIN dbp_msi_view_vis.mv_kmr_l_frage a16
   ON  (a12.amx_frage_katalog_id = a16.kmr_frage_id AND a12.kmr_quelle_id = a16.kmr_quelle_id)
   JOIN dbp_view.v_wup   a17
   ON (a14.mandant_id = a17.mandant_id AND a14.wup_id = a17.wup_id)
   WHERE a12.amx_handlung_typ_id IN (1, 50000)
   AND     a11.antwort_wert IN (0, 1, 4)
   AND     a15.akt_gj = -2
   AND     a17.nb_id IN (-1, 0)

   -- 20 maritz - MCX IST (Alle Hauptfragen)
   UNION ALL
   SELECT
   kmr.mandant_id,
   kmr.wup_id,
   kmr.kjmo,
   kmr.kmr_unter_kategorie_id,
   1 KMR_HAUPFRAGE,
   0 KMR_HAUPFRAGE_KVJ,
   NULL AMX_FESTSTELL,
   NULL AMX_GESAMT,
   MCX_FESTSTELL,
   MCX_GESAMT_TB,
   NULL GEKU_CHANCE,
   NULL GEKU_GESAMT_CNP,
   NULL AMX_FESTSTELL_KVJ,
   NULL AMX_GESAMT_KVJ,
   NULL MCX_FESTSTELL_KVJ,
   NULL MCX_GESAMT_TB_KVJ,
   NULL GEKU_CHANCE_KVJ,
   NULL GEKU_GESAMT_CNP_KVJ
  FROM (
  SELECT v01.kmr_unter_kategorie_id,
   v01.kmr_count_fg,
   v02.mandant_id,
   v02.wup_id,
   v02.nb_id,
   v03.kjmo
  FROM (
  SELECT DISTINCT s01.kmr_unter_kategorie_id,
   s01.kmr_count_fg
  FROM dbp_view.v_kmr_l_unter_kategorie s01
   JOIN dbp_view.v_kmr_agm_unter_kategorie_zu s02
   ON  s01.kmr_unter_kategorie_id = s02.kmr_unter_kategorie_id
   WHERE kmr_count_fg = 1 AND s02.kmr_quelle_id = 2 -- MCX (Maritz)
   ) v01
   CROSS JOIN (SELECT mandant_id,
   wup_id,
   nb_id FROM dbp_view.v_wup WHERE nb_id IN (-1, 0)) v02
   CROSS JOIN (SELECT kjmo FROM dbp_view.v_monat WHERE akt_gj =-1) v03
   ) kmr
   LEFT OUTER JOIN (
   SELECT
   a12.kjmo,
   kmr_unter_kategorie_id,
   wup_id,
   mandant_id,
   COUNT(DISTINCT a11.befragter_id)  MCX_FESTSTELL
  FROM dbp_msi_view_vis.mv_mcx_feedback a11
   JOIN dbp_msi_view_vis.mv_tag a12
   ON  (a11.dat = a12.dat)
   JOIN dbp_msi_view_vis.mv_mcx_l_antwort a13
   ON  (a11.antwort_id = a13.antwort_id AND a11.kmr_quelle_id = a13.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_frage a14
   ON  (a13.antwort_id = a14.kmr_frage_id AND a13.kmr_quelle_id = a14.kmr_quelle_id)
   WHERE a11.ok_fg = 0
   AND     a12.akt_gj = -1
   AND     a11.nb_id IN (-1, 0)
   GROUP BY a12.kjmo, a14.kmr_unter_kategorie_id, a11.wup_id, a11.mandant_id
   ) MCX1
   ON  kmr.mandant_id = MCX1.mandant_id AND kmr.wup_id = MCX1.wup_id
   AND kmr.kjmo = MCX1.kjmo AND kmr.kmr_unter_kategorie_id = MCX1.kmr_unter_kategorie_id

   JOIN dbp_msi_view_vis.mv_kmr_l_unter_kategorie a13
   ON  (KMR.kmr_unter_kategorie_id = a13.kmr_unter_kategorie_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_kategorie a14
   ON  (a13.kmr_kategorie_id = a14.kmr_kategorie_id)
   LEFT OUTER JOIN (
   SELECT
   a15.kmr_teilbereich_uk_id  kmr_teilbereich_uk_id,
   a12.kjmo  kjmo,
   a16.kmr_bereich_id  kmr_bereich_id,
   a11.wup_id  wup_id,
   a11.mandant_id  mandant_id,
   COUNT(DISTINCT a11.befragter_id)  MCX_GESAMT_TB
   FROM dbp_msi_view_vis.mv_mcx_feedback a11
   JOIN dbp_msi_view_vis.mv_tag a12
   ON  (a11.dat = a12.dat)
   JOIN dbp_msi_view_vis.mv_mcx_l_antwort a13
   ON  (a11.antwort_id = a13.antwort_id AND a11.kmr_quelle_id = a13.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_frage a14
   ON  (a13.antwort_id = a14.kmr_frage_id AND a13.kmr_quelle_id = a14.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_unter_kategorie a15
   ON  (a14.kmr_unter_kategorie_id = a15.kmr_unter_kategorie_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_kategorie a16
   ON  (a15.kmr_kategorie_id = a16.kmr_kategorie_id)
   WHERE a13.gesamt_fg = 1
   AND     a12.akt_gj = -1
   AND     a11.nb_id IN (-1, 0)
   GROUP BY a15.kmr_teilbereich_uk_id, a12.kjmo, a16.kmr_bereich_id, a11.wup_id, a11.mandant_id
   ) MCX2
   ON  KMR.mandant_id = MCX2.mandant_id
   AND KMR.wup_id = MCX2.wup_id
   AND KMR.kjmo = MCX2.kjmo
   AND a13.kmr_teilbereich_uk_id = MCX2.kmr_teilbereich_uk_id
   AND a14.kmr_bereich_id = MCX2.kmr_bereich_id

   -- 21 maritz - MCX VJ (Alle Hauptfragen)
   UNION ALL
   SELECT
   kmr.mandant_id,
   kmr.wup_id,
   kmr.kjmo + 100 AS kjmo,
   kmr.kmr_unter_kategorie_id,
   0 KMR_HAUPFRAGE,
   1 KMR_HAUPFRAGE_KVJ,
   NULL AMX_FESTSTELL,
   NULL AMX_GESAMT,
   NULL MCX_FESTSTELL,
   NULL MCX_GESAMT_TB,
   NULL GEKU_CHANCE,
   NULL GEKU_GESAMT_CNP,
   NULL AMX_FESTSTELL_KVJ,
   NULL AMX_GESAMT_KVJ,
   MCX_FESTSTELL AS  MCX_FESTSTELL_KVJ,
   MCX_GESAMT_TB AS  MCX_GESAMT_TB_KVJ,
   NULL GEKU_CHANCE_KVJ,
   NULL GEKU_GESAMT_CNP_KVJ
  FROM (
  SELECT v01.kmr_unter_kategorie_id,
   v01.kmr_count_fg,
   v02.mandant_id,
   v02.wup_id,
   v02.nb_id,
   v03.kjmo
  FROM (
  SELECT DISTINCT s01.kmr_unter_kategorie_id,
   s01.kmr_count_fg
  FROM dbp_view.v_kmr_l_unter_kategorie s01
   JOIN dbp_view.v_kmr_agm_unter_kategorie_zu s02
   ON  s01.kmr_unter_kategorie_id = s02.kmr_unter_kategorie_id
   WHERE kmr_count_fg = 1 AND s02.kmr_quelle_id = 2 -- MCX (Maritz)
   ) v01
   CROSS JOIN (SELECT mandant_id,
   wup_id,
   nb_id FROM dbp_view.v_wup WHERE nb_id IN (-1, 0)) v02
   CROSS JOIN (SELECT kjmo FROM dbp_view.v_monat WHERE akt_gj = -2) v03
   ) kmr
   LEFT OUTER JOIN (
   SELECT
   a12.kjmo,
   kmr_unter_kategorie_id,
   wup_id,
   mandant_id,
   COUNT(DISTINCT a11.befragter_id)  MCX_FESTSTELL
  FROM dbp_msi_view_vis.mv_mcx_feedback a11
   JOIN dbp_msi_view_vis.mv_tag a12
   ON  (a11.dat = a12.dat)
   JOIN dbp_msi_view_vis.mv_mcx_l_antwort a13
   ON  (a11.antwort_id = a13.antwort_id AND a11.kmr_quelle_id = a13.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_frage a14
   ON  (a13.antwort_id = a14.kmr_frage_id AND a13.kmr_quelle_id = a14.kmr_quelle_id)
   WHERE a11.ok_fg = 0
   AND     a12.akt_gj = -2
   AND     a11.nb_id IN (-1, 0)
   GROUP BY a12.kjmo, a14.kmr_unter_kategorie_id, a11.wup_id, a11.mandant_id
   ) MCX1
   ON  kmr.mandant_id = MCX1.mandant_id AND kmr.wup_id = MCX1.wup_id
   AND kmr.kjmo = MCX1.kjmo AND kmr.kmr_unter_kategorie_id = MCX1.kmr_unter_kategorie_id

   JOIN dbp_msi_view_vis.mv_kmr_l_unter_kategorie a13
   ON  (KMR.kmr_unter_kategorie_id = a13.kmr_unter_kategorie_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_kategorie a14
   ON  (a13.kmr_kategorie_id = a14.kmr_kategorie_id)
   LEFT OUTER JOIN (
   SELECT
   a15.kmr_teilbereich_uk_id  kmr_teilbereich_uk_id,
   a12.kjmo  kjmo,
   a16.kmr_bereich_id  kmr_bereich_id,
   a11.wup_id  wup_id,
   a11.mandant_id  mandant_id,
   COUNT(DISTINCT a11.befragter_id)  MCX_GESAMT_TB
   FROM dbp_msi_view_vis.mv_mcx_feedback a11
   JOIN dbp_msi_view_vis.mv_tag a12
   ON  (a11.dat = a12.dat)
   JOIN dbp_msi_view_vis.mv_mcx_l_antwort a13
   ON  (a11.antwort_id = a13.antwort_id AND a11.kmr_quelle_id = a13.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_frage a14
   ON  (a13.antwort_id = a14.kmr_frage_id AND a13.kmr_quelle_id = a14.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_unter_kategorie a15
   ON  (a14.kmr_unter_kategorie_id = a15.kmr_unter_kategorie_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_kategorie a16
   ON  (a15.kmr_kategorie_id = a16.kmr_kategorie_id)
   WHERE a13.gesamt_fg = 1
   AND     a12.akt_gj = -2
   AND     a11.nb_id IN (-1, 0)
   GROUP BY a15.kmr_teilbereich_uk_id, a12.kjmo, a16.kmr_bereich_id, a11.wup_id, a11.mandant_id
   ) MCX2
   ON  KMR.mandant_id = MCX2.mandant_id
   AND KMR.wup_id = MCX2.wup_id
   AND KMR.kjmo = MCX2.kjmo
   AND a13.kmr_teilbereich_uk_id = MCX2.kmr_teilbereich_uk_id
   AND a14.kmr_bereich_id = MCX2.kmr_bereich_id

   -- 30 geku - GEKU (Alle Hauptfragen)
   UNION ALL
   SELECT
   kmr.mandant_id,
   kmr.wup_id,
   kmr.kjmo,
   kmr.kmr_unter_kategorie_id,
   1 KMR_HAUPFRAGE,
   0 KMR_HAUPFRAGE_KVJ,
   NULL AMX_FESTSTELL,
   NULL AMX_GESAMT,
   NULL MCX_FESTSTELL,
   NULL MCX_GESAMT_TB,
   GEKU_CHANCE,
   GEKU_GESAMT_CNP,
   NULL AMX_FESTSTELL_KVJ,
   NULL AMX_GESAMT_KVJ,
   NULL MCX_FESTSTELL_KVJ,
   NULL MCX_GESAMT_TB_KVJ,
   NULL GEKU_CHANCE_KVJ,
   NULL GEKU_GESAMT_CNP_KVJ
  FROM (
  SELECT v01.kmr_unter_kategorie_id,
   v01.kmr_count_fg,
   v02.mandant_id,
   v02.wup_id,
   v02.nb_id,
   v03.kjmo
  FROM (
  SELECT DISTINCT s01.kmr_unter_kategorie_id,
   s01.kmr_count_fg
  FROM dbp_view.v_kmr_l_unter_kategorie s01
   JOIN dbp_view.v_kmr_agm_unter_kategorie_zu s02
   ON  s01.kmr_unter_kategorie_id = s02.kmr_unter_kategorie_id
   WHERE kmr_count_fg = 1 AND s02.kmr_quelle_id = 3 -- GEKU
   ) v01
   CROSS JOIN (SELECT mandant_id,
   wup_id,
   nb_id FROM dbp_view.v_wup WHERE nb_id IN (-1, 0)) v02
   CROSS JOIN (SELECT kjmo FROM dbp_view.v_monat WHERE akt_gj = -1) v03
   ) kmr
   LEFT OUTER JOIN (
   SELECT
   a12.kjmo,
   a15.kmr_unter_kategorie_id,
   a11.wup_id,
   a11.mandant_id,
   COUNT(DISTINCT a11.geku_ticket_id)  GEKU_CHANCE
  FROM dbp_msi_view_vis.mv_geku_f_ticket a11
   JOIN dbp_msi_view_vis.mv_tag a12
   ON  (a11.dat_start = a12.dat)
   JOIN dbp_msi_view_vis.mv_geku_l_artikel a13
   ON  (a11.geku_artikel_uid = a13.geku_artikel_uid)
   JOIN dbp_msi_view_vis.mv_geku_l_dwh_artikel a14
   ON  (a13.geku_dwh_artikel_id = a14.geku_dwh_artikel_id AND a13.kmr_quelle_id = a14.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_frage a15
   ON  (a14.geku_dwh_artikel_id = a15.kmr_frage_id AND a14.kmr_quelle_id = a15.kmr_quelle_id)
   WHERE a11.geku_emotion_id IN (101669)
   AND     a12.akt_gj = -1
   AND     a11.nb_id IN (-1, 0)
   GROUP BY a12.kjmo, a15.kmr_unter_kategorie_id, a11.wup_id, a11.mandant_id
   ) GEKU1
   ON  kmr.kjmo = GEKU1.kjmo
   AND kmr.kmr_unter_kategorie_id = GEKU1.kmr_unter_kategorie_id
   AND kmr.mandant_id = GEKU1.mandant_id
   AND kmr.wup_id = GEKU1.wup_id
   LEFT OUTER JOIN (
   SELECT
   a16.kjmo,
   a11.wup_id,
   a11.mandant_id,
   COUNT(a11.geku_ticket_id)  GEKU_GESAMT_CNP
  FROM dbp_msi_view_vis.mv_geku_f_ticket a11
   JOIN dbp_msi_view_vis.mv_geku_l_artikel a12
   ON  (a11.geku_artikel_uid = a12.geku_artikel_uid)
   JOIN dbp_msi_view_vis.mv_geku_l_dwh_artikel a13
   ON  (a12.geku_dwh_artikel_id = a13.geku_dwh_artikel_id AND a12.kmr_quelle_id = a13.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_frage a14
   ON  (a13.geku_dwh_artikel_id = a14.kmr_frage_id AND a13.kmr_quelle_id = a14.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_unter_kategorie a15
   ON  (a14.kmr_unter_kategorie_id = a15.kmr_unter_kategorie_id)
   JOIN dbp_msi_view_vis.mv_tag a16
   ON  (a11.dat_start = a16.dat)
   WHERE (a11.geku_emotion_id IN (101669, 101667, 101668)
   AND a15.kmr_kategorie_id <> -1)
   AND     a16.akt_gj = -1
   AND     a11.nb_id IN (-1, 0)
   GROUP BY a16.kjmo,a11.wup_id, a11.mandant_id
   ) GEKU2
   ON    kmr.kjmo = GEKU2.kjmo
   AND kmr.mandant_id = GEKU2.mandant_id
   AND kmr.wup_id = GEKU2.wup_id

   -- 31 geku - GEKU VJ (Alle Hauptfragen)
   UNION ALL
   SELECT
   kmr.mandant_id,
   kmr.wup_id,
   kmr.kjmo + 100 AS kjmo,
   kmr.kmr_unter_kategorie_id,
   0 KMR_HAUPFRAGE,
   1 KMR_HAUPFRAGE_KVJ,
   NULL AMX_FESTSTELL,
   NULL AMX_GESAMT,
   NULL MCX_FESTSTELL,
   NULL MCX_GESAMT_TB,
   NULL GEKU_CHANCE,
   NULL GEKU_GESAMT_CNP,
   NULL AMX_FESTSTELL_KVJ,
   NULL AMX_GESAMT_KVJ,
   NULL MCX_FESTSTELL_KVJ,
   NULL MCX_GESAMT_TB_KVJ,
   GEKU_CHANCE AS GEKU_CHANCE_KVJ,
   GEKU_GESAMT_CNP AS GEKU_GESAMT_CNP_KVJ
  FROM (
  SELECT v01.kmr_unter_kategorie_id,
   v01.kmr_count_fg,
   v02.mandant_id,
   v02.wup_id,
   v02.nb_id,
   v03.kjmo
  FROM (
  SELECT DISTINCT s01.kmr_unter_kategorie_id,
   s01.kmr_count_fg
  FROM dbp_view.v_kmr_l_unter_kategorie s01
   JOIN dbp_view.v_kmr_agm_unter_kategorie_zu s02
   ON  s01.kmr_unter_kategorie_id = s02.kmr_unter_kategorie_id
   WHERE kmr_count_fg = 1 AND s02.kmr_quelle_id = 3 -- GEKU
   ) v01
   CROSS JOIN (SELECT mandant_id,
   wup_id,
   nb_id FROM dbp_view.v_wup WHERE nb_id IN (-1, 0)) v02
   CROSS JOIN (SELECT kjmo FROM dbp_view.v_monat WHERE akt_gj =-2) v03
   ) kmr
   LEFT OUTER JOIN (
   SELECT
   a12.kjmo,
   a15.kmr_unter_kategorie_id,
   a11.wup_id,
   a11.mandant_id,
   COUNT(DISTINCT a11.geku_ticket_id)  GEKU_CHANCE
  FROM dbp_msi_view_vis.mv_geku_f_ticket a11
   JOIN dbp_msi_view_vis.mv_tag a12
   ON  (a11.dat_start = a12.dat)
   JOIN dbp_msi_view_vis.mv_geku_l_artikel a13
   ON  (a11.geku_artikel_uid = a13.geku_artikel_uid)
   JOIN dbp_msi_view_vis.mv_geku_l_dwh_artikel a14
   ON  (a13.geku_dwh_artikel_id = a14.geku_dwh_artikel_id AND a13.kmr_quelle_id = a14.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_frage a15
   ON  (a14.geku_dwh_artikel_id = a15.kmr_frage_id AND a14.kmr_quelle_id = a15.kmr_quelle_id)
   WHERE a11.geku_emotion_id IN (101669)
   AND     a12.akt_gj = -2
   AND     a11.nb_id IN (-1, 0)
   GROUP BY a12.kjmo, a15.kmr_unter_kategorie_id, a11.wup_id, a11.mandant_id
   ) GEKU1
   ON  kmr.kjmo = GEKU1.kjmo
   AND kmr.kmr_unter_kategorie_id = GEKU1.kmr_unter_kategorie_id
   AND kmr.mandant_id = GEKU1.mandant_id
   AND kmr.wup_id = GEKU1.wup_id
   LEFT OUTER JOIN (
   SELECT
   a16.kjmo,
   a11.wup_id,
   a11.mandant_id,
   COUNT(a11.geku_ticket_id)  GEKU_GESAMT_CNP
  FROM dbp_msi_view_vis.mv_geku_f_ticket a11
   JOIN dbp_msi_view_vis.mv_geku_l_artikel a12
   ON  (a11.geku_artikel_uid = a12.geku_artikel_uid)
   JOIN dbp_msi_view_vis.mv_geku_l_dwh_artikel a13
   ON  (a12.geku_dwh_artikel_id = a13.geku_dwh_artikel_id AND a12.kmr_quelle_id = a13.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_frage a14
   ON  (a13.geku_dwh_artikel_id = a14.kmr_frage_id AND a13.kmr_quelle_id = a14.kmr_quelle_id)
   JOIN dbp_msi_view_vis.mv_kmr_l_unter_kategorie a15
   ON  (a14.kmr_unter_kategorie_id = a15.kmr_unter_kategorie_id)
   JOIN dbp_msi_view_vis.mv_tag a16
   ON  (a11.dat_start = a16.dat)
   WHERE (a11.geku_emotion_id IN (101669, 101667, 101668)
   AND a15.kmr_kategorie_id <> -1)
   AND     a16.akt_gj = -2
   AND     a11.nb_id IN (-1, 0)
   GROUP BY a16.kjmo,a11.wup_id, a11.mandant_id
   ) GEKU2
   ON    kmr.kjmo = GEKU2.kjmo
   AND kmr.mandant_id = GEKU2.mandant_id
   AND kmr.wup_id = GEKU2.wup_id


   ) KMR

   WHERE (mandant_id, kmr_unter_kategorie_id) NOT IN (SELECT mandant_id,
   kmr_unter_kategorie_id FROM dbp_msi_v_view.v_ts_kmr_mandant_unter_kategorie_ausschluss)

  GROUP BY mandant_id, wup_id, kjmo, kmr_unter_kategorie_id, kmr_count_fg
   ;
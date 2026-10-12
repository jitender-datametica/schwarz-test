CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_werbeaenderungen_dat_beladung_anzahl AS WITH ART_IN_RANK
 AS (SELECT mandant_id,
   aktion_id,
   offer_id,
   art_id,
   dat_ab,
   dat_bis,
   dat_beladung,
   ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), aktion_id, CAST(offer_id AS STRING), CAST(art_id AS STRING)
      , dat_ab, dat_bis ORDER BY dat_beladung IS NULL, dat_beladung) AS rk
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen AS V1
  GROUP BY mandant_id,
   aktion_id,
   offer_id,
   art_id,
   dat_ab,
   dat_bis,
   dat_beladung), ERSTELLUNGSDATUM AS (SELECT art_id,
   mandant_id,
   dat_ab,
   dat_bis,
   kjwo,
   MIN(dat_beladung) AS erstellungsdatum
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen AS WBS_W
  GROUP BY art_id,
   mandant_id,
   dat_ab,
   dat_bis,
   kjwo), ART_IN_OUT AS (SELECT WBS_W0.art_id,
   WBS_W0.mandant_id,
   WBS_W0.dat_ab,
   WBS_W0.dat_bis,
   WBS_W0.kjwo,
   WBS_W0.aktion_id,
   WBS_W0.offer_id,
   WBS_W0.dat_beladung,
   DATE_DIFF(WBS_W0.dat_ab, erdt.erstellungsdatum, DAY) AS days_to_promo,
   SUM(WBS_W0.werbeaenderung_artikelentfernung_fg) AS anzahl_artikelentfernung,
   SUM(WBS_W0.werbeaenderung_artikelneuanlage_fg) AS anzahl_artikelneuanlage,
   COUNT(DISTINCT WBS_W0.wup_id) AS wup_id_count_datb,
    CASE
    WHEN SUM(WBS_W0.werbeaenderung_artikelneuanlage_fg) = COUNT(DISTINCT WBS_W0.wup_id) AND t2.rk = 1 AND DATE_DIFF(WBS_W0
        .dat_ab, erdt.erstellungsdatum, DAY) <= 42 OR SUM(WBS_W0.werbeaenderung_artikelneuanlage_fg) = COUNT(DISTINCT
         WBS_W0.wup_id) AND DATE_DIFF(WBS_W0.dat_ab, erdt.erstellungsdatum, DAY) > 42 AND t2.rk <> 1
    THEN 1
    ELSE 0
    END AS artikelneuanlage_art_fg,
   IF(SUM(WBS_W0.werbeaenderung_artikelentfernung_fg) = COUNT(DISTINCT WBS_W0.wup_id), 1, 0) AS artikelentfernung_art_fg
   
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen AS WBS_W0
   INNER JOIN ART_IN_RANK AS t2 ON WBS_W0.art_id = t2.art_id AND WBS_W0.mandant_id = t2.mandant_id AND WBS_W0.dat_ab =
         t2.dat_ab AND WBS_W0.dat_bis = t2.dat_bis AND WBS_W0.aktion_id = t2.aktion_id AND WBS_W0.offer_id = t2.offer_id
       AND WBS_W0.dat_beladung = t2.dat_beladung
   INNER JOIN ERSTELLUNGSDATUM AS erdt ON WBS_W0.art_id = erdt.art_id AND WBS_W0.mandant_id = erdt.mandant_id AND WBS_W0
      .dat_ab = erdt.dat_ab AND WBS_W0.dat_bis = erdt.dat_bis
  GROUP BY WBS_W0.art_id,
   WBS_W0.mandant_id,
   WBS_W0.dat_ab,
   WBS_W0.dat_bis,
   WBS_W0.kjwo,
   WBS_W0.aktion_id,
   WBS_W0.offer_id,
   WBS_W0.dat_beladung,
   t2.rk,
   erdt.erstellungsdatum) (SELECT DISTINCT WBS_W.art_id,
   WBS_W.mandant_id,
   WBS_W.dat_ab,
   WBS_W.dat_bis,
   WBS_W.kjwo,
   WBS_W.aktion_id,
   WBS_W.offer_id,
   COUNT(DISTINCT WBS_W.wup_id) AS wup_id_count,
   ed.erstellungsdatum,
    CASE
    WHEN WBS_W.werbeaenderung_normalpreiserhoehung_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_normalpreiserhoehung_fg,
    CASE
    WHEN WBS_W.werbeaenderung_normalpreisreduktion_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_normalpreisreduktion_fg,
    CASE
    WHEN WBS_W.werbeaenderung_angebotspreiserhoehung_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_angebotspreiserhoehung_fg,
    CASE
    WHEN WBS_W.werbeaenderung_angebotspreisreduktion_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_angebotspreisreduktion_fg,
    CASE
    WHEN t9.artikelentfernung_art_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_artikelentfernung_fg,
    CASE
    WHEN t9.artikelneuanlage_art_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_artikelneuanlage_fg,
    CASE
    WHEN WBS_W.werbeaenderung_marktanzahlerhoehung_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_marktanzahlerhoehung_fg,
    CASE
    WHEN WBS_W.werbeaenderung_marktanzahlreduktion_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_marktanzahlreduktion_fg,
    CASE
    WHEN WBS_W.werbeaenderung_radio_tv_billboard_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_radio_tv_billboard_fg,
    CASE
    WHEN WBS_W.werbeaenderung_abbildungsaenderung_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_abbildungsaenderung_fg,
    CASE
    WHEN WBS_W.werbeaenderung_werbethema_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_werbethema_fg,
    CASE
    WHEN WBS_W.werbeaenderung_sonstiges_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_sonstiges_fg,
    CASE
    WHEN WBS_W.werbeaenderung_kundenkarte_personalisiert_fg = 1
    THEN CAST(COUNT(DISTINCT WBS_W.dat_beladung) AS INTEGER)
    ELSE 0
    END AS count_werbeaenderung_kundenkarte_personalisiert_fg
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen AS WBS_W
   INNER JOIN ART_IN_OUT AS t9 ON WBS_W.art_id = t9.art_id AND WBS_W.mandant_id = t9.mandant_id AND WBS_W.dat_ab = t9.dat_ab
          AND WBS_W.dat_bis = t9.dat_bis AND WBS_W.aktion_id = t9.aktion_id AND WBS_W.offer_id = t9.offer_id AND WBS_W.dat_beladung
      = t9.dat_beladung
   INNER JOIN ERSTELLUNGSDATUM AS ed ON WBS_W.art_id = ed.art_id AND WBS_W.mandant_id = ed.mandant_id AND WBS_W.dat_ab =
      ed.dat_ab AND WBS_W.dat_bis = ed.dat_bis
  GROUP BY WBS_W.art_id,
   WBS_W.mandant_id,
   WBS_W.dat_ab,
   WBS_W.dat_bis,
   WBS_W.kjwo,
   WBS_W.aktion_id,
   WBS_W.offer_id,
   ed.erstellungsdatum,
   WBS_W.werbeaenderung_normalpreiserhoehung_fg,
   WBS_W.werbeaenderung_normalpreisreduktion_fg,
   WBS_W.werbeaenderung_angebotspreiserhoehung_fg,
   WBS_W.werbeaenderung_angebotspreisreduktion_fg,
   t9.artikelentfernung_art_fg,
   t9.artikelneuanlage_art_fg,
   WBS_W.werbeaenderung_marktanzahlerhoehung_fg,
   WBS_W.werbeaenderung_marktanzahlreduktion_fg,
   WBS_W.werbeaenderung_radio_tv_billboard_fg,
   WBS_W.werbeaenderung_abbildungsaenderung_fg,
   WBS_W.werbeaenderung_werbethema_fg,
   WBS_W.werbeaenderung_sonstiges_fg,
   WBS_W.werbeaenderung_kundenkarte_personalisiert_fg);
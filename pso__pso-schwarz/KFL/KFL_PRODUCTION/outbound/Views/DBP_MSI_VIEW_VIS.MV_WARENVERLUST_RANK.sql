CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_warenverlust_rank (mandant_id
OPTIONS(description='Mandant im DWH'), vs_id OPTIONS(description='ID der Vertriebsschiene'), wup_id
OPTIONS(description='Der\""WUP\"" beinhaltet Märkte und Lager. WUP = WarenUmschlagsPlatz. Mutter WUP ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
art_id
OPTIONS(description='Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
wg_hist_id OPTIONS(description='ID der Warengruppe'), owg_hist_id OPTIONS(description='ID der Oberwarengruppe'),
hwg_hist_id OPTIONS(description='ID der Hauptwarengruppe'), abt_hist_id
OPTIONS(description='Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), inventurart_id
OPTIONS(description='Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.'),
dat_inventur_von
OPTIONS(description='Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.'),
dat_inventur_bis
OPTIONS(description='Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.'),
gj
OPTIONS(description='Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.'),
inventur_id OPTIONS(description='Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads'),
wv_umsatz_netto_wup
OPTIONS(description='Umsatz der betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb'),
wv_inventur_netto_wup
OPTIONS(description='Saldierte Inventur-Differenz-Werte je Artikel und Betrieb im definierten Inventur-Zeitraum'),
wv_menge_inventur_wup
OPTIONS(description='Saldierte Inventur-Differenz-Mengen je Artikel und Betrieb im definierten Inventur-Zeitraum'),
wv_umsatz_netto_aufg_wup
OPTIONS(description='Aufgelaufener Umsatz der betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb'),
wv_inventur_netto_aufg_wup
OPTIONS(description='Aufgelaufene Saldierte Inventur-Differenz-Werte je Artikel und Betrieb im definierten Inventur-Zeitraum'),
wv_menge_inventur_aufg_wup
OPTIONS(description='Aufgelaufene Saldierte Inventur-Differenz-Mengen je Artikel und Betrieb im definierten Inventur-Zeitraum'),
art_wup_fg OPTIONS(description='Flag for first appearance of an article for one store and one business year'), art_vs_fg
OPTIONS(description='Flag for first appearance of an article for one region and one business year'), art_mdt_fg
OPTIONS(description='Flag for first appearance of an article for one country and one business year'),
wv_inventur_netto_quote OPTIONS(description='Anteil von Inventurdifferenz zu Umsatz (auf Filialebene)'),
wv_inventur_netto_aufg_quote
OPTIONS(description='Anteil von aufgelaufener Inventurdifferenz zu aufgelaufenem Umsatz (auf Filialebene)'),
wv_inventur_netto_vs
OPTIONS(description='Inventurdifferenz aggregiert auf Regionsebene (nur einmal pro Region und nicht für alle Zeilen berechnet)'),
wv_umsatz_netto_vs
OPTIONS(description='Umsatz aggregiert auf Regionsebene (nur einmal pro Region und nicht für alle Zeilen berechnet)'),
wv_inventur_netto_mdt
OPTIONS(description='Inventurdifferenz aggregiert auf Landesebene (nur einmal pro Land und nicht für alle Zeilen berechnet)'),
wv_umsatz_netto_mdt
OPTIONS(description='Umsatz aggregiert auf Landesebene (nur einmal pro Land und nicht für alle Zeilen berechnet)'),
wv_inventur_netto_rank OPTIONS(description='Ranking nach Inventurdifferenz'), wv_inventur_netto_rank_aufg
OPTIONS(description='Ranking nach aufgelaufener Inventurdifferenz'), wv_inventur_netto_rank_vs
OPTIONS(description='Ranking nach Inventurdifferenz pro Region'), wv_inventur_netto_rank_mdt
OPTIONS(description='Ranking nach Inventurdifferenz pro Land')) AS WITH FACTS_INVENTUR_WARENVERLUST AS (SELECT I.mandant_id
   ,
   W.vs_id,
   I.wup_id,
   I.art_id,
   I.wg_hist_id,
   I.owg_hist_id,
   I.hwg_hist_id,
   I.abt_hist_id,
   I.wrg_id,
   I.inventurart_id,
   I.dat_inventur_von,
   I.dat_inventur_bis,
   I.gj,
   I.inventur_id,
   I.wv_umsatz_netto,
   I.wv_inventur_netto,
   I.wv_menge_inventur,
   I.wv_umsatz_netto_aufg,
   I.wv_inventur_netto_aufg,
   I.wv_menge_inventur_aufg
  FROM kfl_production_dbp_msi_view_vis.mv_warenverlust AS I
   LEFT JOIN kfl_production_dbp_msi_view_vis.mv_wup AS W USING (mandant_id, wup_id)
  WHERE I.inventurart_id = 3
  QUALIFY (DENSE_RANK() OVER (PARTITION BY I.mandant_id, W.vs_id, I.wup_id, I.wrg_id ORDER BY I.mandant_id NULLS LAST, W
        .vs_id NULLS LAST, I.wup_id NULLS LAST, I.wrg_id NULLS LAST, I.dat_inventur_bis DESC NULLS FIRST)) <= 3),
 FACTS_FLAGGED AS (SELECT mandant_id,
   vs_id,
   wup_id,
   art_id,
   wg_hist_id,
   owg_hist_id,
   hwg_hist_id,
   abt_hist_id,
   wrg_id,
   inventurart_id,
   dat_inventur_von,
   dat_inventur_bis,
   gj,
   inventur_id,
   wv_umsatz_netto,
   wv_inventur_netto,
   wv_menge_inventur,
   wv_umsatz_netto_aufg,
   wv_inventur_netto_aufg,
   wv_menge_inventur_aufg,
   ROW_NUMBER() OVER (PARTITION BY mandant_id, vs_id, wup_id, wrg_id, art_id, gj ORDER BY mandant_id NULLS LAST, vs_id
      NULLS LAST, wup_id NULLS LAST, wrg_id NULLS LAST, art_id NULLS LAST, gj NULLS LAST, dat_inventur_bis DESC
      NULLS FIRST) AS art_wup_nr,
   IF((ROW_NUMBER() OVER (PARTITION BY mandant_id, vs_id, wup_id, wrg_id, art_id, gj ORDER BY mandant_id NULLS LAST,
         vs_id NULLS LAST, wup_id NULLS LAST, wrg_id NULLS LAST, art_id NULLS LAST, gj NULLS LAST, dat_inventur_bis DESC
         NULLS FIRST)) = 1, ROW_NUMBER() OVER (PARTITION BY mandant_id, vs_id, wup_id, wrg_id, art_id, gj ORDER BY
       mandant_id NULLS LAST, vs_id NULLS LAST, wup_id NULLS LAST, wrg_id NULLS LAST, art_id NULLS LAST, gj NULLS LAST,
       dat_inventur_bis DESC NULLS FIRST), 0) AS art_wup_fg,
   ROW_NUMBER() OVER (PARTITION BY mandant_id, vs_id, wrg_id, art_id, gj ORDER BY mandant_id NULLS LAST, vs_id
      NULLS LAST, wup_id NULLS LAST, wrg_id NULLS LAST, art_id NULLS LAST, gj NULLS LAST, dat_inventur_bis DESC
      NULLS FIRST) AS art_vs_nr,
   IF((ROW_NUMBER() OVER (PARTITION BY mandant_id, vs_id, wrg_id, art_id, gj ORDER BY mandant_id NULLS LAST, vs_id
         NULLS LAST, wup_id NULLS LAST, wrg_id NULLS LAST, art_id NULLS LAST, gj NULLS LAST, dat_inventur_bis DESC
         NULLS FIRST)) = 1, ROW_NUMBER() OVER (PARTITION BY mandant_id, vs_id, wrg_id, art_id, gj ORDER BY mandant_id
       NULLS LAST, vs_id NULLS LAST, wup_id NULLS LAST, wrg_id NULLS LAST, art_id NULLS LAST, gj NULLS LAST,
       dat_inventur_bis DESC NULLS FIRST), 0) AS art_vs_fg,
   ROW_NUMBER() OVER (PARTITION BY mandant_id, wrg_id, art_id, gj ORDER BY mandant_id NULLS LAST, vs_id NULLS LAST,
      wup_id NULLS LAST, wrg_id NULLS LAST, art_id NULLS LAST, gj NULLS LAST, dat_inventur_bis DESC NULLS FIRST) AS
   art_mandant_nr,
   IF((ROW_NUMBER() OVER (PARTITION BY mandant_id, wrg_id, art_id, gj ORDER BY mandant_id NULLS LAST, vs_id NULLS LAST,
         wup_id NULLS LAST, wrg_id NULLS LAST, art_id NULLS LAST, gj NULLS LAST, dat_inventur_bis DESC NULLS FIRST)) = 1
     , ROW_NUMBER() OVER (PARTITION BY mandant_id, wrg_id, art_id, gj ORDER BY mandant_id NULLS LAST, vs_id NULLS LAST,
       wup_id NULLS LAST, wrg_id NULLS LAST, art_id NULLS LAST, gj NULLS LAST, dat_inventur_bis DESC NULLS FIRST), 0) AS
   art_mdt_fg
  FROM FACTS_INVENTUR_WARENVERLUST), FACTS_AGGREGATED AS (SELECT mandant_id,
   vs_id,
   wup_id,
   art_id,
   wg_hist_id,
   owg_hist_id,
   hwg_hist_id,
   abt_hist_id,
   wrg_id,
   inventurart_id,
   dat_inventur_von,
   dat_inventur_bis,
   gj,
   inventur_id,
   wv_umsatz_netto,
   wv_inventur_netto,
   wv_menge_inventur,
   wv_umsatz_netto_aufg,
   wv_inventur_netto_aufg,
   wv_menge_inventur_aufg,
   art_wup_fg,
   art_vs_fg,
   art_mdt_fg,
   IF(wv_umsatz_netto = 0, 0, SAFE_DIVIDE(wv_inventur_netto, wv_umsatz_netto)) AS wv_inventur_netto_quote,
   IF(wv_umsatz_netto_aufg = 0, 0, SAFE_DIVIDE(wv_inventur_netto_aufg, wv_umsatz_netto_aufg)) AS
   wv_inventur_netto_aufg_quote,
   IF(art_vs_fg = 1, SUM(wv_inventur_netto) OVER (PARTITION BY mandant_id, vs_id, wrg_id, art_id, gj RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), NULL) AS wv_inventur_netto_vs,
   IF(art_vs_fg = 1, SUM(wv_umsatz_netto) OVER (PARTITION BY mandant_id, vs_id, wrg_id, art_id, gj RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), NULL) AS wv_umsatz_netto_vs,
   IF(art_mdt_fg = 1, SUM(wv_inventur_netto) OVER (PARTITION BY mandant_id, wrg_id, art_id, gj RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), NULL) AS wv_inventur_netto_mdt,
   IF(art_mdt_fg = 1, SUM(wv_umsatz_netto) OVER (PARTITION BY mandant_id, wrg_id, art_id, gj RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), NULL) AS wv_umsatz_netto_mdt
  FROM FACTS_FLAGGED AS t4), RANKINGS AS (SELECT mandant_id,
   vs_id,
   wup_id,
   art_id,
   wg_hist_id,
   owg_hist_id,
   hwg_hist_id,
   abt_hist_id,
   wrg_id,
   inventurart_id,
   dat_inventur_von,
   dat_inventur_bis,
   gj,
   inventur_id,
   wv_umsatz_netto,
   wv_inventur_netto,
   wv_menge_inventur,
   wv_umsatz_netto_aufg,
   wv_inventur_netto_aufg,
   wv_menge_inventur_aufg,
   art_wup_fg,
   art_vs_fg,
   art_mdt_fg,
   wv_inventur_netto_quote,
   wv_inventur_netto_aufg_quote,
   wv_inventur_netto_vs,
   wv_umsatz_netto_vs,
   wv_inventur_netto_mdt,
   wv_umsatz_netto_mdt,
   IF(wv_inventur_netto IS NOT NULL, DENSE_RANK() OVER (PARTITION BY mandant_id, vs_id, wup_id, wrg_id, gj ORDER BY
       wv_inventur_netto NULLS LAST), NULL) AS wv_inventur_netto_rank,
   IF(wv_inventur_netto_aufg IS NOT NULL, DENSE_RANK() OVER (PARTITION BY mandant_id, vs_id, wup_id, wrg_id, gj ORDER BY
       wv_inventur_netto_aufg NULLS LAST), NULL) AS wv_inventur_netto_rank_aufg,
   IF(wv_inventur_netto_vs IS NOT NULL, DENSE_RANK() OVER (PARTITION BY mandant_id, vs_id, wrg_id, gj ORDER BY
       wv_inventur_netto_vs NULLS LAST), NULL) AS wv_inventur_netto_rank_vs,
   IF(wv_inventur_netto_mdt IS NOT NULL, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj ORDER BY
       wv_inventur_netto_mdt NULLS LAST), NULL) AS wv_inventur_netto_rank_mdt
  FROM FACTS_AGGREGATED
  WHERE wv_umsatz_netto IS NOT NULL
   OR wv_umsatz_netto_aufg <> 0
   OR wv_inventur_netto IS NOT NULL
   OR wv_inventur_netto_aufg <> 0
   OR wv_menge_inventur IS NOT NULL
   OR wv_menge_inventur_aufg <> 0) (SELECT mandant_id,
   vs_id,
   wup_id,
   art_id,
   wg_hist_id,
   owg_hist_id,
   hwg_hist_id,
   abt_hist_id,
   wrg_id,
   inventurart_id,
   dat_inventur_von,
   dat_inventur_bis,
   gj,
   inventur_id,
   wv_umsatz_netto AS wv_umsatz_netto_wup,
   wv_inventur_netto AS wv_inventur_netto_wup,
   wv_menge_inventur AS wv_menge_inventur_wup,
   wv_umsatz_netto_aufg AS wv_umsatz_netto_aufg_wup,
   wv_inventur_netto_aufg AS wv_inventur_netto_aufg_wup,
   wv_menge_inventur_aufg AS wv_menge_inventur_aufg_wup,
   art_wup_fg,
   art_vs_fg,
   art_mdt_fg,
   wv_inventur_netto_quote,
   wv_inventur_netto_aufg_quote,
   wv_inventur_netto_vs,
   wv_umsatz_netto_vs,
   wv_inventur_netto_mdt,
   wv_umsatz_netto_mdt,
   wv_inventur_netto_rank,
   wv_inventur_netto_rank_aufg,
   wv_inventur_netto_rank_vs,
   wv_inventur_netto_rank_mdt
  FROM RANKINGS);
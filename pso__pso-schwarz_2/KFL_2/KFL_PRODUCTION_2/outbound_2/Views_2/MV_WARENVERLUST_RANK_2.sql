CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_warenverlust_rank_2 (mandant_id
OPTIONS(description='MANDANT_2 IM DWH'), vs_id OPTIONS(description='ID DER VERTRIEBSSCHIENE'), wup_id
OPTIONS(description='DER\"WUP_2\" BEINHALTET MÄRKTE UND LAGER. WUP_2 = WARENUMSCHLAGSPLATZ. MUTTER WUP_2 ID WIRD VERWENDET FÜR BEZIEHUNG LAGER ZU VERTEILZENTRUM.'),
art_id
OPTIONS(description='ARTIKELNUMMER IM DWH. INPUT: ARTIKEL_2-ID EINSCHLIESSLICH DER GENERATIONEN-ID (9-STELLIG); OUTPUT: 7-STELLIGE L&S-ID + COUNTER = 8-STELLIGE ARTIKEL_2-ID. WWNNNNPC (WARENGRUPPE, NUMMER, PRÜFZIFFER, COUNTER) REGEL: NEUER ARTIKEL_2 -> COUNTER +1.'),
wg_hist_id OPTIONS(description='ID DER WARENGRUPPE'), owg_hist_id OPTIONS(description='ID DER OBERWARENGRUPPE'),
hwg_hist_id OPTIONS(description='ID DER HAUPTWARENGRUPPE'), abt_hist_id
OPTIONS(description='ABTEILUNGS-ID, NEGATIVE WERTE: IM DWH GENERIERTE IDS; POSITIVE WERTE: AUS STAMMDATENSYSTEM ÜBERNOMMEN.'),
wrg_id OPTIONS(description='KURZBEZEICHNUNG DER WÄHRUNG, Z.B. CZK, EUR'), inventurart_id
OPTIONS(description='INVENTURARTEN AUS SAP. UNTERSCHEIDUNG, OB BSP. JAHRES-, FRISCHE- ODER SONDERINVENTUR. SIEHE INVENTURART_SPR_ZU.'),
dat_inventur_von
OPTIONS(description='START DES BETRACHTETEN INVENTURZEITRAUMS. DIESER ZEITRAUM UNTERLIEGT KEINER FESTEN ZEITLICHEN GRÖSSE UND KANN SICH JE LAND_2 UNTERSCHEIDEN.'),
dat_inventur_bis
OPTIONS(description='ENDE DES BETRACHTETEN INVENTURZEITRAUMS. DIESER ZEITRAUM UNTERLIEGT KEINER FESTEN ZEITLICHEN GRÖSSE UND KANN SICH JE LAND_2 UNTERSCHEIDEN.'),
gj
OPTIONS(description='GESCHÄFTSJAHR, DEM INVENTURZEITRAUM ZUGEORDNET WERDEN SOLL. 28.02.2024 KANN BEISPIELSWEISE IN DER BETRACHTUNG ZUM INVENTURZEITRAUM DES GJ 2024 STATT 2023 GEHÖREN.'),
inventur_id OPTIONS(description='EINDEUTIGE HOCHGEZÄHLTE NUMMER ÜBER ALLE FELDER DES EXCEL-UPLOADS'),
wv_umsatz_netto_wup
OPTIONS(description='UMSATZ DER BETROFFENEN INVENTUR_2-ARTIKEL_2 IM DEFINIERTEN INVENTUR_2-ZEITRAUM JE BETRIEB'),
wv_inventur_netto_wup
OPTIONS(description='SALDIERTE INVENTUR_2-DIFFERENZ-WERTE JE ARTIKEL_2 UND BETRIEB IM DEFINIERTEN INVENTUR_2-ZEITRAUM'),
wv_menge_inventur_wup
OPTIONS(description='SALDIERTE INVENTUR_2-DIFFERENZ-MENGEN JE ARTIKEL_2 UND BETRIEB IM DEFINIERTEN INVENTUR_2-ZEITRAUM'),
wv_umsatz_netto_aufg_wup
OPTIONS(description='AUFGELAUFENER UMSATZ DER BETROFFENEN INVENTUR_2-ARTIKEL_2 IM DEFINIERTEN INVENTUR_2-ZEITRAUM JE BETRIEB'),
wv_inventur_netto_aufg_wup
OPTIONS(description='AUFGELAUFENE SALDIERTE INVENTUR_2-DIFFERENZ-WERTE JE ARTIKEL_2 UND BETRIEB IM DEFINIERTEN INVENTUR_2-ZEITRAUM'),
wv_menge_inventur_aufg_wup
OPTIONS(description='AUFGELAUFENE SALDIERTE INVENTUR_2-DIFFERENZ-MENGEN JE ARTIKEL_2 UND BETRIEB IM DEFINIERTEN INVENTUR_2-ZEITRAUM'),
art_wup_fg OPTIONS(description='FLAG FOR FIRST APPEARANCE OF AN ARTICLE FOR ONE STORE AND ONE BUSINESS YEAR'), art_vs_fg
OPTIONS(description='FLAG FOR FIRST APPEARANCE OF AN ARTICLE FOR ONE REGION_2 AND ONE BUSINESS YEAR'), art_mdt_fg
OPTIONS(description='FLAG FOR FIRST APPEARANCE OF AN ARTICLE FOR ONE COUNTRY_2 AND ONE BUSINESS YEAR'),
wv_inventur_netto_quote OPTIONS(description='ANTEIL VON INVENTURDIFFERENZ ZU UMSATZ (AUF FILIALEBENE)'),
wv_inventur_netto_aufg_quote
OPTIONS(description='ANTEIL VON AUFGELAUFENER INVENTURDIFFERENZ ZU AUFGELAUFENEM UMSATZ (AUF FILIALEBENE)'),
wv_inventur_netto_vs
OPTIONS(description='INVENTURDIFFERENZ AGGREGIERT AUF REGIONSEBENE (NUR EINMAL PRO REGION_2 UND NICHT FÜR ALLE ZEILEN BERECHNET)'),
wv_umsatz_netto_vs
OPTIONS(description='UMSATZ AGGREGIERT AUF REGIONSEBENE (NUR EINMAL PRO REGION_2 UND NICHT FÜR ALLE ZEILEN BERECHNET)'),
wv_inventur_netto_mdt
OPTIONS(description='INVENTURDIFFERENZ AGGREGIERT AUF LANDESEBENE (NUR EINMAL PRO LAND_2 UND NICHT FÜR ALLE ZEILEN BERECHNET)'),
wv_umsatz_netto_mdt
OPTIONS(description='UMSATZ AGGREGIERT AUF LANDESEBENE (NUR EINMAL PRO LAND_2 UND NICHT FÜR ALLE ZEILEN BERECHNET)'),
wv_inventur_netto_rank OPTIONS(description='RANKING NACH INVENTURDIFFERENZ'), wv_inventur_netto_rank_aufg
OPTIONS(description='RANKING NACH AUFGELAUFENER INVENTURDIFFERENZ'), wv_inventur_netto_rank_vs
OPTIONS(description='RANKING NACH INVENTURDIFFERENZ PRO REGION_2'), wv_inventur_netto_rank_mdt
OPTIONS(description='RANKING NACH INVENTURDIFFERENZ PRO LAND_2')) AS WITH FACTS_INVENTUR_WARENVERLUST AS (SELECT I.mandant_id
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
  FROM kfl_production_dbp_msi_view_vis.mv_warenverlust_2 AS I
   LEFT JOIN kfl_production_dbp_msi_view_vis.mv_wup_2 AS W USING (mandant_id, wup_id)
  WHERE I.inventurart_id = 3), FACTS_FLAGGED AS (SELECT mandant_id,
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
   ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(vs_id AS STRING), CAST(wup_id AS STRING), wrg_id, CAST(art_id AS STRING)
      , CAST(gj AS STRING) ORDER BY mandant_id IS NULL, mandant_id, vs_id IS NULL, vs_id, wup_id IS NULL, wup_id, wrg_id
      IS NULL, wrg_id, art_id IS NULL, art_id, gj IS NULL, gj, dat_inventur_bis IS NULL DESC, dat_inventur_bis DESC) AS
   art_wup_nr,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(vs_id AS STRING), CAST(wup_id AS STRING), wrg_id
         , CAST(art_id AS STRING), CAST(gj AS STRING) ORDER BY mandant_id IS NULL, mandant_id, vs_id IS NULL, vs_id,
         wup_id IS NULL, wup_id, wrg_id IS NULL, wrg_id, art_id IS NULL, art_id, gj IS NULL, gj, dat_inventur_bis
         IS NULL DESC, dat_inventur_bis DESC)) = 1, ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(vs_id AS STRING)
       , CAST(wup_id AS STRING), wrg_id, CAST(art_id AS STRING), CAST(gj AS STRING) ORDER BY mandant_id IS NULL,
       mandant_id, vs_id IS NULL, vs_id, wup_id IS NULL, wup_id, wrg_id IS NULL, wrg_id, art_id IS NULL, art_id, gj
       IS NULL, gj, dat_inventur_bis IS NULL DESC, dat_inventur_bis DESC), 0) AS art_wup_fg,
   ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(vs_id AS STRING), wrg_id, CAST(art_id AS STRING), CAST(gj AS STRING)
      ORDER BY mandant_id IS NULL, mandant_id, vs_id IS NULL, vs_id, wup_id IS NULL, wup_id, wrg_id IS NULL, wrg_id,
      art_id IS NULL, art_id, gj IS NULL, gj, dat_inventur_bis IS NULL DESC, dat_inventur_bis DESC) AS art_vs_nr,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(vs_id AS STRING), wrg_id, CAST(art_id AS STRING)
         , CAST(gj AS STRING) ORDER BY mandant_id IS NULL, mandant_id, vs_id IS NULL, vs_id, wup_id IS NULL, wup_id,
         wrg_id IS NULL, wrg_id, art_id IS NULL, art_id, gj IS NULL, gj, dat_inventur_bis IS NULL DESC, dat_inventur_bis
         DESC)) = 1, ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(vs_id AS STRING), wrg_id, CAST(art_id AS STRING)
       , CAST(gj AS STRING) ORDER BY mandant_id IS NULL, mandant_id, vs_id IS NULL, vs_id, wup_id IS NULL, wup_id,
       wrg_id IS NULL, wrg_id, art_id IS NULL, art_id, gj IS NULL, gj, dat_inventur_bis IS NULL DESC, dat_inventur_bis
       DESC), 0) AS art_vs_fg,
   ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(art_id AS STRING), CAST(gj AS STRING)
    ORDER BY mandant_id IS NULL, mandant_id, vs_id IS NULL, vs_id, wup_id IS NULL, wup_id, wrg_id IS NULL, wrg_id,
      art_id IS NULL, art_id, gj IS NULL, gj, dat_inventur_bis IS NULL DESC, dat_inventur_bis DESC) AS art_mandant_nr,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(art_id AS STRING), CAST(gj AS STRING)
       ORDER BY mandant_id IS NULL, mandant_id, vs_id IS NULL, vs_id, wup_id IS NULL, wup_id, wrg_id IS NULL, wrg_id,
         art_id IS NULL, art_id, gj IS NULL, gj, dat_inventur_bis IS NULL DESC, dat_inventur_bis DESC)) = 1, ROW_NUMBER()
    OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(art_id AS STRING), CAST(gj AS STRING) ORDER BY
       mandant_id IS NULL, mandant_id, vs_id IS NULL, vs_id, wup_id IS NULL, wup_id, wrg_id IS NULL, wrg_id, art_id
       IS NULL, art_id, gj IS NULL, gj, dat_inventur_bis IS NULL DESC, dat_inventur_bis DESC), 0) AS art_mdt_fg
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
   wv_inventur_netto_quote,
   wv_inventur_netto_aufg_quote,
   wv_inventur_netto_vs,
   wv_umsatz_netto_vs,
   wv_inventur_netto_mdt,
   wv_umsatz_netto_mdt
  FROM (SELECT mandant_id,
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
     IF(art_vs_fg = 1, SUM(wv_inventur_netto) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(vs_id AS STRING),
         wrg_id, CAST(art_id AS STRING), CAST(gj AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
      NULL) AS wv_inventur_netto_vs,
     IF(art_vs_fg = 1, SUM(wv_umsatz_netto) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(vs_id AS STRING), wrg_id
         , CAST(art_id AS STRING), CAST(gj AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), NULL)
     AS wv_umsatz_netto_vs,
     IF(art_mdt_fg = 1, SUM(wv_inventur_netto) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(art_id AS STRING)
         , CAST(gj AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), NULL) AS wv_inventur_netto_mdt
     ,
     IF(art_mdt_fg = 1, SUM(wv_umsatz_netto) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(art_id AS STRING)
         , CAST(gj AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), NULL) AS wv_umsatz_netto_mdt
    FROM FACTS_FLAGGED) AS t5
  WHERE wv_umsatz_netto IS NOT NULL
   OR wv_umsatz_netto_aufg <> 0
   OR wv_inventur_netto IS NOT NULL
   OR wv_inventur_netto_aufg <> 0
   OR wv_menge_inventur IS NOT NULL
   OR wv_menge_inventur_aufg <> 0), RANKINGS AS (SELECT mandant_id,
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
   IF(wv_inventur_netto IS NOT NULL, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(vs_id AS STRING), CAST(wup_id AS STRING)
       , wrg_id, CAST(gj AS STRING) ORDER BY wv_inventur_netto IS NULL, wv_inventur_netto), NULL) AS
   wv_inventur_netto_rank,
   IF(wv_inventur_netto_aufg IS NOT NULL, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(vs_id AS STRING)
       , CAST(wup_id AS STRING), wrg_id, CAST(gj AS STRING) ORDER BY wv_inventur_netto_aufg IS NULL,
       wv_inventur_netto_aufg), NULL) AS wv_inventur_netto_rank_aufg,
   IF(wv_inventur_netto_vs IS NOT NULL, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(vs_id AS STRING)
       , wrg_id, CAST(gj AS STRING) ORDER BY wv_inventur_netto_vs IS NULL, wv_inventur_netto_vs), NULL) AS
   wv_inventur_netto_rank_vs,
   IF(wv_inventur_netto_mdt IS NOT NULL, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
       ORDER BY wv_inventur_netto_mdt IS NULL, wv_inventur_netto_mdt), NULL) AS wv_inventur_netto_rank_mdt
  FROM FACTS_AGGREGATED) (SELECT mandant_id,
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
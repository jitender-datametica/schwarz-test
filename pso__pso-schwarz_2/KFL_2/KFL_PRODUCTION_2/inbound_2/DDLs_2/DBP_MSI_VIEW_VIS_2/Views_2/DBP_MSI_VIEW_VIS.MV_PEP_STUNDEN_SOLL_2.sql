CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PEP_STUNDEN_SOLL_2
AS
   -- FAKTVIEW PEP Bedarfsplanung pro Filiale und Tag_2
   -- Basis: PEP Zeiten und Sollvorgaben CO
   -- 2013-12-01 : INITIAL
   -- 2013-12-16 : Anpassung PEP Fehlzeiten Plan
   -- 2014-04-10 : Review Sollstundenberechnung/Gerharz
   --              Soll-Wert = ln(Umsatz) * flex. Faktor m + Achsenabschnitt b
   -- 2014-06-03 : Anpassung LN-Funktion (NULLIFZERO)
   -- 2015-07-06 : Erweiterung auf -15 Vormonate
   -- 2016-09-06 : AP0007480, einschränkung pep_planung.plan_fg = 1

   SELECT
   sub00.mandant_id,
   sub00.nb_id,
   sub00.wup_id,
   sub00.dat,
   sub00.ums_netto_plan_wup  -- auf Basis wup_plan_tag_2
   ,
   0 AS ums_netto_wup        -- Dummy_2 not used
   ,
   0 AS ums_brutto_wup       -- Dummy_2 not used
   ,
   sub01.anzahl_ma_pzw,
   sub01.anzahl_ma_nzw,
   sub01.stunden_pep_plan,
   sub01.anzahl_ma_pzw_fehl,
   sub01.anzahl_ma_nzw_fehl,
   sub01.stunden_pep_fehl,
   sub01.stunden_pep_plan - sub01.stunden_pep_fehl AS stunden_pep_plan_fehl    -- abzueglich geplante Fehlzeiten
   ,
   sub02.stunden_pep_ist,
   sub03.ums_brutto_ist                                                        -- Umsatz brutto IST (Bondaten)
   ,
   sub03.ums_brutto_plan_dwh                                                   -- Umsatz Plan Hochrechnung DWH
   ,
   sub03.ums_brutto_plan_hl                                                    -- Umsatz Plan Writeback Hausleiter
   ,
   0 AS umsatz_brutto_ma_stunde_plan,
   0 AS regression_faktor,
   0 AS brutto_netto_faktor,
   COALESCE(sub03.ums_brutto_plan_hl, sub03.ums_brutto_plan_dwh) AS ums_brutto_plan,
   0 AS ums_brutto_plan_co,
   0 AS stunden_soll_plan_co,
   0 AS ums_brutto_plan_diff,
   0 AS ums_brutto_plan_regr,
   CAST((LN(CASE WHEN ums_brutto_plan = 0 THEN null ELSE ums_brutto_plan END) * sub05.regression_faktor_var) + sub05.regression_faktor_fix AS NUMBER(38,5))AS stunden_soll_plan,
   0 AS ums_brutto_ist_diff,
   0 AS ums_brutto_ist_regr,
   CAST((LN(CASE WHEN sub03.ums_brutto_ist = 0 THEN null ELSE sub03.ums_brutto_ist END) * sub05.regression_faktor_var) + sub05.regression_faktor_fix AS NUMBER(38,5)) AS stunden_soll_ist,
   ums_brutto_ist - ums_brutto_plan          AS ums_brutto_abw         -- klassische Abw.(nicht verwendet)
   ,
   ums_brutto_plan - ums_brutto_ist          AS ums_brutto_diff        -- verwendet in Report
   ,
   stunden_soll_plan - stunden_pep_plan      AS stunden_plan_abw       -- nicht verwendet
   ,
   stunden_soll_plan - stunden_pep_plan_fehl AS stunden_plan_abw_fehl  -- abzueglich geplante Fehlzeiten
   ,
   stunden_soll_ist - stunden_pep_ist        AS stunden_ist_abw        -- Abw.
  FROM
  ( -- VIS Tag_2 Agg : Umsatz Plan netto pro Filiale (und Tag_2)
  SELECT
  vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.dat,
   vis.ums_netto_plan AS ums_netto_plan_wup
  FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_2  vis
   INNER JOIN dbp_view.v_tag_2 zeit_2
   ON  vis.dat = zeit.dat
   AND zeit.akt_mo BETWEEN -15 AND 2       -- 15 Vormonate und zwei Folgemonate

   INNER JOIN dbp_msi_view_vis.mv_wup_2 wp   -- mv_view!

   ON  vis.mandant_id = wp.mandant_id
   AND vis.wup_id = wp.wup_id
   AND wp.mandant_id = 1 AND wp.nb_id = 0  -- nur Filialen DE
   ) sub00
   LEFT JOIN
   ( -- PEP Anzahl MA und Planzeiten pro Filiale inkl. Fehlzeiten
   SELECT
   fil.mandant_id AS mandant_id,
   fil.nb_id      AS nb_id,
   fil.wup_id     AS wup_id,
   plan.dat AS dat,
   SUM(CASE WHEN plan.pzw_fg = 1 THEN 1 ELSE 0 END)  AS anzahl_ma_pzw,
   SUM(CASE WHEN plan.pzw_fg <> 1 THEN 1 ELSE 0 END) AS anzahl_ma_nzw,
   SUM(ZEROIFNULL(plan.nettozeit))                   AS stunden_pep_plan,
   SUM(CASE WHEN idfehlgrund <> 0 AND plan.pzw_fg = 1 THEN 1 ELSE 0 END)  AS anzahl_ma_pzw_fehl,
   SUM(CASE WHEN idfehlgrund <> 0 AND plan.pzw_fg <> 1 THEN 1 ELSE 0 END) AS anzahl_ma_nzw_fehl,
   SUM(CASE WHEN idfehlgrund <> 0 THEN plan.nettozeit ELSE 0 END)         AS stunden_pep_fehl
  FROM dbp_view.v_pep_planung_2  plan
   INNER JOIN dbp_view.v_pep_filiale_2  fil
   ON plan.idcompany = fil.idcompany
   INNER JOIN dbp_view.v_pep_personal_2  pers
   ON plan.idpersonal = pers.idpersonal
   LEFT OUTER JOIN dbp_view.v_pep_planung_fehlgrund_2 fehl
   ON  plan.idpersonal = fehl.idpersonal
   AND plan.idcompany = fehl.idcompany
   AND plan.dat = fehl.dat
   WHERE (COALESCE(pers.dat_austritt, (to_date('9999-12-31','YYYY-MM_2-DD'))) > plan.dat)
   -- AP0007480
   AND plan.plan_fg = 1

   GROUP BY 1, 2, 3, 4
   ) sub01
   ON  sub00.mandant_id = sub01.mandant_id
   AND sub00.wup_id = sub01.wup_id
   AND sub00.dat = sub01.dat
   LEFT OUTER JOIN
   ( -- Stupfzeiten PEP IST pro Filiale
   SELECT
   fil.mandant_id,
   fil.nb_id,
   fil.wup_id,
   pzeit.dat,
   SUM(pzeit.zeit_sekunden)           AS zeit_stupf_ist,
   SUM(pzeit.zeit_sekunden) / 3600.00 AS stunden_pep_ist -- Stupfzeit
   FROM dbp_view.v_pep_personal_bew_zeit_2 pzeit
   INNER JOIN dbp_view.v_pep_filiale_2  fil
   ON pzeit.mandant_id = fil.mandant_id
   AND pzeit.idcompany = fil.idcompany
   INNER JOIN dbp_view.v_pep_personal_per_2 pers
   ON  pzeit.idpersonal = pers.idpersonal

   WHERE pzeit.dat BETWEEN pers.dat_von AND pers.dat_bis

   GROUP BY 1, 2, 3, 4
   ) sub02
   ON  sub00.mandant_id = sub02.mandant_id
   AND sub00.wup_id = sub02.wup_id
   AND sub00.dat = sub02.dat
   LEFT OUTER JOIN
   ( -- Umsatz brutto : IST + Plan Hochrechnung DWH + Plan HL_2 pro Filiale
   SELECT
   pep.mandant_id,
   pep.wup_id,
   pep.nb_id,
   pep.dat_plan AS dat,
   SUM(ums_brutto_ist_bondaten) AS ums_brutto_ist,
   SUM(ums_brutto_plan)         AS ums_brutto_plan_dwh,
   SUM(ums_brutto_plan_man)     AS ums_brutto_plan_hl
  FROM dbp_msi_v_view.v_pep_plan_tag_2 pep

   WHERE pep.mandant_id = 1
   AND pep.nb_id = 0

   GROUP BY 1, 2, 3, 4
   ) sub03
   ON  sub00.mandant_id = sub03.mandant_id
   AND sub00.wup_id = sub03.wup_id
   AND sub00.dat = sub03.dat
   LEFT OUTER JOIN
   ( -- Sollvorgaben CO pro Filiale - Regression - NEU
   SELECT
   planc2.mandant_id,
   planc2.nb_id,
   planc2.wup_id,
   planc2.dat,
   planc2.regression_faktor_var,
   planc2.regression_faktor_fix

  FROM dbp_view.v_wup_plan_tag_co_v2_2 planc2

   WHERE planc2.mandant_id = 1
   AND planc2.nb_id = 0
   ) sub05
   ON  sub00.mandant_id = sub05.mandant_id
   AND sub00.wup_id = sub05.wup_id
   AND sub00.dat = sub05.dat;
/* FAKT : Umsatz Plan (Meldeschluss) pro Filiale/Monat auf Basis wup_stunden_tag
	2019.0415 ssch0611 : Initial (moved from vis_monat_fakt, wup_planumsatz_eingabe
	2019.0503 awol2209:  Anpassung plan_uebernahme_fg und plan_anpassung_fg. ALT ...wst.ums_netto_plan_mld_ker = wst.ums_netto_plan_hl_ker ...
	2022-10-06 ssch0611 : Finetuning  
	2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]
	2024-09-09 ssch0611 : keine Anpassung Umzugsfiliale. 
	2025-07-11 ssch0611 : Review (geänderte wup_stunden_tag) [AP0273081] */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_stunden_monat (mandant_id, nb_id, wup_id, wrg_id, kjmo,
anz_offen, ums_netto, ums_netto_plan, ums_netto_plan_man, ums_netto_plan_man_meldeschluss, ums_netto_plan_hl_ker,
ums_netto_plan_mld_ker, pers_std, pers_std_plan, plan_uebernahme_fg, plan_anpassung_fg, plan_kein_fg, nl_ist, nl_plan,
nl_plan_hl_ker, nl_plan_mld_ker, nl_abw, nl_abw_hl_ker, nl_abw_mld_ker, ums_abw, filialebene2_id) AS
-- Umsatz netto IST (komplette Monate)
 -- Umsatz netto Plan (KER Jahresplanung)
 -- Umsatz netto Plan HL (Eingabe)

-- Umsatz netto Plan HL (Meldeschluss Plus2)
 -- Umsatz netto Plan HL (Eingabe HL oder KER)

-- Umsatz netto Plan HL (Meldeschluss oder KER)
 -- Stunden IST (komplette Monate)
 -- Stunden Plan (KER Jahresplanung)

/* Berechnungen */ -- Jahresplanung wurde übernommen
 -- Jahresplanung wurde angepasst
 -- kein Planwert vorhanden

-- Nettoleistung IST (komplette Monate)
 -- Nettoleistung Plan (KER Jahresplanung)

-- Nettoleistung Plan (Umsatz Eingabe HL oder KER)
 -- Nettoleistung Plan (Umsatz Meldeschluss2 oder KER)

-- Umsatz Plan (Meldeschluss oder KER) Abw.
 /* Filialebene - Monat */ -- Komplette Monate = 1
 SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.kjmo,
 vis.mo_offen AS anz_offen,
  vis.mo_ums * wst.ist_fg AS ums_netto,
 vis.mo_ums_plan AS ums_netto_plan,
 wst.ums_plan_man AS ums_netto_plan_man,
 wst.ums_plan_man_mld AS ums_netto_plan_man_meldeschluss,
 wst.ums_plan_hl_ker AS ums_netto_plan_hl_ker,
 wst.ums_plan_mld_ker AS ums_netto_plan_mld_ker,
  vis.mo_std * wst.ist_fg AS pers_std,
 vis.mo_std_plan AS pers_std_plan,
 CAST(IF(wst.ums_plan_mld_ker = vis.mo_ums_plan, 1, 0) AS BIGNUMERIC) AS plan_uebernahme_fg,
 CAST(IF(wst.ums_plan_mld_ker = vis.mo_ums_plan, 0, 1) AS BIGNUMERIC) AS plan_anpassung_fg,
 CAST(IF(wst.ums_plan_mld_ker <> 0, 0, 1) AS BIGNUMERIC) AS plan_kein_fg,
   vis.mo_ums * wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg) AS nl_ist,
  vis.mo_ums_plan / IF(vis.mo_std_plan = 0, NULL, vis.mo_std_plan) AS nl_plan,
  wst.ums_plan_hl_ker / IF(vis.mo_std_plan = 0, NULL, vis.mo_std_plan) AS nl_plan_hl_ker,
  wst.ums_plan_mld_ker / IF(vis.mo_std_plan = 0, NULL, vis.mo_std_plan) AS nl_plan_mld_ker,
    (IF(vis.mo_ums * wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg) = 0, NULL, vis.mo_ums *
        wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg)) - IF(vis.mo_ums_plan / IF(vis.mo_std_plan
           = 0, NULL, vis.mo_std_plan) = 0, NULL, vis.mo_ums_plan / IF(vis.mo_std_plan = 0, NULL, vis.mo_std_plan))) /
   IF(vis.mo_ums * wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg) = 0, NULL, vis.mo_ums *
      wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg)) * 100.00 AS nl_abw,
    (IF(vis.mo_ums * wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg) = 0, NULL, vis.mo_ums *
        wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg)) - IF(wst.ums_plan_hl_ker / IF(vis.mo_std_plan
           = 0, NULL, vis.mo_std_plan) = 0, NULL, wst.ums_plan_hl_ker / IF(vis.mo_std_plan = 0, NULL, vis.mo_std_plan))
    ) / IF(vis.mo_ums * wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg) = 0, NULL, vis.mo_ums
       * wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg)) * 100.00 AS nl_abw_hl_ker,
    (IF(vis.mo_ums * wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg) = 0, NULL, vis.mo_ums *
        wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg)) - IF(wst.ums_plan_mld_ker / IF(vis
          .mo_std_plan = 0, NULL, vis.mo_std_plan) = 0, NULL, wst.ums_plan_mld_ker / IF(vis.mo_std_plan = 0, NULL, vis.mo_std_plan
        ))) / IF(vis.mo_ums * wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg) = 0, NULL, vis
      .mo_ums * wst.ist_fg / IF(vis.mo_std * wst.ist_fg = 0, NULL, vis.mo_std * wst.ist_fg)) * 100.00 AS nl_abw_mld_ker
 ,
    (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) * 100.00
   AS ums_abw,
  CASE
  WHEN (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) *
    100.00 < - 20
  THEN 1
  WHEN (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) *
     100.00 >= - 20 AND (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker
       ) * 100.00 < - 10
  THEN 2
  WHEN (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) *
     100.00 >= - 10 AND (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker
       ) * 100.00 < - 5
  THEN 3
  WHEN (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) *
     100.00 >= - 5 AND (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker
       ) * 100.00 < - 2.5
  THEN 4
  WHEN (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) *
     100.00 >= - 2.5 AND (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker
       ) * 100.00 < - 1
  THEN 5
  WHEN (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) *
     100.00 >= - 1 AND (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker
       ) * 100.00 <= 1
  THEN 6
  WHEN (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) *
     100.00 > 1 AND (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker
       ) * 100.00 <= 2.5
  THEN 7
  WHEN (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) *
     100.00 > 2.5 AND (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker
       ) * 100.00 <= 5
  THEN 8
  WHEN (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) *
     100.00 > 5 AND (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker
       ) * 100.00 <= 10
  THEN 9
  WHEN (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) *
     100.00 > 10 AND (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker
       ) * 100.00 <= 20
  THEN 10
  WHEN (vis.mo_ums * wst.ist_fg - wst.ums_plan_mld_ker) / IF(wst.ums_plan_mld_ker = 0, NULL, wst.ums_plan_mld_ker) *
    100.00 > 20
  THEN 11
  ELSE - 1
  END AS filialebene2_id
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.kjmo,
   VIS.wrg_id,
   SUM(VIS.anz_offen) AS mo_offen,
   SUM(VIS.ums_netto) AS mo_ums,
   SUM(VIS.ums_netto_plan) AS mo_ums_plan,
   SUM(VIS.pers_std) AS mo_std,
   SUM(VIS.pers_std_plan) AS mo_std_plan
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wup AS VIS
   INNER JOIN kfl_production_dbp_view.v_tag AS ZEIT ON VIS.kjmo = ZEIT.kjmo
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   VIS.kjmo) AS vis
 LEFT JOIN (SELECT WST.mandant_id,
   WST.nb_id,
   WST.wup_id,
   ZEIT0.kjmo,
   IF(ZEIT0.akt_mo < 0, 1, NULL) AS ist_fg,
   WST.wrg_id,
   SUM(WST.ums_netto_plan_man_meldeschluss_plus2) AS ums_plan_man_mld,
   SUM(WST.ums_netto_plan_man) AS ums_plan_man,
   SUM(WST.umsatz_netto_plan_plus2) AS ums_plan_mld_ker,
   SUM(WST.umsatz_netto_plan) AS ums_plan_hl_ker
  FROM kfl_production_dbp_msi_view_vis.mv_wup_stunden_tag AS WST
   INNER JOIN kfl_production_dbp_view.v_tag AS ZEIT0 ON WST.dat = ZEIT0.dat
  GROUP BY WST.mandant_id,
   WST.nb_id,
   WST.wup_id,
   ZEIT0.kjmo,
   ist_fg,
   WST.wrg_id) AS wst ON vis.wup_id = wst.wup_id AND vis.mandant_id = wst.mandant_id AND vis.wrg_id = wst.wrg_id AND vis
   .kjmo = wst.kjmo;
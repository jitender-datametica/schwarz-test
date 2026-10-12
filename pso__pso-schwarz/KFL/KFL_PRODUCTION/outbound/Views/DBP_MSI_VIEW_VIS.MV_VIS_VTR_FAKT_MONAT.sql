/* Dummy VKL */ /* VTR365 Totalabschriften Anteil */ /* Referenz Region/Land */ /* Setup Rang Filiale Monat */
/* FAKT DENORM : VT Ranking + Details pro Monat 
	Filiale IST/VJ/Plan + Referenz Region/Land + Ranking Filiale/VKL pro Monat/GJ 
	2023-08-01 ssch0611 : Initial als MV_VIS_VTR_FAKT [AP0176993]
	2025-02-10 ssch0611 : Review 2025. Komplett neu erstellt (CTE). Neue Metriken [AP0237182] 
	2025-02-24 ssch0611 : Fixes (Kunden, Delta %p, BIG, Ø Kuga, Inventur) Filter Schließungen (2GJ) [AP0237182] 
	2025-02-25 ssch0611 : Rang Null/Minusquote = ASC! [AP0237182] 
	2025-03-31 ssch0611 : Fixed: Bestandentw Rang ASC  [AP0237182] 
	2025-04-02 ssch0611 : Umstellung Scans/min (KPOS) [AP0264011]
	2025-03-31 ssch0611 : Fixed: K Card Rang VKL_GJ [AP0237182] */
/* WUPCAL gemappt, aggregiert, aggregiert - KVJ (ohne WRG) */ /* VTR220 Nettostückleistung */
/* Setup Rang VKL BJ (BS) */ /* BIG/Bestand : zwei Datenquellen */ /* VTR115 Umsatzanteil Ultra-Frische */
/* ohne Rang */ /* VTR510 Warten Kasse */ /* Rang aufsteigend = Mangel MHD IST (absolut) */ /* Referenz Region/Land */
/* Setup Rang VKL BJ (BS) */ /* Setup Rang VKL Monat */ /* Wechsel am 02. April */ /* Wechsel am 02. April */
/* ohne Rang */ /* Rang absteigend = Kassierleistung IST (absolut) */ /* Setup Rang Filiale Monat */
/* MV_VIS_TAG_REKL_ART aggregiert - IST */ /* MV_VIS_TAG_ABSCHRIFTEN_WG gruppiert -- IST/KVJ */
/* Rang absteigend = Google Sterne IST (Wert) */ /* Setup Rang VKL BJ (BS) */ /* Setup Rang Filiale GJ */
/* Rang : relevante Monate vor Buchungsschluss */ /* Referenz Region/Land */ /* Setup Rang Filiale Monat */
/* VTR535 Ø Mangel MHD pro 10000 Kunden */ /* Setup Rang Filiale GJ */ /* ohne Rang */ /* ohne Rang */
/* Bestandsentwicklung */ /* Referenz Region/Land */
/* V_VIS_TAG_KASSE + V_KASSE_TYP_PER umgerechnet, gemapped, aggregiert, transformiert -- KVJ */
/* Rang (VKL) : echte VKL ohne ZF */ /* Rang (GJ) : Schließungen im GJ nicht enthalten */
/* VTR506 K Card Anteil (Rang ∆VJ %p) */ /* MV_ARTBEW_MO_SUM gruppiert,transformiert - KVJ */
/* Setup Rang Filiale Monat */ /* VTR520 Warten Theke */ /* Rang aufsteigend = Kassierfehler IST (absolut) */
/* VTR555 Ø Kassierfehler pro 100000 Scans */ /* Rang absteigend = Scans/min IST (absolut)  >>>> INAKTIV */
/* Setup Rang Filiale Monat */ /* RO */ /* VTR410 Inventurdifferenz Ultra-Frische */ /* Referenz Region/Land */
/* Rang aufsteigend = Null-/Minusquote IST % */ /* DE */ /* ohne Rang */
/* VTR545 Ø Preisauszeichnung pro 10000 Kunden */ /* ohne Rang */ /* Setup Rang Filiale GJ */
/* Setup Rang VKL BJ (BS) */ /* Setup Rang Filiale GJ */ /* Referenz Region/Land */ /* Kein Plan auf Ebene Filiale */
/* Setup Rang VKL Monat */ /* Abschriften inkl. B/V */ /* VTR345 Preisabschriften Anteil */
/* Rang absteigend = Umsatz netto ∆Plan % */ /* Setup Rang VKL GJ (BS) */ /* Setup Rang Filiale GJ */ /* ohne Rang */
/* Setup Rang VKL Monat */ /* VTR160 Kunden */ /* Setup Rang VKL Monat */
/* Rang aufsteigend = Warten Kasse IST (absolut) */ /* Setup Rang Filiale GJ */ /* VTR250 Scans/min (KPOS) */
/* Referenz Region/Land */ /* Warenzugang */ /* Setup Rang VKL Monat */ /* Setup Rang VKL Monat */
/* Rang absteigend = Personalkosten IST% */ /* Setup Rang VKL Monat */ /* Setup Rang Filiale GJ */
/* Zeit inkl BS. 2 GJ bis Vormonat */ /* Referenz Region/Land */
/* Rang aufsteigend = Preisauszeichnung IST (absolut) */ /* Referenz Region/Land */ /* ohne Rang */
/* VTR275 Personalkosten (%) */ /* VTR540 Preisauszeichnung */ /* CTE */
/* MV_ODS_BON_KASSENABSCHLUSS (KPOS) aggregiert, transformiert -- KVJ (ohne WRG) */ /* Bestellvorschläge */
/* Referenz Region/Land */ /* ohne Rang */ /* transformiert auf akt. Monat */ /* Setup Rang VKL BJ (BS) */
/* GJ der Eröffnung */ /* Referenz Region/Land */ /* Rang absteigend = Personalkosten IST% */
/* VTR140 Absatz (ohne Pfand) */ /* Setup Rang VKL BJ (BS) */ /* Eröffnungsdatum (inkl Mapping Altfiliale) */
/* Setup Rang Filiale Monat */ /* VTR180 Ø-Bon */ /* Referenz Region/Land */ /* Setup Rang VKL Monat */
/* VTR710 Übernahmequote */ /* ohne Rang */ /* Rang absteigend = Google Bewertungen IST */ /* VTR550 Kassierfehler */
/* ohne Rang */ /* VTR255 Scans/min (DWH) -- ALT (VIS_TAG_KASSE) */ /* Setup Rang Filiale Monat */
/* MV_VIS_ZAEHL_AUFTRAG gruppiert -- (ohne WRG) */ /* Setup Rang Filiale Monat */ /* ohne Rang : Personalkosten */
/* Setup Rang VKL BJ (BS) */ /* Setup Rang Filiale GJ */ /* MV_VIS_MONAT_HFM_INVENTUR gruppiert -- IST */
/* transformiert auf akt. Monat */ /* Referenz Region/Land */
/* Basis : MV_VIS_MONAT_FAKT_WUP gruppiert -- IST/KVJ/PLAN */ /* Setup Rang Filiale Monat */
/* Rang absteigend = Scans/min IST (absolut) */ /* ohne Rang */
/* Rang absteigend = Scans/min IST (absolut) >>>> INAKTIV */ /* VTR752 Minusbestandsquote */ /* Setup Rang Filiale GJ */
/* Kein Plan auf Ebene Filiale */ /* Referenz Region/Land */ /* VTR735 Zählaufträge bearbeitet (%) */
/* VTR240 Kassierleistung */ /* weitere Filter/Logik siehe mv_view! */
/* Rang absteigend = Nettoleistung ∆Plan (absolut) */ /* Rang absteigend = Kaufland Card Anteil IST % */
/* Transformation KVJ */ /* VTR120 Umsatz SA (artbew) */
/* Ausschluss : Getränkemärkte, Zeltverkauf, definierte Filialen -- 2025-01 */ /* ohne Rang */
/* Setup Rang Filiale Monat */
/* Rang : Filialen min. 1 komplettes GJ eröffnet. Ohne Schließungsmonat. Ohne definierte Ausschlussfilialen */
/* Referenz Region/Land */ /* Standard VTC : Filiale + definierte ZF. Mapping NEÖ + Filter */
/* DE = MV_VIS_MONAT_BIG_DE gruppiert, gefiltert (12 Monate) */ /* Setup Rang Filiale GJ */ /* ohne Rang */
/* Referenz Region/Land */ /* MV_VIS_TAG_REKL_ART aggregiert, transformiert - KVJ */ /* Referenz Region/Land */
/* Referenz Region/Land */ /* Setup Rang VKL BJ (BS) */ /* Setup Rang VKL BJ (BS) */ /* VTR750 Nullbestandsquote */
/* Setup Rang VKL Monat */ /* Setup Rang Filiale Monat */ /* ohne Rang */ /* Referenz Region/Land */
/* Rang absteigend = Nettoleistung ∆Plan (absolut) */ /* Setup Rang Filiale Monat */ /* VTR360 Totalabschriften (%) */
/* ohne Rang */ /* Referenz Region/Land */ /* Setup Rang Filiale GJ */ /* Bestandsentw. */ /* Setup Rang Filiale GJ */
/* Rang absteigend = Nettoleistung (Umsatz/Stunden) IST-Plan (absolut) */ /* Referenz Region/Land */
/* Referenz Region/Land */ /* VTR300 Abschriften operativ */ /* Setup Rang VKL Monat */ /* Referenz Region/Land */
/* Setup Rang Filiale GJ */ /* MV_VIS_TAG_FWWS_WG gruppiert -- (ohne WRG) */ /* VTR500 Google Bewertung */
/* Setup Rang VKL BJ (BS) */ /* Rang absteigend = Übernahmequote IST % */
/* Rang aufsteigend = Bestandsentw. zum Umsatz IST% >> big_fg = Ausblenden leerer Monate */ /* Setup Rang Filiale GJ */
/* Referenz Region/Land */ /* Mapping auf Akt GJ */ /* korrigierte Bestellungen */
/* Rang absteigend = Umsatz netto IST - Plan % */ /* ohne Rang */ /* VTR210 Nettoleistung */
/* Rang absteigend = Abschriften operativ ∆Plan %p */
/* Ausland = MV_VIS_MONAT_BIG_BESTANDSDIFFERENZEN gruppiert, gefiltert (12 Monate) */
/* VTR125 Umsatzanteil SA (artbew) */ /* Reserve */ /* ohne Rang */ /* Referenz Region/Land */
/* Setup Rang VKL BJ (BS) */ /* VTR310 Abschriften operativ (%) */ /* ohne Treibstoffe */ /* ohne Rang */
/* ohne Rang */ /* Referenz Region/Land */ /* Setup Rang Filiale Monat */ /* VTR730 Zählaufträge (Gesamt) */
/* VTR110 Umsatz Ultra-Frische */ /* fix */ /* Setup Rang Filiale GJ */
/* Rang absteigend = Inventurdifferenz Ultra-Frische IST % */ /* VTR530 Mangel MHD */ /* Setup Rang VKL Monat */
/* ohne Rang */ /* Setup Rang VKL Monat */ /* Zeit Tag -- IST (separat wegen Schaltjahr) */ /* ohne Rang */
/* Rang absteigend = Kaufland Card Anteil ∆VJ %p */ /* Rang aufsteigend = Kassierfehler IST (absolut) */
/* Wert aus BIG vorhanden */ /* Referenz Region/Land */ /* Referenz Region/Land */
/* Rang absteigend = Scans/min IST (absolut) */ /* Setup Rang Filiale Monat */ /* Referenz Region/Land */
/* Referenz Region/Land */ /* Setup Rang Filiale Monat */ /* Umsatz */
/* V_KFL_RETAIL_STORE_MO_SUM gemappt -- IST (ohne WRG) */ /* Setup Rang VKL Monat */ /* Setup Rang VKL Monat */
/* Rang absteigend = Inventurdifferenz Ultra-Frische IST % */ /* Rang aufsteigend = Bestandsentw. zum Umsatz % */
/* Bestand Monat */ /* Setup Rang VKL Monat */ /* MV_ODS_BON_KASSENABSCHLUSS (KPOS) aggregiert -- IST (ohne WRG) */
/* Ausland = MV_VIS_MONAT_BIG_BESTANDSDIFFERENZEN */ /* Bestand Vormonat */
/* Rang aufsteigend = Mangel MHD IST (absolut) */ /* VTR525 Ø Warten Theke pro 10000 Kunden */
/* Referenz Region/Land */ /* Referenz Region/Land */ /* MV_ARTBEW_MO_SUM gruppiert - IST */
/* KFL_RETAIL_STORE_MO_SUM (Werte ab Jan 2024) gemappt, transformiert -- KVJ (ohne WRG) */
/* VTR425 Bestandsentw. zum Umsatz */ /* ohne Rang */ /* Wert aus BIG vorhanden */ /* CTE <--> MAIN */
/* Rang aufsteigend = Warten Theke IST (absolut) */ /* transformiert auf akt. Monat */ /* VTR340 Preisabschriften (%) */
/* Kein Plan auf Ebene Filiale */ /* manuelle Bestellungen */ /* Setup Rang VKL GJ (BS) */
/* Rang aufsteigend = Warten Kasse IST (absolut) */ /* Setup Rang VKL BJ (BS) */ /* Referenz Region/Land */
/* VTR732 Zählungen durchgeführt */ /* Setup Rang Filiale Monat */ /* MV_WUP_PLAN_KJMO_OWG gruppiert -- PLAN */
/* Setup Rang Filiale Monat */ /* Setup Rang Filiale GJ */ /* Referenz Region/Land */ /* Referenz Region/Land */
/* Setup Rang VKL BJ (BS) */ /* ohne Rang */ /* Referenz Region/Land */ /* DE = MV_VIS_MONAT_BIG_DE */ /* Reserve */
/* WUPCAL gemappt, aggregiert - IST (ohne WRG) */ /* Referenz Region/Land */ /* transformiert auf akt. Monat */
/* VTR505 K Card Anteil (Rang IST%) */ /* Setup Rang VKL BJ (BS) */ /* Setup Rang VKL Monat */
/* Rang absteigend = Abschriften operativ ∆Plan %p */ /* Zeit Tag -- KVJ (separat wegen Schaltjahr) */
/* Wert aus BIG vorhanden */ /* Filialen + definierte ZF */ /* Referenz Region/Land */
/* Rang absteigend = Kaufland Card Anteil ∆VJ %p */ /* Referenz Region/Land */ /* Setup Rang Filiale Monat */
/* Referenz Region/Land */ /* Setup Rang VKL BJ (BS) */ /* Setup Rang Filiale GJ */ /* Kein Plan auf Ebene Filiale */
/* Rang absteigend = Übernahmequote IST % */ /* Umsatz */ /* inkl Schließungen im vorigen GJ */
/* VTR420 Bestandsentwicklung */ /* Setup Rang Filiale GJ */ /* Rang aufteigend = Null-/Minusquote IST % * */
/* VTR320 Abschriften Ultra Frische (%) */ /* Wechsel am 02. April */ /* Referenz Region/Land */
/* VTR515 Ø Warten Kasse pro 10000 Kunden */ /* Referenz Region/Land */ /* Setup Rang VKL Monat */
/* Referenz Region/Land */ /* Rang absteigend = Kaufland Card Anteil IST % */
/* Rang aufsteigend = Preisauszeichnung IST (absolut) */ /* MV_VIS_MONAT_FAKT_WG gruppiert -- IST/KVJ */
/* VTR755 Null-/Minusquote */ /* V_VIS_TAG_KASSE + V_KASSE_TYP_PER umgerechnet, gemapped, aggregiert -- IST */
/* VTR200 Nettostunden */ /* Setup Rang VKL Monat */ /* Rang aufsteigend = Warten Kasse IST (absolut) */
/* Referenz Region/Land */ /* MV_VIS_BSCH_BESTVOR_DET aggregiert -- (ohne WRG) */ /* Setup Rang VKL BJ (BS) */
/* GJ der Schließung */ /* Referenz Region/Land */ /* Setup Rang Filiale Monat */ /* ohne Rang */
/* Referenz Region/Land */ /* Setup Rang VKL BJ (BS) */ /* VTR100 Umsatz netto */ /* Setup Rang Filiale GJ */
/* ohne Rang */ /* Setup Rang VKL Monat */ /* VTR270 Personalkosten */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_vtr_fakt_monat AS WITH ZEIT AS (SELECT ZEIT.gj,
   ZEIT.akt_gj /* Default. Wechsel am 02. März */,
    ZEIT.akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) AS akt_gj_mo,
   ZEIT.kjmo,
   ZEIT.kjmo_vj,
   ZEIT.akt_mo,
   ZEIT.min_dat,
   ZEIT.max_dat,
   KER.akt_buchungs_schluss AS akt_bs
  FROM kfl_production_dbp_data.monat AS ZEIT
   INNER JOIN kfl_production_dbp_data.l_buchungsstatus_ker AS KER ON ZEIT.kjmo = KER.kj_ker_mo_id
  WHERE ZEIT.akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) IN (- 1, 0)
   AND ZEIT.akt_mo < 0 /* 2 GJ bis Vormonat */), WUP AS (SELECT mandant_id,
   nb_id,
   vs_id,
   aktuell_wup_id,
   wup_id,
   CAST(IF(vkl_id > 0, vkl_id, (1000 + mandant_id * 100 + vs_id * 10) * - 1) AS BIGNUMERIC) AS vkl_id,
   COALESCE(dat_eroeffnung_alt, dat_eroeffnung) AS neo_dat,
   dat_bis AS stl_dat,
    EXTRACT(YEAR FROM COALESCE(dat_eroeffnung_alt, dat_eroeffnung)) - IF(EXTRACT(MONTH FROM COALESCE(dat_eroeffnung_alt
        , dat_eroeffnung)) < 3, 1, 0) AS neo_gj,
    EXTRACT(YEAR FROM dat_bis) - IF(EXTRACT(MONTH FROM dat_bis) < 3, 1, 0) AS stl_gj,
    CASE
    WHEN mandant_id = 1 AND wup_id IN (1263, 1273, 2583, 3166, 6623, 7220, 8120, 8563, 8940, 5876) OR mandant_id = 7 AND
        wup_id IN (1110, 1410, 6210, 6310, 6410) OR mandant_id = 3 AND wup_id IN (1010)
    THEN 1 /* PL */
    ELSE 0
    END AS aus_fg
  FROM kfl_production_dbp_data.wup AS WUP
  WHERE (nb_id = 0 OR wup_id IN (0, 2, 22, 28, 43, 46, 124, 8980, 8987, 8991, 100000, 100002, 100022, 100028, 100043,
       100046, 100124))
   AND dat_eroeffnung < DATE '2090-12-31'), MONAT_FAKT_WUP AS (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   t4.vs_id,
   t4.vkl_id,
   t1.gj,
   t1.kjmo,
   IF(t4.nb_id = 0 AND t1.gj > t4.neo_gj + 1 AND t4.stl_dat > t1.max_dat AND t4.aus_fg = 0, 1, 0) AS neo_fg,
   IF(t1.akt_bs <= 0, 1, 0) AS bus_fg,
   IF(t1.gj = t4.stl_gj, 0, 1) AS stl_fg,
   IF(t4.nb_id = 0 AND t4.vkl_id > 0, 1, 0) AS vkl_fg,
   SUM(VIS.ums_netto) AS ums_ist,
   SUM(VIS.ums_netto_kvj) AS ums_kvj,
   SUM(VIS.ums_netto_plan) AS ums_plan,
   SUM(VIS.anz_kunde) AS knd_ist,
   SUM(VIS.anz_kunde_kvj) AS knd_kvj,
    SUM(VIS.anz_kunde) / 10000 AS knd_10t_ist,
    SUM(VIS.anz_kunde_kvj) / 10000 AS knd_10t_kvj,
   SUM(VIS.pers_std) AS std_ist,
   SUM(VIS.pers_std_kvj) AS std_kvj,
   SUM(VIS.pers_std_plan) AS std_plan,
   SUM(VIS.pers_kosten) AS kst_ist,
   SUM(VIS.pers_kosten_kvj) AS kst_kvj,
   SUM(VIS.pers_kosten_plan) AS kst_plan
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wup AS VIS
   INNER JOIN ZEIT AS t1 ON VIS.kjmo = t1.kjmo
   INNER JOIN WUP AS t4 ON VIS.wup_id = t4.wup_id AND VIS.mandant_id = t4.mandant_id
  WHERE t4.stl_gj + 2 > t1.gj /* inkl Schließungen im vorigen GJ */
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   t4.vs_id,
   t4.vkl_id,
   t1.gj,
   t1.kjmo,
   neo_fg,
   bus_fg,
   stl_fg,
   vkl_fg), MONAT_FAKT_WARE AS (SELECT VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   VIS0.kjmo,
   SUM(VIS0.ums_netto) AS ums_ware_ist,
   SUM(VIS0.ums_netto_kvj) AS ums_ware_kvj,
   SUM(IF(VIS0.abt_id = 5, VIS0.ums_netto, 0)) AS ums_ulf_ist,
   SUM(IF(VIS0.abt_id = 5, VIS0.ums_netto_kvj, 0)) AS ums_ulf_kvj,
   SUM(IF(WG.owg_id <> 1092, VIS0.menge, 0)) AS menge_opf_ist,
   SUM(IF(WG.owg_id <> 1092, VIS0.menge_kvj, 0)) AS menge_opf_kvj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wg AS VIS0
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int AS WG ON VIS0.wg_id = WG.wg_id
   INNER JOIN ZEIT AS t23 ON VIS0.kjmo = t23.kjmo
   INNER JOIN WUP AS t26 ON VIS0.wup_id = t26.wup_id AND VIS0.mandant_id = t26.mandant_id
  WHERE t26.stl_gj + 2 > t23.gj /* inkl Schließungen im vorigen GJ */
  GROUP BY VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   VIS0.kjmo), MONAT_ARTBEW_IST AS (SELECT t71.mandant_id,
   t71.nb_id,
   t71.wup_id,
   t71.wrg_id,
   t71.kjmo0 AS kjmo,
   t71.ums_artb_ist,
   t71.ums_sa_ist,
   t71.ums_af_ist
  FROM (SELECT VIS2.mandant_id,
     VIS2.nb_id,
     VIS2.wup_id,
     VIS2.wrg_id,
     t65.kjmo AS kjmo0,
     SUM(VIS2.umsatz_netto) AS ums_artb_ist,
     SUM(IF(VIS2.bewart_id = 1002, VIS2.umsatz_netto, 0)) AS ums_sa_ist,
     SUM(IF(VIS2.bewart_id = 1001, VIS2.umsatz_netto, 0)) AS ums_af_ist
    FROM kfl_production_dbp_msi_view_vis.mv_artbew_mo_sum AS VIS2
     INNER JOIN ZEIT AS t65 ON VIS2.kjmo = t65.kjmo
     INNER JOIN WUP AS t68 ON VIS2.wup_id = t68.wup_id AND VIS2.mandant_id = t68.mandant_id
    WHERE t68.stl_gj + 2 > t65.gj /* GJ Schließung klären! */
    GROUP BY VIS2.mandant_id,
     VIS2.nb_id,
     VIS2.wup_id,
     VIS2.wrg_id,
     kjmo0) AS t71), MONAT_ARTBEW_KVJ AS (SELECT t81.mandant_id,
   t81.nb_id,
   t81.wup_id,
   t81.wrg_id,
   t81.kjmo0 /* transformiert auf akt. Monat */ AS kjmo,
   t81.ums_artb_kvj,
   t81.ums_sa_kvj,
   t81.ums_af_kvj
  FROM (SELECT VIS3.mandant_id,
     VIS3.nb_id,
     VIS3.wup_id,
     VIS3.wrg_id,
     t75.kjmo AS kjmo0,
     SUM(VIS3.umsatz_netto) AS ums_artb_kvj,
     SUM(IF(VIS3.bewart_id = 1002, VIS3.umsatz_netto, 0)) AS ums_sa_kvj,
     SUM(IF(VIS3.bewart_id = 1001, VIS3.umsatz_netto, 0)) AS ums_af_kvj
    FROM kfl_production_dbp_msi_view_vis.mv_artbew_mo_sum AS VIS3
     INNER JOIN ZEIT AS t75 ON VIS3.kjmo /* Transformation KVJ */ = t75.kjmo_vj
     INNER JOIN WUP AS t78 ON VIS3.wup_id = t78.wup_id AND VIS3.mandant_id = t78.mandant_id
    WHERE t78.stl_gj + 2 > t75.gj /* inkl Schließungen im vorigen GJ */
    GROUP BY VIS3.mandant_id,
     VIS3.nb_id,
     VIS3.wup_id,
     VIS3.wrg_id,
     kjmo0) AS t81), ZEIT_TAG_IST AS (SELECT dat,
   kjmo,
   akt_mo,
   gj,
    akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) AS akt_gj_mo
  FROM kfl_production_dbp_data.tag AS ZEIT
  WHERE akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) IN (- 1, 0)
   AND akt_mo < 0 /* 2 GJ bis Vormonat */), MONAT_KASSE_IST AS (SELECT VIS8.mandant_id,
   VIS8.nb_id,
   t226.aktuell_wup_id AS wup_id,
   krs.nach_wrg_id AS wrg_id,
   t229.kjmo,
   SUM(VIS8.umsatz_netto * krs.umrechnungskurs) AS ums_kass_ist,
   SUM(VIS8.anz_kunden) AS knd_kass_ist,
   SUM(VIS8.anz_artikel) AS art_kass_ist,
   SUM(IF(ktp.kasse_typ_id = 1, VIS8.umsatz_netto * krs.umrechnungskurs, 0)) AS ums_pos_ist,
   SUM(IF(ktp.kasse_typ_id = 1, VIS8.anz_kunden, 0)) AS knd_pos_ist,
   SUM(IF(ktp.kasse_typ_id = 1, VIS8.anz_artikel, 0)) AS art_pos_ist,
   SUM(IF(ktp.kasse_typ_id <> 1, VIS8.umsatz_netto * krs.umrechnungskurs, 0)) AS ums_sco_ist,
   SUM(IF(ktp.kasse_typ_id <> 1, VIS8.anz_kunden, 0)) AS knd_sco_ist,
   SUM(IF(ktp.kasse_typ_id <> 1, VIS8.anz_artikel, 0)) AS art_sco_ist,
   SUM(IF(ktp.kasse_typ_id = 1, VIS8.anz_artikel / 100000.00, 0)) AS art_100t_ist,
   SUM(IF(ktp.kasse_typ_id = 1, VIS8.registrierzeit / 60.0000, 0)) AS scan_min_ist,
   SUM(IF(ktp.kasse_typ_id = 1, VIS8.kassierzeit / 3600.0000, 0)) AS kass_std_ist
  FROM kfl_production_dbp_view.v_vis_tag_kasse AS VIS8
   INNER JOIN (SELECT KTP.mandant_id,
     KTP.wup_id,
     t217.dat,
     KTP.kasse_nr,
     KTP.kasse_typ_id
    FROM kfl_production_dbp_view.v_kasse_typ_per AS KTP
     INNER JOIN ZEIT_TAG_IST AS t217 ON t217.dat BETWEEN KTP.dat_von AND KTP.dat_bis AND KTP.kasse_typ_id IN (1, 8, 9,
        10, 11) /* Kassentyp : 1 = normal/POS, 8,9 = SCO, 10,11 = Paystation */) AS ktp ON VIS8.mandant_id = ktp.mandant_id
        AND VIS8.wup_id = ktp.wup_id AND VIS8.kasse_nr = ktp.kasse_nr AND VIS8.dat = ktp.dat
   INNER JOIN (SELECT von_wrg_id,
      nach_wrg_id,
      umrechnungskurs
     FROM kfl_production_dbp_data.kurs AS KRS1
     WHERE kurstyp_id = 3
      AND dat_bis = DATE '9999-12-31'
      AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
     UNION ALL
     SELECT von_wrg_id,
      von_wrg_id AS von_wrg_id0,
      1.0000
     FROM kfl_production_dbp_data.kurs AS KRS2
     WHERE kurstyp_id = 3
      AND dat_bis = DATE '9999-12-31'
      AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON VIS8.wrg_id = krs.von_wrg_id
   INNER JOIN WUP AS t226 ON VIS8.mandant_id = t226.mandant_id AND VIS8.wup_id = t226.wup_id
   INNER JOIN ZEIT_TAG_IST AS t229 ON VIS8.dat = t229.dat
  GROUP BY VIS8.mandant_id,
   VIS8.nb_id,
   wup_id,
   wrg_id,
   t229.kjmo), ZEIT_TAG_KVJ AS (SELECT dat AS dat_vj,
   kjmo AS kjmo_vj,
    kjmo + 100 AS kjmo,
   akt_mo,
   gj,
    akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) AS akt_gj_mo
  FROM kfl_production_dbp_data.tag AS ZEIT
  WHERE akt_gj + IF(EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) = 3, 1, 0) IN (- 2, - 1)
   AND akt_mo < - 12 /* 2 GJ bis Vormonat im VJ */), MONAT_KASSE_KVJ AS (SELECT VIS9.mandant_id,
   VIS9.nb_id,
   krs.nach_wrg_id AS wrg_id,
   t244.aktuell_wup_id AS wup_id,
   t247.kjmo,
   SUM(VIS9.umsatz_netto * krs.umrechnungskurs) AS ums_kass_kvj,
   SUM(VIS9.anz_kunden) AS knd_kass_kvj,
   SUM(VIS9.anz_artikel) AS art_kass_kvj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS9.umsatz_netto * krs.umrechnungskurs, 0)) AS ums_pos_kvj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS9.anz_kunden, 0)) AS knd_pos_kvj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS9.anz_artikel, 0)) AS art_pos_kvj,
   SUM(IF(ktp.kasse_typ_id <> 1, VIS9.umsatz_netto * krs.umrechnungskurs, 0)) AS ums_sco_kvj,
   SUM(IF(ktp.kasse_typ_id <> 1, VIS9.anz_kunden, 0)) AS knd_sco_kvj,
   SUM(IF(ktp.kasse_typ_id <> 1, VIS9.anz_artikel, 0)) AS art_sco_kvj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS9.anz_artikel / 100000.00, 0)) AS art_100t_kvj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS9.registrierzeit / 60.0000, 0)) AS scan_min_kvj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS9.kassierzeit / 3600.0000, 0)) AS kass_std_kvj
  FROM kfl_production_dbp_view.v_vis_tag_kasse AS VIS9
   INNER JOIN (SELECT KTP0.mandant_id,
     KTP0.wup_id,
     t235.dat_vj AS dat,
     KTP0.kasse_nr,
     KTP0.kasse_typ_id
    FROM kfl_production_dbp_view.v_kasse_typ_per AS KTP0
     INNER JOIN ZEIT_TAG_KVJ AS t235 ON t235.dat_vj BETWEEN KTP0.dat_von AND KTP0.dat_bis AND KTP0.kasse_typ_id IN (1, 8
        , 9, 10, 11) /* Kassentyp : 1 = normal/POS, 8,9 = SCO, 10,11 = Paystation */) AS ktp ON VIS9.mandant_id = ktp.mandant_id
        AND VIS9.wup_id = ktp.wup_id AND VIS9.kasse_nr = ktp.kasse_nr AND VIS9.dat = ktp.dat
   INNER JOIN (SELECT von_wrg_id,
      nach_wrg_id,
      umrechnungskurs
     FROM kfl_production_dbp_data.kurs AS KRS1
     WHERE kurstyp_id = 3
      AND dat_bis = DATE '9999-12-31'
      AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
     UNION ALL
     SELECT von_wrg_id,
      von_wrg_id AS von_wrg_id0,
      1.0000
     FROM kfl_production_dbp_data.kurs AS KRS2
     WHERE kurstyp_id = 3
      AND dat_bis = DATE '9999-12-31'
      AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON VIS9.wrg_id = krs.von_wrg_id
   INNER JOIN WUP AS t244 ON VIS9.mandant_id = t244.mandant_id AND VIS9.wup_id = t244.wup_id
   INNER JOIN ZEIT_TAG_KVJ AS t247 ON VIS9.dat /* Transformation KVJ */ = t247.dat_vj
  GROUP BY VIS9.mandant_id,
   VIS9.nb_id,
   wrg_id,
   wup_id,
   t247.kjmo), WOCHE_ODS_BON_KA_IST AS (SELECT VIS10.mandant_id,
   VIS10.wup_id,
   t265.kjmo,
   SUM(VIS10.anz_scans) AS scans_ist,
   SUM(VIS10.sum_scan_sek / 60) AS mins_ist
  FROM kfl_production_dbp_msi_view_vis.mv_ods_bon_kassenabschluss AS VIS10
   INNER JOIN ZEIT_TAG_IST AS t265 ON VIS10.dat = t265.dat
   INNER JOIN WUP AS t268 ON VIS10.mandant_id = t268.mandant_id AND VIS10.wup_id = t268.wup_id
  GROUP BY VIS10.mandant_id,
   VIS10.wup_id,
   t265.kjmo), WOCHE_ODS_BON_KA_KVJ AS (SELECT VIS11.mandant_id,
   VIS11.wup_id,
   t274.kjmo,
   SUM(VIS11.anz_scans) AS scans_kvj,
   SUM(VIS11.sum_scan_sek / 60) AS mins_kvj
  FROM kfl_production_dbp_msi_view_vis.mv_ods_bon_kassenabschluss AS VIS11
   INNER JOIN ZEIT_TAG_KVJ AS t274 ON VIS11.dat /* Transformation KVJ */ = t274.dat_vj
   INNER JOIN WUP AS t277 ON VIS11.mandant_id = t277.mandant_id AND VIS11.wup_id = t277.wup_id
  GROUP BY VIS11.mandant_id,
   VIS11.wup_id,
   t274.kjmo), MONAT_ABSCHRIFTEN AS (SELECT t372.mandant_id,
   t372.nb_id,
   t372.wup_id,
   t372.wrg_id,
   t372.kjmo0 AS kjmo,
   t372.abs_op_ist,
   t372.abs_op_kvj,
   t372.abs_ulf_ist,
   t372.abs_ulf_kvj,
   t372.abs_ta_ist,
   t372.abs_ta_kvj,
   t372.abs_pa_ist,
   t372.abs_pa_kvj
  FROM (SELECT VIS14.mandant_id,
     VIS14.nb_id,
     VIS14.wup_id,
     VIS14.wrg_id,
     t366.kjmo AS kjmo0,
     SUM(CASE
        WHEN VIS14.mandant_id IN (6) AND VIS14.abschriftart_id = 2 OR VIS14.mandant_id IN (3) AND VIS14.abschriftart_id
              = 11 OR VIS14.mandant_id IN (2, 4, 5, 7, 8) AND VIS14.abschriftart_id = 7 OR VIS14.mandant_id IN (2, 5)
           AND VIS14.abschriftart_id = 10 OR VIS14.abschriftart_id = 20 AND VIS14.mandant_id NOT IN (1)
        THEN 1
        ELSE - 1
        END * VIS14.abschrift_netto) AS abs_op_ist,
     SUM(CASE
        WHEN VIS14.mandant_id IN (6) AND VIS14.abschriftart_id = 2 OR VIS14.mandant_id IN (3) AND VIS14.abschriftart_id
              = 11 OR VIS14.mandant_id IN (2, 4, 5, 7, 8) AND VIS14.abschriftart_id = 7 OR VIS14.mandant_id IN (2, 5)
           AND VIS14.abschriftart_id = 10 OR VIS14.abschriftart_id = 20 AND VIS14.mandant_id NOT IN (1)
        THEN 1
        ELSE - 1
        END * VIS14.abschrift_netto_kvj) AS abs_op_kvj,
     SUM(CASE
        WHEN VIS14.abt_id = 5
        THEN CASE
         WHEN VIS14.mandant_id IN (6) AND VIS14.abschriftart_id = 2 OR VIS14.abt_id = 5 AND VIS14.mandant_id IN (3) AND
               VIS14.abschriftart_id = 11 OR VIS14.abt_id = 5 AND VIS14.mandant_id IN (2, 4, 5, 7, 8) AND VIS14.abschriftart_id
               = 7 OR VIS14.abt_id = 5 AND VIS14.mandant_id IN (2, 5) AND VIS14.abschriftart_id = 10 OR VIS14.abt_id = 5
              AND VIS14.abschriftart_id = 20 AND VIS14.mandant_id NOT IN (1)
         THEN 1
         ELSE - 1
         END
        ELSE 0
        END * VIS14.abschrift_netto) AS abs_ulf_ist,
     SUM(CASE
        WHEN VIS14.abt_id = 5
        THEN CASE
         WHEN VIS14.abt_id = 5 AND VIS14.mandant_id IN (6) AND VIS14.abschriftart_id = 2 OR VIS14.abt_id = 5 AND VIS14.mandant_id
                 IN (3) AND VIS14.abschriftart_id = 11 OR VIS14.abt_id = 5 AND VIS14.mandant_id IN (2, 4, 5, 7, 8) AND
              VIS14.abschriftart_id = 7 OR VIS14.abt_id = 5 AND VIS14.mandant_id IN (2, 5) AND VIS14.abschriftart_id =
             10 OR VIS14.abt_id = 5 AND VIS14.abschriftart_id = 20 AND VIS14.mandant_id NOT IN (1)
         THEN 1
         ELSE - 1
         END
        ELSE 0
        END * VIS14.abschrift_netto_kvj) AS abs_ulf_kvj,
     SUM(CASE
        WHEN ABS_THEMA.abschriftart_thema_int_id = 1
        THEN CASE
         WHEN VIS14.mandant_id IN (6) AND VIS14.abschriftart_id = 2 OR VIS14.mandant_id IN (3) AND VIS14.abschriftart_id
                = 11 OR VIS14.mandant_id IN (2, 4, 5, 7, 8) AND VIS14.abschriftart_id = 7 OR VIS14.mandant_id IN (2, 5)
            AND VIS14.abschriftart_id = 10 OR VIS14.abschriftart_id = 20 AND VIS14.mandant_id NOT IN (1)
         THEN 1
         ELSE - 1
         END
        ELSE 0
        END * VIS14.abschrift_netto) AS abs_ta_ist,
     SUM(CASE
        WHEN ABS_THEMA.abschriftart_thema_int_id = 1
        THEN CASE
         WHEN VIS14.mandant_id IN (6) AND VIS14.abschriftart_id = 2 OR VIS14.mandant_id IN (3) AND VIS14.abschriftart_id
                = 11 OR VIS14.mandant_id IN (2, 4, 5, 7, 8) AND VIS14.abschriftart_id = 7 OR VIS14.mandant_id IN (2, 5)
            AND VIS14.abschriftart_id = 10 OR VIS14.abschriftart_id = 20 AND VIS14.mandant_id NOT IN (1)
         THEN 1
         ELSE - 1
         END
        ELSE 0
        END * VIS14.abschrift_netto_kvj) AS abs_ta_kvj,
     SUM(CASE
        WHEN ABS_THEMA.abschriftart_thema_int_id = 4
        THEN CASE
         WHEN VIS14.mandant_id IN (6) AND VIS14.abschriftart_id = 2 OR VIS14.mandant_id IN (3) AND VIS14.abschriftart_id
                = 11 OR VIS14.mandant_id IN (2, 4, 5, 7, 8) AND VIS14.abschriftart_id = 7 OR VIS14.mandant_id IN (2, 5)
            AND VIS14.abschriftart_id = 10 OR VIS14.abschriftart_id = 20 AND VIS14.mandant_id NOT IN (1)
         THEN 1
         ELSE - 1
         END
        ELSE 0
        END * VIS14.abschrift_netto) AS abs_pa_ist,
     SUM(CASE
        WHEN ABS_THEMA.abschriftart_thema_int_id = 4
        THEN CASE
         WHEN VIS14.mandant_id IN (6) AND VIS14.abschriftart_id = 2 OR VIS14.mandant_id IN (3) AND VIS14.abschriftart_id
                = 11 OR VIS14.mandant_id IN (2, 4, 5, 7, 8) AND VIS14.abschriftart_id = 7 OR VIS14.mandant_id IN (2, 5)
            AND VIS14.abschriftart_id = 10 OR VIS14.abschriftart_id = 20 AND VIS14.mandant_id NOT IN (1)
         THEN 1
         ELSE - 1
         END
        ELSE 0
        END * VIS14.abschrift_netto_kvj) AS abs_pa_kvj
    FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_abschriften_wg AS VIS14
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu AS ABS_ART ON VIS14.abschriftart_id = ABS_ART.abschriftart_id
        AND VIS14.mandant_id = ABS_ART.mandant_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu AS ABS_THEMA ON ABS_ART.abschriftart_int_id
       = ABS_THEMA.abschriftart_int_id
     INNER JOIN ZEIT_TAG_IST AS t366 ON VIS14.dat = t366.dat
     INNER JOIN WUP AS t369 ON VIS14.wup_id = t369.wup_id AND VIS14.mandant_id = t369.mandant_id
    WHERE t369.stl_gj + 2 > t366.gj /* inkl Schließungen im vorigen GJ */
     AND ABS_THEMA.abschriftart_thema_int_id IN (1, 4) /* Abschriften op = Totalabschriften + Preisabschriften */
    GROUP BY VIS14.mandant_id,
     VIS14.nb_id,
     VIS14.wup_id,
     VIS14.wrg_id,
     kjmo0) AS t372), MONAT_PLAN_WARE AS (SELECT t413.mandant_id,
   t413.nb_id,
   t413.wup_id,
   t413.wrg_id,
   t413.kjmo0 AS kjmo,
   t413.ums_ware_plan,
   t413.abs_ware_plan,
   t413.ums_ulf_plan,
   t413.abs_ulf_plan
  FROM (SELECT VIS17.mandant_id,
     VIS17.nb_id,
     VIS17.wup_id,
     VIS17.wrg_id,
     t407.kjmo AS kjmo0,
     SUM(VIS17.umsatz_netto_plan) AS ums_ware_plan,
     SUM(VIS17.abschriften_netto_operativ_plan) AS abs_ware_plan,
     SUM(IF(HWG.abt_id = 5, VIS17.umsatz_netto_plan, 0)) AS ums_ulf_plan,
     SUM(IF(HWG.abt_id = 5, VIS17.abschriften_netto_operativ_plan, 0)) AS abs_ulf_plan
    FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg AS VIS17
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int AS OWG ON VIS17.owg_id = OWG.owg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int AS HWG ON OWG.hwg_id = HWG.hwg_id
     INNER JOIN ZEIT AS t407 ON VIS17.kjmo = t407.kjmo
     INNER JOIN WUP AS t410 ON VIS17.wup_id = t410.wup_id AND VIS17.mandant_id = t410.mandant_id
    WHERE t410.stl_gj + 2 > t407.gj
    GROUP BY VIS17.mandant_id,
     VIS17.nb_id,
     VIS17.wup_id,
     VIS17.wrg_id,
     kjmo0) AS t413), MONAT_INVENTUR AS (SELECT VIS27.mandant_id,
   VIS27.nb_id,
   VIS27.wup_id,
   VIS27.wrg_id,
   t574.kjmo,
   SUM(VIS27.inventur_wert_netto) AS inv_wert_ist,
   SUM(VIS27.inventur_ums_netto) AS inv_ums_ist
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur AS VIS27
   INNER JOIN ZEIT_TAG_IST AS t574 ON VIS27.dat_plan_zaehlung /* Mapping, abweichendes Datum */ = t574.dat
   INNER JOIN WUP AS t577 ON VIS27.wup_id = t577.wup_id AND VIS27.mandant_id = t577.mandant_id
  WHERE t577.stl_gj + 2 > t574.gj /* inkl Schließungen im vorigen GJ */
   AND VIS27.abt_invart_id IN (50) /* nur Frische Inventur */
  GROUP BY VIS27.mandant_id,
   VIS27.nb_id,
   VIS27.wup_id,
   VIS27.wrg_id,
   t574.kjmo), MONAT_BIG AS (SELECT VIS.mandant_id,
    t598.nb_id,
    VIS.wup_id,
    VIS.wrg_id,
    t595.kjmo,
    1 AS big_fg,
    SUM(IF(VIS.belastungsart_vd_id = 4, VIS.vk_netto, 0)) AS big_ums_netto,
    SUM(IF(VIS.belastungsart_vd_id = 1, VIS.vk_netto, 0)) AS big_01,
    SUM(IF(VIS.belastungsart_vd_id = 2, VIS.vk_netto, 0)) AS big_02,
    CAST(NULL AS BIGNUMERIC) AS big_03,
    CAST(NULL AS BIGNUMERIC) AS big_04,
      SUM(IF(VIS.belastungsart_vd_id = 1, VIS.vk_netto, 0)) + SUM(IF(VIS.belastungsart_vd_id = 2, VIS.vk_netto, 0)) -
     SUM(IF(VIS.belastungsart_vd_id = 4, VIS.vk_netto, 0)) AS big_best_entw
   FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_big_de AS VIS
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_art_wg_zu AS ART ON VIS.mandant_id = ART.mandant_id AND VIS.art_id =
      ART.art_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int AS WG ON ART.wg_id = WG.wg_id
    INNER JOIN ZEIT AS t595 ON VIS.kjmo = t595.kjmo
    INNER JOIN WUP AS t598 ON VIS.wup_id = t598.wup_id AND VIS.mandant_id = t598.mandant_id
   WHERE t598.stl_gj + 2 > t595.gj /* inkl Schließungen im vorigen GJ */
    AND t595.akt_mo BETWEEN - 12 AND (- 1 /* analog mv_view (nur 12 Monate vorhanden) */)
    AND VIS.mandant_id = 1
    AND VIS.belastungsart_vd_id IN (1, 2, 4) /* DE + Filter */
    AND WG.owg_id NOT IN (1094)
   GROUP BY VIS.mandant_id,
    t598.nb_id,
    VIS.wup_id,
    VIS.wrg_id,
    t595.kjmo,
    big_fg,
    big_03,
    big_04
   UNION ALL
   SELECT vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.kjmo,
    1 AS big_fg,
    vis.ums_ware_ist AS big_ums_netto,
    CAST(NULL AS BIGNUMERIC) AS big_01,
    CAST(NULL AS BIGNUMERIC) AS big_02,
    big.best_mo AS big_03,
    big.best_vm AS big_04,
     big.best_mo - big.best_vm AS big_best_entw
   FROM MONAT_FAKT_WARE AS vis
    INNER JOIN (SELECT VIS28.mandant_id,
      VIS28.nb_id,
      VIS28.wup_id,
      krs.nach_wrg_id AS wrg_id,
      VIS28.kjmo,
      1 AS big_fg,
      SUM(VIS28.bestandswert_zvkp_vk_netto * krs.umrechnungskurs) AS best_mo,
      SUM(VIS28.bestandswert_vormonat_zvkp_vk_netto * krs.umrechnungskurs) AS best_vm
     FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_big_bestandsdifferenzen AS VIS28
      INNER JOIN (SELECT von_wrg_id,
         nach_wrg_id,
         umrechnungskurs
        FROM kfl_production_dbp_data.kurs AS KRS1
        WHERE kurstyp_id = 3
         AND dat_bis = DATE '9999-12-31'
         AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
        UNION ALL
        SELECT von_wrg_id,
         von_wrg_id AS von_wrg_id0,
         1.0000
        FROM kfl_production_dbp_data.kurs AS KRS2
        WHERE kurstyp_id = 3
         AND dat_bis = DATE '9999-12-31'
         AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON VIS28.wrg_id = krs.von_wrg_id
      INNER JOIN ZEIT AS t620 ON VIS28.kjmo = t620.kjmo
      INNER JOIN WUP AS t623 ON VIS28.wup_id = t623.wup_id AND VIS28.mandant_id = t623.mandant_id
     WHERE t623.stl_gj + 2 > t620.gj /* inkl Schließungen im vorigen GJ */
      AND t620.akt_mo BETWEEN - 12 AND (- 1 /* analog mv_view (12 Monate) */)
      AND VIS28.mandant_id > 1 /* Ausland */
     GROUP BY VIS28.mandant_id,
      VIS28.nb_id,
      VIS28.wup_id,
      wrg_id,
      VIS28.kjmo,
      big_fg) AS big ON vis.mandant_id = big.mandant_id AND vis.wup_id = big.wup_id AND vis.wrg_id = big.wrg_id AND vis
      .kjmo = big.kjmo
    INNER JOIN ZEIT AS t630 ON vis.kjmo = t630.kjmo
   WHERE t630.akt_mo BETWEEN - 12 AND (- 1 /* analog mv_view (nur 12 Monate vorhanden) */)
    AND vis.mandant_id > 1 /* Ausland */), MONAT_GOOGLE_IST AS (SELECT VIS30.mandant_id,
   VIS30.nb_id,
   t703.aktuell_wup_id AS wup_id,
   t700.kjmo,
   SUM(VIS30.sum_review_rating) AS sum_review_ist,
   SUM(VIS30.anz_review_rating) AS anz_review_ist
  FROM kfl_production_dbp_msi_v_view.v_kfl_retail_store_mo_sum AS VIS30
   INNER JOIN ZEIT AS t700 ON VIS30.kjmo = t700.kjmo
   INNER JOIN WUP AS t703 ON VIS30.mandant_id = t703.mandant_id AND VIS30.wup_id = t703.wup_id
  GROUP BY VIS30.mandant_id,
   VIS30.nb_id,
   wup_id,
   t700.kjmo), MONAT_GOOGLE_KVJ AS (SELECT VIS31.mandant_id,
   VIS31.nb_id,
   t712.aktuell_wup_id AS wup_id,
   t709.kjmo,
   SUM(VIS31.sum_review_rating) AS sum_review_kvj,
   SUM(VIS31.anz_review_rating) AS anz_review_kvj
  FROM kfl_production_dbp_msi_data.kfl_retail_store_mo_sum AS VIS31
   INNER JOIN ZEIT AS t709 ON VIS31.kjmo /* Transformation KVJ */ = t709.kjmo_vj
   INNER JOIN WUP AS t712 ON VIS31.mandant_id = t712.mandant_id AND VIS31.wup_id = t712.wup_id
  WHERE t712.stl_gj + 2 > t709.gj /* inkl Schließungen im vorigen GJ */
  GROUP BY VIS31.mandant_id,
   VIS31.nb_id,
   wup_id,
   t709.kjmo), MONAT_WCAL_IST AS (SELECT WCAL.mandant_id,
   WCAL.nb_id,
   t734.aktuell_wup_id AS wup_id,
   t731.kjmo,
   SUM(WCAL.bonanzahl_sug) AS bon_ist,
   SUM(WCAL.bonanzahl_kundenkarte) AS bon_kk,
   SUM(WCAL.bonanzahl_kundenkarte_payback) AS bon_pb,
    SUM(WCAL.bonanzahl_kundenkarte) - IFNULL(SUM(WCAL.bonanzahl_kundenkarte_payback), 0) AS kcard_ist
  FROM kfl_production_dbp_data.wupcal AS WCAL
   INNER JOIN ZEIT_TAG_IST AS t731 ON WCAL.dat = t731.dat
   INNER JOIN WUP AS t734 ON WCAL.mandant_id = t734.mandant_id AND WCAL.wup_id = t734.wup_id
  WHERE t734.stl_gj + 2 > t731.gj /* inkl Schließungen im vorigen GJ */
  GROUP BY WCAL.mandant_id,
   WCAL.nb_id,
   wup_id,
   t731.kjmo), MONAT_WCAL_KVJ AS (SELECT WCAL0.mandant_id,
   WCAL0.nb_id,
   t744.aktuell_wup_id AS wup_id,
   t741.kjmo,
   SUM(WCAL0.bonanzahl_sug) AS bon_kvj,
   SUM(WCAL0.bonanzahl_kundenkarte) AS bon_kk,
   SUM(WCAL0.bonanzahl_kundenkarte_payback) AS bon_pb,
    SUM(WCAL0.bonanzahl_kundenkarte) - IFNULL(SUM(WCAL0.bonanzahl_kundenkarte_payback), 0) AS kcard_kvj
  FROM kfl_production_dbp_data.wupcal AS WCAL0
   INNER JOIN ZEIT_TAG_KVJ AS t741 ON WCAL0.dat /* Transformation KVJ */ = t741.dat_vj
   INNER JOIN WUP AS t744 ON WCAL0.mandant_id = t744.mandant_id AND WCAL0.wup_id = t744.wup_id
  WHERE t744.stl_gj + 2 > t741.gj /* inkl Schließungen im vorigen GJ */
  GROUP BY WCAL0.mandant_id,
   WCAL0.nb_id,
   wup_id,
   t741.kjmo), MONAT_REKL_IST AS (SELECT VIS32.mandant_id,
   VIS32.nb_id,
   VIS32.wup_id,
   VIS32.wrg_id,
   t795.kjmo,
   SUM(IF(VIS32.reklamationsgrund_id IN (12, 19), 1, 0)) AS f_preis_ist,
   SUM(IF(VIS32.reklamationsgrund_id IN (13, 14), 1, 0)) AS f_kasse_ist,
   SUM(IF(VIS32.reklamationsgrund_id = 91, VIS32.vk_menge_kuga, 0)) AS w_theke_ist,
   SUM(IF(VIS32.reklamationsgrund_id = 92, VIS32.vk_menge_kuga, 0)) AS w_kasse_ist,
   SUM(IF(VIS32.reklamationsgrund_id = 93, VIS32.vk_menge_kuga, 0)) AS anz_mhd_ist
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art AS VIS32
   INNER JOIN ZEIT_TAG_IST AS t795 ON VIS32.dat = t795.dat
   INNER JOIN WUP AS t798 ON VIS32.wup_id = t798.wup_id AND VIS32.mandant_id = t798.mandant_id
  WHERE t798.stl_gj + 2 > t795.gj /* inkl Schließungen im vorigen GJ */
   AND VIS32.reklamationsgrund_id IN (12, 13, 14, 19, 91, 92, 93) /* Definierte Gründe, ohne Pfand */
   AND (VIS32.mandant_id, VIS32.art_id) IN (SELECT (mandant_id, art_id)
     FROM kfl_production_dbp_msi_view_vis.mv_art_wg_zu
     WHERE wg_id NOT IN (980))
  GROUP BY VIS32.mandant_id,
   VIS32.nb_id,
   VIS32.wup_id,
   VIS32.wrg_id,
   t795.kjmo), MONAT_REKL_KVJ AS (SELECT VIS33.mandant_id,
   VIS33.nb_id,
   VIS33.wup_id,
   VIS33.wrg_id,
   t807.kjmo,
   SUM(IF(VIS33.reklamationsgrund_id IN (12, 19), 1, 0)) AS f_preis_kvj,
   SUM(IF(VIS33.reklamationsgrund_id IN (13, 14), 1, 0)) AS f_kasse_kvj,
   SUM(IF(VIS33.reklamationsgrund_id = 91, VIS33.vk_menge_kuga, 0)) AS w_theke_kvj,
   SUM(IF(VIS33.reklamationsgrund_id = 92, VIS33.vk_menge_kuga, 0)) AS w_kasse_kvj,
   SUM(IF(VIS33.reklamationsgrund_id = 93, VIS33.vk_menge_kuga, 0)) AS anz_mhd_kvj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art AS VIS33
   INNER JOIN ZEIT_TAG_KVJ AS t807 ON VIS33.dat /* Transformation auf kjwo_vj */ = t807.dat_vj
   INNER JOIN WUP AS t810 ON VIS33.wup_id = t810.wup_id AND VIS33.mandant_id = t810.mandant_id
  WHERE t810.stl_gj + 2 > t807.gj /* inkl Schließungen im vorigen GJ */
   AND VIS33.reklamationsgrund_id IN (12, 13, 14, 19, 91, 92, 93) /* Definierte Gründe, ohne Pfand */
   AND (VIS33.mandant_id, VIS33.art_id) IN (SELECT (mandant_id, art_id)
     FROM kfl_production_dbp_msi_view_vis.mv_art_wg_zu
     WHERE wg_id NOT IN (980))
  GROUP BY VIS33.mandant_id,
   VIS33.nb_id,
   VIS33.wup_id,
   VIS33.wrg_id,
   t807.kjmo), MONAT_BESTVOR AS (SELECT VIS54.mandant_id,
   VIS54.nb_id,
   VIS54.wup_id,
   t1186.kjmo,
   SUM(IF(VIS54.status NOT IN ('0B', '0N'), 1, 0)) AS best_vor,
   SUM(IF(VIS54.status IN ('0B'), 1, 0)) AS best_man,
   SUM(IF(VIS54.status IN ('V0', 'V-', 'V+'), 1, 0)) AS best_kor
  FROM kfl_production_dbp_msi_view_vis.mv_bsch_bestvor_det AS VIS54
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_art_wg_zu AS ART ON VIS54.art_id = ART.art_id AND VIS54.mandant_id =
     ART.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int AS WG ON ART.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN ZEIT_TAG_IST AS t1186 ON VIS54.dat_plan = t1186.dat
   INNER JOIN WUP AS t1189 ON VIS54.wup_id = t1189.wup_id AND VIS54.mandant_id = t1189.mandant_id
  WHERE t1189.stl_gj + 2 > t1186.gj /* inkl Schließungen im vorigen GJ */
   AND HWG.abt_id IN (5, 6, 7, 8) /* Abteilung ohne Nebengeschäft */
   AND VIS54.status NOT IN ('0N')
  GROUP BY VIS54.mandant_id,
   VIS54.wup_id,
   VIS54.nb_id,
   t1186.kjmo), MONAT_ZAEHL_AUFTRAG AS (SELECT VIS55.mandant_id,
   VIS55.nb_id,
   VIS55.wup_id,
   t1208.kjmo,
   SUM(IF(VIS55.dat_auftrag IS NOT NULL, 1, 0)) AS auftrag,
   SUM(IF(VIS55.dat_zaehl IS NOT NULL, 1, 0)) AS gezaehlt
  FROM kfl_production_dbp_msi_view_vis.mv_vis_zaehl_auftrag AS VIS55
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_art_wg_zu AS ART ON VIS55.art_id = ART.art_id AND VIS55.mandant_id =
     ART.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int AS WG ON ART.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN ZEIT_TAG_IST AS t1208 ON VIS55.dat_auftrag /* dat = dat_auftrag */ = t1208.dat
   INNER JOIN WUP AS t1211 ON VIS55.wup_id = t1211.wup_id AND VIS55.mandant_id = t1211.mandant_id
  WHERE t1211.stl_gj + 2 > t1208.gj /* inkl Schließungen im vorigen GJ */
   AND VIS55.zaehl_grund_id IN ('214', '299', '300', '301', '310', '311', '320', '330', '340', '350', '360', '814',
     '999') /* definierte Zählgründe */
   AND HWG.abt_id IN (5, 6, 7, 8) /* Abteilung ohne Nebengeschäft */
  GROUP BY VIS55.mandant_id,
   VIS55.wup_id,
   VIS55.nb_id,
   t1208.kjmo), MONAT_FWWS AS (SELECT t1277.mandant_id,
   t1277.nb_id,
   t1277.wup_id,
   t1277.kjmo0 AS kjmo,
   t1277.auto_dispo,
   t1277.minus_best,
   t1277.null_best
  FROM (SELECT VIS58.mandant_id,
     VIS58.nb_id,
     VIS58.wup_id,
     t1271.kjmo AS kjmo0,
     SUM(VIS58.anz_artikel_autodispo_dm12) AS auto_dispo,
     SUM(VIS58.anz_artikel_exc214) AS minus_best,
     SUM(IF(VIS58.dispomerkmal IN ('10', '11', '14') OR VIS58.mandant_id <> 1, VIS58.anz_artikel_exc209, NULL)) AS
     null_best
    FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_fwws_wg AS VIS58
     INNER JOIN ZEIT_TAG_IST AS t1271 ON VIS58.dat = t1271.dat
     INNER JOIN WUP AS t1274 ON VIS58.wup_id = t1274.wup_id AND VIS58.mandant_id = t1274.mandant_id
    WHERE t1274.stl_gj + 2 > t1271.gj /* inkl Schließungen im vorigen GJ */
    GROUP BY VIS58.mandant_id,
     VIS58.nb_id,
     VIS58.wup_id,
     kjmo0) AS t1277) (SELECT *
  FROM (SELECT 100 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      CAST(NULL AS BIGNUMERIC) AS filist2,
      kvj_fil AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      plan_fil AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      ist_reg AS regist,
      CAST(NULL AS BIGNUMERIC) AS regist2,
      kvj_reg AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      ist_land AS landist,
      CAST(NULL AS BIGNUMERIC) AS landist2,
      kvj_land AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT mandant_id,
        nb_id,
        wup_id,
        wrg_id,
        vs_id,
        vkl_id,
        gj,
        kjmo,
        neo_fg,
        vkl_fg,
        bus_fg,
        stl_fg,
        ums_ist AS ist_fil,
        ums_kvj AS kvj_fil,
        ums_plan AS plan_fil,
        SUM(ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(ums_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(ums_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
         neo_fg * ums_ist AS ist_fil_mo,
         neo_fg * ums_plan AS plan_fil_mo,
        SUM(neo_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(neo_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS plan_fil_gj,
        SUM(neo_fg * vkl_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(neo_fg * vkl_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS plan_vkl_mo,
        SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS plan_vkl_gj,
         IF(neo_fg = 0, NULL, neo_fg) * ((neo_fg * ums_ist - neo_fg * ums_plan) / IF(neo_fg * ums_plan = 0, NULL, neo_fg
              * ums_plan)) AS fil_mo,
         IF(neo_fg * stl_fg = 0, NULL, neo_fg * stl_fg) * (((SUM(neo_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                 , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING)) - (SUM(neo_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                 , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING))) / IF((SUM(neo_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                 , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
               , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vkl_fg = 0, NULL, vkl_fg) * (((SUM(neo_fg * vkl_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                 , wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING)) - (SUM(neo_fg * vkl_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING),
                 wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING))) / IF((SUM(neo_fg * vkl_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                 , wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * vkl_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
               , wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vkl_fg * stl_fg = 0, NULL, vkl_fg * stl_fg) * (((SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                 , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING)) - (SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                 , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING))) / IF((SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                 , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
               , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0) AS vtr
     UNION ALL
     SELECT 110 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.ums_ulf_ist AS filist,
      CAST(NULL AS BIGNUMERIC) AS filist2,
      sub1.ums_ulf_kvj AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.ums_ulf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      CAST(NULL AS BIGNUMERIC) AS regist2,
      SUM(sub1.ums_ulf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      SUM(sub1.ums_ulf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      CAST(NULL AS BIGNUMERIC) AS landist2,
      SUM(sub1.ums_ulf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_FAKT_WARE AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
     UNION ALL
     SELECT 115 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.ums_ulf_ist AS filist,
      sub1.ums_ware_ist AS filist2,
      sub1.ums_ulf_kvj AS filwvj,
      sub1.ums_ware_kvj AS filwvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.ums_ulf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(sub1.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub1.ums_ulf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regwvj,
      SUM(sub1.ums_ware_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regwvj2,
      SUM(sub1.ums_ulf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(sub1.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub1.ums_ulf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landwvj,
      SUM(sub1.ums_ware_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landwvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_FAKT_WARE AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
     UNION ALL
     SELECT 120 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.ums_sa_ist AS filist,
      CAST(NULL AS BIGNUMERIC) AS filist2,
      sub2.ums_sa_kvj AS filwvj,
      CAST(NULL AS BIGNUMERIC) AS filwvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.ums_sa_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      CAST(NULL AS BIGNUMERIC) AS regist2,
      SUM(sub2.ums_sa_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regwvj,
      CAST(NULL AS BIGNUMERIC) AS regwvj2,
      SUM(sub1.ums_sa_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      CAST(NULL AS BIGNUMERIC) AS landist2,
      SUM(sub2.ums_sa_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landwvj,
      CAST(NULL AS BIGNUMERIC) AS landwvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_ARTBEW_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
      LEFT JOIN MONAT_ARTBEW_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
          = sub2.wrg_id AND vis0.kjmo = sub2.kjmo
     UNION ALL
     SELECT 125 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.ums_sa_ist AS filist,
      sub1.ums_artb_ist AS filist2,
      sub2.ums_sa_kvj AS filwvj,
      sub2.ums_artb_kvj AS filwvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.ums_sa_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(sub1.ums_artb_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub2.ums_sa_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regwvj,
      SUM(sub2.ums_artb_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regwvj2,
      SUM(sub1.ums_sa_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(sub1.ums_artb_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub2.ums_sa_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landwvj,
      SUM(sub2.ums_artb_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landwvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_ARTBEW_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
      LEFT JOIN MONAT_ARTBEW_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
          = sub2.wrg_id AND vis0.kjmo = sub2.kjmo
     UNION ALL
     SELECT 140 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.menge_opf_ist AS filist,
      CAST(NULL AS BIGNUMERIC) AS filist2,
      sub1.menge_opf_kvj AS filwvj,
      CAST(NULL AS BIGNUMERIC) AS filwvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.menge_opf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      CAST(NULL AS BIGNUMERIC) AS regist2,
      SUM(sub1.menge_opf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regwvj,
      CAST(NULL AS BIGNUMERIC) AS regwvj2,
      SUM(sub1.menge_opf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      CAST(NULL AS BIGNUMERIC) AS landist2,
      SUM(sub1.menge_opf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landwvj,
      CAST(NULL AS BIGNUMERIC) AS landwvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_FAKT_WARE AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
     UNION ALL
     SELECT 160 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      knd_ist AS filist,
      CAST(NULL AS BIGNUMERIC) AS filist2,
      knd_kvj AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(knd_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      CAST(NULL AS BIGNUMERIC) AS regist2,
      SUM(knd_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      SUM(knd_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      CAST(NULL AS BIGNUMERIC) AS landist2,
      SUM(knd_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
     UNION ALL
     SELECT 180 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ums_ist AS filist,
      knd_ist AS filist2,
      ums_kvj AS filkvj,
      knd_kvj AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(knd_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(ums_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(knd_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(knd_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(ums_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(knd_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
     UNION ALL
     SELECT 200 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      std_ist AS filist,
      CAST(NULL AS BIGNUMERIC) AS filist2,
      std_kvj AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      std_plan AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      CAST(NULL AS BIGNUMERIC) AS regist2,
      SUM(std_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      SUM(std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      CAST(NULL AS BIGNUMERIC) AS landist2,
      SUM(std_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
     UNION ALL
     SELECT 210 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      kvj_fil AS filkvj,
      kvj_fil2 AS filkvj2,
      plan_fil AS filplan,
      plan_fil2 AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      kvj_reg AS regkvj,
      kvj_reg2 AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      kvj_land AS landkvj,
      kvj_land2 AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT mandant_id,
        nb_id,
        wup_id,
        wrg_id,
        vs_id,
        vkl_id,
        gj,
        kjmo,
        neo_fg,
        vkl_fg,
        bus_fg,
        stl_fg,
        ums_ist AS ist_fil,
        std_ist AS ist_fil2,
        ums_kvj AS kvj_fil,
        std_kvj AS kvj_fil2,
        ums_plan AS plan_fil,
        std_plan AS plan_fil2,
        SUM(ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(ums_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(std_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg2,
        SUM(ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
        SUM(ums_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
        SUM(std_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land2,
         neo_fg * ums_ist AS ist_fil_mo,
         neo_fg * std_ist AS ist_fil_mo2,
         neo_fg * ums_plan AS plan_fil_mo,
         neo_fg * std_plan AS plan_fil_mo2,
        SUM(neo_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(neo_fg * stl_fg * bus_fg * std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(neo_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS plan_fil_gj,
        SUM(neo_fg * stl_fg * bus_fg * std_plan) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS plan_fil_gj2,
        SUM(neo_fg * vkl_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(neo_fg * vkl_fg * std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(neo_fg * vkl_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS plan_vkl_mo,
        SUM(neo_fg * vkl_fg * std_plan) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS plan_vkl_mo2,
        SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(neo_fg * vkl_fg * stl_fg * bus_fg * std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
        SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS plan_vkl_gj,
        SUM(neo_fg * vkl_fg * stl_fg * bus_fg * std_plan) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS plan_vkl_gj2,
         IF(neo_fg = 0, NULL, neo_fg) * (neo_fg * ums_ist / IF(neo_fg * std_ist = 0, NULL, neo_fg * std_ist) - neo_fg *
             ums_plan / IF(neo_fg * std_plan = 0, NULL, neo_fg * std_plan)) AS fil_mo,
         IF(neo_fg * stl_fg = 0, NULL, neo_fg * stl_fg) * ((SUM(neo_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING)) / IF((SUM(neo_fg * stl_fg * bus_fg * std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                  , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
                UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * stl_fg * bus_fg * std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING)) - (SUM(neo_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING)) / IF((SUM(neo_fg * stl_fg * bus_fg * std_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                  , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
                UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * stl_fg * bus_fg * std_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vkl_fg = 0, NULL, vkl_fg) * ((SUM(neo_fg * vkl_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING),
                wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING)) / IF((SUM(neo_fg * vkl_fg * std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING),
                  wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
                UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * vkl_fg * std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                , wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING)) - (SUM(neo_fg * vkl_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING),
                wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING)) / IF((SUM(neo_fg * vkl_fg * std_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                  , wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
                UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * vkl_fg * std_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                , wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vkl_fg * stl_fg = 0, NULL, vkl_fg * stl_fg) * ((SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING)) / IF((SUM(neo_fg * vkl_fg * stl_fg * bus_fg * std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                  , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
                UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * vkl_fg * stl_fg * bus_fg * std_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING)) - (SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING)) / IF((SUM(neo_fg * vkl_fg * stl_fg * bus_fg * std_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                  , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
                UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * vkl_fg * stl_fg * bus_fg * std_plan) OVER (PARTITION BY CAST(mandant_id AS STRING)
                , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
              UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0) AS vtr
     UNION ALL
     SELECT 220 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.menge_opf_ist AS filist,
      vis0.std_ist AS filist2,
      sub1.menge_opf_kvj AS filkvj,
      vis0.std_kvj AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.menge_opf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(vis0.std_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub1.menge_opf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(vis0.std_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(sub1.menge_opf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(vis0.std_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub1.menge_opf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(vis0.std_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_FAKT_WARE AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
     UNION ALL
     SELECT 240 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      kvj_fil AS filkvj,
      kvj_fil2 AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      kvj_reg AS regkvj,
      kvj_reg2 AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      kvj_land AS landkvj,
      kvj_land2 AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.ums_pos_ist AS ist_fil,
        sub1.kass_std_ist AS ist_fil2,
        sub2.ums_pos_kvj AS kvj_fil,
        sub2.kass_std_kvj AS kvj_fil2,
        SUM(sub1.ums_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub1.kass_std_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(sub2.ums_pos_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub2.kass_std_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg2,
        SUM(sub1.ums_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub1.kass_std_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
        SUM(sub2.ums_pos_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
        SUM(sub2.kass_std_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land2,
         vis0.neo_fg * sub1.ums_pos_ist AS ist_fil_mo,
         vis0.neo_fg * sub1.kass_std_ist AS ist_fil_mo2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.ums_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.kass_std_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.ums_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.kass_std_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.ums_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.kass_std_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.ums_pos_ist / IF(vis0.neo_fg * sub1.kass_std_ist =
             0, NULL, vis0.neo_fg * sub1.kass_std_ist)) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                * sub1.ums_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                  .neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.kass_std_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.kass_std_ist)
            OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.ums_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.kass_std_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * sub1.kass_std_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                 * vis0.bus_fg * sub1.ums_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                   .neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.kass_std_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.kass_std_ist
              ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_KASSE_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
            = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
        LEFT JOIN MONAT_KASSE_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
            = sub2.wrg_id AND vis0.kjmo = sub2.kjmo) AS vtr
     UNION ALL
     SELECT 250 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      kvj_fil AS filkvj,
      kvj_fil2 AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      kvj_reg AS regkvj,
      kvj_reg2 AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      kvj_land AS landkvj,
      kvj_land2 AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.scans_ist AS ist_fil,
        sub1.mins_ist AS ist_fil2,
        sub2.scans_kvj AS kvj_fil,
        sub2.mins_kvj AS kvj_fil2,
        SUM(sub1.scans_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub1.mins_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(sub2.scans_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub2.mins_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg2,
        SUM(sub1.scans_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub1.mins_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
        SUM(sub2.scans_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
        SUM(sub2.mins_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land2,
         vis0.neo_fg * sub1.scans_ist AS ist_fil_mo,
         vis0.neo_fg * sub1.mins_ist AS ist_fil_mo2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.scans_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.mins_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.scans_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.mins_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.scans_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.mins_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.scans_ist / IF(vis0.neo_fg * sub1.mins_ist = 0,
            NULL, vis0.neo_fg * sub1.mins_ist)) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                * sub1.scans_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                  .neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.mins_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.mins_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.scans_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.mins_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * sub1.mins_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                 * vis0.bus_fg * sub1.scans_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                   .neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.mins_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.mins_ist
              ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN WOCHE_ODS_BON_KA_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND
          vis0.kjmo /* ohne WRG */ = sub1.kjmo
        LEFT JOIN WOCHE_ODS_BON_KA_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND
          vis0.kjmo /* ohne WRG */ = sub2.kjmo) AS vtr
     UNION ALL
     SELECT 255 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      kvj_fil AS filkvj,
      kvj_fil2 AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      kvj_reg AS regkvj,
      kvj_reg2 AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      kvj_land AS landkvj,
      kvj_land2 AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.art_pos_ist AS ist_fil,
        sub1.scan_min_ist AS ist_fil2,
        sub2.art_pos_kvj AS kvj_fil,
        sub2.scan_min_kvj AS kvj_fil2,
        SUM(sub1.art_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub1.scan_min_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(sub2.art_pos_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub2.scan_min_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg2,
        SUM(sub1.art_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub1.scan_min_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
        SUM(sub2.art_pos_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
        SUM(sub2.scan_min_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land2,
         vis0.neo_fg * sub1.art_pos_ist AS ist_fil_mo,
         vis0.neo_fg * sub1.scan_min_ist AS ist_fil_mo2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.art_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.scan_min_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.art_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.scan_min_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.art_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.scan_min_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.art_pos_ist / IF(vis0.neo_fg * sub1.scan_min_ist =
             0, NULL, vis0.neo_fg * sub1.scan_min_ist)) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                * sub1.art_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                  .neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.scan_min_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.scan_min_ist)
            OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.art_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.scan_min_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * sub1.scan_min_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                 * vis0.bus_fg * sub1.art_pos_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                   .neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.scan_min_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.scan_min_ist
              ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_KASSE_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
            = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
        LEFT JOIN MONAT_KASSE_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
            = sub2.wrg_id AND vis0.kjmo = sub2.kjmo) AS vtr
     UNION ALL
     SELECT 270 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      kst_ist AS filist,
      CAST(NULL AS BIGNUMERIC) AS filist2,
      kst_kvj AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(kst_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      CAST(NULL AS BIGNUMERIC) AS regist2,
      SUM(kst_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      SUM(kst_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      CAST(NULL AS BIGNUMERIC) AS landist2,
      SUM(kst_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
     UNION ALL
     SELECT 275 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      kvj_fil AS filkvj,
      kvj_fil2 AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      kvj_reg AS regkvj,
      kvj_reg2 AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      kvj_land AS landkvj,
      kvj_land2 AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT mandant_id,
        nb_id,
        wup_id,
        wrg_id,
        vs_id,
        vkl_id,
        gj,
        kjmo,
        neo_fg,
        vkl_fg,
        bus_fg,
        stl_fg,
        kst_ist AS ist_fil,
        ums_ist AS ist_fil2,
        kst_kvj AS kvj_fil,
        ums_kvj AS kvj_fil2,
        kst_plan AS plan_fil,
        ums_plan AS plan_fil2,
        SUM(kst_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(kst_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(ums_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg2,
        SUM(kst_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
        SUM(kst_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
        SUM(ums_kvj) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land2,
         neo_fg * kst_ist AS ist_fil_mo,
         neo_fg * ums_ist AS ist_fil_mo2,
        SUM(neo_fg * stl_fg * bus_fg * kst_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(neo_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(neo_fg * vkl_fg * kst_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(neo_fg * vkl_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(neo_fg * vkl_fg * stl_fg * bus_fg * kst_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(gj AS STRING)
           , CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
         IF(neo_fg = 0, NULL, neo_fg) * (neo_fg * kst_ist / IF(neo_fg * ums_ist = 0, NULL, neo_fg * ums_ist)) AS fil_mo
        ,
         IF(neo_fg * stl_fg = 0, NULL, neo_fg * stl_fg) * ((SUM(neo_fg * stl_fg * bus_fg * kst_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
               , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING)) / IF((SUM(neo_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                 , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
               , wrg_id, CAST(gj AS STRING), CAST(wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vkl_fg = 0, NULL, vkl_fg) * ((SUM(neo_fg * vkl_fg * kst_ist) OVER (PARTITION BY CAST(mandant_id AS STRING),
               wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING)) / IF((SUM(neo_fg * vkl_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING),
                 wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * vkl_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
               , wrg_id, CAST(kjmo AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vkl_fg * stl_fg = 0, NULL, vkl_fg * stl_fg) * ((SUM(neo_fg * vkl_fg * stl_fg * bus_fg * kst_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
               , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING)) / IF((SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
                 , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
               UNBOUNDED FOLLOWING)) = 0, NULL, SUM(neo_fg * vkl_fg * stl_fg * bus_fg * ums_ist) OVER (PARTITION BY CAST(mandant_id AS STRING)
               , wrg_id, CAST(gj AS STRING), CAST(vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0) AS vtr
     UNION ALL
     SELECT 300 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.abs_op_ist AS filist,
      CAST(NULL AS BIGNUMERIC) AS filist2,
      sub1.abs_op_kvj AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      CAST(NULL AS BIGNUMERIC) AS regist2,
      SUM(sub1.abs_op_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      SUM(sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      CAST(NULL AS BIGNUMERIC) AS landist2,
      SUM(sub1.abs_op_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_ABSCHRIFTEN AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
     UNION ALL
     SELECT 310 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      kvj_fil AS filkvj,
      kvj_fil2 AS filkvj2,
      plan_fil AS filplan,
      plan_fil2 AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      kvj_reg AS regkvj,
      kvj_reg2 AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      kvj_land AS landkvj,
      kvj_land2 AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo * 100, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj * 100, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo * 100, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj * 100, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.abs_op_ist AS ist_fil,
        sub1.abs_op_kvj AS kvj_fil,
        sub2.ums_ware_ist AS ist_fil2,
        sub2.ums_ware_kvj AS kvj_fil2,
        sub3.abs_ware_plan AS plan_fil,
        sub3.ums_ware_plan AS plan_fil2,
        SUM(sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(sub1.abs_op_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub2.ums_ware_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg2,
        SUM(sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
        SUM(sub1.abs_op_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
        SUM(sub2.ums_ware_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land2,
         vis0.neo_fg * sub1.abs_op_ist AS ist_fil_mo,
         vis0.neo_fg * sub2.ums_ware_ist AS ist_fil_mo2,
         vis0.neo_fg * sub3.abs_ware_plan AS plan_fil_mo,
         vis0.neo_fg * sub3.ums_ware_plan AS plan_fil_mo2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub3.abs_ware_plan) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS plan_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub3.ums_ware_plan) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS plan_fil_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub3.abs_ware_plan) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS plan_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub3.ums_ware_plan) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS plan_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub3.abs_ware_plan) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS plan_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub3.ums_ware_plan) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS plan_vkl_gj2,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.abs_op_ist / IF(vis0.neo_fg * sub2.ums_ware_ist =
              0, NULL, vis0.neo_fg * sub2.ums_ware_ist) - vis0.neo_fg * sub3.abs_ware_plan / IF(vis0.neo_fg * sub3.ums_ware_plan
                = 0, NULL, vis0.neo_fg * sub3.ums_ware_plan)) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                 * sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
                , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                   .neo_fg * vis0.stl_fg * vis0.bus_fg * sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                  , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
                AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub2.ums_ware_ist)
             OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING)
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - (SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                 * sub3.abs_ware_plan) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
                , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                   .neo_fg * vis0.stl_fg * vis0.bus_fg * sub3.ums_ware_plan) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                  , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
                AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub3.ums_ware_plan)
             OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING)
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
              AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                  , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN
                UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * sub2.ums_ware_ist
               ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING)
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - (SUM(vis0.neo_fg * vis0.vkl_fg * sub3.abs_ware_plan
               ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING)
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub3.ums_ware_plan
                 ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING)
                  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg *
               sub3.ums_ware_plan) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
                , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                  * vis0.bus_fg * sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
                , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                    .neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                  , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
                AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub2.ums_ware_ist
               ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - (SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                  * vis0.bus_fg * sub3.abs_ware_plan) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
                , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                    .neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub3.ums_ware_plan) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                  , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
                AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub3.ums_ware_plan
               ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_ABSCHRIFTEN AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0
           .wrg_id = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
        LEFT JOIN MONAT_FAKT_WARE AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
            = sub2.wrg_id AND vis0.kjmo = sub2.kjmo
        LEFT JOIN MONAT_PLAN_WARE AS sub3 ON vis0.wup_id = sub3.wup_id AND vis0.mandant_id = sub3.mandant_id AND vis0.wrg_id
            = sub3.wrg_id AND vis0.kjmo = sub3.kjmo) AS vtr
     UNION ALL
     SELECT 320 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.abs_ulf_ist AS filist,
      sub2.ums_ulf_ist AS filist2,
      sub1.abs_ulf_kvj AS filkvj,
      sub2.ums_ulf_kvj AS filkvj2,
      sub3.abs_ulf_plan AS filplan,
      sub3.ums_ulf_plan AS filplan2,
      SUM(sub1.abs_ulf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(sub2.ums_ulf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub1.abs_ulf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(sub2.ums_ulf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(sub1.abs_ulf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(sub2.ums_ulf_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub1.abs_ulf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(sub2.ums_ulf_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_ABSCHRIFTEN AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
      LEFT JOIN MONAT_FAKT_WARE AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
          = sub2.wrg_id AND vis0.kjmo = sub2.kjmo
      LEFT JOIN MONAT_PLAN_WARE AS sub3 ON vis0.wup_id = sub3.wup_id AND vis0.mandant_id = sub3.mandant_id AND vis0.wrg_id
          = sub3.wrg_id AND vis0.kjmo = sub3.kjmo
     UNION ALL
     SELECT 340 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.abs_pa_ist AS filist,
      sub2.ums_ware_ist AS filist2,
      sub1.abs_pa_kvj AS filkvj,
      sub2.ums_ware_kvj AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.abs_pa_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub1.abs_pa_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(sub2.ums_ware_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(sub1.abs_pa_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub1.abs_pa_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(sub2.ums_ware_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_ABSCHRIFTEN AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
      LEFT JOIN MONAT_FAKT_WARE AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
          = sub2.wrg_id AND vis0.kjmo = sub2.kjmo
     UNION ALL
     SELECT 345 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.abs_pa_ist AS filist,
      sub1.abs_op_ist AS filist2,
      sub1.abs_pa_kvj AS filkvj,
      sub1.abs_op_kvj AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.abs_pa_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub1.abs_pa_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(sub1.abs_op_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(sub1.abs_pa_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub1.abs_pa_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(sub1.abs_op_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_ABSCHRIFTEN AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
     UNION ALL
     SELECT 360 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.abs_ta_ist AS filist,
      sub2.ums_ware_ist AS filist2,
      sub1.abs_ta_kvj AS filkvj,
      sub2.ums_ware_kvj AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.abs_ta_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub1.abs_ta_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(sub2.ums_ware_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(sub1.abs_ta_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(sub2.ums_ware_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub1.abs_ta_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(sub2.ums_ware_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_ABSCHRIFTEN AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
      LEFT JOIN MONAT_FAKT_WARE AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
          = sub2.wrg_id AND vis0.kjmo = sub2.kjmo
     UNION ALL
     SELECT 365 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.abs_ta_ist AS filist,
      sub1.abs_op_ist AS filist2,
      sub1.abs_ta_kvj AS filkvj,
      sub1.abs_op_kvj AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.abs_ta_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub1.abs_ta_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(sub1.abs_op_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(sub1.abs_ta_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(sub1.abs_op_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub1.abs_ta_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(sub1.abs_op_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_ABSCHRIFTEN AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
     UNION ALL
     SELECT 410 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      ist_reg AS regist,
      ist_reg2 AS regist2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      ist_land AS landist,
      ist_land2 AS landist2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.inv_wert_ist AS ist_fil,
        sub1.inv_ums_ist AS ist_fil2,
        SUM(sub1.inv_wert_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub1.inv_ums_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(sub1.inv_wert_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub1.inv_ums_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
         vis0.neo_fg * sub1.inv_wert_ist AS ist_fil_mo,
         vis0.neo_fg * sub1.inv_ums_ist AS ist_fil_mo2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.inv_wert_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.inv_ums_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.inv_wert_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.inv_ums_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.inv_wert_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.inv_ums_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.inv_wert_ist / IF(vis0.neo_fg * sub1.inv_ums_ist =
             0, NULL, vis0.neo_fg * sub1.inv_ums_ist)) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                * sub1.inv_wert_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                  .neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.inv_ums_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.inv_ums_ist) OVER
             (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.inv_wert_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.inv_ums_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * sub1.inv_ums_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                 * vis0.bus_fg * sub1.inv_wert_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                   .neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.inv_ums_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.inv_ums_ist
              ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_INVENTUR AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
            = sub1.wrg_id AND vis0.kjmo = sub1.kjmo) AS vtr
     UNION ALL
     SELECT 420 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.big_best_entw AS filist,
      CAST(NULL AS BIGNUMERIC) AS filist2,
      CAST(NULL AS BIGNUMERIC) AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.big_best_entw) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      CAST(NULL AS BIGNUMERIC) AS regist2,
      CAST(NULL AS BIGNUMERIC) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      SUM(sub1.big_best_entw) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      CAST(NULL AS BIGNUMERIC) AS landist2,
      CAST(NULL AS BIGNUMERIC) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_BIG AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id =
         sub1.wrg_id AND vis0.kjmo = sub1.kjmo
     UNION ALL
     SELECT 425 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      CAST(NULL AS BIGNUMERIC) AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      CAST(NULL AS BIGNUMERIC) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      CAST(NULL AS BIGNUMERIC) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      IF(big_fg * neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(big_fg * neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(big_fg * vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(big_fg * vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(big_fg * neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(big_fg * neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(big_fg * vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(big_fg * vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.big_fg,
        sub1.big_best_entw AS ist_fil,
        sub1.big_ums_netto AS ist_fil2,
        SUM(sub1.big_best_entw) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub1.big_ums_netto) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(sub1.big_best_entw) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub1.big_ums_netto) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
         vis0.neo_fg * sub1.big_best_entw AS ist_fil_mo,
         vis0.neo_fg * sub1.big_ums_netto AS ist_fil_mo2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.big_best_entw) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.big_ums_netto) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.big_best_entw) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.big_ums_netto) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.big_best_entw) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.big_ums_netto) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.big_best_entw / IF(vis0.neo_fg * sub1.big_ums_netto
               = 0, NULL, vis0.neo_fg * sub1.big_ums_netto)) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                * sub1.big_best_entw) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                  .neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.big_ums_netto) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.big_ums_netto)
            OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.big_best_entw) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.big_ums_netto) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * sub1.big_ums_netto) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                 * vis0.bus_fg * sub1.big_best_entw) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                   .neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.big_ums_netto) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.big_ums_netto
              ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_BIG AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id =
           sub1.wrg_id AND vis0.kjmo = sub1.kjmo) AS vtr
     UNION ALL
     SELECT 500 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      kvj_fil AS filkvj,
      kvj_fil2 AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      kvj_reg AS regkvj,
      kvj_reg2 AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      kvj_land AS landkvj,
      kvj_land2 AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.sum_review_ist AS ist_fil,
        sub1.anz_review_ist AS ist_fil2,
        sub2.sum_review_kvj AS kvj_fil,
        sub2.anz_review_kvj AS kvj_fil2,
        SUM(sub1.sum_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub1.anz_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(sub2.sum_review_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub2.anz_review_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg2,
        SUM(sub1.sum_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub1.anz_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
        SUM(sub2.sum_review_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
        SUM(sub2.anz_review_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land2,
         vis0.neo_fg * sub1.sum_review_ist AS ist_fil_mo,
         vis0.neo_fg * sub1.anz_review_ist AS ist_fil_mo2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.sum_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.anz_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.sum_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.anz_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.sum_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.anz_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.sum_review_ist / IF(vis0.neo_fg * sub1.anz_review_ist
               = 0, NULL, vis0.neo_fg * sub1.anz_review_ist)) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                * sub1.sum_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                  .neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.anz_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.anz_review_ist)
            OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.sum_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.anz_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * sub1.anz_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                 * vis0.bus_fg * sub1.sum_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                   .neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.anz_review_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.anz_review_ist
              ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_GOOGLE_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.kjmo
          /* ohne WRG */ = sub1.kjmo
        LEFT JOIN MONAT_GOOGLE_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.kjmo
          /* ohne WRG */ = sub2.kjmo) AS vtr
     UNION ALL
     SELECT 505 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      kvj_fil AS filkvj,
      kvj_fil2 AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      kvj_reg AS regkvj,
      kvj_reg2 AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      kvj_land AS landkvj,
      kvj_land2 AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.kcard_ist AS ist_fil,
        sub1.bon_ist AS ist_fil2,
        sub2.kcard_kvj AS kvj_fil,
        sub2.bon_kvj AS kvj_fil2,
        SUM(sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(sub2.kcard_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub2.bon_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg2,
        SUM(sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
        SUM(sub2.kcard_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
        SUM(sub2.bon_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land2,
         vis0.neo_fg * sub1.kcard_ist AS ist_fil_mo,
         vis0.neo_fg * sub1.bon_ist AS ist_fil_mo2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING),
           vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.kcard_ist / IF(vis0.neo_fg * sub1.bon_ist = 0,
            NULL, vis0.neo_fg * sub1.bon_ist)) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                  .neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                 * vis0.bus_fg * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                   .neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist
              ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_WCAL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.kjmo
          /* ohne WRG */ = sub1.kjmo
        LEFT JOIN MONAT_WCAL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.kjmo
          /* ohne WRG */ = sub2.kjmo) AS vtr
     UNION ALL
     SELECT 506 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      kvj_fil AS filkvj,
      kvj_fil2 AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      kvj_reg AS regkvj,
      kvj_reg2 AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      kvj_land AS landkvj,
      kvj_land2 AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo * 100, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj * 100, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo * 100, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj * 100, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.kcard_ist AS ist_fil,
        sub1.bon_ist AS ist_fil2,
        sub2.kcard_kvj AS kvj_fil,
        sub2.bon_kvj AS kvj_fil2,
        SUM(sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(sub2.kcard_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub2.bon_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg2,
        SUM(sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
        SUM(sub2.kcard_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
        SUM(sub2.bon_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land2,
         vis0.neo_fg * sub1.kcard_ist AS ist_fil_mo,
         vis0.neo_fg * sub1.bon_ist AS ist_fil_mo2,
         vis0.neo_fg * sub2.kcard_kvj AS kvj_fil_mo,
         vis0.neo_fg * sub2.bon_kvj AS kvj_fil_mo2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING),
           vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub2.kcard_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS kvj_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub2.bon_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING),
           vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS kvj_fil_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub2.kcard_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS kvj_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub2.bon_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub2.kcard_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS kvj_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub2.bon_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS kvj_vkl_gj2,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.kcard_ist / IF(vis0.neo_fg * sub1.bon_ist = 0,
             NULL, vis0.neo_fg * sub1.bon_ist) - vis0.neo_fg * sub2.kcard_kvj / IF(vis0.neo_fg * sub2.bon_kvj = 0, NULL
             , vis0.neo_fg * sub2.bon_kvj)) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                 * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
                , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                   .neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                  , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
                AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
              AND UNBOUNDED FOLLOWING)) - (SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub2.kcard_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
              AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub2.bon_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                  , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
                AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub2.bon_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
              AND UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
              AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                  , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN
                UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * sub1.bon_ist)
             OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING)
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - (SUM(vis0.neo_fg * vis0.vkl_fg * sub2.kcard_kvj
               ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING)
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub2.bon_kvj
                 ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING)
                  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg *
               sub2.bon_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
                , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                  * vis0.bus_fg * sub1.kcard_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
                , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                    .neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                  , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
                AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.bon_ist
               ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - (SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                  * vis0.bus_fg * sub2.kcard_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
                , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                    .neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub2.bon_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                  , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
                AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub2.bon_kvj
               ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_WCAL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.kjmo
          /* ohne WRG */ = sub1.kjmo
        LEFT JOIN MONAT_WCAL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.kjmo
          /* ohne WRG */ = sub2.kjmo) AS vtr
     UNION ALL
     SELECT 510 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      CAST(NULL AS BIGNUMERIC),
      kvj_fil AS filkvj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      ist_reg AS regist,
      CAST(NULL AS BIGNUMERIC),
      kvj_reg AS regkvj,
      CAST(NULL AS BIGNUMERIC),
      ist_land AS landist,
      CAST(NULL AS BIGNUMERIC),
      kvj_land AS landkvj,
      CAST(NULL AS BIGNUMERIC),
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.w_kasse_ist AS ist_fil,
        sub2.w_kasse_kvj AS kvj_fil,
        SUM(sub1.w_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub2.w_kasse_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub1.w_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub2.w_kasse_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
         vis0.neo_fg * sub1.w_kasse_ist AS ist_fil_mo,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.w_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.w_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.w_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.w_kasse_ist) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * (SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
              * sub1.w_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
             , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * (SUM(vis0.neo_fg * vis0.vkl_fg * sub1.w_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
             , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
           UNBOUNDED FOLLOWING)) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * (SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
               * vis0.bus_fg * sub1.w_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
             , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_REKL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
            = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
        LEFT JOIN MONAT_REKL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
            = sub2.wrg_id AND vis0.kjmo = sub2.kjmo) AS vtr
     UNION ALL
     SELECT 515 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.w_kasse_ist AS filist,
      vis0.knd_10t_ist AS filist2,
      sub2.w_kasse_kvj AS filkvj,
      vis0.knd_10t_kvj AS filkvj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      SUM(sub1.w_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(vis0.knd_10t_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub2.w_kasse_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(vis0.knd_10t_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(sub1.w_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(vis0.knd_10t_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub2.w_kasse_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(vis0.knd_10t_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_REKL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
      LEFT JOIN MONAT_REKL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
          = sub2.wrg_id AND vis0.kjmo = sub2.kjmo
     UNION ALL
     SELECT 520 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      CAST(NULL AS BIGNUMERIC),
      kvj_fil AS filkvj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      ist_reg AS regist,
      CAST(NULL AS BIGNUMERIC),
      kvj_reg AS regkvj,
      CAST(NULL AS BIGNUMERIC),
      ist_land AS landist,
      CAST(NULL AS BIGNUMERIC),
      kvj_land AS landkvj,
      CAST(NULL AS BIGNUMERIC),
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.w_theke_ist AS ist_fil,
        sub2.w_theke_kvj AS kvj_fil,
        SUM(sub1.w_theke_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub2.w_theke_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub1.w_theke_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub2.w_theke_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
         vis0.neo_fg * sub1.w_theke_ist AS ist_fil_mo,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.w_theke_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.w_theke_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.w_theke_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.w_theke_ist) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * (SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
              * sub1.w_theke_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
             , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * (SUM(vis0.neo_fg * vis0.vkl_fg * sub1.w_theke_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
             , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
           UNBOUNDED FOLLOWING)) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * (SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
               * vis0.bus_fg * sub1.w_theke_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
             , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_REKL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
            = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
        LEFT JOIN MONAT_REKL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
            = sub2.wrg_id AND vis0.kjmo = sub2.kjmo) AS vtr
     UNION ALL
     SELECT 525 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.w_theke_ist AS filist,
      vis0.knd_10t_ist AS filist2,
      sub2.w_theke_kvj AS filkvj,
      vis0.knd_10t_kvj AS filkvj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      SUM(sub1.w_theke_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(vis0.knd_10t_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub2.w_theke_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(vis0.knd_10t_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(sub1.w_theke_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(vis0.knd_10t_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub2.w_theke_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(vis0.knd_10t_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_REKL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
      LEFT JOIN MONAT_REKL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
          = sub2.wrg_id AND vis0.kjmo = sub2.kjmo
     UNION ALL
     SELECT 530 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      CAST(NULL AS BIGNUMERIC),
      kvj_fil AS filkvj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      ist_reg AS regist,
      CAST(NULL AS BIGNUMERIC),
      kvj_reg AS regkvj,
      CAST(NULL AS BIGNUMERIC),
      ist_land AS landist,
      CAST(NULL AS BIGNUMERIC),
      kvj_land AS landkvj,
      CAST(NULL AS BIGNUMERIC),
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.anz_mhd_ist AS ist_fil,
        sub2.anz_mhd_kvj AS kvj_fil,
        SUM(sub1.anz_mhd_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub2.anz_mhd_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub1.anz_mhd_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub2.anz_mhd_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
         vis0.neo_fg * sub1.anz_mhd_ist AS ist_fil_mo,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.anz_mhd_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.anz_mhd_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.anz_mhd_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.anz_mhd_ist) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * (SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
              * sub1.anz_mhd_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
             , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * (SUM(vis0.neo_fg * vis0.vkl_fg * sub1.anz_mhd_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
             , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
           UNBOUNDED FOLLOWING)) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * (SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
               * vis0.bus_fg * sub1.anz_mhd_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
             , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_REKL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
            = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
        LEFT JOIN MONAT_REKL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
            = sub2.wrg_id AND vis0.kjmo = sub2.kjmo) AS vtr
     UNION ALL
     SELECT 535 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.anz_mhd_ist AS filist,
      vis0.knd_10t_ist AS filist2,
      sub2.anz_mhd_kvj AS filkvj,
      vis0.knd_10t_kvj AS filkvj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      SUM(sub1.anz_mhd_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(vis0.knd_10t_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub2.anz_mhd_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(vis0.knd_10t_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(sub1.anz_mhd_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(vis0.knd_10t_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub2.anz_mhd_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(vis0.knd_10t_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_REKL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
      LEFT JOIN MONAT_REKL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
          = sub2.wrg_id AND vis0.kjmo = sub2.kjmo
     UNION ALL
     SELECT 540 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      CAST(NULL AS BIGNUMERIC),
      kvj_fil AS filkvj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      ist_reg AS regist,
      CAST(NULL AS BIGNUMERIC),
      kvj_reg AS regkvj,
      CAST(NULL AS BIGNUMERIC),
      ist_land AS landist,
      CAST(NULL AS BIGNUMERIC),
      kvj_land AS landkvj,
      CAST(NULL AS BIGNUMERIC),
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.f_preis_ist AS ist_fil,
        sub2.f_preis_kvj AS kvj_fil,
        SUM(sub1.f_preis_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub2.f_preis_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub1.f_preis_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub2.f_preis_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
         vis0.neo_fg * sub1.f_preis_ist AS ist_fil_mo,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.f_preis_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.f_preis_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.f_preis_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.f_preis_ist) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * (SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
              * sub1.f_preis_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
             , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * (SUM(vis0.neo_fg * vis0.vkl_fg * sub1.f_preis_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
             , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
           UNBOUNDED FOLLOWING)) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * (SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
               * vis0.bus_fg * sub1.f_preis_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
             , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_REKL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
            = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
        LEFT JOIN MONAT_REKL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
            = sub2.wrg_id AND vis0.kjmo = sub2.kjmo) AS vtr
     UNION ALL
     SELECT 545 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.f_preis_ist AS filist,
      vis0.knd_10t_ist AS filist2,
      sub2.f_preis_kvj AS filkvj,
      vis0.knd_10t_kvj AS filkvj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      SUM(sub1.f_preis_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(vis0.knd_10t_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub2.f_preis_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(vis0.knd_10t_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(sub1.f_preis_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(vis0.knd_10t_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub2.f_preis_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(vis0.knd_10t_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_REKL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
      LEFT JOIN MONAT_REKL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
          = sub2.wrg_id AND vis0.kjmo = sub2.kjmo
     UNION ALL
     SELECT 550 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      CAST(NULL AS BIGNUMERIC),
      kvj_fil AS filkvj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      ist_reg AS regist,
      CAST(NULL AS BIGNUMERIC),
      kvj_reg AS regkvj,
      CAST(NULL AS BIGNUMERIC),
      ist_land AS landist,
      CAST(NULL AS BIGNUMERIC),
      kvj_land AS landkvj,
      CAST(NULL AS BIGNUMERIC),
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
        sub1.f_kasse_ist AS ist_fil,
        sub2.f_kasse_kvj AS kvj_fil,
        SUM(sub1.f_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub2.f_kasse_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_reg,
        SUM(sub1.f_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub2.f_kasse_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kvj_land,
         vis0.neo_fg * sub1.f_kasse_ist AS ist_fil_mo,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.f_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.f_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.f_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * sub1.f_kasse_ist) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * (SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
              * sub1.f_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
             , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * (SUM(vis0.neo_fg * vis0.vkl_fg * sub1.f_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
             , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
           UNBOUNDED FOLLOWING)) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * (SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
               * vis0.bus_fg * sub1.f_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
             , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_REKL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
            = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
        LEFT JOIN MONAT_REKL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
            = sub2.wrg_id AND vis0.kjmo = sub2.kjmo) AS vtr
     UNION ALL
     SELECT 555 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.f_kasse_ist AS filist,
      sub3.art_100t_ist AS filist2,
      sub2.f_kasse_kvj AS filkvj,
      sub4.art_100t_kvj AS filkvj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      SUM(sub1.f_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(sub3.art_100t_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      SUM(sub2.f_kasse_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj,
      SUM(sub4.art_100t_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regkvj2,
      SUM(sub1.f_kasse_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(sub3.art_100t_ist) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      SUM(sub2.f_kasse_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj,
      SUM(sub4.art_100t_kvj) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_REKL_IST AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.wrg_id
          = sub1.wrg_id AND vis0.kjmo = sub1.kjmo
      LEFT JOIN MONAT_REKL_KVJ AS sub2 ON vis0.wup_id = sub2.wup_id AND vis0.mandant_id = sub2.mandant_id AND vis0.wrg_id
          = sub2.wrg_id AND vis0.kjmo = sub2.kjmo
      LEFT JOIN MONAT_KASSE_IST AS sub3 ON vis0.wup_id = sub3.wup_id AND vis0.mandant_id = sub3.mandant_id AND vis0.wrg_id
          = sub3.wrg_id AND vis0.kjmo = sub3.kjmo
      LEFT JOIN MONAT_KASSE_KVJ AS sub4 ON vis0.wup_id = sub4.wup_id AND vis0.mandant_id = sub4.mandant_id AND vis0.wrg_id
          = sub4.wrg_id AND vis0.kjmo = sub4.kjmo
     UNION ALL
     SELECT 710 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      CAST(NULL AS BIGNUMERIC) AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      CAST(NULL AS BIGNUMERIC) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      CAST(NULL AS BIGNUMERIC) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
         sub1.best_vor - sub1.best_kor AS ist_fil,
         sub1.best_vor + sub1.best_man AS ist_fil2,
        SUM(sub1.best_vor - sub1.best_kor) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub1.best_vor + sub1.best_man) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(sub1.best_vor - sub1.best_kor) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub1.best_vor + sub1.best_man) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
         vis0.neo_fg * (sub1.best_vor - sub1.best_kor) AS ist_fil_mo,
         vis0.neo_fg * (sub1.best_vor + sub1.best_man) AS ist_fil_mo2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * (sub1.best_vor - sub1.best_kor)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * (sub1.best_vor + sub1.best_man)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * (sub1.best_vor - sub1.best_kor)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * (sub1.best_vor + sub1.best_man)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * (sub1.best_vor - sub1.best_kor)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * (sub1.best_vor + sub1.best_man)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * (sub1.best_vor - sub1.best_kor) / IF(vis0.neo_fg * (sub1
                .best_vor + sub1.best_man) = 0, NULL, vis0.neo_fg * (sub1.best_vor + sub1.best_man))) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                * (sub1.best_vor - sub1.best_kor)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                  .neo_fg * vis0.stl_fg * vis0.bus_fg * (sub1.best_vor + sub1.best_man)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * (sub1.best_vor + sub1
                .best_man)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * (sub1.best_vor - sub1.best_kor))
            OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * (sub1.best_vor
                   + sub1.best_man)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
                 , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL,
            SUM(vis0.neo_fg * vis0.vkl_fg * (sub1.best_vor + sub1.best_man)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                 * vis0.bus_fg * (sub1.best_vor - sub1.best_kor)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING),
               vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * (sub1.best_vor +
                  sub1.best_man)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
                 , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL,
            SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * (sub1.best_vor + sub1.best_man)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_BESTVOR AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.kjmo
          /* ohne WRG */ = sub1.kjmo) AS vtr
     UNION ALL
     SELECT 730 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.auftrag AS filist,
      CAST(NULL AS BIGNUMERIC) AS filist2,
      CAST(NULL AS BIGNUMERIC) AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.auftrag) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      CAST(NULL AS BIGNUMERIC) AS regist2,
      CAST(NULL AS BIGNUMERIC) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      SUM(sub1.auftrag) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      CAST(NULL AS BIGNUMERIC) AS landist2,
      CAST(NULL AS BIGNUMERIC) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_ZAEHL_AUFTRAG AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0
        .kjmo /* ohne WRG */ = sub1.kjmo
     UNION ALL
     SELECT 732 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.gezaehlt AS filist,
      CAST(NULL AS BIGNUMERIC) AS filist2,
      CAST(NULL AS BIGNUMERIC) AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.gezaehlt) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      CAST(NULL AS BIGNUMERIC) AS regist2,
      CAST(NULL AS BIGNUMERIC) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      SUM(sub1.gezaehlt) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      CAST(NULL AS BIGNUMERIC) AS landist2,
      CAST(NULL AS BIGNUMERIC) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_ZAEHL_AUFTRAG AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0
        .kjmo /* ohne WRG */ = sub1.kjmo
     UNION ALL
     SELECT 735 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.gezaehlt AS filist,
      sub1.auftrag AS filist2,
      CAST(NULL AS BIGNUMERIC) AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.gezaehlt) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(sub1.auftrag) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      CAST(NULL AS BIGNUMERIC) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      SUM(sub1.gezaehlt) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(sub1.auftrag) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      CAST(NULL AS BIGNUMERIC) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_ZAEHL_AUFTRAG AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0
        .kjmo /* ohne WRG */ = sub1.kjmo
     UNION ALL
     SELECT 750 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.null_best AS filist,
      sub1.auto_dispo AS filist2,
      CAST(NULL AS BIGNUMERIC) AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.null_best) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      CAST(NULL AS BIGNUMERIC) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      SUM(sub1.null_best) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      CAST(NULL AS BIGNUMERIC) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_FWWS AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.kjmo
        /* ohne WRG */ = sub1.kjmo
     UNION ALL
     SELECT 752 AS vtr_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.vs_id,
      vis0.vkl_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.kjmo,
      sub1.minus_best AS filist,
      sub1.auto_dispo AS filist2,
      CAST(NULL AS BIGNUMERIC) AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      SUM(sub1.minus_best) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist,
      SUM(sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vs_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS regist2,
      CAST(NULL AS BIGNUMERIC) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      SUM(sub1.minus_best) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist,
      SUM(sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS landist2,
      CAST(NULL AS BIGNUMERIC) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGINT),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC)
     FROM MONAT_FAKT_WUP AS vis0
      LEFT JOIN MONAT_FWWS AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.kjmo
        /* ohne WRG */ = sub1.kjmo
     UNION ALL
     SELECT 755 AS vtr_id,
      mandant_id,
      nb_id,
      vs_id,
      vkl_id,
      wup_id,
      wrg_id,
      gj,
      kjmo,
      ist_fil AS filist,
      ist_fil2 AS filist2,
      CAST(NULL AS BIGNUMERIC) AS filkvj,
      CAST(NULL AS BIGNUMERIC) AS filkvj2,
      CAST(NULL AS BIGNUMERIC) AS filplan,
      CAST(NULL AS BIGNUMERIC) AS filplan2,
      ist_reg AS regist,
      ist_reg2 AS regist2,
      CAST(NULL AS BIGNUMERIC) AS regkvj,
      CAST(NULL AS BIGNUMERIC) AS regkvj2,
      ist_land AS landist,
      ist_land2 AS landist2,
      CAST(NULL AS BIGNUMERIC) AS landkvj,
      CAST(NULL AS BIGNUMERIC) AS landkvj2,
      IF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY fil_mo IS NULL, fil_mo), NULL) AS filmo_rang,
      IF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY fil_gj IS NULL, fil_gj), NULL) AS filgj_rang,
      IF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(kjmo AS STRING) ORDER BY vkl_mo IS NULL, vkl_mo), NULL) AS vklmo_rang,
      IF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(vs_id AS STRING)
          , CAST(gj AS STRING) ORDER BY vkl_gj IS NULL, vkl_gj), NULL) AS vklgj_rang,
      IF(neo_fg * bus_fg = 1, fil_mo, NULL) AS filmo_wert,
      IF(neo_fg * stl_fg = 1, fil_gj, NULL) AS filgj_wert,
      IF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS vklmo_wert,
      IF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS vklgj_wert
     FROM (SELECT vis0.mandant_id,
        vis0.nb_id,
        vis0.wup_id,
        vis0.wrg_id,
        vis0.vs_id,
        vis0.vkl_id,
        vis0.gj,
        vis0.kjmo,
        vis0.neo_fg,
        vis0.vkl_fg,
        vis0.bus_fg,
        vis0.stl_fg,
         sub1.null_best + sub1.minus_best AS ist_fil,
        sub1.auto_dispo AS ist_fil2,
        SUM(sub1.null_best + sub1.minus_best) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg,
        SUM(sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           , CAST(vis0.vs_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_reg2,
        SUM(sub1.null_best + sub1.minus_best) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land,
        SUM(sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ist_land2,
         vis0.neo_fg * (sub1.null_best + sub1.minus_best) AS ist_fil_mo,
         vis0.neo_fg * sub1.auto_dispo AS ist_fil_mo2,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * (sub1.null_best + sub1.minus_best)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj,
        SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_fil_gj2,
        SUM(vis0.neo_fg * vis0.vkl_fg * (sub1.null_best + sub1.minus_best)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo,
        SUM(vis0.neo_fg * vis0.vkl_fg * sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
           , CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_mo2,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * (sub1.null_best + sub1.minus_best)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj,
        SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
           , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING) AS ist_vkl_gj2,
         IF(vis0.neo_fg = 0, NULL, vis0.neo_fg) * (vis0.neo_fg * (sub1.null_best + sub1.minus_best) / IF(vis0.neo_fg *
              sub1.auto_dispo = 0, NULL, vis0.neo_fg * sub1.auto_dispo)) AS fil_mo,
         IF(vis0.neo_fg * vis0.stl_fg = 0, NULL, vis0.neo_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg
                * (sub1.null_best + sub1.minus_best)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING)
               , CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0
                  .neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
                 , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
               AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * sub1.auto_dispo) OVER
             (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.wup_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS fil_gj,
         IF(vis0.vkl_fg = 0, NULL, vis0.vkl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * (sub1.null_best + sub1.minus_best))
            OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * sub1.auto_dispo
                ) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING), CAST(vis0.vkl_id AS STRING)
                 RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg *
              sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.kjmo AS STRING)
               , CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS vkl_mo,
         IF(vis0.vkl_fg * vis0.stl_fg = 0, NULL, vis0.vkl_fg * vis0.stl_fg) * ((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg
                 * vis0.bus_fg * (sub1.null_best + sub1.minus_best)) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING)
               , vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING)) / IF((SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * sub1.auto_dispo)
              OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id, CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING)
                 RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(vis0.neo_fg * vis0.vkl_fg *
                vis0.stl_fg * vis0.bus_fg * sub1.auto_dispo) OVER (PARTITION BY CAST(vis0.mandant_id AS STRING), vis0.wrg_id
               , CAST(vis0.gj AS STRING), CAST(vis0.vkl_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
             UNBOUNDED FOLLOWING))) AS vkl_gj
       FROM MONAT_FAKT_WUP AS vis0
        LEFT JOIN MONAT_FWWS AS sub1 ON vis0.wup_id = sub1.wup_id AND vis0.mandant_id = sub1.mandant_id AND vis0.kjmo
          /* ohne WRG */ = sub1.kjmo) AS vtr));
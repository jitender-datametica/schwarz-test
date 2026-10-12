CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_STUNDEN_MONAT_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	KJMO,
	ANZ_OFFEN,
	UMS_NETTO,
	UMS_NETTO_PLAN,
	UMS_NETTO_PLAN_MAN,
	UMS_NETTO_PLAN_MAN_MELDESCHLUSS,
	UMS_NETTO_PLAN_HL_KER,
	UMS_NETTO_PLAN_MLD_KER,
	PERS_STD,
	PERS_STD_PLAN,
	PLAN_UEBERNAHME_FG,
	PLAN_ANPASSUNG_FG,
	PLAN_KEIN_FG,
	NL_IST,
	NL_PLAN,
	NL_PLAN_HL_KER,
	NL_PLAN_MLD_KER,
	NL_ABW,
	NL_ABW_HL_KER,
	NL_ABW_MLD_KER,
	UMS_ABW,
	FILIALEBENE2_ID
) AS

/*
	FAKT : Umsatz Plan (Meldeschluss) pro Filiale/Monat_2 auf Basis wup_stunden_tag_2
	2019.0415 ssch0611 : Initial (moved from vis_monat_fakt, wup_planumsatz_eingabe
	2019.0503 awol2209:  Anpassung plan_uebernahme_fg und plan_anpassung_fg. ALT ...wst.ums_netto_plan_mld_ker = wst.ums_netto_plan_hl_ker ...
	2022-10-06 ssch0611 : Finetuning  
	2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]
	2024-09-09 ssch0611 : keine Anpassung Umzugsfiliale. 
	2025-07-11 ssch0611 : Review (geänderte wup_stunden_tag_2) [AP0273081]
*/

SELECT vis.mandant_id
	, vis.nb_id
	, vis.wup_id
	, vis.wrg_id
	, vis.kjmo
	, vis.mo_offen         AS anz_offen
	, vis.mo_ums * ist_fg  AS ums_netto          -- Umsatz netto IST (komplette Monate)
	, vis.mo_ums_plan      AS ums_netto_plan     -- Umsatz netto Plan (KER Jahresplanung)
	, wst.ums_plan_man     AS ums_netto_plan_man -- Umsatz netto Plan HL_2 (Eingabe)
	, wst.ums_plan_man_mld AS ums_netto_plan_man_meldeschluss -- Umsatz netto Plan HL_2 (Meldeschluss Plus2)
	, wst.ums_plan_hl_ker  AS ums_netto_plan_hl_ker  -- Umsatz netto Plan HL_2 (Eingabe HL_2 oder KER)
	, wst.ums_plan_mld_ker AS ums_netto_plan_mld_ker -- Umsatz netto Plan HL_2 (Meldeschluss oder KER)
	, vis.mo_std * ist_fg  AS pers_std      -- Stunden_2 IST (komplette Monate)
	, vis.mo_std_plan      AS pers_std_plan -- Stunden_2 Plan (KER Jahresplanung)
	/* Berechnungen */
	, IFF(ums_netto_plan_mld_ker = ums_netto_plan, 1, 0) ::BYTEINT AS plan_uebernahme_fg -- Jahresplanung wurde übernommen
	, IFF(ums_netto_plan_mld_ker = ums_netto_plan, 0, 1) ::BYTEINT AS plan_anpassung_fg  -- Jahresplanung wurde angepasst
	, IFF(ums_netto_plan_mld_ker <> 0, 0, 1) ::BYTEINT             AS plan_kein_fg       -- kein Planwert vorhanden
	, ums_netto              / NULLIFZERO(pers_std)      AS nl_ist          -- Nettoleistung IST (komplette Monate)
	, ums_netto_plan         / NULLIFZERO(pers_std_plan) AS nl_plan         -- Nettoleistung Plan (KER Jahresplanung)
	, ums_netto_plan_hl_ker  / NULLIFZERO(pers_std_plan) AS nl_plan_hl_ker  -- Nettoleistung Plan (Umsatz Eingabe HL_2 oder KER)
	, ums_netto_plan_mld_ker / NULLIFZERO(pers_std_plan) AS nl_plan_mld_ker -- Nettoleistung Plan (Umsatz Meldeschluss2 oder KER)
	, ((NULLIFZERO(nl_ist) - NULLIFZERO(nl_plan))           / NULLIFZERO(nl_ist)) * 100.00 AS nl_abw  
	, ((NULLIFZERO(nl_ist) - NULLIFZERO(nl_plan_hl_ker))    / NULLIFZERO(nl_ist)) * 100.00 AS nl_abw_hl_ker  
	, ((NULLIFZERO(nl_ist) - NULLIFZERO(nl_plan_mld_ker))   / NULLIFZERO(nl_ist)) * 100.00 AS nl_abw_mld_ker  
	, ((ums_netto - ums_netto_plan_mld_ker) / NULLIFZERO(ums_netto_plan_mld_ker)) * 100.00 AS ums_abw -- Umsatz Plan (Meldeschluss oder KER) Abw.
	/* Filialebene - Monat_2 */
, CASE
	WHEN UMS_ABW <  -20                       THEN 1
	WHEN UMS_ABW >= -20   AND UMS_ABW < -10   THEN 2
	WHEN UMS_ABW >= -10   AND UMS_ABW <  -5   THEN 3
	WHEN UMS_ABW >=  -5   AND UMS_ABW <  -2.5 THEN 4
	WHEN UMS_ABW >=  -2.5 AND UMS_ABW <  -1   THEN 5
	WHEN UMS_ABW >=  -1   AND UMS_ABW <=  1   THEN 6
	WHEN UMS_ABW >    1   AND UMS_ABW <=  2.5 THEN 7
	WHEN UMS_ABW >    2.5 AND UMS_ABW <=  5   THEN 8
	WHEN UMS_ABW >    5   AND UMS_ABW <= 10   THEN 9
	WHEN UMS_ABW >   10   AND UMS_ABW <= 20   THEN 10
	WHEN UMS_ABW >   20                       THEN 11
	ELSE -1 END AS filialebene2_id

FROM (
	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wup_id
		, vis.kjmo
		, vis.wrg_id
		, SUM(vis.anz_offen)      AS mo_offen
		, SUM(vis.ums_netto)      AS mo_ums 
		, SUM(vis.ums_netto_plan) AS mo_ums_plan 
		, SUM(vis.pers_std)       AS mo_std 
		, SUM(vis.pers_std_plan)  AS mo_std_plan 
	FROM dbp_msi_view_vis.mv_vis_monat_fakt_wup_2 vis

	INNER JOIN dbp_view.v_tag_2 zeit_2
	ON zeit.kjmo = vis.kjmo

	GROUP BY ALL
) vis
 
LEFT JOIN ( 
	SELECT wst.mandant_id
		, wst.nb_id
		, wst.wup_id
		, zeit.kjmo
		, IFF(zeit.akt_mo < 0, 1, NULL) AS ist_fg -- Komplette Monate = 1
		, wst.wrg_id
		, SUM(wst.ums_netto_plan_man_meldeschluss_plus2) AS ums_plan_man_mld
		, SUM(wst.ums_netto_plan_man)                    AS ums_plan_man
		, SUM(wst.umsatz_netto_plan_plus2)               AS ums_plan_mld_ker
		, SUM(wst.umsatz_netto_plan)                     AS ums_plan_hl_ker
	FROM dbp_msi_view_vis.mv_wup_stunden_tag_2  wst

	INNER JOIN dbp_view.v_tag_2 zeit_2
	ON zeit.dat = wst.dat

	GROUP BY ALL
) wst
ON wst.wup_id = vis.wup_id AND wst.mandant_id = vis.mandant_id AND wst.wrg_id = vis.wrg_id
AND wst.kjmo = vis.kjmo
;
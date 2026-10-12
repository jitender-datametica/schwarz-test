create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_BESTWERT_CALC_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	ARTHIERTYP_ID,
	DAT,
	OWG_ID,
	BSW_FG,
	UMSATZ_BRUTTO_OWG,
	UMSATZ_PLAN_BRUTTO_OWG,
	ABSCHRIFT_OPERATIV_BRUTTO_OWG,
	ABSCHRIFT_PREIS_BRUTTO_OWG,
	ABSCHRIFT_TOTAL_BRUTTO_OWG,
	ABSCHRIFT_AKTION_BRUTTO_OWG,
	WARENEINGANG_BRUTTO_OWG,
	BESTAND_VORMONAT_BRUTTO_OWG,
	SCHLUSSBESTAND_BRUTTO_OWG,
	BESTAND_CALC,
	ANFANGSBESTAND_BRUTTO_OWG
) as










WITH 
  warengruppe AS (
	SELECT arthiertyp_id
		, wg_id
		, owg_id
		, sort_id
	FROM dbp_msi_view_vis.mv_wg_int_1
	WHERE owg_id IN (1010)
	)

, umsatz AS (
	SELECT u.mandant_id
		, u.nb_id
		, u.wup_id
		, u.wrg_id
		, u.arthiertyp_id
		, w.owg_id
		, u.dat
		, SUM(u.ums_brutto) AS ums_brutto
	FROM dbp_msi_data.vis_tag_umsatz_wg_1 u
	JOIN warengruppe w
		ON u.wg_id = w.wg_id
	WHERE u.arthiertyp_id = 2
	GROUP BY u.mandant_id
		, u.nb_id
		, u.wup_id
		, u.wrg_id
		, u.arthiertyp_id
		, w.owg_id
		, u.dat
	)

, abschriften_1 AS (
	SELECT a.mandant_id
		, a.nb_id
		, a.wup_id
		, a.wrg_id
		, a.arthiertyp_id
		, w.owg_id
		, a.dat
		, SUM(CASE WHEN ath.abschriftart_thema_int_id IN (1, 4) THEN a.abschrift_brutto * - 1.00
				ELSE NULL
				END) AS abschrift_op
		, SUM(CASE WHEN ath.abschriftart_thema_int_id IN (1) THEN a.abschrift_brutto * - 1.00
				ELSE NULL
				END) AS abschrift_ta
		, SUM(CASE WHEN ath.abschriftart_thema_int_id IN (4) THEN a.abschrift_brutto * - 1.00
				ELSE NULL
				END) AS abschrift_pa
		, SUM(CASE WHEN ath.abschriftart_int_id IN (- 1) THEN a.abschrift_brutto * - 1.00
				ELSE NULL
				END) AS abschrift_ak
	FROM dbp_msi_data.vis_tag_abschriften_wg_1 a
	JOIN warengruppe w
		ON w.wg_id = a.wg_id
	JOIN dbp_msi_view_vis.mv_abschriftart_int_zu_1 ai
		ON a.abschriftart_id = ai.abschriftart_id
			AND a.mandant_id = ai.mandant_id
	JOIN dbp_msi_view_vis.mv_abschriftart_int_thema_zu_1 ath
		ON ath.abschriftart_int_id = ai.abschriftart_int_id
	WHERE a.arthiertyp_id = 2
		AND (ath.abschriftart_thema_int_id IN (1, 4)
			OR ath.abschriftart_int_id IN (- 1)
			)
	GROUP BY a.mandant_id
		, a.nb_id
		, a.wup_id
		, a.wrg_id
		, a.arthiertyp_id
		, w.owg_id
		, a.dat
	)

, bestellfortschreibung AS (
	SELECT mandant_id
		, nb_id
		, wup_id
		, wrg_id
		, arthiertyp_id
		, owg_id
		, dat
		, umsatz_plan_brutto_owg  AS ums_pl_br_owg
		, wareneingang_brutto_owg AS we_brutto_owg
		, schlussbestand_vormonat_brutto_owg AS bestand_vormo
		, datzeit_pflege
	FROM dbp_msi_data.ts_bestwertfortschreibung_1
	)



SELECT u.mandant_id
	, u.nb_id
	, w.aktuell_wup_id AS wup_id
	, u.wrg_id
	, u.arthiertyp_id
	, u.dat
	, u.owg_id
	, COALESCE(b.mandant_id, 0)       AS bsw_fg
	, COALESCE(u.ums_brutto, 0.00)    AS umsatz_brutto_owg
	, COALESCE(b.ums_pl_br_owg, 0.00) AS umsatz_plan_brutto_owg
	, COALESCE(a.abschrift_op, 0.00)  AS abschrift_operativ_brutto_owg
	, COALESCE(a.abschrift_pa, 0.00)  AS abschrift_preis_brutto_owg
	, COALESCE(a.abschrift_ta, 0.00)  AS abschrift_total_brutto_owg
	, COALESCE(a.abschrift_ak, 0.00)  AS abschrift_aktion_brutto_owg
	, COALESCE(b.we_brutto_owg, 0.00) AS wareneingang_brutto_owg
	, COALESCE(b.bestand_vormo, 0.00) AS bestand_vormonat_brutto_owg 
	, 0.00                            AS schlussbestand_brutto_owg 
	
	, bestand_vormonat_brutto_owg + wareneingang_brutto_owg - umsatz_brutto_owg + abschrift_operativ_brutto_owg + abschrift_aktion_brutto_owg AS bestand_calc 
	
	, COALESCE(b.bestand_vormo
		, SUM(bestand_calc) OVER (PARTITION BY u.mandant_id, w.aktuell_wup_id, u.owg_id, u.wrg_id, MONTH(u.dat), YEAR(u.dat) ORDER BY u.dat ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
		, 0.00
	) AS anfangsbestand_brutto_owg 
FROM umsatz u

LEFT OUTER JOIN abschriften_1 a 
	ON u.mandant_id = a.mandant_id
		AND u.wup_id = a.wup_id
		AND u.wrg_id = a.wrg_id
		AND u.owg_id = a.owg_id
		AND u.dat = a.dat

LEFT JOIN bestellfortschreibung b
	ON u.mandant_id = b.mandant_id
		AND u.wup_id = b.wup_id
		AND u.wrg_id = b.wrg_id
		AND u.owg_id = b.owg_id
		AND u.dat = b.dat

INNER JOIN dbp_view.v_wup_1 w
	ON u.mandant_id = w.mandant_id
		AND u.wup_id = w.wup_id
;

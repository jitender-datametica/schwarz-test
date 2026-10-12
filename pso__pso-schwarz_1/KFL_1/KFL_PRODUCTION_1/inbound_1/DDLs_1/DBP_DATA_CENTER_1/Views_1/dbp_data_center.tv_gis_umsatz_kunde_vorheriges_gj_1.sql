CREATE OR REPLACE VIEW DBP_DATA_CENTER.TV_GIS_UMSATZ_KUNDE_VORHERIGES_GJ_1(
	GJ,
	ISO_CODE,
	WUP_ID,
	UMSATZ_NETTO_LAND,
	UMSATZ_BRUTTO_LAND,
	UMSATZ_NETTO_EUR,
	UMSATZ_BRUTTO_EUR,
	UMS_NETTO_PLAN_LAND,
	UMS_NETTO_PLAN_EUR,
	KUNDEN,
	DURCHSCHNITT_BON_NETTO_LAND,
	DURCHSCHNITT_BON_BRUTTO_LAND,
	DURCHSCHNITT_BON_NETTO_EUR,
	DURCHSCHNITT_BON_BRUTTO_EUR,
	UMSATZ_VT_NETTO_EUR,
	UMSATZ_VT_NETTO_LAND,
	DURCHSCHNITT_BON_VT_NETTO_EUR,
	DURCHSCHNITT_BON_VT_NETTO_LAND
) AS 
 
/*
	EXPORT : Daten vorheriges GJ 
	2024-09-24 ssch0611 : Filialumgliederung [P1760-DWH] + Review
*/
 
SELECT
  sub_ek.gj
, CASE sub_ek.mandant_id
	WHEN  1 THEN 'DEU'
	WHEN  2 THEN 'CZE'
	WHEN  3 THEN 'POL'
	WHEN  4 THEN 'MDA'
	WHEN  5 THEN 'SVK'
	WHEN  6 THEN 'HRV'
	WHEN  7 THEN 'ROU'
	WHEN  8 THEN 'BGR'
	ELSE NULL 
  END AS iso_code
, sub_ek.wup_id
, sub_ek.umsatz_netto_land   AS umsatz_netto_land
, sub_ek.umsatz_brutto_land  AS umsatz_brutto_land
, sub_ek.umsatz_netto_eur    AS umsatz_netto_eur
, sub_ek.umsatz_brutto_eur   AS umsatz_brutto_eur
, sub_vt.ums_netto_plan_land AS ums_netto_plan_land
, sub_vt.ums_netto_plan_eur  AS ums_netto_plan_eur
, sub_vt.kunden              AS kunden
, sub_ek.umsatz_netto_land  / NULLIFZERO(sub_vt.kunden) AS durchschnitt_bon_netto_land
, sub_ek.umsatz_brutto_land / NULLIFZERO(sub_vt.kunden) AS durchschnitt_bon_brutto_land
, sub_ek.umsatz_netto_eur   / NULLIFZERO(sub_vt.kunden) AS durchschnitt_bon_netto_eur
, sub_ek.umsatz_brutto_eur  / NULLIFZERO(sub_vt.kunden) AS durchschnitt_bon_brutto_eur
, sub_vt.ums_vt_netto_eur                               AS umsatz_vt_netto_eur
, sub_vt.ums_vt_netto_land                              AS umsatz_vt_netto_land
, sub_vt.ums_vt_netto_eur   / NULLIFZERO(sub_vt.kunden) AS durchschnitt_bon_vt_netto_eur
, sub_vt.ums_vt_netto_land  / NULLIFZERO(sub_vt.kunden) AS durchschnitt_bon_vt_netto_land
FROM (
	SELECT ais.mandant_id, ais.wup_id, ais.gj
	, SUM(ais.umsatz_netto_land) umsatz_netto_land
	, SUM(ais.umsatz_brutto_land) AS umsatz_brutto_land
	, SUM(ais.umsatz_netto_eur) AS umsatz_netto_eur
	, SUM(ais.umsatz_brutto_eur) AS umsatz_brutto_eur
	FROM ( -- AIS : EK-Daten + Mapping auf akt_wup
		SELECT ais.mandant_id, wup.aktuell_wup_id AS wup_id, zeit.gj, ais.dat
		, ais.umsatz_netto AS umsatz_netto_land
		, ais.umsatz_netto + ais.umsatz_mwst_betrag AS umsatz_brutto_land
		, COALESCE(ais.diff_umsatz_netto_konz, ais.umsatz_netto) umsatz_netto_eur
		, COALESCE(ais.diff_umsatz_netto_konz + ais.diff_umsatz_mwst_betrag_konz, ais.umsatz_netto + ais.umsatz_mwst_betrag) AS umsatz_brutto_eur
		FROM dbp_data.artbew_wg_tp2_sum_1 ais
 
		JOIN dbp_data.wup_1 wup_1
		ON wup.mandant_id = ais.mandant_id AND wup.wup_id = ais.wup_id
 
		JOIN dbp_view.v_tag_1 zeit_1
		ON zeit.dat = ais.dat
 
		WHERE zeit.akt_gj = -1
	) ais
	GROUP BY ALL 
) sub_ek
 
LEFT OUTER JOIN (
	SELECT vis.mandant_id, vis.wup_id, vis.gj
	, SUM(ums_plan_land) AS ums_netto_plan_land
	, SUM(ums_plan_eur)  AS ums_netto_plan_eur
	, SUM(anz_kunde)     AS kunden
	, SUM(ums_netto_land) AS ums_vt_netto_land
	, SUM(ums_netto_eur) AS ums_vt_netto_eur
	FROM ( -- VIS : VT-Daten inkl. Mapping auf akt_wup
		SELECT vis.mandant_id, vis.wup_id, vis.kjmo, zeit.gj
		, CASE WHEN vis.wrg_id = 'EUR' THEN vis.ums_netto END      AS ums_netto_eur
		, CASE WHEN vis.wrg_id = 'EUR' THEN vis.ums_netto_plan END AS ums_plan_eur
		, CASE WHEN vis.wrg_id = 'EUR' THEN vis.anz_kunde END      AS anz_kunde
		, CASE WHEN vis.wrg_id <> 'EUR' OR land.default_wrg = 'EUR' THEN vis.ums_netto END      AS ums_netto_land
		, CASE WHEN vis.wrg_id <> 'EUR' OR land.default_wrg = 'EUR' THEN vis.ums_netto_plan END AS ums_plan_land
		FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WUP_1 vis
 
		INNER JOIN DBP_DATA.MANDANT_1 land_1
		ON land.mandant_id = vis.mandant_id
 
		INNER JOIN DBP_DATA.MONAT_1 zeit_1
		ON zeit.kjmo=vis.kjmo
 
		WHERE vis.nb_id = 0 AND zeit.akt_gj = -1
	) vis
	GROUP BY ALL 
) sub_vt
ON sub_vt.mandant_id = sub_ek.mandant_id AND sub_vt.wup_id = sub_ek.wup_id
AND sub_vt.gj = sub_ek.gj
 
WHERE sub_ek.umsatz_netto_land > 0
;
create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_VIS_MONAT_FAKT_WUP_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	RPM_IMMOBILIE_ID,
	VS_ID,
	KJMO,
	UMSATZ_NETTO,
	UMSATZ_NETTO_VJ,
	UMSATZ_NETTO_VVJ,
	UMSATZ_NETTO_PLAN,
	EXPANSIONSBEREINIGUNG_DAT,
	DAT_EROEFFNUNG,
	UMSATZ_NETTO_PLAN_EURO,
	UMSATZ_NETTO_VJ_EURO
) as

SELECT
v01.mandant_id
, v01.nb_id
, v01.wup_id
, v01.rpm_hierarchie_id
, v01.vs_id
, v01.kjmo
--, v01.wrg_id                AS umsatz_wrg
, CAST(
CASE
WHEN v200.wrg_typ_id  = 0
THEN COALESCE( v01.ums_netto   ,0)
WHEN  v200.wrg_typ_id  = 1
THEN COALESCE(v01.ums_netto ,0) / v300.umrechnungskurs
END
AS DECIMAL(18,8))
AS umsatz_netto
, CAST(
CASE
WHEN v200.wrg_typ_id  = 0
THEN COALESCE( v01.ums_netto_kvj   ,0)
WHEN  v200.wrg_typ_id  = 1
THEN COALESCE(v01.ums_netto_kvj   ,0) / v300.umrechnungskurs
END
AS DECIMAL(18,8))
AS umsatz_netto_vj
, CAST(
CASE
WHEN v200.wrg_typ_id  = 0
THEN COALESCE( v01.ums_netto_kvvj    ,0)
WHEN  v200.wrg_typ_id  = 1
THEN COALESCE(v01.ums_netto_kvvj    ,0) / v300.umrechnungskurs
END
AS DECIMAL(18,8))
AS umsatz_netto_vvj
, CAST(
CASE
WHEN v200.wrg_typ_id  = 0
THEN COALESCE( v01.ums_netto_plan   ,0)
WHEN  v200.wrg_typ_id  = 1
THEN COALESCE(v01.ums_netto_plan   ,0) / v300.umrechnungskurs
END
AS DECIMAL(18,8))
AS umsatz_netto_plan

, v01.expansionsbereinigung_dat

, v01.dat_eroeffnung
, v01.umsatz_netto_plan_euro
, v01.umsatz_netto_vj_euro

--umsatzentwicklung
FROM KFL_PRODUCTION.DBP_MSI_VIEW_IOS_MATERIALIZED.tbl_mv_vis_monat_fakt_wup_2 v01
-- Ermittlung der eingestellter Währung

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200

JOIN KFL_PRODUCTION.DBP_MSI_VIEW_IOS_MATERIALIZED.mv_mandant_2 v250
ON v01.mandant_id = v250.mandant_id

-- Umrechnung Standardkurs, Berichtkurs
JOIN  KFL_PRODUCTION.DBP_MSI_VIEW_IOS_MATERIALIZED.mv_kurs_2 v300
ON v300.dat_bis = '9999-12-31'
AND v250.default_wrg = v300.von_wrg_id
AND v300.kurstyp_id = 3
AND v300.nach_wrg_id = v01.wrg_id;
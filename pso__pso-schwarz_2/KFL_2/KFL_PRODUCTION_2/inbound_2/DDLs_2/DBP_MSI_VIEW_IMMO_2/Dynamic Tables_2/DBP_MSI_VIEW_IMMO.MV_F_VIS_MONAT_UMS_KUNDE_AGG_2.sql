CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_F_VIS_MONAT_UMS_KUNDE_AGG_2(
	MANDANT_ID,
	WRG_ID,
	WRG_TYP_ID,
	WUP_ID,
	WE_INTRENO,
	F_ANZ_KUNDE_ANZ,
	KJMO,
	F_ANZ_KUNDE_AGG,
	F_UMS_NETTO_AGG,
	AVG_UMS_NETTO,
	AVG_ANZ_KUNDE
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, v1.wrg_id, v1.wrg_typ_id, v1.wup_id, v1.we_intreno, SUM(CASE WHEN v1.f_anz_kunde > 0 THEN 1 ELSE 0 END) AS f_anz_kunde_anz, MAX(v1.kjmo) AS kjmo, SUM(v1.f_anz_kunde) AS f_anz_kunde_agg, SUM (v1.f_ums_netto) AS f_ums_netto_agg, CASE WHEN f_anz_kunde_anz <> 0 THEN CAST (TRUNC(f_ums_netto_agg/f_anz_kunde_anz) AS DECIMAL (18,2))ELSE 0 END AS avg_ums_netto, CASE WHEN f_anz_kunde_anz <> 0 THEN CAST(TRUNC( f_anz_kunde_agg/f_anz_kunde_anz) AS DECIMAL(18,2)) ELSE 0 END AS avg_anz_kunde
   FROM dbp_msi_view_immo.mv_f_vis_monat_ums_kunde_2 AS v1
   WHERE v1.akt_buchungs_schluss<= 0  AND v1.akt_buchungs_schluss>=-11
   
   GROUP BY
   v1.mandant_id
   ,v1.wrg_id
   ,v1.wrg_typ_id
   ,v1.wup_id
   ,v1.we_intreno;
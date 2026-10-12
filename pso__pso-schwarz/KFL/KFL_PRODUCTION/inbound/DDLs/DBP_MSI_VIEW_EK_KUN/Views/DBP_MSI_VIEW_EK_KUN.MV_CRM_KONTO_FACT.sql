create or replace view DBP_MSI_VIEW_EK_KUN.MV_CRM_KONTO_FACT(
	CRM_KONTO_ID,
	CRM_KUNDE_ID,
	CRM_KONTO_TYP_ID,
	CRM_KUNDENPROGRAMM_ID,
	ZEIT_VON,
	ZEIT_BIS,
	DAT_BIS,
	GELOESCHT_FG_KONTO,
	DAT
) as
SELECT
v01.crm_konto_id
,v01.crm_kunde_id
,v01.crm_konto_typ_id
,v01.crm_kundenprogramm_id
,v01.zeit_von
,v01.zeit_bis 
,CAST(v01.zeit_bis AS DATE) AS dat_bis
,v01.geloescht_fg AS geloescht_fg_konto
,v02.dat
FROM dbp_view.v_crm_l_konto v01
JOIN dbp_view.v_tag v02
ON v02.dat BETWEEN v01.zeit_von AND v01.zeit_bis
WHERE akt_tag<=0;
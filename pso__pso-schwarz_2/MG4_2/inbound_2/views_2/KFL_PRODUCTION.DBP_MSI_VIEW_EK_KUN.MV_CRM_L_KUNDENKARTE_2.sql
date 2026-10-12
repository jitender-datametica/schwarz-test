create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_CRM_L_KUNDENKARTE_2(
	KUNDENKARTE_ID,
	MANDANT_ID,
	CRM_KUNDENKARTE_ART_ID,
	CRM_KUNDENKARTE_NR,
	CRM_KONTO_ID,
	GESPERRT_FG,
	ZEIT_VON,
	ZEIT_BIS,
	GELOESCHT_FG_KUNDENKARTE
) as
SELECT
kundenkarte_id
,mandant_id
,crm_kundenkarte_art_id
,crm_kundenkarte_nr
,crm_konto_id
,gesperrt_fg
,zeit_von
,zeit_bis
,geloescht_fg AS geloescht_fg_kundenkarte
FROM dbp_view.v_crm_l_kundenkarte_2
;
create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_CRM_L_KUNDE_2(
	CRM_KUNDE_ID,
	DAT_REGISTRIERUNG,
	DAT_ABMELDUNG,
	KUNDENTYP_ID,
	KUNDENHERKUNFT_ID,
	GENDER_ID,
	GEBURTSJAHR,
	AGE,
	KUNDE_STATUSGRUND_ID,
	STRASSE,
	WOHNORT,
	PLZ,
	KUNDE_MANDANT_ID,
	VORZUGSFILIALE_WUP_ID,
	AKT_VORZUGSFILIALE_WUP_ID,
	VORZUGSFILIALE_MANDANT_ID,
	NB_ID,
	MERGE_FG,
	REGISTRIERUNGSFILIALE_WUP_ID,
	AKT_REGISTRIERUNGSFILIALE_WUP_ID,
	REGISTRIERUNGSFILIALE_MANDANT_ID,
	REGISTRIERUNGSFILIALE_NB_ID,
	MANDANT_KBEZ
) as
SELECT
v01.crm_kunde_id
,TO_DATE(v01.zeit_registrierung) AS dat_registrierung
,TO_DATE(v01.zeit_abmeldung) AS dat_abmeldung
,v01.kundentyp_id
,v01.kundenherkunft_id
,v01.gender_id
,v01.geburtsjahr
,DATE_PART(YEAR, CURRENT_TIMESTAMP) - v01.geburtsjahr AS age
,v01.kunde_statusgrund_id
,v01.strasse
,v01.wohnort
,v01.plz
,v01.kunde_mandant_id
,v01.vorzugsfiliale_wup_id

,v04.aktuell_wup_id AS akt_vorzugsfiliale_wup_id
,v01.vorzugsfiliale_mandant_id
,v01.nb_id
,v01.merge_fg
,v01.registrierungsfiliale_wup_id

,v03.aktuell_wup_id AS akt_registrierungsfiliale_wup_id
,v01.registrierungsfiliale_mandant_id
,v01.registrierungsfiliale_nb_id
,v02.mandant_kbez

FROM DBP_VIEW.v_crm_l_kunde_2 v01

JOIN DBP_VIEW.v_mandant_2 v02
ON (v01.kunde_mandant_id=v02.mandant_id)


JOIN DBP_MSI_VIEW_EK_KUN.MV_WUP_2 V03
ON (v01.registrierungsfiliale_mandant_id = v03.mandant_id
AND v01.registrierungsfiliale_wup_id = v03.wup_id
AND v01.registrierungsfiliale_nb_id = v03.nb_id)

JOIN DBP_MSI_VIEW_EK_KUN.MV_WUP_2 V04
ON (v01.vorzugsfiliale_mandant_id = v04.mandant_id
AND v01.vorzugsfiliale_wup_id = v04.wup_id
AND v01.nb_id = v04.nb_id)
;
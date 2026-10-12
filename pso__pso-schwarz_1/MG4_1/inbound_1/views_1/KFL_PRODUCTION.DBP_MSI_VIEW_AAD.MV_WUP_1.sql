create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_WUP_1(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	WUP_STANDORT,
	DAT_VON,
	VF_ID,
	VKL_ID,
	HL_ID,
	DAT_BIS,
	DAT_EROEFFNUNG,
	BREITENGRAD,
	LAENGENGRAD,
	VS_ID,
	LAND_ID
) as






SELECT
    v01.wup_id	
   ,v01.nb_id
   ,v01.mandant_id
   ,CASE WHEN wup_id = 0
	THEN land_id || ' (unbekannt)'
	ELSE wup_standort
	END AS wup_standort
   ,v01.dat_von
   ,v01.vf_id
   ,v01.vkl_id
   ,v01.hl_id
   ,v01.dat_bis
   ,v01.dat_eroeffnung
   ,v01.breitengrad
   ,v01.laengengrad
   ,v01.vs_id
   ,v01.land_id
FROM dbp_view.v_wup_1 v01

WHERE ((nb_id = 0
AND dat_von < CURRENT_DATE

AND dat_eroeffnung < CURRENT_DATE) 
OR wup_id = 0)
AND wup_id = aktuell_wup_id
;
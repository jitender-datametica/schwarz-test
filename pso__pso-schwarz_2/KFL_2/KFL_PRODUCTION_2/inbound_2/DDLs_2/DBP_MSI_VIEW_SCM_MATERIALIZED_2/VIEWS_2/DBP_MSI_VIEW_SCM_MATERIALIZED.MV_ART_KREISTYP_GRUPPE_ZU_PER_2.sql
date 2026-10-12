create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_KREISTYP_GRUPPE_ZU_PER_2(
	ART_ID,
	MANDANT_ID,
	KREISTYP_ID,
	DAT_VON,
	KREISTYP_GRUPPE_ID,
	DAT_BIS
) as
SELECT
 v00.art_id
,v00.mandant_id
,COALESCE(v01.kreistyp_id,'') AS kreistyp_id
,v01.dat_von
,COALESCE(v01.kreistyp_gruppe_id,'') AS kreistyp_gruppe_id
,v01.dat_bis
FROM DBP_VIEW.v_art_2 v00 
LEFT JOIN DBP_VIEW.v_art_kreistyp_gruppe_zu_per_2 v01
ON v00.mandant_id = v01.mandant_id
AND v00.art_id = v01.art_id
AND v01.dat_bis = '9999-12-31'
WHERE v00.dat_bis = '9999-12-31';
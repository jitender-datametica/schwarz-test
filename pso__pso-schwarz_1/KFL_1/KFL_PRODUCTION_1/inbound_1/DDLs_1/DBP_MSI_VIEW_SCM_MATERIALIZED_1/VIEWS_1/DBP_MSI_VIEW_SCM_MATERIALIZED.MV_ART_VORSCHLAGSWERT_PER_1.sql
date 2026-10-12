create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_VORSCHLAGSWERT_PER_1(
	MANDANT_ID,
	ART_ID,
	DAT_VON,
	AUSG_MENGE_EINH_ID,
	PALETTEN_FAKTOR_EINH_ID,
	DAT_BIS,
	SORTIMENTSLISTENART_ID,
	ZL_KOLLI_MENGE_EINH_ID,
	LAGE_FAKTOR_EINH_ID,
	AUSPACK_FG
) as
SELECT v01.mandant_id
      ,v01.art_id
      ,v01.dat_von
      ,TRIM(CASE WHEN v01.ausg_menge_einh_id <> '' THEN v01.ausg_menge_einh_id ELSE '1' END) AS ausg_menge_einh_id
      ,v01.paletten_faktor_einh_id
      ,v01.dat_bis
      ,v01.sortimentslistenart_id
      ,v01.zl_kolli_menge_einh_id
      ,v01.lage_faktor_einh_id
      ,v01.auspack_fg
FROM DBP_VIEW.v_art_vorschlagswert_per_1 v01
WHERE v01.dat_bis = '9999-12-31';
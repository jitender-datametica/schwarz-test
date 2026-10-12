create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_AUTODISPO_DIF_TAG_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT,
	DAT_AUSFUEHRUNG,
	DIF_TYP_ID,
	DIF_STATUS_ID,
	DIF_WERT,
	DIF_KOMMENTAR,
	SAP_RETURNCODE
) as
SELECT v01.mandant_id
      ,v01.kunde_id AS wup_id
      ,0 AS nb_id
      ,v01.art_id
      ,v01.dat
      ,v01.dat_ausfuehrung
      ,v01.dif_typ_id
      ,v01.dif_status_id
      ,v01.dif_wert
      ,v01.dif_kommentar
      ,v01.sap_returncode
FROM DBP_VIEW.v_autodispo_dif_tag_2 v01;
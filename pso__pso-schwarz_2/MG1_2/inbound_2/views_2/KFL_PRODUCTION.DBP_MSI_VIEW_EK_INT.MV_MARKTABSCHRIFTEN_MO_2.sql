create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_MARKTABSCHRIFTEN_MO_2(
	WUP_ID,
	NB_ID,
	KJMO,
	MANDANT_ID,
	ABSCHRIFTART_ID,
	ART_ID,
	ABSCHRIFTBETRAG_NETTO,
	ABSCHRIFTBETRAG_NETTO_VJ,
	WRG_ID,
	WUP_BEREINIGT_FG
) as

   SELECT wup_id, nb_id, kjmo, mandant_id, abschriftart_id, art_id, abschriftbetrag_netto, abschriftbetrag_netto_vj, wrg_id, wup_bereinigt_fg

   FROM dbp_msi_v_view.v_marktabschriften_coi_mo_2;
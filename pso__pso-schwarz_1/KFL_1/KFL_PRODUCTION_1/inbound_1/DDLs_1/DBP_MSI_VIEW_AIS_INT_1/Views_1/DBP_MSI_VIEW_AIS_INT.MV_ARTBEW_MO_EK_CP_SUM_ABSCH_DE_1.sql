CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTBEW_MO_EK_CP_SUM_ABSCH_DE_1(
	MANDANT_ID,
	ART_ID,
	BEWART_ID,
	BEWART_DET_ID,
	WUP_ID,
	NB_ID,
	KJMO,
	WRG_ID,
   POSTEN_ID_PER,
	POSTEN_KZ_PER,
	PREIS_ABSCHRIFT_NETTO
) AS
   SELECT
   v01.mandant_id
   ,v01.art_id
   ,v01.bewart_id
   ,v01.bewart_det_id
   ,v01.wup_id
   ,v01.nb_id
   ,v01.kjmo
   ,v01.wrg_id
   ,CAST(CASE WHEN v01.bewart_id = 1001 AND v01.posten_id NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END AS VARCHAR(2)) AS posten_id_per
   ,CASE WHEN v01.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS posten_kz_per
   ,v01.preis_abschrift_netto

   FROM dbp_view.v_artbew_mo_ek_cp_sum_1 v01
   WHERE wup_bereinigt_fg = 0
   AND v01.mandant_id = 1;
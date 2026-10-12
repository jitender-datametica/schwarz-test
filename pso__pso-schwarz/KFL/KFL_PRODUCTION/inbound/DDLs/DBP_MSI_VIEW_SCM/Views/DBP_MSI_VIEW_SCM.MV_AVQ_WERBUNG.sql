create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_AVQ_WERBUNG(
	MANDANT_ID,
	KJWO,
	KJWO_VON,
	WUP_ID,
	NB_ID,
	DAT_VON,
	DAT_BIS,
	ANZ_TAGE_AKTION,
	WTAG_ID_ENDE,
	WTAG_ID_START,
	CLUSTER_DAUER_ID,
	WERBEMITTEL_AVQ_TOP_PRIO,
	WERBEFLAECHENABSCHNITT_AVQ_TOP_PRIO,
	WERBEFLAECHENTHEMA_AVQ_TOP_PRIO,
	ART_WB_ID,
	POSTEN_WB_ID,
	ART_ID,
	POSTEN_ID,
	PMR_TOP_ART_FG,
	WERBEPROZESS_ID,
	AKTIONSKLASSIFIZIERUNG_ID,
	AKTIONSKLASSIFIZIERUNG_DET_ID,
	WRG_ID,
	VK_AKTION_BRUTTO,
	VK_KCARD_BRUTTO,
	VK_VOR_AKTION_BRUTTO,
	BETRAG_UMSTAZ_GESAMT,
	FAKTOR_FLAKI,
	MHD_ZEITRAUM,
	LAGER_PROZENT,
	PLANMENGE_WBS,
	PLANMENGE_UPLOAD,
	ESTIMATION_ID_WBS,
	ADJUSTMENT_ID_WBS,
	BESTAND_AKTIONSSTART,
	BESTAND_AKTIONSENDE,
	UEBERBESTAND,
	MIN_SICHERH_BESTAND,
	MENGE_BESTAND_SOLL_MAX,
	SOLLBESTAND,
	ANZ_NULLBESTAND_GESAMT,
	ANZ_NULLBESTAND_TAG1,
	ANZ_NULLBESTAND_TAG1BIS3,
	ANZ_MINUSBESTAND_GESAMT,
	ANZ_MINUSBESTAND_TAG1,
	ANZ_MINUSBESTAND_TAG1BIS3,
	ANZ_EXC209_GESAMT,
	ANZ_EXC209_TAG1,
	ANZ_EXC209_TAG1BIS3,
	ANZ_EXC214_GESAMT,
	ANZ_EXC214_TAG1,
	ANZ_EXC214_TAG1BIS3,
	MENGE_GESAMT,
	UMSATZ_GESAMT,
	MENGE_HISTORIE_AF,
	MENGE_NUR_TAG1,
	MENGE_TAG_1_7BIS13,
	WE_MENGE_GESAMT,
	WE_MENGE_VOR_AKTION,
	WE_MENGE_IN_AKTION,
	MWB_BASISMENGE_EINH_ID,
	ANGEBOT_TYP_CD,
	AKTION_TYP_ID,
	GESCHAEFTSVORFALL_ID,
	KONDITIONSART_ID,
	RABATT_TYP_ID,
	ANZ_BONUSKAUF_BEZAHLT,
	ANZ_BONUSKAUF_KAUF,
	ANZ_BONUSKAUF_GRATIS,
	MENGE_BONUSKAUF_MIN,
	PROZ_BONUSKAUF_RABATT,
	BETRAG_BONUSKAUF_RABATT,
	LISTUNG_FG
) as






SELECT 
 aw.mandant_id
,aw.kjwo
,t.kjwo AS kjwo_von
,aw.wup_id
,aw.nb_id
,aw.dat_aktion_von
,aw.dat_aktion_bis
,aw.anz_tage_aktion
,aw.wtag_id_ende
,aw.wtag_id_start
,aw.cluster_dauer_id
,aw.werbemittel_avq_top_prio_nr
,aw.werbeflaechenabschnitt_avq_top_prio_nr
,aw.werbeflaechenthema_avq_top_prio_nr
,aw.art_mutter_wb_id
,aw.posten_wb_id
,aw.art_id
,CASE WHEN aw.posten_id ='PN' THEN 1 ELSE 0 END AS posten_id
,aw.pmr_top_art_fg
,aw.werbeprozess_id
,aw.aktionsklassifizierung_id
,aw.aktionsklassifizierung_det_id
,aw.wrg_id
,aw.betrag_vk_aktion_brutto
,aw.betrag_vk_kcard_brutto
,aw.betrag_vor_aktion_brutto
,aw.betrag_umsatz_gesamt
,aw.faktor_flaki
,aw.mhd_zeitraum
,aw.prz_min_restlaufzeit_lager
,aw.menge_plan_wbs
,aw.menge_plan_upload
,aw.wbs_estimation_id
,aw.wbs_adjustment_id
,aw.menge_bestand_aktionsstart
,aw.menge_bestand_aktionsende
,aw.menge_ueberbestand
,aw.menge_bestand_min_sicherheit
,aw.menge_bestand_soll_max
,aw.menge_sollbestand
,aw.anz_nullbestand_gesamt
,aw.anz_nullbestand_tag1
,aw.anz_nullbestand_tag1bis3
,aw.anz_minusbestand_gesamt
,aw.anz_minusbestand_tag1
,aw.anz_minusbestand_tag1bis3
,aw.anz_exc209_gesamt
,aw.anz_exc209_tag1
,aw.anz_exc209_tag1bis3
,aw.anz_exc214_gesamt
,aw.anz_exc214_tag1
,aw.anz_exc214_tag1bis3
,aw.menge_gesamt
,aw.betrag_umsatz_gesamt
,aw.menge_historie_af
,aw.menge_nur_tag1
,aw.menge_tag_1_7bis13
,aw.menge_we_gesamt
,aw.menge_we_vor_aktion
,aw.menge_we_in_aktion
,mwb.basismenge_einh_id
,aw.ANGEBOT_TYP_CD
,aw.AKTION_TYP_ID
,aw.GESCHAEFTSVORFALL_ID
,aw.KONDITIONSART_ID
,aw.RABATT_TYP_ID
,aw.ANZ_BONUSKAUF_BEZAHLT
,aw.ANZ_BONUSKAUF_KAUF
,aw.ANZ_BONUSKAUF_GRATIS
,aw.MENGE_BONUSKAUF_MIN
,aw.PROZ_BONUSKAUF_RABATT
,aw.BETRAG_BONUSKAUF_RABATT
,aw.listung_fg
FROM dbp_view.v_avq_werbung aw

 JOIN dbp_view.v_art  mwb
   ON mwb.mandant_id = aw.mandant_id AND mwb.art_id = aw.art_mutter_wb_id
   AND mwb.dat_bis = '9999-12-31'
JOIN dbp_view.v_tag t
ON aw.dat_aktion_von = t.dat

;

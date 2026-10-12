create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BESCH_RECH_DET_2(
	SYSTEM_ID,
	MANDANT_ID,
	RECH_BELEG_ID,
	RECH_BELEG_POS_ID,
	GJ,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	WBNK_FG,
	KONDITIONSART_ID,
	EAN_ID,
	GP_ART_ID,
	EDI_POS_NR,
	BETRAG_MWST,
	WG_ID,
	GP_ID,
	EINKAUFSORGANISATION_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	MENGE_RECH,
	BEST_MENGE_EINH_ID,
	BEST_PREIS_MENGE,
	BEST_PREIS_MENGE_EINH_ID,
	BUCH_GRUND_INT_ID,
	BUCH_GRUND_EXT_ID,
	ARTHIERTYP_ID,
	LAGERBEW_BELEG_ID,
	LAGERBEW_BELEG_POS_ID,
	KJ,
	MENGENABW_RPW_FG,
	PREISABW_RPW_FG,
	MENGE_RECHSTELLER,
	RECHSTELLER_MENGE_EINH_ID,
	BETRAG_KONDITION,
	KONDITION_EINH_ID,
	KONDITION_MENGE_EINH_ID,
	KONDITION_PREIS_EINH_ID,
	PREIS_VK_BRUTTO,
	BETRAG_VK_BRUTTO,
	BETRAG_BELEG,
	SOLL_HABEN_KZ,
	VK_WRG_ID,
	POS_MANUELL_ERSTELLT_FG,
	DAT_RPW,
	DAT_BUCH,
	DAT_BELEG,
	DAT_ERFASST,
	DAT_RECH_EINGANG,
	SAP_MWST_ID,
	BETRAG_KORREKTUR_NETTO,
	MWST
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
           7
          ,a.mandant_id
          ,a.rech_beleg_id
          ,a.rech_beleg_pos_id
          ,a.gj
          ,a.best_beleg_id
          ,a.best_beleg_pos_id
          ,a.wbnk_fg
          ,COALESCE(a.konditionsart_id, '0') AS konditionsart_id
          ,COALESCE(a.ean_id,0) ean_id
          ,a.gp_art_id
          ,a.edi_pos_nr
          ,a.betrag_mwst
          ,c.wg_id
          ,b.gp_id
          ,a.einkaufsorganisation_id
          ,b.wup_id
          ,b.nb_id
          ,a.art_id
          --CAST(TRUNC(a.menge_rech/u.umrech_faktor,3) AS DECIMAL(18,3)),
          ,CAST((a.menge_rech/ROUND(u.umrech_faktor,21)) AS DECIMAL(18,3))
          ,a.best_menge_einh_id
          ,a.best_preis_menge
          ,a.best_preis_menge_einh_id
          ,COALESCE (a.buch_grund_int_id, '0') buch_grund_int_id
          ,COALESCE (a.buch_grund_ext_id, '0') buch_grund_ext_id
          ,a.arthiertyp_id
          ,a.lagerbew_beleg_id
          ,a.lagerbew_beleg_pos_id
          ,a.kj
          ,a.mengenabw_rpw_fg
          ,a.preisabw_rpw_fg
          ,a.menge_rechsteller
          ,a.rechsteller_menge_einh_id
          ,a.betrag_kondition
          ,a.kondition_einh_id
          ,a.kondition_menge_einh_id
          ,a.kondition_preis_einh_id
          ,a.preis_vk_brutto
          ,a.betrag_vk_brutto
          ,a.betrag_beleg
          ,a.soll_haben_kz
          ,a.vk_wrg_id
          ,a.pos_manuell_erstellt_fg
          ,CASE WHEN b.rech_beleg_status_id = '5' THEN  CAST(b.dat_erfasst AS VARCHAR) ELSE NULL END AS dat_rpw_
          ,b.dat_buch
          ,b.dat_beleg
          ,b.dat_vorerfasst AS dat_erfasst
          ,b.dat_rech_eingang
          ,sap_mwst_id
          ,a.betrag_korrektur_netto
          ,a.mwst
          FROM dbp_view.v_besch_rech_det_2 a
          JOIN dbp_view.v_besch_rech_2 b
          ON a.mandant_id = b.mandant_id
          AND a.rech_beleg_id = b.rech_beleg_id
          AND a.gj = b.gj
          JOIN dbp_view.v_art_wg_zu_per_2 c
          ON a.mandant_id = c.mandant_id
          AND a.art_id = c.art_id
          AND (CASE WHEN b.rech_beleg_status_id = '5' THEN  CAST(b.dat_erfasst AS DATE) ELSE NULL END) BETWEEN c.dat_von AND c.dat_bis
          AND c.arthiertyp_id = 2
          INNER JOIN dbp_view.v_art_umrechnung_faktor_per_2 u
          ON a.art_id = u.art_id
          AND a.mandant_id = u.mandant_id
          AND a.best_menge_einh_id = u.altnv_menge_einh_id
          AND (CASE WHEN b.rech_beleg_status_id = '5' THEN CAST(b.dat_erfasst AS DATE) ELSE NULL END) BETWEEN u.dat_von AND u.dat_bis
          WHERE a.mandant_id = 1;

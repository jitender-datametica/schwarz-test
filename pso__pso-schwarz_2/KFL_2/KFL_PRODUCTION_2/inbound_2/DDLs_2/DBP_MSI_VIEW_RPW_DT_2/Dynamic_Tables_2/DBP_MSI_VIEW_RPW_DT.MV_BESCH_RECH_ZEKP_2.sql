create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BESCH_RECH_ZEKP_2(
	RECH_BELEG_ID,
	RECH_BELEG_POS_ID,
	GJ,
	KJ,
	ART_ID,
	SYSTEM_ID,
	GP_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT_BUCH,
	MENGE_RECH,
	BETRAG_BELEG,
	BETRAG_EK_BRUTTO,
	BETRAG_EK_NETTO,
	BETRAG_EK_NN,
	BETRAG_EK_MEP,
	BETRAG_EK_NETTO_BNK,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	LAGERBEW_BELEG_ID,
	LAGERBEW_BELEG_POS_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 29.12.2012 AL Join Bedienung art_gp_wup_zu_per_2  um mandant_id ergänzt

    SELECT
    det.rech_beleg_id,
    det.rech_beleg_pos_id,
    det.gj,
    det.kj,
    det.art_id,
    7,
    art_gp.gp_id,
    det.mandant_id,
    det.nb_id,
    det.wup_id,
    CASE WHEN kopf.rech_beleg_status_id = '5' THEN CAST(kopf.dat_erfasst AS VARCHAR) ELSE NULL END AS dat_buch,
    CAST(TRUNC(det.menge_rech/umrech.umrech_faktor) AS DECIMAL(18,3)),
    det.betrag_beleg,
    det.menge_rech * ek_brutto AS betrag_ek_brutto,
    det.menge_rech * ek_netto AS betrag_ek_n,
    det.menge_rech * ek_nettonetto AS betrag_ek_nn,
    det.menge_rech * ek_mep AS betrag_ek_mep,
    det.menge_rech * ek_netto_bnk AS betrag_ek_netto_bnk,
    best_beleg_id,
    best_beleg_pos_id,
    lagerbew_beleg_id,
    lagerbew_beleg_pos_id
    FROM dbp_view.v_besch_rech_det_2 det

    JOIN dbp_view.v_besch_rech_2 kopf
    ON det.rech_beleg_id=kopf.rech_beleg_id
    AND det.mandant_id=kopf.mandant_id
    AND det.gj=kopf.gj

    JOIN dbp_view.v_art_gp_zu_per_2 art_gp
    ON det.art_id = art_gp.art_id
    AND det.mandant_id=art_gp.mandant_id
    AND kopf.dat_buch BETWEEN art_gp.dat_von AND art_gp.dat_bis

    JOIN dbp_view.v_art_gp_wup_zu_per_2 art_gp_wup
    ON art_gp_wup.art_id = det.art_id
    AND art_gp_wup.mandant_id = det.mandant_id
    AND art_gp_wup.gp_id = art_gp.gp_id
    AND det.wup_id = art_gp_wup.wup_id
    AND kopf.dat_buch  BETWEEN art_gp_wup.dat_von AND art_gp_wup.dat_bis
    INNER JOIN dbp_view.v_art_umrechnung_faktor_per_2 umrech
    ON det.mandant_id = umrech.mandant_id
    AND det.art_id = umrech.art_id
    AND det.best_menge_einh_id = umrech.altnv_menge_einh_id
    AND kopf.dat_buch BETWEEN umrech.dat_von AND umrech.dat_bis

    WHERE det.mandant_id = 1;

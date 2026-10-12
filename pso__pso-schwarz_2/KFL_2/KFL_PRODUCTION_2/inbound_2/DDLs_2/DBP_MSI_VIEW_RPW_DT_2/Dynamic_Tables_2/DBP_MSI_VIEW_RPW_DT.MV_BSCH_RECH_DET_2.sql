create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BSCH_RECH_DET_2(
	WUP_ID,
	LAGERORT_ID,
	NB_ID,
	BSCH_ID,
	BSCH_POS_ID,
	ART_ID,
	DAT,
	BEWART_ID,
	MANDANT_ID,
	LAGER_BEWART_ID,
	LAGERBEW_BELEG_ID,
	KJ,
	GP_ID,
	BA_ID,
	BA_POS_ID,
	MENGE_RECH,
	EK_N,
	EK_NN,
	VK_N,
	STATUS_2,
	EINKAUFSORGANISATION_ID,
	EK_MEP,
	EK_KB,
	SYSTEM_ID,
	DIFF_MENGE_RECH_WE,
	DIFF_EK_N_WE,
	DIFF_VK_N_WE,
	MENGE_LAGERBEW,
	EK_N_LAGERBEW,
	VK_LAGERBEW,
	MENGE_RECHNUNG,
	AS_EK_N_RECHNUNG,
	EK_N_RECHNUNG,
	VK_RECHNUNG,
	VK_N_RECHNUNG
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    v01.wup_id,
    v01.lagerort_id,
    v01.nb_id,
    v01.bsch_id,
    v01.bsch_pos_id,
    v01.art_id,
    v01.dat,
    v01.bewart_id,
    v01.mandant_id,
    v01.lager_bewart_id,
    TRUNC( v01.bsch_id / 10000),
    MOD( v01.bsch_id, 10000) AS kj,
    v01.gp_id,
    v01.ba_id,
    v01.ba_pos_id,
    v01.menge_rech,
    v01.ek_n,
    v01.ek_nn,
    TRUNC( v01.vk_n * (100 + v03.mwst) / 100) AS vk_n,
    v01.status_2,
    v01.einkaufsorganisation_id,
    v01.ek_mep,
    v01.ek_kb,
    7 AS system_id,
    v01.diff_menge_rech_we,
    v01.diff_ek_n_we,
    TRUNC( v01.diff_vk_n_we * (100 + v03.mwst) / 100) AS diff_vk_n_we,
    CASE WHEN v01.status_2 =1 THEN v01.menge_rech
WHEN v01.status_2 =3 THEN menge_rech - diff_menge_rech_we
END AS menge_lagerbew,
    CASE WHEN v01.status_2 =1 THEN v01.ek_n
WHEN v01.status_2 =3 THEN v01.ek_n - v01.diff_ek_n_we
END AS ek_n_lagerbew,
    CASE WHEN status_2 =1 THEN CAST(( v01.vk_n * (100 + v03.mwst) / 100) AS NUMBER(38,6))
    WHEN v01.status_2 =3 THEN CAST(( v01.vk_n * (100 + v03.mwst) / 100) AS NUMBER(38,6)) - CAST((  v01.diff_vk_n_we  * (100 + v03.mwst) / 100) AS NUMBER(38,6))
    END AS vk_lagerbew,
    CASE WHEN status_2 =3 THEN v01.menge_rech
WHEN v01.status_2 =1 THEN NULL
END AS menge_rechnung,
    CASE WHEN v01.status_2 =3 THEN v01.menge_rech * v05.ek_netto
WHEN v01.status_2 =1 THEN NULL
END AS as_ek_n_rechnung,
    CASE WHEN status_2 =3 THEN v01.ek_n
WHEN v01.status_2 =1 THEN NULL
END AS ek_n_rechnung,
    CASE WHEN status_2 =3 THEN CAST(( v01.vk_n * (100 + v03.mwst) / 100) AS NUMBER(38,6))
    WHEN v01.status_2 =1 THEN NULL
    END AS vk_rechnung,
    CASE WHEN v01.status_2 =3 THEN v01.vk_n
WHEN v01.status_2 =1 THEN NULL
END AS vk_n_rechnung

FROM dbp_view.v_bsch_rech_det_2 v01

    JOIN dbp_view.v_art_2 v02
    ON v01.art_id = v02.art_id
    AND v01.mandant_id = v02.mandant_id

    JOIN dbp_view.v_mwst_per_2 v03
    ON v02.mwst_id = v03.mwst_id
    AND v02.mandant_id = v03.mandant_id
    AND v01.dat BETWEEN v03.dat_von AND v03.dat_bis
    LEFT OUTER JOIN dbp_view.v_art_gp_zu_per_2 v04
    ON v01.art_id = v04.art_id
    AND v01.mandant_id = v04.mandant_id
    AND v01.dat BETWEEN v04.dat_von AND v04.dat_bis
    LEFT OUTER JOIN dbp_view.v_art_gp_wup_zu_per_2 v05
    ON v01.art_id = v05.art_id
    AND v05.wup_id <> -1
    AND v04.gp_id = v05.gp_id
    AND v01.wup_id = v05.wup_id
    AND v01.dat BETWEEN v05.dat_von AND v05.dat_bis

    WHERE v01.mandant_id = 1;

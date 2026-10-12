create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BESCH_BEST_DET(
	MANDANT_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	ART_ID,
	EMPFAENGER_WUP_ID,
	NB_ID,
	LAGERORT_ID,
	LOESCH_FG,
	MENGE_BEST,
	SELBSTABHOL_FG,
	BEST_PREIS_MENGE_EINH_ID,
	MENGE_KOLLI,
	MENGE_PALETTE,
	ENDLIEF_FG,
	DAT_AENDERUNG,
	KUNDE_ID,
	DAT_BEST_BELEG,
	BEST_BASISMENGE_EINH_ID,
	EAN_ID,
	BETRAG_KOND_ZW_SUM2,
	POS_KOSTENLOS_FG,
	BETRAG_POS_NETTO,
	BETRAG_POS_NETTO_BEST_WRG,
	VK_BRUTTO,
	SYSTEM_ID,
	KJ,
	MENGE_BLOCK_BESTAND,
	GP_TEILSORTIMENT_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    v01.mandant_id,
    v01.best_beleg_id,
    v01.best_beleg_pos_id,
    v01.art_id,
    v01.wup_id  AS empfaenger_wup_id,
    v01.nb_id,
    v01.lagerort_id,
    v01.loesch_fg,
    v01.menge_best_bme,
    v01.selbstabhol_fg,
    v01.best_preis_menge_einh_id,
    v01.menge_best_kolli,
    v01.menge_best_palette,
    v01.endlief_fg,
    v01.dat_aenderung,
    v01.kunde_id,
    v01.dat_best_beleg,
    v01.best_menge_einh_id,
    v01.ean_id,
    v01.betrag_kond_zw_sum2,
    v01.pos_kostenlos_fg,
    v01.betrag_pos_netto,
    v01.betrag_pos_netto_best_wrg,
    v03.vk_brutto * menge_best_bme,
    7,
    EXTRACT(YEAR FROM v01.dat_best_beleg),
    v01.menge_block_bestand,
    v01.gp_teilsortiment_id

FROM dbp_view.v_besch_best_det v01

    JOIN dbp_view.v_besch_best v02
    ON v01.best_beleg_id = v02.best_beleg_id
    AND v01.mandant_id = v02.mandant_id
    AND v01.dat_best_beleg = v02.dat_best_beleg
    LEFT OUTER JOIN dbp_view.v_art_wup_zu_per v03
    ON v03.mandant_id = v01.mandant_id
    AND v03.art_id = v01.art_id
    AND v03.wup_id = v01.wup_id
    AND v03.nb_id = v01.nb_id
    AND v01.dat_best_beleg BETWEEN v03.dat_von AND v03.dat_bis

    WHERE v01.mandant_id = 1
    AND v02.einkaufsorganisation_id <> 5000;

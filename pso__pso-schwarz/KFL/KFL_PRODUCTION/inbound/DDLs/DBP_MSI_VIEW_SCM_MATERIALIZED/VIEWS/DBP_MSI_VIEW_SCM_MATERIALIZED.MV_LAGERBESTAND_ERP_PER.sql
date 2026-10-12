create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_LAGERBESTAND_ERP_PER(
	ART_ID,
	GJMO_BUCH,
	LAGERORT_ID,
	LAGERORT_LOESCH_FG,
	MANDANT_ID,
	MENGE_LGBEST_ERP_FREI_BME,
	MENGE_LGBEST_ERP_GESP_BME,
	MENGE_LGBEST_ERP_KOLLI,
	MENGE_LGBEST_ERP_NF_CHARGE_BME,
	MENGE_LGBEST_ERP_PALETTE,
	MENGE_LGBEST_ERP_QUAL_BME,
	MENGE_LGBEST_ERP_RET_GESP_BME,
	MENGE_LGBEST_ERP_UMLAG_BME,
	BETRAG_LGBEST_ERP,
	NB_ID,
	PFLEGE_STATUS,
	SPERR_ID,
	WUP_ID,
	DAT,
	WRG_ID,
	VK_NETTO_LGBEST_ERP,
	MENGE_BLOCKBESTAND_ACT,
	MENGE_BLOCKBESTAND_IWT,
	LGORT_IS_LGFSB_FG
) as


SELECT
v01.art_id,
v01.gjmo_buch,
v01.lagerort_id,
v01.lagerort_loesch_fg,
v01.mandant_id,
v01.menge_lgbest_erp_frei_bme,
v01.menge_lgbest_erp_gesp_bme,
v01.menge_lgbest_erp_kolli,
v01.menge_lgbest_erp_nf_charge_bme,
v01.menge_lgbest_erp_palette,
v01.menge_lgbest_erp_qual_bme,
v01.menge_lgbest_erp_ret_gesp_bme,
v01.menge_lgbest_erp_umlag_bme,
v01.betrag_lgbest_erp,
v01.nb_id,
v01.pflege_status,
v01.sperr_id,
v01.wup_id,
v02.dat,
v01.wrg_id,
v01.vk_netto_lgbest_erp,
v03.menge_blockbestand AS menge_blockbestand_act,
v04.menge_blockbestand AS menge_blockbestand_iwt,
CASE WHEN v011.FREMD_LAGERORT_ID = v01.lagerort_id THEN 1 ELSE 0 END AS lgort_is_lgfsb_fg																							   
FROM dbp_view.v_lagerbestand_erp_per v01
JOIN dbp_view.v_tag v02
ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis

JOIN dbp_view.v_art_wup_status_per v011
ON v01.mandant_id = v011.mandant_id
AND v01.wup_id     = v011.wup_id
AND v01.nb_id      = v011.nb_id
AND v01.art_id     = v011.art_id
AND v02.dat BETWEEN v011.dat_von AND v011.dat_bis


LEFT JOIN dbp_view.v_blockbestand_per v03
ON v01.mandant_id = v03.mandant_id
AND v01.wup_id     = v03.wup_id
AND v01.nb_id      = v03.nb_id
AND v01.art_id     = v03.art_id
AND v02.dat BETWEEN v03.dat_von AND v03.dat_bis
AND v03.prozess_id = 1


LEFT JOIN dbp_view.v_blockbestand_per v04
ON v01.mandant_id = v04.mandant_id
AND v01.wup_id     = v04.wup_id
AND v01.nb_id      = v04.nb_id
AND v01.art_id     = v04.art_id
AND v02.dat BETWEEN v04.dat_von AND v04.dat_bis
AND v04.prozess_id = 2;
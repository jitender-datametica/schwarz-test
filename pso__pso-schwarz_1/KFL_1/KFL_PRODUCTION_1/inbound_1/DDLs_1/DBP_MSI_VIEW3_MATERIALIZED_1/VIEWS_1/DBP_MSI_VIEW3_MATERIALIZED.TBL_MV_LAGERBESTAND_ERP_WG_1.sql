create or replace view DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_LAGERBESTAND_ERP_WG_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	LAGERORT_ID,
	WG_ID,
	DAT,
	ARTHIERTYP_ID,
	MENGE_LGBEST_ERP_FREI_BME,
	MENGE_LGBEST_ERP_UMLAG_BME,
	MENGE_LGBEST_ERP_QUAL_BME,
	MENGE_LGBEST_ERP_NF_CHARGE_BME,
	MENGE_LGBEST_ERP_GESP_BME,
	MENGE_LGBEST_ERP_RET_GESP_BME,
	MENGE_LGBEST_ERP_KOLLI,
	MENGE_LGBEST_ERP_PALETTE,
	BETRAG_LGBEST_ERP,
	MENGE_LGBEST_ERP_BME,
	WRG_ID,
	WRG_TYP_ID,
	VK_NETTO_LGBEST_ERP
) as
SELECT
    v01.mandant_id,
    v01.wup_id,
    v01.nb_id,
    v01.lagerort_id,
    v01.wg_id,
    v01.dat,
    v01.arthiertyp_id,
    v01.menge_lgbest_erp_frei_bme,
    v01.menge_lgbest_erp_umlag_bme,
    v01.menge_lgbest_erp_qual_bme,
    v01.menge_lgbest_erp_nf_charge_bme,
    v01.menge_lgbest_erp_gesp_bme,
    v01.menge_lgbest_erp_ret_gesp_bme,
    v01.menge_lgbest_erp_kolli,
    v01.menge_lgbest_erp_palette,
    CASE
        WHEN v03.wrg_typ_id = 0 THEN v01.betrag_lgbest_erp * v02.umrechnungskurs
        ELSE v01.betrag_lgbest_erp
    END AS betrag_lgbest_erp,
    CAST(
        (
            v01.menge_lgbest_erp_frei_bme + v01.menge_lgbest_erp_gesp_bme + v01.menge_lgbest_erp_qual_bme + v01.menge_lgbest_erp_ret_gesp_bme + v01.menge_lgbest_erp_umlag_bme
        ) AS DECIMAL (18, 3)
    ) AS menge_lgbest_erp_bme,
    v03.wrg_id,
    v03.wrg_typ_id,
    CASE
        WHEN v03.wrg_typ_id = 0 THEN (v01.vk_netto_lgbest_erp * v02.umrechnungskurs)
        ELSE v01.vk_netto_lgbest_erp
    END AS vk_netto_lgbest_erp
FROM
    dbp_view.v_lagerbestand_erp_wg_1 v01
    JOIN DBP_MSI_VIEW3_MATERIALIZED.mv_kurs_1 v02 ON v01.wrg_id = v02.von_wrg_id
    JOIN dbp_view.v_mandant_wrg_typ_zu_1 v03 ON v01.mandant_id = v03.mandant_id
    WHERE extract(year from v01.dat) >= year(current_timestamp) - 2;
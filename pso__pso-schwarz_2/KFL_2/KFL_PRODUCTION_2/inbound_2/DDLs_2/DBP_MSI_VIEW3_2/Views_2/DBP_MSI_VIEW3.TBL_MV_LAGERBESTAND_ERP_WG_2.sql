CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_LAGERBESTAND_ERP_WG_2 (
    mandant_id,
    wup_id,
    nb_id,
    lagerort_id,
    wg_id,
    dat,
    arthiertyp_id,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme,
    menge_lgbest_erp_kolli,
    menge_lgbest_erp_palette,
    betrag_lgbest_erp,
    menge_lgbest_erp_bme,
    wrg_id,
    wrg_typ_id,
    vk_netto_lgbest_erp
) AS
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
    dbp_view.v_lagerbestand_erp_wg_2 v01
    JOIN dbp_msi_view3.mv_kurs_2 v02 ON v01.wrg_id = v02.von_wrg_id
    JOIN dbp_view.v_mandant_wrg_typ_zu_2 v03 ON v01.mandant_id = v03.mandant_id
    WHERE extract(year from v01.dat) >= year(current_timestamp) - 2
;
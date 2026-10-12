CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGERBESTAND_ERP_WG (
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
-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

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
   betrag_lgbest_erp,
   menge_lgbest_erp_bme,
    v01.wrg_id,
    v01.wrg_typ_id,
vk_netto_lgbest_erp
FROM
    DBP_MSI_VIEW3.TBL_MV_LAGERBESTAND_ERP_WG v01
    JOIN dbp_msi_view3.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU v04 
    ON v01.wrg_typ_id = v04.wrg_typ_id;
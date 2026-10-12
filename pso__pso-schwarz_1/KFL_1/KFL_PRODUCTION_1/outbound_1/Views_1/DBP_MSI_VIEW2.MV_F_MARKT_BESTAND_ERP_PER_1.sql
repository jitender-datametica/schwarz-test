CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_f_markt_bestand_erp_per_1 (mandant_id, wup_id, nb_id, art_id,
stimmig_id, dat, wrg_id, gp_id, posten_id, ds_markt_bestand_menge_frei, ds_markt_bestand_menge_qual,
ds_markt_bestand_menge_gesperrt, ds_markt_bestand_menge_ges, ds_markt_bestand_ekn_frei, ds_markt_bestand_ekn_qual,
ds_markt_bestand_ekn_gesperrt, ds_markt_bestand_ekn_ges, ds_markt_bestand_ekn_bnk_frei, ds_markt_bestand_ekn_bnk_qual,
ds_markt_bestand_ekn_bnk_gesperrt, ds_markt_bestand_ekn_bnk_ges, ds_markt_bestand_klep_frei, ds_markt_bestand_klep_qual
, ds_markt_bestand_klep_gesperrt, ds_markt_bestand_klep_ges, ds_markt_bestand_mep_frei, ds_markt_bestand_mep_qual,
ds_markt_bestand_mep_gesperrt, ds_markt_bestand_mep_ges, ds_markt_bestand_vkn_frei, ds_markt_bestand_vkn_qual,
ds_markt_bestand_vkn_gesperrt, ds_markt_bestand_vkn_ges) AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 relevant_fg AS stimmig_id,
 dat,
 wrg_id,
 gp_id,
 posten_id,
 menge_lgbest_erp_frei_bme AS ds_markt_bestand_menge_frei,
 menge_lgbest_erp_qual_bme AS ds_markt_bestand_menge_qual,
 menge_lgbest_erp_gesp_bme AS ds_markt_bestand_menge_gesperrt,
 CAST(menge_lgbest_erp_frei_bme + menge_lgbest_erp_qual_bme + menge_lgbest_erp_gesp_bme AS BIGNUMERIC) AS
 ds_markt_bestand_menge_ges,
 CAST(betrag_ek_netto_lgbest_erp_frei AS BIGNUMERIC) AS ds_markt_bestand_ekn_frei,
 CAST(betrag_ek_netto_lgbest_erp_qual AS BIGNUMERIC) AS ds_markt_bestand_ekn_qual,
 ROUND(CAST(menge_lgbest_erp_gesp_bme * ek_netto AS BIGNUMERIC), 5) AS ds_markt_bestand_ekn_gesperrt,
 CAST(betrag_ek_netto_lgbest_erp_frei + betrag_ek_netto_lgbest_erp_qual + ROUND(CAST(menge_lgbest_erp_gesp_bme * ek_netto AS BIGNUMERIC)
    , 5) AS BIGNUMERIC) AS ds_markt_bestand_ekn_ges,
 CAST(betrag_ek_netto_bnk_lgbest_erp_frei AS BIGNUMERIC) AS ds_markt_bestand_ekn_bnk_frei,
 CAST(betrag_ek_netto_bnk_lgbest_erp_qual AS BIGNUMERIC) AS ds_markt_bestand_ekn_bnk_qual,
 ROUND(CAST(menge_lgbest_erp_gesp_bme * ek_netto_bnk AS BIGNUMERIC), 5) AS ds_markt_bestand_ekn_bnk_gesperrt,
 CAST(betrag_ek_netto_bnk_lgbest_erp_frei + betrag_ek_netto_bnk_lgbest_erp_qual + ROUND(CAST(menge_lgbest_erp_gesp_bme * ek_netto_bnk AS BIGNUMERIC)
    , 5) AS BIGNUMERIC) AS ds_markt_bestand_ekn_bnk_ges,
 CAST(betrag_ek_einstandspreis_lgbest_erp_frei AS BIGNUMERIC) AS ds_markt_bestand_klep_frei,
 CAST(betrag_ek_einstandspreis_lgbest_erp_qual AS BIGNUMERIC) AS ds_markt_bestand_klep_qual,
 ROUND(CAST(menge_lgbest_erp_gesp_bme * ek_einstandspreis AS BIGNUMERIC), 5) AS ds_markt_bestand_klep_gesperrt,
 CAST(betrag_ek_einstandspreis_lgbest_erp_frei + betrag_ek_einstandspreis_lgbest_erp_qual + ROUND(CAST(menge_lgbest_erp_gesp_bme * ek_einstandspreis AS BIGNUMERIC)
    , 5) AS BIGNUMERIC) AS ds_markt_bestand_klep_ges,
 CAST(betrag_ek_mep_olk_lgbest_erp_frei AS BIGNUMERIC) AS ds_markt_bestand_mep_frei,
 CAST(betrag_ek_mep_olk_lgbest_erp_qual AS BIGNUMERIC) AS ds_markt_bestand_mep_qual,
 ROUND(CAST(menge_lgbest_erp_gesp_bme * ek_mep_olk AS BIGNUMERIC), 5) AS ds_markt_bestand_mep_gesperrt,
 CAST(betrag_ek_mep_olk_lgbest_erp_frei + betrag_ek_mep_olk_lgbest_erp_qual + ROUND(CAST(menge_lgbest_erp_gesp_bme * ek_mep_olk AS BIGNUMERIC)
    , 5) AS BIGNUMERIC) AS ds_markt_bestand_mep_ges,
 CAST(betrag_vk_netto_lgbest_erp_frei AS BIGNUMERIC) AS ds_markt_bestand_vkn_frei,
 CAST(betrag_vk_netto_lgbest_erp_qual AS BIGNUMERIC) AS ds_markt_bestand_vkn_qual,
 ROUND(CAST(menge_lgbest_erp_gesp_bme * vk_netto AS BIGNUMERIC), 5) AS ds_markt_bestand_vkn_gesperrt,
 CAST(betrag_vk_netto_lgbest_erp_frei + betrag_vk_netto_lgbest_erp_qual + ROUND(CAST(menge_lgbest_erp_gesp_bme * vk_netto AS BIGNUMERIC)
    , 5) AS BIGNUMERIC) AS ds_markt_bestand_vkn_ges
FROM kfl_production_dbp_msi_data.marktbestand_erp_tag_sum_1 AS V01
WHERE mandant_id = 1
 AND nb_id = 0
 AND dat < CURRENT_DATE;
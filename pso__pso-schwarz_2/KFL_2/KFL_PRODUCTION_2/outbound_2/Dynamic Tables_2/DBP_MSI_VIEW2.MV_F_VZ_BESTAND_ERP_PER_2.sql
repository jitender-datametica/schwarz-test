CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_f_vz_bestand_erp_per_2
AS
SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 lagerort_id,
 0 AS stimming_id,
 dat,
 wrg_id,
 gp_id,
 posten_id,
 menge_lgbest_erp_frei_bme AS ds_vz_bestand_menge_frei,
 menge_lgbest_erp_qual_bme AS ds_vz_bestand_menge_qual,
 menge_lgbest_erp_gesamt_bme AS ds_vz_bestand_menge_ges,
 betrag_ek_netto_lgbest_erp_frei AS ds_vz_bestand_ekn_frei,
 betrag_ek_netto_lgbest_erp_qual AS ds_vz_bestand_ekn_qual,
  betrag_ek_netto_lgbest_erp_frei + betrag_ek_netto_lgbest_erp_qual AS ds_vz_bestand_ekn_ges,
 betrag_ek_netto_bnk_lgbest_erp_frei AS ds_vz_bestand_ekn_bnk_frei,
 betrag_ek_netto_bnk_lgbest_erp_qual AS ds_vz_bestand_ekn_bnk_qual,
  betrag_ek_netto_bnk_lgbest_erp_frei + betrag_ek_netto_bnk_lgbest_erp_qual AS ds_vz_bestand_ekn_bnk_ges,
 betrag_ek_einstandspreis_lgbest_erp_frei AS ds_vz_bestand_klep_frei,
 betrag_ek_einstandspreis_lgbest_erp_qual AS ds_vz_bestand_klep_qual,
  betrag_ek_einstandspreis_lgbest_erp_frei + betrag_ek_netto_lgbest_erp_qual AS ds_vz_bestand_klep_ges,
 betrag_ek_mep_olk_lgbest_erp_frei AS ds_vz_bestand_mep_frei,
 betrag_ek_mep_olk_lgbest_erp_qual AS ds_vz_bestand_mep_qual,
  betrag_ek_mep_olk_lgbest_erp_frei + betrag_ek_mep_olk_lgbest_erp_qual AS ds_vz_bestand_mep_ges,
 betrag_vk_netto_lgbest_erp_frei AS ds_vz_bestand_vkn_frei,
 betrag_vk_netto_lgbest_erp_qual AS ds_vz_bestand_vkn_qual,
 betrag_vk_netto_lgbest_erp_gesamt AS ds_vz_bestand_vkn_ges
FROM kfl_production_dbp_msi_v_view.v_lagerbestand_erp_tag_sum_2 AS T1_2
WHERE mandant_id = 1
 AND nb_id = -111
 AND dat < CURRENT_DATE;
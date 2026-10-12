CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_markt_bestand_erp_1 (mandant_id, wup_id, nb_id,
art_id, stimmig_id, dat, wrg_id, ds_markt_bestand_menge_frei, ds_markt_bestand_menge_qual, ds_markt_bestand_menge_ges,
ds_markt_bestand_ekn_frei, ds_markt_bestand_ekn_qual, ds_markt_bestand_ekn_ges, ds_markt_bestand_ekn_bnk_frei,
ds_markt_bestand_ekn_bnk_qual, ds_markt_bestand_ekn_bnk_ges, ds_markt_bestand_vkn_frei, ds_markt_bestand_vkn_qual,
ds_markt_bestand_vkn_ges) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V01.relevant_fg AS stimmig_id,
 V01.dat,
 V02.wrg_id,
 V01.menge_lgbest_erp_frei_bme AS ds_markt_bestand_menge_frei,
 V01.menge_lgbest_erp_qual_bme AS ds_markt_bestand_menge_qual,
 CAST(V01.menge_lgbest_erp_frei_bme + V01.menge_lgbest_erp_qual_bme AS NUMERIC) AS ds_markt_bestand_menge_ges,
 ROUND(CAST(V01.menge_lgbest_erp_frei_bme * V02.ek_netto AS NUMERIC), 5) AS ds_markt_bestand_ekn_frei,
 ROUND(CAST(V01.menge_lgbest_erp_qual_bme * V02.ek_netto AS NUMERIC), 5) AS ds_markt_bestand_ekn_qual,
 ROUND(CAST(CAST(V01.menge_lgbest_erp_frei_bme + V01.menge_lgbest_erp_qual_bme AS NUMERIC) * V02.ek_netto AS NUMERIC), 5
  ) AS ds_markt_bestand_ekn_ges,
 ROUND(CAST(V01.menge_lgbest_erp_frei_bme * V02.ek_netto_bnk AS NUMERIC), 5) AS ds_markt_bestand_ekn_bnk_frei,
 ROUND(CAST(V01.menge_lgbest_erp_qual_bme * V02.ek_netto_bnk AS NUMERIC), 5) AS ds_markt_bestand_ekn_bnk_qual,
 ROUND(CAST(CAST(V01.menge_lgbest_erp_frei_bme + V01.menge_lgbest_erp_qual_bme AS NUMERIC) * V02.ek_netto_bnk AS NUMERIC
   ), 5) AS ds_markt_bestand_ekn_bnk_ges,
 ROUND(CAST(V01.menge_lgbest_erp_frei_bme * V02.vk_netto AS NUMERIC), 5) AS ds_markt_bestand_vkn_frei,
 ROUND(CAST(V01.menge_lgbest_erp_qual_bme * V02.vk_netto AS NUMERIC), 5) AS ds_markt_bestand_vkn_qual,
 ROUND(CAST(CAST(V01.menge_lgbest_erp_frei_bme + V01.menge_lgbest_erp_qual_bme AS NUMERIC) * V02.vk_netto AS NUMERIC), 5
  ) AS ds_markt_bestand_vkn_ges
FROM kfl_production_dbp_view.v_marktbestand_erp_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_marktbestand_erp_zu_1 AS V02 ON V01.bestand_id = V02.bestand_id AND V01.mandant_id =
   V02.mandant_id
WHERE V01.mandant_id = 1;
-- 2022-07-12, AP0125093, SPEC0161886, dknop, replacing join to art_wup_ek_zu_per_1

CREATE OR REPLACE VIEW kfl_production_dbp_trans.mv_f_art_bestand_vw_sum_1 (mandant_id, art_id, stimmig_id, dat, gp_id,
wrg_id, ds_vz_bestand_menge_frei, ds_vz_bestand_menge_ges, ds_vz_bestand_menge_qual, ds_vz_bestand_klep_frei,
ds_vz_bestand_klep_ges, ds_vz_bestand_mep_frei, ds_vz_bestand_mep_ges, ds_vz_bestand_ekn_frei, ds_vz_bestand_ekn_ges,
ds_vz_bestand_ekn_bnk_frei, ds_vz_bestand_ekn_bnk_ges, ds_vz_bestand_vkn_frei, ds_vz_bestand_vkn_ges, vz_verbrauch_menge
, vz_verbrauch_klep, vz_verbrauch_mep, vz_verbrauch_ekn, vz_verbrauch_ekn_bnk, ds_markt_bestand_menge_frei,
ds_markt_bestand_menge_ges, ds_markt_bestand_menge_qual, ds_markt_bestand_klep_frei, ds_markt_bestand_klep_ges,
ds_markt_bestand_mep_frei, ds_markt_bestand_mep_ges, ds_markt_bestand_ekn_frei, ds_markt_bestand_ekn_ges,
ds_markt_bestand_ekn_bnk_frei, ds_markt_bestand_ekn_bnk_ges, ds_markt_bestand_vkn_frei, ds_markt_bestand_vkn_ges,
markt_verbrauch_menge, markt_verbrauch_klep, markt_verbrauch_mep, markt_verbrauch_ekn, markt_verbrauch_ekn_bnk) AS
SELECT T1.mandant_id,
 T1.art_id,
 T1.relevant_fg AS stimmig_id,
 T1.dat,
 T1.gp_id,
 T3.wrg_id,
 CAST(T1.menge_lgbest_erp_frei_bme * T1.lagerbestand_fg AS NUMERIC) AS ds_vz_bestand_menge_frei,
 CAST(T1.menge_lgbest_erp_gesamt_bme * T1.lagerbestand_fg AS NUMERIC) AS ds_vz_bestand_menge_ges,
 CAST(T1.menge_lgbest_erp_qual_bme * T1.lagerbestand_fg AS NUMERIC) AS ds_vz_bestand_menge_qual,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_frei_bme * T1.lagerbestand_fg AS NUMERIC) * T3.einstandspreis AS NUMERIC), 5) AS
 ds_vz_bestand_klep_frei,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_gesamt_bme * T1.lagerbestand_fg AS NUMERIC) * T3.einstandspreis AS NUMERIC), 5) AS
 ds_vz_bestand_klep_ges,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_frei_bme * T1.lagerbestand_fg AS NUMERIC) * T3.ek_mep AS NUMERIC), 5) AS
 ds_vz_bestand_mep_frei,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_gesamt_bme * T1.lagerbestand_fg AS NUMERIC) * T3.ek_mep AS NUMERIC), 5) AS
 ds_vz_bestand_mep_ges,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_frei_bme * T1.lagerbestand_fg AS NUMERIC) * T3.ek_netto AS NUMERIC), 5) AS
 ds_vz_bestand_ekn_frei,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_gesamt_bme * T1.lagerbestand_fg AS NUMERIC) * T3.ek_netto AS NUMERIC), 5) AS
 ds_vz_bestand_ekn_ges,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_frei_bme * T1.lagerbestand_fg AS NUMERIC) * T3.ek_netto_bnk AS NUMERIC), 5) AS
 ds_vz_bestand_ekn_bnk_frei,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_gesamt_bme * T1.lagerbestand_fg AS NUMERIC) * T3.ek_netto_bnk AS NUMERIC), 5) AS
 ds_vz_bestand_ekn_bnk_ges,
 CAST(T1.betrag_vk_netto_frei_bme * T1.lagerbestand_fg AS NUMERIC) AS ds_vz_bestand_vkn_frei,
 CAST(T1.betrag_vk_netto_gesamt_bme * T1.lagerbestand_fg AS NUMERIC) AS ds_bestand_vz_vkn_ges,
 CAST(T1.menge_abgang_bme * T1.lagerbestand_fg AS NUMERIC) AS vz_verbrauch_menge,
 ROUND(CAST(CAST(T1.menge_abgang_bme * T1.lagerbestand_fg AS NUMERIC) * T3.einstandspreis AS NUMERIC), 5) AS
 vz_verbrauch_klep,
 ROUND(CAST(CAST(T1.menge_abgang_bme * T1.lagerbestand_fg AS NUMERIC) * T3.ek_mep AS NUMERIC), 5) AS vz_verbrauch_mep,
 ROUND(CAST(CAST(T1.menge_abgang_bme * T1.lagerbestand_fg AS NUMERIC) * T3.ek_netto AS NUMERIC), 5) AS vz_verbrauch_ekn
 ,
 ROUND(CAST(CAST(T1.menge_abgang_bme * T1.lagerbestand_fg AS NUMERIC) * T3.ek_netto_bnk AS NUMERIC), 5) AS
 vz_verbrauch_ekn_bnk,
 CAST(T1.menge_lgbest_erp_frei_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) AS ds_markt_bestand_menge_frei,
 CAST(T1.menge_lgbest_erp_gesamt_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) AS ds_markt_bestand_menge_ges,
 CAST(T1.menge_lgbest_erp_qual_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) AS ds_markt_bestand_menge_qual,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_frei_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.einstandspreis AS NUMERIC
   ), 5) AS ds_markt_bestand_klep_frei,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_gesamt_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.einstandspreis AS
   NUMERIC), 5) AS ds_markt_bestand_klep_ges,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_frei_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.ek_mep AS NUMERIC), 5) AS
 ds_markt_bestand_mep_frei,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_gesamt_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.ek_mep AS NUMERIC), 5)
 AS ds_markt_bestand_mep_ges,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_frei_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.ek_netto AS NUMERIC), 5)
 AS ds_markt_bestand_ekn_frei,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_gesamt_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.ek_netto AS NUMERIC), 5
  ) AS ds_markt_bestand_ekn_ges,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_frei_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.ek_netto_bnk AS NUMERIC)
  , 5) AS ds_markt_bestand_ekn_bnk_frei,
 ROUND(CAST(CAST(T1.menge_lgbest_erp_gesamt_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.ek_netto_bnk AS NUMERIC
   ), 5) AS ds_markt_bestand_ekn_bnk_ges,
 CAST(T1.betrag_vk_netto_frei_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) AS ds_markt_bestand_vkn_frei,
 CAST(T1.betrag_vk_netto_gesamt_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) AS ds_markt_bestand_vkn_ges,
 CAST(T1.menge_abgang_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) AS markt_verbrauch_menge,
 ROUND(CAST(CAST(T1.menge_abgang_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.einstandspreis AS NUMERIC), 5) AS
 markt_verbrauch_klep,
 ROUND(CAST(CAST(T1.menge_abgang_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.ek_mep AS NUMERIC), 5) AS
 markt_verbrauch_mep,
 ROUND(CAST(CAST(T1.menge_abgang_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.ek_netto AS NUMERIC), 5) AS
 markt_verbrauch_ekn,
 ROUND(CAST(CAST(T1.menge_abgang_bme * (T1.lagerbestand_fg - 1) * -1 AS NUMERIC) * T3.ek_netto_bnk AS NUMERIC), 5) AS
 markt_verbrauch_ekn_bnk
FROM kfl_production_eval.art_bestand_vw_sum_1 AS T1_1
 INNER JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per_1 AS T3 ON T1.gp_id = T3.gp_id AND T1.art_id = T3.art_id AND T1.wup_id
      = T3.wup_id AND T1.mandant_id = T3.mandant_id AND T1.dat BETWEEN T3.dat_von AND T3.dat_bis
WHERE T1.mandant_id = 1;
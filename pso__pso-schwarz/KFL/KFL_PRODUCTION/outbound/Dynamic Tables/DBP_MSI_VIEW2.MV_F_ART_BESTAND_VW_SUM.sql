CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_f_art_bestand_vw_sum
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  t1.mandant_id AS mandant_id,
  t1.art_id AS art_id,
  t1.relevant_fg AS stimmig_id,
  t1.dat AS dat,
  t1.gp_id AS gp_id,
  t3.wrg_id AS wrg_id,
  CAST(t1.menge_lgbest_erp_frei_bme * t1.lagerbestand_fg AS BIGNUMERIC) AS ds_vz_bestand_menge_frei,
  CAST(t1.menge_lgbest_erp_gesamt_bme * t1.lagerbestand_fg AS BIGNUMERIC) AS ds_vz_bestand_menge_ges,
  CAST(t1.menge_lgbest_erp_qual_bme * t1.lagerbestand_fg AS BIGNUMERIC) AS ds_vz_bestand_menge_qual,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_frei_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.einstandspreis AS BIGNUMERIC),
    5
  ) AS ds_vz_bestand_klep_frei,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_gesamt_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.einstandspreis AS BIGNUMERIC),
    5
  ) AS ds_vz_bestand_klep_ges,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_frei_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.ek_mep AS BIGNUMERIC),
    5
  ) AS ds_vz_bestand_mep_frei,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_gesamt_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.ek_mep AS BIGNUMERIC),
    5
  ) AS ds_vz_bestand_mep_ges,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_frei_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.ek_netto AS BIGNUMERIC),
    5
  ) AS ds_vz_bestand_ekn_frei,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_gesamt_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.ek_netto AS BIGNUMERIC),
    5
  ) AS ds_vz_bestand_ekn_ges,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_frei_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.ek_netto_bnk AS BIGNUMERIC),
    5
  ) AS ds_vz_bestand_ekn_bnk_frei,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_gesamt_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.ek_netto_bnk AS BIGNUMERIC),
    5
  ) AS ds_vz_bestand_ekn_bnk_ges,
  CAST(t1.betrag_vk_netto_frei_bme * t1.lagerbestand_fg AS BIGNUMERIC) AS ds_vz_bestand_vkn_frei,
  CAST(t1.betrag_vk_netto_gesamt_bme * t1.lagerbestand_fg AS BIGNUMERIC) AS ds_vz_bestand_vkn_ges,
  CAST(t1.menge_abgang_bme * t1.lagerbestand_fg AS BIGNUMERIC) AS vz_verbrauch_menge,
  ROUND(
    CAST(CAST(t1.menge_abgang_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.einstandspreis AS BIGNUMERIC),
    5
  ) AS vz_verbrauch_klep,
  ROUND(
    CAST(CAST(t1.menge_abgang_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.ek_mep AS BIGNUMERIC),
    5
  ) AS vz_verbrauch_mep,
  ROUND(
    CAST(CAST(t1.menge_abgang_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.ek_netto AS BIGNUMERIC),
    5
  ) AS vz_verbrauch_ekn,
  ROUND(
    CAST(CAST(t1.menge_abgang_bme * t1.lagerbestand_fg AS BIGNUMERIC) * t3.ek_netto_bnk AS BIGNUMERIC),
    5
  ) AS vz_verbrauch_ekn_bnk,
  CAST(t1.menge_lgbest_erp_frei_bme * (
    t1.lagerbestand_fg - 1
  ) * -1 AS BIGNUMERIC) AS ds_markt_bestand_menge_frei,
  CAST(t1.menge_lgbest_erp_gesamt_bme * (
    t1.lagerbestand_fg - 1
  ) * -1 AS BIGNUMERIC) AS ds_markt_bestand_menge_ges,
  CAST(t1.menge_lgbest_erp_qual_bme * (
    t1.lagerbestand_fg - 1
  ) * -1 AS BIGNUMERIC) AS ds_markt_bestand_menge_qual,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_frei_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.einstandspreis AS BIGNUMERIC),
    5
  ) AS ds_markt_bestand_klep_frei,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_gesamt_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.einstandspreis AS BIGNUMERIC),
    5
  ) AS ds_markt_bestand_klep_ges,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_frei_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.ek_mep AS BIGNUMERIC),
    5
  ) AS ds_markt_bestand_mep_frei,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_gesamt_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.ek_mep AS BIGNUMERIC),
    5
  ) AS ds_markt_bestand_mep_ges,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_frei_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.ek_netto AS BIGNUMERIC),
    5
  ) AS ds_markt_bestand_ekn_frei,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_gesamt_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.ek_netto AS BIGNUMERIC),
    5
  ) AS ds_markt_bestand_ekn_ges,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_frei_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.ek_netto_bnk AS BIGNUMERIC),
    5
  ) AS ds_markt_bestand_ekn_bnk_frei,
  ROUND(
    CAST(CAST(t1.menge_lgbest_erp_gesamt_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.ek_netto_bnk AS BIGNUMERIC),
    5
  ) AS ds_markt_bestand_ekn_bnk_ges,
  CAST(t1.betrag_vk_netto_frei_bme * (
    t1.lagerbestand_fg - 1
  ) * -1 AS BIGNUMERIC) AS ds_markt_bestand_vkn_frei,
  CAST(t1.betrag_vk_netto_gesamt_bme * (
    t1.lagerbestand_fg - 1
  ) * -1 AS BIGNUMERIC) AS ds_markt_bestand_vkn_ges,
  CAST(t1.menge_abgang_bme * (
    t1.lagerbestand_fg - 1
  ) * -1 AS BIGNUMERIC) AS markt_verbrauch_menge,
  ROUND(
    CAST(CAST(t1.menge_abgang_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.einstandspreis AS BIGNUMERIC),
    5
  ) AS markt_verbrauch_klep,
  ROUND(
    CAST(CAST(t1.menge_abgang_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.ek_mep AS BIGNUMERIC),
    5
  ) AS markt_verbrauch_mep,
  ROUND(
    CAST(CAST(t1.menge_abgang_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.ek_netto AS BIGNUMERIC),
    5
  ) AS markt_verbrauch_ekn,
  ROUND(
    CAST(CAST(t1.menge_abgang_bme * (
      t1.lagerbestand_fg - 1
    ) * -1 AS BIGNUMERIC) * t3.ek_netto_bnk AS BIGNUMERIC),
    5
  ) AS markt_verbrauch_ekn_bnk
FROM kfl_production_dbp_view.v_art_bestand_vw_sum AS t1
INNER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS t2
  ON t1.art_id = t2.art_id
  AND t1.wup_id = t2.wup_id
  AND t1.mandant_id = t2.mandant_id
  AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
INNER JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per AS t3
  ON t2.gp_id = t3.gp_id
  AND t2.art_id = t3.art_id
  AND t2.wup_id = t3.wup_id
  AND t2.mandant_id = t3.mandant_id
  AND t1.dat BETWEEN t3.dat_von AND t3.dat_bis
WHERE
  t1.mandant_id = 1;

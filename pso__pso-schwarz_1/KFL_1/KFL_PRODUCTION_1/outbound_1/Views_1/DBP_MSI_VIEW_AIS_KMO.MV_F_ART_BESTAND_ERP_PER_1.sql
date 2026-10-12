CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_f_art_bestand_erp_per_1 (mandant_id, vw_id, art_id,
stimmig_id, dat, wrg_id, gp_id, ds_vz_bestand_menge_frei, ds_vz_bestand_menge_qual, ds_vz_bestand_menge_ges,
ds_vz_bestand_ekn2_frei, ds_vz_bestand_ekn2_qual, ds_vz_bestand_ekn2_ges, ds_vz_bestand_ekn4_frei,
ds_vz_bestand_ekn4_qual, ds_vz_bestand_ekn4_ges, ds_vz_bestand_vkn_frei, ds_vz_bestand_vkn_qual, ds_vz_bestand_vkn_ges,
vz_verbrauch_menge, vz_verbrauch_ekn2, vz_verbrauch_ekn4, ds_markt_bestand_menge_frei, ds_markt_bestand_menge_qual,
ds_markt_bestand_menge_ges, ds_markt_bestand_ekn2_frei, ds_markt_bestand_ekn2_qual, ds_markt_bestand_ekn2_ges,
ds_markt_bestand_ekn4_frei, ds_markt_bestand_ekn4_qual, ds_markt_bestand_ekn4_ges, ds_markt_bestand_vkn_frei,
ds_markt_bestand_vkn_qual, ds_markt_bestand_vkn_ges, markt_verbrauch_menge, markt_verbrauch_ekn2, markt_verbrauch_ekn4)
AS SELECT T01.mandant_id,
 T01.vw_id,
 T01.art_id,
 T01.relevant_fg AS stimmig_id,
 T01.dat,
  CASE
  WHEN T02.wrg_typ_id = 1
  THEN T01.wrg_id
  ELSE V03.nach_wrg_id
  END AS `_wrg_id`,
 T01.gp_id,
  T01.menge_lgbest_erp_frei_bme * T01.lagerbestand_fg AS ds_vz_bestand_menge_frei,
  T01.menge_lgbest_erp_qual_bme * T01.lagerbestand_fg AS ds_vz_bestand_menge_qual,
  T01.menge_lgbest_erp_gesamt_bme * T01.lagerbestand_fg AS ds_vz_bestand_menge_ges,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V03.umrechnungskurs * T01.lagerbestand_fg
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V04.umrechnungskurs * T01.lagerbestand_fg
    ELSE (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * T01.lagerbestand_fg
    END AS NUMERIC), 4) AS ds_vz_bestand_ekn2_frei,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V03.umrechnungskurs * T01.lagerbestand_fg
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V04.umrechnungskurs * T01.lagerbestand_fg
    ELSE (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * T01.lagerbestand_fg
    END AS NUMERIC), 4) AS ds_vz_bestand_ekn2_qual,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V03.umrechnungskurs * T01.lagerbestand_fg
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V04.umrechnungskurs * T01.lagerbestand_fg
    ELSE (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * T01.lagerbestand_fg
    END AS NUMERIC), 4) AS ds_vz_bestand_ekn2_ges,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V03.umrechnungskurs * T01.lagerbestand_fg
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V04.umrechnungskurs * T01.lagerbestand_fg
    ELSE (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * T01.lagerbestand_fg
    END AS NUMERIC), 4) AS ds_vz_bestand_ekn4_frei,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V03.umrechnungskurs * T01.lagerbestand_fg
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V04.umrechnungskurs * T01.lagerbestand_fg
    ELSE (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * T01.lagerbestand_fg
    END AS NUMERIC), 4) AS ds_vz_bestand_ekn4_qual,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V03.umrechnungskurs * T01.lagerbestand_fg
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V04.umrechnungskurs * T01.lagerbestand_fg
    ELSE (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * T01.lagerbestand_fg
    END AS NUMERIC), 4) AS ds_vz_bestand_ekn4_ges,
  CASE
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_vk_netto_frei_bme * T01.lagerbestand_fg * V03.umrechnungskurs
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_vk_netto_frei_bme * T01.lagerbestand_fg * V04.umrechnungskurs
  ELSE T01.betrag_vk_netto_frei_bme * T01.lagerbestand_fg
  END AS ds_vz_bestand_vkn_frei,
  CASE
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_vk_netto_qual_bme * T01.lagerbestand_fg * V03.umrechnungskurs
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_vk_netto_qual_bme * T01.lagerbestand_fg * V04.umrechnungskurs
  ELSE T01.betrag_vk_netto_qual_bme * T01.lagerbestand_fg
  END AS ds_vz_bestand_vkn_qual,
  CASE
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_vk_netto_gesamt_bme * T01.lagerbestand_fg * V03.umrechnungskurs
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_vk_netto_gesamt_bme * T01.lagerbestand_fg * V04.umrechnungskurs
  ELSE T01.betrag_vk_netto_gesamt_bme * T01.lagerbestand_fg
  END AS ds_vz_bestand_vkn_ges,
  COALESCE(T01.menge_abgang_bme, 0) * T01.lagerbestand_fg AS vz_verbrauch_menge,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.ek_nettonetto + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V03.umrechnungskurs * T01.lagerbestand_fg
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.ek_nettonetto + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V04.umrechnungskurs * T01.lagerbestand_fg
    ELSE (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.ek_nettonetto + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * T01.lagerbestand_fg
    END AS NUMERIC), 4) AS vz_verbrauch_ekn2,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.einstandspreis + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V03.umrechnungskurs * T01.lagerbestand_fg
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.einstandspreis + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V04.umrechnungskurs * T01.lagerbestand_fg
    ELSE (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.einstandspreis + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * T01.lagerbestand_fg
    END AS NUMERIC), 4) AS vz_verbrauch_ekn4,
  T01.menge_lgbest_erp_frei_bme * (1 - T01.lagerbestand_fg) AS ds_markt_bestand_menge_frei,
  T01.menge_lgbest_erp_qual_bme * (1 - T01.lagerbestand_fg) AS ds_markt_bestand_menge_qual,
  T01.menge_lgbest_erp_gesamt_bme * (1 - T01.lagerbestand_fg) AS ds_markt_bestand_menge_ges,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V03.umrechnungskurs * (1 - T01.lagerbestand_fg)
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V04.umrechnungskurs * (1 - T01.lagerbestand_fg)
    ELSE (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * (1 - T01.lagerbestand_fg)
    END AS NUMERIC), 4) AS ds_markt_bestand_ekn2_frei,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V03.umrechnungskurs * (1 - T01.lagerbestand_fg)
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V04.umrechnungskurs * (1 - T01.lagerbestand_fg)
    ELSE (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * (1 - T01.lagerbestand_fg)
    END AS NUMERIC), 4) AS ds_markt_bestand_ekn2_qual,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V03.umrechnungskurs * (1 - T01.lagerbestand_fg)
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V04.umrechnungskurs * (1 - T01.lagerbestand_fg)
    ELSE (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.ek_nettonetto + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * (1 - T01.lagerbestand_fg)
    END AS NUMERIC), 4) AS ds_markt_bestand_ekn2_ges,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V03.umrechnungskurs * (1 - T01.lagerbestand_fg)
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V04.umrechnungskurs * (1 - T01.lagerbestand_fg)
    ELSE (T01.betrag_vk_netto_frei_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_frei_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * (1 - T01.lagerbestand_fg)
    END AS NUMERIC), 4) AS ds_markt_bestand_ekn4_frei,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V03.umrechnungskurs * (1 - T01.lagerbestand_fg)
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V04.umrechnungskurs * (1 - T01.lagerbestand_fg)
    ELSE (T01.betrag_vk_netto_qual_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_qual_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * (1 - T01.lagerbestand_fg)
    END AS NUMERIC), 4) AS ds_markt_bestand_ekn4_qual,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V03.umrechnungskurs * (1 - T01.lagerbestand_fg)
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V04.umrechnungskurs * (1 - T01.lagerbestand_fg)
    ELSE (T01.betrag_vk_netto_gesamt_bme * T04.kein_zekp_fg * T04.einstandspreis + T01.menge_lgbest_erp_gesamt_bme * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * (1 - T01.lagerbestand_fg)
    END AS NUMERIC), 4) AS ds_markt_bestand_ekn4_ges,
  CASE
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_vk_netto_frei_bme * (1 - T01.lagerbestand_fg) * V03.umrechnungskurs
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_vk_netto_frei_bme * (1 - T01.lagerbestand_fg) * V04.umrechnungskurs
  ELSE T01.betrag_vk_netto_frei_bme * (1 - T01.lagerbestand_fg)
  END AS ds_markt_bestand_vkn_frei,
  CASE
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_vk_netto_qual_bme * (1 - T01.lagerbestand_fg) * V03.umrechnungskurs
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_vk_netto_qual_bme * (1 - T01.lagerbestand_fg) * V04.umrechnungskurs
  ELSE T01.betrag_vk_netto_qual_bme * (1 - T01.lagerbestand_fg)
  END AS ds_markt_bestand_vkn_qual,
  CASE
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_vk_netto_gesamt_bme * (1 - T01.lagerbestand_fg) * V03.umrechnungskurs
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_vk_netto_gesamt_bme * (1 - T01.lagerbestand_fg) * V04.umrechnungskurs
  ELSE T01.betrag_vk_netto_gesamt_bme * (1 - T01.lagerbestand_fg)
  END AS ds_markt_bestand_vkn_ges,
  COALESCE(T01.menge_abgang_bme, 0) * (1 - T01.lagerbestand_fg) AS markt_verbrauch_menge,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.ek_nettonetto + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V03.umrechnungskurs * (1 - T01.lagerbestand_fg)
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.ek_nettonetto + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * V04.umrechnungskurs * (1 - T01.lagerbestand_fg)
    ELSE (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.ek_nettonetto + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.ek_nettonetto) * (1 - T01.lagerbestand_fg)
    END AS NUMERIC), 4) AS markt_verbrauch_ekn2,
 ROUND(CAST(CASE
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
    THEN (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.einstandspreis + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V03.umrechnungskurs * (1 - T01.lagerbestand_fg)
    WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
    THEN (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.einstandspreis + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * V04.umrechnungskurs * (1 - T01.lagerbestand_fg)
    ELSE (COALESCE(T01.betrag_vk_netto_abgang, 0) * T04.kein_zekp_fg * T04.einstandspreis + COALESCE(T01.menge_abgang_bme, 0) * (1 - T04.kein_zekp_fg) * T04.einstandspreis) * (1 - T01.lagerbestand_fg)
    END AS NUMERIC), 4) AS markt_verbrauch_ekn4
FROM kfl_production_dbp_view.v_art_bestand_vw_sum_1 AS T01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS T02 ON T01.nb_id NOT IN (99, - 111)
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V03 ON T01.wrg_id = V03.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V04 ON T01.dat BETWEEN V04.dat_von AND V04.dat_bis AND T01.wrg_id = V04.von_wrg_id
   
 INNER JOIN kfl_production_dbp_view.v_art_wup_ek_zu_per_1 AS T04 ON T01.mandant_id = T04.mandant_id AND T01.art_id = T04.art_id
      AND T01.dat BETWEEN T04.dat_von AND T04.dat_bis AND T04.wup_id = - 1
WHERE V04.kurstyp_id = 3
 AND V04.nach_wrg_id = 'EUR'
 AND V03.dat_bis = DATE '9999-12-31'
 AND V03.kurstyp_id = 3
 AND V03.nach_wrg_id = 'EUR'
 AND T01.mandant_id <> 1;
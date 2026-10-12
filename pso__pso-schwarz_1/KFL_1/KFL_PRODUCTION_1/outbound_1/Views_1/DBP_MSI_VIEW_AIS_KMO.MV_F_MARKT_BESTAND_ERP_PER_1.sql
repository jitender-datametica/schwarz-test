CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_f_markt_bestand_erp_per_1 (mandant_id, wup_id, nb_id, art_id
, stimmig_id, dat, wrg_id, gp_id, posten_id, ds_markt_bestand_menge_frei, ds_markt_bestand_menge_qual,
ds_markt_bestand_menge_gesperrt, ds_markt_bestand_menge_ges, ds_markt_bestand_ekn2_frei, ds_markt_bestand_ekn2_qual,
ds_markt_bestand_ekn2_gesperrt, ds_markt_bestand_ekn2_ges, ds_markt_bestand_ekn4_frei, ds_markt_bestand_ekn4_qual,
ds_markt_bestand_ekn4_gesperrt, ds_markt_bestand_ekn4_ges, ds_markt_bestand_vkn_frei, ds_markt_bestand_vkn_qual,
ds_markt_bestand_vkn_gesperrt, ds_markt_bestand_vkn_ges) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V01.relevant_fg AS stimmig_id,
 V01.dat,
  CASE
  WHEN V03.wrg_typ_id = 1
  THEN V01.wrg_id
  ELSE 'EUR'
  END AS `_wrg_id`,
 V01.gp_id,
 V01.posten_id,
 V01.menge_lgbest_erp_frei_bme AS ds_markt_bestand_menge_frei,
 V01.menge_lgbest_erp_qual_bme AS ds_markt_bestand_menge_qual,
 V01.menge_lgbest_erp_gesp_bme AS ds_markt_bestand_menge_gesperrt,
 CAST(V01.menge_lgbest_erp_frei_bme + V01.menge_lgbest_erp_qual_bme + V01.menge_lgbest_erp_gesp_bme AS BIGNUMERIC) AS
 ds_markt_bestand_menge_ges,
 CAST(CASE
   WHEN V03.wrg_typ_id = 1
   THEN V01.betrag_ek_nettonetto_lgbest_erp_frei
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
   THEN V01.betrag_ek_nettonetto_lgbest_erp_frei_konz
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
   THEN V01.betrag_ek_nettonetto_lgbest_erp_frei * V01.umrechnungskurs_hist
   ELSE NULL
   END AS NUMERIC) AS ds_markt_bestand_ekn2_frei,
 CAST(CASE
   WHEN V03.wrg_typ_id = 1
   THEN V01.betrag_ek_nettonetto_lgbest_erp_qual
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
   THEN V01.betrag_ek_nettonetto_lgbest_erp_qual_konz
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
   THEN V01.betrag_ek_nettonetto_lgbest_erp_qual * V01.umrechnungskurs_hist
   ELSE NULL
   END AS NUMERIC) AS ds_markt_bestand_ekn2_qual,
 CAST(CASE
   WHEN V03.wrg_typ_id = 1
   THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_nettonetto
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
   THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_nettonetto_konz
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
   THEN V01.menge_lgbest_erp_gesp_bme * (V01.ek_nettonetto * V01.umrechnungskurs_hist)
   ELSE NULL
   END AS NUMERIC) AS ds_markt_bestand_ekn2_gesperrt,
 CAST(CAST(CASE
      WHEN V03.wrg_typ_id = 1
      THEN V01.betrag_ek_nettonetto_lgbest_erp_frei
      WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
      THEN V01.betrag_ek_nettonetto_lgbest_erp_frei_konz
      WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
      THEN V01.betrag_ek_nettonetto_lgbest_erp_frei * V01.umrechnungskurs_hist
      ELSE NULL
      END AS NUMERIC) + CAST(CASE
      WHEN V03.wrg_typ_id = 1
      THEN V01.betrag_ek_nettonetto_lgbest_erp_qual
      WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
      THEN V01.betrag_ek_nettonetto_lgbest_erp_qual_konz
      WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
      THEN V01.betrag_ek_nettonetto_lgbest_erp_qual * V01.umrechnungskurs_hist
      ELSE NULL
      END AS NUMERIC) + CAST(CASE
     WHEN V03.wrg_typ_id = 1
     THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_nettonetto
     WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
     THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_nettonetto_konz
     WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
     THEN V01.menge_lgbest_erp_gesp_bme * (V01.ek_nettonetto * V01.umrechnungskurs_hist)
     ELSE NULL
     END AS NUMERIC) AS NUMERIC) AS ds_markt_bestand_ekn2_ges,
 CAST(CASE
   WHEN V03.wrg_typ_id = 1
   THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
   THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei_konz
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
   THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei * V01.umrechnungskurs_hist
   ELSE NULL
   END AS NUMERIC) AS ds_markt_bestand_ekn4_frei,
 CAST(CASE
   WHEN V03.wrg_typ_id = 1
   THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
   THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual_konz
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
   THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual * V01.umrechnungskurs_hist
   ELSE NULL
   END AS NUMERIC) AS ds_markt_bestand_ekn4_qual,
 CAST(CASE
   WHEN V03.wrg_typ_id = 1
   THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_einstandspreis
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
   THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_einstandspreis_konz
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
   THEN V01.menge_lgbest_erp_gesp_bme * (V01.ek_einstandspreis * V01.umrechnungskurs_hist)
   ELSE NULL
   END AS NUMERIC) AS ds_markt_bestand_ekn4_gesperrt,
 CAST(CAST(CASE
      WHEN V03.wrg_typ_id = 1
      THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei
      WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
      THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei_konz
      WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
      THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei * V01.umrechnungskurs_hist
      ELSE NULL
      END AS NUMERIC) + CAST(CASE
      WHEN V03.wrg_typ_id = 1
      THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual
      WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
      THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual_konz
      WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
      THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual * V01.umrechnungskurs_hist
      ELSE NULL
      END AS NUMERIC) + CAST(CASE
     WHEN V03.wrg_typ_id = 1
     THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_einstandspreis
     WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
     THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_einstandspreis_konz
     WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
     THEN V01.menge_lgbest_erp_gesp_bme * (V01.ek_einstandspreis * V01.umrechnungskurs_hist)
     ELSE NULL
     END AS NUMERIC) AS NUMERIC) AS ds_markt_bestand_ekn4_ges,
 CAST(CASE
   WHEN V03.wrg_typ_id = 1
   THEN V01.betrag_vk_netto_lgbest_erp_frei
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
   THEN V01.betrag_vk_netto_lgbest_erp_frei_konz
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
   THEN V01.betrag_vk_netto_lgbest_erp_frei * V01.umrechnungskurs_hist
   ELSE NULL
   END AS BIGNUMERIC) AS ds_markt_bestand_vkn_frei,
 CAST(CASE
   WHEN V03.wrg_typ_id = 1
   THEN V01.betrag_vk_netto_lgbest_erp_qual
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
   THEN V01.betrag_vk_netto_lgbest_erp_qual_konz
   WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
   THEN V01.betrag_vk_netto_lgbest_erp_qual * V01.umrechnungskurs_hist
   ELSE NULL
   END AS BIGNUMERIC) AS ds_markt_bestand_vkn_qual,
 CAST(CASE
   WHEN V03.wrg_typ_id = 1
   THEN V01.menge_lgbest_erp_gesp_bme * V01.vk_netto
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
   THEN V01.menge_lgbest_erp_gesp_bme * V01.vk_netto_konz
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
   THEN V01.menge_lgbest_erp_gesp_bme * (V01.vk_netto * V01.umrechnungskurs_hist)
   ELSE NULL
   END AS BIGNUMERIC) AS ds_markt_bestand_vkn_gesperrt,
   CAST(CASE
     WHEN V03.wrg_typ_id = 1
     THEN V01.betrag_vk_netto_lgbest_erp_frei
     WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
     THEN V01.betrag_vk_netto_lgbest_erp_frei_konz
     WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
     THEN V01.betrag_vk_netto_lgbest_erp_frei * V01.umrechnungskurs_hist
     ELSE NULL
     END AS BIGNUMERIC) + CAST(CASE
     WHEN V03.wrg_typ_id = 1
     THEN V01.betrag_vk_netto_lgbest_erp_qual
     WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 0
     THEN V01.betrag_vk_netto_lgbest_erp_qual_konz
     WHEN V03.wrg_typ_id = 1 AND V03.berichtskurs_typ_id = 1
     THEN V01.betrag_vk_netto_lgbest_erp_qual * V01.umrechnungskurs_hist
     ELSE NULL
     END AS BIGNUMERIC) + CAST(CASE
    WHEN V03.wrg_typ_id = 1
    THEN V01.menge_lgbest_erp_gesp_bme * V01.vk_netto
    WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
    THEN V01.menge_lgbest_erp_gesp_bme * V01.vk_netto_konz
    WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
    THEN V01.menge_lgbest_erp_gesp_bme * (V01.vk_netto * V01.umrechnungskurs_hist)
    ELSE NULL
    END AS BIGNUMERIC) AS ds_markt_bestand_vkn_ges
FROM kfl_production_dbp_msi_data.marktbestand_erp_tag_sum_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V03 ON V01.dat < CURRENT_DATE
WHERE V01.mandant_id <> 1
 AND V01.nb_id = 0;
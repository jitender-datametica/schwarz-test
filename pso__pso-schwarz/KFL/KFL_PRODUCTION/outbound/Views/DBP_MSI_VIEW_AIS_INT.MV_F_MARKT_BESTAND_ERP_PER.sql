CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_f_markt_bestand_erp_per (mandant_id, wup_id, nb_id, art_id
, dat, gp_id, lagerort_id, ds_markt_bestand_menge_frei, ds_markt_bestand_menge_qual, ds_markt_bestand_menge_gesperrt,
ds_markt_bestand_menge_ges, ds_markt_bestand_ekn_frei, ds_markt_bestand_ekn_qual, ds_markt_bestand_ekn_gesperrt,
ds_markt_bestand_ekn_ges, ds_markt_bestand_klep_frei, ds_markt_bestand_klep_qual, ds_markt_bestand_klep_gesperrt,
ds_markt_bestand_klep_ges, ds_markt_bestand_mep_olk_frei, ds_markt_bestand_mep_olk_qual,
ds_markt_bestand_mep_olk_gesperrt, ds_markt_bestand_mep_olk_ges, ds_markt_bestand_vkn_frei, ds_markt_bestand_vkn_qual,
ds_markt_bestand_vkn_gesperrt, ds_markt_bestand_vkn_ges) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V01.dat,
 V01.gp_id,
 '0001' AS lagerort_id,
 V01.menge_lgbest_erp_frei_bme AS ds_markt_bestand_menge_frei,
 V01.menge_lgbest_erp_qual_bme AS ds_markt_bestand_menge_qual,
 V01.menge_lgbest_erp_gesp_bme AS ds_markt_bestand_menge_gesperrt,
  COALESCE(V01.menge_lgbest_erp_frei_bme, 0) + COALESCE(V01.menge_lgbest_erp_qual_bme, 0) AS ds_markt_bestand_menge_ges
 ,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.betrag_ek_netto_lgbest_erp_frei
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_ek_netto_lgbest_erp_frei_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.betrag_ek_netto_lgbest_erp_frei * V01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_markt_bestand_ekn_frei,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.betrag_ek_netto_lgbest_erp_qual
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_ek_netto_lgbest_erp_qual_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.betrag_ek_netto_lgbest_erp_qual * V01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_markt_bestand_ekn_qual,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_netto
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_netto_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.menge_lgbest_erp_gesp_bme * (V01.ek_netto * V01.umrechnungskurs_hist)
  ELSE NULL
  END AS ds_markt_bestand_ekn_gesperrt,
   COALESCE(CASE
     WHEN V02.wrg_typ_id = 1
     THEN V01.betrag_ek_netto_lgbest_erp_frei
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
     THEN V01.betrag_ek_netto_lgbest_erp_frei_konz
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
     THEN V01.betrag_ek_netto_lgbest_erp_frei * V01.umrechnungskurs_hist
     ELSE NULL
     END, 0) + COALESCE(CASE
     WHEN V02.wrg_typ_id = 1
     THEN V01.betrag_ek_netto_lgbest_erp_qual
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
     THEN V01.betrag_ek_netto_lgbest_erp_qual_konz
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
     THEN V01.betrag_ek_netto_lgbest_erp_qual * V01.umrechnungskurs_hist
     ELSE NULL
     END, 0) + COALESCE(V01.menge_lgbest_erp_gesp_bme, 0) AS ds_markt_bestand_ekn_ges,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei * V01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_markt_bestand_klep_frei,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual * V01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_markt_bestand_klep_qual,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_einstandspreis
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_einstandspreis_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.menge_lgbest_erp_gesp_bme * (V01.ek_einstandspreis * V01.umrechnungskurs_hist)
  ELSE NULL
  END AS ds_markt_bestand_klep_gesperrt,
   COALESCE(CASE
     WHEN V02.wrg_typ_id = 1
     THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
     THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei_konz
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
     THEN V01.betrag_ek_einstandspreis_lgbest_erp_frei * V01.umrechnungskurs_hist
     ELSE NULL
     END, 0) + COALESCE(CASE
     WHEN V02.wrg_typ_id = 1
     THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
     THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual_konz
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
     THEN V01.betrag_ek_einstandspreis_lgbest_erp_qual * V01.umrechnungskurs_hist
     ELSE NULL
     END, 0) + COALESCE(CASE
    WHEN V02.wrg_typ_id = 1
    THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_netto
    WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
    THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_netto_konz
    WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
    THEN V01.menge_lgbest_erp_gesp_bme * (V01.ek_netto * V01.umrechnungskurs_hist)
    ELSE NULL
    END, 0) AS ds_markt_bestand_klep_ges,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.betrag_ek_mep_olk_lgbest_erp_frei
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_ek_mep_olk_lgbest_erp_frei_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.betrag_ek_mep_olk_lgbest_erp_frei * V01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_markt_bestand_mep_olk_frei,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.betrag_ek_mep_olk_lgbest_erp_qual
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_ek_mep_olk_lgbest_erp_qual_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.betrag_ek_mep_olk_lgbest_erp_qual * V01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_markt_bestand_mep_olk_qual,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_mep_olk
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_mep_olk_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.menge_lgbest_erp_gesp_bme * (V01.ek_mep_olk * V01.umrechnungskurs_hist)
  ELSE NULL
  END AS ds_markt_bestand_mep_olk_gesperrt,
   COALESCE(CASE
     WHEN V02.wrg_typ_id = 1
     THEN V01.betrag_ek_mep_olk_lgbest_erp_frei
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
     THEN V01.betrag_ek_mep_olk_lgbest_erp_frei_konz
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
     THEN V01.betrag_ek_mep_olk_lgbest_erp_frei * V01.umrechnungskurs_hist
     ELSE NULL
     END, 0) + COALESCE(CASE
     WHEN V02.wrg_typ_id = 1
     THEN V01.betrag_ek_mep_olk_lgbest_erp_qual
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
     THEN V01.betrag_ek_mep_olk_lgbest_erp_qual_konz
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
     THEN V01.betrag_ek_mep_olk_lgbest_erp_qual * V01.umrechnungskurs_hist
     ELSE NULL
     END, 0) + COALESCE(CASE
    WHEN V02.wrg_typ_id = 1
    THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_mep_olk
    WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
    THEN V01.menge_lgbest_erp_gesp_bme * V01.ek_mep_olk_konz
    WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
    THEN V01.menge_lgbest_erp_gesp_bme * (V01.ek_mep_olk * V01.umrechnungskurs_hist)
    ELSE NULL
    END, 0) AS ds_markt_bestand_mep_olk_ges,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.betrag_vk_netto_lgbest_erp_frei
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_vk_netto_lgbest_erp_frei_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.betrag_vk_netto_lgbest_erp_frei * V01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_markt_bestand_vkn_frei,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.betrag_vk_netto_lgbest_erp_qual
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_vk_netto_lgbest_erp_qual_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.betrag_vk_netto_lgbest_erp_qual * V01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_markt_bestand_vkn_qual,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.menge_lgbest_erp_gesp_bme * V01.vk_netto
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.menge_lgbest_erp_gesp_bme * V01.vk_netto_konz
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.menge_lgbest_erp_gesp_bme * (V01.vk_netto * V01.umrechnungskurs_hist)
  ELSE NULL
  END AS ds_markt_bestand_vkn_gesperrt,
   COALESCE(CASE
     WHEN V02.wrg_typ_id = 1
     THEN V01.betrag_vk_netto_lgbest_erp_frei
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
     THEN V01.betrag_vk_netto_lgbest_erp_frei_konz
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
     THEN V01.betrag_vk_netto_lgbest_erp_frei * V01.umrechnungskurs_hist
     ELSE NULL
     END, 0) + COALESCE(CASE
     WHEN V02.wrg_typ_id = 1
     THEN V01.betrag_vk_netto_lgbest_erp_qual
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
     THEN V01.betrag_vk_netto_lgbest_erp_qual_konz
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
     THEN V01.betrag_vk_netto_lgbest_erp_qual * V01.umrechnungskurs_hist
     ELSE NULL
     END, 0) + COALESCE(CASE
    WHEN V02.wrg_typ_id = 1
    THEN V01.menge_lgbest_erp_gesp_bme * V01.vk_netto
    WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
    THEN V01.menge_lgbest_erp_gesp_bme * V01.vk_netto_konz
    WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
    THEN V01.menge_lgbest_erp_gesp_bme * (V01.vk_netto * V01.umrechnungskurs_hist)
    ELSE NULL
    END, 0) AS ds_markt_bestand_vkn_ges
FROM kfl_production_dbp_msi_data.marktbestand_erp_tag_sum AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V02 ON V01.dat < CURRENT_DATE
WHERE V01.nb_id = 0;
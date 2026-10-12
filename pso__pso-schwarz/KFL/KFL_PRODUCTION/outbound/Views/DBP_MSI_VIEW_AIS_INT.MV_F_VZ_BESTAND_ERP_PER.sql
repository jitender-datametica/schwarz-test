CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_f_vz_bestand_erp_per (mandant_id, wup_id, nb_id, art_id,
lagerort_id, dat, gp_id, ds_vz_bestand_menge_frei, ds_vz_bestand_menge_qual, ds_vz_bestand_menge_ges,
ds_vz_bestand_ekn_frei, ds_vz_bestand_ekn_qual, ds_vz_bestand_ekn_ges, ds_vz_bestand_klep_frei, ds_vz_bestand_klep_qual
, ds_vz_bestand_klep_ges, ds_vz_bestand_mep_olk_frei, ds_vz_bestand_mep_olk_qual, ds_vz_bestand_mep_olk_ges,
ds_vz_bestand_vkn_frei, ds_vz_bestand_vkn_qual, ds_vz_bestand_vkn_ges) AS SELECT T1.mandant_id,
 T1.wup_id,
 T1.nb_id,
 T1.art_id,
 T1.lagerort_id,
 T1.dat,
 T1.gp_id,
 T1.menge_lgbest_erp_frei_bme AS ds_vz_bestand_menge_frei,
 T1.menge_lgbest_erp_qual_bme AS ds_vz_bestand_menge_qual,
 T1.menge_lgbest_erp_gesamt_bme AS ds_vz_bestand_menge_ges,
  CASE
  WHEN T2.wrg_typ_id = 1
  THEN T1.betrag_ek_netto_lgbest_erp_frei
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
  THEN T1.betrag_ek_netto_lgbest_erp_frei_konz
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
  THEN T1.betrag_ek_netto_lgbest_erp_frei * T1.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_ekn_frei,
  CASE
  WHEN T2.wrg_typ_id = 1
  THEN T1.betrag_ek_netto_lgbest_erp_qual
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
  THEN T1.betrag_ek_netto_lgbest_erp_qual_konz
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
  THEN T1.betrag_ek_netto_lgbest_erp_qual * T1.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_ekn_qual,
  COALESCE(CASE
    WHEN T2.wrg_typ_id = 1
    THEN T1.betrag_ek_netto_lgbest_erp_frei
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
    THEN T1.betrag_ek_netto_lgbest_erp_frei_konz
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
    THEN T1.betrag_ek_netto_lgbest_erp_frei * T1.umrechnungskurs_hist
    ELSE NULL
    END, 0) + COALESCE(CASE
    WHEN T2.wrg_typ_id = 1
    THEN T1.betrag_ek_netto_lgbest_erp_qual
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
    THEN T1.betrag_ek_netto_lgbest_erp_qual_konz
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
    THEN T1.betrag_ek_netto_lgbest_erp_qual * T1.umrechnungskurs_hist
    ELSE NULL
    END, 0) AS ds_vz_bestand_ekn_ges,
  CASE
  WHEN T2.wrg_typ_id = 1
  THEN T1.betrag_ek_einstandspreis_lgbest_erp_frei
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
  THEN T1.betrag_ek_einstandspreis_lgbest_erp_frei_konz
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
  THEN T1.betrag_ek_einstandspreis_lgbest_erp_frei * T1.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_klep_frei,
  CASE
  WHEN T2.wrg_typ_id = 1
  THEN T1.betrag_ek_einstandspreis_lgbest_erp_qual
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
  THEN T1.betrag_ek_einstandspreis_lgbest_erp_qual_konz
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
  THEN T1.betrag_ek_einstandspreis_lgbest_erp_qual * T1.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_klep_qual,
  COALESCE(CASE
    WHEN T2.wrg_typ_id = 1
    THEN T1.betrag_ek_einstandspreis_lgbest_erp_frei
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
    THEN T1.betrag_ek_einstandspreis_lgbest_erp_frei_konz
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
    THEN T1.betrag_ek_einstandspreis_lgbest_erp_frei * T1.umrechnungskurs_hist
    ELSE NULL
    END, 0) + COALESCE(CASE
    WHEN T2.wrg_typ_id = 1
    THEN T1.betrag_ek_einstandspreis_lgbest_erp_qual
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
    THEN T1.betrag_ek_einstandspreis_lgbest_erp_qual_konz
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
    THEN T1.betrag_ek_einstandspreis_lgbest_erp_qual * T1.umrechnungskurs_hist
    ELSE NULL
    END, 0) AS ds_vz_bestand_klep_ges,
  CASE
  WHEN T2.wrg_typ_id = 1
  THEN T1.betrag_ek_mep_olk_lgbest_erp_frei
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
  THEN T1.betrag_ek_mep_olk_lgbest_erp_frei_konz
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
  THEN T1.betrag_ek_mep_olk_lgbest_erp_frei * T1.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_mep_olk_frei,
  CASE
  WHEN T2.wrg_typ_id = 1
  THEN T1.betrag_ek_mep_olk_lgbest_erp_qual
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
  THEN T1.betrag_ek_mep_olk_lgbest_erp_qual_konz
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
  THEN T1.betrag_ek_mep_olk_lgbest_erp_qual * T1.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_mep_olk_qual,
  COALESCE(CASE
    WHEN T2.wrg_typ_id = 1
    THEN T1.betrag_ek_mep_olk_lgbest_erp_frei
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
    THEN T1.betrag_ek_mep_olk_lgbest_erp_frei_konz
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
    THEN T1.betrag_ek_mep_olk_lgbest_erp_frei * T1.umrechnungskurs_hist
    ELSE NULL
    END, 0) + COALESCE(CASE
    WHEN T2.wrg_typ_id = 1
    THEN T1.betrag_ek_mep_olk_lgbest_erp_qual
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
    THEN T1.betrag_ek_mep_olk_lgbest_erp_qual_konz
    WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
    THEN T1.betrag_ek_mep_olk_lgbest_erp_qual * T1.umrechnungskurs_hist
    ELSE NULL
    END, 0) AS ds_vz_bestand_mep_olk_ges,
  CASE
  WHEN T2.wrg_typ_id = 1
  THEN T1.betrag_vk_netto_lgbest_erp_frei
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
  THEN T1.betrag_vk_netto_lgbest_erp_frei_konz
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
  THEN T1.betrag_vk_netto_lgbest_erp_frei * T1.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_vkn_frei,
  CASE
  WHEN T2.wrg_typ_id = 1
  THEN T1.betrag_vk_netto_lgbest_erp_qual
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
  THEN T1.betrag_vk_netto_lgbest_erp_qual_konz
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
  THEN T1.betrag_vk_netto_lgbest_erp_qual * T1.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_vkn_qual,
  CASE
  WHEN T2.wrg_typ_id = 1
  THEN T1.betrag_vk_netto_lgbest_erp_gesamt
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 0
  THEN T1.betrag_vk_netto_lgbest_erp_gesamt_konz
  WHEN T2.wrg_typ_id = 0 AND T2.berichtskurs_typ_id = 1
  THEN T1.betrag_vk_netto_lgbest_erp_gesamt * T1.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_vkn_ges
FROM kfl_production_dbp_msi_v_view.v_lagerbestand_erp_tag_sum AS T1
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS T2 ON T1.nb_id = - 111 AND T1.dat < CURRENT_DATE;
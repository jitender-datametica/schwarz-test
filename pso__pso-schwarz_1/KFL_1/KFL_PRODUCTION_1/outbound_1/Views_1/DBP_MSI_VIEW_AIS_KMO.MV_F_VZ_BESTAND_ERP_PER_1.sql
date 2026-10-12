CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_f_vz_bestand_erp_per_1 (mandant_id, wup_id, nb_id, art_id,
lagerort_id, stimmig_id, dat, wrg_id, gp_id, posten_id, ds_vz_bestand_menge_frei, ds_vz_bestand_menge_qual,
ds_vz_bestand_menge_ges, ds_vz_bestand_ekn2_frei, ds_vz_bestand_ekn2_qual, ds_vz_bestand_ekn2_ges,
ds_vz_bestand_ekn4_frei, ds_vz_bestand_ekn4_qual, ds_vz_bestand_ekn4_ges, ds_vz_bestand_vkn_frei, ds_vz_bestand_vkn_qual
, ds_vz_bestand_vkn_ges) AS SELECT T01.mandant_id,
 T01.wup_id,
 T01.nb_id,
 T01.art_id,
 T01.lagerort_id,
 0 AS stimmig_id,
 T01.dat,
  CASE
  WHEN T02.wrg_typ_id = 1
  THEN T01.wrg_id
  ELSE 'EUR'
  END AS `_wrg_id`,
 T01.gp_id,
 T01.posten_id,
 T01.menge_lgbest_erp_frei_bme AS ds_vz_bestand_menge_frei,
 T01.menge_lgbest_erp_qual_bme AS ds_vz_bestand_menge_qual,
 T01.menge_lgbest_erp_gesamt_bme AS ds_vz_bestand_menge_ges,
  CASE
  WHEN T02.wrg_typ_id = 1
  THEN T01.betrag_ek_nettonetto_lgbest_erp_frei
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_ek_nettonetto_lgbest_erp_frei_konz
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_ek_nettonetto_lgbest_erp_frei * T01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_ekn2_frei,
  CASE
  WHEN T02.wrg_typ_id = 1
  THEN T01.betrag_ek_nettonetto_lgbest_erp_qual
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_ek_nettonetto_lgbest_erp_qual_konz
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_ek_nettonetto_lgbest_erp_qual * T01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_ekn2_qual,
  CASE
  WHEN T02.wrg_typ_id = 1
  THEN T01.menge_lgbest_erp_gesamt_bme * T01.ek_nettonetto
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.menge_lgbest_erp_gesamt_bme * T01.ek_nettonetto_konz
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.menge_lgbest_erp_gesamt_bme * T01.ek_nettonetto * T01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_ekn2_ges,
  CASE
  WHEN T02.wrg_typ_id = 1
  THEN T01.betrag_ek_einstandspreis_lgbest_erp_frei
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_ek_einstandspreis_lgbest_erp_frei_konz
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_ek_einstandspreis_lgbest_erp_frei * T01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_ekn4_frei,
  CASE
  WHEN T02.wrg_typ_id = 1
  THEN T01.betrag_ek_einstandspreis_lgbest_erp_qual
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_ek_einstandspreis_lgbest_erp_qual_konz
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_ek_einstandspreis_lgbest_erp_qual * T01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_ekn4_qual,
  CASE
  WHEN T02.wrg_typ_id = 1
  THEN T01.menge_lgbest_erp_gesamt_bme * T01.ek_einstandspreis
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.menge_lgbest_erp_gesamt_bme * T01.ek_einstandspreis_konz
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.menge_lgbest_erp_gesamt_bme * T01.ek_einstandspreis * T01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_ekn4_ges,
  CASE
  WHEN T02.wrg_typ_id = 1
  THEN T01.betrag_vk_netto_lgbest_erp_frei
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_vk_netto_lgbest_erp_frei_konz
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_vk_netto_lgbest_erp_frei * T01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_vkn_frei,
  CASE
  WHEN T02.wrg_typ_id = 1
  THEN T01.betrag_vk_netto_lgbest_erp_qual
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_vk_netto_lgbest_erp_qual_konz
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_vk_netto_lgbest_erp_qual * T01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_vkn_qual,
  CASE
  WHEN T02.wrg_typ_id = 1
  THEN T01.betrag_vk_netto_lgbest_erp_gesamt
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 0
  THEN T01.betrag_vk_netto_lgbest_erp_gesamt_konz
  WHEN T02.wrg_typ_id = 0 AND T02.berichtskurs_typ_id = 1
  THEN T01.betrag_vk_netto_lgbest_erp_gesamt * T01.umrechnungskurs_hist
  ELSE NULL
  END AS ds_vz_bestand_vkn_ges
FROM kfl_production_dbp_msi_v_view.v_lagerbestand_erp_tag_sum_1 AS T01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS T02 ON T01.nb_id = - 111 AND T01.dat < CURRENT_DATE
WHERE T01.mandant_id <> 1;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_artbew_1 (dat, art_id, mandant_id, gp_id, nb_id, wup_id,
bewart_id, bewart_det_id, bq_findung_id, bezugsweg_id, aktion_id, posten_id_per, posten_kz_per, wrg_1, herst_id,
wup_bereinigt_fg, wup_bereinigt_fg_vj, wup_bereinigt_fg_vj_wo, mwst_id, umsatz_mwst_betrag, umsatz_netto, vk_menge,
vk_menge_norm, ek_brutto_absatz, ek_netto_absatz, ek_nettobnk_absatz, ek_netto2_absatz, ek_netto3_absatz,
ek_netto4_absatz, ek_netto4_absatz_einstandspreis, ek_gld_absatz, umsatz_mwst_betrag_af, umsatz_netto_af, vk_menge_af,
vk_menge_af_norm, ek_brutto_absatz_af, ek_netto_absatz_af, ek_nettobnk_absatz_af, ek_netto2_absatz_af,
ek_netto3_absatz_af, ek_netto4_absatz_af, ek_netto4_absatz_af_einstandspreis, ek_gld_absatz_af, umsatz_mwst_betrag_sa,
umsatz_netto_sa, vk_menge_sa, vk_menge_sa_norm, ek_brutto_absatz_sa, ek_netto_absatz_sa, ek_nettobnk_absatz_sa,
ek_netto2_absatz_sa, ek_netto3_absatz_sa, ek_netto4_absatz_sa, ek_netto4_absatz_sa_einstandspreis, ek_gld_absatz_sa,
ean_kasse, logkostenzuschlag, umsatz_af_non_loyalty, umsatz_af_loyalty,
umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby, umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
umsatz_af_exkl_schwarz_media_u_bonrabatt_bby, umsatz_af_loyalty_schwarz_media, umsatz_sa_non_loyalty, umsatz_sa_loyalty
, umsatz_bby_non_loyalty, umsatz_bby_loyalty, umsatz_kdn_bby_loyalty, umsatz_kdp_bby_loyalty,
umsatz_bonrabatt_bby_non_loyalty, umsatz_bonrabatt_bby_loyalty, umsatz_bonrabatt_bby, vk_menge_af_non_loyalty,
vk_menge_af_loyalty, vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby, vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
vk_menge_af_loyalty_schwarz_media, vk_menge_sa_non_loyalty, vk_menge_sa_loyalty, vk_menge_bby_non_loyalty,
vk_menge_bby_loyalty, vk_menge_kdn_bby_loyalty, vk_menge_kdp_bby_loyalty, vk_menge_bonrabatt_bby_non_loyalty,
vk_menge_bonrabatt_bby_loyalty, vk_menge_bonrabatt_bby, pv_aktion_sa_loyalty, pv_aktion_sa_loyalty_bby,
pv_aktion_sa_loyalty_kdn_bby, pv_aktion_sa_loyalty_kdp_bby, pv_aktion_sa_non_loyalty, pv_aktion_sa_non_loyalty_bby,
pv_bby_loyalty, pv_bby_non_loyalty, pv_kdn_bby_loyalty, pv_kdp_bby_loyalty, pv_bonrabatt_bby_non_loyalty,
pv_bonrabatt_bby_loyalty, pv_bonrabatt_bby, bonusbasis, bonusbasis_af, bonusbasis_sa, ek_mepol, ek_mepol_af, ek_mepol_sa
, werbeabschrift_pv, werbeabschrift_werbenachvermarktung_manuell, werbeabschrift_aktionsanpassung_filiale,
werbeabschrift_rest, aktionsart_liste_id, aktion_typ_liste_id) AS SELECT V01.dat,
 V01.art_id,
 V01.mandant_id,
 V01.gp_id,
 V01.nb_id,
 V01.wup_id,
 V01.bewart_id,
 V01.bewart_det_id,
 V01.bq_findung_id,
 V01.bezugsweg_id,
 COALESCE(V01.standard_aktion_id, V01.aktion_id, '0') AS aktion_id,
 CAST(CASE
   WHEN V01.bewart_id = 1001 AND V01.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END AS STRING) AS posten_id_per,
 CAST(CASE
   WHEN V01.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END AS STRING) AS posten_kz_per,
 V01.wrg_1,
 V01.herst_id,
 V05.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
 V05.wup_bereinigt_fg_vj,
 V05.wup_bereinigt_fg_vj_wo,
 V01.mwst_id,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
  END AS umsatz_mwst_betrag,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.umsatz_netto AS BIGNUMERIC)
  END AS umsatz_netto,
 CAST(V01.menge AS BIGNUMERIC) AS vk_menge,
  CASE
  WHEN V01.mandant_id = 1 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'G'
  THEN V01.menge * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'KG'
  THEN V01.menge * V03.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'ML'
  THEN V01.menge * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'L'
  THEN V01.menge * V03.faktor_nettoinhalt
  WHEN V01.mandant_id > 1 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'G'
  THEN V01.menge * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'KG'
  THEN V01.menge * V03.inhalt_menge
  WHEN V01.mandant_id > 1 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'ML'
  THEN V01.menge * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'L'
  THEN V01.menge * V03.inhalt_menge
  WHEN V03.basismenge_einh_id = 'KG'
  THEN V01.menge
  ELSE 0
  END AS vk_menge_norm,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_ek_brutto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.ek_brutto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_brutto AS BIGNUMERIC)
  END AS ek_brutto_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_ek_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.ek_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_netto AS BIGNUMERIC)
  END AS ek_netto_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_ek_netto_bnk_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.ek_netto_bnk * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_netto_bnk AS BIGNUMERIC)
  END AS ek_nettobnk_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_ek_nettonetto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.ek_nettonetto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_nettonetto AS BIGNUMERIC)
  END AS ek_netto2_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_ek_mep_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_mep AS BIGNUMERIC)
  END AS ek_netto3_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_einstandspreis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 OR V02.wrg_typ_id = 1 AND V01.mandant_id = 1
  THEN CAST(V01.ek_mep AS BIGNUMERIC)
  ELSE CAST(V01.einstandspreis AS BIGNUMERIC)
  END AS ek_netto4_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_einstandspreis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.einstandspreis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.einstandspreis AS BIGNUMERIC)
  END AS ek_netto4_absatz_einstandspreis,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_ek_gld_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.ek_gld * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_gld AS BIGNUMERIC)
  END AS ek_gld_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
      IN (1001, 1010)
  THEN CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_mwst_betrag_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
      IN (1001, 1010)
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_netto_af,
  CASE
  WHEN V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE NULL
  END AS vk_menge_af,
  CASE
  WHEN V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'G'
  THEN V01.menge * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'KG'
  THEN V01.menge * V03.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'ML'
  THEN V01.menge * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'L'
  THEN V01.menge * V03.faktor_nettoinhalt
  WHEN V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010) AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id
     = 'G'
  THEN V01.menge * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010) AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id
     = 'KG'
  THEN V01.menge * V03.inhalt_menge
  WHEN V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010) AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id
     = 'ML'
  THEN V01.menge * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010) AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id
     = 'L'
  THEN V01.menge * V03.inhalt_menge
  WHEN V01.bewart_id IN (1001, 1010) AND V03.basismenge_einh_id = 'KG'
  THEN V01.menge
  ELSE 0
  END AS vk_menge_af_norm,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_brutto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_brutto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
      IN (1001, 1010)
  THEN CAST(V01.ek_brutto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_brutto_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
      IN (1001, 1010)
  THEN CAST(V01.ek_netto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_netto_bnk_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_netto_bnk * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
      IN (1001, 1010)
  THEN CAST(V01.ek_netto_bnk AS BIGNUMERIC)
  ELSE NULL
  END AS ek_nettobnk_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_nettonetto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_nettonetto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
      IN (1001, 1010)
  THEN CAST(V01.ek_nettonetto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto2_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_mep_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
      IN (1001, 1010)
  THEN CAST(V01.ek_mep AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto3_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_einstandspreis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.mandant_id
       = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.ek_mep AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.einstandspreis AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto4_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_einstandspreis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.einstandspreis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.mandant_id
        = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001,
      1010)
  THEN CAST(V01.einstandspreis AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto4_absatz_af_einstandspreis,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_gld_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_gld * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
      IN (1001, 1010)
  THEN CAST(V01.ek_gld AS BIGNUMERIC)
  ELSE NULL
  END AS ek_gld_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_mwst_betrag_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_netto_sa,
  CASE
  WHEN V01.bewart_id = 1002
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE NULL
  END AS vk_menge_sa,
  CASE
  WHEN V01.mandant_id = 1 AND V01.bewart_id = 1002 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'G'
  THEN V01.menge * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V01.bewart_id = 1002 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'KG'
  THEN V01.menge * V03.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND V01.bewart_id = 1002 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'ML'
  THEN V01.menge * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V01.bewart_id = 1002 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'L'
  THEN V01.menge * V03.faktor_nettoinhalt
  WHEN V01.mandant_id > 1 AND V01.bewart_id = 1002 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'G'
  THEN V01.menge * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V01.bewart_id = 1002 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'KG'
    
  THEN V01.menge * V03.inhalt_menge
  WHEN V01.mandant_id > 1 AND V01.bewart_id = 1002 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'ML'
    
  THEN V01.menge * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V01.bewart_id = 1002 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'L'
  THEN V01.menge * V03.inhalt_menge
  WHEN V01.bewart_id = 1002 AND V03.basismenge_einh_id = 'KG'
  THEN V01.menge
  ELSE 0
  END AS vk_menge_sa_norm,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_brutto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_brutto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.ek_brutto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_brutto_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.ek_netto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_netto_bnk_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_netto_bnk * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.ek_netto_bnk AS BIGNUMERIC)
  ELSE NULL
  END AS ek_nettobnk_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_nettonetto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_nettonetto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.ek_nettonetto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto2_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_mep_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.ek_mep AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto3_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_einstandspreis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.mandant_id = 1
    AND V01.bewart_id = 1002
  THEN CAST(V01.ek_mep AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.einstandspreis AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto4_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_einstandspreis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.einstandspreis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.mandant_id = 1
     AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.einstandspreis AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto4_absatz_sa_einstandspreis,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_gld_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_gld * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.ek_gld AS BIGNUMERIC)
  ELSE NULL
  END AS ek_gld_absatz_sa,
  CASE
  WHEN V01.ean_kasse BETWEEN 100000 AND 999999
  THEN V01.ean_kasse * 10000000
  ELSE V01.ean_kasse
  END AS ean_kasse,
  CASE
  WHEN V01.mandant_id = 1
  THEN V01.logkostenzuschlag
  ELSE NULL
  END AS logkostenzuschlag,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id IN (100110,
     100130)
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id IN (100110,
     100130)
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id IN (100110, 100130) OR V02.wrg_typ_id = 1 AND V01
     .bewart_det_id IN (100110, 100130)
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_af_non_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id IN (100111,
     100121, 100131)
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id IN (100111,
     100121, 100131)
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id IN (100111, 100121, 100131) OR V02.wrg_typ_id = 1
      AND V01.bewart_det_id IN (100111, 100121, 100131)
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_af_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100111
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100111
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100111 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
      = 100111
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE 0
  END AS umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100110
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100110
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100110 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
      = 100110
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE 0
  END AS umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
   CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100111
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100111
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100111 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
       = 100111
   THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
   ELSE 0
   END + CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100110
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100110
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100110 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
       = 100110
   THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
   ELSE 0
   END AS umsatz_af_exkl_schwarz_media_u_bonrabatt_bby,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100121
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100121
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100121 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
      = 100121
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_af_loyalty_schwarz_media,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100210
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100210
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100210 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
      = 100210
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_sa_non_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100211
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100211
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100211 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
      = 100211
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_sa_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100220
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100220
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100220 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
      = 100220
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_bby_non_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100221
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100221
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100221 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
      = 100221
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_bby_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100231
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100231
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100231 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
      = 100231
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_kdn_bby_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100241
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100241
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100241 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
      = 100241
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_kdp_bby_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100130
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100130
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100130 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
      = 100130
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE 0
  END AS umsatz_bonrabatt_bby_non_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100131
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100131
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100131 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
      = 100131
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE 0
  END AS umsatz_bonrabatt_bby_loyalty,
   CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100130
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100130
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100130 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
       = 100130
   THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
   ELSE 0
   END + CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100131
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id = 100131
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id = 100131 OR V02.wrg_typ_id = 1 AND V01.bewart_det_id
       = 100131
   THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
   ELSE 0
   END AS umsatz_bonrabatt_bby,
  CASE
  WHEN V01.bewart_det_id IN (100110, 100130)
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE NULL
  END AS vk_menge_af_non_loyalty,
  CASE
  WHEN V01.bewart_det_id IN (100111, 100121, 100131)
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE NULL
  END AS vk_menge_af_loyalty,
  CASE
  WHEN V01.bewart_det_id = 100111
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE 0
  END AS vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
  CASE
  WHEN V01.bewart_det_id = 100110
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE 0
  END AS vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
   CASE
   WHEN V01.bewart_det_id = 100111
   THEN CAST(V01.menge AS BIGNUMERIC)
   ELSE 0
   END + CASE
   WHEN V01.bewart_det_id = 100110
   THEN CAST(V01.menge AS BIGNUMERIC)
   ELSE 0
   END AS vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
  CASE
  WHEN V01.bewart_det_id = 100121
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE NULL
  END AS vk_menge_af_loyalty_schwarz_media,
  CASE
  WHEN V01.bewart_det_id = 100210
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE NULL
  END AS vk_menge_sa_non_loyalty,
  CASE
  WHEN V01.bewart_det_id = 100211
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE NULL
  END AS vk_menge_sa_loyalty,
  CASE
  WHEN V01.bewart_det_id = 100220
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE NULL
  END AS vk_menge_bby_non_loyalty,
  CASE
  WHEN V01.bewart_det_id = 100221
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE NULL
  END AS vk_menge_bby_loyalty,
  CASE
  WHEN V01.bewart_det_id = 100231
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE NULL
  END AS vk_menge_kdn_bby_loyalty,
  CASE
  WHEN V01.bewart_det_id = 100241
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE NULL
  END AS vk_menge_kdp_bby_loyalty,
  CASE
  WHEN V01.bewart_det_id = 100130
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE 0
  END AS vk_menge_bonrabatt_bby_non_loyalty,
  CASE
  WHEN V01.bewart_det_id = 100131
  THEN CAST(V01.menge AS BIGNUMERIC)
  ELSE 0
  END AS vk_menge_bonrabatt_bby_loyalty,
   CASE
   WHEN V01.bewart_det_id = 100130
   THEN CAST(V01.menge AS BIGNUMERIC)
   ELSE 0
   END + CASE
   WHEN V01.bewart_det_id = 100131
   THEN CAST(V01.menge AS BIGNUMERIC)
   ELSE 0
   END AS vk_menge_bonrabatt_bby,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100211
  THEN CAST(V01.pv_aktion_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100211
  THEN ROUND(CAST(V01.pv_aktion * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100211
  THEN CAST(V01.pv_aktion AS BIGNUMERIC)
  ELSE NULL
  END AS pv_aktion_sa_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100221, 100211)
  THEN CAST(V01.pv_aktion_bby_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100221, 100211)
  THEN ROUND(CAST(V01.pv_aktion_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100221, 100211)
  THEN CAST(V01.pv_aktion_bby AS BIGNUMERIC)
  ELSE NULL
  END AS pv_aktion_sa_loyalty_bby,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100231, 100221, 100211)
  THEN CAST(V01.pv_aktion_kdn_bby_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100231, 100221, 100211)
  THEN ROUND(CAST(V01.pv_aktion_kdn_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100231, 100221, 100211)
  THEN CAST(V01.pv_aktion_kdn_bby AS BIGNUMERIC)
  ELSE NULL
  END AS pv_aktion_sa_loyalty_kdn_bby,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100241, 100231, 100221, 100211)
  THEN CAST(V01.pv_aktion_kdp_bby_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100241, 100231, 100221, 100211)
  THEN ROUND(CAST(V01.pv_aktion_kdp_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100241, 100231, 100221, 100211)
  THEN CAST(V01.pv_aktion_kdp_bby AS BIGNUMERIC)
  ELSE NULL
  END AS pv_aktion_sa_loyalty_kdp_bby,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100210
  THEN CAST(V01.pv_aktion_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100210
  THEN ROUND(CAST(V01.pv_aktion * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100210
  THEN CAST(V01.pv_aktion AS BIGNUMERIC)
  ELSE NULL
  END AS pv_aktion_sa_non_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100220, 100210)
  THEN CAST(V01.pv_aktion_bby_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100220, 100210)
  THEN ROUND(CAST(V01.pv_aktion_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100220, 100210)
  THEN CAST(V01.pv_aktion_bby AS BIGNUMERIC)
  ELSE NULL
  END AS pv_aktion_sa_non_loyalty_bby,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100221, 100231, 100241)
  THEN CAST(V01.pv_bby_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100221, 100231, 100241)
  THEN ROUND(CAST(V01.pv_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100221, 100231, 100241)
  THEN CAST(V01.pv_bby AS BIGNUMERIC)
  ELSE NULL
  END AS pv_bby_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100220
  THEN CAST(V01.pv_bby_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100220
  THEN ROUND(CAST(V01.pv_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100220
  THEN CAST(V01.pv_bby AS BIGNUMERIC)
  ELSE NULL
  END AS pv_bby_non_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100231, 100241)
  THEN CAST(V01.pv_kdn_bby_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100231, 100241)
  THEN ROUND(CAST(V01.pv_kdn_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100231, 100241)
  THEN CAST(V01.pv_kdn_bby AS BIGNUMERIC)
  ELSE NULL
  END AS pv_kdn_bby_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.pv_kdp_bby_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.pv_kdp_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1
  THEN CAST(V01.pv_kdp_bby AS BIGNUMERIC)
  ELSE NULL
  END AS pv_kdp_bby_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100210, 100220, 100130)
  THEN CAST(V01.pv_bonrabatt_bby_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100210, 100220, 100130)
  THEN ROUND(CAST(V01.pv_bonrabatt_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100210, 100220, 100130)
  THEN CAST(V01.pv_bonrabatt_bby AS BIGNUMERIC)
  ELSE 0
  END AS pv_bonrabatt_bby_non_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100211, 100221, 100231, 100241,
     100131)
  THEN CAST(V01.pv_bonrabatt_bby_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100211, 100221, 100231, 100241,
     100131)
  THEN ROUND(CAST(V01.pv_bonrabatt_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100211, 100221, 100231, 100241, 100131)
  THEN CAST(V01.pv_bonrabatt_bby AS BIGNUMERIC)
  ELSE 0
  END AS pv_bonrabatt_bby_loyalty,
   CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100210, 100220, 100130)
   THEN CAST(V01.pv_bonrabatt_bby_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100210, 100220, 100130)
   THEN ROUND(CAST(V01.pv_bonrabatt_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100210, 100220, 100130)
   THEN CAST(V01.pv_bonrabatt_bby AS BIGNUMERIC)
   ELSE 0
   END + CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100211, 100221, 100231, 100241,
      100131)
   THEN CAST(V01.pv_bonrabatt_bby_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100211, 100221, 100231, 100241,
      100131)
   THEN ROUND(CAST(V01.pv_bonrabatt_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100211, 100221, 100231, 100241, 100131)
   THEN CAST(V01.pv_bonrabatt_bby AS BIGNUMERIC)
   ELSE 0
   END AS pv_bonrabatt_bby,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.bonusbasis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.bonusbasis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.bonusbasis AS BIGNUMERIC)
  END AS bonusbasis,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.bonusbasis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.bonusbasis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.bonusbasis AS BIGNUMERIC)
  ELSE NULL
  END AS bonusbasis_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.bonusbasis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.bonusbasis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.bonusbasis AS BIGNUMERIC)
  ELSE NULL
  END AS bonusbasis_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.ek_mep_vor_fwu_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_mep_vor_fwu * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_mep_vor_fwu AS BIGNUMERIC)
  END AS ek_mepol,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.ek_mep_vor_fwu_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_mep_vor_fwu * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.ek_mep_vor_fwu AS BIGNUMERIC)
  ELSE NULL
  END AS ek_mepol_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.ek_mep_vor_fwu_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_mep_vor_fwu * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.ek_mep_vor_fwu AS BIGNUMERIC)
  ELSE NULL
  END AS ek_mepol_sa,
           COALESCE(CASE
             WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100211
             THEN CAST(V01.pv_aktion_konz AS BIGNUMERIC)
             WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100211
             THEN ROUND(CAST(V01.pv_aktion * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
             WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100211
             THEN CAST(V01.pv_aktion AS BIGNUMERIC)
             ELSE NULL
             END, 0) + COALESCE(CASE
             WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100221, 100211)
             THEN CAST(V01.pv_aktion_bby_konz AS BIGNUMERIC)
             WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100221, 100211)
             THEN ROUND(CAST(V01.pv_aktion_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
             WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100221, 100211)
             THEN CAST(V01.pv_aktion_bby AS BIGNUMERIC)
             ELSE NULL
             END, 0) + COALESCE(CASE
            WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100231, 100221, 100211)
            THEN CAST(V01.pv_aktion_kdn_bby_konz AS BIGNUMERIC)
            WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100231, 100221, 100211)
            THEN ROUND(CAST(V01.pv_aktion_kdn_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
            WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100231, 100221, 100211)
            THEN CAST(V01.pv_aktion_kdn_bby AS BIGNUMERIC)
            ELSE NULL
            END, 0) + COALESCE(CASE
           WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100241, 100231, 100221,
              100211)
           THEN CAST(V01.pv_aktion_kdp_bby_konz AS BIGNUMERIC)
           WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100241, 100231, 100221,
              100211)
           THEN ROUND(CAST(V01.pv_aktion_kdp_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
           WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100241, 100231, 100221, 100211)
           THEN CAST(V01.pv_aktion_kdp_bby AS BIGNUMERIC)
           ELSE NULL
           END, 0) + COALESCE(CASE
          WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100210
          THEN CAST(V01.pv_aktion_konz AS BIGNUMERIC)
          WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100210
          THEN ROUND(CAST(V01.pv_aktion * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
          WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100210
          THEN CAST(V01.pv_aktion AS BIGNUMERIC)
          ELSE NULL
          END, 0) + COALESCE(CASE
         WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100220, 100210)
         THEN CAST(V01.pv_aktion_bby_konz AS BIGNUMERIC)
         WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100220, 100210)
         THEN ROUND(CAST(V01.pv_aktion_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
         WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100220, 100210)
         THEN CAST(V01.pv_aktion_bby AS BIGNUMERIC)
         ELSE NULL
         END, 0) + COALESCE(CASE
        WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100221, 100231, 100241)
        THEN CAST(V01.pv_bby_konz AS BIGNUMERIC)
        WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100221, 100231, 100241)
        THEN ROUND(CAST(V01.pv_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
        WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100221, 100231, 100241)
        THEN CAST(V01.pv_bby AS BIGNUMERIC)
        ELSE NULL
        END, 0) + COALESCE(CASE
       WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100220
       THEN CAST(V01.pv_bby_konz AS BIGNUMERIC)
       WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100220
       THEN ROUND(CAST(V01.pv_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
       WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100220
       THEN CAST(V01.pv_bby AS BIGNUMERIC)
       ELSE NULL
       END, 0) + COALESCE(CASE
      WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100231, 100241)
      THEN CAST(V01.pv_kdn_bby_konz AS BIGNUMERIC)
      WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100231, 100241)
      THEN ROUND(CAST(V01.pv_kdn_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
      WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100231, 100241)
      THEN CAST(V01.pv_kdn_bby AS BIGNUMERIC)
      ELSE NULL
      END, 0) + COALESCE(CASE
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
     THEN CAST(V01.pv_kdp_bby_konz AS BIGNUMERIC)
     WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
     THEN ROUND(CAST(V01.pv_kdp_bby * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
     WHEN V02.wrg_typ_id = 1
     THEN CAST(V01.pv_kdp_bby AS BIGNUMERIC)
     ELSE NULL
     END, 0) + COALESCE(V01.pv_bonrabatt_bby, 0) AS werbeabschrift_pv,
 0 AS werbeabschrift_werbenachvermarktung_manuell,
 0 AS werbeabschrift_aktionsanpassung_filiale,
 0 AS werbeabschrift_rest,
 V01.aktionsart_liste_id,
 V01.aktion_typ_liste_id
FROM kfl_production_dbp_data.artbew_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V02 ON (V01.mandant_id <> 5 OR V01.art_id <> 206731500)
      AND (V01.mandant_id <> 2 OR V01.art_id <> 208124500) AND (V01.mandant_id <> 3 OR V01.art_id <> 208113690) AND (V01
       .mandant_id <> 6 OR V01.art_id <> 208131570) AND (V01.mandant_id NOT IN (4, 7) OR V01.art_id <> 208114740) AND (V01
     .mandant_id <> 8 OR V01.art_id <> 208131640)
 INNER JOIN kfl_production_dbp_data.art_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
 LEFT JOIN kfl_production_dbp_msi_view_ais_int.tbl_wup_bereinigt_1 AS V05 ON V01.dat = V05.dat AND V01.mandant_id = V05.mandant_id
     AND V01.wup_id = V05.wup_id
UNION ALL
SELECT *
FROM kfl_production_dbp_msi_view_ais_int.tbl_mv_artbew_1 AS V01;
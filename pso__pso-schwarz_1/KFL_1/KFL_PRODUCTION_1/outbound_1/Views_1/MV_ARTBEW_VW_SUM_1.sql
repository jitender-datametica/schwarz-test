CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_artbew_vw_sum_1 (dat, art_id, mandant_id, gp_id, herst_id, vw_id
, bewart_id, bezugsweg_id, ean_kasse, posten_id_per, posten_kz_per, umsatz_mwst_betrag, umsatz_netto, vk_menge,
vk_menge_norm, ek_netto2_absatz, ek_netto3_absatz, ek_netto4_absatz, umsatz_mwst_betrag_af, umsatz_netto_af, vk_menge_af
, vk_menge_af_norm, ek_netto2_absatz_af, ek_netto3_absatz_af, ek_netto4_absatz_af, umsatz_mwst_betrag_sa,
umsatz_netto_sa, vk_menge_sa, vk_menge_sa_norm, ek_netto2_absatz_sa, ek_netto3_absatz_sa, ek_netto4_absatz_sa,
ek_brutto_absatz, ek_brutto_absatz_af, ek_brutto_absatz_sa, ek_gld_absatz, ek_gld_absatz_af, ek_gld_absatz_sa,
ek_nettobnk_absatz, ek_nettobnk_absatz_af, ek_nettobnk_absatz_sa, ek_netto_absatz, ek_netto_absatz_af,
ek_netto_absatz_sa, logkostenzuschlag, logkostenzuschlag_af, logkostenzuschlag_sa, ek_mepol, ek_mepol_af, ek_mepol_sa,
bonusbasis, bonusbasis_af, bonusbasis_sa) AS SELECT V01.dat,
 V01.art_id,
 V01.mandant_id,
 V01.gp_id,
 V01.herst_id,
 V01.vw_id,
 V01.bewart_id,
 V01.bezugsweg_id,
  CASE
  WHEN V01.ean_kasse BETWEEN 100000 AND 999999
  THEN V01.ean_kasse * 10000000
  ELSE V01.ean_kasse
  END AS ean_kasse,
 CAST(CASE
   WHEN V01.bewart_id = 1001 AND V04.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END AS STRING) AS posten_id_per,
 SUBSTR(CASE
   WHEN V04.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per,
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
  WHEN V01.mandant_id = 1 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'G'
  THEN V01.menge * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'KG'
  THEN V01.menge * V05.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'ML'
  THEN V01.menge * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'L'
  THEN V01.menge * V05.faktor_nettoinhalt
  WHEN V01.mandant_id > 1 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'G'
  THEN V01.menge * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'KG'
  THEN V01.menge * V05.inhalt_menge
  WHEN V01.mandant_id > 1 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'ML'
  THEN V01.menge * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'L'
  THEN V01.menge * V05.inhalt_menge
  WHEN V05.basismenge_einh_id = 'KG'
  THEN V01.menge
  ELSE 0
  END AS vk_menge_norm,
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
  WHEN V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'G'
  THEN V01.menge * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'KG'
  THEN V01.menge * V05.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'ML'
  THEN V01.menge * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'L'
  THEN V01.menge * V05.faktor_nettoinhalt
  WHEN V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010) AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id
     = 'G'
  THEN V01.menge * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010) AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id
     = 'KG'
  THEN V01.menge * V05.inhalt_menge
  WHEN V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010) AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id
     = 'ML'
  THEN V01.menge * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010) AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id
     = 'L'
  THEN V01.menge * V05.inhalt_menge
  WHEN V01.bewart_id IN (1001, 1010) AND V05.basismenge_einh_id = 'KG'
  THEN V01.menge
  ELSE 0
  END AS vk_menge_af_norm,
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
  WHEN V01.mandant_id = 1 AND V01.bewart_id = 1002 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'G'
  THEN V01.menge * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V01.bewart_id = 1002 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'KG'
  THEN V01.menge * V05.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND V01.bewart_id = 1002 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'ML'
  THEN V01.menge * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V01.bewart_id = 1002 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'L'
  THEN V01.menge * V05.faktor_nettoinhalt
  WHEN V01.mandant_id > 1 AND V01.bewart_id = 1002 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'G'
  THEN V01.menge * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V01.bewart_id = 1002 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'KG'
    
  THEN V01.menge * V05.inhalt_menge
  WHEN V01.mandant_id > 1 AND V01.bewart_id = 1002 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'ML'
    
  THEN V01.menge * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V01.bewart_id = 1002 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'L'
  THEN V01.menge * V05.inhalt_menge
  WHEN V01.bewart_id = 1002 AND V05.basismenge_einh_id = 'KG'
  THEN V01.menge
  ELSE 0
  END AS vk_menge_sa_norm,
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
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_ek_brutto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.ek_brutto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_brutto AS BIGNUMERIC)
  END AS ek_brutto_absatz,
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
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_brutto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_brutto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.ek_brutto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_brutto_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_ek_gld_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.ek_gld * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_gld AS BIGNUMERIC)
  END AS ek_gld_absatz,
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
  THEN CAST(V01.diff_ek_gld_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_gld * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.ek_gld AS BIGNUMERIC)
  ELSE NULL
  END AS ek_gld_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_ek_netto_bnk_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.ek_netto_bnk * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_netto_bnk AS BIGNUMERIC)
  END AS ek_nettobnk_absatz,
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
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_netto_bnk_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_netto_bnk * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.ek_netto_bnk AS BIGNUMERIC)
  ELSE NULL
  END AS ek_nettobnk_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_ek_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.ek_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_netto AS BIGNUMERIC)
  END AS ek_netto_absatz,
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
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.ek_netto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto_absatz_sa,
  CASE
  WHEN V01.mandant_id = 1
  THEN V01.logkostenzuschlag
  ELSE NULL
  END AS logkostenzuschlag,
  CASE
  WHEN V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN V01.logkostenzuschlag
  ELSE NULL
  END AS logkostenzuschlag_af,
  CASE
  WHEN V01.mandant_id = 1 AND V01.bewart_id = 1002
  THEN V01.logkostenzuschlag
  ELSE NULL
  END AS logkostenzuschlag_sa,
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
  END AS bonusbasis_sa
FROM kfl_production_dbp_data.artbew_vw_sum_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V02 ON TRUE
 LEFT JOIN kfl_production_dbp_data.art_per_1 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id AND V01
   .dat BETWEEN DATE_SUB(V04.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V04.dat_bis, INTERVAL 1 DAY))
 INNER JOIN kfl_production_dbp_data.art_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.art_id = V05.art_id AND (V01.mandant_id
           <> 5 OR V01.art_id <> 206731500) AND (V01.mandant_id <> 2 OR V01.art_id <> 208124500) AND (V01.mandant_id <>
        3 OR V01.art_id <> 208113690) AND (V01.mandant_id <> 6 OR V01.art_id <> 208131570) AND (V01.mandant_id NOT IN (4
       , 7) OR V01.art_id <> 208114740) AND (V01.mandant_id <> 8 OR V01.art_id <> 208131640);
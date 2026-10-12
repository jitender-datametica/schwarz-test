-- AP0212516, SPEC0243813 - Anpassungen AF Kennzahlen
 -- AP0052094, SPEC0065401

-- SPEC0068483 - adding bewart_1 1010 to the AF columns
 -- AP0217036, SPEC0244515 - PV hinzufuegen

-- AP0077097, SPEC0094265 - new umsatz and absatz metrics
 -- AP0152678, SPEC0187452 - new EK n3 inkl FWU metrics

-- AP0143687, SPEC0172769 - new EK metrics
 -- AP0147481, SPEC0220258 - neue Bewart_id SMP

-- AP0261549, Bewegungsart bei pv_kdp_bby_loyalty hinzufügen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artbew_wg_tag_sum_1 (dat, wg_id, arthiertyp_id, mandant_id,
nb_id, wup_id, bewart_id, bewart_det_id, posten_id, posten_kz, wup_bereinigt_fg, wup_bereinigt_fg_vj,
wup_bereinigt_fg_vj_wo, umsatz_mwst_betrag, umsatz_netto, vk_menge, ek_brutto_absatz, ek_netto_absatz,
ek_nettobnk_absatz, ek_netto2_absatz, ek_netto3_absatz, ek_netto3_inkl_fwu_absatz, ek_netto4_absatz,
umsatz_mwst_betrag_af, umsatz_netto_af, vk_menge_af, ek_brutto_absatz_af, ek_netto_absatz_af, ek_nettobnk_absatz_af,
ek_netto2_absatz_af, ek_netto3_absatz_af, ek_netto3_inkl_fwu_absatz_af, ek_netto4_absatz_af, umsatz_mwst_betrag_sa,
umsatz_netto_sa, vk_menge_sa, ek_brutto_absatz_sa, ek_netto_absatz_sa, ek_nettobnk_absatz_sa, ek_netto2_absatz_sa,
ek_netto3_absatz_sa, ek_netto3_inkl_fwu_absatz_sa, ek_netto4_absatz_sa, umsatz_af_non_loyalty, umsatz_af_loyalty,
umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby, umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
umsatz_af_exkl_schwarz_media_u_bonrabatt_bby, umsatz_af_loyalty_schwarz_media, umsatz_sa_non_loyalty, umsatz_sa_loyalty
, umsatz_bby_non_loyalty, umsatz_bby_loyalty, umsatz_kdn_bby_loyalty, umsatz_kdp_bby_loyalty,
umsatz_af_bonrabatt_non_loyalty, umsatz_af_bonrabatt_loyalty, umsatz_af_bonrabatt, vk_menge_af_non_loyalty,
vk_menge_af_loyalty, vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby, vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
vk_menge_af_loyalty_schwarz_media, vk_menge_sa_non_loyalty, vk_menge_sa_loyalty, vk_menge_bby_non_loyalty,
vk_menge_bby_loyalty, vk_menge_kdn_bby_loyalty, vk_menge_kdp_bby_loyalty, vk_menge_bonrabatt_bby_non_loyalty,
vk_menge_bonrabatt_bby_loyalty, vk_menge_bonrabatt_bby, ek_gld_absatz, ek_gld_absatz_af, ek_gld_absatz_sa, ek_mepol,
ek_mepol_af, ek_mepol_sa, bonusbasis, bonusbasis_af, bonusbasis_sa, pv_aktion_sa_loyalty, pv_aktion_sa_loyalty_bby,
pv_aktion_sa_loyalty_kdn_bby, pv_aktion_sa_loyalty_kdp_bby, pv_aktion_sa_non_loyalty, pv_aktion_sa_non_loyalty_bby,
pv_bby_loyalty, pv_bby_non_loyalty, pv_kdn_bby_loyalty, pv_kdp_bby_loyalty, pv_bonrabatt_bby_non_loyalty,
pv_bonrabatt_bby_loyalty, pv_bonrabatt_bby) AS
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
 -- AP0052094, SPEC0065401

-- AP0143687, SPEC0172769 - new EK metrics
 -- PV
 SELECT V01.dat,
 V01.wg_id,
 V01.arthiertyp_id,
 V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 V01.bewart_id,
 V01.bewart_det_id,
 SUBSTR(CASE
   WHEN V01.bewart_id = 1001 AND V01.posten_id NOT IN ('1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_id,
 SUBSTR(CASE
   WHEN V01.posten_id NOT IN ('1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz,
 V01.wup_bereinigt_fg,
 V01.wup_bereinigt_fg_vj,
 V01.wup_bereinigt_fg_vj_wo,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
  END AS umsatz_mwst_betrag,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.umsatz_netto AS BIGNUMERIC)
  END AS umsatz_netto,
 CAST(V01.menge AS BIGNUMERIC) AS vk_menge,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.diff_ek_brutto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_brutto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_brutto AS BIGNUMERIC)
  END AS ek_brutto_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.diff_ek_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_netto AS BIGNUMERIC)
  END AS ek_netto_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.diff_ek_netto_bnk_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_netto_bnk * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_netto_bnk AS BIGNUMERIC)
  END AS ek_nettobnk_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.diff_ek_nettonetto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_nettonetto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_nettonetto AS BIGNUMERIC)
  END AS ek_netto2_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.diff_ek_mep_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_mep AS BIGNUMERIC)
  END AS ek_netto3_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.diff_ek_kal_basis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_kal_basis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_kal_basis AS BIGNUMERIC)
  END AS ek_netto3_inkl_fwu_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.diff_einstandspreis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.einstandspreis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.einstandspreis AS BIGNUMERIC)
  END AS ek_netto4_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_mwst_betrag_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_netto_af,
 V01.vk_menge_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_brutto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_brutto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.ek_brutto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_brutto_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.ek_netto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_netto_bnk_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_netto_bnk * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.ek_netto_bnk AS BIGNUMERIC)
  ELSE NULL
  END AS ek_nettobnk_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_nettonetto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_nettonetto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.ek_nettonetto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto2_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_mep_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.ek_mep AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto3_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_kal_basis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.ek_kal_basis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.ek_kal_basis AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto3_inkl_fwu_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_einstandspreis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.einstandspreis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.einstandspreis AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto4_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_mwst_betrag_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_netto_sa,
 V01.vk_menge_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_brutto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_brutto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.ek_brutto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_brutto_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.ek_netto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_netto_bnk_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_netto_bnk * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.ek_netto_bnk AS BIGNUMERIC)
  ELSE NULL
  END AS ek_nettobnk_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_nettonetto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_nettonetto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.ek_nettonetto AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto2_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_mep_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.ek_mep AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto3_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_kal_basis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.ek_kal_basis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.ek_kal_basis AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto3_inkl_fwu_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_einstandspreis_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.einstandspreis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.einstandspreis AS BIGNUMERIC)
  ELSE NULL
  END AS ek_netto4_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100110, 100130)
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100110, 100130)
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100110, 100130)
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_af_non_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id IN (100111, 100121, 100131)
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id IN (100111, 100121, 100131)
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100111, 100121, 100131)
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_af_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100111
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100111
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100111
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE 0
  END AS umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100110
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100110
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100110
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE 0
  END AS umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
   CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100111
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100111
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100111
   THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
   ELSE 0
   END + CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100110
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100110
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100110
   THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
   ELSE 0
   END AS umsatz_af_exkl_schwarz_media_u_bonrabatt_bby,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100121
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100121
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100121
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_af_loyalty_schwarz_media,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100210
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100210
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100210
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_sa_non_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100211
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100211
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100211
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_sa_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100220
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100220
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100220
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_bby_non_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100221
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100221
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100221
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_bby_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100231
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100231
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100231
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_kdn_bby_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100241
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100241
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100241
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_kdp_bby_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100130
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100130
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100130
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE 0
  END AS umsatz_af_bonrabatt_non_loyalty,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100131
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100131
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100131
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE 0
  END AS umsatz_af_bonrabatt_loyalty,
   CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100130
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100130
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100130
   THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
   ELSE 0
   END + CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.bewart_det_id = 100131
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.bewart_det_id = 100131
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 1 AND V01.bewart_det_id = 100131
   THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
   ELSE 0
   END AS umsatz_af_bonrabatt,
 V01.vk_menge_af_non_loyalty,
 V01.vk_menge_af_loyalty,
 V01.vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
 V01.vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
 V01.vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
 V01.vk_menge_af_loyalty_schwarz_media,
 V01.vk_menge_sa_non_loyalty,
 V01.vk_menge_sa_loyalty,
 V01.vk_menge_bby_non_loyalty,
 V01.vk_menge_bby_loyalty,
 V01.vk_menge_kdn_bby_loyalty,
 V01.vk_menge_kdp_bby_loyalty,
 V01.vk_menge_bonrabatt_bby_non_loyalty,
 V01.vk_menge_bonrabatt_bby_loyalty,
 V01.vk_menge_bonrabatt_bby,
  CASE
  WHEN V02.wrg_typ_id = 0
  THEN CAST(V01.diff_ek_gld_konz AS BIGNUMERIC)
  ELSE CAST(V01.ek_gld AS BIGNUMERIC)
  END AS ek_gld_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_ek_gld_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.ek_gld AS BIGNUMERIC)
  ELSE NULL
  END AS ek_gld_absatz_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_ek_gld_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
  THEN CAST(V01.ek_gld AS BIGNUMERIC)
  ELSE NULL
  END AS ek_gld_absatz_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN CAST(V01.ek_mep_vor_fwu_konz AS BIGNUMERIC)
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
  END AS bonusbasis_sa,
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
   END AS pv_bonrabatt_bby
FROM kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artbew_wg_tag_sum_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V02 ON TRUE;
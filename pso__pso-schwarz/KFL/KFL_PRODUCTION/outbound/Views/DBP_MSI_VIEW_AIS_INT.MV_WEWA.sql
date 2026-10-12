/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
 -- SPEC0207782

-- CASE WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) THEN v01.menge_rech END AS Bsch_Menge

-- DE
 -- CROSS JOIN aktueller Berichtskurs
 -- DE

-- 21.11.2023 staeblern / Umbenennung der Spalte Betrag zu betrag_ek_netto

-- 08.03.2024 bauertob / Changed logic for Lief_EK_mep(_vor_fwu)_Umsatz to align KMO and DE
 -- DE

-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025

-- bauertob 20.07.2023 - AP0179744, SPEC0207782 - adjusted MEP-fields

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- 18.07.2025 prescher / SPEC0313584- Aufnahme Fakt Kalkulationsbasis
 -- DE

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- SPEC0236778

/* Umrechnung Standardkurs, Tageskurs              
JOIN KFL_PRODUCTION.dbp_view.v_kurs v300
ON v01.dat_buch BETWEEN v300.dat_von AND v300.dat_bis
AND v01.wrg_id = v300.von_wrg_id
AND v300.kurstyp_id = 9
AND v300.nach_wrg_id ='EUR' */
-- DE
 -- ZEKP Auflösung allgemeingeltende Preise

/* AP0219157/SPEC0256033 CROSS JOIN auf DBP_VIEW.V_ART wegen Erweiterung um Spalten norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
 -- lsvi0303 02.11.2020 - AP0074875, SPEC0089162 - added ek_mep fields for mandant_id=1

-- lsvi0303 21.02.2020 - AP0112499, SPEC0144895 - einstandspreis formatting
 -- DE

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE
 -- ZEKP Auflösung, marktspezifische Preise

/* AP0219157/SPEC0256033 Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
-- DE

/* AP0219157/SPEC0256033 CROSS JOIN auf DBP_VIEW.V_ART wegen Erweiterung um Spalten _norm zur Berechnung der tatsächlichen Mengen der KG/G/L/ML Artikel 14.06.2024 */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_wewa (mandant_id, wewa_beleg_id, wewa_beleg_pos_id,
wewa_jahr, art_id, wup_id, nb_id, gp_id, lager_bewart_id, dat_buch, menge_basis, menge_basis_norm, betrag_ekn,
betrag_vk_netto, wewa_menge_zl, wewa_menge_zl_norm, wewa_menge_dz, wewa_menge_dz_norm, wewa_menge_ret_zl,
wewa_menge_ret_zl_norm, wewa_menge_ret_dz, wewa_menge_ret_dz_norm, wewa_betrag_zl, wewa_betrag_dz, wewa_betrag_ret_zl,
wewa_betrag_ret_dz, einstandspreis, ek_mep_vor_fwu, ek_mep, ek_kalkulationsbasis, ek_kalkulationsbasis_ohne_fwu,
ek_nettonetto, lief_ek_mep_umsatz, lief_ek_mep_umsatz_zl, lief_ek_mep_umsatz_dz, lief_ek_mep_umsatz_ret,
lief_ek_mep_umsatz_ret_dz, lief_ek_mep_umsatz_ret_zl, lief_ek_mep_vor_fwu_umsatz, lief_ek_mep_vor_fwu_umsatz_zl,
lief_ek_mep_vor_fwu_umsatz_dz, lief_ek_mep_vor_fwu_umsatz_ret, lief_ek_mep_vor_fwu_umsatz_ret_zl,
lief_ek_mep_vor_fwu_umsatz_ret_dz, logkosten, wewa_status, wrg_id, posten_kz_per) AS SELECT V01.mandant_id,
 V01.wewa_beleg_id,
 V01.wewa_beleg_pos_id,
 V01.wewa_jahr,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V01.gp_id,
 V01.lager_bewart_id,
 V01.dat_buch,
 V01.menge_basis,
  CASE
  WHEN V01.mandant_id = 1 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'G'
  THEN V01.menge_basis * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'KG'
  THEN V01.menge_basis * V05.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'ML'
  THEN V01.menge_basis * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V05.basismenge_einh_id = 'ST' AND V05.einh_id = 'L'
  THEN V01.menge_basis * V05.faktor_nettoinhalt -- KMO

  WHEN V01.mandant_id > 1 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'G'
  THEN V01.menge_basis * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'KG'
  THEN V01.menge_basis * V05.inhalt_menge
  WHEN V01.mandant_id > 1 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'ML'
  THEN V01.menge_basis * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V05.basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'L'
  THEN V01.menge_basis * V05.inhalt_menge -- länderübergreifend

  WHEN V05.basismenge_einh_id = 'KG'
  THEN V01.menge_basis
  ELSE 0
  END AS menge_basis_norm,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN V01.betrag_ek_netto
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN V01.betrag_ek_netto * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN V01.betrag_ek_netto * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS betrag_ekn,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN V01.betrag_vk_netto
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN V01.betrag_vk_netto * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN V01.betrag_vk_netto * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS betrag_vk_netto,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111
  THEN V01.menge_basis
  ELSE 0
  END AS wewa_menge_zl,
  CASE
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111 AND V05
     .basismenge_einh_id = 'ST' AND V05.einh_id = 'G'
  THEN V01.menge_basis * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111 AND V05
     .basismenge_einh_id = 'ST' AND V05.einh_id = 'KG'
  THEN V01.menge_basis * V05.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111 AND V05
     .basismenge_einh_id = 'ST' AND V05.einh_id = 'ML'
  THEN V01.menge_basis * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111 AND V05
     .basismenge_einh_id = 'ST' AND V05.einh_id = 'L'
  THEN V01.menge_basis * V05.faktor_nettoinhalt -- KMO

  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111 AND V05
     .basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'G'
  THEN V01.menge_basis * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111 AND V05
     .basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'KG'
  THEN V01.menge_basis * V05.inhalt_menge
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111 AND V05
     .basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'ML'
  THEN V01.menge_basis * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111 AND V05
     .basismenge_einh_id = 'ST' AND V05.inhalt_menge_einh_id = 'L'
  THEN V01.menge_basis * V05.inhalt_menge -- länderübergreifend

  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111 AND V05.basismenge_einh_id =
    'KG'
  THEN V01.menge_basis
  ELSE 0
  END AS wewa_menge_zl_norm,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0
  THEN V01.menge_basis
  ELSE 0
  END AS wewa_menge_dz,
  CASE
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'G'
  THEN V01.menge_basis * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'KG'
  THEN V01.menge_basis * V05.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'ML'
  THEN V01.menge_basis * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'L'
  THEN V01.menge_basis * V05.faktor_nettoinhalt -- KMO

  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'G'
  THEN V01.menge_basis * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'KG'
  THEN V01.menge_basis * V05.inhalt_menge
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'ML'
  THEN V01.menge_basis * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'L'
  THEN V01.menge_basis * V05.inhalt_menge -- länderübergreifend

  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0 AND V05.basismenge_einh_id = 'KG'
  THEN V01.menge_basis
  ELSE 0
  END AS wewa_menge_dz_norm,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111
  THEN V01.menge_basis
  ELSE 0
  END AS wewa_menge_ret_zl,
  CASE
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'G'
  THEN V01.menge_basis * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'KG'
  THEN V01.menge_basis * V05.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'ML'
  THEN V01.menge_basis * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'L'
  THEN V01.menge_basis * V05.faktor_nettoinhalt -- KMO

  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'G'
  THEN V01.menge_basis * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'KG'
  THEN V01.menge_basis * V05.inhalt_menge
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'ML'
  THEN V01.menge_basis * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'L'
  THEN V01.menge_basis * V05.inhalt_menge -- länderübergreifend

  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111 AND V05.basismenge_einh_id = 'KG'
  THEN V01.menge_basis
  ELSE 0
  END AS wewa_menge_ret_zl_norm,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0
  THEN V01.menge_basis
  ELSE 0
  END AS wewa_menge_ret_dz,
  CASE
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'G'
  THEN V01.menge_basis * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'KG'
  THEN V01.menge_basis * V05.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'ML'
  THEN V01.menge_basis * (V05.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.einh_id = 'L'
  THEN V01.menge_basis * V05.faktor_nettoinhalt -- KMO

  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'G'
  THEN V01.menge_basis * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'KG'
  THEN V01.menge_basis * V05.inhalt_menge
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'ML'
  THEN V01.menge_basis * (V05.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0 AND V05.basismenge_einh_id
      = 'ST' AND V05.inhalt_menge_einh_id = 'L'
  THEN V01.menge_basis * V05.inhalt_menge -- länderübergreifend

  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0 AND V05.basismenge_einh_id = 'KG'
  THEN V01.menge_basis
  ELSE 0
  END AS wewa_menge_ret_dz_norm,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111
  THEN CAST(CASE
    WHEN V200.wrg_typ_id = 1
    THEN V01.betrag_ek_netto
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN V01.betrag_ek_netto * V300.umrechnungskurs
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN V01.betrag_ek_netto * V400.umrechnungskurs
    ELSE NULL
    END AS NUMERIC)
  ELSE NULL
  END AS wewa_betrag_zl,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0
  THEN CAST(CASE
    WHEN V200.wrg_typ_id = 1
    THEN V01.betrag_ek_netto
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN V01.betrag_ek_netto * V300.umrechnungskurs
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN V01.betrag_ek_netto * V400.umrechnungskurs
    ELSE NULL
    END AS NUMERIC)
  ELSE NULL
  END AS wewa_betrag_dz,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111
  THEN CAST(CASE
    WHEN V200.wrg_typ_id = 1
    THEN V01.betrag_ek_netto
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN V01.betrag_ek_netto * V300.umrechnungskurs
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN V01.betrag_ek_netto * V400.umrechnungskurs
    ELSE NULL
    END AS NUMERIC)
  ELSE NULL
  END AS wewa_betrag_ret_zl,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0
  THEN CAST(CASE
    WHEN V200.wrg_typ_id = 1
    THEN V01.betrag_ek_netto
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN V01.betrag_ek_netto * V300.umrechnungskurs
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN V01.betrag_ek_netto * V400.umrechnungskurs
    ELSE NULL
    END AS NUMERIC)
  ELSE NULL
  END AS wewa_betrag_ret_dz,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(v02.einstandspreis, v03.einstandspreis)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(v02.einstandspreis, v03.einstandspreis) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(v02.einstandspreis, v03.einstandspreis) * V400.umrechnungskurs
   ELSE 0
   END AS BIGNUMERIC) AS einstandspreis_,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V400.umrechnungskurs
   ELSE 0
   END AS BIGNUMERIC) AS ek_mep_vor_fwu_,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(v02.ek_mep, v03.ek_mep)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(v02.ek_mep, v03.ek_mep) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(v02.ek_mep, v03.ek_mep) * V400.umrechnungskurs
   ELSE 0
   END AS BIGNUMERIC) AS ek_mep_,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(v02.ek_kal_basis, v03.ek_kal_basis) * V01.menge_basis
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(v02.ek_kal_basis, v03.ek_kal_basis) * V01.menge_basis * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(v02.ek_kal_basis, v03.ek_kal_basis) * V01.menge_basis * V400.umrechnungskurs
   ELSE 0
   END AS BIGNUMERIC) AS ek_kalkulationsbasis,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(v02.ek_kal_basis, v03.ek_kal_basis) + (CAST(CASE
        WHEN V200.wrg_typ_id = 1
        THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu)
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
        THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V300.umrechnungskurs
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
        THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V400.umrechnungskurs
        ELSE 0
        END AS BIGNUMERIC) - CAST(CASE
        WHEN V200.wrg_typ_id = 1
        THEN COALESCE(v02.ek_mep, v03.ek_mep)
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
        THEN COALESCE(v02.ek_mep, v03.ek_mep) * V300.umrechnungskurs
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
        THEN COALESCE(v02.ek_mep, v03.ek_mep) * V400.umrechnungskurs
        ELSE 0
        END AS BIGNUMERIC))
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(v02.ek_kal_basis, v03.ek_kal_basis) * V300.umrechnungskurs + (CAST(CASE
        WHEN V200.wrg_typ_id = 1
        THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu)
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
        THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V300.umrechnungskurs
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
        THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V400.umrechnungskurs
        ELSE 0
        END AS BIGNUMERIC) - CAST(CASE
        WHEN V200.wrg_typ_id = 1
        THEN COALESCE(v02.ek_mep, v03.ek_mep)
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
        THEN COALESCE(v02.ek_mep, v03.ek_mep) * V300.umrechnungskurs
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
        THEN COALESCE(v02.ek_mep, v03.ek_mep) * V400.umrechnungskurs
        ELSE 0
        END AS BIGNUMERIC))
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(v02.ek_kal_basis, v03.ek_kal_basis) * V400.umrechnungskurs + (CAST(CASE
        WHEN V200.wrg_typ_id = 1
        THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu)
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
        THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V300.umrechnungskurs
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
        THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V400.umrechnungskurs
        ELSE 0
        END AS BIGNUMERIC) - CAST(CASE
        WHEN V200.wrg_typ_id = 1
        THEN COALESCE(v02.ek_mep, v03.ek_mep)
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
        THEN COALESCE(v02.ek_mep, v03.ek_mep) * V300.umrechnungskurs
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
        THEN COALESCE(v02.ek_mep, v03.ek_mep) * V400.umrechnungskurs
        ELSE 0
        END AS BIGNUMERIC))
   ELSE 0
   END AS BIGNUMERIC) AS ek_kalkulationsbasis_ohne_fwu,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(v02.ek_nettonetto, v03.ek_nettonetto)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(v02.ek_nettonetto, v03.ek_nettonetto) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(v02.ek_nettonetto, v03.ek_nettonetto) * V400.umrechnungskurs
   ELSE NULL
   END AS FLOAT64) AS ek_nettonetto,
 ROUND(CAST((CASE
       WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111
       THEN V01.menge_basis
       ELSE 0
       END + CASE
       WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0
       THEN V01.menge_basis
       ELSE 0
       END) * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_umsatz,
 ROUND(CAST(CASE
     WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111
     THEN V01.menge_basis
     ELSE 0
     END * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_umsatz_zl,
 ROUND(CAST(CASE
     WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0
     THEN V01.menge_basis
     ELSE 0
     END * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_umsatz_dz,
 ROUND(CAST((CASE
       WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111
       THEN V01.menge_basis
       ELSE 0
       END + CASE
       WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0
       THEN V01.menge_basis
       ELSE 0
       END) * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_umsatz_ret,
 ROUND(CAST(CASE
     WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111
     THEN V01.menge_basis
     ELSE 0
     END * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_umsatz_ret_zl,
 ROUND(CAST(CASE
     WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0
     THEN V01.menge_basis
     ELSE 0
     END * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep, v03.ek_mep) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_umsatz_ret_dz,
 ROUND(CAST((CASE
       WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111
       THEN V01.menge_basis
       ELSE 0
       END + CASE
       WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0
       THEN V01.menge_basis
       ELSE 0
       END) * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_vor_fwu_umsatz,
 ROUND(CAST(CASE
     WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111
     THEN V01.menge_basis
     ELSE 0
     END * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_vor_fwu_umsatz_zl,
 ROUND(CAST(CASE
     WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0
     THEN V01.menge_basis
     ELSE 0
     END * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_vor_fwu_umsatz_dz,
 ROUND(CAST((CASE
       WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111
       THEN V01.menge_basis
       ELSE 0
       END + CASE
       WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0
       THEN V01.menge_basis
       ELSE 0
       END) * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_vor_fwu_umsatz_ret,
 ROUND(CAST(CASE
     WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111
     THEN V01.menge_basis
     ELSE 0
     END * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_vor_fwu_umsatz_ret_zl,
 ROUND(CAST(CASE
     WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0
     THEN V01.menge_basis
     ELSE 0
     END * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V300.umrechnungskurs
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(v02.ek_mep_vor_fwu, v03.ek_mep_vor_fwu) * V400.umrechnungskurs
      ELSE 0
      END AS BIGNUMERIC) AS NUMERIC), 4) AS lief_ek_mep_vor_fwu_umsatz_ret_dz,
 0 AS logkosten,
 V01.status AS wewa_status,
 V01.wrg_id,
 SUBSTR(CASE
   WHEN V04.posten_id NOT IN ('1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_wewa AS V01
 LEFT JOIN (SELECT mandant_id,
   art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis,
   einstandspreis,
   ek_mep_vor_fwu,
   ek_mep,
   ek_kal_basis,
   ek_nettonetto
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per
  WHERE mandant_id > 1
   AND wup_id > - 1) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.wup_id = v02.wup_id AND V01.gp_id = v02.gp_id AND
    V01.art_id = v02.art_id AND V01.dat_buch BETWEEN v02.dat_von AND v02.dat_bis
 LEFT JOIN (SELECT mandant_id,
   art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis,
   einstandspreis,
   ek_mep_vor_fwu,
   ek_mep,
   ek_kal_basis,
   ek_nettonetto
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per
  WHERE mandant_id > 1
   AND wup_id = - 1) AS v03 ON V01.mandant_id = v03.mandant_id AND V01.gp_id = v03.gp_id AND V01.art_id = v03.art_id AND
   V01.dat_buch BETWEEN v03.dat_von AND v03.dat_bis -- Ermittlung der eingestellter Währung

 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V300 ON V300.dat_bis = DATE '9999-12-31' AND V01.wrg_id = V300.von_wrg_id
   AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR' -- CROSS JOIN historischer Berichtskurs

 INNER JOIN kfl_production_dbp_view.v_kurs AS V400 ON V01.dat_buch BETWEEN V400.dat_von AND V400.dat_bis AND V01.wrg_id
     = V400.von_wrg_id AND V400.kurstyp_id = 3 AND V400.nach_wrg_id = 'EUR'
 LEFT JOIN kfl_production_dbp_view.v_art_per AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id AND
   V01.dat_buch BETWEEN DATE_SUB(V04.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V04.dat_bis, INTERVAL 1 DAY))
 INNER JOIN kfl_production_dbp_view.v_art AS V05 ON V01.mandant_id = V05.mandant_id AND V01.art_id = V05.art_id
UNION ALL
SELECT V01.mandant_id,
 V01.bsch_id,
 V01.bsch_pos_id,
 ROUND(CAST(SUBSTR(SUBSTR(CAST(V01.dat AS STRING), 1, 20), 1, 4) AS BIGNUMERIC), 0) AS wewa_jahr,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V01.gp_id,
 V01.lager_bewart_id,
 V01.dat,
 V01.menge_rech,
  CASE
  WHEN V01.mandant_id = 1 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'G'
  THEN V01.menge_rech * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'KG'
  THEN V01.menge_rech * V03.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'ML'
  THEN V01.menge_rech * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'L'
  THEN V01.menge_rech * V03.faktor_nettoinhalt -- KMO

  WHEN V01.mandant_id > 1 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'G'
  THEN V01.menge_rech * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'KG'
  THEN V01.menge_rech * V03.inhalt_menge
  WHEN V01.mandant_id > 1 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'ML'
  THEN V01.menge_rech * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'L'
  THEN V01.menge_rech * V03.inhalt_menge -- länderübergreifend

  WHEN V03.basismenge_einh_id = 'KG'
  THEN V01.menge_rech
  ELSE 0
  END AS menge_rech_norm,
 V01.ek_n,
 V01.vk_n,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id = -111
  THEN V01.menge_rech
  ELSE NULL
  END AS bsch_menge_zl,
  CASE
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = -111 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'G'
  THEN V01.menge_rech * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = -111 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'KG'
  THEN V01.menge_rech * V03.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = -111 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'ML'
  THEN V01.menge_rech * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = -111 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'L'
  THEN V01.menge_rech * V03.faktor_nettoinhalt -- KMO

  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = -111 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'G'
  THEN V01.menge_rech * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = -111 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'KG'
  THEN V01.menge_rech * V03.inhalt_menge
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = -111 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'ML'
  THEN V01.menge_rech * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = -111 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'L'
  THEN V01.menge_rech * V03.inhalt_menge -- länderübergreifend

  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id = -111 AND V03.basismenge_einh_id
     = 'KG'
  THEN V01.menge_rech
  ELSE 0
  END AS bsch_menge_zl_norm,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id IN (0)
  THEN V01.menge_rech
  ELSE NULL
  END AS bsch_menge_dz,
  CASE
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = 0 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'G'
  THEN V01.menge_rech * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = 0 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'KG'
  THEN V01.menge_rech * V03.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = 0 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'ML'
  THEN V01.menge_rech * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = 0 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'L'
  THEN V01.menge_rech * V03.faktor_nettoinhalt -- KMO

  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = 0 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'G'
  THEN V01.menge_rech * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = 0 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'KG'
  THEN V01.menge_rech * V03.inhalt_menge
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = 0 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'ML'
  THEN V01.menge_rech * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id
       = 0 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'L'
  THEN V01.menge_rech * V03.inhalt_menge -- länderübergreifend

  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id = 0 AND V03.basismenge_einh_id
     = 'KG'
  THEN V01.menge_rech
  ELSE 0
  END AS bsch_menge_dz_norm,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = -111
  THEN V01.menge_rech
  ELSE NULL
  END AS bsch_menge_ret_zl,
  CASE
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id =
      -111 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'G'
  THEN V01.menge_rech * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id =
      -111 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'KG'
  THEN V01.menge_rech * V03.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id =
      -111 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'ML'
  THEN V01.menge_rech * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id =
      -111 AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'L'
  THEN V01.menge_rech * V03.faktor_nettoinhalt -- KMO

  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id =
      -111 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'G'
  THEN V01.menge_rech * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id =
      -111 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'KG'
  THEN V01.menge_rech * V03.inhalt_menge
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id =
      -111 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'ML'
  THEN V01.menge_rech * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id =
      -111 AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'L'
  THEN V01.menge_rech * V03.inhalt_menge -- länderübergreifend

  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = -111 AND V03.basismenge_einh_id
     = 'KG'
  THEN V01.menge_rech
  ELSE 0
  END AS bsch_menge_ret_zl_norm,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id IN (0)
  THEN V01.menge_rech
  ELSE NULL
  END AS bsch_menge_ret_dz,
  CASE
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = 0
    AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'G'
  THEN V01.menge_rech * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = 0
    AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'KG'
  THEN V01.menge_rech * V03.faktor_nettoinhalt
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = 0
    AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'ML'
  THEN V01.menge_rech * (V03.faktor_nettoinhalt / 1000)
  WHEN V01.mandant_id = 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = 0
    AND V03.basismenge_einh_id = 'ST' AND V03.einh_id = 'L'
  THEN V01.menge_rech * V03.faktor_nettoinhalt -- KMO

  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = 0
    AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'G'
  THEN V01.menge_rech * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = 0
    AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'KG'
  THEN V01.menge_rech * V03.inhalt_menge
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = 0
    AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'ML'
  THEN V01.menge_rech * (V03.inhalt_menge / 1000)
  WHEN V01.mandant_id > 1 AND CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = 0
    AND V03.basismenge_einh_id = 'ST' AND V03.inhalt_menge_einh_id = 'L'
  THEN V01.menge_rech * V03.inhalt_menge -- länderübergreifend

  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = 0 AND V03.basismenge_einh_id
     = 'KG'
  THEN V01.menge_rech
  ELSE 0
  END AS bsch_menge_ret_dz_norm,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id = -111
  THEN V01.ek_n
  ELSE NULL
  END AS lief_ek_n_umsatz_zl,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id IN (0)
  THEN V01.ek_n
  ELSE NULL
  END AS lief_ek_n_umsatz_dz,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = -111
  THEN V01.ek_n
  ELSE NULL
  END AS lief_ek_n_umsatz_ret_zl,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id IN (0)
  THEN V01.ek_n
  ELSE NULL
  END AS lief_ek_n_umsatz_ret_dz,
 V01.ek_mep,
 0,
 V01.ek_mep AS ek_mep0,
 V01.ek_kb,
 0,
 V01.ek_nn,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915)
  THEN V01.ek_mep
  ELSE 0
  END AS lief_ek_mep_umsatz,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id = -111
  THEN V01.ek_mep
  ELSE 0
  END AS lief_ek_mep_umsatz_zl,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902, 905, 906, 913, 915) AND V01.nb_id IN (0)
  THEN V01.ek_mep
  ELSE 0
  END AS lief_ek_mep_umsatz_dz,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916)
  THEN V01.ek_mep
  ELSE 0
  END AS lief_ek_mep_umsatz_ret,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id = -111
  THEN V01.ek_mep
  ELSE 0
  END AS lief_ek_mep_umsatz_ret_zl,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162, 907, 908, 912, 916) AND V01.nb_id IN (0)
  THEN V01.ek_mep
  ELSE 0
  END AS lief_ek_mep_umsatz_ret_dz,
 -- SPEC0236778
 0 AS lief_ek_mep_vor_fwu_umsatz,
 0 AS lief_ek_mep_vor_fwu_umsatz_zl,
 0 AS lief_ek_mep_vor_fwu_umsatz_dz,
 0 AS lief_ek_mep_vor_fwu_umsatz_ret,
 0 AS lief_ek_mep_vor_fwu_umsatz_ret_zl,
 0 AS lief_ek_mep_vor_fwu_umsatz_ret_dz,
 V01.logkosten,
 V01.status AS wewa_status,
 'EUR' AS wrg_id,
 SUBSTR(CASE
   WHEN V2.posten_id NOT IN ('PN', 'PF', 'SP')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_bsch_rech_det AS V01
 LEFT JOIN kfl_production_dbp_view.v_art_per AS V2 ON V01.art_id = V2.art_id AND V01.mandant_id = V2.mandant_id AND V01
   .dat BETWEEN DATE_SUB(V2.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V2.dat_bis, INTERVAL 1 DAY))
 INNER JOIN kfl_production_dbp_view.v_art AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
WHERE V01.mandant_id = 1
 AND V01.status <> 2
 AND V01.nb_id NOT IN (2, 6, 7);
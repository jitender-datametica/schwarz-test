-- 03.07.2013 #585784 sschücke / Erweiterung um Feld betrag_vk_netto

-- 25.11.2019 SPEC0066248 -fields konditionsbetrag_zar5 and ek_brutto added

-- 05.11.2012 AL Datentypanpassung EK nettonetto und Einstandspreis auf BIGNUMERIC(38,5)

-- 31.01.2024 staeblern / Aktionskonditionsmetriken ADD COALESCE ek_netto_normal, da nicht immer vorhanden

-- 28.02.2024 staeblern / Simulationsmetriken angleichen - zwei neue Fakten für die Anpassung der Metriken im FE

-- 03.04.2012 AL neu erstellt
 -- 19.09.2012 AL ergänzt um ekn2 (ek_nettonetto)

-- 21.11.2023 staeblern / Umbenennung der Spalte Betrag zu betrag_ek_netto

-- 12.12.2023 staeblern / Aktionskonditionsmetriken

-- 23.06.2025 prescher / SPEC0313583- Aufnahme Fakt Kalkulationsbasis

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wewa_1 AS
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025

-- nochmals die Werte damit nur bei RO wir werte erhalten.
 SELECT V01.mandant_id,
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
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN V01.betrag_ek_netto
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN V01.betrag_ek_netto * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN V01.betrag_ek_netto * V01.umrechnungskurs_1
   ELSE NULL
   END AS NUMERIC) AS betrag_ekn,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN V01.betrag_vk_netto
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN V01.betrag_vk_netto * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN V01.betrag_vk_netto * V01.umrechnungskurs_1
   ELSE NULL
   END AS NUMERIC) AS betrag_vk_netto,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111
  THEN V01.menge_basis
  ELSE NULL
  END AS wewa_menge_zl,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0
  THEN V01.menge_basis
  ELSE NULL
  END AS wewa_menge_dz,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111
  THEN V01.menge_basis
  ELSE NULL
  END AS wewa_menge_ret_zl,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0
  THEN V01.menge_basis
  ELSE NULL
  END AS wewa_menge_ret_dz,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111
  THEN CAST(CASE
    WHEN V200.wrg_typ_id = 1
    THEN V01.betrag_ek_netto
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN V01.betrag_ek_netto * V01.umrechnungskurs_0
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN V01.betrag_ek_netto * V01.umrechnungskurs_1
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
    THEN V01.betrag_ek_netto * V01.umrechnungskurs_0
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN V01.betrag_ek_netto * V01.umrechnungskurs_1
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
    THEN V01.betrag_ek_netto * V01.umrechnungskurs_0
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN V01.betrag_ek_netto * V01.umrechnungskurs_1
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
    THEN V01.betrag_ek_netto * V01.umrechnungskurs_0
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN V01.betrag_ek_netto * V01.umrechnungskurs_1
    ELSE NULL
    END AS NUMERIC)
  ELSE NULL
  END AS wewa_betrag_ret_dz,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.einstandspreis_v02, V01.einstandspreis_v03)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.einstandspreis_v02, V01.einstandspreis_v03) * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.einstandspreis_v02, V01.einstandspreis_v03) * V01.umrechnungskurs_1
   ELSE NULL
   END AS BIGNUMERIC) AS einstandspreis,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_mep_vor_fwu_v02, V01.ek_mep_vor_fwu_v03)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.ek_mep_vor_fwu_v02, V01.ek_mep_vor_fwu_v03) * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.ek_mep_vor_fwu_v02, V01.ek_mep_vor_fwu_v03) * V01.umrechnungskurs_1
   ELSE NULL
   END AS BIGNUMERIC) AS ek_mep_vor_fwu,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_mep_v02, V01.ek_mep_v03)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.ek_mep_v02, V01.ek_mep_v03) * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.ek_mep_v02, V01.ek_mep_v03) * V01.umrechnungskurs_1
   ELSE NULL
   END AS BIGNUMERIC) AS ek_mep,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_kalkulationsbasis_v02, V01.ek_kalkulationsbasis_v03)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.ek_kalkulationsbasis_v02, V01.ek_kalkulationsbasis_v03) * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.ek_kalkulationsbasis_v02, V01.ek_kalkulationsbasis_v03) * V01.umrechnungskurs_1
   ELSE NULL
   END AS BIGNUMERIC) AS ek_kalkulationsbasis,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_kalkulationsbasis_ohne_fwu_v02, V01.ek_kalkulationsbasis_ohne_fwu_v03)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.ek_kalkulationsbasis_ohne_fwu_v02, V01.ek_kalkulationsbasis_ohne_fwu_v03) * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.ek_kalkulationsbasis_ohne_fwu_v02, V01.ek_kalkulationsbasis_ohne_fwu_v03) * V01.umrechnungskurs_1
   ELSE NULL
   END AS BIGNUMERIC) AS ek_kalkulationsbasis_ohne_fwu,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_nettonetto_v02, V01.ek_nettonetto_v03)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.ek_nettonetto_v02, V01.ek_nettonetto_v03) * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.ek_nettonetto_v02, V01.ek_nettonetto_v03) * V01.umrechnungskurs_1
   ELSE NULL
   END AS BIGNUMERIC) AS ek_nettonetto,
 V01.konditionsbetrag_zar5,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_1
   ELSE NULL
   END AS BIGNUMERIC) AS ek_brutto,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_1
   ELSE NULL
   END AS BIGNUMERIC) AS ek_brutto_normal,
 V01.wewa_status,
 V01.wrg_id,
 V01.posten_kz_per,
  CASE
  WHEN V01.mandant_id = 7
  THEN COALESCE(V01.menge_basis * CAST(CASE
        WHEN V200.wrg_typ_id = 1
        THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03)
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
        THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_0
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
        THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_1
        ELSE NULL
        END AS BIGNUMERIC), 0) - V01.menge_basis * CAST(CASE
       WHEN V200.wrg_typ_id = 1
       THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03)
       WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
       THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_0
       WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
       THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_1
       ELSE NULL
       END AS BIGNUMERIC) + V01.menge_basis * CAST(CASE
         WHEN V200.wrg_typ_id = 1
         THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03)
         WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
         THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_0
         WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
         THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_1
         ELSE NULL
         END AS BIGNUMERIC) * V01.konditionsbetrag_zar5 / 1000 * - 1
  ELSE V01.menge_basis * CAST(CASE
        WHEN V200.wrg_typ_id = 1
        THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03)
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
        THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_0
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
        THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_1
        ELSE NULL
        END AS BIGNUMERIC) * V01.konditionsbetrag_zar5 / 1000 * - 1
  END AS we_betrag_aktionskond,
  CASE
  WHEN V01.mandant_id = 7
  THEN IF(V01.menge_basis * CAST(CASE
       WHEN V200.wrg_typ_id = 1
       THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03)
       WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
       THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_0
       WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
       THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_1
       ELSE NULL
       END AS BIGNUMERIC) = 0, NULL, V01.menge_basis * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_0
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_1
      ELSE NULL
      END AS BIGNUMERIC))
  ELSE IF(V01.menge_basis * CAST(CASE
       WHEN V200.wrg_typ_id = 1
       THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03)
       WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
       THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_0
       WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
       THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_1
       ELSE NULL
       END AS BIGNUMERIC) = 0, NULL, V01.menge_basis * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_0
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_1
      ELSE NULL
      END AS BIGNUMERIC))
  END AS we_wert_ek_brutto_normalkalk_inkl_ret,
  CASE
  WHEN V01.mandant_id = 7
  THEN COALESCE(V01.menge_basis * CAST(CASE
        WHEN V200.wrg_typ_id = 1
        THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03)
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
        THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_0
        WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
        THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_1
        ELSE NULL
        END AS BIGNUMERIC), 0) - V01.menge_basis * CAST(CASE
       WHEN V200.wrg_typ_id = 1
       THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03)
       WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
       THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_0
       WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
       THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_1
       ELSE NULL
       END AS BIGNUMERIC) + V01.menge_basis * CAST(CASE
         WHEN V200.wrg_typ_id = 1
         THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03)
         WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
         THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_0
         WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
         THEN COALESCE(V01.ek_brutto_v02, V01.ek_brutto_v03) * V01.umrechnungskurs_1
         ELSE NULL
         END AS BIGNUMERIC) * V01.konditionsbetrag_zar5 / 1000 * - 1
  ELSE 0
  END AS we_betrag_aktionskond_nur_ro,
  CASE
  WHEN V01.mandant_id = 7
  THEN IF(V01.menge_basis * CAST(CASE
       WHEN V200.wrg_typ_id = 1
       THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03)
       WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
       THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_0
       WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
       THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_1
       ELSE NULL
       END AS BIGNUMERIC) = 0, NULL, V01.menge_basis * CAST(CASE
      WHEN V200.wrg_typ_id = 1
      THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03)
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_0
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(V01.ek_brutto_normal_v02, V01.ek_brutto_normal_v03) * V01.umrechnungskurs_1
      ELSE NULL
      END AS BIGNUMERIC))
  ELSE CAST(IF(0 = 0, NULL, 0) AS BIGNUMERIC)
  END AS we_wert_ek_brutto_normalkalk_inkl_ret_nur_ro
FROM kfl_production_dbp_msi_view_ais_kmo.tbl_mv_wewa_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE;
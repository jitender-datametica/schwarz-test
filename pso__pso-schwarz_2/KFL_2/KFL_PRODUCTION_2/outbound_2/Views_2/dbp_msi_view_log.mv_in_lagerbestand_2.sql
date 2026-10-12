-- 2024-03-04, dknop, updating logic for currency conversion

-- 2023-03-22,AP0162037, dknop, adding wert_unfrei_euro and wert_frei_euro for last day of month

-- AP0133256_SPEC0166769, dknop, initial
 CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_in_lagerbestand_2(USERID STRING) AS SELECT IN_A_BEW.in_art_id
 ,
 IN_A_BEW.mandant_id,
 IN_A_BEW.dat,
 IN_A_BEW.bewertungskreis_id,
  IN_A_BEW.betrag_preis_bestand / IF(IN_A_BEW.menge_bestand_bme = 0, NULL, IN_A_BEW.menge_bestand_bme) AS gld,
 IN_LAG_PER.menge_lgbest_frei_bme AS menge_frei,
   IN_A_BEW.betrag_preis_bestand / IF(IN_A_BEW.menge_bestand_bme = 0, NULL, IN_A_BEW.menge_bestand_bme) * IN_LAG_PER.menge_lgbest_frei_bme
   AS wert_frei,
  CASE
  WHEN M_WRG.wrg_typ_id = 0
  THEN IN_A_BEW.betrag_preis_bestand / IF(IN_A_BEW.menge_bestand_bme = 0, NULL, IN_A_BEW.menge_bestand_bme) * IN_LAG_PER
    .menge_lgbest_frei_bme * KURS.umrechnungskurs
  ELSE IN_A_BEW.betrag_preis_bestand / IF(IN_A_BEW.menge_bestand_bme = 0, NULL, IN_A_BEW.menge_bestand_bme) * IN_LAG_PER
   .menge_lgbest_frei_bme
  END AS wert_frei_euro,
     IN_LAG_PER.menge_lgbest_umlag_bme + IN_LAG_PER.menge_lgbest_qual_bme + IN_LAG_PER.menge_lgbest_nf_charge_bme +
   IN_LAG_PER.menge_lgbest_gesp_bme + IN_LAG_PER.menge_lgbest_ret_gesp_bme AS menge_unfrei,
   IN_A_BEW.betrag_preis_bestand / IF(IN_A_BEW.menge_bestand_bme = 0, NULL, IN_A_BEW.menge_bestand_bme) * (IN_LAG_PER.menge_lgbest_umlag_bme
        + IN_LAG_PER.menge_lgbest_qual_bme + IN_LAG_PER.menge_lgbest_nf_charge_bme + IN_LAG_PER.menge_lgbest_gesp_bme +
    IN_LAG_PER.menge_lgbest_ret_gesp_bme) AS wert_unfrei,
  CASE
  WHEN M_WRG.wrg_typ_id = 0
  THEN IN_A_BEW.betrag_preis_bestand / IF(IN_A_BEW.menge_bestand_bme = 0, NULL, IN_A_BEW.menge_bestand_bme) * (IN_LAG_PER
         .menge_lgbest_umlag_bme + IN_LAG_PER.menge_lgbest_qual_bme + IN_LAG_PER.menge_lgbest_nf_charge_bme + IN_LAG_PER
       .menge_lgbest_gesp_bme + IN_LAG_PER.menge_lgbest_ret_gesp_bme) * KURS.umrechnungskurs
  ELSE IN_A_BEW.betrag_preis_bestand / IF(IN_A_BEW.menge_bestand_bme = 0, NULL, IN_A_BEW.menge_bestand_bme) * (IN_LAG_PER
        .menge_lgbest_umlag_bme + IN_LAG_PER.menge_lgbest_qual_bme + IN_LAG_PER.menge_lgbest_nf_charge_bme + IN_LAG_PER
      .menge_lgbest_gesp_bme + IN_LAG_PER.menge_lgbest_ret_gesp_bme)
  END AS wert_unfrei_euro,
  CASE
  WHEN IN_A_BEW.dat = LAST_DAY(IN_A_BEW.dat, MONTH)
  THEN CASE
   WHEN M_WRG.wrg_typ_id = 0
   THEN IN_A_BEW.betrag_preis_bestand / IF(IN_A_BEW.menge_bestand_bme = 0, NULL, IN_A_BEW.menge_bestand_bme) *
     IN_LAG_PER.menge_lgbest_frei_bme * KURS.umrechnungskurs
   ELSE IN_A_BEW.betrag_preis_bestand / IF(IN_A_BEW.menge_bestand_bme = 0, NULL, IN_A_BEW.menge_bestand_bme) *
    IN_LAG_PER.menge_lgbest_frei_bme
   END
  ELSE NULL
  END AS wert_frei_euro_ldom,
  CASE
  WHEN IN_A_BEW.dat = LAST_DAY(IN_A_BEW.dat, MONTH)
  THEN CASE
   WHEN M_WRG.wrg_typ_id = 0
   THEN IN_A_BEW.betrag_preis_bestand / IF(IN_A_BEW.menge_bestand_bme = 0, NULL, IN_A_BEW.menge_bestand_bme) * (IN_LAG_PER
          .menge_lgbest_umlag_bme + IN_LAG_PER.menge_lgbest_qual_bme + IN_LAG_PER.menge_lgbest_nf_charge_bme +
        IN_LAG_PER.menge_lgbest_gesp_bme + IN_LAG_PER.menge_lgbest_ret_gesp_bme) * KURS.umrechnungskurs
   ELSE IN_A_BEW.betrag_preis_bestand / IF(IN_A_BEW.menge_bestand_bme = 0, NULL, IN_A_BEW.menge_bestand_bme) * (IN_LAG_PER
         .menge_lgbest_umlag_bme + IN_LAG_PER.menge_lgbest_qual_bme + IN_LAG_PER.menge_lgbest_nf_charge_bme + IN_LAG_PER
       .menge_lgbest_gesp_bme + IN_LAG_PER.menge_lgbest_ret_gesp_bme)
   END
  ELSE NULL
  END AS wert_unfrei_euro_ldom,
 M_WRG.wrg_id,
 IN_LAG_PER.in_lagerort_id,
 IN_LAG_PER.werk_id
FROM kfl_production_dbp_view.v_in_art_bewertungskreis_tag_2 AS IN_A_BEW
 LEFT JOIN kfl_production_dbp_view.v_in_lagerbestand_per_2 AS IN_LAG_PER ON IN_A_BEW.in_art_id = IN_LAG_PER.in_art_id AND
     IN_A_BEW.mandant_id = IN_LAG_PER.mandant_id AND IN_A_BEW.dat BETWEEN IN_LAG_PER.dat_von AND IN_LAG_PER.dat_bis AND CAST(IN_A_BEW.bewertungskreis_id AS FLOAT64)
   = IN_LAG_PER.werk_id
 LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_2 AS KURS_2 ON IN_A_BEW.wrg_id = KURS.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS M_WRG ON IN_A_BEW.mandant_id = M_WRG.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS WRG_USER ON M_WRG.wrg_typ_id = WRG_USER.wrg_typ_id;
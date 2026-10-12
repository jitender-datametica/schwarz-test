CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_mietertrag_denorm_1 AS SELECT sub01.mandant_id,
 sub01.debitor_id,
 sub01.immo_objekt_id,
 sub01.kjmo,
 sub03.anz_immo,
  sub01.bet_miete * KURS.kurs_1 AS betrag_miete,
  sub01.bet_zahlung * KURS.kurs_1 AS betrag_zahlung,
  sub01.bet_ruecklast * KURS.kurs_1 AS betrag_ruecklast,
  sub01.bet_storno * KURS.kurs_1 AS betrag_storno,
  sub01.bet_sonst * KURS.kurs_1 AS betrag_sonst,
      sub01.bet_miete * KURS.kurs_1 + sub01.bet_zahlung * KURS.kurs_1 + sub01.bet_ruecklast * KURS.kurs_1 + sub01.bet_storno *
    KURS.kurs_1 + sub01.bet_sonst * KURS.kurs_1 AS betrag_gesamt,
 sub02.max_abzug_id AS abzug_id,
 TRUNC(CAST(sub02.saldo_vortrag * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)) AS wert_vortrag,
 TRUNC(CAST(sub02.summe_soll * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)) AS wert_soll,
  TRUNC(CAST(sub02.saldo_vortrag * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)) + TRUNC(CAST(sub02.summe_soll * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)
   ) AS wert_faellig,
 TRUNC(CAST(sub02.summe_haben * - 1 * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)) AS wert_haben,
  TRUNC(CAST(sub02.summe_soll * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)) + TRUNC(CAST(sub02.summe_haben * - 1 * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)
   ) AS wert_offen,
 TRUNC(CAST(sub02.saldo_konto * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)) AS wert_saldo,
 COALESCE(TRUNC(CAST(sub02.summe_haben_10 * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)), 0) AS wert_haben10,
 COALESCE(TRUNC(CAST((sub02.summe_haben_20 - sub02.summe_haben_10) * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)), 0) AS
 wert_haben20,
 COALESCE(TRUNC(CAST((sub02.summe_haben_30 - COALESCE(sub02.summe_haben_20, sub02.summe_haben_10)) * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)
   ), 0) AS wert_haben30,
 COALESCE(TRUNC(CAST((sub02.summe_haben_0 - COALESCE(sub02.summe_haben_30, sub02.summe_haben_20, sub02.summe_haben_10)) * KURS.kurs_1 / sub03.anz_immo AS BIGNUMERIC)
   ), 0) AS wert_haben00,
 KURS.wrg_id,
 KURS.wrg_typ_id
FROM (SELECT mandant_id,
   debitor_id,
   immo_objekt_id,
   kjmo,
   wrg_id,
   SUM(CASE
     WHEN mandant_id = 1 AND belegart_id IN ('AD', 'AM', 'AN', 'BM', 'BN', 'EK', 'PV') OR mandant_id <> 1 AND
        belegart_id IN ('DG', 'DR', 'JD', 'JQ', 'RV')
     THEN konto_betrag
     ELSE 0.00
     END) AS bet_miete,
   SUM(CASE
     WHEN mandant_id = 1 AND belegart_id IN ('AD', 'AM', 'AN', 'BM', 'BN', 'EK', 'PV') OR mandant_id <> 1 AND
        belegart_id IN ('DG', 'DR', 'JD', 'JQ', 'RV')
     THEN konto_betrag
     ELSE 0.00
     END) AS bet_zahlung,
   SUM(CASE
     WHEN mandant_id = 1 AND belegart_id IN ('GA', 'GL')
     THEN konto_betrag
     ELSE 0.00
     END) AS bet_ruecklast,
   SUM(CASE
     WHEN mandant_id = 1 AND belegart_id IN ('AD', 'AM', 'AN', 'BM', 'BN', 'EK', 'PV') OR mandant_id <> 1 AND
        belegart_id IN ('DG', 'DR', 'JD', 'JQ', 'RV')
     THEN konto_betrag
     ELSE 0.00
     END) AS bet_storno,
   SUM(CASE
     WHEN mandant_id = 1 AND belegart_id NOT IN ('AD', 'AM', 'AN', 'BM', 'BN', 'EK', 'PV', '45', '46', 'EA', 'EB', 'EE'
         , 'ES', 'EU', 'GE', 'GZ', 'KO', 'SX', 'GA', 'GL', '31', '36', '37', '38', '39', '49', '79', 'ZE') OR mandant_id
         <> 1 AND belegart_id NOT IN ('DG', 'DR', 'JD', 'JQ', 'RV', 'KO', 'ZP', 'SB', 'JB')
     THEN konto_betrag
     ELSE 0.00
     END) AS bet_sonst
  FROM kfl_production_dbp_view.v_ivs_mietertrag_detail_1
  GROUP BY mandant_id,
   debitor_id,
   immo_objekt_id,
   kjmo,
   wrg_id) AS sub01
 INNER JOIN (SELECT SUB021.mandant_id,
   SUB021.debitor_id,
   SUB021.kjmo,
   sub022.max_abzug_id,
   SUB021.saldo_vortrag,
   SUB021.summe_soll,
   SUB021.summe_haben,
   SUB021.saldo_konto,
   sub022.summe_haben_10,
   sub022.summe_haben_20,
   sub022.summe_haben_30,
   sub022.summe_haben_0,
   SUB021.saldo_soll,
   SUB021.saldo_haben,
   SUB021.wrg_id
  FROM kfl_production_dbp_view.v_ivs_debitor_kontostand_1 AS SUB021
   INNER JOIN (SELECT mandant_id,
     debitor_id,
     kjmo,
     wrg_id,
      CASE
      WHEN MIN(abzug_id) = 0
      THEN 0
      ELSE MAX(abzug_id)
      END AS max_abzug_id,
     SUM(CASE
       WHEN abzug_id = 10
       THEN summe_haben * - 1
       ELSE NULL
       END) AS summe_haben_10,
     SUM(CASE
       WHEN abzug_id = 20
       THEN summe_haben * - 1
       ELSE NULL
       END) AS summe_haben_20,
     SUM(CASE
       WHEN abzug_id = 30
       THEN summe_haben * - 1
       ELSE NULL
       END) AS summe_haben_30,
     SUM(CASE
       WHEN abzug_id = 0
       THEN summe_haben * - 1
       ELSE NULL
       END) AS summe_haben_0
    FROM kfl_production_dbp_view.v_ivs_debitor_kontostand_1
    GROUP BY mandant_id,
     debitor_id,
     kjmo,
     wrg_id) AS sub022 ON SUB021.mandant_id = sub022.mandant_id AND SUB021.debitor_id = sub022.debitor_id AND SUB021.kjmo
        = sub022.kjmo AND SUB021.abzug_id = sub022.max_abzug_id AND SUB021.wrg_id = sub022.wrg_id) AS sub02 ON sub01.mandant_id
      = sub02.mandant_id AND sub01.debitor_id = sub02.debitor_id AND sub01.kjmo = sub02.kjmo AND sub01.wrg_id = sub02.wrg_id
   
 INNER JOIN (SELECT mandant_id,
   debitor_id,
   kjmo,
   wrg_id,
   COUNT(DISTINCT immo_objekt_id) AS anz_immo
  FROM kfl_production_dbp_view.v_ivs_mietertrag_detail_1
  GROUP BY debitor_id,
   mandant_id,
   kjmo,
   wrg_id) AS sub03 ON sub01.mandant_id = sub03.mandant_id AND sub01.debitor_id = sub03.debitor_id AND sub01.kjmo =
    sub03.kjmo AND sub01.wrg_id = sub03.wrg_id
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS ZEIT_1 ON sub01.kjmo = ZEIT.kjmo
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_1 AS KURS_1 ON sub01.mandant_id = KURS.mandant_id AND
   ZEIT.max_dat BETWEEN KURS.kurs_dat_von AND KURS.kurs_dat_bis;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_belegart_belegtyp_zu_2 AS SELECT DISTINCT mandant_id,
 belegart_id,
 CAST(CASE
   WHEN mandant_id = 1 AND belegart_id IN ('AD', 'AM', 'AN', 'BM', 'BN', 'EK', 'PV') OR mandant_id <> 1 AND belegart_id IN ('DG', 'DR', 'JD', 'JQ', 'RV')
   THEN 10
   WHEN mandant_id = 1 AND belegart_id IN ('45', '46', 'EA', 'EB', 'EE', 'ES', 'EU', 'GE', 'GZ', 'KO', 'SX') OR mandant_id <> 1 AND belegart_id IN ('KO', 'ZP', 'SB')
   THEN 20
   WHEN mandant_id = 1 AND belegart_id IN ('GA', 'GL')
   THEN 30
   WHEN mandant_id = 1 AND belegart_id IN ('31', '36', '37', '38', '39', '49', '79', 'ZE') OR mandant_id <> 1 AND belegart_id IN ('JB')
   THEN 40
   ELSE 99
   END AS BIGNUMERIC) AS belegtyp_id,
 CAST(CASE
   WHEN CAST(CASE
      WHEN mandant_id = 1 AND belegart_id IN ('AD', 'AM', 'AN', 'BM', 'BN', 'EK', 'PV') OR mandant_id <> 1 AND belegart_id IN ('DG', 'DR', 'JD', 'JQ', 'RV')
      THEN 10
      WHEN mandant_id = 1 AND belegart_id IN ('45', '46', 'EA', 'EB', 'EE', 'ES', 'EU', 'GE', 'GZ', 'KO', 'SX') OR mandant_id <> 1 AND belegart_id IN ('KO', 'ZP', 'SB')
      THEN 20
      WHEN mandant_id = 1 AND belegart_id IN ('GA', 'GL')
      THEN 30
      WHEN mandant_id = 1 AND belegart_id IN ('31', '36', '37', '38', '39', '49', '79', 'ZE') OR mandant_id <> 1 AND belegart_id IN ('JB')
      THEN 40
      ELSE 99
      END AS BIGNUMERIC) = 10
   THEN 'Miete'
   WHEN CAST(CASE
      WHEN mandant_id = 1 AND belegart_id IN ('AD', 'AM', 'AN', 'BM', 'BN', 'EK', 'PV') OR mandant_id <> 1 AND belegart_id IN ('DG', 'DR', 'JD', 'JQ', 'RV')
      THEN 10
      WHEN mandant_id = 1 AND belegart_id IN ('45', '46', 'EA', 'EB', 'EE', 'ES', 'EU', 'GE', 'GZ', 'KO', 'SX') OR mandant_id <> 1 AND belegart_id IN ('KO', 'ZP', 'SB')
      THEN 20
      WHEN mandant_id = 1 AND belegart_id IN ('GA', 'GL')
      THEN 30
      WHEN mandant_id = 1 AND belegart_id IN ('31', '36', '37', '38', '39', '49', '79', 'ZE') OR mandant_id <> 1 AND belegart_id IN ('JB')
      THEN 40
      ELSE 99
      END AS BIGNUMERIC) = 20
   THEN 'Zahlung'
   WHEN CAST(CASE
      WHEN mandant_id = 1 AND belegart_id IN ('AD', 'AM', 'AN', 'BM', 'BN', 'EK', 'PV') OR mandant_id <> 1 AND belegart_id IN ('DG', 'DR', 'JD', 'JQ', 'RV')
      THEN 10
      WHEN mandant_id = 1 AND belegart_id IN ('45', '46', 'EA', 'EB', 'EE', 'ES', 'EU', 'GE', 'GZ', 'KO', 'SX') OR mandant_id <> 1 AND belegart_id IN ('KO', 'ZP', 'SB')
      THEN 20
      WHEN mandant_id = 1 AND belegart_id IN ('GA', 'GL')
      THEN 30
      WHEN mandant_id = 1 AND belegart_id IN ('31', '36', '37', '38', '39', '49', '79', 'ZE') OR mandant_id <> 1 AND belegart_id IN ('JB')
      THEN 40
      ELSE 99
      END AS BIGNUMERIC) = 30
   THEN 'Rücklastschrift'
   WHEN CAST(CASE
      WHEN mandant_id = 1 AND belegart_id IN ('AD', 'AM', 'AN', 'BM', 'BN', 'EK', 'PV') OR mandant_id <> 1 AND belegart_id IN ('DG', 'DR', 'JD', 'JQ', 'RV')
      THEN 10
      WHEN mandant_id = 1 AND belegart_id IN ('45', '46', 'EA', 'EB', 'EE', 'ES', 'EU', 'GE', 'GZ', 'KO', 'SX') OR mandant_id <> 1 AND belegart_id IN ('KO', 'ZP', 'SB')
      THEN 20
      WHEN mandant_id = 1 AND belegart_id IN ('GA', 'GL')
      THEN 30
      WHEN mandant_id = 1 AND belegart_id IN ('31', '36', '37', '38', '39', '49', '79', 'ZE') OR mandant_id <> 1 AND belegart_id IN ('JB')
      THEN 40
      ELSE 99
      END AS BIGNUMERIC) = 40
   THEN 'Storno'
   WHEN CAST(CASE
      WHEN mandant_id = 1 AND belegart_id IN ('AD', 'AM', 'AN', 'BM', 'BN', 'EK', 'PV') OR mandant_id <> 1 AND belegart_id IN ('DG', 'DR', 'JD', 'JQ', 'RV')
      THEN 10
      WHEN mandant_id = 1 AND belegart_id IN ('45', '46', 'EA', 'EB', 'EE', 'ES', 'EU', 'GE', 'GZ', 'KO', 'SX') OR mandant_id <> 1 AND belegart_id IN ('KO', 'ZP', 'SB')
      THEN 20
      WHEN mandant_id = 1 AND belegart_id IN ('GA', 'GL')
      THEN 30
      WHEN mandant_id = 1 AND belegart_id IN ('31', '36', '37', '38', '39', '49', '79', 'ZE') OR mandant_id <> 1 AND belegart_id IN ('JB')
      THEN 40
      ELSE 99
      END AS BIGNUMERIC) = 99
   THEN 'Sonst. Buchung'
   ELSE NULL
   END AS STRING) AS belegtyp_bez
FROM kfl_production_dbp_view.v_ivs_mietertrag_detail_2;
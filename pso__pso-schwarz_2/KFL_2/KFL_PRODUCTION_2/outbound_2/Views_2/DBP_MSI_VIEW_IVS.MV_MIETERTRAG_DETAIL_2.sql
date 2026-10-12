CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_mietertrag_detail_2 AS SELECT MED.mandant_id,
 MED.debitor_id,
 MED.immo_objekt_id,
 MED.kjmo,
 MED.sachkonto_id,
 MED.belegart_id,
 CAST(CASE
   WHEN MED.mandant_id = 1 AND MED.belegart_id IN ('AD', 'AM', 'AN', 'BM', 'BN', 'EK', 'PV') OR MED.mandant_id <> 1 AND MED.belegart_id IN ('DG', 'DR', 'JD', 'JQ', 'RV')
   THEN 10
   WHEN MED.mandant_id = 1 AND MED.belegart_id IN ('45', '46', 'EA', 'EB', 'EE', 'ES', 'EU', 'GE', 'GZ', 'KO', 'SX') OR MED.mandant_id <> 1 AND MED.belegart_id IN ('KO', 'ZP', 'SB')
   THEN 20
   WHEN MED.mandant_id = 1 AND MED.belegart_id IN ('GA', 'GL')
   THEN 30
   WHEN MED.mandant_id = 1 AND MED.belegart_id IN ('31', '36', '37', '38', '39', '49', '79', 'ZE') OR MED.mandant_id <> 1 AND MED.belegart_id IN ('JB')
   THEN 40
   ELSE 99
   END AS BIGNUMERIC) AS belegtyp_id,
  MED.konto_betrag * KURS.kurs_2 AS konto_betrag,
 KURS.wrg_id,
 KURS.wrg_typ_id
FROM kfl_production_dbp_view.v_ivs_mietertrag_detail_2 AS MED
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS ZEIT_2 ON MED.kjmo = ZEIT.kjmo
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_2 AS KURS_2 ON MED.mandant_id = KURS.mandant_id AND
   ZEIT.max_dat BETWEEN KURS.kurs_dat_von AND KURS.kurs_dat_bis;
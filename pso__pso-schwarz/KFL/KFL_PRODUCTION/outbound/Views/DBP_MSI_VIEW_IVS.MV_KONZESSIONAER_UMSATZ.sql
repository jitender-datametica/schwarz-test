CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_konzessionaer_umsatz AS SELECT KUMO.mandant_id,
 KUMO.mietvertrag_id,
 KUMO.immo_objekt_id,
 KUMO.konzessionaer_id,
 KUMO.kjmo,
 CAST(RANK() OVER (PARTITION BY CAST(KUMO.mandant_id AS STRING), KUMO.konzessionaer_id, KUMO.mietvertrag_id, KUMO.immo_objekt_id, CAST(KURS.wrg_typ_id AS STRING) ORDER BY KUMO.kjmo IS NULL, KUMO.kjmo) AS BIGNUMERIC)
 AS kjmo_lfd,
  KUMO.betrag_umsatz * KURS.kurs AS konz_umsatz,
 KURS.wrg_id,
 KURS.wrg_typ_id
FROM kfl_production_dbp_view.v_ivs_konzessionaer_umsatz AS KUMO
 INNER JOIN kfl_production_dbp_view.v_monat AS ZEIT ON KUMO.kjmo = ZEIT.kjmo
 INNER JOIN kfl_production_dbp_view.v_l_buchungsstatus_ker AS KER ON KUMO.kjmo = KER.kj_ker_mo_id AND KUMO.kjmo <= KER.buchungs_schluss_akt
   
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per AS KURS ON KUMO.mandant_id = KURS.mandant_id AND
   ZEIT.max_dat BETWEEN KURS.kurs_dat_von AND KURS.kurs_dat_bis
WHERE KUMO.betrag_umsatz BETWEEN 0.01 AND 999999999;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_ruecklastschrift AS SELECT RL.mandant_id,
 RL.debitor_id,
 RL.kjmo,
 RL.dat_beleg,
  RL.beleg_betrag * KURS.kurs AS beleg_betrag,
 KURS.wrg_id,
 KURS.wrg_typ_id
FROM kfl_production_dbp_view.v_ivs_ruecklastschrift AS RL
 INNER JOIN kfl_production_dbp_view.v_monat AS ZEIT ON RL.kjmo = ZEIT.kjmo
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per AS KURS ON RL.mandant_id = KURS.mandant_id AND
   ZEIT.max_dat BETWEEN KURS.kurs_dat_von AND KURS.kurs_dat_bis;
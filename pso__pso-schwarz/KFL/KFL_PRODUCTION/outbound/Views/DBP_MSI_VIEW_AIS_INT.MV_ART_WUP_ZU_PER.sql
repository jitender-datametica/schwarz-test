CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_art_wup_zu_per (art_id, bezugsweg_id, dat_bis, dat_von,
listung_id, mandant_id, nb_id, vk_brutto, wup_id, kdis_kz, kdis_aenderung_dat) AS SELECT V01.art_id,
 V01.bezugsweg_id,
 V01.dat_bis,
 V01.dat_von,
 V01.listung_id,
 V01.mandant_id,
 V01.nb_id,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN ROUND(CAST(V01.vk_brutto * V03.umrechnungskurs AS BIGNUMERIC), 4)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.vk_brutto * V04.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE V01.vk_brutto
  END AS vk_brutto,
 V01.wup_id,
  CASE
  WHEN V01.kdis IS NULL OR V01.kdis = 0
  THEN ' '
  ELSE 'K'
  END AS kdis_kz,
 CURRENT_DATE AS kdis_aenderung_dat
FROM kfl_production_dbp_view.v_art_wup_zu_per AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V02 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V03 ON V01.wrg_id = V03.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs AS V04 ON V01.dat_von >= V04.dat_von AND V01.dat_bis <= V04.dat_bis AND V01.wrg_id
    = V04.von_wrg_id
WHERE V04.kurstyp_id = 3
 AND V04.nach_wrg_id = 'EUR'
 AND V03.dat_bis = DATE '9999-12-31'
 AND V03.kurstyp_id = 3
 AND V03.nach_wrg_id = 'EUR'
 AND V01.dat_bis = DATE '9999-12-31'
 AND V01.nb_id <> 99;
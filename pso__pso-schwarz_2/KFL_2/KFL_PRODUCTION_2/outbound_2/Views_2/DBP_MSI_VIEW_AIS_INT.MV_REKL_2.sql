CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_rekl_2 (dat, art_id, ean_kasse, mandant_id, wup_id, nb_id,
reklamationsgrund_id, rekl_vk_brutto, rekl_vk_netto, rekl_vk_menge, gp_id, mhd, los_charge, mwst_id, mwst, art_id_ref,
kunden_text) AS SELECT V01.dat,
 V01.art_id,
  CASE
  WHEN V01.ean_kasse IS NOT NULL
  THEN V01.ean_kasse
  ELSE 0
  END AS ean_kasse,
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.reklamationsgrund_id,
  CASE
  WHEN V2.wrg_typ_id = 0 AND V2.berichtskurs_typ_id = 0
  THEN V01.vk_brutto_re * V04.umrechnungskurs
  WHEN V2.wrg_typ_id = 0 AND V2.berichtskurs_typ_id = 1
  THEN V01.vk_brutto_re * V05.umrechnungskurs
  ELSE V01.vk_brutto_re
  END AS rekl_vk_brutto,
    CASE
    WHEN V2.wrg_typ_id = 0 AND V2.berichtskurs_typ_id = 0
    THEN V01.vk_brutto_re * V04.umrechnungskurs
    WHEN V2.wrg_typ_id = 0 AND V2.berichtskurs_typ_id = 1
    THEN V01.vk_brutto_re * V05.umrechnungskurs
    ELSE V01.vk_brutto_re
    END * 100 / (100 + V03.mwst) AS rekl_vk_netto,
 V01.vk_menge_re AS rekl_vk_menge,
 V01.gp_id,
 V01.mhd,
 V01.los_charge,
 V02.mwst_id,
 V03.mwst,
 V01.art_id_ref,
 V01.kunden_text
FROM kfl_production_dbp_view.v_rekl_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per_2 AS V03 ON V02.mwst_id = V03.mwst_id AND V02.mandant_id = V03.mandant_id
  AND V01.dat BETWEEN V03.dat_von AND V03.dat_bis
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V2 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V04 ON V01.wrg_id = V04.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V05 ON V01.dat BETWEEN V05.dat_von AND V05.dat_bis AND V01.wrg_id = V05.von_wrg_id
   
WHERE V05.kurstyp_id = 3
 AND V05.nach_wrg_id = 'EUR'
 AND V04.dat_bis = DATE '9999-12-31'
 AND V04.kurstyp_id = 3
 AND V04.nach_wrg_id = 'EUR'
 AND V01.bon_storno_fg = 0;
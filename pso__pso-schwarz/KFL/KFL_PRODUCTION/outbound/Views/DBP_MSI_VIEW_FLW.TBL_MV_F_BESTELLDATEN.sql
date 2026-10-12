CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_bestelldaten (mandant_id, lief_beleg_id, lief_typ_id,
dat_lief_soll, lief_beleg_pos_id, werk_id, in_art_id, in_art_nr, basismenge_einh_id, verk_menge_einh_id, nettogew,
dat_mat_bereitstllg, dat_produktion, in_kunde_id, verkaufs_beleg_id, verkaufs_beleg_pos_id, menge_auftrag_vme_kum,
menge_bes_bme_kum, menge_bes_bme_kum_kg) AS SELECT V01.mandant_id,
 V01.lief_beleg_id,
 V01.lief_typ_id,
 V01.dat_lief_soll,
 V02.lief_beleg_pos_id,
 V02.werk_id,
 V02.flw_art_id AS in_art_id,
 V11.flw_art_nr AS in_art_nr,
 V11.basismenge_einh_id,
 V02.verk_menge_einh_id,
 V02.nettogew,
 V02.dat_mat_bereitstllg,
 V03.dat_produktion,
 V01.flw_kunde_id AS in_kunde_id,
 V04.verkaufs_beleg_id,
 V04.verkaufs_beleg_pos_id,
 V04.menge_auftrag_vme_kum,
 V04.menge_bes_bme_kum,
  CASE
  WHEN V11.basismenge_einh_id = 'KG'
  THEN V04.menge_bes_bme_kum
  WHEN V11.basismenge_einh_id = 'ST'
  THEN ROUND(CAST(V04.menge_bes_bme_kum * V12.umrech_faktor AS NUMERIC), 6)
  ELSE NULL
  END AS menge_bes_bme_kum_kg
FROM kfl_production_dbp_view.v_flw_besch_lief AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_besch_lief_det AS V02 ON V01.mandant_id = V02.mandant_id AND V01.lief_beleg_id
    = V02.lief_beleg_id
 INNER JOIN kfl_production_dbp_view.v_flw_datenpool AS V03 ON V02.mandant_id = V03.mandant_id AND V02.lief_beleg_id =
     V03.lief_beleg_id AND V02.flw_art_id = V03.flw_art_id AND V03.datenpool_satzart_id IN ('KP')
 INNER JOIN kfl_production_dbp_view.v_flw_kunde_auftrag_det AS V04 ON V02.mandant_id = V04.mandant_id AND V02.vorlage_beleg_id
     = V04.verkaufs_beleg_id AND V02.flw_art_id = V04.flw_art_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art AS V11 ON V02.mandant_id = V11.mandant_id AND V02.flw_art_id = V11.flw_art_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per AS V12 ON V11.mandant_id = V12.mandant_id AND V11.flw_art_id
     = V12.flw_art_id AND CASE
    WHEN V11.basismenge_einh_id = 'ST'
    THEN 'KG'
    WHEN V11.basismenge_einh_id = 'KG'
    THEN 'ST'
    ELSE NULL
    END = V12.altnv_menge_einh_id
WHERE V01.mandant_id IN (1, 2);
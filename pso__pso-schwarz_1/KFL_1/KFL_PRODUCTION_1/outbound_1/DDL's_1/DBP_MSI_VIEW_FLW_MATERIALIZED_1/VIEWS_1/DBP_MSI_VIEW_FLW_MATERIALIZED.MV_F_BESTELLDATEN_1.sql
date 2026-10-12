CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_bestelldaten_1 (mandant_id, lief_beleg_id,
lief_typ_id, dat_lief_soll, lief_beleg_pos_id, werk_id, in_art_id, in_art_nr, basismenge_einh_id, verk_menge_einh_id,
nettogew, dat_mat_bereitstllg, dat_produktion, in_kunde_id, verkaufs_beleg_id, verkaufs_beleg_pos_id,
menge_auftrag_vme_kum, menge_bes_bme_kum, menge_bes_bme_kum_kg, stueckliste_id, stueckliste_pos_id, stueckliste_typ_id,
menge_basis, komponentenmenge, komponentenmenge_einh_id, stueckliste_pos_typ_id, in_art_id_sek, in_art_nr_sek,
art_bez_sek) AS SELECT V01.mandant_id,
 V01.lief_beleg_id,
 V01.lief_typ_id,
 V01.dat_lief_soll,
 V01.lief_beleg_pos_id,
 V01.werk_id,
 V01.in_art_id,
 V01.in_art_nr,
 V01.basismenge_einh_id,
 V01.verk_menge_einh_id,
 V01.nettogew,
 V01.dat_mat_bereitstllg,
 V01.dat_produktion,
 V01.in_kunde_id,
 V01.verkaufs_beleg_id,
 V01.verkaufs_beleg_pos_id,
 V01.menge_auftrag_vme_kum,
 V01.menge_bes_bme_kum,
 V01.menge_bes_bme_kum_kg,
 v07.stueckliste_id,
 v07.stueckliste_pos_id,
 v07.stueckliste_typ_id,
 v07.menge_basis,
 v07.komponentenmenge,
 v07.komponentenmenge_einh_id,
 v07.stueckliste_pos_typ_id,
 v07.flw_art_id_sek AS in_art_id_sek,
 v07.flw_art_nr_sek AS in_art_nr_sek,
 v07.art_bez_sek
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_bestelldaten_1 AS V01
 LEFT JOIN (SELECT V05.mandant_id,
   V05.stueckliste_id,
   V05.werk_id,
   V05.flw_art_id AS flw_art_id_primaer,
   V05.menge_basis,
   V06.stueckliste_pos_id,
   V06.stueckliste_typ_id,
   V06.komponentenmenge,
   V06.komponentenmenge_einh_id,
   V06.stueckliste_pos_typ_id,
   V06.flw_art_id AS flw_art_id_sek,
   V08.flw_art_nr AS flw_art_nr_sek,
   V09.art_bez AS art_bez_sek
  FROM kfl_production_dbp_view.v_flw_stueckliste_1 AS V05
   INNER JOIN kfl_production_dbp_view.v_flw_stueckliste_det_1 AS V06 ON V05.mandant_id = V06.mandant_id AND V05.stueckliste_id
       = V06.stueckliste_id AND V05.stueckliste_typ_id = V06.stueckliste_typ_id
   LEFT JOIN kfl_production_dbp_view.v_flw_art_1 AS V08 ON V06.mandant_id = V08.mandant_id AND V06.flw_art_id = V08.flw_art_id
     
   INNER JOIN kfl_production_dbp_view.v_flw_art_spr_zu_1 AS V09 ON V08.mandant_id = V09.mandant_id AND V08.flw_art_id =
     V09.flw_art_id
   INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V10 ON V09.spr_id = V10.spr_id
  WHERE V06.stueckliste_pos_typ_id IN ('G', 'X')
   AND V06.komponentenmenge > 0.001) AS v07 ON TRUE
WHERE V01.mandant_id IN (1, 2);
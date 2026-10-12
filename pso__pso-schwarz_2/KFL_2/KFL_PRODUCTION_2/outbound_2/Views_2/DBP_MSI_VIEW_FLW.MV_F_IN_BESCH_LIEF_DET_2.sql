CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_in_besch_lief_det_2 (lief_beleg_id, lief_beleg_pos_id,
mandant_id, dat_lief_soll, in_verkaufsorganisation_id, werk_id, lief_pos_typ_id, in_art_id, charge_id, in_vw_id,
dat_mat_bereitstllg, menge_lief_ist_bme, verk_menge_einh_id, nettogew, menge_lief_ist_lme, wrg_id, vorlage_beleg_id) AS
SELECT V01.lief_beleg_id,
 V01.lief_beleg_pos_id,
 V01.mandant_id,
 V01.dat_lief_soll,
 V01.in_verkaufsorganisation_id,
 V01.werk_id,
 V01.lief_pos_typ_id,
 V01.in_art_id,
 V01.charge_id,
 V01.in_vw_id,
 V01.dat_mat_bereitstllg,
 MAX(V01.menge_lief_ist_bme) AS menge_lief_ist_bme,
 V01.verk_menge_einh_id,
 MAX(V01.nettogew) AS nettogew,
 MAX(V01.menge_lief_ist_lme) AS menge_lief_ist_lme,
 V08.wrg_id,
 V01.vorlage_beleg_id
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_in_besch_lief_det_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V07 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V08 ON V01.mandant_id = V08.mandant_id AND V07.wrg_typ_id =
   V08.wrg_typ_id
GROUP BY V01.lief_beleg_id,
 V01.lief_beleg_pos_id,
 V01.mandant_id,
 V01.dat_lief_soll,
 V01.in_verkaufsorganisation_id,
 V01.werk_id,
 V01.lief_pos_typ_id,
 V01.in_art_id,
 V01.charge_id,
 V01.in_vw_id,
 V01.dat_mat_bereitstllg,
 V01.verk_menge_einh_id,
 V08.wrg_id,
 V01.vorlage_beleg_id;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_in_besch_lief_det (lief_beleg_id, lief_beleg_pos_id,
mandant_id, dat_lief_soll, in_verkaufsorganisation_id, werk_id, lief_pos_typ_id, in_art_id, charge_id, in_vw_id,
dat_mat_bereitstllg, menge_lief_ist_bme, verk_menge_einh_id, nettogew, menge_lief_ist_lme, vorlage_beleg_id) AS SELECT
 V01.lief_beleg_id,
 V02.lief_beleg_pos_id,
 V01.mandant_id,
 V01.dat_lief_soll,
 V01.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id,
 V02.werk_id,
 V02.lief_pos_typ_id,
 V02.flw_art_id AS in_art_id,
 V02.charge_id,
 V02.flw_vw_id AS in_vw_id,
 V02.dat_mat_bereitstllg,
 V02.menge_lief_ist_bme,
 V02.verk_menge_einh_id,
 V02.nettogew,
 V02.menge_lief_ist_lme,
 V02.vorlage_beleg_id
FROM kfl_production_dbp_view.v_flw_besch_lief AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_besch_lief_det AS V02 ON V01.mandant_id = V02.mandant_id AND V01.lief_beleg_id
    = V02.lief_beleg_id
 INNER JOIN kfl_production_dbp_view.v_flw_art AS V05 ON V01.mandant_id = V05.mandant_id AND V02.flw_art_id = V05.flw_art_id
   
WHERE V05.artikelart_id IN ('ZKMN', 'HALB', 'ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA', 'ZDIE', 'REWO', 'ZHAW',
   'ZFLV')
 AND V01.mandant_id IN (1, 2);
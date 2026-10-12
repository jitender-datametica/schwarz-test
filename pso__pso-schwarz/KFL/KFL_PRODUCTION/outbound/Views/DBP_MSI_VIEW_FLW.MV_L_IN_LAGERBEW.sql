CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_lagerbew (mandant_id, lagerbew_beleg_id, kj,
vorgangsart_id, dat_beleg, dat_buch, dat_erfasst, ref_lagerbew_beleg_id, belegkopftext) AS SELECT mandant_id,
 lagerbew_beleg_id,
 kj,
 vorgangsart_id,
 dat_beleg,
 dat_buch,
 dat_erfasst,
 ref_lagerbew_beleg_id,
 belegkopftext
FROM kfl_production_dbp_view.v_flw_lagerbew AS V01;
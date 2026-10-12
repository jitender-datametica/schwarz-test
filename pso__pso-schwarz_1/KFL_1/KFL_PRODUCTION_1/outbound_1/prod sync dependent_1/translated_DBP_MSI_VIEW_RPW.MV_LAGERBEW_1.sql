CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_lagerbew_1 (mandant_id, lagerbew_beleg_id, kj, vorgangsart_id,
dat_buch, beleg_user_name, waren_begl_schein_id, dat_beleg, dat_erfasst, belegart_id, system_id, belegkopftext,
ref_lagerbew_beleg_id) AS SELECT mandant_id,
 lagerbew_beleg_id,
 kj,
 vorgangsart_id,
 dat_buch,
 beleg_user_name,
 COALESCE(waren_begl_schein_id, '') AS waren_begl_schein_id,
 dat_beleg,
 dat_erfasst,
 belegart_id,
 7 AS system_id,
 belegkopftext,
 COALESCE(ref_lagerbew_beleg_id, '-1') AS ref_lagerbew_beleg_id
FROM kfl_production_dbp_view.v_lagerbew_1
WHERE mandant_id = 1;
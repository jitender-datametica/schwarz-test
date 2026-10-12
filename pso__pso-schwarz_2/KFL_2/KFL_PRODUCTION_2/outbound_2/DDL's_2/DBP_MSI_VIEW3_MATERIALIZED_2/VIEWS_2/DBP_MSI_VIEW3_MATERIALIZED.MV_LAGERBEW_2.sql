CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_lagerbew_2 (beleg_user_name, dat_beleg, dat_buch,
dat_erfasst, kj, lagerbew_beleg_id, mandant_id, ref_lagerbew_beleg_id, vorgangsart_id, belegkopftext,
ref_lagerbew_beleg_id_num, kj_lief_beleg) AS SELECT V01.beleg_user_name,
 V01.dat_beleg,
 V01.dat_buch,
 V01.dat_erfasst,
 V01.kj,
 V01.lagerbew_beleg_id,
 V01.mandant_id,
 V01.ref_lagerbew_beleg_id,
 V01.vorgangsart_id,
 V01.belegkopftext,
 V01.ref_lagerbew_beleg_id_num,
 V02.kj AS kj_lief_beleg
FROM kfl_production_dbp_view.v_lagerbew_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_besch_lief_2 AS V02 ON V01.ref_lagerbew_beleg_id_num = V02.lief_beleg_id AND V01.mandant_id
      = V02.mandant_id AND EXTRACT(YEAR FROM V01.dat_buch) BETWEEN V02.kj - 1 AND (V02.kj + 1) AND EXTRACT(YEAR FROM V01
    .dat_buch) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;
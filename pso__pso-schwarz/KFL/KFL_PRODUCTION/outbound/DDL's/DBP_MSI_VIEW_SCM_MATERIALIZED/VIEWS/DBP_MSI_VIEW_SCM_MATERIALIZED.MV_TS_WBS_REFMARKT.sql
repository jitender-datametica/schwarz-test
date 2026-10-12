CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_ts_wbs_refmarkt (mandant_id, wup_id, nb_id,
wup_id_ref, nb_id_ref, ref_faktor_fallback, mandant_id_vz_fallback, wup_id_vz_fallback, nb_id_vz_fallback,
fixamount_share_alg_500, fixamount_share_alg_120, estimation_fg, adjustment_fg) AS SELECT WUP.mandant_id,
 WUP.wup_id,
 WUP.nb_id,
 REF.wup_id_ref,
 REF.nb_id_ref,
 REF.ref_faktor_fallback,
 REF.mandant_id_vz_fallback,
 REF.wup_id_vz_fallback,
 REF.nb_id_vz_fallback,
 REF.fixamount_share_alg_500,
 REF.fixamount_share_alg_120,
 COALESCE(REF.estimation_fg, 1) AS estimation_fg,
 COALESCE(REF.adjustment_id, 1) AS adjustment_fg
FROM kfl_production_dbp_view.v_wup AS WUP
 LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_refmarkt AS REF ON WUP.mandant_id = REF.mandant_id AND WUP.wup_id = REF.wup_id
     AND WUP.nb_id = REF.nb_id
WHERE WUP.nb_id = 0;
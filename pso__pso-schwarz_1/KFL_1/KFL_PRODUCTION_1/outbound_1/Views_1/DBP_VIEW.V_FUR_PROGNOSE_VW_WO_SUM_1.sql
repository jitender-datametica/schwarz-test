CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fur_prognose_vw_wo_sum_1 AS SELECT mandant_id,
 vw_id,
 art_id,
 kjwo_kl,
 menge_prognose,
 menge_prognose_bef,
 menge_prognose_max,
 menge_af,
 menge_sa,
 diff_menge_af_prognose
FROM kfl_production_dbp_data.fur_prognose_vw_wo_sum_1;
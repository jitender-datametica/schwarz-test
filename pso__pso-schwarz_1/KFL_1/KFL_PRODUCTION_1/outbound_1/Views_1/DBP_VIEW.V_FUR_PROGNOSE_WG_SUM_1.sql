CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fur_prognose_wg_sum_1 AS SELECT wup_id,
 nb_id,
 mandant_id,
 wg_id,
 arthiertyp_id,
 dat,
 menge_prognose,
 menge_prognose_bef,
 menge_prognose_max,
 menge_af,
 menge_sa,
 diff_menge_af_prognose
FROM kfl_production_dbp_data.fur_prognose_wg_sum_1;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_fur_prognose_artbew_wg_sum_2 (wup_id, nb_id, mandant_id,
wg_id, dat, menge_prognose, menge_prognose_bef, menge_prognose_max, vk_menge, vk_menge_af, vk_menge_sa,
diff_menge_af_prognose) AS SELECT wup_id,
 nb_id,
 mandant_id,
 wg_id,
 dat,
 CAST(menge_prognose AS NUMERIC) AS menge_prognose,
 CAST(menge_prognose_bef AS NUMERIC) AS menge_prognose_bef,
 CAST(menge_prognose_max AS NUMERIC) AS menge_prognose_max,
 CAST(menge_af + menge_sa AS BIGNUMERIC) AS menge,
 CAST(menge_af AS BIGNUMERIC) AS vk_menge_af,
 CAST(menge_sa AS BIGNUMERIC) AS vk_menge_sa,
 CAST(diff_menge_af_prognose AS NUMERIC) AS diff_menge_af_prognose
FROM kfl_production_dbp_view.v_fur_prognose_wg_sum_2 AS V01
WHERE mandant_id <> 1;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_kaufland_store_mo_sum_1 (mandant_id, wup_id, nb_id, kjmo,
kfl_review_anz, kfl_review_sum) AS SELECT MO.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 MO.nb_id,
 MO.kjmo,
 MO.anz_review_rating AS kfl_review_anz,
 MO.sum_review_rating AS kfl_review_sum
FROM kfl_production_dbp_msi_data.kfl_retail_store_mo_sum_1 AS MO
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON MO.mandant_id = WUP.mandant_id AND MO.wup_id = WUP.wup_id;
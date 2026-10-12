CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wupcal_mo_sum_2 (wup_id, mandant_id, nb_id, kjmo, gjmo,
bonanzahl) AS SELECT wup_id,
 mandant_id,
 nb_id,
 kjmo,
 gjmo,
 bonanzahl
FROM kfl_production_dbp_view.v_wupcal_mo_sum_2
WHERE mandant_id <> 1;
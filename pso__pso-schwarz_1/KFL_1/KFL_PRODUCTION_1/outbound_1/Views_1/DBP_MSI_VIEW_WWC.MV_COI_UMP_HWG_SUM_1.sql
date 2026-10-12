CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_coi_ump_hwg_sum_1 (mandant_id, wup_id, nb_id, dat, hwg_id,
wrg_id, umsatz_netto) AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 hwg_id,
 wrg_id,
 umsatz_netto
FROM kfl_production_dbp_view.v_coi_ump_hwg_sum_1;
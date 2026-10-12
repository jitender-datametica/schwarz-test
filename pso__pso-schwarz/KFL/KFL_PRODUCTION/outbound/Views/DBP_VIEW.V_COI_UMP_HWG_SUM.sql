CREATE OR REPLACE VIEW kfl_production_dbp_view.v_coi_ump_hwg_sum AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 hwg_id,
 wrg_id,
 umsatz_netto
FROM kfl_production_dbp_data.coi_ump_hwg_sum;
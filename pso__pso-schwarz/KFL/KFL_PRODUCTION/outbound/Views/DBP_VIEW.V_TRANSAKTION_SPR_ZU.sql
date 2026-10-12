CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transaktion_spr_zu AS SELECT mandant_id,
 transaktion_id,
 spr_id,
 transaktion_bez
FROM kfl_production_dbp_data.transaktion_spr_zu;
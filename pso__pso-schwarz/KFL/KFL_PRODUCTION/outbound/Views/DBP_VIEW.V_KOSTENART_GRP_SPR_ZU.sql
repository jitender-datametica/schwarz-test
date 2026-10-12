CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kostenart_grp_spr_zu AS SELECT kostenart_grp_id,
 spr_id,
 system_id,
 kostenart_grp_bez
FROM kfl_production_dbp_data.kostenart_grp_spr_zu;
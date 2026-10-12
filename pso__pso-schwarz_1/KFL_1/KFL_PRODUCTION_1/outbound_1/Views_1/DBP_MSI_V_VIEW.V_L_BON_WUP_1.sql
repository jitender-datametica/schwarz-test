CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_l_bon_wup_1 AS SELECT mandant_id,
 wup_id,
 bda_anym_fg,
 gesperrt_fg,
 dat,
 user_id
FROM kfl_production_dbp_msi_data.l_bon_wup_1;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_anlage_1 AS SELECT anlage_id,
 anlage_sub_id,
 mandant_id,
 buchungskreis_id AS anlage_buchungskreis_id,
 anlage_bez
FROM kfl_production_dbp_view.v_anlage_1;
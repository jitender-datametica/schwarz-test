CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_bedienkonzept_auspr_2 AS SELECT bedienkonzept_id,
 bedienkonzept_auspr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_bedienkonzept_auspr_2;
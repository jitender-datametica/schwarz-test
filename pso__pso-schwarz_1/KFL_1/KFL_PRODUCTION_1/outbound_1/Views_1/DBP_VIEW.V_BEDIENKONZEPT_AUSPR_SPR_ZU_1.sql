CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bedienkonzept_auspr_spr_zu_1 AS SELECT bedienkonzept_id,
 bedienkonzept_auspr_id,
 spr_id,
 bedienkonzept_auspr_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.bedienkonzept_auspr_spr_zu_1;
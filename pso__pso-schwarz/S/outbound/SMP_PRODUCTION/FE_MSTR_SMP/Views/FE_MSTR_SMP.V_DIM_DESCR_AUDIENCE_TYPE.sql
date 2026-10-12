CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_descr_audience_type (division_id, country_id,
descr_audience_segment_id, descr_audience_type_id, descr_audience_type_name, active_fg) AS SELECT division_id,
 country_id,
 descr_audience_segment_id,
 descr_audience_type_id,
 descr_audience_type_name,
 active_fg
FROM smp_production_core_rel.t_descr_audience_type;
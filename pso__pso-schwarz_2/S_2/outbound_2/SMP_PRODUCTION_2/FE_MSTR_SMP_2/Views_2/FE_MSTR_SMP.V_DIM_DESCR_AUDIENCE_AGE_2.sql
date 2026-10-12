CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_descr_audience_age_2 (descr_audience_id, descr_audience_name,
descr_audience_value, descr_audience_desc) AS SELECT DISTINCT descr_audience_id,
 descr_audience_name,
 descr_audience_value,
 REPLACE(descr_audience_value, ' ABOVE MEDIAN', '') AS descr_audience_desc
FROM smp_production_core_rel.t_descr_audience_2
WHERE descr_audience_type_id = 'AGE'
UNION ALL
SELECT DISTINCT 'AGE_ALL',
 'All age groups',
 'n/a',
 'n/a'
FROM smp_production_core_rel.t_descr_audience_2;
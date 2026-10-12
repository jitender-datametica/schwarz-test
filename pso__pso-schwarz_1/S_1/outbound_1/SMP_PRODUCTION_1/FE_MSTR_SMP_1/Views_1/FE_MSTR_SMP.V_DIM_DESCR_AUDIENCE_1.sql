CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_descr_audience_1 (country_id, division_id, descr_audience_id,
descr_audience_name, descr_audience_value, descr_audience_desc, descr_audience_type_id) AS SELECT DISTINCT country_id,
 division_id,
 descr_audience_id,
 descr_audience_name,
 descr_audience_value,
 REPLACE(descr_audience_value, ' ABOVE MEDIAN', '') AS descr_audience_desc,
 descr_audience_type_id
FROM smp_production_core_rel.t_descr_audience_1
WHERE descr_audience_type_id IN ('BUYING BEHAVIOUR', 'AGE', 'GENDER')
 AND LEFT(descr_audience_id, 3) NOT IN ('ZIP', 'BUY', 'CLI', 'VIE' -- ,'AGE'
);
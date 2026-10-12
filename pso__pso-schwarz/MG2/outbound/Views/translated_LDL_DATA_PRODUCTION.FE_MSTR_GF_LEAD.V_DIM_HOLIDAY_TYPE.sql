CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_dim_holiday_type (holiday_type_cd
OPTIONS(description='Holiday Type Code'), holiday_name OPTIONS(description='Description for Holiday type in German'),
holiday_name_de OPTIONS(description='Description for Holiday type in German'), holiday_name_en
OPTIONS(description='Description for Holiday type in German')) AS SELECT DISTINCT holiday_name AS holiday_type_cd,
 holiday_name,
 holiday_name AS holiday_name_de,
 holiday_name AS holiday_name_en
FROM ldl_data_production_core_dim.t_fact_national_holiday
UNION ALL
SELECT 'NA' AS holiday_name,
 '' AS holiday_name0,
 '' AS holiday_name_de,
 '' AS holiday_name_en;
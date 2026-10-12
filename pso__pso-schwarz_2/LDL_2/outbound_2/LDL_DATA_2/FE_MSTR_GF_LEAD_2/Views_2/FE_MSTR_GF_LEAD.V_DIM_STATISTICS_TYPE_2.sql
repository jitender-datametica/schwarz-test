CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_statistics_type_2 (stat_type_cd
OPTIONS(description='The code identifying the kind of metric which is calculated for internal companies.'),
stat_type_descr
OPTIONS(description='A textual description for the kind of metric which is calculated for internal companies.'),
dwh_updated_tmsp OPTIONS(description='the point in time when this record was created or last updated.'), dwh_node_cd
OPTIONS(description='the code for the source system (or slice of source system) from which this record was loaded.'),
dwh_created_tmsp OPTIONS(description='the point in time when this record was created in the data warehouse.'),
dwh_load_id
OPTIONS(description='the unique identifier of the batch load which has done the last update to this record.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE KIND OF METRIC WHICH IS CALCULATED FOR INTERNAL COMPANIES.`) AS
SELECT stat_type_cd,
 stat_type_descr,
 dwh_updated_tmsp,
 dwh_node_cd,
 dwh_created_tmsp,
 dwh_load_id
FROM ldl_data_core_rel.t_statistics_type_2 AS MAIN
WHERE lang_cd = 'DE';
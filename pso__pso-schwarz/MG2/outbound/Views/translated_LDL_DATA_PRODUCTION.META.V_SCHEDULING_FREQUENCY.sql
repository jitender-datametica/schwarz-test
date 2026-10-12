CREATE OR REPLACE VIEW ldl_data_production_meta.v_scheduling_frequency (scheduling_freq_cd
OPTIONS(description='A code defining, how often a scheduling unit or a test is executed. E.g daily, weekly, ...'),
scheduling_freq_descr OPTIONS(description='A textual description for the scheduling frequency.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DESCRIBES, HOW OFTEN A SCHEDULING UNIT OR A TEST IS EXECUTED. E.G. DAILY, WEEKLY, ...`)
AS SELECT scheduling_freq_cd,
 scheduling_freq_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_scheduling_frequency
UNION DISTINCT
SELECT '@',
 'Unknown scheduling frequency',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';
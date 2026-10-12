CREATE OR REPLACE VIEW P_LEW_PROCESS.V_AGC_AGGREGATE_CORE_DEPENDENCY_2
(
aggregate_name
,core_table_name
,last_updated
)
AS
   SELECT
   aggregate_name,
   core_table_name,
   last_updated
   FROM p_lew_process.t_agc_aggregate_core_dependency_2
;
CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_LIL_MEASURE_GROUP_1
  (
      meas_grp_id
      , meas_grp_desc
      , dwh_load_id
      , dwh_created
      , dwh_updated
  )
  AS
     SELECT
         meas_grp_id,
     meas_grp_desc,
     dwh_load_id,
     dwh_created,
     dwh_updated
 FROM p_lew_process_mstr.t_lil_measure_group_1 ;
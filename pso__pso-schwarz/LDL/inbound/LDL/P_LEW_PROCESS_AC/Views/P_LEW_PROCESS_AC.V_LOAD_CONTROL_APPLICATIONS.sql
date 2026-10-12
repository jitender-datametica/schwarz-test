CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_LOAD_CONTROL_APPLICATIONS
( load_process_application_id
, load_process_application_name
, load_process_application_desc
)
AS
   SELECT
     load_process_application_id,
   load_process_application_name,
   load_process_application_desc
  FROM p_lew_process.t_load_control_applications
;
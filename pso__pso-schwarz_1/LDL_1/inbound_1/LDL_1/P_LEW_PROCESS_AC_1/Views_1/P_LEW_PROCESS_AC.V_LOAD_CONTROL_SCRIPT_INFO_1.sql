CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_LOAD_CONTROL_SCRIPT_INFO_1
(
  load_process
, load_process_script_svn_vrs
, load_process_script_svn_lastchangedby
, load_process_script_svn_lastchangeddate_txt
, load_process_script_svn_lastchangeddate_tms
, load_process_script_svn_url
, load_id
, dwh_inserted
)
AS
   SELECT
     load_process,
   load_process_script_svn_vrs,
   load_process_script_svn_lastchangedby,
   load_process_script_svn_lastchangeddate_txt,
   load_process_script_svn_lastchangeddate_tms,
   load_process_script_svn_url,
   load_id,
   dwh_inserted
  FROM p_lew_process.t_load_control_script_info_1
;
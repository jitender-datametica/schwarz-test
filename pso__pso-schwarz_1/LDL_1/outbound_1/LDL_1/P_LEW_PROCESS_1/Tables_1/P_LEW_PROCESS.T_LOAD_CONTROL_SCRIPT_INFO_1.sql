CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_load_control_script_info_1 (
load_process STRING(100) COLLATE 'und:ci' NOT NULL,
load_process_script_svn_vrs BIGNUMERIC(38,0) NOT NULL,
load_process_script_svn_lastchangedby STRING(100) COLLATE 'und:ci',
load_process_script_svn_lastchangeddate_txt STRING(64) COLLATE 'und:ci',
load_process_script_svn_lastchangeddate_tms DATETIME,
load_process_script_svn_url STRING(250) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL,
dwh_inserted DATETIME NOT NULL
);
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_sys_load_status_acl_2 (
jobname STRING(128) COLLATE 'und:ci' NOT NULL,
instance_id DATETIME NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
start_datetransfer DATETIME,
end_datetransfer DATETIME,
flag_change BIGNUMERIC(38,0) DEFAULT 0,
rowcountobj BIGNUMERIC(38,0) DEFAULT 0,
rowcountobjperms BIGNUMERIC(38,0) DEFAULT 0,
approval_datetime_obj DATETIME,
approval_datetime_objperms DATETIME,
statustext STRING(255) COLLATE 'und:ci'
);
CREATE TABLE meta.t_srg_surv_submission_sid(
   surv_submission_sid NUMBER AUTOINCREMENT,
   surv_submission_nr VARCHAR(50),
   surv_platform_cd VARCHAR(20),
   SRC_TABLE_NAME	VARCHAR(250),
   DWH_CREATED_TMSP	TIMESTAMP_LTZ(9)
);
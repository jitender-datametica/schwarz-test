CREATE TABLE meta.t_srg_surv_form_sid_2(
   surv_form_sid NUMBER AUTOINCREMENT,
   surv_form_nr VARCHAR(20),
   surv_type_cd VARCHAR(5),
   surv_platform_cd VARCHAR(20),
   SRC_TABLE_NAME	VARCHAR(250),
   DWH_CREATED_TMSP	TIMESTAMP_LTZ(9)
);
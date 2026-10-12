CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_busyear_lookup_1 (client_id OPTIONS(description='Identification of country_1'),
ba_nr OPTIONS(description='order number'), ian OPTIONS(description='international article number'), busyear
OPTIONS(description='business year'), startmonth OPTIONS(description='definition of business year - starting month'),
endmonth OPTIONS(description='definition of business year - ending month'), cal_month
OPTIONS(description='current month'))
OPTIONS(DESCRIPTION = `MAPPING OF MONTH ATTRIBUTE TO SOLVE THE DOUBLED SALES_1 QUANTITY ISSUE`) AS SELECT CLIENT.client_id
 ,
 BYR.ba_nr,
 BYR.ian,
 BYR.busyear,
 BYR.start_month AS startmonth,
 BYR.end_month AS endmonth,
 MTH.cy_month AS cal_month
FROM ldl_scm_core_rel.t_busyear_lookup_1 AS BYR
 INNER JOIN ldl_scm_core_rel.v_cal_month_1 AS MTH ON MTH.cy_month BETWEEN BYR.start_month AND BYR.end_month
 INNER JOIN ldl_scm_core.v_client_1 AS CLIENT ON BYR.land_1 = CLIENT.country_cd;
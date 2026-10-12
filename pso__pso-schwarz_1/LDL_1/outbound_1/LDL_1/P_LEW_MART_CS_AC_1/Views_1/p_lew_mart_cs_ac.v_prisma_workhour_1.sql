/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs_ac.v_prisma_workhour_1
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_prisma_workhour_1 (client_id, src_orig_store_nr, dwh_cal_dt,
work_time_total_hr, cs_updated, cs_created, cs_load_id) AS SELECT *
FROM ldl_p_lew_mart_cs.v_prisma_workhour_1;
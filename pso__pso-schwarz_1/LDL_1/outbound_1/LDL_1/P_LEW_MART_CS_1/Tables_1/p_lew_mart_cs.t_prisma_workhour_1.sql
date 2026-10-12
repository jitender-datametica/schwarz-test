/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_prisma_workhour_1
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_prisma_workhour_1 (
client_id BIGNUMERIC(38) NOT NULL,
src_orig_store_nr BIGNUMERIC(38) NOT NULL,
dwh_cal_dt DATE NOT NULL,
work_time_total_hr NUMERIC(18,5) NOT NULL,
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_prisma_workhour
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#----------------------------------------------------------------------------
*/
CREATE TABLE p_lew_mart_cs.t_prisma_workhour
(
client_id NUMBER(38) NOT NULL,
src_orig_store_nr NUMBER(38) NOT NULL,
dwh_cal_dt DATE NOT NULL,
work_time_total_hr DECIMAL(18,5) NOT NULL,
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL
);

/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs_ac.v_prisma_salesq_2
#----------------------------------------------------------------------------
# History:
#  1.0  29.04.2022    Ross, Ulrich            Init
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_prisma_salesq_2 (client_id, store_id, dat_formdate, uhrzeit, cashier_id,
int_itemgroup_cd, subitemgroup_id, sales_q, dwh_created) AS SELECT *
FROM ldl_p_lew_mart_cs.v_prisma_salesq_2;
/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Base table for EK-wise NRV metric NRV exkl. SV (WE Datum) (in LW)
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2024-04-17   Torsten Bachmann    Initial version, AP0162679, NRV base KPI
# 1.1  2024-05-21   Torsten Bachmann    We are using "ignore" Approach to calculate WE Kalk in MSTR, so NRV_PART columns are not needed anymore
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_nrv_cond_wh_day_item_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
sup_sid BIGNUMERIC(38,0),
loc_sid_wh BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
dwh_cal_dt DATE NOT NULL,
entry_dt DATE,
curr_cd_from STRING(20),
payout_invoice_type_cd STRING(100),
payout_invoice_billing_type_cd STRING(100),
nrv_exkl_sv_we_dat BIGNUMERIC(38,5),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL
);
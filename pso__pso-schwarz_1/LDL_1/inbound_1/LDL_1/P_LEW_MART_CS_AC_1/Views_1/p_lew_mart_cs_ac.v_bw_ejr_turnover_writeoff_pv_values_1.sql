/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs_ac.v_bw_ejr_turnover_writeoff_pv_values_1
#----------------------------------------------------------------------------
# History:
#   1.0            05.10.2022        Ulrich Ross              Init
#                                                             User Story 391252
#                                                             SAP BW Performance Issue - SF
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_cs_ac.v_bw_ejr_turnover_writeoff_pv_values_1
(
    client_id
  , dwh_cal_dt
  , item_id
  , currency_iso_cd
  , M1401
  , M1102PVS
  , M1201BNL
)
AS
   SELECT
    client_id
  , dwh_cal_dt
  , item_id
  , currency_iso_cd
  , M1401
  , M1102PVS
  , M1201BNL
   FROM p_lew_mart_cs.v_bw_ejr_turnover_writeoff_pv_values_1
;
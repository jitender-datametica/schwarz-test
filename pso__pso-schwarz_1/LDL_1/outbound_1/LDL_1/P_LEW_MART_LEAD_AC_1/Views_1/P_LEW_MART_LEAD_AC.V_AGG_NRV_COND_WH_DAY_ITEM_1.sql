/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: NRV Base for view for EK-wise metric NRV exkl. SV (WE Datum) (in LW)
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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_nrv_cond_wh_day_item_1 (client_id, supplier_id, loc_sid_wh, wh_id,
item_id, dat_formdate, dat_entry_rcv, currency_iso_cd, payout_invoice_type_cd, payout_invoice_billing_type_cd,
nrv_exkl_sv_we_dat)
OPTIONS(DESCRIPTION = `NRV BASE FOR VIEW NRV_EXKL_SV_WE_DAT INCL. PAYOUT_INVOICE_TYPE_CD AND PAYOUT_INVOICE_BILLING_TYPE_CD`)
AS SELECT NRV.client_id,
 NRV.sup_sid AS supplier_id,
 NRV.loc_sid_wh,
 LOC_WH.src_wh_id AS wh_id,
 ITMP.item_sid_map AS item_id,
 NRV.dwh_cal_dt AS dat_formdate,
 NRV.entry_dt AS dat_entry_rcv,
 NRV.curr_cd_from AS currency_iso_cd,
 NRV.payout_invoice_type_cd,
 NRV.payout_invoice_billing_type_cd,
 NRV.nrv_exkl_sv_we_dat
FROM ldl_p_lew_mart_lead.t_agg_nrv_cond_wh_day_item_1 AS NRV
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON NRV.client_id = ITMP.client_id AND NRV.item_sid = ITMP.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC_WH ON NRV.client_id = LOC_WH.client_id AND NRV.loc_sid_wh = LOC_WH.loc_sid
     AND UPPER(LOC_WH.wh_store_mark) = 'B' /* WHs */;
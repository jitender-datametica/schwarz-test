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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_NRV_COND_WH_DAY_ITEM_1(
  CLIENT_ID,
  SUPPLIER_ID,
  LOC_SID_WH,
  WH_ID,
  ITEM_ID,
  DAT_FORMDATE,
  DAT_ENTRY_RCV,
  CURRENCY_ISO_CD,
  PAYOUT_INVOICE_TYPE_CD,
  PAYOUT_INVOICE_BILLING_TYPE_CD,
  NRV_EXKL_SV_WE_DAT
)
COMMENT = 'NRV Base for view NRV_exkl_SV_WE_Dat incl. PAYOUT_INVOICE_TYPE_CD and payout_invoice_billing_type_cd'
AS
SELECT
  nrv.client_id
, nrv.sup_sid                    AS supplier_id
, nrv.loc_sid_wh
, loc_wh.src_wh_id               AS wh_id
, itmp.item_sid_map              AS item_id
, nrv.dwh_cal_dt                 AS dat_formdate
, nrv.entry_dt                   AS dat_entry_rcv
, nrv.curr_cd_from               AS currency_iso_cd
, nrv.payout_invoice_type_cd
, nrv.payout_invoice_billing_type_cd
, nrv.nrv_exkl_sv_we_dat         AS nrv_exkl_sv_we_dat
FROM P_LEW_MART_LEAD.T_AGG_NRV_COND_WH_DAY_ITEM_1 nrv
  INNER JOIN P_LEW_CORE_AC.v_item_map_key_1 itmp
    ON itmp.client_id = nrv.client_id
   AND itmp.item_sid  = nrv.item_sid
  INNER JOIN P_LEW_CORE_AC.v_location_1 AS loc_wh
    ON nrv.client_id  = loc_wh.client_id
   AND nrv.loc_sid_wh = loc_wh.loc_sid
   AND UPPER(loc_wh.wh_store_mark) = 'B' /* WHs */
;

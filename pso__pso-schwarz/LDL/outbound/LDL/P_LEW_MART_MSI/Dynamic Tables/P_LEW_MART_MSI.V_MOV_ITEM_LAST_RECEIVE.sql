/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# History:
#  1.0  11.10.2017    Arne Arnold              Erstellung
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  17.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_mov_item_last_receive
OPTIONS(DESCRIPTION = '$Revision: 16817 $')
AS
/* Ermittle die letzten Liefertermine fuer Wareneingaenge innerhalb des letzten Jahres */ SELECT RCV.client_id,
 WH.src_wh_id AS wh_id,
 RCV.dat_entry_rcv,
 RCV.dat_formdate,
 RCV.item_sid AS item_id,
 CRY.currency_iso_cd,
  RCV.price_retail_rcv / CRY.rate_currency_exchange AS price_retail_rcv,
  RCV.price_retail_net_rcv / CRY.rate_currency_exchange AS price_retail_net_rcv,
 RCV.status_tg,
 RCV.receipt_pos_margin_rel_fg AS receipt_pos_marginrel_fg,
 RCV.customer_nr,
 RCV.receipttype_id AS receivetype_id
FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving AS RCV
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON RCV.client_id = WH.client_id AND RCV.wh_loc_sid = WH.loc_sid_wh
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON RCV.client_id = CRY.client_id
WHERE WH.dwh_actual_fg = 1
 AND CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 AND (RCV.client_id, RCV.wh_loc_sid, RCV.item_sid, RCV.receipttype_id, RCV.dat_entry_rcv, RCV.dat_formdate) IN (SELECT (RCV0
     .client_id, RCV0.wh_loc_sid, RCV0.item_sid, RCV0.receipttype_id, MAX(RCV0.dat_entry_rcv), MAX(RCV0.dat_formdate))
   FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving AS RCV0
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS C ON RCV0.dat_entry_rcv = C.cal_dt
   WHERE C.cy_day_seq BETWEEN - 364 AND 0
   GROUP BY RCV0.client_id,
    RCV0.wh_loc_sid,
    RCV0.item_sid,
    RCV0.receipttype_id)
GROUP BY RCV.client_id,
 wh_id,
 RCV.dat_entry_rcv,
 RCV.dat_formdate,
 item_id,
 CRY.currency_iso_cd,
 RCV.price_retail_rcv,
 RCV.price_retail_net_rcv,
 CRY.rate_currency_exchange,
 RCV.status_tg,
 receipt_pos_marginrel_fg,
 RCV.customer_nr,
 receivetype_id;
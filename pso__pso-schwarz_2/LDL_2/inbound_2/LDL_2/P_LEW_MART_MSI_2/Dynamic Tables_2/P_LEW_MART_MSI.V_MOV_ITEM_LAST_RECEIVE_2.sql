
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
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_MOV_ITEM_LAST_RECEIVE_2 COMMENT = '$Revision: 16817 $'

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
#DescStart#
#$Revision: 16817 $, $LastChangedBy: tbachmann $
#SubjectAreas#: Wareneingang
#DescEnd#
*/
SELECT 
  rcv.client_id
, wh.src_wh_id AS wh_id
, rcv.dat_entry_rcv
, rcv.dat_formdate
, rcv.item_sid AS item_id
, cry.currency_iso_cd
, rcv.price_retail_rcv / cry.rate_currency_exchange AS price_retail_rcv
, rcv.price_retail_net_rcv / cry.rate_currency_exchange  AS price_retail_net_rcv
, rcv.status_tg
, rcv.receipt_pos_margin_rel_fg AS receipt_pos_marginrel_fg
, rcv.customer_nr
, rcv.receipttype_id AS receivetype_id
FROM P_LEW_CORE_AC.v_wawi_mov_item_wh_receiving_2 AS rcv
INNER JOIN P_LEW_BIL_AC.v_warehouse_2 AS wh
        ON rcv.client_id = wh.client_id
        AND rcv.wh_loc_sid = wh.loc_sid_wh
INNER JOIN P_LEW_CORE_AC.v_wawi_ref_client_currency_rate_2 AS cry
        ON  rcv.client_id = cry.client_id
WHERE wh.dwh_actual_fg = 1
    AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
    AND (
          rcv.client_id
        , rcv.wh_loc_sid
        , rcv.item_sid
        , rcv.receipttype_id
        , rcv.dat_entry_rcv
        , rcv.dat_formdate
        ) IN (         /* Ermittle die letzten Liefertermine fuer Wareneingaenge innerhalb des letzten Jahres */
        SELECT
          rcv.client_id
        , rcv.wh_loc_sid
        , rcv.item_sid
        , rcv.receipttype_id
        , MAX(rcv.dat_entry_rcv) AS MAX_dat_entry_rcv
        , MAX(rcv.dat_formdate) AS MAX_dat_formdate
        FROM P_LEW_CORE_AC.v_wawi_mov_item_wh_receiving_2 AS rcv
         INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_2  AS c
                ON  rcv.dat_entry_rcv = c.cal_dt
        WHERE c.cy_day_seq BETWEEN -364 AND 0
        GROUP BY rcv.client_id
            , rcv.wh_loc_sid
            , rcv.item_sid
            , rcv.receipttype_id
    )
GROUP BY rcv.client_id
    , wh_id
    , rcv.dat_entry_rcv
    , rcv.dat_formdate
    , item_id
    , cry.currency_iso_cd
    , rcv.price_retail_rcv
    , rcv.price_retail_net_rcv
    , cry.rate_currency_exchange
    , rcv.status_tg
    , receipt_pos_marginrel_fg
    , rcv.customer_nr
    , receivetype_id
;

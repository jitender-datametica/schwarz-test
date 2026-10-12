/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_MAT_AGG_STORE_DAY_PICK_DELIV_1
#----------------------------------------------------------------------------
# History:
#  1.0  07.09.2020    Wenz, Tobias        	Initial Version
#                                           
#  1.1  30.11.2020    Stemke		            Strukturabgleich Delta bis 25.11.2020
#                                           
#  1.2  09.10.2025    Rahman, Md Fahmin     RP050: Add new column QTY_ORD_CASE for 'Ausgelieferte Kolli inklusive Zuteilungen' metric
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MAT_AGG_STORE_DAY_PICK_DELIV_1
(
    CLIENT_ID
  , LOC_SID_STORE_MOVE_TO
  , WH_LOC_SID
  , WH_ID
  , ASPECT_ID
  , DAT_FORMDATE
  , CY_MONTH
  , CY_WEEK
  , STC_SLOT_ID
  , QTY_ORD_CASE
  , QTY_DEL_CASE
  , ORDER_CNT
  , DWH_UPDATED
)
AS
SELECT
    src.CLIENT_ID
  , act.LOC_SID_STORE_MOVE_TO
  , src.WH_LOC_SID
  , loc.SRC_WH_ID AS WH_ID
  , act.ASPECT_ID
  , src.DAT_FORMDATE
  , cal.CY_MONTH
  , cal.CY_WEEK
  , src.STC_SLOT_ID
  , SUM(src.QTY_ORD_CASE) AS QTY_ORD_CASE
  , SUM(src.QTY_DEL_CASE) AS QTY_DEL_CASE
  , SUM(src.ORDER_CNT) AS ORDER_CNT
  , CURRENT_TIMESTAMP(6) AS DWH_UPDATED
FROM
    (SELECT
        mov.CLIENT_ID
      , mov.LOC_SID_STORE
      , sk.ORIG_ITEM_NR
      , mov.LOC_SID_WH AS WH_LOC_SID
      , mov.DWH_CAL_DT AS DAT_FORMDATE
      , mov.STC_SLOT_NR AS STC_SLOT_ID
      , SUM(mov.ORDERED_CASE_QTY) AS QTY_ORD_CASE
      , SUM(mov.DEL_CASE_QTY) AS QTY_DEL_CASE
      , COUNT(DISTINCT mov.RECEIPT_ID) AS ORDER_CNT
    FROM
        p_lew_core_ac.v_item_delivery_1 mov /* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_delivery mit Core Objekt p_lew_core_ac.v_item_delivery_1*/

    INNER JOIN p_lew_core_ac.v_wawi_itm_item_skey_1 sk
        ON mov.CLIENT_ID = sk.CLIENT_ID
        AND mov.ITEM_SID = sk.ITEM_SID
        AND mov.DWH_CAL_DT BETWEEN sk.DAT_REC_START AND sk.DAT_REC_END

    LEFT OUTER JOIN p_lew_core_ac.v_item_fruits_vegetables_delivery_1 fv /* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_fv_delivery fv mit Core Objekt p_lew_core_ac.v_item_fruits_vegetables_delivery_1*/
        ON mov.CLIENT_ID = fv.CLIENT_ID
        AND mov.LOC_SID_STORE = fv.LOC_SID_STORE
        AND mov.ITEM_SID = fv.ITEM_SID
        AND mov.DWH_CAL_DT = fv.DWH_CAL_DT

    WHERE COALESCE(DEL_CASE_QTY, 0) + COALESCE(ORDERED_CASE_QTY, 0) <> 0
        AND mov.DELIVERY_TYPE_ID IN (1,2)
        AND fv.CLIENT_ID IS NULL

    GROUP BY 1,2,3,4,5,6 -- GROUP BY for the non-aggregated columns in this subquery

    UNION ALL

    SELECT
        fv.CLIENT_ID
      , fv.LOC_SID_STORE
      , sk.ORIG_ITEM_NR
      , fv.LOC_SID_WH AS WH_LOC_SID
      , fv.DWH_CAL_DT AS DAT_FORMDATE
      , fv.SLOT_NR AS STC_SLOT_ID
      , CAST(NULL AS NUMBER) AS QTY_ORD_CASE -- NEW COLUMN IN INNER SELECT (using NULL). Added this to the second inner SELECT from v_item_fruits_vegetables_delivery_1, as the column doesn't exist in this source.
      , SUM(fv.CASE_QTY) AS QTY_DEL_CASE
      , COUNT(DISTINCT fv.RECEIPT_ID_FV_DEL) AS ORDER_CNT
    FROM
        p_lew_core_ac.v_item_fruits_vegetables_delivery_1 fv /* Ersetzen Legacy Objekt p_lew_core_ac.v_wawi_mov_item_fv_delivery fv mit Core Objekt p_lew_core_ac.v_item_fruits_vegetables_delivery_1*/

    INNER JOIN p_lew_core_ac.v_wawi_itm_item_skey_1 sk
        ON fv.CLIENT_ID = sk.CLIENT_ID
        AND fv.ITEM_SID = sk.ITEM_SID
        AND fv.DWH_CAL_DT BETWEEN sk.DAT_REC_START AND sk.DAT_REC_END

    WHERE fv.CASE_QTY IS NOT NULL
        AND fv.CASE_QTY <> 0

    GROUP BY 1,2,3,4,5,6

    ) src

INNER JOIN p_lew_core_ac.v_cal_calendarday_1 cal
    ON cal.CAL_DT = src.DAT_FORMDATE

INNER JOIN p_lew_bil_ac.v_org_store_merge_1 act
    ON act.CLIENT_ID = src.CLIENT_ID
    AND act.LOC_SID_STORE = src.LOC_SID_STORE
    AND act.ASPECT_ID  = 1

INNER JOIN p_lew_core_ac.v_location_1 loc
    ON src.CLIENT_ID = loc.CLIENT_ID
    AND src.WH_LOC_SID = loc.LOC_SID
    AND loc.WH_STORE_MARK='B'

GROUP BY 1,2,3,4,5,6,7,8,9 -- All non-aggregated columns from the outer SELECT
;

/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_cal_calendarday_1", "p_lew_core_ac.v_item_delivery_1", "p_lew_core_ac.v_wawi_itm_item_skey_1", "p_lew_core_ac.v_item_fruits_vegetables_delivery_1" ****/
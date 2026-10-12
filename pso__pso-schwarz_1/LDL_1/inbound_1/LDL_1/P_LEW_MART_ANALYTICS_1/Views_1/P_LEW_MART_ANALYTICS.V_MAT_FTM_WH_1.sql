CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_MAT_FTM_WH_1
(
    CLIENT_ID
    , DAT_FORMDATE
    , WH_ID
    , ITEM_ID
    , ORIG_ITEM_NR
    , BUYING_VAL
) 
AS
SELECT 
    WE.CLIENT_ID
    ,TAG.DAT_CALENDAR AS DAT_FORMDATE
    ,WE.WH_ID
    ,ITEM_ID
    ,WE.ORIG_ITEM_NR
    ,1.00*SUM(WE_EK_WERT)/NULLIFZERO(SUM(WE_MENGE)) AS BUYING_VAL
FROM P_LEW_MART_MSI_AC.V_CAL_CALENDARDAY_1 AS TAG_1    
 LEFT OUTER JOIN(
     SELECT
         WE.CLIENT_ID
         ,WE.WH_ID
         ,WE.ITEM_ID 
         ,UWG_INFO.ITEMGROUP_INT_ID
         ,WE.DAT_FORMDATE 
         ,TAG.CY_DAY_SEQUENCE
         ,ART_INFO.ORIG_ITEM_NR
         ,SUM((CASE WHEN WE.RECEIVETYPE_ID IN (1, 2, 3) THEN CASE WHEN WE.STATUS_TG > 3  AND WE.RECEIPT_POS_MARGINREL_FG = 1 THEN (((( ((CAST( WE.QTY_TOTAL_RCV AS DECIMAL(18,2)) ) - ( CASE WHEN  ZEROIFNULL(  WE.CUSTOMER_NR ) = 0 THEN 0 ELSE CAST(WE.QTY_TOTAL_RCV AS DECIMAL(18,2)) END)))   ))) END   ELSE NULL END))  WE_MENGE
         ,SUM((CASE WHEN WE.RECEIPT_POS_MARGINREL_FG = 1 THEN WE.VAL_BUYING_RCV ELSE NULL END))  WE_EK_WERT
--here was a select FROM P_LEW_MART_MSI_AC.V_MOV_ITEM_RECEIVE_WH_1, so I take only what is in scope, not all available columns. 
        FROM ( 
          SELECT 
            a.client_id
            ,a.src_wh_id AS wh_id
            ,itmp.item_sid_map AS item_id
            ,a.dwh_cal_dt AS dat_formdate
            ,a.receipt_type_id AS RECEIVETYPE_ID
            ,a.status_tg AS STATUS_TG
            ,a.receipt_pos_margin_rel_fg AS RECEIPT_POS_MARGINREL_FG
            ,a.customer_nr AS CUSTOMER_NR
            ,a.buying_val AS VAL_BUYING_RCV
            ,a.receive_piece_qty AS QTY_TOTAL_RCV
          FROM P_LEW_BIL_AC.v_mov_item_receive_wh_1 a
          INNER JOIN P_LEW_CORE_AC.v_item_map_key_1 itmp
          ON itmp.client_id = a.client_id
            AND itmp.item_sid = a.item_sid
          WHERE a.curr_cd_from = 'EUR'
            AND a.dwh_cal_dt BETWEEN DATEADD(YEAR, -2, CURRENT_DATE) AND CURRENT_DATE
            AND (a.receipt_type_id IN (1,2,3) OR a.receipt_pos_margin_rel_fg = 1)
        )AS WE
--end       
        INNER JOIN P_LEW_MART_MSI_AC.V_CAL_CALENDARDAY_1 AS TAG_1
            ON TAG.DAT_CALENDAR = WE.DAT_FORMDATE

        INNER JOIN P_LEW_MART_MSI_AC.V_ITM_ITEM_1 AS ART_INFO
            ON ART_INFO.CLIENT_ID = WE.CLIENT_ID
            AND ART_INFO.ITEM_ID = WE.ITEM_ID

        INNER JOIN P_LEW_MART_MSI_AC.V_ITM_SUBITEMGROUP_1 AS UWG_INFO
            ON UWG_INFO.SUBITEMGROUP_ID = ART_INFO.SUBITEMGROUP_ID 
       GROUP BY 1,2,3,4,5,6,7
      ) WE 
        ON ((ITEMGROUP_INT_ID IN (10,20,30,32) AND WE.CY_DAY_SEQUENCE BETWEEN TAG.CY_DAY_SEQUENCE - 14 AND TAG.CY_DAY_SEQUENCE) 
        OR (ITEMGROUP_INT_ID IN (40,50,60,90) AND WE.CY_DAY_SEQUENCE BETWEEN TAG.CY_DAY_SEQUENCE - 164 AND TAG.CY_DAY_SEQUENCE)
        OR (ITEMGROUP_INT_ID IN (0,70) AND WE.CY_DAY_SEQUENCE BETWEEN TAG.CY_DAY_SEQUENCE - 1000 AND TAG.CY_DAY_SEQUENCE))

    GROUP BY 1,2,3,4,5
;
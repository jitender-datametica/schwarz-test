/*
 * ----------------------------------------------------------------------------
 *  History:
 * 
 *   Vrs Date       Developer               Task
 *   --- ---------- ----------------------- --------------------------------
 *   1.0 2022-11-07 Andrzej Wandtke         AP0140749 CC Dashboard - Initial version 
 * ----------------------------------------------------------------------------
 */


CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_LDI_ORDER_MTH(
	CLIENT_ID COMMENT 'The surrogate key for a WAWI client.'
,	CLIENT_ID_ONLINE COMMENT 'The surrogate key for a WAWI client.'
,	CY COMMENT 'Calendar year'
,	CY_MONTH COMMENT 'Calendar month'
,	ORDER_CNT_MTH COMMENT 'The number of orders which have been placed with Lidl Digital on that day. (The total number of orders is reduced by the number of cancellations.) '
,	ORDER_LINE_CNT_MTH COMMENT 'The number of order lines which have been placed with Lidl Digital on that day. (This is the total number of ordered items, reduced by orders that have been cancelled later ON and by returns.)'
) AS
WITH 
cte_c_store AS (
        SELECT
         country_sid AS client_id
        ,client_id   AS client_id_online
        FROM p_lew_core_ac.v_client
        WHERE client_online_fg = 1
        AND  lob_cd = 'LDL'
)
,cte_cy AS (
       SELECT
       s.client_id AS client_id_online
       ,cal.cy
       ,cal.cy_month
       ,SUM(s.adj_order_cnt)         AS order_cnt
       ,SUM(s.adj_order_line_cnt)    AS order_line_cnt
       FROM p_lew_precore_ac.v_ldi_order_summary AS s
       INNER JOIN p_lew_core_ac.v_cal_calendarday AS cal
        ON cal.cal_dt = s.dwh_cal_dt
       WHERE s.dwh_cal_dt >= TO_DATE('2016-01-01', 'yyyy-mm-dd')
       GROUP BY
       client_id_online
       ,cal.cy
       ,cal.cy_month
)
SELECT
c_store.client_id
,c_store.client_id_online               AS client_id_online
,cy.cy
,cy.cy_month
,cy.order_cnt                           AS order_cnt_mth
,cy.order_line_cnt                      AS order_line_cnt_mth
FROM cte_c_store AS c_store
INNER JOIN cte_cy AS cy 
 ON cy.client_id_online = c_store.client_id_online
;
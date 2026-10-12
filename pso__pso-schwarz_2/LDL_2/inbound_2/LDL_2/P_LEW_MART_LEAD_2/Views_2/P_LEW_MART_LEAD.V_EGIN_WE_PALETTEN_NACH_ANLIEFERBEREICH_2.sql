create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_EGIN_WE_PALETTEN_NACH_ANLIEFERBEREICH_2(
	CLIENT_ID COMMENT 'Indicator of country_2',
	WH_ID COMMENT 'Warehouse number',
	WH_STAGING_AREA_CD COMMENT 'Warehouse area number',
	WH_DOCKING_GATE_NR COMMENT 'Tor',
	SUP_SID COMMENT 'Supplier_2 sid number',
	SPEDITION COMMENT 'Name of the carrier ',
	DAT_ENTRY_RCV COMMENT 'task completed date and time',
	EURO_PAL COMMENT 'Amount of Euro pallets',
	EURO_PAL_REJECTED COMMENT 'Amount of rejected euro pallets',
	DD_PAL COMMENT 'Amount of Düsseldorf pallets',
	DD_PAL_REJECTED COMMENT 'Amount of rejected Düsseldorf pallets',
	EURO_PAL_AUFGELAUFEN COMMENT 'cumulative euro pallets',
	DD_PAL_AUFGELAUFEN COMMENT 'cumulative Düsseldorf pallets',
	EURO_PAL_REJECTED_AUFGELAUFEN COMMENT 'cumulative rejected euro pallets',
	DD_PAL_REJECTED_AUFGELAUFEN COMMENT 'cumulative rejected Düsseldorf pallets',
	EURO_PAL_VJ COMMENT 'Amount of Euro pallets mapped to previous year',
	EURO_PAL_REJECTED_VJ COMMENT 'Amount of rejected euro pallets mapped to previous year',
	DD_PAL_VJ COMMENT 'Amount of Düsseldorf pallets mapped to previous year',
	DD_PAL_REJECTED_VJ COMMENT 'Amount of rejected Düsseldorf mapped to previous year',
	EURO_PAL_VJ_AUFGELAUFEN COMMENT 'cumulative euro pallets previous year',
	DD_PAL_VJ_AUFGELAUFEN COMMENT 'cumulative Düsseldorf pallets previous year',
	EURO_PAL_REJECTED_VJ_AUFGELAUFEN COMMENT 'cumulative rejected euro pallets previous year',
	DD_PAL_REJECTED_VJ_AUFGELAUFEN COMMENT 'cumulative rejected Düsseldorf pallets previous year'
) as
WITH base_we_paletten_day AS (
   SELECT 
    det.client_id
    ,det.wh_nr AS wh_id
    ,wdg.wh_staging_area_cd
    ,pos.wh_docking_gate_nr
    ,IFNULL(pos.departure_sup_sid,-1) AS sup_sid
    ,det.carrier_descr AS spedition
    ,wk.dat_formdate AS dat_entry_rcv
    ,SUM(CASE WHEN (pos.pallet_type_cd = 'EP' OR pos.pallet_type_cd IS NULL) THEN pos.pallet_cnt ELSE 0 END) AS euro_pal
    ,SUM(CASE WHEN (pos.pallet_type_cd = 'EP' OR pos.pallet_type_cd IS NULL) AND pos.rejected_fg = 1 THEN pos.pallet_cnt ELSE 0 END) AS euro_pal_rejected
    ,SUM(CASE WHEN pos.pallet_type_cd = 'DD' THEN pos.pallet_cnt ELSE 0 END) AS dd_pal
    ,SUM(CASE WHEN pos.pallet_type_cd = 'DD' AND pos.rejected_fg = 1 THEN pos.pallet_cnt ELSE 0 END) AS dd_pal_rejected
FROM p_lew_core.t_warehouse_receiving_count_task_2 det
INNER JOIN p_lew_core.t_warehouse_receiving_count_task_pos_2 pos
ON det.client_id = pos.client_id
AND det.wh_loc_sid = pos.wh_loc_sid
AND det.wh_rcv_cnt_task_sid = pos.wh_rcv_cnt_task_sid
AND pos.pos_status_id IN (99)
INNER JOIN p_lew_core.t_ref_warehouse_docking_gate_2 wdg
ON pos.client_id = wdg.client_id
AND pos.wh_loc_sid = wdg.wh_loc_sid
AND pos.wh_docking_gate_nr = wdg.wh_docking_gate_nr
INNER JOIN (SELECT DISTINCT client_id, wh_loc_sid, receipt_id_rcv, dat_formdate FROM p_lew_core.t_wawi_mov_item_wh_receiving_2 WHERE receipttype_id = 1) wk
ON wk.client_id = pos.client_id
AND pos.wh_loc_sid = wk.wh_loc_sid
AND pos.rcv_receipt_id = wk.receipt_id_rcv
LEFT OUTER JOIN (SELECT client_id, sup_sid FROM p_lew_core.t_supplier_2 WHERE sup_name LIKE '%Dummy_2%' OR sup_name LIKE '%dummy_2%') sup
ON pos.client_id = sup.client_id
AND pos.departure_sup_sid = sup.sup_sid
WHERE det.task_status_id = 99
AND pos.case_per_pallet_cnt > 0
AND det.task_created_dt BETWEEN ADD_MONTHS(SYSDATE()::DATE,-24) AND LAST_DAY(ADD_MONTHS(SYSDATE()::DATE,0))
AND (pos.departure_sup_sid IS NULL OR sup.sup_sid IS NULL)
GROUP BY 1,2,3,4,5,6,7
UNION ALL

SELECT 
    det.client_id
    ,det.wh_nr AS wh_id
    ,'-2' AS wh_staging_area_cd
    ,-2 AS wh_docking_gate_nr
    ,pos.departure_sup_sid AS sup_sid
    ,det.carrier_descr AS spedition
    ,wk.dat_formdate AS dat_entry_rcv
    ,SUM(CASE WHEN (pos.pallet_type_cd = 'EP' OR pos.pallet_type_cd IS NULL) THEN pos.pallet_cnt ELSE 0 END) AS euro_pal
    ,SUM(CASE WHEN (pos.pallet_type_cd = 'EP' OR pos.pallet_type_cd IS NULL) AND pos.rejected_fg = 1 THEN pos.pallet_cnt ELSE 0 END) AS euro_pal_rejected
    ,SUM(CASE WHEN pos.pallet_type_cd = 'DD' THEN pos.pallet_cnt ELSE 0 END) AS dd_pal
    ,SUM(CASE WHEN pos.pallet_type_cd = 'DD' AND pos.rejected_fg = 1 THEN pos.pallet_cnt ELSE 0 END) AS dd_pal_rejected
FROM p_lew_core.t_warehouse_receiving_count_task_2 det
INNER JOIN p_lew_core.t_warehouse_receiving_count_task_pos_2 pos
ON det.client_id = pos.client_id
AND det.wh_loc_sid = pos.wh_loc_sid
AND det.wh_rcv_cnt_task_sid = pos.wh_rcv_cnt_task_sid
AND pos.pos_status_id IN (99)
INNER JOIN p_lew_core.t_ref_warehouse_docking_gate_2 wdg
ON pos.client_id = wdg.client_id
AND pos.wh_loc_sid = wdg.wh_loc_sid
AND pos.wh_docking_gate_nr = wdg.wh_docking_gate_nr
INNER JOIN (SELECT DISTINCT client_id, wh_loc_sid, receipt_id_rcv, dat_formdate FROM p_lew_core.t_wawi_mov_item_wh_receiving_2 WHERE receipttype_id = 1) wk
ON wk.client_id = pos.client_id
AND pos.wh_loc_sid = wk.wh_loc_sid
AND pos.rcv_receipt_id = wk.receipt_id_rcv
INNER JOIN (SELECT client_id, sup_sid FROM p_lew_core.t_supplier_2 WHERE sup_name LIKE '%Dummy_2%' OR sup_name LIKE '%dummy_2%') sup
ON pos.client_id = sup.client_id
AND pos.departure_sup_sid = sup.sup_sid
WHERE det.task_status_id = 99
AND pos.case_per_pallet_cnt > 0
AND det.task_created_dt BETWEEN ADD_MONTHS(SYSDATE()::DATE,-24) AND LAST_DAY(ADD_MONTHS(SYSDATE()::DATE,0))
GROUP BY 1,2,3,4,5,6,7
UNION ALL
SELECT 
    wr.client_id
    ,wh.src_wh_id AS wh_id
    ,'-1' AS wh_staging_area_cd
    ,-1 AS wh_docking_gate_nr
    ,IFNULL(wr.sup_sid,-1) AS sup_sid
    ,'-1' AS spedition
    ,wr.dat_formdate AS dat_entry_rcv
    ,SUM(DECODE(IFNULL(wr.package_qty,3),3
    ,(wr.qty_total_rcv/IFNULL(wr.case_size_dec,TRY_TO_NUMBER(SUBSTR(wr.item_sid,-4))))/IFNULL(wr.pallet_factor_rcv
    ,DECODE(IFNULL(wr.package_qty,3),1
    ,IFNULL(wr.stock_location_nr,1),2
    ,IFNULL(itm.case_factor_dd,itm.case_factor_euro/2),3
    ,itm.case_factor_euro,1)),0)) AS euro_pal
     ,0 AS euro_pal_rejected
    ,SUM(DECODE(IFNULL(wr.package_qty,3),2
    ,(wr.qty_total_rcv/IFNULL(wr.case_size_dec,TRY_TO_NUMBER(SUBSTR(wr.item_sid,-4))))/IFNULL(wr.pallet_factor_rcv
    ,DECODE(IFNULL(wr.package_qty,3),1
    ,IFNULL(wr.stock_location_nr,1),2
    ,IFNULL(itm.case_factor_dd,itm.case_factor_euro/2),3
    ,itm.case_factor_euro,1)),0)) AS dd_pal
    ,0 AS dd_pal_rejected
FROM (
    SELECT * 
    FROM p_lew_core.t_wawi_mov_item_wh_receiving_2 
    WHERE dat_formdate BETWEEN ADD_MONTHS(SYSDATE()::DATE,-24) AND LAST_DAY(ADD_MONTHS(SYSDATE()::DATE,0))
    AND IFNULL(case_size_dec, TRY_TO_NUMBER(SUBSTR(item_sid,-4))) >0
    AND receipttype_id = 1
    AND receipt_id_rcv < 5000000) wr
INNER JOIN p_lew_bil.t_warehouse_2 wh
ON wr.client_id = wh.client_id
AND wr.wh_loc_sid = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1
INNER JOIN p_lew_core.t_wawi_itm_item_wh_2 itm
ON wr.client_id = itm.client_id
AND wr.wh_loc_sid = itm.wh_loc_sid
AND wr.item_sid = itm.item_sid
AND itm.dat_rec_end = '9999-12-31'
WHERE 1=1
AND IFNULL(wr.pallet_factor_rcv,DECODE(IFNULL(wr.package_qty,3),1
   ,IFNULL(wr.stock_location_nr,1),2
   ,IFNULL(itm.case_factor_dd,itm.case_factor_euro/2),3
   ,itm.case_factor_euro,1))>0
AND (
        NOT EXISTS(
        SELECT 1
        FROM p_lew_core.t_warehouse_receiving_count_task_pos_2
        WHERE CONCAT(client_id, wh_loc_sid, rcv_receipt_id) = CONCAT(wr.client_id,wr.wh_loc_sid, wr.receipt_id_rcv)
        AND wh_docking_gate_nr IS NOT NULL
        )
)
GROUP BY 
    wr.client_id
    ,wh.src_wh_id
    ,wr.sup_sid
    ,wr.dat_formdate
    ,wr.receipt_id_rcv
)
, fact_we_paletten_day_previous_year AS ( 
SELECT
    a.client_id
    ,a.wh_id
    ,a.wh_staging_area_cd
    ,a.wh_docking_gate_nr
    ,a.sup_sid
    ,a.spedition
    ,b.cal_dt AS dat_entry_rcv
    ,b.busyear
    ,SUM(a.euro_pal) AS we_paletten_ep_vj
    ,SUM(we_paletten_ep_vj) OVER (PARTITION BY a.client_id, a.wh_id, b.busyear ORDER BY b.cal_dt,a.wh_staging_area_cd,a.wh_docking_gate_nr, a.sup_sid, a.spedition  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_ep_vj_aufgelaufen
    ,SUM(a.dd_pal) AS we_paletten_dd_vj
    ,SUM(we_paletten_dd_vj) OVER (PARTITION BY a.client_id, a.wh_id, b.busyear ORDER BY b.cal_dt, a.wh_staging_area_cd, a.wh_docking_gate_nr, a.sup_sid, a.spedition ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_dd_vj_aufgelaufen
    ,SUM(a.euro_pal_rejected) AS we_paletten_rejected_ep_vj
     ,SUM(we_paletten_rejected_ep_vj) OVER (PARTITION BY a.client_id, a.wh_id, b.busyear ORDER BY b.cal_dt, a.wh_staging_area_cd, a.wh_docking_gate_nr, a.sup_sid, a.spedition ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_rejected_ep_vj_aufgelaufen
    ,SUM(a.dd_pal_rejected) AS we_paletten_rejected_dd_vj
    , SUM(we_paletten_rejected_dd_vj) OVER (PARTITION BY a.client_id, a.wh_id, b.busyear ORDER BY b.cal_dt, a.wh_staging_area_cd, a.wh_docking_gate_nr, a.sup_sid, a.spedition ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_rejected_dd_vj_aufgelaufen
FROM base_we_paletten_day a
JOIN p_lew_core_ac.v_cal_calendarday_2 b
ON a.dat_entry_rcv = b.cal_dt_prev_1y
GROUP BY
	a.client_id
	,a.wh_id
	,a.wh_staging_area_cd
	,a.wh_docking_gate_nr
	,a.sup_sid
	,a.spedition
	,b.cal_dt
    ,b.busyear
    ),
fact_we_paletten_day_current_year AS ( 
SELECT
    a.client_id
    ,a.wh_id
    ,a.wh_staging_area_cd
    ,a.wh_docking_gate_nr
    ,a.sup_sid
    ,a.spedition
    ,b.cal_dt AS dat_entry_rcv
    ,b.busyear
    ,SUM(a.euro_pal) AS we_paletten_ep
    ,SUM(we_paletten_ep) OVER (PARTITION BY a.client_id, a.wh_id, b.busyear ORDER BY b.cal_dt, a.wh_staging_area_cd, a.wh_docking_gate_nr, a.sup_sid, a.spedition ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_ep_aufgelaufen
    ,SUM(a.dd_pal) AS we_paletten_dd
    ,SUM(we_paletten_dd) OVER (PARTITION BY a.client_id, a.wh_id, b.busyear ORDER BY b.cal_dt, a.wh_staging_area_cd, a.wh_docking_gate_nr, a.sup_sid, a.spedition ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_dd_aufgelaufen
    ,SUM(a.euro_pal_rejected) AS we_paletten_rejected_ep
     ,SUM(we_paletten_rejected_ep) OVER (PARTITION BY a.client_id, a.wh_id, b.busyear ORDER BY b.cal_dt, a.wh_staging_area_cd, a.wh_docking_gate_nr, a.sup_sid, a.spedition ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_rejected_ep_aufgelaufen
    ,SUM(a.dd_pal_rejected) AS we_paletten_rejected_dd
    , SUM(we_paletten_rejected_dd) OVER (PARTITION BY a.client_id, a.wh_id, b.busyear ORDER BY b.cal_dt, a.wh_staging_area_cd, a.wh_docking_gate_nr, a.sup_sid, a.spedition ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS we_paletten_rejected_dd_aufgelaufen
FROM base_we_paletten_day a
JOIN p_lew_core_ac.v_cal_calendarday_2 b
ON a.dat_entry_rcv = b.cal_dt
GROUP BY
	a.client_id
	,a.wh_id
	,a.wh_staging_area_cd
	,a.wh_docking_gate_nr
	,a.sup_sid
	,a.spedition
	,b.cal_dt
    ,b.busyear
    )
    SELECT 
         IFNULL(a.client_id, b.client_id) AS client_id
        ,IFNULL(a.wh_id , b.wh_id) AS wh_id
        ,IFNULL(IFNULL(a.wh_staging_area_cd, b.wh_staging_area_cd),'-1') AS wh_staging_area_cd
        ,IFNULL(IFNULL(a.wh_docking_gate_nr, b.wh_docking_gate_nr),-1) AS wh_docking_gate_nr
        ,IFNULL(a.sup_sid, b.sup_sid) AS sup_sid
        ,IFNULL(a.spedition, b.spedition) AS spedition
        ,IFNULL(a.dat_entry_rcv, b.dat_entry_rcv) AS dat_entry_rcv
        ,MAX(b.we_paletten_ep) AS euro_pal
        ,MAX(b.we_paletten_rejected_ep) AS euro_pal_rejected
        ,MAX(b.we_paletten_dd) AS dd_pal
        ,MAX(b.we_paletten_rejected_dd) AS dd_pal_rejected
        ,MAX(b.we_paletten_ep_aufgelaufen) AS euro_pal_aufgelaufen
        ,MAX(b.we_paletten_dd_aufgelaufen) AS dd_pal_aufgelaufen
        ,MAX(b.we_paletten_rejected_ep_aufgelaufen) AS euro_pal_rejected_aufgelaufen
        ,MAX(b.we_paletten_rejected_dd_aufgelaufen) AS dd_pal_rejected_aufgelaufen
        ,MAX(a.we_paletten_ep_vj) AS euro_pal_vj
        ,MAX(a.we_paletten_rejected_ep_vj) AS euro_pal_rejected_vj
        ,MAX(a.we_paletten_dd_vj) AS dd_pal_vj
        ,MAX(a.we_paletten_rejected_dd_vj) AS dd_pal_rejected_vj
        ,MAX(a.we_paletten_ep_vj_aufgelaufen) AS euro_pal_vj_aufgelaufen
        ,MAX(a.we_paletten_dd_vj_aufgelaufen) AS dd_pal_vj_aufgelaufen
        ,MAX(a.we_paletten_rejected_ep_vj_aufgelaufen) AS euro_pal_rejected_vj_aufgelaufen
        ,MAX(a.we_paletten_rejected_dd_vj_aufgelaufen) AS dd_pal_rejected_vj_aufgelaufen
    FROM fact_we_paletten_day_previous_year a
    FULL OUTER JOIN fact_we_paletten_day_current_year b
    ON a.client_id = b.client_id
    AND a.wh_id = b.wh_id
    AND a.wh_staging_area_cd = b.wh_staging_area_cd
    AND a.wh_docking_gate_nr = b.wh_docking_gate_nr
    AND a.sup_sid = b.sup_sid
    AND a.spedition = b.spedition
    AND a.dat_entry_rcv = b.dat_entry_rcv
    GROUP BY 1,2,3,4,5,6,7
;

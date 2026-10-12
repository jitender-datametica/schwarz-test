/*########################################################################################################################################
  # View: FE_MSTR_SCM.V_DMND_ORD_RECVD_MNTHY_SUM_1                                                                                         
  #	Initial Developer: Gao, Pin																									             
  #	Change Management: 																												     
  #	2025-04-29   Gao, Pin               Redesign the logic and add Stock and Sales_1 data to the logic											                 
  # 2025-05-09	 Gao, Pin               Add Zielreichweite																									     
  #	2025-05-22	 Gao, Pin               Embed the new GJ logic. Add VJ, aufgelaufen Values															             
  # 2025-07-01   Gao, Pin               Change the stock and sales_1 table with the monthly aggregated ones                                                       
  # 2025-07-07   Gao, Pin               Added logic to separate the Schwarz Produktion Nüsse Schokolade into two suppliers                                      
  # 2025-08-19   Gao, Pin               Added logic to calculate the reichweite in day                                                                          
  # 2025-09-18   Gao, Pin               Adjust the logic by adding ba_nr to the partition for calculating the cumulative values                                 
  # 2025-11-04   Gao, Pin               Add APT table and logic  
  # 2025-12-01   Gao, Pin               Add item_lookup to avoid a inner loop by using fe_mstr_scm.v_item_lookup_1     
  # 2025-12-05   Gao, Pin               Add monitoring_zeitraum indicating start month and end month of the business year for each item_1 
  # 2026-01-08   Gao, Pin               Removal of case size and pallet factor from promotion_act session and adding HAVING statement to filter                       
  #                                     only items with a positive demand quantities  
  # 2026-01-12   Gao, Pin               Change the order of src_orig_item_nr_int and orig_item_nr_int in the item_lookup session to make sure the 
  #                                     IAN from t_wawi_itm_item_int_1 comes first                                          
  #  																															         
  ########################################################################################################################################
*/

CREATE OR REPLACE VIEW FE_MSTR_SCM.V_DMND_ORD_RECVD_MNTHY_SUM_1(
    CLIENT_ID COMMENT 'Identification ID of country_1',
	BUSYEAR COMMENT 'business year',
	MONITORING_ZEITRAUM COMMENT 'start month and end month of the business year',
	SUPPLIER_ID_INT COMMENT 'supplier_1 international id',
	BA_NR COMMENT 'order number',
	BA_BEZEICHNUNG COMMENT 'order description',
	NAN COMMENT 'national article number',
	IAN COMMENT 'international article number',
	ARTIKEL_BEZEICHNUNG COMMENT 'description of article name',
	PALFKT COMMENT 'pallet factor',
	KOLLIINHALT COMMENT 'case size',
	ACTION_WEEK COMMENT 'the promotion week for the product',
	ACTION_AMOUNT_PC COMMENT 'the promotion amount in piece for the product in the next 3 months',
	ACTION_AMOUNT_PAL COMMENT 'the promotion amount in pallet for the product in the next 3 months',
	PROMOTION_FACTOR COMMENT 'the promotion factor for the product',
	ZIELREICHWEITE COMMENT 'target delivery time',
	CAL_MONTH COMMENT 'calendar_1 month',
	BESTAND_ARTIKEL_LETZTER_STAND_STK COMMENT 'latest stock of the article in piece',
	BESTAND_ARTIKEL_LETZTER_STAND_PAL COMMENT 'latest stock of the article in pallet',
	ABVERKAUF_ARTIKEL_PER_MONAT_STK COMMENT 'sales_1 of article per month in piece',
	ABVERKAUF_ARTIKEL_STK_VORMONAT COMMENT 'sales_1 of article in the last month per piece',
	ABVERKAUF_ARTIKEL_PER_MONAT_STK_VJ COMMENT 'sales_1 of article per month in the previous year',
	ABVERKAUF_ARTIKEL_PER_MONAT_STK_VVJ COMMENT 'sales_1 of article per month 2 years ago',
	ABVERKAUF_ARTIKEL_PER_MONAT_STK_VVVJ COMMENT 'sales_1 of article per month 3 years ago',
	ABVERKAUF_ARTIKEL_PER_MONAT_PAL COMMENT 'sales_1 of article per month in pallet',
	ABVERKAUF_ARTIKEL_PAL_VORMONAT COMMENT 'sales_1 of article per pallet in the last month',
	ABVERKAUF_ARTIKEL_PER_MONAT_PAL_VJ COMMENT 'sales_1 of article per month in pallet 1 year ago',
	ABVERKAUF_ARTIKEL_PER_MONAT_PAL_VVJ COMMENT 'sales_1 of article per month in pallet 2 years ago',
	ABVERKAUF_ARTIKEL_PER_MONAT_PAL_VVVJ COMMENT 'sales_1 of article per month in pallet 3 years ago',
	BEDARFSMENGE_PER_STK_JAHR COMMENT 'demand quantity per piece in a year',
	BEDARFSMENGE_PER_STK_JAHR_VJ COMMENT 'demand quantity per piece in the previous year',
	BEDARFSMENGE_PER_STK_MONTH COMMENT 'demand quantity per piece mapped to the calendar_1 month',
	BEDARFSMENGE_PER_STK_MONTH_VJ COMMENT 'demand quantity per piece mapped to the previous month',
	BEDARFSMENGE_AUFGELAUFEN_PER_STK_BIS_VORMONAT COMMENT 'cumulative demand quantity till previous month',
	BEDARFSMENGE_AUFGELAUFEN_PER_STK_BIS_VORMONAT_VJ COMMENT 'cumulative demand quantity mapped to previous month',
	BEDARFSMENGE_PER_PAL_JAHR COMMENT 'demand quantity per pallet mapped to the business year',
	BEDARFSMENGE_PER_PAL_JAHR_VJ COMMENT 'demand quantity per pallet mapped to the previous year',
	BEDARFSMENGE_PER_PAL_MONTH COMMENT 'demand quantity per pallet mapped to the calendar_1 month',
	BEDARFSMENGE_PER_PAL_MONTH_VJ COMMENT 'demand quantity per pallet mapped to the previous month',
	BEDARFSMENGE_AUFGELAUFEN_PER_PAL_BIS_VORMONAT COMMENT 'cumulative demand quantity per pallet till previous month',
	BEDARFSMENGE_AUFGELAUFEN_PER_PAL_BIS_VORMONAT_VJ COMMENT 'cumulative demand quantity per pallet mapped to previous month',
	BESTELLMENGE_PER_STK_MONTH COMMENT 'order quantity per piece mapped to the calendar_1 month',
	BESTELLMENGE_PER_STK_MONTH_VJ COMMENT 'order quantity per piece mapped to the previous month',
	BESTELLMENGE_AUFGELAUFEN_PER_STK_BIS_VORMONAT COMMENT 'cumulative order quantity per piece until previous month',
	BESTELLMENGE_AUFGELAUFEN_PER_STK_BIS_VORMONAT_VJ COMMENT 'cumulative order quantity per piece until previous month mapped to previous year',
	BESTELLMENGE_PER_PAL_MONTH COMMENT 'order quantity per pallet mapped to the calendar_1 month',
	BESTELLMENGE_PER_PAL_MONTH_VJ COMMENT 'order quantity per pallet mapped to the previous year',
	BESTELLMENGE_AUFGELAUFEN_PER_PAL_BIS_VORMONAT COMMENT 'cumulative order quantity per pallet till previous month',
	BESTELLMENGE_AUFGELAUFEN_PER_PAL_BIS_VORMONAT_VJ COMMENT 'cumulative order quantity per pallet till previous month mapped to previous year',
	LIEFERMENGE_PER_STK_MONTH COMMENT 'delivery quantity per piece mapped to the calendar_1 month',
	LIEFERMENGE_PER_PAL_MONTH COMMENT 'delivery quantity per pallet mapped to the calendar_1 month',
	OPEN_ORDER_STK_PER_MONTH COMMENT 'open order per piece mapped to the calendar_1 month',
	OPEN_ORDER_STK_VORMONAT COMMENT 'open order per piece mapped to the previous month',
	OPEN_ORDER_PAL_PER_MONTH COMMENT 'open order per pallet mapped to the calendar_1 month',
	OPEN_ORDER_PAL_VORMONAT COMMENT 'open order per pallet mapped to the previous month'
) AS
WITH item_lookup AS (
	SELECT DISTINCT
    i.client_id
    ,i.country_iso_cd
    ,i.orig_item_nr AS nan
    ,IFNULL(i.src_orig_item_nr_int, i.orig_item_nr_int) AS ian
    ,IFNULL(i.item_descr,i.item_name) AS artikel_bezeichnung
    ,IFNULL(sdt.tgt_delivery_time_week_cnt,0) AS zielreichweite
FROM core_rel.t_item_1 i
LEFT JOIN core_rel.t_subitemgroup_delivery_time_target_1 sdt
ON i.subitemgrp_cd = sdt.subitemgrp_cd
WHERE ((i.client_id NOT IN (33) AND i.case_size > 0 ) OR i.client_id IN (33))
QUALIFY ROW_NUMBER() OVER (PARTITION BY i.client_id, ian, nan ORDER BY artikel_bezeichnung, i.dwh_updated_tmsp DESC) = 1 
)
, month_demand_aggregation AS (
SELECT 
	cou.client_id
	,deitm.ba_nr
	,deitm.ba_bezeichnung
	,CASE 
		WHEN CAST(deitm.supplier_id_int AS VARCHAR(38)) IN ('31839') AND deitm.bedarfsource IN ('NUTS') THEN '31839_1'
		WHEN CAST(deitm.supplier_id_int AS VARCHAR(38)) IN ('31839') AND deitm.bedarfsource IN ('CHOCOLATE') THEN '31839_2'
	 ELSE CAST(deitm.supplier_id_int AS VARCHAR(38))
	END AS supplier_id_int
	,deitm.ian
	,deitm.artikel_bezeichnung
	,deitm.palfkt
	,deitm.kolliinhalt
	,IFNULL(itm.nan,-1) AS NAN
	,itm.zielreichweite
	,deitm.cal_month
	,deitm.cal_week
	,bus.busyear
	,CAST(bus.monitoring_time_frame AS VARCHAR(100)) AS monitoring_zeitraum
	,deitm.BEDARFSMENGE_PER_STK_WEEK
	,deitm.bedarfsmenge_per_pal_week 
	,deitm.BEDARFSMENGE_PER_STK_JAHR 
	,deitm.bedarfsmenge_per_pal_jahr 
	,deitm.BESTELLMENGE_PER_STK_WEEK 
	,deitm.bestellmenge_per_pal_week 
	,deitm.LIEFERMENGE_PER_STK_WEEK 
	,deitm.liefermenge_per_pal_week 
	,deitm.OPEN_ORDER_STK_PER_WEEK 
	,deitm.open_order_pal_per_week
FROM core.T_DEMAND_ORDR_RECVD_WEEKLY_1 deitm
INNER JOIN core_rel.t_client_1 cou
ON deitm.land_1 = cou.country_cd
LEFT JOIN item_lookup itm
ON cou.client_id = itm.client_id
AND itm.ian = deitm.ian
INNER JOIN (
	SELECT 
    a.land_1
    ,a.ba_nr
    ,a.ian
    ,a.busyear
    ,a.start_month
    ,a.end_month
    ,CONCAT(b.cy_month_desc, '-', c.cy_month_desc) AS monitoring_time_frame
FROM core_rel.t_busyear_lookup_1 a
INNER JOIN (
   SELECT DISTINCT
    cy_month
    ,CONCAT(LEFT(month_name,3),' ',LEFT(cy,4)) AS cy_month_desc
FROM core_rel.v_cal_month_1
) b
ON a.start_month = b.cy_month
INNER JOIN (
   SELECT DISTINCT
    cy_month
    ,CONCAT(LEFT(month_name,3),' ',LEFT(cy,4)) AS cy_month_desc
FROM core_rel.v_cal_month_1
) c
ON a.end_month = c.cy_month
) bus 
ON deitm.land_1 = bus.land_1
AND deitm.ian = bus.ian
AND deitm.ba_nr = bus.ba_nr
AND deitm.cal_month BETWEEN bus.start_month AND bus.end_month
WHERE LOWER(deitm.bedarfsource) NOT LIKE '%elm%'
AND deitm.bedarfsmenge_per_pal_jahr > 0
),
promotion_act AS (
	WITH sales_promotion_element AS (
	SELECT 
		spe.client_id
		,spe.orig_item_nr
		,itm.ian
		,spe.sale_promo_status_cd
		,spe.promo_start_dt
		,spe.promo_sales_prod_cnt AS promo_sales_prod_cnt_stk
		,spe.promo_sales_prod_cnt/NULLIF(spe.case_size*spe.pallet_factor,0) AS promo_sales_prod_cnt_pal
		,spe.promo_factor
	FROM core_rel.T_SALES_PROMOTION_ELEMENT_1 spe
	LEFT OUTER JOIN (
		SELECT DISTINCT 
			client_id
			,ORIG_ITEM_NR AS nan
			,IFNULL(orig_item_nr_int, src_orig_item_nr_int) AS ian
		FROM core_rel.t_item_1
		QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id, IFNULL(orig_item_nr_int,src_orig_item_nr_int),case_size ORDER BY client_id,subitemgrp_cd DESC,dwh_updated_tmsp DESC) =1
	) itm
	ON spe.client_id = itm.client_id
	AND spe.orig_item_nr = itm.nan
    LEFT OUTER JOIN (
        SELECT DISTINCT
            land_1
            ,supplier_id_int
            ,ian
        FROM core.t_demand_ordr_recvd_weekly_1) dow
    ON spe.country_cd = dow.land_1
    AND itm.ian = dow.ian
	WHERE spe.promo_start_dt BETWEEN ADD_MONTHS(SYSDATE()::DATE,0) AND ADD_MONTHS(SYSDATE()::DATE,3)--only consider the promotion in the next 3 months
)
SELECT 
	apt.CLIENT_ID
	,apt.orig_item_nr AS nan
	,apt.ian
	,LISTAGG(DISTINCT apt.promo_start_dt,', ') WITHIN GROUP (ORDER BY apt.promo_start_dt)  AS promo_start_dt
	,LISTAGG(DISTINCT cal.cy_week, ', ') WITHIN GROUP (ORDER BY cal.cy_week) AS action_week
	,LISTAGG(DISTINCT apt.promo_sales_prod_cnt_stk, ', ') WITHIN GROUP (ORDER BY apt.promo_sales_prod_cnt_stk) AS action_amount_pc
	,LISTAGG(DISTINCT CEIL(apt.promo_sales_prod_cnt_pal), ', ') WITHIN GROUP (ORDER BY CEIL(apt.promo_sales_prod_cnt_pal)) AS action_amount_pal
	,LISTAGG(DISTINCT apt.promo_factor, ', ') WITHIN GROUP (ORDER BY apt.promo_factor)  AS promotion_factor
FROM sales_promotion_element apt
INNER JOIN core_rel.V_CAL_CALENDARDAY_1 cal
ON apt.promo_start_dt = cal.cal_dt
GROUP BY
	apt.client_id
	,apt.orig_item_nr
	,apt.ian
),
bestand AS (
	SELECT 
	be.client_id
	,cou.country_cd
	,be.orig_item_nr
	,itm.nan
	,itm.ian
	,be.cal_month
	,SUM(be.stock_qty) AS bestand
FROM core_rel.T_STOCK_BY_WAREHOUSE_PRODUCT_MONTH_1 be
LEFT JOIN (
	SELECT DISTINCT 
		client_id
		,nan
		,ian
	FROM FE_MSTR_SCM.V_ITEM_LOOKUP_1 
) itm
ON be.client_id = itm.client_id
AND be.orig_item_nr = itm.nan
INNER JOIN core_rel.t_client_1 cou
ON be.client_id = cou.client_id
GROUP BY 
	be.client_id
	,cou.country_cd
	,be.orig_item_nr
	,itm.nan
	,itm.ian
	,be.cal_month
),
abverkauf AS (
	SELECT
    sa.client_id
    ,cou.country_cd
    ,sa.orig_item_nr
    ,itm.ian
    ,sa.cal_month
    ,SUM(sa.sales_qty) AS abverkauf
FROM core_rel.t_sales_by_warehouse_product_month_1 sa
LEFT JOIN (
    SELECT DISTINCT
		client_id
		,nan
		,ian
	FROM FE_MSTR_SCM.V_ITEM_LOOKUP_1
) itm
ON sa.client_id = itm.client_id
AND sa.orig_item_nr = itm.nan
INNER JOIN core_rel.t_client_1 cou
ON sa.client_id = cou.client_id
GROUP BY
    sa.client_id
    ,cou.country_cd
    ,sa.orig_item_nr
    ,itm.ian
    ,sa.cal_month
),
fact_mapping_current_year AS (
SELECT
	d.client_id
	,d.busyear
	,d.monitoring_zeitraum
	,d.supplier_id_int
	,d.ba_nr
	,d.ba_bezeichnung
	,d.nan
	,d.ian
	,d.artikel_bezeichnung
	,d.palfkt
	,d.kolliinhalt
	,CAST(pa.action_week AS VARCHAR(100)) AS action_week
	,CAST(pa.action_amount_pc AS VARCHAR(100)) AS action_amount_pc
	,CAST(pa.action_amount_pal AS VARCHAR(100)) AS action_amount_pal
	,CAST(pa.promotion_factor AS VARCHAR(100)) AS promotion_factor
	,d.zielreichweite
	,d.cal_month
	,IFNULL(MAX(b.bestand),0) AS bestand_artikel_letzter_Stand_STK
	,bestand_artikel_letzter_stand_stk/NULLIF(d.palfkt*d.kolliinhalt,0) AS bestand_artikel_letzter_stand_pal
	,IFNULL(ab.abverkauf,0) AS abverkauf_artikel_per_month_stk
	,abverkauf_artikel_per_month_stk/NULLIF(d.palfkt*d.kolliinhalt,0) AS abverkauf_artikel_per_month_pal
	,MAX(d.bedarfsmenge_per_stk_jahr) AS bedarfsmenge_per_stk_jahr
	,SUM(d.bedarfsmenge_per_stk_week) AS bedarfsmenge_per_stk_month
	,SUM(bedarfsmenge_per_stk_month) OVER (PARTITION BY d.client_id, d.ian, d.ba_nr, d.busyear ORDER BY d.busyear, d.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS bedarfsmenge_aufgelaufen_per_stk_bis_vormonat
	,MAX(d.bedarfsmenge_per_pal_jahr) AS bedarfsmenge_per_pal_jahr
	,SUM(d.bedarfsmenge_per_pal_week) AS bedarfsmenge_per_pal_month
	,SUM(bedarfsmenge_per_pal_month) OVER (PARTITION BY d.client_id, d.ian, d.ba_nr, d.busyear ORDER BY d.busyear, d.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS bedarfsmenge_aufgelaufen_per_pal_bis_vormonat
	,SUM(d.bestellmenge_per_stk_week) AS bestellmenge_per_stk_month
	,SUM(bestellmenge_per_stk_month) OVER (PARTITION BY d.client_id,d.ian, d.ba_nr, d.busyear ORDER BY d.busyear, d.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS bestellmenge_aufgelaufen_per_stk_bis_vormonat
	,SUM(d.bestellmenge_per_pal_week) AS bestellmenge_per_pal_month
	,SUM(bestellmenge_per_pal_month) OVER (PARTITION BY d.client_id, d.ian, d.ba_nr, d.busyear ORDER BY d.busyear, d.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS bestellmenge_aufgelaufen_per_pal_bis_vormonat
	,SUM(d.liefermenge_per_stk_week) AS liefermenge_per_stk_month
	,SUM(d.liefermenge_per_pal_week) AS liefermenge_per_pal_month
	,SUM(d.open_order_stk_per_week) AS open_order_stk_per_month
	,SUM(d.open_order_pal_per_week) AS open_order_pal_per_month
FROM month_demand_aggregation d
LEFT JOIN bestand b
ON d.client_id = b.client_id
AND d.ian = b.ian
AND d.nan = b.orig_item_nr
AND d.cal_month = b.cal_month
LEFT JOIN abverkauf ab
ON d.client_id = ab.client_id
AND d.ian = ab.ian
AND d.nan = ab.orig_item_nr
AND d.cal_month = ab.cal_month
LEFT JOIN promotion_act pa
ON d.client_id = pa.client_id
AND d.nan = pa.nan
AND d.ian = pa.ian
GROUP BY 
	d.client_id
	,d.busyear
	,d.monitoring_zeitraum
	,d.supplier_id_int
	,d.ba_nr
	,d.ba_bezeichnung
	,d.nan
	,d.ian
	,d.artikel_bezeichnung
	,d.palfkt
	,d.kolliinhalt
	,pa.action_week
	,pa.action_amount_pc
	,pa.action_amount_pal
	,pa.promotion_factor
	,d.zielreichweite
	,d.cal_month
	,ab.abverkauf
)
SELECT 
	f.client_id
	,f.busyear
	,f.monitoring_zeitraum
	,f.supplier_id_int
	,f.ba_nr
	,f.ba_bezeichnung
	,f.nan
	,f.ian
	,f.artikel_bezeichnung
	,f.palfkt
	,f.kolliinhalt
	,f.action_week
	,f.action_amount_pc
	,f.action_amount_pal
	,f.promotion_factor
	,f.zielreichweite
	,f.cal_month
	,f.bestand_artikel_letzter_stand_stk
	,f.bestand_artikel_letzter_stand_pal
	,f.abverkauf_artikel_per_month_stk
	,LAG(f.abverkauf_artikel_per_month_stk) OVER (PARTITION BY f.client_id, f.ian ORDER BY f.cal_month) AS abverkauf_artikel_stk_vormonat
	,fp.abverkauf_artikel_per_month_stk AS abverkauf_artikel_per_month_stk_vj
	,fpp.abverkauf_artikel_per_month_stk AS abverkauf_artikel_per_month_stk_vvj
	,fppp.abverkauf_artikel_per_month_stk AS abverkauf_artikel_per_month_stk_vvvj
	,f.abverkauf_artikel_per_month_pal
	,LAG(f.abverkauf_artikel_per_month_pal) OVER (PARTITION BY f.client_id, f.ian ORDER BY f.cal_month) AS abverkauf_artikel_pal_vormonat
	,fp.abverkauf_artikel_per_month_pal AS abverkauf_artikel_per_month_pal_vj
	,fpp.abverkauf_artikel_per_month_pal AS abverkauf_artikel_per_month_pal_vvj
	,fppp.abverkauf_artikel_per_month_pal AS abverkauf_artikel_per_month_pal_vvvj
	,f.bedarfsmenge_per_stk_jahr
	,fp.bedarfsmenge_per_stk_jahr AS bedarfsmenge_per_stk_jahr_vj
	,f.bedarfsmenge_per_stk_month
	,fp.bedarfsmenge_per_stk_month AS bedarfsmenge_per_stk_month_vj
	,f.bedarfsmenge_aufgelaufen_per_stk_bis_vormonat
	,fp.bedarfsmenge_aufgelaufen_per_stk_bis_vormonat AS bedarfsmenge_aufgelaufen_per_stk_bis_vormonat_vj
	,f.bedarfsmenge_per_pal_jahr
	,fp.bedarfsmenge_per_pal_jahr AS bedarfsmenge_per_pal_jahr_vj
	,f.bedarfsmenge_per_pal_month
	,fp.bedarfsmenge_per_pal_month AS bedarfsmenge_per_pal_month_vj
	,f.bedarfsmenge_aufgelaufen_per_pal_bis_vormonat
	,fp.bedarfsmenge_aufgelaufen_per_pal_bis_vormonat AS bedarfsmenge_aufgelaufen_per_pal_bis_vormonat_vj
	,f.bestellmenge_per_stk_month
	,fp.bestellmenge_per_stk_month AS bestellmenge_per_stk_month_vj
	,f.bestellmenge_aufgelaufen_per_stk_bis_vormonat
	,fp.bestellmenge_aufgelaufen_per_stk_bis_vormonat AS bestellmenge_aufgelaufen_per_stk_bis_vormonat_vj
	,f.bestellmenge_per_pal_month
	,fp.bestellmenge_per_pal_month AS bestellmenge_per_pal_month_vj
	,f.bestellmenge_aufgelaufen_per_pal_bis_vormonat
	,fp.bestellmenge_aufgelaufen_per_pal_bis_vormonat AS bestellmenge_aufgelaufen_per_pal_bis_vormonat_vj
	,f.liefermenge_per_stk_month
	,f.liefermenge_per_pal_month
	,f.open_order_stk_per_month
	,LAG(f.open_order_stk_per_month) OVER (PARTITION BY f.client_id, f.ian, f.supplier_id_int ORDER BY f.cal_month) AS open_order_stk_vormonat
	,f.open_order_pal_per_month
	,LAG(f.open_order_pal_per_month) OVER (PARTITION BY f.client_id, f.ian, f.supplier_id_int ORDER BY f.cal_month) AS open_order_pal_vormonat
FROM fact_mapping_current_year f
JOIN (
    SELECT DISTINCT
         d.cy_month
    ,m.prev_cy_month
    ,m.preprev_cy_month
    ,m.preprevprev_cy_month
    ,dayofmonth(cal_dt_last_day_prev_1m) AS amt_day_prev_mth
FROM core.v_cal_calendarday_1 d
JOIN core_rel.v_cal_month_1 m
ON d.cy_month = m.cy_month
ORDER BY d.cy_month
) mth
ON f.cal_month = mth.cy_month
LEFT JOIN fact_mapping_current_year fp
ON f.client_id = fp.client_id
AND f.ian = fp.ian
AND f.nan = fp.nan
AND f.ba_nr = fp.ba_nr
AND f.supplier_id_int = fp.supplier_id_int
AND mth.prev_cy_month = fp.cal_month
AND f.busyear - 1 = fp.busyear
LEFT JOIN fact_mapping_current_year fpp
ON f.client_id = fpp.client_id
AND f.ian = fpp.ian
AND f.nan = fpp.nan
AND f.ba_nr = fpp.ba_nr
AND f.supplier_id_int = fpp.supplier_id_int
AND mth.preprev_cy_month = fpp.cal_month
AND f.busyear - 2 = fpp.busyear
LEFT JOIN fact_mapping_current_year fppp
ON f.client_id = fppp.client_id
AND f.ian = fppp.ian
AND f.nan = fppp.nan
AND f.ba_nr = fppp.ba_nr
AND f.supplier_id_int = fppp.supplier_id_int
AND mth.preprev_cy_month = fppp.cal_month
AND f.busyear - 3 = fppp.busyear;
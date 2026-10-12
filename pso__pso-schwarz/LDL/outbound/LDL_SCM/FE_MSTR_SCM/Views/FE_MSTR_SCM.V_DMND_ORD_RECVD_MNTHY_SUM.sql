/*########################################################################################################################################
  # View: FE_MSTR_SCM.V_DMND_ORD_RECVD_MNTHY_SUM                                                                                         
  #	Initial Developer: Gao, Pin																									             
  #	Change Management: 																												     
  #	2025-04-29   Gao, Pin               Redesign the logic and add Stock and Sales data to the logic											                 
  # 2025-05-09	 Gao, Pin               Add Zielreichweite																									     
  #	2025-05-22	 Gao, Pin               Embed the new GJ logic. Add VJ, aufgelaufen Values															             
  # 2025-07-01   Gao, Pin               Change the stock and sales table with the monthly aggregated ones                                                       
  # 2025-07-07   Gao, Pin               Added logic to separate the Schwarz Produktion Nüsse Schokolade into two suppliers                                      
  # 2025-08-19   Gao, Pin               Added logic to calculate the reichweite in day                                                                          
  # 2025-09-18   Gao, Pin               Adjust the logic by adding ba_nr to the partition for calculating the cumulative values                                 
  # 2025-11-04   Gao, Pin               Add APT table and logic  
  # 2025-12-01   Gao, Pin               Add item_lookup to avoid a inner loop by using fe_mstr_scm.v_item_lookup     
  # 2025-12-05   Gao, Pin               Add monitoring_zeitraum indicating start month and end month of the business year for each item 
  # 2026-01-08   Gao, Pin               Removal of case size and pallet factor from promotion_act session and adding HAVING statement to filter                       
  #                                     only items with a positive demand quantities  
  # 2026-01-12   Gao, Pin               Change the order of src_orig_item_nr_int and orig_item_nr_int in the item_lookup session to make sure the 
  #                                     IAN from t_wawi_itm_item_int comes first                                          
  #  																															         
  ########################################################################################################################################
*/



CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_dmnd_ord_recvd_mnthy_sum (client_id
OPTIONS(description='Identification ID of country'), busyear OPTIONS(description='business year'), monitoring_zeitraum
OPTIONS(description='start month and end month of the business year'), supplier_id_int
OPTIONS(description='supplier international id'), ba_nr OPTIONS(description='order number'), ba_bezeichnung
OPTIONS(description='order description'), nan OPTIONS(description='national article number'), ian
OPTIONS(description='international article number'), artikel_bezeichnung
OPTIONS(description='description of article name'), palfkt OPTIONS(description='pallet factor'), kolliinhalt
OPTIONS(description='case size'), action_week OPTIONS(description='the promotion week for the product'),
action_amount_pc OPTIONS(description='the promotion amount in piece for the product in the next 3 months'),
action_amount_pal OPTIONS(description='the promotion amount in pallet for the product in the next 3 months'),
promotion_factor OPTIONS(description='the promotion factor for the product'), zielreichweite
OPTIONS(description='target delivery time'), cal_month OPTIONS(description='calendar month'),
bestand_artikel_letzter_stand_stk OPTIONS(description='latest stock of the article in piece'),
bestand_artikel_letzter_stand_pal OPTIONS(description='latest stock of the article in pallet'),
abverkauf_artikel_per_monat_stk OPTIONS(description='sales of article per month in piece'),
abverkauf_artikel_stk_vormonat OPTIONS(description='sales of article in the last month per piece'),
abverkauf_artikel_per_monat_stk_vj OPTIONS(description='sales of article per month in the previous year'),
abverkauf_artikel_per_monat_stk_vvj OPTIONS(description='sales of article per month 2 years ago'),
abverkauf_artikel_per_monat_stk_vvvj OPTIONS(description='sales of article per month 3 years ago'),
abverkauf_artikel_per_monat_pal OPTIONS(description='sales of article per month in pallet'),
abverkauf_artikel_pal_vormonat OPTIONS(description='sales of article per pallet in the last month'),
abverkauf_artikel_per_monat_pal_vj OPTIONS(description='sales of article per month in pallet 1 year ago'),
abverkauf_artikel_per_monat_pal_vvj OPTIONS(description='sales of article per month in pallet 2 years ago'),
abverkauf_artikel_per_monat_pal_vvvj OPTIONS(description='sales of article per month in pallet 3 years ago'),
bedarfsmenge_per_stk_jahr OPTIONS(description='demand quantity per piece in a year'), bedarfsmenge_per_stk_jahr_vj
OPTIONS(description='demand quantity per piece in the previous year'), bedarfsmenge_per_stk_month
OPTIONS(description='demand quantity per piece mapped to the calendar month'), bedarfsmenge_per_stk_month_vj
OPTIONS(description='demand quantity per piece mapped to the previous month'),
bedarfsmenge_aufgelaufen_per_stk_bis_vormonat OPTIONS(description='cumulative demand quantity till previous month'),
bedarfsmenge_aufgelaufen_per_stk_bis_vormonat_vj
OPTIONS(description='cumulative demand quantity mapped to previous month'), bedarfsmenge_per_pal_jahr
OPTIONS(description='demand quantity per pallet mapped to the business year'), bedarfsmenge_per_pal_jahr_vj
OPTIONS(description='demand quantity per pallet mapped to the previous year'), bedarfsmenge_per_pal_month
OPTIONS(description='demand quantity per pallet mapped to the calendar month'), bedarfsmenge_per_pal_month_vj
OPTIONS(description='demand quantity per pallet mapped to the previous month'),
bedarfsmenge_aufgelaufen_per_pal_bis_vormonat
OPTIONS(description='cumulative demand quantity per pallet till previous month'),
bedarfsmenge_aufgelaufen_per_pal_bis_vormonat_vj
OPTIONS(description='cumulative demand quantity per pallet mapped to previous month'), bestellmenge_per_stk_month
OPTIONS(description='order quantity per piece mapped to the calendar month'), bestellmenge_per_stk_month_vj
OPTIONS(description='order quantity per piece mapped to the previous month'),
bestellmenge_aufgelaufen_per_stk_bis_vormonat
OPTIONS(description='cumulative order quantity per piece until previous month'),
bestellmenge_aufgelaufen_per_stk_bis_vormonat_vj
OPTIONS(description='cumulative order quantity per piece until previous month mapped to previous year'),
bestellmenge_per_pal_month OPTIONS(description='order quantity per pallet mapped to the calendar month'),
bestellmenge_per_pal_month_vj OPTIONS(description='order quantity per pallet mapped to the previous year'),
bestellmenge_aufgelaufen_per_pal_bis_vormonat
OPTIONS(description='cumulative order quantity per pallet till previous month'),
bestellmenge_aufgelaufen_per_pal_bis_vormonat_vj
OPTIONS(description='cumulative order quantity per pallet till previous month mapped to previous year'),
liefermenge_per_stk_month OPTIONS(description='delivery quantity per piece mapped to the calendar month'),
liefermenge_per_pal_month OPTIONS(description='delivery quantity per pallet mapped to the calendar month'),
open_order_stk_per_month OPTIONS(description='open order per piece mapped to the calendar month'),
open_order_stk_vormonat OPTIONS(description='open order per piece mapped to the previous month'),
open_order_pal_per_month OPTIONS(description='open order per pallet mapped to the calendar month'),
open_order_pal_vormonat OPTIONS(description='open order per pallet mapped to the previous month')) AS WITH ITEM_LOOKUP
 AS (SELECT DISTINCT I.client_id,
   I.country_iso_cd,
   I.orig_item_nr AS nan,
   IFNULL(I.src_orig_item_nr_int, I.orig_item_nr_int) AS ian,
   IFNULL(I.item_descr, I.item_name) AS artikel_bezeichnung,
   IFNULL(SDT.tgt_delivery_time_week_cnt, 0) AS zielreichweite
  FROM ldl_scm_core_rel.t_item AS I
   LEFT JOIN ldl_scm_core_rel.t_subitemgroup_delivery_time_target AS SDT ON I.subitemgrp_cd = SDT.subitemgrp_cd
  WHERE I.case_size > 0 AND I.client_id NOT IN (33)
   OR I.client_id IN (33)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(I.client_id AS STRING), ian, CAST(nan AS STRING) ORDER BY
        artikel_bezeichnung IS NULL, artikel_bezeichnung, I.dwh_updated_tmsp IS NULL DESC, I.dwh_updated_tmsp DESC)) = 1
    ), MONTH_DEMAND_AGGREGATION AS (SELECT COU.client_id,
   DEITM.ba_nr,
   DEITM.ba_bezeichnung,
    CASE
    WHEN CAST(DEITM.supplier_id_int AS STRING) IN ('31839') AND DEITM.bedarfsource IN ('NUTS')
    THEN '31839_1'
    WHEN CAST(DEITM.supplier_id_int AS STRING) IN ('31839') AND DEITM.bedarfsource IN ('CHOCOLATE')
    THEN '31839_2'
    ELSE CAST(DEITM.supplier_id_int AS STRING)
    END AS supplier_id_int,
   DEITM.ian,
   DEITM.artikel_bezeichnung,
   DEITM.palfkt,
   DEITM.kolliinhalt,
   IFNULL(itm.nan, - 1) AS nan,
   itm.zielreichweite,
   DEITM.cal_month,
   DEITM.cal_week,
   bus.busyear,
   CAST(bus.monitoring_time_frame AS STRING) AS monitoring_zeitraum,
   DEITM.bedarfsmenge_per_stk_week,
   DEITM.bedarfsmenge_per_pal_week,
   DEITM.bedarfsmenge_per_stk_jahr,
   DEITM.bedarfsmenge_per_pal_jahr,
   DEITM.bestellmenge_per_stk_week,
   DEITM.bestellmenge_per_pal_week,
   DEITM.liefermenge_per_stk_week,
   DEITM.liefermenge_per_pal_week,
   DEITM.open_order_stk_per_week,
   DEITM.open_order_pal_per_week
  FROM ldl_scm_core.t_demand_ordr_recvd_weekly AS DEITM
   INNER JOIN ldl_scm_core_rel.t_client AS COU ON DEITM.land = COU.country_cd
   LEFT JOIN ITEM_LOOKUP AS itm ON COU.client_id = itm.client_id AND DEITM.ian = itm.ian
   INNER JOIN (SELECT A.land,
     A.ba_nr,
     A.ian,
     A.busyear,
     A.start_month,
     A.end_month,
     CONCAT(b.cy_month_desc, '-', c.cy_month_desc) AS monitoring_time_frame
    FROM ldl_scm_core_rel.t_busyear_lookup AS A
     INNER JOIN (SELECT DISTINCT cy_month,
       CONCAT(LEFT(month_name, 3), ' ', LEFT(SUBSTR(CAST(cy AS STRING), 1, 20), 4)) AS cy_month_desc
      FROM ldl_scm_core_rel.v_cal_month) AS b ON A.start_month = b.cy_month
     INNER JOIN (SELECT DISTINCT cy_month,
       CONCAT(LEFT(month_name, 3), ' ', LEFT(SUBSTR(CAST(cy AS STRING), 1, 20), 4)) AS cy_month_desc
      FROM ldl_scm_core_rel.v_cal_month) AS c ON A.end_month = c.cy_month) AS bus ON DEITM.land = bus.land AND DEITM.ian
        = bus.ian AND DEITM.ba_nr = bus.ba_nr AND DEITM.cal_month BETWEEN bus.start_month AND bus.end_month
  WHERE DEITM.bedarfsmenge_per_pal_jahr > 0
   AND LOWER(DEITM.bedarfsource) NOT LIKE '%elm%'), BESTAND AS (SELECT BE.client_id,
   COU0.country_cd,
   BE.orig_item_nr,
   itm.nan,
   itm.ian,
   BE.cal_month,
   SUM(BE.stock_qty) AS bestand
  FROM ldl_scm_core_rel.t_stock_by_warehouse_product_month AS BE
   LEFT JOIN (SELECT DISTINCT client_id,
     nan,
     ian
    FROM ldl_scm_fe_mstr_scm.v_item_lookup) AS itm ON BE.client_id = itm.client_id AND BE.orig_item_nr = itm.nan
   INNER JOIN ldl_scm_core_rel.t_client AS COU0 ON BE.client_id = COU0.client_id
  GROUP BY BE.cal_month,
   BE.client_id,
   BE.orig_item_nr,
   itm.nan,
   itm.ian,
   COU0.country_cd), ABVERKAUF AS (SELECT SA.client_id,
   COU1.country_cd,
   SA.orig_item_nr,
   itm.ian,
   SA.cal_month,
   SUM(SA.sales_qty) AS abverkauf
  FROM ldl_scm_core_rel.t_sales_by_warehouse_product_month AS SA
   LEFT JOIN (SELECT DISTINCT client_id,
     nan,
     ian
    FROM ldl_scm_fe_mstr_scm.v_item_lookup) AS itm ON SA.client_id = itm.client_id AND SA.orig_item_nr = itm.nan
   INNER JOIN ldl_scm_core_rel.t_client AS COU1 ON SA.client_id = COU1.client_id
  GROUP BY SA.cal_month,
   SA.client_id,
   SA.orig_item_nr,
   itm.ian,
   COU1.country_cd), PROMOTION_ACT AS (WITH SALES_PROMOTION_ELEMENT AS (SELECT SPE.client_id,
      SPE.orig_item_nr,
      itm.ian,
      SPE.sale_promo_status_cd,
      SPE.promo_start_dt,
      SPE.promo_sales_prod_cnt AS promo_sales_prod_cnt_stk,
       SPE.promo_sales_prod_cnt / NULLIF(SPE.case_size * SPE.pallet_factor, 0) AS promo_sales_prod_cnt_pal,
      SPE.promo_factor
     FROM ldl_scm_core_rel.t_sales_promotion_element AS SPE
      LEFT JOIN (SELECT DISTINCT client_id,
        orig_item_nr AS nan,
        IFNULL(orig_item_nr_int, src_orig_item_nr_int) AS ian
       FROM ldl_scm_core_rel.t_item
       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), ian, CAST(case_size AS STRING) ORDER BY
             client_id IS NULL, client_id, subitemgrp_cd IS NULL DESC, subitemgrp_cd DESC, dwh_updated_tmsp IS NULL DESC
             , dwh_updated_tmsp DESC)) = 1) AS itm ON SPE.client_id = itm.client_id AND SPE.orig_item_nr = itm.nan
      LEFT JOIN (SELECT DISTINCT land,
        supplier_id_int,
        ian
       FROM ldl_scm_core.t_demand_ordr_recvd_weekly) AS dow ON SPE.country_cd = dow.land AND itm.ian = dow.ian
     WHERE SPE.promo_start_dt BETWEEN IF(DATE(CURRENT_DATETIME()) = LAST_DAY(DATE(CURRENT_DATETIME())), LAST_DAY(DATE_ADD(DATE(CURRENT_DATETIME()
           ), INTERVAL 0 MONTH)), DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL 0 MONTH)) AND (IF(DATE(CURRENT_DATETIME()
           ) = LAST_DAY(DATE(CURRENT_DATETIME())), LAST_DAY(DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL 3 MONTH)),
         DATE_ADD(DATE(CURRENT_DATETIME()), INTERVAL 3 MONTH)))) (SELECT apt.client_id,
      apt.orig_item_nr AS nan,
      apt.ian,
      STRING_AGG(DISTINCT CAST(apt.promo_start_dt AS STRING), ', ' ORDER BY CAST(apt.promo_start_dt AS STRING)  NULLS FIRST) AS promo_start_dt,
      STRING_AGG(DISTINCT CAST(CAL.cy_week AS STRING), ', ' ORDER BY CAST(CAL.cy_week AS STRING) NULLS FIRST) AS action_week,
      STRING_AGG(DISTINCT CAST(apt.promo_sales_prod_cnt_stk AS STRING), ', ' ORDER BY CAST(apt.promo_sales_prod_cnt_stk AS STRING)
         NULLS FIRST) AS action_amount_pc,
      STRING_AGG(DISTINCT CAST(CEIL(apt.promo_sales_prod_cnt_pal) AS STRING), ', ' ORDER BY CAST(CEIL(apt.promo_sales_prod_cnt_pal
         )AS STRING)  NULLS FIRST, CAST(CEIL(apt.promo_sales_prod_cnt_pal)AS STRING)) AS action_amount_pal,
      STRING_AGG(DISTINCT CAST(apt.promo_factor AS STRING), ', ' ORDER BY CAST(apt.promo_factor AS STRING)  NULLS FIRST) AS
      promotion_factor
     FROM SALES_PROMOTION_ELEMENT AS apt
      INNER JOIN ldl_scm_core_rel.v_cal_calendarday AS CAL ON apt.promo_start_dt = CAL.cal_dt
     GROUP BY apt.client_id,
      nan,
      apt.ian)), FACT_MAPPING_CURRENT_YEAR AS (SELECT t36.client_id,
   t36.busyear,
   t36.monitoring_zeitraum,
   t36.supplier_id_int,
   t36.ba_nr,
   t36.ba_bezeichnung,
   t36.nan,
   t36.ian,
   t36.artikel_bezeichnung,
   t36.palfkt,
   t36.kolliinhalt,
   CAST(t36.action_week AS STRING) AS action_week,
   CAST(t36.action_amount_pc AS STRING) AS action_amount_pc,
   CAST(t36.action_amount_pal AS STRING) AS action_amount_pal,
   CAST(t36.promotion_factor AS STRING) AS promotion_factor,
   t36.zielreichweite,
   t36.cal_month,
   IFNULL(t36.z0, 0) AS bestand_artikel_letzter_stand_stk,
    IFNULL(t36.z0, 0) / NULLIF(t36.palfkt * t36.kolliinhalt, 0) AS bestand_artikel_letzter_stand_pal,
   IFNULL(t36.abverkauf, 0) AS abverkauf_artikel_per_month_stk,
    IFNULL(t36.abverkauf, 0) / NULLIF(t36.palfkt * t36.kolliinhalt, 0) AS abverkauf_artikel_per_month_pal,
   t36.bedarfsmenge_per_stk_jahr,
   t36.bedarfsmenge_per_stk_month,
   SUM(t36.bedarfsmenge_per_stk_month) OVER (PARTITION BY t36.client_id, CAST(t36.ian AS STRING), CAST(t36.ba_nr AS STRING)
      , CAST(t36.busyear AS STRING) ORDER BY t36.busyear IS NULL, t36.busyear, t36.cal_month IS NULL, t36.cal_month
    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS bedarfsmenge_aufgelaufen_per_stk_bis_vormonat,
   t36.bedarfsmenge_per_pal_jahr,
   t36.bedarfsmenge_per_pal_month,
   SUM(t36.bedarfsmenge_per_pal_month) OVER (PARTITION BY t36.client_id, CAST(t36.ian AS STRING), CAST(t36.ba_nr AS STRING)
      , CAST(t36.busyear AS STRING) ORDER BY t36.busyear IS NULL, t36.busyear, t36.cal_month IS NULL, t36.cal_month
    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS bedarfsmenge_aufgelaufen_per_pal_bis_vormonat,
   t36.bestellmenge_per_stk_month,
   SUM(t36.bestellmenge_per_stk_month) OVER (PARTITION BY t36.client_id, CAST(t36.ian AS STRING), CAST(t36.ba_nr AS STRING)
      , CAST(t36.busyear AS STRING) ORDER BY t36.busyear IS NULL, t36.busyear, t36.cal_month IS NULL, t36.cal_month
    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS bestellmenge_aufgelaufen_per_stk_bis_vormonat,
   t36.bestellmenge_per_pal_month,
   SUM(t36.bestellmenge_per_pal_month) OVER (PARTITION BY t36.client_id, CAST(t36.ian AS STRING), CAST(t36.ba_nr AS STRING)
      , CAST(t36.busyear AS STRING) ORDER BY t36.busyear IS NULL, t36.busyear, t36.cal_month IS NULL, t36.cal_month
    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS bestellmenge_aufgelaufen_per_pal_bis_vormonat,
   t36.liefermenge_per_stk_month,
   t36.liefermenge_per_pal_month,
   t36.open_order_stk_per_month,
   t36.open_order_pal_per_month
  FROM (SELECT d.client_id,
     d.busyear,
     d.monitoring_zeitraum,
     d.supplier_id_int,
     d.ba_nr,
     d.ba_bezeichnung,
     d.nan,
     d.ian,
     d.artikel_bezeichnung,
     d.palfkt,
     d.kolliinhalt,
     pa.action_week,
     pa.action_amount_pc,
     pa.action_amount_pal,
     pa.promotion_factor,
     d.zielreichweite,
     d.cal_month,
     ab.abverkauf,
     MAX(b.bestand) AS z0,
     MAX(d.bedarfsmenge_per_stk_jahr) AS bedarfsmenge_per_stk_jahr,
     SUM(d.bedarfsmenge_per_stk_week) AS bedarfsmenge_per_stk_month,
     MAX(d.bedarfsmenge_per_pal_jahr) AS bedarfsmenge_per_pal_jahr,
     SUM(d.bedarfsmenge_per_pal_week) AS bedarfsmenge_per_pal_month,
     SUM(d.bestellmenge_per_stk_week) AS bestellmenge_per_stk_month,
     SUM(d.bestellmenge_per_pal_week) AS bestellmenge_per_pal_month,
     SUM(d.liefermenge_per_stk_week) AS liefermenge_per_stk_month,
     SUM(d.liefermenge_per_pal_week) AS liefermenge_per_pal_month,
     SUM(d.open_order_stk_per_week) AS open_order_stk_per_month,
     SUM(d.open_order_pal_per_week) AS open_order_pal_per_month
    FROM MONTH_DEMAND_AGGREGATION AS d
     LEFT JOIN BESTAND AS b ON d.client_id = b.client_id AND d.ian = b.ian AND d.nan = b.orig_item_nr AND d.cal_month =
       b.cal_month
     LEFT JOIN ABVERKAUF AS ab ON d.client_id = ab.client_id AND d.ian = ab.ian AND d.nan = ab.orig_item_nr AND d.cal_month
        = ab.cal_month
     LEFT JOIN PROMOTION_ACT AS pa ON d.client_id = pa.client_id AND d.nan = pa.nan AND d.ian = pa.ian
    GROUP BY d.client_id,
     d.ba_nr,
     d.ba_bezeichnung,
     d.supplier_id_int,
     d.ian,
     d.artikel_bezeichnung,
     d.palfkt,
     d.kolliinhalt,
     d.nan,
     d.zielreichweite,
     d.cal_month,
     d.busyear,
     d.monitoring_zeitraum,
     ab.abverkauf,
     pa.action_week,
     pa.action_amount_pc,
     pa.action_amount_pal,
     pa.promotion_factor) AS t36) (SELECT f.client_id,
   f.busyear,
   f.monitoring_zeitraum,
   f.supplier_id_int,
   f.ba_nr,
   f.ba_bezeichnung,
   f.nan,
   f.ian,
   f.artikel_bezeichnung,
   f.palfkt,
   f.kolliinhalt,
   f.action_week,
   f.action_amount_pc,
   f.action_amount_pal,
   f.promotion_factor,
   f.zielreichweite,
   f.cal_month,
   f.bestand_artikel_letzter_stand_stk,
   f.bestand_artikel_letzter_stand_pal,
   f.abverkauf_artikel_per_month_stk,
   LAG(f.abverkauf_artikel_per_month_stk) OVER (PARTITION BY f.client_id, CAST(f.ian AS STRING) ORDER BY f.cal_month
      IS NULL, f.cal_month) AS abverkauf_artikel_stk_vormonat,
   fp.abverkauf_artikel_per_month_stk AS abverkauf_artikel_per_month_stk_vj,
   fpp.abverkauf_artikel_per_month_stk AS abverkauf_artikel_per_month_stk_vvj,
   fppp.abverkauf_artikel_per_month_stk AS abverkauf_artikel_per_month_stk_vvvj,
   f.abverkauf_artikel_per_month_pal,
   LAG(f.abverkauf_artikel_per_month_pal) OVER (PARTITION BY f.client_id, CAST(f.ian AS STRING) ORDER BY f.cal_month
      IS NULL, f.cal_month) AS abverkauf_artikel_pal_vormonat,
   fp.abverkauf_artikel_per_month_pal AS abverkauf_artikel_per_month_pal_vj,
   fpp.abverkauf_artikel_per_month_pal AS abverkauf_artikel_per_month_pal_vvj,
   fppp.abverkauf_artikel_per_month_pal AS abverkauf_artikel_per_month_pal_vvvj,
   f.bedarfsmenge_per_stk_jahr,
   fp.bedarfsmenge_per_stk_jahr AS bedarfsmenge_per_stk_jahr_vj,
   f.bedarfsmenge_per_stk_month,
   fp.bedarfsmenge_per_stk_month AS bedarfsmenge_per_stk_month_vj,
   f.bedarfsmenge_aufgelaufen_per_stk_bis_vormonat,
   fp.bedarfsmenge_aufgelaufen_per_stk_bis_vormonat AS bedarfsmenge_aufgelaufen_per_stk_bis_vormonat_vj,
   f.bedarfsmenge_per_pal_jahr,
   fp.bedarfsmenge_per_pal_jahr AS bedarfsmenge_per_pal_jahr_vj,
   f.bedarfsmenge_per_pal_month,
   fp.bedarfsmenge_per_pal_month AS bedarfsmenge_per_pal_month_vj,
   f.bedarfsmenge_aufgelaufen_per_pal_bis_vormonat,
   fp.bedarfsmenge_aufgelaufen_per_pal_bis_vormonat AS bedarfsmenge_aufgelaufen_per_pal_bis_vormonat_vj,
   f.bestellmenge_per_stk_month,
   fp.bestellmenge_per_stk_month AS bestellmenge_per_stk_month_vj,
   f.bestellmenge_aufgelaufen_per_stk_bis_vormonat,
   fp.bestellmenge_aufgelaufen_per_stk_bis_vormonat AS bestellmenge_aufgelaufen_per_stk_bis_vormonat_vj,
   f.bestellmenge_per_pal_month,
   fp.bestellmenge_per_pal_month AS bestellmenge_per_pal_month_vj,
   f.bestellmenge_aufgelaufen_per_pal_bis_vormonat,
   fp.bestellmenge_aufgelaufen_per_pal_bis_vormonat AS bestellmenge_aufgelaufen_per_pal_bis_vormonat_vj,
   f.liefermenge_per_stk_month,
   f.liefermenge_per_pal_month,
   f.open_order_stk_per_month,
   LAG(f.open_order_stk_per_month) OVER (PARTITION BY f.client_id, CAST(f.ian AS STRING), f.supplier_id_int ORDER BY f.cal_month
      IS NULL, f.cal_month) AS open_order_stk_vormonat,
   f.open_order_pal_per_month,
   LAG(f.open_order_pal_per_month) OVER (PARTITION BY f.client_id, CAST(f.ian AS STRING), f.supplier_id_int ORDER BY f.cal_month
      IS NULL, f.cal_month) AS open_order_pal_vormonat
  FROM FACT_MAPPING_CURRENT_YEAR AS f
   INNER JOIN (SELECT DISTINCT D.cy_month,
     M.prev_cy_month,
     M.preprev_cy_month,
     M.preprevprev_cy_month,
     EXTRACT(DAY FROM D.cal_dt_last_day_prev_1m) AS amt_day_prev_mth
    FROM ldl_scm_core.v_cal_calendarday AS D
     INNER JOIN ldl_scm_core_rel.v_cal_month AS M ON D.cy_month = M.cy_month
    ORDER BY D.cy_month NULLS LAST) AS mth ON f.cal_month = mth.cy_month
   LEFT JOIN FACT_MAPPING_CURRENT_YEAR AS fp ON f.client_id = fp.client_id AND f.ian = fp.ian AND f.nan = fp.nan AND f.ba_nr
         = fp.ba_nr AND f.supplier_id_int = fp.supplier_id_int AND mth.prev_cy_month = fp.cal_month AND f.busyear - 1 =
     fp.busyear
   LEFT JOIN FACT_MAPPING_CURRENT_YEAR AS fpp ON f.client_id = fpp.client_id AND f.ian = fpp.ian AND f.nan = fpp.nan AND
        f.ba_nr = fpp.ba_nr AND f.supplier_id_int = fpp.supplier_id_int AND mth.preprev_cy_month = fpp.cal_month AND f.busyear
       - 2 = fpp.busyear
   LEFT JOIN FACT_MAPPING_CURRENT_YEAR AS fppp ON f.client_id = fppp.client_id AND f.ian = fppp.ian AND f.nan = fppp.nan
          AND f.ba_nr = fppp.ba_nr AND f.supplier_id_int = fppp.supplier_id_int AND mth.preprev_cy_month = fppp.cal_month
       AND f.busyear - 3 = fppp.busyear);



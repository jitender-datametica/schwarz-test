/*########################################################################################################################################
  # View: FE_MSTR_SCM.V_DMND_ORD_RECVD_WKLY_SUM_1                                                                                          
  #	Last Modified: Pin Gao																									             
  #	Change Management: 																												     
  #	2025-04-29  Gao, Pin      Redesign the logic only display the weekly demand											                             
  # 2025-05-09	Gao, Pin      Add Zielreichweite																							             
  #	2025-05-22  Gao, Pin      Embed the new GJ logic		                                                                                             
  #	2025-07-07	Gao, Pin      Added logic to separate Schwarz Produktion Nüsse Schokolade into two suppliers	
  #	2025-12-02	Gao, Pin      Add item_lookup session to avoid inner loop with fe_mstr_scm.v_item_lookup_1
  # 2025-12-05	Gao, Pin      Add monitoring_zeitraum for each item_1 indicating the start and end month of a business year
  # 2026-01-13  Gao, Pin      Change the order of src_orig_item_nr_int and orig_item_nr_int in the item_lookup session to make sure the 
  #                           IAN from t_wawi_itm_item_int_1 comes first                            				         
  #      																															     
  ########################################################################################################################################
*/


CREATE OR REPLACE VIEW FE_MSTR_SCM.V_DMND_ORD_RECVD_WKLY_SUM_1(
	CLIENT_ID COMMENT 'Identification ID of country_1',
	COUNTRY_CD COMMENT 'Abbreviation of country_1',
	BA_NR COMMENT 'Order number',
	BA_BEZEICHNUNG COMMENT 'Order description',
	IAN COMMENT 'International Article Number',
	NAN COMMENT 'National Article Number',
	ZIELREICHWEITE COMMENT 'target delivery time',
	SUPPLIER_ID_INT COMMENT 'supplier_1 international ID',
	PALFKT COMMENT 'pallet facotr',
	KOLLIINHALT COMMENT 'case size',
	CAL_WEEK COMMENT 'calendar_1 week',
	CAL_MONTH COMMENT 'calendar_1 month',
	BUSYEAR COMMENT 'business year',
	MONITORING_ZEITRAUM COMMENT 'start month and end month of the business year for each item_1',
	BESTELLMENGE_PER_STK_WK COMMENT 'order quantity per piece mapped to the calendar_1 week',
	BESTELLMENGE_PER_PAL_WK COMMENT 'order quantity per pallet mapped to the calendar_1 week'
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
SELECT 
	cou.client_id
	,d.land_1 AS country_cd
	,d.ba_nr
	,d.ba_bezeichnung
	,d.ian
	,IFNULL(itm.nan,-1) AS nan
	,itm.zielreichweite
	,CASE 
		WHEN CAST(d.supplier_id_int AS VARCHAR(38)) IN ('31839') AND d.BEDARFSOURCE IN ('NUTS') THEN '31839_1'
		WHEN CAST(d.supplier_id_int AS VARCHAR(38)) IN ('31839') AND d.BEDARFSOURCE IN ('CHOCOLATE') THEN '31839_2'
	 ELSE CAST(d.supplier_id_int AS VARCHAR(38))
	END AS supplier_id_int
	,d.palfkt
	,d.kolliinhalt
	,d.cal_week
	,d.cal_month
	,bus.busyear
	,CAST(bus.monitoring_time_frame AS VARCHAR(100)) AS monitoring_zeitraum
	,d.bestellmenge_per_stk_week AS bestellmenge_per_stk_wk
	,d.bestellmenge_per_pal_week AS bestellmenge_per_pal_wk
FROM core.t_demand_ordr_recvd_weekly_1 d
INNER JOIN core_rel.t_client_1 cou
ON d.land_1 = cou.country_cd
LEFT JOIN item_lookup itm
ON cou.client_id = itm.client_id
AND d.ian = itm.ian
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
ON d.land_1 = bus.land_1
AND d.ian = bus.ian
AND d.ba_nr = bus.ba_nr
AND d.cal_month BETWEEN bus.start_month AND bus.end_month
WHERE LOWER(d.bedarfsource) NOT LIKE '%elm%'
AND d.bedarfsmenge_per_pal_jahr > 0
;

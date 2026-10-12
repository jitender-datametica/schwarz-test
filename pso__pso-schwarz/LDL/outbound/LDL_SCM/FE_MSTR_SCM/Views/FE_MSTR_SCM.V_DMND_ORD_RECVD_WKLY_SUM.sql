/*########################################################################################################################################
  # View: FE_MSTR_SCM.V_DMND_ORD_RECVD_WKLY_SUM                                                                                          
  #	Last Modified: Pin Gao																									             
  #	Change Management: 																												     
  #	2025-04-29  Gao, Pin      Redesign the logic only display the weekly demand											                             
  # 2025-05-09	Gao, Pin      Add Zielreichweite																							             
  #	2025-05-22  Gao, Pin      Embed the new GJ logic		                                                                                             
  #	2025-07-07	Gao, Pin      Added logic to separate Schwarz Produktion Nüsse Schokolade into two suppliers	
  #	2025-12-02	Gao, Pin      Add item_lookup session to avoid inner loop with fe_mstr_scm.v_item_lookup
  # 2025-12-05	Gao, Pin      Add monitoring_zeitraum for each item indicating the start and end month of a business year
  # 2026-01-13  Gao, Pin      Change the order of src_orig_item_nr_int and orig_item_nr_int in the item_lookup session to make sure the 
  #                           IAN from t_wawi_itm_item_int comes first                            				         
  #      																															     
  ########################################################################################################################################
*/


CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_dmnd_ord_recvd_wkly_sum (client_id
OPTIONS(description='Identification ID of country'), country_cd OPTIONS(description='Abbreviation of country'), ba_nr
OPTIONS(description='Order number'), ba_bezeichnung OPTIONS(description='Order description'), ian
OPTIONS(description='International Article Number'), nan OPTIONS(description='National Article Number'), zielreichweite
OPTIONS(description='target delivery time'), supplier_id_int OPTIONS(description='supplier international ID'), palfkt
OPTIONS(description='pallet facotr'), kolliinhalt OPTIONS(description='case size'), cal_week
OPTIONS(description='calendar week'), cal_month OPTIONS(description='calendar month'), busyear
OPTIONS(description='business year'), monitoring_zeitraum
OPTIONS(description='start month and end month of the business year for each item'), bestellmenge_per_stk_wk
OPTIONS(description='order quantity per piece mapped to the calendar week'), bestellmenge_per_pal_wk
OPTIONS(description='order quantity per pallet mapped to the calendar week')) AS WITH ITEM_LOOKUP AS (SELECT DISTINCT I
   .client_id,
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
    ) (SELECT COU.client_id,
   D.land AS country_cd,
   D.ba_nr,
   D.ba_bezeichnung,
   D.ian,
   IFNULL(itm.nan, - 1) AS nan,
   itm.zielreichweite,
    CASE
    WHEN CAST(D.supplier_id_int AS STRING) IN ('31839') AND D.bedarfsource IN ('NUTS')
    THEN '31839_1'
    WHEN CAST(D.supplier_id_int AS STRING) IN ('31839') AND D.bedarfsource IN ('CHOCOLATE')
    THEN '31839_2'
    ELSE CAST(D.supplier_id_int AS STRING)
    END AS supplier_id_int,
   D.palfkt,
   D.kolliinhalt,
   D.cal_week,
   D.cal_month,
   bus.busyear,
   CAST(bus.monitoring_time_frame AS STRING) AS monitoring_zeitraum,
   D.bestellmenge_per_stk_week AS bestellmenge_per_stk_wk,
   D.bestellmenge_per_pal_week AS bestellmenge_per_pal_wk
  FROM ldl_scm_core.t_demand_ordr_recvd_weekly AS D
   INNER JOIN ldl_scm_core_rel.t_client AS COU ON D.land = COU.country_cd
   LEFT JOIN ITEM_LOOKUP AS itm ON COU.client_id = itm.client_id AND D.ian = itm.ian
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
      FROM ldl_scm_core_rel.v_cal_month) AS c ON A.end_month = c.cy_month) AS bus ON D.land = bus.land AND D.ian = bus.ian
        AND D.ba_nr = bus.ba_nr AND D.cal_month BETWEEN bus.start_month AND bus.end_month
  WHERE D.bedarfsmenge_per_pal_jahr > 0
   AND LOWER(D.bedarfsource) NOT LIKE '%elm%');
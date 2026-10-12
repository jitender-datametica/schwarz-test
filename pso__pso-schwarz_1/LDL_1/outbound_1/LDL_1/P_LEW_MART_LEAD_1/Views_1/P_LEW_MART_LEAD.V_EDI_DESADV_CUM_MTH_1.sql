CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_edi_desadv_cum_mth_1 (client_id OPTIONS(description='Client ID'), ctry_grp_id
OPTIONS(description='Country_1 group ID'), aspect_id
OPTIONS(description='Aspect ID (1=Betriebsgesellschaft, 2=Vertriebsgesellschaft)'), wh_id
OPTIONS(description='Warehouse ID'), wh_loc_sid OPTIONS(description='Location_1 surrogate ID'), sup_sid
OPTIONS(description='Supplier_1 surrogate ID'), gl_loc_nr OPTIONS(description='Supplier_1 global location_1 number'), sup_name
OPTIONS(description='Supplier_1 name'), byr OPTIONS(description='Current business year of the record'), cy_month
OPTIONS(description='Current calendar_1 week of the record'), byr_py
OPTIONS(description='Business year in previous calendar_1 year'), cy_month_py
OPTIONS(description='Calendar_1 week in previous calendar_1 year'), byr_seq
OPTIONS(description='Sequence for business year'), cy_month_seq OPTIONS(description='Sequence for calendar_1 week'),
base_desp_adv_cnt_mth_sum OPTIONS(description='Total number of despatch advices per calendar_1 month'),
base_desp_adv_cnt_mth_cum
OPTIONS(description='Running total number of despatch advices within a business year cumulated after every calendar_1 month'),
base_desp_adv_cnt_mth_sum_py
OPTIONS(description='Total number of despatch advices of the calendar_1 month of the previous business year (mapped to the current month)'),
base_desp_adv_cnt_mth_cum_py
OPTIONS(description='Total number of despatch advices cumulated after every calendar_1 month within the previous business year (mapped to the current month)'),
usable_desp_adv_cnt_mth_sum OPTIONS(description='Total number of usable despatch advices per calendar_1 month'),
usable_desp_adv_cnt_mth_cum
OPTIONS(description='Running total number of usable despatch advices within a business year cumulated after every calendar_1 month'),
usable_desp_adv_cnt_mth_sum_py
OPTIONS(description='Total number of usable despatch advices of the calendar_1 month of the previuos business year (mapped to the current month)'),
usable_desp_adv_cnt_mth_cum_py
OPTIONS(description='Running total number of usable despatch advices cumulated after every calendar_1 month whint the previous business year (mapped to the current month)'),
base_wh_rcvg_all_cnt_mth_sum OPTIONS(description='Total number of item_1 receipts (All) per calendar_1 month'),
base_wh_rcvg_all_cnt_mth_cum
OPTIONS(description='Running total number of item_1 receipts (All) within a business year cumulated after every calendar_1 month'),
base_wh_rcvg_all_cnt_mth_sum_py
OPTIONS(description='Total number of item_1 receipts (All) of the calendar_1 month of the previous business year (mapped to the current month)'),
base_wh_rcvg_all_cnt_mth_cum_py
OPTIONS(description='Total number of item_1 receipts (All) cumulated after every calendar_1 month within the previous business year (mapped to the current month)'),
base_wh_rcvg_edi_cnt_mth_sum OPTIONS(description='Total number of item_1 receipts (EDI) per calendar_1 month'),
base_wh_rcvg_edi_cnt_mth_cum
OPTIONS(description='Running total number of item_1 receipts (EDI) within a business year cumulated after every calendar_1 month'),
base_wh_rcvg_edi_cnt_mth_sum_py
OPTIONS(description='Total number of item_1 receipts (EDI) of the calendar_1 week of the previous business year (mapped to the current month)'),
base_wh_rcvg_edi_cnt_mth_cum_py
OPTIONS(description='Total number of item_1 receipts (EDI) cumulated after every calendar_1 month within the previous business year (mapped to the current month)'),
base_item_rcvg_cnt_mth_sum OPTIONS(description='Total number of item_1 receiving countings per calendar_1 month'),
base_item_rcvg_cnt_mth_cum
OPTIONS(description='Running total number of item_1 receiving countings within a business year cumulated after every calendar_1 month'),
base_item_rcvg_cnt_mth_sum_py
OPTIONS(description='Total number of item_1 receiving countings of the calendar_1 month of the previous business year (mapped to the current month)'),
base_item_rcvg_cnt_mth_cum_py
OPTIONS(description='Total number of item_1 receiving countings cumulated after every calendar_1 month within the previous business year (mapped to the current month)'),
tgt_rate_adv_overall_all OPTIONS(description='DESADV overall target rate for All per country_1 and business year'),
tgt_rate_adv_overall_edi OPTIONS(description='DESADV overall target rate for EDI per country_1 and business year'),
tgt_rate_adv_avail_all OPTIONS(description='DESADV availability target rate for All per country_1 and business year'),
tgt_rate_adv_avail_edi OPTIONS(description='DESADV availability target rate for EDI per country_1 and business year'),
tgt_rate_adv_usage OPTIONS(description='DESADV usage target rate per country_1 and business year'))
OPTIONS(DESCRIPTION = `VIEW WITH CUMULATED FACTS FOR MONTH - MIS LEAD / 02 PROZESSE / 021103 WARE UMSCHLAGEN / EDI/ DESADV KENNZAHLEN`)
AS WITH LISTING_SUPPLIERS AS (SELECT client_id,
   ctry_grp_id,
   aspect_id,
   wh_id,
   wh_loc_sid,
   sup_sid
  FROM ldl_p_lew_mart_lead.v_edi_desadv_agg_1
  GROUP BY client_id,
   ctry_grp_id,
   aspect_id,
   wh_id,
   wh_loc_sid,
   sup_sid), LISTING_MONTHS AS (SELECT C.busyear,
   C.cy_month,
    C.busyear - 1 AS busyear_prev_1y,
   M.cy_month_prev_1y,
   C.busyear_seq,
   C.cy_month_seq
  FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS C
   INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS M ON C.cy_month = M.cy_month
  WHERE C.busyear_seq BETWEEN - 2 AND 0
   AND C.cy_month_seq <= 0
  GROUP BY C.busyear,
   C.cy_month,
   busyear_prev_1y,
   M.cy_month_prev_1y,
   C.busyear_seq,
   C.cy_month_seq), LISTING_INDEX AS (SELECT *
  FROM (SELECT DISTINCT *
    FROM LISTING_SUPPLIERS AS s) AS t1_1
   INNER JOIN LISTING_MONTHS AS m ON TRUE), FACT_AGGREGATION_MONTH AS (SELECT client_id,
   aspect_id,
   wh_id,
   sup_sid,
   byr,
   cy_month,
   SUM(desp_adv_cnt) AS desp_adv_cnt_mth_sum,
   SUM(SUM(desp_adv_cnt)) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), CAST(sup_sid AS STRING), CAST(byr AS STRING)
      ORDER BY cy_month IS NULL, cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS desp_adv_cnt_mth_cum,
   SUM(usable_desp_adv_cnt) AS usable_desp_adv_cnt_mth_sum,
   SUM(SUM(usable_desp_adv_cnt)) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), CAST(sup_sid AS STRING)
      , CAST(byr AS STRING) ORDER BY cy_month IS NULL, cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   usable_desp_adv_cnt_mth_cum,
   SUM(wh_rcvg_all_cnt) AS wh_rcvg_all_cnt_mth_sum,
   SUM(SUM(wh_rcvg_all_cnt)) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), CAST(sup_sid AS STRING)
      , CAST(byr AS STRING) ORDER BY cy_month IS NULL, cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   wh_rcvg_all_cnt_mth_cum,
   SUM(wh_rcvg_edi_cnt) AS wh_rcvg_edi_cnt_mth_sum,
   SUM(SUM(wh_rcvg_edi_cnt)) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), CAST(sup_sid AS STRING)
      , CAST(byr AS STRING) ORDER BY cy_month IS NULL, cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   wh_rcvg_edi_cnt_mth_cum,
   SUM(item_rcvg_cnt) AS item_rcvg_cnt_mth_sum,
   SUM(SUM(item_rcvg_cnt)) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), CAST(sup_sid AS STRING)
      , CAST(byr AS STRING) ORDER BY cy_month IS NULL, cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   item_rcvg_cnt_mth_cum
  FROM ldl_p_lew_mart_lead.v_edi_desadv_agg_1
  GROUP BY client_id,
   aspect_id,
   wh_id,
   sup_sid,
   byr,
   cy_month), MAPPING_INDEX_FACT_PREVIOUSYEAR AS (SELECT i.client_id,
   i.ctry_grp_id,
   i.aspect_id,
   i.wh_id,
   i.wh_loc_sid,
   i.sup_sid,
   i.busyear,
   i.cy_month,
   i.busyear_prev_1y,
   i.cy_month_prev_1y,
   i.busyear_seq,
   i.cy_month_seq -- 1. Mapping fact of previous year for despatch advices (Angekommene Lieferavise)
,
   f.desp_adv_cnt_mth_sum,
   COALESCE(f.desp_adv_cnt_mth_cum, LAG(f.desp_adv_cnt_mth_cum) OVER (PARTITION BY CAST(i.client_id AS STRING), CAST(i.wh_id AS STRING)
       , CAST(i.sup_sid AS STRING), CAST(i.busyear AS STRING) ORDER BY i.cy_month IS NULL, i.cy_month)) AS
   desp_adv_cnt_mth_cum,
   fp.desp_adv_cnt_mth_sum AS desp_adv_cnt_mth_sum_py,
   COALESCE(fp.desp_adv_cnt_mth_cum, LAG(fp.desp_adv_cnt_mth_cum) OVER (PARTITION BY CAST(i.client_id AS STRING), CAST(i.wh_id AS STRING)
       , CAST(i.sup_sid AS STRING), CAST(i.busyear AS STRING) ORDER BY i.cy_month IS NULL, i.cy_month)) AS
   desp_adv_cnt_mth_cum_py,
   f.usable_desp_adv_cnt_mth_sum,
   COALESCE(f.usable_desp_adv_cnt_mth_cum, LAG(f.usable_desp_adv_cnt_mth_cum) OVER (PARTITION BY CAST(i.client_id AS STRING)
       , CAST(i.wh_id AS STRING), CAST(i.sup_sid AS STRING), CAST(i.busyear AS STRING) ORDER BY i.cy_month IS NULL, i.cy_month
       )) AS usable_desp_adv_cnt_mth_cum,
   fp.usable_desp_adv_cnt_mth_sum AS usable_desp_adv_cnt_mth_sum_py,
   COALESCE(fp.usable_desp_adv_cnt_mth_cum, LAG(fp.usable_desp_adv_cnt_mth_cum) OVER (PARTITION BY CAST(i.client_id AS STRING)
       , CAST(i.wh_id AS STRING), CAST(i.sup_sid AS STRING), CAST(i.busyear AS STRING) ORDER BY i.cy_month IS NULL, i.cy_month
       )) AS usable_desp_adv_cnt_mth_cum_py,
   f.wh_rcvg_all_cnt_mth_sum,
   COALESCE(f.wh_rcvg_all_cnt_mth_cum, LAG(f.wh_rcvg_all_cnt_mth_cum) OVER (PARTITION BY CAST(i.client_id AS STRING), CAST(i.wh_id AS STRING)
       , CAST(i.sup_sid AS STRING), CAST(i.busyear AS STRING) ORDER BY i.cy_month IS NULL, i.cy_month)) AS
   wh_rcvg_all_cnt_mth_cum,
   fp.wh_rcvg_all_cnt_mth_sum AS wh_rcvg_all_cnt_mth_sum_py,
   COALESCE(fp.wh_rcvg_all_cnt_mth_cum, LAG(fp.wh_rcvg_all_cnt_mth_cum) OVER (PARTITION BY CAST(i.client_id AS STRING), CAST(i.wh_id AS STRING)
       , CAST(i.sup_sid AS STRING), CAST(i.busyear AS STRING) ORDER BY i.cy_month IS NULL, i.cy_month)) AS
   wh_rcvg_all_cnt_mth_cum_py,
   f.wh_rcvg_edi_cnt_mth_sum,
   COALESCE(f.wh_rcvg_edi_cnt_mth_cum, LAG(f.wh_rcvg_edi_cnt_mth_cum) OVER (PARTITION BY CAST(i.client_id AS STRING), CAST(i.wh_id AS STRING)
       , CAST(i.sup_sid AS STRING), CAST(i.busyear AS STRING) ORDER BY i.cy_month IS NULL, i.cy_month)) AS
   wh_rcvg_edi_cnt_mth_cum,
   fp.wh_rcvg_edi_cnt_mth_sum AS wh_rcvg_edi_cnt_mth_sum_py,
   COALESCE(fp.wh_rcvg_edi_cnt_mth_cum, LAG(fp.wh_rcvg_edi_cnt_mth_cum) OVER (PARTITION BY CAST(i.client_id AS STRING), CAST(i.wh_id AS STRING)
       , CAST(i.sup_sid AS STRING), CAST(i.busyear AS STRING) ORDER BY i.cy_month IS NULL, i.cy_month)) AS
   wh_rcvg_edi_cnt_mth_cum_py,
   f.item_rcvg_cnt_mth_sum,
   COALESCE(f.item_rcvg_cnt_mth_cum, LAG(f.item_rcvg_cnt_mth_cum) OVER (PARTITION BY CAST(i.client_id AS STRING), CAST(i.wh_id AS STRING)
       , CAST(i.sup_sid AS STRING), CAST(i.busyear AS STRING) ORDER BY i.cy_month IS NULL, i.cy_month)) AS
   item_rcvg_cnt_mth_cum,
   fp.item_rcvg_cnt_mth_sum AS item_rcvg_cnt_mth_sum_py,
   COALESCE(fp.item_rcvg_cnt_mth_cum, LAG(fp.item_rcvg_cnt_mth_cum) OVER (PARTITION BY CAST(i.client_id AS STRING), CAST(i.wh_id AS STRING)
       , CAST(i.sup_sid AS STRING), CAST(i.busyear AS STRING) ORDER BY i.cy_month IS NULL, i.cy_month)) AS
   item_rcvg_cnt_mth_cum_py
  FROM LISTING_INDEX AS i
   LEFT JOIN FACT_AGGREGATION_MONTH AS f ON i.client_id = f.client_id AND i.aspect_id = f.aspect_id AND i.wh_id = f.wh_id
         AND i.sup_sid = f.sup_sid AND i.busyear = f.byr AND i.cy_month = f.cy_month
   LEFT JOIN FACT_AGGREGATION_MONTH AS fp ON i.client_id = fp.client_id AND i.aspect_id = fp.aspect_id AND i.wh_id = fp
        .wh_id AND i.sup_sid = fp.sup_sid AND i.busyear_prev_1y = fp.byr
      -- To avoid doubled matches because of week 9 as first week of a business year (partial week in Feb and partial week in Mar separately)

       AND i.cy_month_prev_1y = fp.cy_month
  QUALIFY i.busyear > (MIN(i.busyear) OVER (PARTITION BY 1 RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)))
 , LIMITATION_TARGET_RATES AS (SELECT client_id,
   bus_year,
   advice_target_rate AS tgt_rate_adv_overall_all,
   advice_edi_target_rate AS tgt_rate_adv_overall_edi,
   advice_avail_target_rate AS tgt_rate_adv_avail_all,
   advice_avail_edi_target_rate AS tgt_rate_adv_avail_edi,
   advice_usage_target_rate AS tgt_rate_adv_usage,
   dwh_valid_from,
   dwh_valid_to -- , dwh_created
 -- , dwh_updated

  FROM ldl_p_lew_core_ac.v_despatch_advice_usage_plan_hist_1
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to), LISTING_SUPPLIER_INFORMATION AS (SELECT client_id,
   supplier_id,
   global_location_nr,
   supplier_name,
   orig_supplier_nr,
   supplier_id_int
  FROM ldl_p_lew_mart_msi_ac.v_sup_supplier_1
  WHERE supplier_id >= 0 -- excluding country_1 entries
), KPI_TARGETS AS (SELECT f.client_id,
   f.ctry_grp_id,
   f.aspect_id,
   f.wh_id,
   f.wh_loc_sid,
   f.sup_sid,
   s.global_location_nr,
   s.supplier_name,
   f.busyear,
   f.cy_month,
   f.busyear_prev_1y,
   f.cy_month_prev_1y,
   f.busyear_seq,
   f.cy_month_seq -- 1. despatch advices (Angekommene Lieferavise)
,
   f.desp_adv_cnt_mth_sum -- Angekommene Lieferavise - Ist
,
   f.desp_adv_cnt_mth_cum -- Angekommene Lieferavise - Ist aufgel.
,
   f.desp_adv_cnt_mth_sum_py -- Angekommene Lieferavise - VJ
,
   f.desp_adv_cnt_mth_cum_py -- Angekommene Lieferavise - VJ aufgel.

   -- usable despatch advices (Verwendbare Lieferavise)
,
   f.usable_desp_adv_cnt_mth_sum -- Verwendbare Lieferavise - Ist
,
   f.usable_desp_adv_cnt_mth_cum -- Verwendbare Lieferavise -- Ist augel.
,
   f.usable_desp_adv_cnt_mth_sum_py -- Verwendbare Lieferavise - VJ
,
   f.usable_desp_adv_cnt_mth_cum_py -- Verwendbare Lieferavise - VJ augfel.

   -- 2. booked item_1 receipts at a warehouse (Gebuchte Wareneingaenge Gesamt)
,
   f.wh_rcvg_all_cnt_mth_sum -- Gebuchte Wareneingaenge Gesamt - Ist
,
   f.wh_rcvg_all_cnt_mth_cum -- Gebuchte Wareneingaenge Gesamt - Ist aufgel.
,
   f.wh_rcvg_all_cnt_mth_sum_py -- Gebuchte Wareneingaenge Gesamt - VJ
,
   f.wh_rcvg_all_cnt_mth_cum_py -- Gebuchte Wareneingaenge Gesamt - VJ aufgel.

   -- 3. booked item_1 receipts at a warehouse limited to EDI (Gebuchte Wareneingaenge EDI Lieferanten)
,
   f.wh_rcvg_edi_cnt_mth_sum -- Gebuchte Wareneingaenge EDI Lieferanten - Ist
,
   f.wh_rcvg_edi_cnt_mth_cum -- Gebuchte Wareneingaenge EDI Lieferanten - Ist aufgel.
,
   f.wh_rcvg_edi_cnt_mth_sum_py -- Gebuchte Wareneingaenge EDI Lieferanten - VJ
,
   f.wh_rcvg_edi_cnt_mth_cum_py -- Gebuchte Wareneingaenge EDI Lieferanten - VJ aufgel.

   -- 4. item_1 receiving countings with a referenced used despatch advice (Verwendete Lieferavise)
,
   f.item_rcvg_cnt_mth_sum -- Verwendete Lieferavise - Ist
,
   f.item_rcvg_cnt_mth_cum -- Verwendete Lieferavise - Ist aufgel.
,
   f.item_rcvg_cnt_mth_sum_py -- Verwendete Lieferavise - VJ
,
   f.item_rcvg_cnt_mth_cum_py -- Verwendete Lieferavise - VJ aufgel.
 -- Target rates for each country_1
,
   t.tgt_rate_adv_overall_all -- DESADV target rate for All per country_1 and business year
,
   t.tgt_rate_adv_overall_edi -- DESADV target rate for EDI per country_1 and business year
,
   t.tgt_rate_adv_avail_all -- Availability target rate for All per country_1 and business year
,
   t.tgt_rate_adv_avail_edi -- Availability target rate for EDI per country_1 and business year
,
   t.tgt_rate_adv_usage -- Usage target rate per country_1 and business year

  FROM MAPPING_INDEX_FACT_PREVIOUSYEAR AS f
   LEFT JOIN LIMITATION_TARGET_RATES AS t ON f.client_id = t.client_id AND f.busyear = t.bus_year
   LEFT JOIN LISTING_SUPPLIER_INFORMATION AS s ON f.client_id = s.client_id AND f.sup_sid = s.supplier_id) (-- 'Target rate of despatch advices which have been used in the receivings process among all receivings (all suppliers)'

  -- 'Target rate of despatch advices which have been used in the receivings process among all receivings (EDI suppliers only)'

  -- 'Target rate of sent despatch advices among all receivings (all suppliers)'

  -- 'Target rate of sent despatch advices among all receivings (EDI suppliers only)'

  -- 'Target rate of despatch advices which have been used in the receivings process among all sent despatch advices from EDI suppliers only'

  -- month total (Angekommene Lieferavise - Ist)
 -- Month total (verwendbare Lieferavise - Ist)

  -- month total (Gebuchte Wareneingaenge Gesamt - Ist)
 -- month total (Gebuchte Wareneingaege EDI Lieferanten - Ist)

  -- Angekommene Lieferavise - VJ
 -- Angekommene Lieferavise - VJ aufgel.

  -- Mapping fact of previous year for usable despatch advices (Verwendbare Lieferavise)

  -- Verwendbare Lieferavise - VJ

  -- 2. Mapping fact of previous year for booked item_1 receipts at a warehouse (Gebuchte Wareneingaenge Gesamt)

  -- Gebuchte Wareneingaenge Gesamt - VJ
 -- Gebuchte Wareneingaenge Gesamt - VJ aufgel.

  -- 3. Mapping fact of previous year for booked item_1 receipts at a warehouse limited to EDI (Gebuchte Wareneingaenge EDI Lieferanten)

  -- Gebuchte Wareneingaenge EDI Lieferanten - VJ
 -- Gebuchte Wareneingaenge EDI Lieferanten - VJ aufgel.

  -- 4. Mapping fact of previous year for item_1 receiving countings with a referenced used despatch advice (Verwendete Lieferavise)

  -- Verwendete Lieferavise - VJ
 -- Verwendete Lieferavise - VJ aufgel.

  -- filter out the data of that oldest year where values for previous year are empty
 SELECT client_id,
   ctry_grp_id,
   aspect_id,
   wh_id,
   wh_loc_sid,
   sup_sid,
   global_location_nr AS gl_loc_nr,
   supplier_name AS sup_name,
   busyear AS byr,
   cy_month,
   busyear_prev_1y AS byr_py,
   cy_month_prev_1y AS cy_month_py,
   busyear_seq AS byr_seq,
   cy_month_seq,
   desp_adv_cnt_mth_sum AS base_desp_adv_cnt_mth_sum,
   desp_adv_cnt_mth_cum AS base_desp_adv_cnt_mth_cum,
   desp_adv_cnt_mth_sum_py AS base_desp_adv_cnt_mth_sum_py,
   desp_adv_cnt_mth_cum_py AS base_desp_adv_cnt_mth_cum_py,
   usable_desp_adv_cnt_mth_sum,
   usable_desp_adv_cnt_mth_cum,
   usable_desp_adv_cnt_mth_sum_py,
   usable_desp_adv_cnt_mth_cum_py,
   wh_rcvg_all_cnt_mth_sum AS base_wh_rcvg_all_cnt_mth_sum,
   wh_rcvg_all_cnt_mth_cum AS base_wh_rcvg_all_cnt_mth_cum,
   wh_rcvg_all_cnt_mth_sum_py AS base_wh_rcvg_all_cnt_mth_sum_py,
   wh_rcvg_all_cnt_mth_cum_py AS base_wh_rcvg_all_cnt_mth_cum_py,
   wh_rcvg_edi_cnt_mth_sum AS base_wh_rcvg_edi_cnt_mth_sum,
   wh_rcvg_edi_cnt_mth_cum AS base_wh_rcvg_edi_cnt_mth_cum,
   wh_rcvg_edi_cnt_mth_sum_py AS base_wh_rcvg_edi_cnt_mth_sum_py,
   wh_rcvg_edi_cnt_mth_cum_py AS base_wh_rcvg_edi_cnt_mth_cum_py,
   item_rcvg_cnt_mth_sum AS base_item_rcvg_cnt_mth_sum,
   item_rcvg_cnt_mth_cum AS base_item_rcvg_cnt_mth_cum,
   item_rcvg_cnt_mth_sum_py AS base_item_rcvg_cnt_mth_sum_py,
   item_rcvg_cnt_mth_cum_py AS base_item_rcvg_cnt_mth_cum_py,
   tgt_rate_adv_overall_all,
   tgt_rate_adv_overall_edi,
   tgt_rate_adv_avail_all,
   tgt_rate_adv_avail_edi,
   tgt_rate_adv_usage
  FROM KPI_TARGETS);
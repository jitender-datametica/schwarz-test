CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_PICKING_PERFORMANCE_DAY_1
AS
   SELECT
     client_id                 AS client_id,
   wh_id                     AS wh_id,
   wh_loc_sid                AS wh_loc_sid,
   dat_calendar              AS dat_calendar,
   cy_week                   AS cy_week,
   cy_month                  AS cy_month,
   picking_main_area_nr_pp   AS picking_main_area_nr_pp,
   picking_main_area_desc_pp AS picking_main_area_desc_pp,
   picking_area_nr_pp        AS picking_area_nr_pp,
   picking_area_desc_pp      AS picking_area_desc_pp,
   picking_receipt_nr        AS picking_receipt_nr,
   order_nr                  AS order_nr,
   qty_sum_working_time_sec  AS qty_sum_working_time_sec,
   means_of_transport_id     AS means_of_transport_id,
   picked_cases              AS picked_cases,
   picked_cases_by_pbv       AS picked_cases_by_pbv,
   picked_cases_not_by_pbv   AS picked_cases_not_by_pbv,
   picked_ep_places          AS picked_ep_places,
   thm_1                     AS thm_1,
   thm_2                     AS thm_2,
   thm_3                     AS thm_3,
   thm_4                     AS thm_4,
   thm_5                     AS thm_5,
   thm_else                  AS thm_else,
   first_entry_fg            AS first_entry_fg

  FROM p_lew_mart_lead.v_agg_picking_performance_day_1
;
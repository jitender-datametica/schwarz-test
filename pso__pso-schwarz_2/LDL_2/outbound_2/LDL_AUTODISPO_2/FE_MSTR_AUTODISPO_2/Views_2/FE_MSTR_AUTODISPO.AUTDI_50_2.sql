/* Version: 2.3
  ** Author:  Dominik Pfarr
  ** Date:  2024-07-24
  ** Changes:  adding 2 new reasons for cooldown, adjust multiple reasons, filter on UWG instead of area_name; temp. remove cooldown; adding fpast; adjusting forecast error for today and past, remove chiller and min_max; adjusting partition by; check for fk_mil of last opening date - adjusted; Chiller and multireasons corrected again; reshape evaluation; re_2-include "other" as default reason; max(storecalculation_id) */
CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.autdi_50_2 AS WITH LAST_OPEN_DAY AS (SELECT M.country_2,
   M.store,
   M.item_nr,
   M.itemnr_long,
   M.entrydate,
   M.warehousemil,
   M.orderarea,
   M.std,
   M.status_2,
   M.quantity,
   M.capacity,
   MAX(C.cal_dt) AS prev_day
  FROM ldl_autodispo_core.t_oracle_v_fk_mil_2 AS M
   INNER JOIN ldl_autodispo_fe_mstr_autodispo.v_dim_calendar_date_2 AS C ON TRUE
   LEFT JOIN ldl_autodispo_core.t_oracle_v_specialday_2 AS SD ON M.country_2 = SD.country_2 AND M.store = SD.store AND C.cal_dt
      = SD.sp_day
  WHERE C.cal_dt BETWEEN DATE_SUB(DATE(M.entrydate), INTERVAL 8 DAY) AND (DATE_SUB(DATE(M.entrydate), INTERVAL 1 DAY))
   AND DATE(M.entrydate) >= DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY)
   AND M.quantity = 0
   AND (SD.store IS NULL OR SD.reports = 1)
  GROUP BY M.country_2,
   M.store,
   M.itemnr_long,
   M.item_nr,
   M.entrydate,
   M.warehousemil,
   M.orderarea,
   M.std,
   M.status_2,
   M.quantity,
   M.capacity), MISSING_ITEMS_2 AS (SELECT v.country_2,
   v.store,
   v.item_nr,
   v.itemnr_long,
   v.entrydate,
   v.warehousemil,
   v.orderarea,
   v.std,
   v.status_2,
   v.quantity,
   v.capacity,
   v.prev_day,
   SUM(S.sales_quantity) AS sales_quantity,
   SUM(F.forc_quantity) AS forc_quantity
  FROM LAST_OPEN_DAY AS v
   LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_order_2 AS FO ON v.country_2 = FO.country_2 AND v.item_nr = FO.ord_item_nr AND v
       .store = FO.ord_store_nr AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(FO.ord_time_id - 365.25 * 4712 - 2 AS INTEGER)
       DAY) = CAST(v.entrydate AS DATE) AND FO.ord_order_type = 'CALCULATION'
   LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_forecast_2 AS F ON v.country_2 = F.country_2 AND v.store = F.forc_store_nr AND v
         .item_nr = F.forc_item_nr AND F.forc_type = 1 AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(F.forc_time_id - 365.25 * 4712 - 2 AS INTEGER)
        DAY) >= DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND CAST(DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST((F.forc_time_id - 365.25 * 4712) - 2 AS INTEGER)
        DAY) AS DATETIME) BETWEEN CAST(DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(FO.ord_gen_time_id - 365.25 * 4712 - 2 AS INTEGER)
        DAY) AS DATETIME) AND v.entrydate AND F.deleted = 0
   LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_sales_2 AS S ON v.country_2 = S.country_2 AND v.item_nr = S.sales_item_nr AND v
        .store = S.sales_store_nr AND CAST(DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST((S.sales_time_id - 365.25 * 4712) - 2 AS INTEGER)
         DAY) AS DATETIME) BETWEEN CAST(DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(FO.ord_gen_time_id - 365.25 * 4712 - 2 AS INTEGER)
         DAY) AS DATETIME) AND v.entrydate AND F.forc_time_id = S.sales_time_id AND S.deleted = 0
  GROUP BY v.country_2,
   v.store,
   v.item_nr,
   v.itemnr_long,
   v.entrydate,
   v.warehousemil,
   v.orderarea,
   v.std,
   v.status_2,
   v.quantity,
   v.capacity,
   v.prev_day) (SELECT 1 AS anzahl,
   t6.country_2,
   t6.store,
   t6.prev_day,
   t6.item_nr,
   t6.itemdesc,
   t6.entrydate,
   t6.warehousemil,
   t6.orderarea,
   t6.std,
   t6.status_2,
   t6.quantity,
   t6.capacity,
   t6.ord_order_type,
   t6.ord_storecalculation_id,
   t6.store_wh,
   t6.store_address,
   t6.item_sub_group_nr,
   t6.item_family_group_nr,
   t6.item_family_group,
   t6.item_sub_group,
    CASE
    WHEN ARRAY_LENGTH(ARRAY(SELECT x FROM UNNEST([t6.std_err, t6.wh_err, t6.forc_err, t6.status_err]) AS x WHERE x IS NOT NULL)) > 1
    THEN 'Multiple reasons'
    WHEN t6.std_err IS NOT NULL
    THEN 'Store STD error'
    WHEN t6.wh_err IS NOT NULL
    THEN 'WH STD'
    WHEN t6.forc_err IS NOT NULL
    THEN 'Forecast error'
    WHEN t6.status_err IS NOT NULL
    THEN 'Inactive status_2'
    ELSE 'Other'
    END AS reason,
    CASE
    WHEN ARRAY_LENGTH(ARRAY(SELECT x FROM UNNEST([t6.std_err, t6.wh_err, t6.forc_err, t6.status_err]) AS x WHERE x IS NOT NULL)) > 1
    THEN 'Multiple reasons'
    WHEN ARRAY_LENGTH(ARRAY(SELECT x FROM UNNEST([t6.std_err, t6.wh_err, t6.forc_err, t6.status_err]) AS x WHERE x IS NOT NULL)) = 1
    THEN ARRAY_TO_STRING(ARRAY(SELECT x FROM UNNEST([t6.std_err, t6.wh_err, t6.forc_err, t6.status_err]) AS x WHERE x IS NOT NULL), ', ')
    ELSE 'Other'
    END AS sub_reason,
    CASE
    WHEN ARRAY_LENGTH(ARRAY(SELECT x FROM UNNEST([t6.std_err, t6.wh_err, t6.forc_err, t6.status_err]) AS x WHERE x IS NOT NULL)) > 1
    THEN ARRAY_TO_STRING(ARRAY(SELECT x FROM UNNEST([t6.std_err, t6.wh_err, t6.forc_err, t6.status_err]) AS x WHERE x IS NOT NULL), ', ')
    ELSE NULL
    END AS reasons
  FROM (SELECT m.country_2,
     m.store,
     m.item_nr,
     m.itemnr_long,
     m.entrydate,
     m.warehousemil,
     m.orderarea,
     m.std,
     m.status_2,
     m.quantity,
     m.capacity,
     m.prev_day,
     m.sales_quantity,
     m.forc_quantity,
     FO0.ord_order_type,
     FO0.ord_storecalculation_id,
     MIL.quantity AS prev_quantity,
     MIL.std AS prev_std,
     DS.store_wh,
     DS.store_address,
     DI.item_name AS itemdesc,
     DI.item_sub_group_nr,
     DI.item_family_group_nr,
     DI.item_family_group,
     DI.item_sub_group,
      CASE
      WHEN m.status_2 > 9
      THEN 'ADS'
      WHEN EX.ex_item_nr IS NOT NULL
      THEN 'Excluded'
      WHEN m.status_2 IN (5, 6)
      THEN 'New'
      WHEN m.status_2 = 7
      THEN 'Allocation'
      ELSE NULL
      END AS status_err,
      CASE
      WHEN m.quantity - m.std - (MIL.quantity - MIL.std) > m.capacity * 0.3
      THEN 'Store reporting'
      WHEN ABS(m.quantity - m.std) > m.capacity * 0.33
      THEN 'Store STD error'
      ELSE NULL
      END AS std_err,
      CASE
      WHEN FD.del_amount * FO0.ord_case_size < FO0.ord_pieces_quantity
      THEN 'Order modification'
      WHEN OPT.opt_type_name = 'Warehouse Stock' AND OPT.opt_after <> OPT.opt_before
      THEN 'WH STD'
      WHEN FS.stock_item_nr IS NOT NULL
      THEN 'limited WH STD'
      ELSE NULL
      END AS wh_err,
      CASE
      WHEN S0.sales_quantity > F0.forc_quantity AND (S0.sales_quantity - F0.forc_quantity) / CASE
          WHEN IFNULL(F0.forc_quantity, 0) = 0
          THEN CAST(- 1 AS BIGNUMERIC)
          ELSE F0.forc_quantity
          END > 0.2
      THEN 'Forecast error today'
      WHEN S0.sales_quantity > FMINUS.forc_quantity AND (S0.sales_quantity - FMINUS.forc_quantity) / CASE
          WHEN IFNULL(FMINUS.forc_quantity, 0) = 0
          THEN CAST(- 1 AS BIGNUMERIC)
          ELSE FMINUS.forc_quantity
          END > 0.2
      THEN 'Forecast error today'
      WHEN m.sales_quantity > m.forc_quantity AND (m.sales_quantity - m.forc_quantity) / CASE
          WHEN IFNULL(m.forc_quantity, 0) = 0
          THEN CAST(- 1 AS BIGNUMERIC)
          ELSE m.forc_quantity
          END > 0.2
      THEN 'Forecast error past'
      ELSE NULL
      END AS forc_err
    FROM MISSING_ITEMS_2 AS m
     LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_mil_2 AS MIL ON m.country_2 = MIL.country_2 AND m.store = MIL.store AND m.itemnr_long
         = MIL.itemnr_long AND m.prev_day = CAST(MIL.entrydate AS DATE)
     INNER JOIN ldl_autodispo_core.t_oracle_v_dim_item_2 AS DI ON m.item_nr = DI.item_nr AND m.country_2 = DI.country_2
     INNER JOIN ldl_autodispo_core.t_oracle_v_dim_store_2 AS DS ON m.store = DS.store_nr AND m.country_2 = DS.country_2 AND DS
       .deleted = 0
     LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_sales_2 AS S0 ON m.item_nr = S0.sales_item_nr AND m.store = S0.sales_store_nr
           AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(S0.sales_time_id - 365.25 * 4712 - 2 AS INTEGER)
          DAY) = CAST(m.entrydate AS DATE) AND m.country_2 = S0.country_2 AND S0.deleted = 0
     LEFT JOIN ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_order_2 AS FO0 ON m.item_nr = FO0.item_nr AND m.store = FO0.store
           AND FO0.date = CAST(m.entrydate AS DATE) AND FO0.ord_order_type = 'CALCULATION' AND m.country_2 = FO0.country_2
     LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_delivery_2 AS FD ON m.item_nr = FD.del_item_nr AND m.store = FD.del_store_nr
          AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(FD.del_time_id - 365.25 * 4712 - 2 AS INTEGER) DAY)
        = CAST(m.entrydate AS DATE) AND m.country_2 = FD.country_2
     LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_forecast_2 AS FMINUS ON m.store = FMINUS.forc_store_nr AND m.item_nr =
            FMINUS.forc_item_nr AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(FMINUS.forc_forc_time_id - 365.25 * 4712 - 2 AS INTEGER)
            DAY) = FO0.generation_date AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(FMINUS.forc_time_id - 365.25 * 4712 - 2 AS INTEGER)
           DAY) >= DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(FMINUS.forc_time_id - 365.25 * 4712 - 2 AS INTEGER)
          DAY) = CAST(m.entrydate AS DATE) AND m.country_2 = FMINUS.country_2 AND FMINUS.deleted = 0
     LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_forecast_2 AS F0 ON m.store = F0.forc_store_nr AND m.item_nr = F0.forc_item_nr
              AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(F0.forc_forc_time_id - 365.25 * 4712 - 2 AS INTEGER)
             DAY) >= DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(F0.forc_time_id - 365.25 * 4712 - 2 AS INTEGER)
            DAY) >= DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(F0.forc_forc_time_id - 365.25 * 4712 - 2 AS INTEGER)
           DAY) = CAST(m.entrydate AS DATE) AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(F0.forc_time_id - 365.25 * 4712 - 2 AS INTEGER)
          DAY) = CAST(m.entrydate AS DATE) AND m.country_2 = F0.country_2 AND F0.deleted = 0
     LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_optimization_2 AS OPT ON m.store = OPT.opt_store_nr AND m.item_nr = OPT.opt_item_nr
            AND DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(OPT.opt_time_id - 365.25 * 4712 - 2 AS INTEGER)
           DAY) = CAST(m.entrydate AS DATE) AND OPT.opt_order_type = 'CALCULATION' AND m.country_2 = OPT.country_2 AND
       OPT.deleted = 0
     LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_excluded_2 AS EX ON CAST(EX.ex_store_nr AS FLOAT64) = m.store AND m.item_nr
           = EX.ex_item_nr AND m.entrydate BETWEEN CAST(DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(CAST(EX.ex_from_time_id AS FLOAT64)
              - 365.25 * 4712 - 2 AS INTEGER) DAY) AS DATETIME) AND (CAST(DATE_ADD(CAST('0001-01-01' AS DATE),
            INTERVAL CAST(CAST(EX.ex_to_time_id AS FLOAT64) - 365.25 * 4712 - 2 AS INTEGER) DAY) AS DATETIME)) AND m
        .country_2 = EX.country_2 AND EX.deleted = 0
     LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_stock_2 AS FS ON DATE(DATE_ADD(CAST('0001-01-01' AS DATE), INTERVAL CAST(CAST(FS.stock_time_id AS FLOAT64)
               - 365.25 * 4712 - 2 AS INTEGER) DAY)) = FO0.generation_date AND m.item_nr = FS.stock_item_nr AND CAST(FS.stock_ware_id AS FLOAT64)
         = DS.store_wh AND m.country_2 = FS.country_2 AND FS.stock_quantity <= 0
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY m.country_2, m.item_nr, CAST(m.store AS STRING), m.entrydate ORDER BY FO0.ord_storecalculation_id
          IS NULL DESC, FO0.ord_storecalculation_id DESC)) = 1) AS t6);
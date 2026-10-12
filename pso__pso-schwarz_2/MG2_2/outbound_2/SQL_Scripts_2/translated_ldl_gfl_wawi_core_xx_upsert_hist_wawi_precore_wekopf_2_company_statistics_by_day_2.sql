 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , uom_cd, bus_dt, curr_cd, int_company_natural_key, int_company_key_type_cd, stat_type_cd, stat_qty, stat_dt, stat_cnt
 , stat_meas, stat_val, curr_stat_fg)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,


  /* seperator,
  gatetype,
  taskid,
  gingate,
  carrier,
  krednr,
  name,
  wh_nr,
  ctrcode,
  wedatum
  pal_dd_goods,
  pal_eu_goods,
  create_date,
  mod_date, */
  'WAWI' AS source_system,
  CAST(MAX(extraction_tmsp) AS DATE) AS extraction_dt,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(MAX(extraction_tmsp) AS TIMESTAMP) AS dwh_mapping_tmsp,
  '${SRC_INPUT_TABLE}' AS filename,
  CAST(NULL AS STRING) AS uom_cd,
  CAST(wedatum AS DATE) AS bus_dt,
  CAST(NULL AS STRING) AS curr_cd,
    ctrcode || '|' || CAST(CAST(wh_nr AS BIGNUMERIC) AS STRING) AS int_company_natural_key,
  'COMPANY' AS int_company_key_type_cd,
  CAST(138 AS STRING) AS stat_type_cd,
   SUM(pal_dd_goods) + SUM(pal_eu_goods) AS stat_qty,
  CAST(CURRENT_TIMESTAMP() AS DATE) AS stat_dt,
  NULL AS stat_cnt,
  NULL AS stat_meas,
  NULL AS stat_val,
   1 <> 0 AS curr_stat_fg
 FROM ((SELECT 1 AS seperator,
      ggt.c170_gatetype AS gatetype,
      gt.c173_view_taskid AS taskid,
      gt.c173_gingate AS gingate,
      TRIM(gt.c173_carrier) AS carrier,
      k.krednr,
      k.name1 AS name,
      wk.wh_nr,
      wk.ctrcode,
      wk.wedatum,
      MIN(gt.c173_pal_dd_goods) AS pal_dd_goods,
      MIN(gt.c173_pal_eu_goods) AS pal_eu_goods,
      MIN(gt.c173_create_date) AS create_date,
      MAX(gt.c173_mod_date) AS mod_date,
      MAX(wk.extraction_tmsp) AS extraction_tmsp
     FROM ldl_data_production_etl.t_wawi_precore_t170_gingatetypes_2 AS ggt
      INNER JOIN ldl_data_production_etl.t_wawi_precore_t171_gingates_2 AS gg ON ggt.c170_gatetypeid = gg.c171_gatetypeid
        AND ggt.ctrcode = gg.ctrcode AND ggt.wh_nr = gg.wh_nr
      INNER JOIN ldl_data_production_etl.t_wawi_precore_t173_gintasks_2 AS gt ON gg.c171_gingate = gt.c173_gingate AND ggt
         .ctrcode = gt.ctrcode AND ggt.wh_nr = gt.wh_nr
      INNER JOIN ldl_data_production_etl.t_wawi_precore_t174_gincount_2 AS gc ON gt.c173_taskid = gc.c174_taskid AND ggt.ctrcode
           = gc.ctrcode AND ggt.wh_nr = gc.wh_nr AND gc.c174_itemstatus = 99
      INNER JOIN ldl_data_production_etl.t_wawi_precore_kreditor_2 AS k ON k.krednr = '000' || SUBSTR(gc.c174_ponr, 1, 4)
       AND ggt.ctrcode = k.ctrcode
      INNER JOIN ldl_data_production_etl.t_wawi_precore_wekopf_2 AS wk ON gc.c174_rcvid = wk.id AND ggt.ctrcode = wk.ctrcode
           AND ggt.wh_nr = wk.wh_nr /* Temporarily filter for testing */ AND DATE(wk.wedatum) > DATE '2023-12-01'
     GROUP BY seperator,
      gatetype,
      taskid,
      gingate,
      carrier,
      k.krednr,
      name,
      wk.wh_nr,
      wk.ctrcode,
      wk.wedatum
     UNION DISTINCT
     SELECT 2 AS seperator,
      'O&G Lieferungen' AS gatetype,
      gt.c173_view_taskid AS taskid,
      gt.c173_gingate AS gingate,
      TRIM(gt.c173_carrier) AS carrier,
      k.krednr,
      k.name1 AS name,
      wk.wh_nr,
      wk.ctrcode,
      wk.wedatum,
      MIN(gt.c173_pal_dd_goods) AS pal_dd_goods,
      MIN(gt.c173_pal_eu_goods) AS pal_eu_goods,
      MIN(gt.c173_create_date) AS create_date,
      MAX(gt.c173_mod_date) AS mod_date,
      MAX(wk.extraction_tmsp) AS extraction_tmsp
     FROM ldl_data_production_etl.t_wawi_precore_t170_gingatetypes_2 AS ggt
      INNER JOIN ldl_data_production_etl.t_wawi_precore_t171_gingates_2 AS gg ON ggt.c170_gatetypeid = gg.c171_gatetypeid
        AND ggt.ctrcode = gg.ctrcode AND ggt.wh_nr = gg.wh_nr
      INNER JOIN ldl_data_production_etl.t_wawi_precore_t173_gintasks_2 AS gt ON gg.c171_gingate = gt.c173_gingate AND ggt
         .ctrcode = gt.ctrcode AND ggt.wh_nr = gt.wh_nr
      INNER JOIN ldl_data_production_etl.t_wawi_precore_t187_fv_orders_2 AS fv ON gt.c173_taskid = fv.c187_taskid AND ggt
          .ctrcode = fv.ctrcode AND ggt.wh_nr = fv.wh_nr AND fv.c187_row_status = 99
      INNER JOIN ldl_data_production_etl.t_wawi_precore_kreditor_2 AS k ON fv.c187_krednr = k.krednr AND ggt.ctrcode = k.ctrcode
        
      INNER JOIN ldl_data_production_etl.t_wawi_precore_wekopf_2 AS wk ON fv.c187_rcv_id = wk.id AND ggt.ctrcode = wk.ctrcode
           AND ggt.wh_nr = wk.wh_nr /* Temporarily filter for testing */ AND DATE(wk.wedatum) > DATE '2023-12-01'
     GROUP BY taskid,
      gingate,
      carrier,
      k.krednr,
      name,
      wk.wh_nr,
      wk.ctrcode,
      wk.wedatum)
    UNION DISTINCT
    SELECT 99 AS seperator,
     'Manuelle WE' AS gatetype,
     CAST(NULL AS INTEGER) AS taskid,
     CAST(NULL AS INTEGER) AS gingate,
     CAST(NULL AS STRING) AS carrier,
     k.krednr,
     k.name1 AS name,
     w.wh_nr,
     w.ctrcode,
     w.wedatum,
     SUM(CASE
       WHEN IFNULL(w.rcv_unit_type, 3) = 2
       THEN (w.mengekarton * IFNULL(w.decimalcase, CAST(SUBSTR(w.artikelnr, - 4) AS FLOAT64)) + w.mengestueck) / IFNULL(w
          .decimalcase, CAST(SUBSTR(w.artikelnr, - 4) AS FLOAT64)) / IFNULL(w.pallet_factor, CASE
          WHEN IFNULL(w.rcv_unit_type, 3) = 1
          THEN CAST(IFNULL(a.karton_lage, 1) AS BIGNUMERIC)
          WHEN IFNULL(w.rcv_unit_type, 3) = 2
          THEN IFNULL(a.karton_duess, a.karton_euro / 2)
          WHEN IFNULL(w.rcv_unit_type, 3) = 3
          THEN CAST(a.karton_euro AS BIGNUMERIC)
          ELSE 1
          END)
       ELSE 0
       END) AS pal_dd_goods,
     SUM(CASE
       WHEN IFNULL(w.rcv_unit_type, 3) = 3
       THEN (w.mengekarton * IFNULL(w.decimalcase, CAST(SUBSTR(w.artikelnr, - 4) AS FLOAT64)) + w.mengestueck) / IFNULL(w
          .decimalcase, CAST(SUBSTR(w.artikelnr, - 4) AS FLOAT64)) / IFNULL(w.pallet_factor, CASE
          WHEN IFNULL(w.rcv_unit_type, 3) = 1
          THEN CAST(IFNULL(a.karton_lage, 1) AS BIGNUMERIC)
          WHEN IFNULL(w.rcv_unit_type, 3) = 2
          THEN IFNULL(a.karton_duess, a.karton_euro / 2)
          WHEN IFNULL(w.rcv_unit_type, 3) = 3
          THEN CAST(a.karton_euro AS BIGNUMERIC)
          ELSE 1
          END)
       ELSE 0
       END) AS pal_eu_goods,
     CAST(NULL AS DATETIME) AS create_date,
     CAST(NULL AS DATETIME) AS mod_date,
     CURRENT_TIMESTAMP() AS extraction_tmsp
    FROM ldl_data_production_etl.v62_receivings_2 AS w
     INNER JOIN ldl_data_production_etl.t_wawi_precore_kreditor_2 AS k ON w.krednr = k.krednr AND w.ctrcode = k.ctrcode
     INNER JOIN ldl_data_production_etl.t_wawi_precore_artikel_2 AS a ON w.artikelnr = a.artikelnr
    WHERE w.id BETWEEN 783058 AND 783065
     AND k.krednr = w.krednr
     AND a.artikelnr = w.artikelnr
     AND IFNULL(w.decimalcase, CAST(SUBSTR(w.artikelnr, - 4) AS FLOAT64)) > 0
     AND IFNULL(w.pallet_factor, CASE
        WHEN IFNULL(w.rcv_unit_type, 3) = 1
        THEN CAST(IFNULL(a.karton_lage, 1) AS BIGNUMERIC)
        WHEN IFNULL(w.rcv_unit_type, 3) = 2
        THEN IFNULL(a.karton_duess, a.karton_euro / 2)
        WHEN IFNULL(w.rcv_unit_type, 3) = 3
        THEN CAST(a.karton_euro AS BIGNUMERIC)
        ELSE 1
        END) > 0
     AND w.weposart = 1
     AND (EXISTS (SELECT 1
        FROM ldl_data_production_etl.t_wawi_precore_t173_gintasks_2
         INNER JOIN ldl_data_production_etl.t_wawi_precore_t174_gincount_2 ON TRUE
        WHERE t_wawi_precore_t173_gintasks.c173_taskid = t_wawi_precore_t174_gincount.c174_taskid
         AND t_wawi_precore_t174_gincount.c174_rcvid = w.id
         AND t_wawi_precore_t173_gintasks.c173_gingate IS NULL
         AND t_wawi_precore_t173_gintasks.c173_task_type = 0) OR NOT EXISTS (SELECT 1
         FROM ldl_data_production_etl.t_wawi_precore_t174_gincount_2
         WHERE c174_rcvid = w.id) AND NOT EXISTS (SELECT 1
         FROM ldl_data_production_etl.t_wawi_precore_t187_fv_orders_2
         WHERE c187_rcv_id = w.id))
    GROUP BY k.krednr,
     name,
     w.wh_nr,
     w.ctrcode,
     w.wedatum,
     extraction_tmsp) AS t15
 GROUP BY int_company_natural_key,
  int_company_key_type_cd,
  stat_type_cd,
  stat_dt,
  bus_dt,
  curr_stat_fg,
  stat_val,
  curr_cd,
  stat_cnt,
  stat_meas,
  uom_cd,
  source_system,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd);
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  int_company_natural_key,
  int_company_key_type_cd,
  stat_type_cd,
  stat_dt,
  bus_dt,
  curr_stat_fg,
  stat_val,
  curr_cd,
  stat_cnt,
  stat_qty,
  stat_meas,
  uom_cd,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
WITH v62_receivings_1 AS (
  SELECT
    wk.id, /* ----------------------- */
    wk.wawi_instanz_kzl,
    wk.wh_nr,
    wp.artikelnr,
    wp.weposart,
    wp.posnr,
    wp.link_posnr,
    wp.mengekarton,
    wp.mengestueck,
    wp.decimalcase,
    wp.tgstatus,
    coalesce(wp.wekorrdatum, wp.wedatum) AS entrydate,
    wk.krednr,
    wk.lieferscheinnr,
    wk.issue_slip,
    wp.satas_entree,
    wk.po_nr,
    wk.status_1,
    wk.statussatz,
    wk.tgstatus AS tgstatus_0,
    weight_value,
    pricecond_value,
    wk.wedatum,
    wk.wareneingangszeit,
    wk.we_art,
    wp.adjust_stock,
    wp.anlieferungsartkzl,
    wp.bediener,
    wp.item_facility,
    wp.rcv_unit_type,
    wp.pallet_factor,
    wp.container_deposit,
    wp.datum,
    wk.delnotenorm,
    wp.dispolfdnrartikel,
    wp.ekpstueckdm,
    wp.ekpstueckekland,
    wp.ekpstueckland,
    wp.landkzl, /* WP.KREDNR, */
    wp.mindesthaltbarkeit,
    wp.mwstschl,
    wp.nr,
    wp.oldstatus,
    wp.ra_id,
    wp.ra_posnr,
    wp.rechposnr,
    wp.ret_vatmultiplier,
    wp.item_category,
    wp.status_1 AS status_0,
    wp.sumekpdm,
    wp.sumekpekland,
    wp.sumekpland,
    wp.sumvkpnorm,
    wp.teillieferung,
    wp.todo,
    wp.vkpnormstueck,
    wp.waehrungsknz_1,
    wp.wekorrdatum,
    wp.zollnr,
    wk.gesellschaftsnr,
    wk.lagerortnr,
    wp.includemargin,
    wp.matchable,
    wp.spcondnr,
    wp.change_id,
    wp.splitlinkposnr,
    wp.split_type,
    wp.valid_from,
    wp.valid_until,
    wp.mengekarton * wp.decimalcase + coalesce(wp.mengestueck, 0) AS totalqty,
    (
      wp.vkpnormstueck - wp.container_deposit - (
        wp.vkpnormstueck - wp.container_deposit
      ) / nullif(
        CASE
          WHEN wp.ret_vatmultiplier IS NULL
          THEN 1
          WHEN wp.ret_vatmultiplier = 0
          THEN 1
          ELSE wp.ret_vatmultiplier
        END,
        0
      )
    ) * (
      wp.mengekarton * wp.decimalcase + coalesce(wp.mengestueck, 0)
    ) AS sumret_vatvalue,
    wp.vkpnormstueck - wp.container_deposit - (
      wp.vkpnormstueck - wp.container_deposit
    ) / nullif(
      CASE
        WHEN wp.ret_vatmultiplier IS NULL
        THEN 1
        WHEN wp.ret_vatmultiplier = 0
        THEN 1
        ELSE wp.ret_vatmultiplier
      END,
      0
    ) AS ret_vatvalue,
    wp.container_deposit * (
      wp.mengekarton * wp.decimalcase + coalesce(wp.mengestueck, 0)
    ) AS sum_contdeposit,
    wp.vkpnormstueck - wp.container_deposit AS ret_cd,
    (
      wp.vkpnormstueck - wp.container_deposit
    ) * (
      wp.mengekarton * wp.decimalcase + coalesce(wp.mengestueck, 0)
    ) AS sumret_cd,
    (
      wp.vkpnormstueck - wp.container_deposit
    ) / nullif(
      CASE
        WHEN wp.ret_vatmultiplier IS NULL
        THEN 1
        WHEN wp.ret_vatmultiplier = 0
        THEN 1
        ELSE wp.ret_vatmultiplier
      END,
      0
    ) / nullif(bev_tax, 0) AS ret_vatcdbev,
    (
      wp.vkpnormstueck - wp.container_deposit
    ) / nullif(
      CASE
        WHEN wp.ret_vatmultiplier IS NULL
        THEN 1
        WHEN wp.ret_vatmultiplier = 0
        THEN 1
        ELSE wp.ret_vatmultiplier
      END,
      0
    ) / nullif(bev_tax, 0) * (
      wp.mengekarton * wp.decimalcase + coalesce(wp.mengestueck, 0)
    ) AS sumret_vatcdbev,
    (
      wp.vkpnormstueck - wp.container_deposit
    ) / nullif(
      CASE
        WHEN wp.ret_vatmultiplier IS NULL
        THEN 1
        WHEN wp.ret_vatmultiplier = 0
        THEN 1
        ELSE wp.ret_vatmultiplier
      END,
      0
    ) / nullif(bev_tax, 0) + wp.container_deposit AS ret_vatbevpcd,
    (
      (
        wp.vkpnormstueck - wp.container_deposit
      ) / nullif(
        CASE
          WHEN wp.ret_vatmultiplier IS NULL
          THEN 1
          WHEN wp.ret_vatmultiplier = 0
          THEN 1
          ELSE wp.ret_vatmultiplier
        END,
        0
      ) / nullif(bev_tax, 0) + wp.container_deposit
    ) * (
      wp.mengekarton * wp.decimalcase + coalesce(wp.mengestueck, 0)
    ) AS sumret_vatbevpcd,
    (
      wp.vkpnormstueck - wp.container_deposit
    ) / nullif(
      CASE
        WHEN wp.ret_vatmultiplier IS NULL
        THEN 1
        WHEN wp.ret_vatmultiplier = 0
        THEN 1
        ELSE wp.ret_vatmultiplier
      END,
      0
    ) AS ret_vatcd,
    (
      wp.vkpnormstueck - wp.container_deposit
    ) / nullif(
      CASE
        WHEN wp.ret_vatmultiplier IS NULL
        THEN 1
        WHEN wp.ret_vatmultiplier = 0
        THEN 1
        ELSE wp.ret_vatmultiplier
      END,
      0
    ) * (
      wp.mengekarton * wp.decimalcase + coalesce(wp.mengestueck, 0)
    ) AS sumret_vatcd,
    (
      wp.vkpnormstueck - wp.container_deposit
    ) / nullif(
      CASE
        WHEN wp.ret_vatmultiplier IS NULL
        THEN 1
        WHEN wp.ret_vatmultiplier = 0
        THEN 1
        ELSE wp.ret_vatmultiplier
      END,
      0
    ) - (
      wp.vkpnormstueck - wp.container_deposit
    ) / nullif(
      CASE
        WHEN wp.ret_vatmultiplier IS NULL
        THEN 1
        WHEN wp.ret_vatmultiplier = 0
        THEN 1
        ELSE wp.ret_vatmultiplier
      END,
      0
    ) / nullif(bev_tax, 0) AS bevtax,
    (
      (
        wp.vkpnormstueck - wp.container_deposit
      ) / nullif(
        CASE
          WHEN wp.ret_vatmultiplier IS NULL
          THEN 1
          WHEN wp.ret_vatmultiplier = 0
          THEN 1
          ELSE wp.ret_vatmultiplier
        END,
        0
      ) - (
        wp.vkpnormstueck - wp.container_deposit
      ) / nullif(
        CASE
          WHEN wp.ret_vatmultiplier IS NULL
          THEN 1
          WHEN wp.ret_vatmultiplier = 0
          THEN 1
          ELSE wp.ret_vatmultiplier
        END,
        0
      ) / nullif(bev_tax, 0)
    ) * (
      wp.mengekarton * wp.decimalcase + coalesce(wp.mengestueck, 0)
    ) AS sumbevtax,
    (
      (
        wp.vkpnormstueck - wp.container_deposit
      ) / nullif(
        CASE
          WHEN wp.ret_vatmultiplier IS NULL
          THEN 1
          WHEN wp.ret_vatmultiplier = 0
          THEN 1
          ELSE wp.ret_vatmultiplier
        END,
        0
      ) / nullif(bev_tax, 0) + wp.container_deposit
    ) * (
      wp.mengekarton * wp.decimalcase + coalesce(wp.mengestueck, 0)
    ) AS sumret_exclvat
  FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.wepos_1 AS wp
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.wekopf_1 AS wk
    ON wp.id = wk.id
    AND wp.gesellschaftsnr = wk.gesellschaftsnr
    AND wp.lagerortnr = wk.lagerortnr
  WHERE
    wp.delete_fg IS NULL AND wk.delete_fg IS NULL
)
SELECT
  CONCAT(
    left(subselect.wawi_instanz_kzl, 2),
    '|',
    substr(CAST(CAST(subselect.wh_nr AS NUMERIC) AS STRING), 1, 16777216)
  ) AS int_company_natural_key,
  'COMPANY' AS int_company_key_type_cd,
  CAST('138' AS NUMERIC) AS stat_type_cd,
  current_timestamp() AS stat_dt,
  subselect.wedatum AS bus_dt,
  1 AS curr_stat_fg,
  NULL AS stat_val,
  NULL AS curr_cd,
  NULL AS stat_cnt,
  sum(subselect.pal_dd_goods) + sum(subselect.pal_eu_goods) AS stat_qty,
  NULL AS stat_meas,
  NULL AS uom_cd,
  'WAWI' AS source_system, /*
        seperator,
        gatetype,
        taskid,
        gingate,
        carrier,
        krednr,
        name,
        wh_nr,
        wawi_instanz_kzl,
        wedatum
        pal_dd_goods,
        pal_eu_goods,
        create_date,
        mod_date,
      */ /* ------------------- */
  MAX(subselect.extraction_tmsp) AS extraction_dt,
  MAX(subselect.extraction_tmsp) AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    1 AS seperator,
    c170_gatetype AS gatetype,
    c173_view_taskid AS taskid,
    c173_gingate AS gingate,
    TRIM(c173_carrier, ' ') AS carrier,
    k.krednr AS krednr,
    k.name1 AS name,
    wk.wh_nr AS wh_nr,
    wk.wawi_instanz_kzl AS wawi_instanz_kzl,
    wk.wedatum AS wedatum,
    MIN(c173_pal_dd_goods) AS pal_dd_goods,
    MIN(c173_pal_eu_goods) AS pal_eu_goods,
    MIN(c173_create_date) AS create_date,
    MAX(c173_mod_date) AS mod_date,
    MAX(wk.extraction_tmsp) AS extraction_tmsp
  FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t170_gingatetypes_1 AS ggt
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t171_gingates_1 AS gg
    ON ggt.c170_gatetypeid = gg.c171_gatetypeid
    AND ggt.wawi_instanz_kzl = gg.wawi_instanz_kzl
    AND ggt.wh_nr = gg.wh_nr
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t173_gintasks_1 AS gt
    ON gg.c171_gingate = gt.c173_gingate
    AND ggt.wawi_instanz_kzl = gt.wawi_instanz_kzl
    AND ggt.wh_nr = gt.wh_nr
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t174_gincount_1 AS gc
    ON gc.c174_taskid = gt.c173_taskid
    AND ggt.wawi_instanz_kzl = gc.wawi_instanz_kzl
    AND ggt.wh_nr = gc.wh_nr
    AND gc.c174_itemstatus = CAST('99' AS NUMERIC)
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.kreditor_1 AS k
    ON k.krednr = CONCAT('000', substr(c174_ponr, 1, 4))
    AND ggt.wawi_instanz_kzl = k.wawi_instanz_kzl
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.wekopf_1 AS wk
    ON gc.c174_rcvid = wk.id
    AND ggt.wawi_instanz_kzl = wk.wawi_instanz_kzl
    AND ggt.wh_nr = wk.wh_nr
    AND /* Temporarily filter for testing */ CAST(wk.wedatum AS DATE) > CAST('2023-12-01' AS DATE)
  WHERE
    gg.delete_fg IS NULL
    AND ggt.delete_fg IS NULL
    AND gt.delete_fg IS NULL
    AND gc.delete_fg IS NULL
    AND k.delete_fg IS NULL
    AND wk.delete_fg IS NULL
  GROUP BY
    1,
    c170_gatetype,
    c173_view_taskid,
    c173_gingate,
    TRIM(c173_carrier, ' '),
    6,
    7,
    8,
    9,
    10
  UNION DISTINCT
  SELECT
    2 AS seperator,
    'O&G Lieferungen' AS gatetype,
    c173_view_taskid AS taskid,
    c173_gingate AS gingate,
    TRIM(c173_carrier, ' ') AS carrier,
    k.krednr AS krednr,
    k.name1 AS name,
    wk.wh_nr AS wh_nr,
    wk.wawi_instanz_kzl AS wawi_instanz_kzl,
    wk.wedatum AS wedatum,
    MIN(c173_pal_dd_goods) AS pal_dd_goods,
    MIN(c173_pal_eu_goods) AS pal_eu_goods,
    MIN(c173_create_date) AS create_date,
    MAX(c173_mod_date) AS mod_date,
    MAX(wk.extraction_tmsp) AS extraction_tmsp
  FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t170_gingatetypes_1 AS ggt
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t171_gingates_1 AS gg
    ON ggt.c170_gatetypeid = gg.c171_gatetypeid
    AND ggt.wawi_instanz_kzl = gg.wawi_instanz_kzl
    AND ggt.wh_nr = gg.wh_nr
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t173_gintasks_1 AS gt
    ON gg.c171_gingate = gt.c173_gingate
    AND ggt.wawi_instanz_kzl = gt.wawi_instanz_kzl
    AND ggt.wh_nr = gt.wh_nr
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t187_fv_orders_1 AS fv
    ON fv.c187_taskid = gt.c173_taskid
    AND ggt.wawi_instanz_kzl = fv.wawi_instanz_kzl
    AND ggt.wh_nr = fv.wh_nr
    AND fv.c187_row_status = CAST('99' AS NUMERIC)
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.kreditor_1 AS k
    ON fv.c187_krednr = k.krednr AND ggt.wawi_instanz_kzl = k.wawi_instanz_kzl
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.wekopf_1 AS wk
    ON fv.c187_rcv_id = wk.id
    AND ggt.wawi_instanz_kzl = wk.wawi_instanz_kzl
    AND ggt.wh_nr = wk.wh_nr
    AND /* Temporarily filter for testing */ CAST(wk.wedatum AS DATE) > CAST('2023-12-01' AS DATE)
  WHERE
    gg.delete_fg IS NULL
    AND ggt.delete_fg IS NULL
    AND gt.delete_fg IS NULL
    AND fv.delete_fg IS NULL
    AND k.delete_fg IS NULL
    AND wk.delete_fg IS NULL
  GROUP BY
    c173_view_taskid,
    c173_gingate,
    TRIM(c173_carrier, ' '),
    6,
    7,
    8,
    9,
    10
  UNION DISTINCT
  SELECT
    CAST('99' AS NUMERIC) AS seperator,
    'Manuelle WE' AS gatetype,
    NULL AS taskid,
    NULL AS gingate,
    NULL AS carrier,
    k.krednr AS krednr,
    k.name1 AS name,
    w.wh_nr AS wh_nr,
    w.wawi_instanz_kzl AS wawi_instanz_kzl,
    w.wedatum AS wedatum,
    sum(
      CASE coalesce(w.rcv_unit_type, 3)
        WHEN 2
        THEN (
          w.mengekarton * coalesce(w.decimalcase, CAST(substr(w.artikelnr, -4) AS FLOAT64)) + w.mengestueck
        ) / coalesce(w.decimalcase, CAST(substr(w.artikelnr, -4) AS FLOAT64)) / coalesce(
          w.pallet_factor,
          CASE coalesce(w.rcv_unit_type, 3)
            WHEN 1
            THEN coalesce(a.karton_lage, 1)
            WHEN 2
            THEN coalesce(a.karton_duess, a.karton_euro / 2)
            WHEN 3
            THEN a.karton_euro
            ELSE 1
          END
        )
        ELSE 0
      END
    ) AS pal_dd_goods,
    sum(
      CASE coalesce(w.rcv_unit_type, 3)
        WHEN 3
        THEN (
          w.mengekarton * coalesce(w.decimalcase, CAST(substr(w.artikelnr, -4) AS FLOAT64)) + w.mengestueck
        ) / coalesce(w.decimalcase, CAST(substr(w.artikelnr, -4) AS FLOAT64)) / coalesce(
          w.pallet_factor,
          CASE coalesce(w.rcv_unit_type, 3)
            WHEN 1
            THEN coalesce(a.karton_lage, 1)
            WHEN 2
            THEN coalesce(a.karton_duess, a.karton_euro / 2)
            WHEN 3
            THEN a.karton_euro
            ELSE 1
          END
        )
        ELSE 0
      END
    ) AS pal_eu_goods,
    NULL AS create_date,
    NULL AS mod_date,
    current_timestamp() AS extraction_tmsp
  FROM v62_receivings_1 AS w
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.kreditor_1 AS k
    ON w.krednr = k.krednr AND w.wawi_instanz_kzl = k.wawi_instanz_kzl
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_1 AS a
    ON w.artikelnr = a.artikelnr
  WHERE
    a.delete_fg IS NULL
    AND k.delete_fg IS NULL
    AND w.id BETWEEN CAST('783058' AS NUMERIC) AND CAST('783065' AS NUMERIC)
    AND k.krednr = w.krednr
    AND a.artikelnr = w.artikelnr
    AND coalesce(w.decimalcase, CAST(substr(w.artikelnr, -4) AS FLOAT64)) > 0
    AND coalesce(
      w.pallet_factor,
      CASE coalesce(w.rcv_unit_type, 3)
        WHEN 1
        THEN coalesce(a.karton_lage, 1)
        WHEN 2
        THEN coalesce(a.karton_duess, a.karton_euro / 2)
        WHEN 3
        THEN a.karton_euro
        ELSE 1
      END
    ) > 0
    AND w.weposart = 1
    AND (
      EXISTS(
        SELECT
          1
        FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t173_gintasks_1
        CROSS JOIN ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t174_gincount_1
        WHERE
          c173_taskid = c174_taskid
          AND c174_rcvid = w.id
          AND c173_gingate IS NULL
          AND c173_task_type = 0
      )
      OR NOT EXISTS(
        SELECT
          1
        FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t174_gincount_1
        WHERE
          c174_rcvid = w.id
      )
      AND NOT EXISTS(
        SELECT
          1
        FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t187_fv_orders_1
        WHERE
          c187_rcv_id = w.id
      )
    )
  GROUP BY
    6,
    7,
    8,
    9,
    10,
    15
) AS subselect
GROUP BY
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  11,
  12,
  13,
  16,
  17,
  18,
  19,
  20;
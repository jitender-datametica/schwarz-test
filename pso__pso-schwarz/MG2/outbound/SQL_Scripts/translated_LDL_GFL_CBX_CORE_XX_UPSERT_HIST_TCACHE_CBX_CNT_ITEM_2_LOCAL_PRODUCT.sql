-- WAWI_HQ country deduplication mapping table
CREATE TEMPORARY TABLE t_ctrcode_map_xx_load_id_zz
  AS
    SELECT
        subselect.int_org_ctr_cd AS ctrcode_tgt,
        subselect.party_nat_key_nr AS ctrcode_src,
        ROW_NUMBER() OVER (PARTITION BY subselect.party_sid ORDER BY IF(CASE
          WHEN subselect.party_nat_key_nr = subselect.int_org_ctr_cd THEN NUMERIC '0'
          ELSE NUMERIC '1'
        END IS NULL, 0, 1) DESC, CASE
          WHEN subselect.party_nat_key_nr = subselect.int_org_ctr_cd THEN NUMERIC '0'
          ELSE NUMERIC '1'
        END, IF(subselect.party_nat_key_nr IS NULL, 0, 1) DESC, subselect.party_nat_key_nr) AS ctrcode_rank
      FROM
        (
          SELECT DISTINCT
              pk.party_sid,
              pk.party_nat_key_nr,
              LEFT(io.int_org_nr, 2) AS int_org_ctr_cd
            FROM
              ldl_data_production.meta.t_party_key AS pk
              INNER JOIN ldl_data_production.core_rel.t_internal_organization AS io ON pk.party_sid = io.int_org_sid
               AND pk.dwh_valid_fg
               AND io.dwh_valid_fg
               AND pk.party_key_type_cd = 'COUNTRY'
        ) AS subselect
;

-- CBX product to (WAWI) local product
CREATE TEMPORARY TABLE t_cbx_prod_to_wawi_item
  AS
    SELECT
        p.prod_sid,
        p.prod_nr,
        iit.ctrcode,
        iit.itemnr
      FROM
        (
          SELECT
              t_product.prod_sid,
              t_product.prod_nr AS prod_nr
            FROM
              ldl_data_production.core_rel.t_product
            WHERE t_product.prod_sid IN(
              SELECT
                  t_product.prod_sid
                FROM
                  ldl_data_production.meta.t_product_key
                WHERE prod_key_type_cd IN(
                  'CBX'
                )
            )
             AND t_product.dwh_valid_fg
             AND t_product.prod_nr IS NOT NULL
        ) AS p
        INNER JOIN (
          SELECT
              iit_0.*
            FROM
              (
                SELECT
                    subselect.*
                  FROM
                    (
                      SELECT DISTINCT
                          t_wawi_precore_t215_int_itemnr.ctrcode,
                          ROUND(CAST(SUBSTR(t_wawi_precore_t215_int_itemnr.c215_itemnr, 1, CAST(LENGTH(t_wawi_precore_t215_int_itemnr.c215_itemnr) - NUMERIC '4' AS INT64)) AS BIGNUMERIC), 0) AS itemnr,
                          CAST(/* expression of unknown or erroneous type */ t_wawi_precore_t215_int_itemnr.c215_int_itemnr AS BIGNUMERIC) AS c215_int_itemnr
                        FROM
                          ldl_data_production.etl.t_wawi_precore_t215_int_itemnr
                    ) AS subselect
                  QUALIFY ROW_NUMBER() OVER (PARTITION BY subselect.ctrcode, subselect.c215_int_itemnr ORDER BY /* By NF/CBX product prefer the WAWI item with matching number */ IF(CASE
                    WHEN subselect.c215_int_itemnr = subselect.itemnr THEN NUMERIC '0'
                    ELSE NUMERIC '1'
                  END IS NULL, 0, 1) DESC, CASE
                    WHEN subselect.c215_int_itemnr = subselect.itemnr THEN NUMERIC '0'
                    ELSE NUMERIC '1'
                  END, IF(subselect.itemnr IS NULL, 0, 1) DESC, subselect.itemnr) = NUMERIC '1'
              ) AS iit_0
              INNER JOIN ldl_data_production.etl.t_ctrcode_map_xx_load_id_zz AS cm ON iit_0.ctrcode = cm.ctrcode_src
            QUALIFY ROW_NUMBER() OVER (PARTITION BY iit_0.c215_int_itemnr, cm.ctrcode_tgt ORDER BY IF(cm.ctrcode_rank IS NULL, 0, 1) DESC, cm.ctrcode_rank) = NUMERIC '1'
        ) AS iit ON p.prod_nr = iit.c215_int_itemnr
;

INSERT INTO xx_temp_db_zz.xx_src2tgt_temp_table1_zz_xx_src_context_area_zz (prod_nr, ctrcode, prod_key_type_cd, int_org_key_type_cd, add_nr_exist_fg, local_prod_nr, local_prod_name, local_prod_descr, local_prod_version_nr, local_prod_creation_dt, local_list_dt, local_delist_dt, locked_fg, brand_name, intrastat_nr, plu_nr, vat_refund_fg, dangerous_goods_fg, min_cust_age_meas, sort_seq, brand_type_cd, source_system, extraction_dt, dwh_mapping_tmsp, tf_error_fg, deleted_fg, record_id, filename, dwh_node_cd, dwh_load_id)
  SELECT DISTINCT
      -- Extraction/Filter Logic:
      src.prod_nr AS prod_nr,
      src.ctrcode AS ctrcode,
      'CBX' AS prod_key_type_cd,
      'COUNTRY' AS int_org_key_type_cd,
      FALSE AS add_nr_exist_fg,
      src.itemnr AS local_prod_nr,
      waw.bez_kurz AS local_prod_name,
      waw.bez_lang AS local_prod_descr,
      COALESCE(waw.itemversion, NUMERIC '0') AS local_prod_version_nr,
      waw.gueltig_ab AS local_prod_creation_dt,
      CASE
        WHEN waw.eingelist = TRUE THEN waw.eingel_datum
        ELSE NULL
      END AS local_list_dt,
      CASE
        WHEN waw.ausgelist = TRUE THEN waw.ausgel_datum
        ELSE NULL
      END AS local_delist_dt,
      lck.itemnr IS NOT NULL AS locked_fg,
      UPPER(waw.marke) AS brand_name,
      itmo.commoditycode AS intrastat_nr,
      waw.plu AS plu_nr,
      COALESCE(waw.refund, FALSE) AS vat_refund_fg,
      dg.itemnr IS NOT NULL AS dangerous_goods_fg,
      adsc.`desc` AS min_cust_age_meas,
      waw.ordersatznr AS sort_seq,
      waw.brand_type_cd,
      'CBX' AS source_system,
      CURRENT_DATE() AS extraction_dt,
      waw.extraction_tmsp AS dwh_mapping_tmsp,
      NUMERIC '0' AS tf_error_fg,
      NUMERIC '0' AS deleted_fg,
      NUMERIC '0' AS record_id,
      't_xx_SRC_INPUT_TABLE_zz' AS filename,
      'WAWI_HQ' AS dwh_node_cd,
      'xx_LOAD_ID_zz' AS dwh_load_id
    FROM
      ldl_data_production.etl.t_cbx_prod_to_wawi_item AS src
      INNER JOIN (
        SELECT
            CAST(artnrvier AS BIGNUMERIC) AS itemnr,
            a.*,
            CASE
              WHEN UPPER(brd.c270_listdescript) LIKE '% EM' THEN 'EM'
              WHEN UPPER(brd.c270_listdescript) LIKE '% M' THEN 'M'
              ELSE 'EM/M'
            END AS brand_type_cd
          FROM
            ldl_data_production.etl.t_wawi_precore_artikel AS a
            LEFT OUTER JOIN ldl_data_production.etl.t_wawi_precore_t270_listtype AS brd ON brd.ctrcode = a.ctrcode
             AND c270_listnr = listenknznr
          QUALIFY ROW_NUMBER() OVER (PARTITION BY a.ctrcode, artnrvier ORDER BY IF(artikelnr IS NULL, 0, 1) DESC, artikelnr) = NUMERIC '1'
      ) AS waw ON src.ctrcode = waw.ctrcode
       AND src.itemnr = waw.itemnr
      LEFT OUTER JOIN (
        SELECT
            t_wawi_precore_t119_status_locked.ctrcode,
            ROUND(CAST(SUBSTR(t_wawi_precore_t119_status_locked.itemno, 1, CAST(LENGTH(t_wawi_precore_t119_status_locked.itemno) - NUMERIC '4' AS INT64)) AS BIGNUMERIC), 0) AS itemnr
          FROM
            ldl_data_production.etl.t_wawi_precore_t119_status_locked
          GROUP BY 1, 2
          HAVING MIN(t_wawi_precore_t119_status_locked.locked) = NUMERIC '1'
      ) AS lck ON waw.ctrcode = lck.ctrcode
       AND waw.itemnr = lck.itemnr
      LEFT OUTER JOIN (
        SELECT
            ROUND(CAST(SUBSTR(a.artikelnr, 1, CAST(LENGTH(a.artikelnr) - NUMERIC '4' AS INT64)) AS BIGNUMERIC), 0) AS itemnr,
            a.*
          FROM
            ldl_data_production.etl.t_wawi_precore_artikelbestell AS a
          QUALIFY ROW_NUMBER() OVER (PARTITION BY a.ctrcode, itemnr ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr) = NUMERIC '1'
      ) AS itmo ON waw.ctrcode = itmo.ctrcode
       AND waw.itemnr = itmo.itemnr
      LEFT OUTER JOIN (
        SELECT
            ROUND(CAST(SUBSTR(a.itemno, 1, CAST(LENGTH(a.itemno) - NUMERIC '4' AS INT64)) AS BIGNUMERIC), 0) AS itemnr,
            a.*
          FROM
            ldl_data_production.etl.t_wawi_precore_t220_dangerous_goods AS a
          QUALIFY ROW_NUMBER() OVER (PARTITION BY a.ctrcode, itemnr ORDER BY IF(a.itemno IS NULL, 0, 1) DESC, a.itemno) = NUMERIC '1'
      ) AS dg ON waw.ctrcode = dg.ctrcode
       AND waw.itemnr = dg.itemnr
      LEFT OUTER JOIN (
        SELECT
            CAST(/* expression of unknown or erroneous type */ a.itemnrshort AS BIGNUMERIC) AS itma_itemnr,
            a.*
          FROM
            ldl_data_production.etl.t_wawi_precore_t214_itemaddinfo AS a
          QUALIFY ROW_NUMBER() OVER (PARTITION BY a.ctrcode, itma_itemnr ORDER BY IF(a.itemnr IS NULL, 0, 1) DESC, a.itemnr) = NUMERIC '1'
      ) AS itma ON waw.ctrcode = itma.ctrcode
       AND waw.itemnr = itma.itma_itemnr
      LEFT OUTER JOIN ldl_data_production.etl.t_wawi_precore_t007_descriptions AS adsc ON waw.ctrcode = adsc.ctrcode
       AND itma.ageflag = adsc.code
       AND adsc.type_ = 'AgeLimits'
;

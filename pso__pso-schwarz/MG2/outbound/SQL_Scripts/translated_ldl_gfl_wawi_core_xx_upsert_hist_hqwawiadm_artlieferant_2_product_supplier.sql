/* Standard processing as per mapping specifications:
*/

/*
0.2 init country table and deduplication mapping
*/
CREATE OR REPLACE TEMP TABLE t_wawi_instanz_kzl_map AS (
    SELECT
        int_org_ctr_cd AS wawi_instanz_kzl_tgt,
        party_nat_key_nr AS wawi_instanz_kzl_src,
        ROW_NUMBER() OVER (
            PARTITION BY party_sid
            ORDER BY CASE WHEN party_nat_key_nr = int_org_ctr_cd
                          THEN 0 ELSE 1 END,
                     party_nat_key_nr
        ) AS wawi_instanz_kzl_rank
    FROM (
        SELECT DISTINCT
            pk.party_sid,
            pk.party_nat_key_nr,
            LEFT(io.int_org_nr,2) AS int_org_ctr_cd
        FROM ldl_data_production_meta.t_party_key AS pk
        INNER JOIN ldl_data_production_core_rel.t_internal_organization AS io
            ON pk.party_sid = io.int_org_sid
           AND pk.dwh_valid_fg
           AND io.dwh_valid_fg
           AND pk.party_key_type_cd = 'COUNTRY'
    )
);

/*
0.3 CBX product to local items
*/
CREATE OR REPLACE TEMP TABLE t_cbx_prod_to_wawi_items AS (
    SELECT
        p.prod_sid,
        p.prod_nr,
        iit.wawi_instanz_kzl,
        iit.itemnr
    FROM (
        SELECT 
            prod_sid,
            SAFE_CAST(prod_nr AS INT64) AS prod_nr -- SAFE_CAST for BigQuery
        FROM ldl_data_production_core_rel.t_product
        WHERE prod_sid IN (
            SELECT prod_sid FROM ldl_data_production_meta.t_product_key
            WHERE prod_key_type_cd = 'CBX'
        )
        AND dwh_valid_fg
        AND SAFE_CAST(prod_nr AS INT64) IS NOT NULL
    ) AS p
    INNER JOIN (
        SELECT DISTINCT
            LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
            SAFE_CAST(SUBSTR(c215_itemnr,1,LENGTH(c215_itemnr)-4) AS INT64) AS itemnr,
            SAFE_CAST(c215_int_itemnr AS INT64) AS c215_int_itemnr
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr
    ) AS iit
        ON p.prod_nr = iit.c215_int_itemnr
);

/*
0.3 add FV product to local items
*/
CREATE OR REPLACE TEMP TABLE t_fv_prod_to_wawi_item AS (
    SELECT
        p.prod_sid,
        p.prod_nr,
        iit.wawi_instanz_kzl,
        iit.itemnr
    FROM (
        SELECT 
            prod_sid,
            SAFE_CAST(prod_nr AS INT64) AS prod_nr
        FROM ldl_data_production_core_rel.t_product
        WHERE prod_sid IN (
            SELECT prod_sid FROM ldl_data_production_meta.t_product_key
            WHERE prod_key_type_cd = 'FV'
        )
        AND dwh_valid_fg
        AND SAFE_CAST(prod_nr AS INT64) IS NOT NULL
    ) AS p
    INNER JOIN (
        SELECT DISTINCT
            LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
            SAFE_CAST(SUBSTR(c215_itemnr,1,LENGTH(c215_itemnr)-4) AS INT64) AS itemnr,
            SAFE_CAST(c215_int_itemnr AS INT64) AS c215_int_itemnr
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr
    ) AS iit
        ON p.prod_nr = iit.c215_int_itemnr
);

/*
0.4 add WaWi product to local items
*/
CREATE OR REPLACE TEMP TABLE t_wawi_prod_to_wawi_item AS (
    SELECT
        p.prod_sid,
        SPLIT(p.prod_nat_key_nr,'|')[OFFSET(0)] AS wawi_instanz_kzl,
        m.wawi_instanz_kzl_tgt,
        SAFE_CAST(SPLIT(p.prod_nat_key_nr,'|')[OFFSET(1)] AS INT64) AS itemnr
    FROM ldl_data_production_meta.t_product_key p
    LEFT JOIN t_wawi_instanz_kzl_map m
        ON SPLIT(p.prod_nat_key_nr,'|')[OFFSET(0)] = m.wawi_instanz_kzl_src
    WHERE p.prod_key_type_cd = 'WAWI'
      AND p.dwh_valid_fg = TRUE
);

INSERT INTO ldl_data_production_${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
        prod_sid,
        party_nat_key_nr,
        int_org_key_type_cd,
        sup_nat_key_nr,
        sup_key_type_cd,
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
SELECT --CBX
       src.prod_sid,
       src.wawi_instanz_kzl AS party_nat_key_nr,
       'COUNTRY' AS int_org_key_type_cd,
       src.wawi_instanz_kzl || '|' || ltrim(src.krednr,'0') AS sup_nat_key_nr,
       'SUPPLIER' AS sup_key_type_cd,
       'CBX' AS source_system,
       src.extraction_tmsp AS extraction_dt,
       src.extraction_tmsp AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       'artlieferant' AS filename,
       'CBX' AS dwh_node_cd,
       '${LOAD_ID}' AS dwh_load_id
FROM (
         SELECT
             l.prod_sid,
             c.wawi_instanz_kzl_tgt AS wawi_instanz_kzl,
             s.krednr,
             l.prod_nr,
             CONCAT(c.wawi_instanz_kzl_tgt,'|',CAST(s.krednr AS STRING)) AS party_nat_key_nr,
             s.extraction_tmsp
         FROM t_cbx_prod_to_wawi_items l
         LEFT JOIN t_wawi_instanz_kzl_map c
             ON l.wawi_instanz_kzl = c.wawi_instanz_kzl_src
         LEFT JOIN (
             SELECT
                 SAFE_CAST(SUBSTR(TRIM(artikelnr),1,LENGTH(TRIM(artikelnr))-4) AS STRING) AS artikelnr,
                 LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
                 ltrim(krednr,'0') AS krednr,
                 extraction_tmsp
             FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artlieferant
         ) s
             ON CAST(l.itemnr AS STRING) = s.artikelnr
            AND l.wawi_instanz_kzl = s.wawi_instanz_kzl
         WHERE s.krednr IS NOT NULL
           AND s.krednr <> ''
         QUALIFY ROW_NUMBER() OVER (
             PARTITION BY l.prod_sid,c.wawi_instanz_kzl_tgt
             ORDER BY s.krednr
         ) = 1
) src

UNION ALL --FV
SELECT 
       src.prod_sid,
       src.wawi_instanz_kzl AS party_nat_key_nr,
       'COUNTRY' AS int_org_key_type_cd,
       LEFT(src.wawi_instanz_kzl,2) || '|' || ltrim(src.krednr,'0') AS sup_nat_key_nr,
       'SUPPLIER' AS sup_key_type_cd,
       'FV' AS source_system,
       src.extraction_tmsp AS extraction_dt,
       src.extraction_tmsp AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       'wawi_precore_artlieferant_hq' AS filename,
       'FV' AS dwh_node_cd,
       '${LOAD_ID}' AS dwh_load_id
FROM (
         SELECT
             l.prod_sid,
             c.wawi_instanz_kzl_tgt AS wawi_instanz_kzl,
             s.krednr,
             l.prod_nr,
             CONCAT(c.wawi_instanz_kzl_tgt,'|',CAST(s.krednr AS STRING)) AS party_nat_key_nr,
             s.extraction_tmsp
         FROM t_fv_prod_to_wawi_item l
         LEFT JOIN t_wawi_instanz_kzl_map c
             ON l.wawi_instanz_kzl = c.wawi_instanz_kzl_src
         LEFT JOIN (
             SELECT
                 SAFE_CAST(SUBSTR(TRIM(artikelnr),1,LENGTH(TRIM(artikelnr))-4) AS STRING) AS artikelnr,
                 LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
                 ltrim(krednr,'0') AS krednr,
                 extraction_tmsp
             FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artlieferant
         ) s
             ON CAST(l.itemnr AS STRING) = s.artikelnr
            AND l.wawi_instanz_kzl = s.wawi_instanz_kzl
         WHERE s.krednr IS NOT NULL
           AND s.krednr <> ''
         QUALIFY ROW_NUMBER() OVER (
             PARTITION BY l.prod_sid,c.wawi_instanz_kzl_tgt
             ORDER BY s.krednr
         ) = 1
) src

UNION ALL --EKS
SELECT 
       src.prod_sid,
       src.wawi_instanz_kzl AS party_nat_key_nr,
       'COUNTRY' AS int_org_key_type_cd,
       src.wawi_instanz_kzl || '|' || ltrim(src.krednr,'0') AS sup_nat_key_nr,
       'SUPPLIER' AS sup_key_type_cd,
       'EKS' AS source_system,
       src.extraction_tmsp AS extraction_dt,
       src.extraction_tmsp AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       'wawi_precore_artlieferant_hq' AS filename,
       'EKS' AS dwh_node_cd,
       '${LOAD_ID}' AS dwh_load_id
FROM (
         SELECT
             pk.prod_sid,
             LEFT(c.wawi_instanz_kzl_tgt,2) AS wawi_instanz_kzl,
             s.krednr,
             CONCAT(c.wawi_instanz_kzl_tgt,'|',s.krednr) AS party_nat_key_nr,
             s.extraction_tmsp
         FROM ldl_data_production_etl.t_tcache_eks_item_wawi_item eks
         LEFT JOIN t_wawi_instanz_kzl_map c
             ON eks.wawi_instanz_kzl = c.wawi_instanz_kzl_src
         LEFT JOIN (
             SELECT
                 SAFE_CAST(SUBSTR(TRIM(artikelnr),1,LENGTH(TRIM(artikelnr))-4) AS STRING) AS artikelnr,
                 LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
                 ltrim(krednr,'0') AS krednr,
                 extraction_tmsp
             FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artlieferant
         ) s
             ON CAST(eks.itemno_wawi AS STRING) = s.artikelnr
            AND eks.wawi_instanz_kzl = s.wawi_instanz_kzl
         INNER JOIN ldl_data_production_meta.t_product_key pk
             ON CAST(pk.prod_nat_key_nr AS STRING) = CAST(eks.prod_num AS STRING)
            AND pk.prod_key_type_cd = 'EKS'
            AND pk.dwh_valid_fg
         WHERE eks.prod_num IS NOT NULL
           AND s.krednr IS NOT NULL
           AND s.krednr <> ''
         QUALIFY ROW_NUMBER() OVER (
             PARTITION BY c.wawi_instanz_kzl_tgt, eks.prod_num
             ORDER BY s.krednr
         ) = 1
) src

UNION ALL --WAWI
SELECT 
       src.prod_sid,
       src.wawi_instanz_kzl AS party_nat_key_nr,
       'COUNTRY' AS int_org_key_type_cd,
       src.wawi_instanz_kzl || '|' || ltrim(src.krednr,'0') AS sup_nat_key_nr,
       'SUPPLIER' AS sup_key_type_cd,
       'WAWI' AS source_system,
       src.extraction_tmsp AS extraction_dt,
       src.extraction_tmsp AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       'wawi_precore_artlieferant_hq' AS filename,
       'WAWI' AS dwh_node_cd,
       '${LOAD_ID}' AS dwh_load_id
FROM (
         SELECT
             w.prod_sid,
             c.wawi_instanz_kzl_tgt AS wawi_instanz_kzl,
             s.krednr,
             w.itemnr,
             CONCAT(c.wawi_instanz_kzl_tgt,'|',CAST(s.krednr AS STRING)) AS party_nat_key_nr,
             s.extraction_tmsp
         FROM t_wawi_prod_to_wawi_item w
         LEFT JOIN t_wawi_instanz_kzl_map c
             ON w.wawi_instanz_kzl = c.wawi_instanz_kzl_src
         LEFT JOIN (
             SELECT
                 SAFE_CAST(SUBSTR(TRIM(artikelnr),1,LENGTH(TRIM(artikelnr))-4) AS STRING) AS artikelnr,
                 LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
                 ltrim(krednr,'0') AS krednr,
                 extraction_tmsp
             FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artlieferant
         ) s
             ON CAST(w.itemnr AS STRING) = s.artikelnr
            AND w.wawi_instanz_kzl = s.wawi_instanz_kzl
         WHERE w.itemnr IS NOT NULL
           AND s.krednr IS NOT NULL
           AND s.krednr <> ''
         QUALIFY ROW_NUMBER() OVER (
             PARTITION BY s.artikelnr,c.wawi_instanz_kzl_tgt
             ORDER BY s.krednr
         ) = 1
) src
;

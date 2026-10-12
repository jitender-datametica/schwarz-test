/* Standard processing as per mapping specifications:
*/

-- WAWI_HQ country_2 deduplication mapping table (used by CBX, FV, EKS)
CREATE OR REPLACE TEMP TABLE t_wawi_instanz_kzl_map AS (
    SELECT
        int_org_ctr_cd AS wawi_instanz_kzl_tgt,
        party_nat_key_nr AS wawi_instanz_kzl_src,
        ROW_NUMBER() OVER (
            PARTITION BY party_sid
            ORDER BY CASE WHEN party_nat_key_nr = int_org_ctr_cd THEN 0 ELSE 1 END,
                     party_nat_key_nr
        ) AS wawi_instanz_kzl_rank
    FROM (
        SELECT DISTINCT
            pk.party_sid,
            pk.party_nat_key_nr,
            LEFT(io.int_org_nr, 2) AS int_org_ctr_cd
        FROM ldl_data_production_meta.t_party_key_2 AS pk
        JOIN ldl_data_production_core_rel.t_internal_organization_2 AS io
            ON pk.party_sid = io.int_org_sid
           AND pk.dwh_valid_fg
           AND io.dwh_valid_fg
           AND pk.party_key_type_cd = 'COUNTRY_2'
    )
);

-- CBX product to (WAWI) local items
CREATE OR REPLACE TEMP TABLE t_cbx_prod_to_wawi_items AS (
    SELECT
        p.prod_sid,
        p.prod_nr,
        iit.wawi_instanz_kzl,
        iit.itemnr
    FROM (
        SELECT 
            prod_sid,
            SAFE_CAST(prod_nr AS INT64) AS prod_nr
        FROM ldl_data_production_core_rel.t_product_2
        WHERE prod_sid IN (
            SELECT prod_sid FROM ldl_data_production_meta.t_product_key_2
            WHERE prod_key_type_cd = 'CBX'
        )
          AND dwh_valid_fg
          AND SAFE_CAST(prod_nr AS INT64) IS NOT NULL
    ) AS p
    JOIN (
        SELECT DISTINCT
            LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
            SAFE_CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr)-4) AS INT64) AS itemnr,
            SAFE_CAST(c215_int_itemnr AS INT64) AS c215_int_itemnr
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_2
        WHERE delete_fg IS NULL
    ) AS iit
      ON p.prod_nr = iit.c215_int_itemnr
);

-- FV product to (WAWI) local items
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
        FROM ldl_data_production_core_rel.t_product_2
        WHERE prod_sid IN (
            SELECT prod_sid FROM ldl_data_production_meta.t_product_key_2
            WHERE prod_key_type_cd = 'FV'
        )
          AND dwh_valid_fg
          AND SAFE_CAST(prod_nr AS INT64) IS NOT NULL
    ) AS p
    JOIN (
        SELECT DISTINCT
            LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
            SAFE_CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr)-4) AS INT64) AS itemnr,
            SAFE_CAST(c215_int_itemnr AS INT64) AS c215_int_itemnr
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_2
        WHERE delete_fg IS NULL
    ) AS iit
      ON p.prod_nr = iit.c215_int_itemnr
);

-- WAWI product to (WAWI) local product
CREATE OR REPLACE TEMP TABLE t_wawi_prod_to_wawi_item_2 AS (
    SELECT
        prod_sid,
        SPLIT(prod_nat_key_nr, '|')[OFFSET(0)] AS wawi_instanz_kzl,
        SAFE_CAST(SPLIT(prod_nat_key_nr, '|')[OFFSET(1)] AS INT64) AS itemnr
    FROM ldl_data_production_meta.t_product_key_2
    WHERE prod_key_type_cd = 'WAWI'
      AND dwh_valid_fg
);


INSERT INTO ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
    prod_sid,
    party_nat_key_nr,
    int_org_key_type_cd,
    list_type_cd,
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
WITH src_base AS (

    SELECT
        src.prod_sid,
        src.wawi_instanz_kzl,
        waw.listenknznr,
        waw.extraction_tmsp,
        ROW_NUMBER() OVER (
            PARTITION BY src.prod_sid, src.wawi_instanz_kzl
            ORDER BY waw.listenknznr
        ) AS rn
    FROM t_wawi_prod_to_wawi_item_2 AS src
    JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_2 AS waw
      ON src.wawi_instanz_kzl = LEFT(waw.wawi_instanz_kzl,2)
     AND src.itemnr = SAFE_CAST(waw.artnrvier AS INT64)
    WHERE waw.delete_fg IS NULL

), cbx_src AS (

    SELECT
        iit.prod_sid,
        iit.wawi_instanz_kzl,
        waw.listenknznr,
        waw.extraction_tmsp,
        ROW_NUMBER() OVER (
            PARTITION BY iit.wawi_instanz_kzl, iit.prod_sid
            ORDER BY waw.listenknznr
        ) AS rn
    FROM t_cbx_prod_to_wawi_items AS iit
    JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_2 AS waw
      ON iit.wawi_instanz_kzl = LEFT(waw.wawi_instanz_kzl,2)
     AND iit.itemnr = SAFE_CAST(waw.artnrvier AS INT64)
    WHERE waw.listenknznr IS NOT NULL
      AND waw.delete_fg IS NULL

), fv_src AS (

    SELECT
        iit.prod_sid,
        iit.wawi_instanz_kzl,
        waw.listenknznr,
        waw.extraction_tmsp,
        ROW_NUMBER() OVER (
            PARTITION BY iit.wawi_instanz_kzl, iit.prod_sid
            ORDER BY waw.listenknznr
        ) AS rn
    FROM t_fv_prod_to_wawi_item AS iit
    JOIN (
        SELECT
            SAFE_CAST(artnrvier AS INT64) AS itemnr,
            wawi_instanz_kzl,
            listenknznr,
            extraction_tmsp,
            ROW_NUMBER() OVER (
                PARTITION BY wawi_instanz_kzl, artnrvier
                ORDER BY listenknznr
            ) AS inner_rn
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_2
        WHERE listenknznr IS NOT NULL
          AND delete_fg IS NULL
    ) AS waw
      ON iit.wawi_instanz_kzl = LEFT(waw.wawi_instanz_kzl,2)
     AND iit.itemnr = waw.itemnr
    WHERE waw.inner_rn = 1

), eks_src AS (

    SELECT
        pk.prod_sid,
        pr.wawi_instanz_kzl,
        artkl.listenknznr,
        artkl.extraction_tmsp,
        ROW_NUMBER() OVER (
            PARTITION BY pr.wawi_instanz_kzl, pk.prod_sid
            ORDER BY artkl.listenknznr
        ) AS rn
    FROM (
        SELECT
            SAFE_CAST(artnrvier AS INT64) AS itemnr,
            wawi_instanz_kzl,
            listenknznr,
            extraction_tmsp
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_2
        WHERE listenknznr IS NOT NULL
          AND delete_fg IS NULL
    ) artkl
    JOIN ldl_data_production_etl.t_tcache_eks_item_wawi_item_2 pr
      ON pr.wawi_instanz_kzl = LEFT(artkl.wawi_instanz_kzl,2)
     AND pr.itemno_wawi = artkl.itemnr
    JOIN ldl_data_production_meta.t_product_key_2 pk
      ON CAST(pr.prod_num AS STRING) = pk.prod_nat_key_nr
     AND pk.prod_key_type_cd = 'EKS'
     AND pk.dwh_valid_fg

)

SELECT
    prod_sid,
    wawi_instanz_kzl AS party_nat_key_nr,
    'COUNTRY_2' AS int_org_key_type_cd,
    CASE
      WHEN listenknznr IN (1,2) THEN 1      --Normal Assortment
      WHEN listenknznr IN (5,6) THEN 3      --Test_2 Assortment
      WHEN listenknznr IN (7,8) THEN 2      --Promotion
      WHEN listenknznr IN (9,10) THEN 4     --New Listing
      WHEN listenknznr IN (11,12) THEN 5    -- Delisted
      ELSE 0
    END AS list_type_cd,
    'WAWI' AS source_system,
    extraction_tmsp AS extraction_dt,
    extraction_tmsp AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    '${SRC_INPUT_TABLE}' AS filename,
    'WAWI_HQ' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM (
    SELECT * FROM src_base WHERE rn = 1
    UNION ALL SELECT * FROM cbx_src WHERE rn = 1
    UNION ALL SELECT * FROM fv_src WHERE rn = 1
    UNION ALL SELECT * FROM eks_src WHERE rn = 1
)
WHERE listenknznr IS NOT NULL;

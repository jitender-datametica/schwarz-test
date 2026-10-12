-- Standard processing as per mapping specifications:

INSERT INTO ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
    prod_key_type_cd,      --NAT_KEY_TYPE
    prod_nr,               --NAT_KEY
    prod_grp_key_type_cd,  --NAT_KEY_TYPE
    prod_grp_type_cd,
    prod_grp_nr,           --NAT_KEY
    -- FRAMEWORK AND TECHNICAL COLUMNS
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
WITH t451 AS
(
    SELECT *
    FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t451_integra_masterdata_2 src
    WHERE delete_fg IS NULL
      AND CAST(src.c451_itemnr AS NUMERIC) NOT IN (
            SELECT CAST(itemno AS NUMERIC)
            FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_2
            WHERE delete_fg IS NULL
              AND NOT itemgrshortdesc BETWEEN 10 AND 13
      )
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY LEFT(src.wawi_instanz_kzl, 2),
                     src.c451_itemnr,
                     src.c451_subitemnr
        ORDER BY src.extraction_tmsp DESC
    ) = 1
),
t038 AS
(
    SELECT src.*
    FROM ldl_wawi_production.hqwawiadm.t038_itemfamily_2 src
    INNER JOIN (
        SELECT
            wawi_instanz_kzl,
            RANK() OVER (
                ORDER BY CASE
                    WHEN wawi_instanz_kzl = 'DE' THEN 1
                    WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR') THEN 2
                    WHEN wawi_instanz_kzl = 'GR' THEN 3
                    WHEN wawi_instanz_kzl IN ('BG', 'CY') THEN 4
                END,
                wawi_instanz_kzl
            ) AS eks_rank
        FROM (
            SELECT DISTINCT wawi_instanz_kzl
            FROM ldl_wawi_production.hqwawiadm.t038_itemfamily_2
            WHERE delete_fg IS NULL
        ) a
    ) csrc
        ON csrc.wawi_instanz_kzl = csrc.wawi_instanz_kzl
    WHERE delete_fg IS NULL
    QUALIFY csrc.eks_rank = MIN(csrc.eks_rank) OVER (
        PARTITION BY LEFT(src.wawi_instanz_kzl, 2),
                     src.c038_family_id
    --AND Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2), src.C038_FAMILY_ID 
    )
)
SELECT
    'FV'                    AS prod_key_type_cd,
    itemno                  AS prod_nr,
    'IFG'                   AS prod_grp_key_type_cd,
    'IFG'                   AS prod_grp_type_cd,
    sig_nr || '|' || ifg_nr AS prod_grp_nr,
    'WAWI_HQ'               AS source_system,
    extraction_tmsp         AS extraction_dt,
    extraction_tmsp         AS dwh_mapping_tmsp,
    0                       AS tf_error_fg,
    0                       AS deleted_fg,
    0                       AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'WAWI_HQ'               AS dwh_node_cd,
    '${LOAD_ID}'       AS dwh_load_id
FROM
(
    SELECT
        itemnr.itemnr AS itemno,
        CAST(COALESCE(eks.itemgrshortdesc, t038.c038_itemgrpnr) AS NUMERIC) AS sig_nr,
        CAST(COALESCE(eks.itemgroupid, t038.c038_family_code) AS NUMERIC) AS ifg_nr,
        COALESCE(eks.extraction_tmsp, waw.extraction_tmsp) AS extraction_tmsp
    FROM
    (
        SELECT CAST(c451_itemnr AS NUMERIC) AS itemnr
        FROM t451
        UNION ALL
        SELECT itemno
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_2
        WHERE itemgrshortdesc BETWEEN 10 AND 13
          AND delete_fg IS NULL
    ) itemnr
    -- LEFT OUTER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_2 AS eks
    LEFT OUTER JOIN (
        SELECT *
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_2
        WHERE delete_fg IS NULL
        QUALIFY ROW_NUMBER() OVER (
            PARTITION BY itemno
            ORDER BY seqid DESC
        ) = 1
    ) eks
        ON itemnr.itemnr = eks.itemno
    LEFT OUTER JOIN (
        SELECT
            a.*,
            CAST(artikelnr AS NUMERIC) AS itemnr
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_2 a
        WHERE delete_fg IS NULL
        QUALIFY ROW_NUMBER() OVER (
            PARTITION BY itemnr
            ORDER BY CASE
                WHEN wawi_instanz_kzl = 'DE' THEN 1
                WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR') THEN 2
                WHEN wawi_instanz_kzl = 'GR' THEN 3
                WHEN wawi_instanz_kzl IN ('BG', 'CY') THEN 4
            END,
            wawi_instanz_kzl,
            artikelnr
        ) = 1
    ) waw
        ON itemnr.itemnr = waw.itemnr
    LEFT OUTER JOIN (
        SELECT *
        FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t214_itemaddinfo_2
        WHERE delete_fg IS NULL
        QUALIFY ROW_NUMBER() OVER (
            PARTITION BY LEFT(wawi_instanz_kzl, 2),
                         c214_itemnr
            ORDER BY extraction_tmsp DESC
        ) = 1
    ) itma
        ON waw.wawi_instanz_kzl = itma.wawi_instanz_kzl
       AND waw.artikelnr = itma.c214_itemnr
    LEFT OUTER JOIN t038
        ON itma.wawi_instanz_kzl = t038.wawi_instanz_kzl
       AND itma.c214_family_id = t038.c038_family_id
    WHERE COALESCE(eks.itemgrshortdesc, t038.c038_itemgrpnr) IS NOT NULL
      AND COALESCE(eks.itemgroupid, t038.c038_family_code) IS NOT NULL
) src;

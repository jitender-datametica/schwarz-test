/*
 We need to store away logical deletes t- end date records.
 We cannot use the standard option as the end-dating only happens when one field is null, rather than the absence of the record from source
 So we create this extract TF table with an _DELETES prefix for that purpose, and then populate it towards the end of the script.
 We will then use those stored deletes in a post-process sql script to end date records).
*/


/*
CREATE OR REPLACE TRANSIENT TABLE LDL_DATA_PRODUCTION_$_1{TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_DELETE_KEYS 
(
	PROD_SID INTEGER  NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
	INT_ORG_SID INTEGER  NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.'
);
*/


/* Standard processing as per mapping specifications:
*/
-- WAWI_HQ country_1 deduplication mapping table (used by CBX, FV, EKS)

CREATE OR REPLACE TEMP TABLE etl.t_wawi_instanz_kzl_map_${load_id} AS (
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
        FROM ldl_data_production_meta.t_party_key_1 pk
        JOIN ldl_data_production_core_rel.t_internal_organization_1 io
            ON pk.party_sid = io.int_org_sid
           AND pk.dwh_valid_fg
           AND io.dwh_valid_fg
           AND pk.party_key_type_cd = 'COUNTRY_1'
    )
);

-- CBX product to (WAWI) local items
CREATE OR REPLACE TEMP TABLE etl.t_cbx_prod_to_wawi_items_${load_id} AS (
    SELECT
        p.prod_sid,
        p.prod_nr,
        iit.wawi_instanz_kzl,
        iit.itemnr
    FROM (
        SELECT 
            prod_sid,
            SAFE_CAST(prod_nr AS INT64) AS prod_nr
        FROM ldl_data_production_core_rel.t_product_1
        WHERE prod_sid IN (
            SELECT prod_sid FROM ldl_data_production_meta.t_product_key_1
            WHERE prod_key_type_cd = 'CBX'
        )
          AND dwh_valid_fg
          AND SAFE_CAST(prod_nr AS INT64) IS NOT NULL
    ) p
    JOIN (
        SELECT DISTINCT
            LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
            SAFE_CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr)-4) AS INT64) AS itemnr,
            SAFE_CAST(c215_int_itemnr AS INT64) AS c215_int_itemnr
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_1
        WHERE delete_fg IS NULL
    ) iit
      ON p.prod_nr = iit.c215_int_itemnr
);

-- FV product to (WAWI) local items
CREATE OR REPLACE TEMP TABLE etl.t_fv_prod_to_wawi_item_${load_id} AS (
    SELECT
        p.prod_sid,
        p.prod_nr,
        iit.wawi_instanz_kzl,
        iit.itemnr
    FROM (
        SELECT 
            prod_sid,
            SAFE_CAST(prod_nr AS INT64) AS prod_nr
        FROM ldl_data_production_core_rel.t_product_1
        WHERE prod_sid IN (
            SELECT prod_sid FROM ldl_data_production_meta.t_product_key_1
            WHERE prod_key_type_cd = 'FV'
        )
          AND dwh_valid_fg
          AND SAFE_CAST(prod_nr AS INT64) IS NOT NULL
    ) p
    JOIN (
        SELECT DISTINCT
            LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
            SAFE_CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr)-4) AS INT64) AS itemnr,
            SAFE_CAST(c215_int_itemnr AS INT64) AS c215_int_itemnr
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_1
        WHERE delete_fg IS NULL
    ) iit
      ON p.prod_nr = iit.c215_int_itemnr
);

--WAWI product to (WAWI) local product
CREATE OR REPLACE TEMP TABLE etl.t_wawi_prod_to_wawi_item_${load_id} AS (
    SELECT
        prod_sid,
        SPLIT(prod_nat_key_nr, '|')[OFFSET(0)] AS wawi_instanz_kzl,
        SAFE_CAST(SPLIT(prod_nat_key_nr, '|')[OFFSET(1)] AS INT64) AS itemnr
    FROM ldl_data_production_meta.t_product_key_1
    WHERE prod_key_type_cd = 'WAWI'
      AND dwh_valid_fg
);

-- Prepare source data for upsert transform

WITH cbx_variant AS (
  SELECT
      ar.artnrvier AS itemnr,
      ar.wawi_instanz_kzl,
      ab.dispogrupnr,
      ab.extraction_tmsp,
      ROW_NUMBER() OVER (
          PARTITION BY ar.artnrvier, ar.wawi_instanz_kzl
          ORDER BY ab.dispogrupnr
      ) AS rn
  FROM (
      SELECT DISTINCT dispogrupnr, wawi_instanz_kzl, artikelnr, extraction_tmsp
      FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikelbestell_1
      WHERE dispogrupnr IS NOT NULL
        AND delete_fg IS NULL
  ) ab
  JOIN (
      SELECT DISTINCT artnrvier, wawi_instanz_kzl, artikelnr
      FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table}
      WHERE delete_fg IS NULL
  ) ar
    ON ab.artikelnr = ar.artikelnr
   AND ab.wawi_instanz_kzl = ar.wawi_instanz_kzl
)
, cbx_best AS (
    SELECT itemnr, wawi_instanz_kzl, dispogrupnr, extraction_tmsp
    FROM cbx_variant
    WHERE rn = 1
)
, consolidated_src_sel AS (

    -- Source data for CBX the mapping
    SELECT
        'CBX' AS source_system,
        src.prod_sid,
        --  , src.prod_nr
        src.wawi_instanz_kzl,
        best.dispogrupnr,
        best.extraction_tmsp
    FROM etl.t_cbx_prod_to_wawi_items_${load_id} src
    JOIN cbx_best best
      ON src.wawi_instanz_kzl = best.wawi_instanz_kzl
     AND src.itemnr = best.itemnr

    UNION ALL

    -- Source data for the FV mapping
    SELECT
        'FV' AS source_system,
        iit.prod_sid,
        --   iit.prod_nr
        LEFT(iit.wawi_instanz_kzl,2) AS wawi_instanz_kzl,
        --  , iit.itemnr
        best.dispogrupnr,
        best.extraction_tmsp
    FROM etl.t_fv_prod_to_wawi_item_${load_id} iit
    JOIN cbx_best best
      ON iit.wawi_instanz_kzl = best.wawi_instanz_kzl
     AND iit.itemnr = best.itemnr

    UNION ALL

    -- Source data for the EKS mapping
    SELECT
        'EKS' AS source_system,
        pk.prod_sid,
        LEFT(ar.wawi_instanz_kzl,2) AS wawi_instanz_kzl,
        ab.dispogrupnr,
        ab.extraction_tmsp
    FROM (
        SELECT DISTINCT dispogrupnr, wawi_instanz_kzl, artikelnr, extraction_tmsp
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikelbestell_1
        WHERE dispogrupnr IS NOT NULL
          AND delete_fg IS NULL
    ) ab
    JOIN (
        SELECT DISTINCT artnrvier, wawi_instanz_kzl, artikelnr
        FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table}
        WHERE delete_fg IS NULL
    ) ar
      ON ab.artikelnr = ar.artikelnr
     AND ab.wawi_instanz_kzl = ar.wawi_instanz_kzl
    JOIN ldl_data_production_etl.t_tcache_eks_item_wawi_item_1 pr
      ON pr.wawi_instanz_kzl = ar.wawi_instanz_kzl
     AND pr.itemno_wawi = ar.artnrvier
    JOIN ldl_data_production_meta.t_product_key_1 pk
      ON CAST(pr.prod_num AS STRING) = pk.prod_nat_key_nr
     AND pk.prod_key_type_cd = 'EKS'
     AND pk.dwh_valid_fg

    UNION ALL

    -- Source data for the WAWI mapping
    SELECT
        'WAWI_HQ' AS source_system,
        src.prod_sid,
        LEFT(src.wawi_instanz_kzl,2) AS wawi_instanz_kzl,
        best.dispogrupnr,
        best.extraction_tmsp
    FROM etl.t_wawi_prod_to_wawi_item_${load_id} src
    JOIN cbx_best best
      ON src.wawi_instanz_kzl = best.wawi_instanz_kzl
     AND src.itemnr = best.itemnr
)

INSERT INTO ldl_data_production_$_1{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
    prod_sid,
    int_org_key_type_cd,
    int_org_nk,
    dispatch_grp_nr,
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
SELECT
    prod_sid,
    'COUNTRY_1' AS int_org_key_type_cd,
    wawi_instanz_kzl AS int_org_nk,
    dispogrupnr AS dispatch_grp_nr,
    source_system,
    CURRENT_DATE() AS extraction_dt,
    COALESCE(extraction_tmsp, CURRENT_TIMESTAMP()) AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    'WH.WAWIADM.ARTIKEL_1' AS filename,
    'WAWI_HQ' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM consolidated_src_sel
WHERE dispogrupnr IS NOT NULL;



-- DELETES (END DATES)

/* PK 17.04.2025 NOT USED and dispogrupnr is not NULL should not be there

INSERT INTO  LDL_DATA_PRODUCTION_$_1{TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_DELETE_KEYS 
(
    PROD_SID,
    INT_ORG_SID
)

----------------------------------------------------------------

-- Prepare source data for upsert transform

with consolidated_src_sel as (


-- Source data for CBX the mapping
SELECT
    'CBX' as source_system
    ,src.prod_sid
--  , src.prod_nr
  , LEFT(src.wawi_instanz_kzl,2) AS wawi_instanz_kzl
  , waw.dispogrupnr
  , waw.extraction_tmsp
FROM LDL_DATA_PRODUCTION_ETL.t_cbx_prod_to_wawi_items_${LOAD_ID} AS src
        INNER JOIN
        (SELECT Cast(ar.artnrvier AS Number) as itemnr, ar.wawi_instanz_kzl, ab.dispogrupnr, ab.extraction_tmsp
        FROM  (select distinct dispogrupnr, wawi_instanz_kzl, artikelnr, extraction_tmsp FROM ${ldl_wawi_common_snflk_cl_db_name}.HQWAWIADM.ARTIKELBESTELL_1  WHERE dispogrupnr is not NULL AND delete_fg IS NULL) ab
        JOIN (select distinct artnrvier, wawi_instanz_kzl, artikelnr FROM              (SELECT 
              src.* 
             FROM ${ldl_wawi_common_snflk_cl_db_name}.${SRC_INPUT_TABLE} src
             JOIN LDL_DATA_PRODUCTION_etl_process.t_wawi_extract_control_1 co 
                ON co.schema_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[0]) AND co.table_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[1]) 
             JOIN LDL_DATA_PRODUCTION_etl_process.t_wawi_extract_control_status_1 st 
                ON st.schema_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[0]) AND st.table_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[1])
                 AND src.wawi_instanz_kzl=st.wawi_instanz_kzl AND 0 = st.wh_nr and src.scn>=IFF(co.delta_fg,st.last_scn,0)
             WHERE delete_fg IS NULL        
            )  waw) ar
        ON ab.artikelnr = ar.artikelnr
        AND ab.wawi_instanz_kzl = ar.wawi_instanz_kzl
        QUALIFY ROW_NUMBER() OVER (PARTITION BY ar.artnrvier, ar.wawi_instanz_kzl ORDER BY ab.dispogrupnr)  = 1) waw
        ON  src.wawi_instanz_kzl = waw.wawi_instanz_kzl
        AND src.itemnr = waw.itemnr
        INNER JOIN LDL_DATA_PRODUCTION_ETL.t_wawi_instanz_kzl_map_${LOAD_ID} AS cm
        ON  LEFT(waw.wawi_instanz_kzl,2) = cm.wawi_instanz_kzl_src
        QUALIFY Row_Number() OVER (PARTITION BY cm.wawi_instanz_kzl_tgt, src.prod_nr ORDER BY waw.dispogrupnr) = 1
        
        UNION
        
-- Source data for the FV mapping
SELECT
        'FV' as source_system
        ,  iit.prod_sid 
        --   iit.prod_nr
        , LEFT(iit.wawi_instanz_kzl,2) AS wawi_instanz_kzl
        --  , iit.itemnr
        , waw.dispogrupnr
        , waw.extraction_tmsp
FROM LDL_DATA_PRODUCTION_ETL.t_fv_prod_to_wawi_item_${LOAD_ID} AS iit
        INNER JOIN
        (SELECT ar.artnrvier as itemnr, ar.wawi_instanz_kzl, ab.dispogrupnr, ab.extraction_tmsp
        FROM  (select distinct dispogrupnr, wawi_instanz_kzl, artikelnr, extraction_tmsp FROM ${ldl_wawi_common_snflk_cl_db_name}.HQWAWIADM.ARTIKELBESTELL_1  WHERE delete_fg IS NULL ) ab
        JOIN (select distinct artnrvier, wawi_instanz_kzl, artikelnr FROM              (SELECT 
              src.* 
             FROM ${ldl_wawi_common_snflk_cl_db_name}.${SRC_INPUT_TABLE} src
             JOIN LDL_DATA_PRODUCTION_etl_process.t_wawi_extract_control_1 co 
                ON co.schema_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[0]) AND co.table_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[1]) 
             JOIN LDL_DATA_PRODUCTION_etl_process.t_wawi_extract_control_status_1 st 
                ON st.schema_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[0]) AND st.table_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[1])
                 AND src.wawi_instanz_kzl=st.wawi_instanz_kzl AND 0 = st.wh_nr and src.scn>=IFF(co.delta_fg,st.last_scn,0)
             WHERE delete_fg IS NULL        
            )  waw) ar
        ON ab.artikelnr = ar.artikelnr
        AND ab.wawi_instanz_kzl = ar.wawi_instanz_kzl
        QUALIFY ROW_NUMBER() OVER (PARTITION BY ar.artnrvier, ar.wawi_instanz_kzl ORDER BY ab.dispogrupnr)  = 1) waw
        ON  iit.wawi_instanz_kzl = waw.wawi_instanz_kzl
        AND iit.itemnr = waw.itemnr
        INNER JOIN LDL_DATA_PRODUCTION_ETL.t_wawi_instanz_kzl_map_${LOAD_ID} AS cm
        ON  LEFT(waw.wawi_instanz_kzl,2) = cm.wawi_instanz_kzl_src
        QUALIFY Row_Number() OVER (PARTITION BY cm.wawi_instanz_kzl_tgt, iit.prod_nr ORDER BY waw.dispogrupnr) = 1
        
        UNION
        
-- Source data for the EKS mapping
        SELECT
        'EKS' as source_system
        ,pk.prod_sid
        ,LEFT(pr.wawi_instanz_kzl,2) AS wawi_instanz_kzl
        ,artkl.dispogrupnr
        ,artkl.extraction_tmsp
FROM
        (SELECT ar.artnrvier, ar.wawi_instanz_kzl, ab.dispogrupnr, ab.extraction_tmsp 
        FROM  (select distinct dispogrupnr, wawi_instanz_kzl, artikelnr, extraction_tmsp FROM ${ldl_wawi_common_snflk_cl_db_name}.HQWAWIADM.ARTIKELBESTELL_1  WHERE dispogrupnr is not NULL AND delete_fg IS NULL ) ab
        JOIN (select distinct artnrvier, wawi_instanz_kzl, artikelnr FROM              (SELECT 
              src.* 
             FROM ${ldl_wawi_common_snflk_cl_db_name}.${SRC_INPUT_TABLE} src
             JOIN LDL_DATA_PRODUCTION_etl_process.t_wawi_extract_control_1 co 
                ON co.schema_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[0]) AND co.table_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[1]) 
             JOIN LDL_DATA_PRODUCTION_etl_process.t_wawi_extract_control_status_1 st 
                ON st.schema_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[0]) AND st.table_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[1])
                 AND src.wawi_instanz_kzl=st.wawi_instanz_kzl AND 0 = st.wh_nr and src.scn>=IFF(co.delta_fg,st.last_scn,0)
             WHERE delete_fg IS NULL        
            )  waw) ar
        ON ab.artikelnr = ar.artikelnr
        AND ab.wawi_instanz_kzl = ar.wawi_instanz_kzl
        QUALIFY ROW_NUMBER() OVER (PARTITION BY ar.artnrvier, ar.wawi_instanz_kzl ORDER BY ab.dispogrupnr)  = 1) artkl
        JOIN LDL_DATA_PRODUCTION_ETL.t_tcache_eks_item_wawi_item_1 pr 
        on pr.wawi_instanz_kzl=artkl.wawi_instanz_kzl
        AND pr.ITEMNO_WAWI = artkl.artnrvier
        INNER JOIN LDL_DATA_PRODUCTION_META.t_product_key_1 AS pk
        ON  Cast(pr.prod_num AS String) = pk.prod_nat_key_nr
        AND pk.prod_key_type_cd = 'EKS' AND pk.dwh_valid_fg
        INNER JOIN LDL_DATA_PRODUCTION_ETL.t_wawi_instanz_kzl_map_${LOAD_ID} AS cm
        ON  LEFT(artkl.wawi_instanz_kzl,2) = cm.wawi_instanz_kzl_src
        QUALIFY Row_Number() OVER (PARTITION BY cm.wawi_instanz_kzl_tgt, pr.prod_num ORDER BY artkl.dispogrupnr) = 1

        UNION
 
-- Source data for the WAWI mapping
	SELECT
            'WAWI_HQ' AS SOURCE_SYSTEM
	  , SRC.PROD_SID
	  , LEFT(SRC.wawi_instanz_kzl,2) AS wawi_instanz_kzl
	  , WAW.DISPOGRUPNR
	  , WAW.EXTRACTION_TMSP
	FROM LDL_DATA_PRODUCTION_ETL.T_WAWI_PROD_TO_WAWI_ITEM_${LOAD_ID} AS SRC
	INNER JOIN
		(SELECT CAST(AR.ARTNRVIER AS NUMBER) AS ITEMNR, AR.wawi_instanz_kzl, AB.DISPOGRUPNR, AB.EXTRACTION_TMSP
	FROM  (SELECT DISTINCT DISPOGRUPNR, wawi_instanz_kzl, ARTIKELNR, EXTRACTION_TMSP  FROM ${ldl_wawi_common_snflk_cl_db_name}.HQWAWIADM.ARTIKELBESTELL_1 WHERE DISPOGRUPNR IS NOT NULL AND delete_fg IS NULL) AB
	JOIN (SELECT DISTINCT ARTNRVIER, wawi_instanz_kzl, ARTIKELNR FROM              (SELECT 
              src.* 
             FROM ${ldl_wawi_common_snflk_cl_db_name}.${SRC_INPUT_TABLE} src
             JOIN LDL_DATA_PRODUCTION_etl_process.t_wawi_extract_control_1 co 
                ON co.schema_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[0]) AND co.table_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[1]) 
             JOIN LDL_DATA_PRODUCTION_etl_process.t_wawi_extract_control_status_1 st 
                ON st.schema_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[0]) AND st.table_name=UPPER(SPLIT('${SRC_INPUT_TABLE}','.')[1])
                 AND src.wawi_instanz_kzl=st.wawi_instanz_kzl AND 0 = st.wh_nr and src.scn>=IFF(co.delta_fg,st.last_scn,0)
             WHERE delete_fg IS NULL        
            )  waw) AR
	ON AB.ARTIKELNR = AR.ARTIKELNR
	AND AB.wawi_instanz_kzl = AR.wawi_instanz_kzl
	QUALIFY ROW_NUMBER() OVER (PARTITION BY AR.ARTNRVIER, AR.wawi_instanz_kzl ORDER BY AB.DISPOGRUPNR)  = 1) WAW
	ON  SRC.wawi_instanz_kzl = WAW.wawi_instanz_kzl
	AND SRC.ITEMNR = WAW.ITEMNR
	INNER JOIN LDL_DATA_PRODUCTION_ETL.t_wawi_instanz_kzl_map_${LOAD_ID} AS CM
	ON  LEFT(WAW.wawi_instanz_kzl,2) = CM.wawi_instanz_kzl_SRC
	QUALIFY ROW_NUMBER() OVER (PARTITION BY SRC.PROD_SID, CM.wawi_instanz_kzl_TGT
							   ORDER BY CASE WHEN WAW.DISPOGRUPNR IS NOT NULL THEN 0 ELSE 1 END
									  , CM.wawi_instanz_kzl_RANK
									  , WAW.ITEMNR) = 1
        )
SELECT
    PROD_SID AS PROD_SID,
    INT_ORG_SID.PARTY_SID AS INT_ORG_SID
FROM CONSOLIDATED_SRC_SEL
LEFT OUTER JOIN LDL_DATA_PRODUCTION_META.T_PARTY_KEY_1 INT_ORG_SID 
ON INT_ORG_SID.DWH_VALID_FG = TRUE
AND UPPER(INT_ORG_SID.PARTY_KEY_TYPE_CD) = 'COUNTRY_1'
AND UPPER(INT_ORG_SID.PARTY_NAT_KEY_NR) = UPPER(wawi_instanz_kzl)
WHERE DISPOGRUPNR IS NULL --    <-- will be end-dated in post process
;		

*/
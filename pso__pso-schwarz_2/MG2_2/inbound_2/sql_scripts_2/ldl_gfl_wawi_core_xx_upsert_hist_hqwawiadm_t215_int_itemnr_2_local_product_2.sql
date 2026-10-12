-- WAWI_HQ country_2 deduplication mapping table
CREATE TEMPORARY TABLE ETL.t_wawi_instanz_kzl_map AS (
    SELECT
        int_org_ctr_cd AS wawi_instanz_kzl_tgt
      , party_nat_key_nr AS wawi_instanz_kzl_src
      , Row_Number() OVER (PARTITION BY party_sid
                          ORDER BY CASE WHEN party_nat_key_nr = int_org_ctr_cd
                                            THEN 0 ELSE 1
                                    END, party_nat_key_nr
                          ) AS wawi_instanz_kzl_rank
    FROM
    (
        SELECT DISTINCT
            pk.party_sid
          , pk.party_nat_key_nr
          , Left(io.int_org_nr, 2) as int_org_ctr_cd
        FROM meta.t_party_key_2 AS pk
        INNER JOIN core_rel.t_internal_organization_2 AS io
        ON  pk.party_sid = io.int_org_sid
        AND pk.dwh_valid_fg
        AND io.dwh_valid_fg
        AND pk.party_key_type_cd = 'COUNTRY_2'
    )
);

--EKS product to (WAWI) local product
CREATE TEMPORARY TABLE ETL.t_eks_prod_to_wawi_item AS (
    SELECT eks.*
    FROM
    (
        SELECT
            prod_num
          , wawi_instanz_kzl
          , itemno_wawi
        FROM etl.t_tcache_eks_item_wawi_item_2
        QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, prod_num
                                   ORDER BY
                                       /* Use product (BA) link first if exists */
                                       CASE WHEN prod_num = itemno THEN 0 ELSE 1 END
                                     , itemno_wawi) = 1
    ) AS eks
    INNER JOIN ETL.t_wawi_instanz_kzl_map AS cm
    ON  eks.wawi_instanz_kzl = cm.wawi_instanz_kzl_src
    QUALIFY Row_Number() OVER (PARTITION BY eks.prod_num, cm.wawi_instanz_kzl_tgt ORDER BY wawi_instanz_kzl_rank) = 1
)
;

--Extraction/Filter Logic:
INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_KEY_TYPE_CD,
        PROD_NR,
        INT_ORG_KEY_TYPE_CD,
        ctrcode,
        LOCAL_PROD_NR,
        ADD_NR_EXIST_FG,
        LOCAL_PROD_NAME,
        LOCAL_PROD_DESCR,
        LOCAL_PROD_VERSION_NR,
        LOCAL_PROD_CREATION_DT,
        LOCAL_LIST_DT,
        LOCAL_DELIST_DT,
        LOCKED_FG,
        BRAND_NAME,
        INTRASTAT_NR,
        PLU_NR,
        VAT_REFUND_FG,
        DANGEROUS_GOODS_FG,
        MIN_CUST_AGE_MEAS,
        SORT_SEQ,
        BRAND_TYPE_CD,
    -- FRAMEWORK AND TECHNICAL COLUMNS
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
)
SELECT
        'EKS' AS PROD_KEY_TYPE_CD,
        src.prod_num AS PROD_NR,
        'COUNTRY_2' AS INT_ORG_KEY_TYPE_CD,
        src.wawi_instanz_kzl AS ctrcode,
        waw.artnrvier AS LOCAL_PROD_NR,
        src.add_nr_exist_fg AS ADD_NR_EXIST_FG,
        waw.bez_kurz AS LOCAL_PROD_NAME,
        waw.bez_lang AS LOCAL_PROD_DESCR,
        COALESCE(waw.itemversion, 0) AS LOCAL_PROD_VERSION_NR,
        waw.gueltig_ab AS LOCAL_PROD_CREATION_DT,
        CASE WHEN waw.eingelist = TRUE THEN waw.eingel_datum ELSE NULL END AS LOCAL_LIST_DT,
        CASE WHEN waw.ausgelist = TRUE THEN waw.ausgel_datum ELSE NULL END AS LOCAL_DELIST_DT,
        (lck.itemnr IS NOT NULL) AS LOCKED_FG, --lck.locked_fg
        UPPER(waw.marke) AS BRAND_NAME,
        itmo.commoditycode AS INTRASTAT_NR,
        waw.plu AS PLU_NR,
        COALESCE(waw.refund, FALSE) AS VAT_REFUND_FG,
        (dg.itemnr IS NOT NULL) AS DANGEROUS_GOODS_FG, --dg.dang_fg
        TRY_CAST(adsc.c007_desc AS NUMBER) AS MIN_CUST_AGE_MEAS,
        waw.ordersatznr AS SORT_SEQ,
        case when c270_listdescript ilike '% EM' then 'EM'
        when c270_listdescript ilike '% M' then 'M'
        else 'EM/M' end BRAND_TYPE_CD,
    -- FRAMEWORK AND TECHNICAL COLUMNS
        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        waw.extraction_tmsp AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        '${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_HQ' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID
FROM
(
    SELECT
        wawi_instanz_kzl
      , prod_num
      , itemno_wawi
      , (Count(*) OVER (PARTITION BY wawi_instanz_kzl, prod_num) > 1) AS add_nr_exist_fg
    FROM etl.t_tcache_eks_item_wawi_item_2
    QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, prod_num ORDER BY itemno_wawi) = 1
) AS SRC
INNER JOIN
(
    SELECT Cast(artnrvier AS Number) AS itemnr
      , a.*
    FROM  ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_2 AS a
    WHERE delete_fg IS NULL
    QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, artnrvier ORDER BY artikelnr) = 1
) AS waw
ON  src.wawi_instanz_kzl = LEFT(waw.wawi_instanz_kzl,2)
AND src.itemno_wawi = waw.itemnr
LEFT OUTER JOIN
(
    SELECT
        LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
      , Cast(Substring(c119_itemno, 1, Length(c119_itemno)-4) AS Number) AS itemnr
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t119_status_locked_2
    WHERE delete_fg IS NULL
    GROUP BY 1,2
    HAVING Min(c119_locked) = 1
) AS lck
ON  LEFT(waw.wawi_instanz_kzl,2) = lck.wawi_instanz_kzl
AND waw.itemnr = lck.itemnr
LEFT OUTER JOIN
(
    SELECT Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) AS itemnr
      , a.*
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikelbestell_2 AS a
    WHERE delete_fg IS NULL
    QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, itemnr ORDER BY artikelnr) = 1
) AS itmo
ON  waw.wawi_instanz_kzl = itmo.wawi_instanz_kzl
AND waw.itemnr = itmo.itemnr
LEFT OUTER JOIN
(
    SELECT Cast(Substring(c220_itemno, 1, Length(c220_itemno)-4) AS Number) AS itemnr
      , a.*
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t220_dangerous_goods_2 a 
    WHERE delete_fg IS NULL
    QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, itemnr ORDER BY c220_itemno) = 1
) as dg
ON  waw.wawi_instanz_kzl = dg.wawi_instanz_kzl
AND waw.itemnr = dg.itemnr
LEFT OUTER JOIN
(
    select Cast(c214_itemnrshort AS Number) AS itemnr_
      , a.*
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t214_itemaddinfo_2 AS a
    WHERE delete_fg IS NULL
    QUALIFY Row_Number() OVER (PARTITION BY a.wawi_instanz_kzl, a.c214_itemnrshort ORDER BY a.c214_itemnr) = 1
) AS itma
ON  waw.wawi_instanz_kzl = itma.wawi_instanz_kzl
AND waw.itemnr = itma.itemnr_
LEFT OUTER JOIN LDL_WAWI_PRODUCTION.hqwawiadm.t007_descriptions_2 AS adsc
ON  waw.wawi_instanz_kzl = adsc.wawi_instanz_kzl
AND itma.c214_ageflag = adsc.c007_code
AND adsc.c007_type = 'AgeLimits'
AND adsc.delete_fg IS NULL
left join     LDL_WAWI_PRODUCTION.hqwawiadm.T270_LISTTYPE_2 brd
on brd.wawi_instanz_kzl = waw.wawi_instanz_kzl
and c270_listnr = listenknznr 
AND brd.delete_fg IS NULL 
;

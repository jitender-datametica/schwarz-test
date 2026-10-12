-- WAWI_HQ country_2 deduplication mapping table
CREATE TEMPORARY TABLE ETL.t_ctrcode_map_${LOAD_ID} AS (
    SELECT
        int_org_ctr_cd AS ctrcode_tgt
      , party_nat_key_nr AS ctrcode_src
      , Row_Number() OVER (PARTITION BY party_sid
                          ORDER BY CASE WHEN party_nat_key_nr = int_org_ctr_cd
                                            THEN 0 ELSE 1
                                    END, party_nat_key_nr
                          ) AS ctrcode_rank
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
          , ctrcode
          , itemno_wawi
        FROM ETL.t_wawi_precore_eks_item_wawi_item_2
        QUALIFY Row_Number() OVER (PARTITION BY ctrcode, prod_num
                                   ORDER BY
                                       /* Use product (BA) link first if exists */
                                       CASE WHEN prod_num = itemno THEN 0 ELSE 1 END
                                     , itemno_wawi) = 1
    ) AS eks
    INNER JOIN ETL.t_ctrcode_map_${LOAD_ID} AS cm
    ON  eks.ctrcode = cm.ctrcode_src
    QUALIFY Row_Number() OVER (PARTITION BY eks.prod_num, cm.ctrcode_tgt ORDER BY ctrcode_rank) = 1
)
;

--Extraction/Filter Logic:
INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_KEY_TYPE_CD,
        PROD_NR,
        INT_ORG_KEY_TYPE_CD,
        CTRCODE,
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
        src.ctrcode AS CTRCODE,
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
        TRY_CAST(adsc.desc AS NUMBER) AS MIN_CUST_AGE_MEAS,
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
        ctrcode
      , prod_num
      , itemno_wawi
      , (Count(*) OVER (PARTITION BY ctrcode, prod_num) > 1) AS add_nr_exist_fg
    FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, prod_num ORDER BY itemno_wawi) = 1
) AS SRC
INNER JOIN
(
    SELECT Cast(artnrvier AS Number) AS itemnr
      , a.*
    FROM ETL.T_WAWI_PRECORE_ARTIKEL_2 AS a
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, artnrvier ORDER BY artikelnr) = 1
) AS waw
ON  src.ctrcode = waw.ctrcode
AND src.itemno_wawi = waw.itemnr
LEFT OUTER JOIN
(
    SELECT
        ctrcode
      , Cast(Substring(itemno, 1, Length(itemno)-4) AS Number) AS itemnr
    FROM ETL.T_WAWI_PRECORE_T119_STATUS_LOCKED_2
    GROUP BY 1,2
    HAVING Min(locked) = 1
) AS lck
ON  waw.ctrcode = lck.ctrcode
AND waw.itemnr = lck.itemnr
LEFT OUTER JOIN
(
    SELECT Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) AS itemnr
      , a.*
    FROM ETL.T_WAWI_PRECORE_ARTIKELBESTELL_2 AS a
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr ORDER BY artikelnr) = 1
) AS itmo
ON  waw.ctrcode = itmo.ctrcode
AND waw.itemnr = itmo.itemnr
LEFT OUTER JOIN
(
    SELECT Cast(Substring(itemno, 1, Length(itemno)-4) AS Number) AS itemnr
      , a.*
    FROM ETL.T_WAWI_PRECORE_T220_DANGEROUS_GOODS_2 AS a
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr ORDER BY itemno) = 1
) as dg
ON  waw.ctrcode = dg.ctrcode
AND waw.itemnr = dg.itemnr
LEFT OUTER JOIN
(
    select Cast(itemnrshort AS Number) AS itemnr_
      , a.*
    FROM ETL.T_WAWI_PRECORE_T214_ITEMADDINFO_2 AS a
    QUALIFY Row_Number() OVER (PARTITION BY a.ctrcode, a.itemnrshort ORDER BY a.itemnr) = 1
) AS itma
ON  waw.ctrcode = itma.ctrcode
AND waw.itemnr = itma.itemnr_
LEFT OUTER JOIN ETL.T_WAWI_PRECORE_T007_DESCRIPTIONS_2 AS adsc
ON  waw.ctrcode = adsc.ctrcode
AND itma.ageflag = adsc.code
AND adsc.type_ = 'AgeLimits'
left join     ETL.t_wawi_precore_T270_LISTTYPE_2 brd
on brd.ctrcode = waw.ctrcode
and c270_listnr = listenknznr  
;

-- WAWI_HQ country deduplication mapping table
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
        FROM meta.t_party_key AS pk
        INNER JOIN core_rel.t_internal_organization AS io
        ON  pk.party_sid = io.int_org_sid
        AND pk.dwh_valid_fg
        AND io.dwh_valid_fg
        AND pk.party_key_type_cd = 'COUNTRY'
    )
);


-- FV product to (WAWI) local product
CREATE TEMPORARY TABLE ETL.t_fv_prod_to_wawi_item AS (
    SELECT
        p.prod_sid
      , p.prod_nr
      , iit.wawi_instanz_kzl
      , iit.itemnr
    FROM
    (
        SELECT 
            prod_sid
          , try_Cast(prod_nr AS Number) AS prod_nr
        FROM CORE_REL.t_product
        WHERE prod_sid IN (SELECT prod_sid FROM META.t_product_key WHERE prod_key_type_cd IN ('FV'))
        AND dwh_valid_fg
    ) AS p
    INNER JOIN
    (
        SELECT iit.*
        FROM
        (
            SELECT *
            FROM
            (
                SELECT DISTINCT
                    LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
                  , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
                  , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
                FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr
                WHERE delete_fg IS NULL
            )
            QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, c215_int_itemnr
                                       /* By FV product prefer the WAWI item with matching number */
                                       ORDER BY CASE WHEN c215_int_itemnr = itemnr THEN 0 ELSE 1 END
                                                , itemnr
                                      ) = 1
        ) AS iit
        INNER JOIN ETL.t_wawi_instanz_kzl_map AS cm
        ON  iit.wawi_instanz_kzl = cm.wawi_instanz_kzl_src
        QUALIFY Row_Number() OVER (PARTITION BY iit.c215_int_itemnr, cm.wawi_instanz_kzl_tgt ORDER BY cm.wawi_instanz_kzl_rank) = 1
    ) AS iit
    ON  p.prod_nr = iit.c215_int_itemnr

);

--INSERT INTO  ETL.t_tf_integra_precore_t451_integra_masterdata_2_local_product__
INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
          ctrcode
        , INT_ORG_KEY_TYPE_CD
        , PROD_KEY_TYPE_CD
        , PROD_NR
        , LOCAL_PROD_NR
        , ADD_NR_EXIST_FG
        , LOCAL_PROD_NAME
        , LOCAL_PROD_DESCR
        , LOCAL_PROD_VERSION_NR
        , LOCAL_PROD_CREATION_DT
        , LOCAL_LIST_DT
        , LOCAL_DELIST_DT
        , LOCKED_FG
        , BRAND_NAME
        , INTRASTAT_NR
        , PLU_NR
        , VAT_REFUND_FG
        , DANGEROUS_GOODS_FG
        , MIN_CUST_AGE_MEAS
        , SORT_SEQ
        , BRAND_TYPE_CD
        -- FRAMEWORK AND TECHNICAL COLUMNS
        , SOURCE_SYSTEM
        , EXTRACTION_DT
        , DWH_MAPPING_TMSP
        , TF_ERROR_FG
        , DELETED_FG
        , RECORD_ID
        , FILENAME
        , DWH_NODE_CD
        , DWH_LOAD_ID
)
SELECT    wawi_instanz_kzl                  AS ctrcode
        , 'COUNTRY'                         AS INT_ORG_KEY_TYPE_CD
        , 'FV'                              AS PROD_KEY_TYPE_CD      
        , prod_nr                           AS PROD_NR
        , src_itemnr                        AS LOCAL_PROD_NR
        , FALSE                             AS ADD_NR_EXIST_FG
        , bez_kurz                          AS LOCAL_PROD_NAME
        , bez_lang                          AS LOCAL_PROD_DESCR
        , Coalesce(itemversion, 0)          AS LOCAL_PROD_VERSION_NR
        , gueltig_ab                        AS LOCAL_PROD_CREATION_DT
        , CASE WHEN eingelist = TRUE 
               THEN eingel_datum ELSE Null 
          END                               AS LOCAL_LIST_DT
        , CASE WHEN ausgelist = TRUE 
               THEN ausgel_datum ELSE Null 
          END                               AS LOCAL_DELIST_DT
        , locked_fg                         AS LOCKED_FG
        , UPPER(marke)                      AS BRAND_NAME
        , commoditycode                     AS INTRASTAT_NR
        , plu                               AS PLU_NR
        , Coalesce(refund, False)           AS VAT_REFUND_FG
        , dang_fg                           AS DANGEROUS_GOODS_FG
        , Try_Cast(desc_007 AS Number)      AS MIN_CUST_AGE_MEAS
        , ordersatznr                       AS SORT_SEQ
        , BRAND_TYPE_CD
        , 'WAWI'                            AS SOURCE_SYSTEM
        , CURRENT_DATE                      AS EXTRACTION_DT
        , extraction_tmsp                   AS DWH_MAPPING_TMSP
        , 0                                 AS TF_ERROR_FG
        , 0                                 AS DELETED_FG
        , 0                                 AS RECORD_ID
        , '{SRC_INPUT_TABLE}'            AS FILENAME
        , 'WAWI_HQ'                         AS DWH_NODE_CD
        , '${LOAD_ID}'                      AS DWH_LOAD_ID

FROM (
        -- Extraction/Filter Logic:
        SELECT
            src.prod_nr
          , src.wawi_instanz_kzl
          , src.itemnr  as src_itemnr
          , waw.extraction_tmsp
          , waw.bez_kurz
          , waw.bez_lang
          , waw.itemversion
          , waw.gueltig_ab
          , waw.eingelist
          , waw.eingel_datum
          , waw.ausgelist
          , waw.ausgel_datum
          , (lck_itemnr IS NOT NULL) AS locked_fg
          , waw.marke
          , itmo.commoditycode
          , waw.plu
          , waw.refund
          , (dg_itemnr IS NOT NULL) AS dang_fg
          , adsc.desc_007
          , waw.ordersatznr
          , case when c270_listdescript ilike '% EM' then 'EM'
            when c270_listdescript ilike '% M' then 'M'
            else 'EM/M' end BRAND_TYPE_CD
        FROM ETL.t_fv_prod_to_wawi_item AS src
        INNER JOIN
        (
            SELECT Cast(artnrvier AS Number) AS waw_itemnr
              , a.*
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel AS a
            WHERE delete_fg IS NULL
            QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, artnrvier ORDER BY artikelnr) = 1
        ) AS waw
        ON  src.wawi_instanz_kzl = LEFT(waw.wawi_instanz_kzl,2)
        AND src.itemnr  = waw.waw_itemnr
        left join     ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.T270_LISTTYPE brd
        on brd.wawi_instanz_kzl = waw.wawi_instanz_kzl
        and c270_listnr = listenknznr 
        LEFT OUTER JOIN
        (
            SELECT
                wawi_instanz_kzl
              , Cast(Substring(c119_itemno, 1, Length(c119_itemno)-4) AS Number) AS lck_itemnr
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t119_status_locked
            WHERE delete_fg IS NULL
            GROUP BY 1,2
            HAVING Min(c119_locked) = 1
        ) AS lck
        ON  waw.wawi_instanz_kzl = lck.wawi_instanz_kzl
        AND waw_itemnr  = lck_itemnr
        LEFT OUTER JOIN
        (
            SELECT Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) AS itmo_itemnr
              , a.*
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikelbestell AS a
            WHERE delete_fg IS NULL
            QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, itmo_itemnr ORDER BY artikelnr) = 1
        ) AS itmo
        ON  waw.wawi_instanz_kzl = itmo.wawi_instanz_kzl
        AND waw_itemnr  = itmo.itmo_itemnr
        LEFT OUTER JOIN
        (
            SELECT Cast(Substring(c220_itemno, 1, Length(c220_itemno)-4) AS Number) AS dg_itemnr
              , a.*
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t220_dangerous_goods  AS a 
            WHERE delete_fg IS NULL
            QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, dg_itemnr ORDER BY dg_itemnr) = 1
        ) as dg
        ON  waw.wawi_instanz_kzl = dg.wawi_instanz_kzl
        AND waw_itemnr  = dg.dg_itemnr
        LEFT OUTER JOIN
        (
            SELECT Cast(c214_itemnrshort AS Number) as itma_itemnr
              , a.*
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t214_itemaddinfo AS a
            WHERE delete_fg IS NULL
            QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, itma_itemnr ORDER BY a.c214_itemnr) = 1
        ) AS itma
        ON  waw.wawi_instanz_kzl = itma.wawi_instanz_kzl
        AND waw_itemnr  = itma.itma_itemnr
        LEFT OUTER JOIN (
                SELECT 
                    a.*
                    , c007_desc AS desc_007 
                FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t007_descriptions a
                WHERE delete_fg IS NULL) AS adsc
        ON  waw.wawi_instanz_kzl  = adsc.wawi_instanz_kzl AND adsc.delete_fg IS NULL
        AND itma.c214_ageflag = adsc.c007_code
        AND adsc.c007_TYPE = 'AgeLimits'
) SRC

;

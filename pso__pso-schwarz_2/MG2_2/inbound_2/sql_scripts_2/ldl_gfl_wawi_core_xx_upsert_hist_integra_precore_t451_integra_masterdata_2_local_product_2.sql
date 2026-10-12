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


-- FV product to (WAWI) local product
CREATE TEMPORARY TABLE ETL.t_fv_prod_to_wawi_item AS (
    SELECT
        p.prod_sid
      , p.prod_nr
      , iit.ctrcode
      , iit.itemnr
    FROM
    (
        SELECT 
            prod_sid
          , try_Cast(prod_nr AS Number) AS prod_nr
        FROM CORE_REL.t_product_2
        WHERE prod_sid IN (SELECT prod_sid FROM META.t_product_key_2 WHERE prod_key_type_cd IN ('FV'))
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
                    ctrcode
                  , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
                  , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
                FROM etl.t_wawi_precore_t215_int_itemnr_2
            )
            QUALIFY Row_Number() OVER (PARTITION BY ctrcode, c215_int_itemnr
                                       /* By FV product prefer the WAWI item_2 with matching number */
                                       ORDER BY CASE WHEN c215_int_itemnr = itemnr THEN 0 ELSE 1 END
                                                , itemnr
                                      ) = 1
        ) AS iit
        INNER JOIN ETL.t_ctrcode_map_${LOAD_ID} AS cm
        ON  iit.ctrcode = cm.ctrcode_src
        QUALIFY Row_Number() OVER (PARTITION BY iit.c215_int_itemnr, cm.ctrcode_tgt ORDER BY cm.ctrcode_rank) = 1
    ) AS iit
    ON  p.prod_nr = iit.c215_int_itemnr

);

--INSERT INTO  etl.t_tf_integra_precore_t451_integra_masterdata_2_local_product__
INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
          CTRCODE
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
SELECT    ctrcode                           AS CTRCODE
        , 'COUNTRY_2'                         AS INT_ORG_KEY_TYPE_CD
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
        , 't_${SRC_INPUT_TABLE}'            AS FILENAME
        , 'WAWI_HQ'                         AS DWH_NODE_CD
        , '${LOAD_ID}'                      AS DWH_LOAD_ID

FROM (
        -- Extraction/Filter Logic:
        SELECT
            src.prod_nr
          , src.ctrcode
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
            FROM etl.t_wawi_precore_artikel_2 AS a
            QUALIFY Row_Number() OVER (PARTITION BY ctrcode, artnrvier ORDER BY artikelnr) = 1
        ) AS waw
        ON  src.ctrcode = waw.ctrcode
        AND src.itemnr  = waw.waw_itemnr
        left join     ETL.t_wawi_precore_T270_LISTTYPE_2 brd
        on brd.ctrcode = waw.ctrcode
        and c270_listnr = listenknznr 
        LEFT OUTER JOIN
        (
            SELECT
                ctrcode
              , Cast(Substring(itemno, 1, Length(itemno)-4) AS Number) AS lck_itemnr
            FROM etl.t_wawi_precore_t119_status_locked_2
            GROUP BY 1,2
            HAVING Min(locked) = 1
        ) AS lck
        ON  waw.ctrcode = lck.ctrcode
        AND waw_itemnr  = lck_itemnr
        LEFT OUTER JOIN
        (
            SELECT Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) AS itmo_itemnr
              , a.*
            FROM etl.t_wawi_precore_artikelbestell_2 AS a
            QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itmo_itemnr ORDER BY artikelnr) = 1
        ) AS itmo
        ON  waw.ctrcode = itmo.ctrcode
        AND waw_itemnr  = itmo.itmo_itemnr
        LEFT OUTER JOIN
        (
            SELECT Cast(Substring(itemno, 1, Length(itemno)-4) AS Number) AS dg_itemnr
              , a.*
            FROM etl.t_wawi_precore_t220_dangerous_goods_2 AS a
            QUALIFY Row_Number() OVER (PARTITION BY ctrcode, dg_itemnr ORDER BY dg_itemnr) = 1
        ) as dg
        ON  waw.ctrcode = dg.ctrcode
        AND waw_itemnr  = dg.dg_itemnr
        LEFT OUTER JOIN
        (
            SELECT Cast(itemnrshort AS Number) as itma_itemnr
              , a.*
            FROM etl.t_wawi_precore_t214_itemaddinfo_2 AS a
            QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itma_itemnr ORDER BY a.itemnr) = 1
        ) AS itma
        ON  waw.ctrcode = itma.ctrcode
        AND waw_itemnr  = itma.itma_itemnr
        LEFT OUTER JOIN (
            SELECT 
                  t_wawi_precore_t007_descriptions.*
                , t_wawi_precore_t007_descriptions.desc as desc_007 
                FROM etl.t_wawi_precore_t007_descriptions_2) AS adsc
        ON  waw.ctrcode  = adsc.ctrcode
        AND itma.ageflag = adsc.code
        AND adsc.TYPE_ = 'AgeLimits'
) SRC

;

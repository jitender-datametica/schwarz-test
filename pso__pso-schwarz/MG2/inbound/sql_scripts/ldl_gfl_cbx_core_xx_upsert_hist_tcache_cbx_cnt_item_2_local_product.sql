-- WAWI_HQ country deduplication mapping table
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
        FROM meta.t_party_key AS pk
        INNER JOIN core_rel.t_internal_organization AS io
        ON  pk.party_sid = io.int_org_sid
        AND pk.dwh_valid_fg
        AND io.dwh_valid_fg
        AND pk.party_key_type_cd = 'COUNTRY'
    )
);

-- CBX product to (WAWI) local product
CREATE TEMPORARY TABLE ETL.t_cbx_prod_to_wawi_item AS (
    SELECT
        p.prod_sid
      , p.prod_nr
      , iit.ctrcode
      , iit.itemnr
    FROM
    (
        SELECT 
            prod_sid
          , Try_Cast(prod_nr AS Number) AS prod_nr
        FROM CORE_REL.t_product
        WHERE prod_sid IN (SELECT prod_sid FROM META.t_product_key WHERE prod_key_type_cd IN ('CBX'))
        AND dwh_valid_fg
        AND Try_Cast(prod_nr AS Number) IS NOT NULL
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
                FROM etl.t_wawi_precore_t215_int_itemnr
            )
            QUALIFY Row_Number() OVER (PARTITION BY ctrcode, c215_int_itemnr
                                       /* By NF/CBX product prefer the WAWI item with matching number */
                                       ORDER BY CASE WHEN c215_int_itemnr = itemnr THEN 0 ELSE 1 END
                                                , itemnr
                                      ) = 1
        ) AS iit
        INNER JOIN ETL.t_ctrcode_map_${LOAD_ID} AS cm
        ON  iit.ctrcode = cm.ctrcode_src
        QUALIFY Row_Number() OVER (PARTITION BY iit.c215_int_itemnr, cm.ctrcode_tgt ORDER BY cm.ctrcode_rank) = 1
    ) AS iit
    ON  p.prod_nr = iit.C215_INT_ITEMNR

);

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
   PROD_NR
 , CTRCODE
 , PROD_KEY_TYPE_CD
 , INT_ORG_KEY_TYPE_CD
 , ADD_NR_EXIST_FG
 , LOCAL_PROD_NR
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
-- Extraction/Filter Logic:
SELECT DISTINCT
   src.prod_nr                          AS PROD_NR
 , src.ctrcode                          AS CTRCODE
 , 'CBX'                                AS PROD_KEY_TYPE_CD
 , 'COUNTRY'                            AS INT_ORG_KEY_TYPE_CD
 , FALSE                                AS ADD_NR_EXIST_FG
 , src.itemnr                           AS LOCAL_PROD_NR
 , waw.bez_kurz                         AS LOCAL_PROD_NAME
 , waw.bez_lang                         AS LOCAL_PROD_DESCR
 , Coalesce(waw.itemversion, 0)         AS LOCAL_PROD_VERSION_NR
 , waw.gueltig_ab                       AS LOCAL_PROD_CREATION_DT
 , CASE WHEN waw.eingelist = TRUE
   THEN waw.eingel_datum ELSE Null END  AS LOCAL_LIST_DT
 , CASE WHEN waw.ausgelist = TRUE
   THEN waw.ausgel_datum ELSE Null END  AS LOCAL_DELIST_DT
 , (lck.itemnr IS NOT NULL)             AS LOCKED_FG
 , UPPER(waw.marke)                            AS BRAND_NAME
 , itmo.commoditycode                   AS INTRASTAT_NR
 , waw.plu                              AS PLU_NR
 , Coalesce(waw.refund, FALSE)          AS VAT_REFUND_FG
 , (dg.itemnr IS NOT NULL)              AS DANGEROUS_GOODS_FG
 , Try_Cast(adsc.desc AS Number)   AS MIN_CUST_AGE_MEAS
 , waw.ordersatznr                      AS SORT_SEQ
 , BRAND_TYPE_CD

 , 'CBX'                                AS SOURCE_SYSTEM
 , CURRENT_DATE                         AS EXTRACTION_DT
 , waw.extraction_tmsp                  AS DWH_MAPPING_TMSP
 , 0                                    AS TF_ERROR_FG
 , 0                                    AS DELETED_FG
 , 0                                    AS RECORD_ID
 , 't_${SRC_INPUT_TABLE}'               AS FILENAME
 , 'WAWI_HQ'                            AS DWH_NODE_CD
 , '${LOAD_ID}'                         AS DWH_LOAD_ID

FROM ETL.t_cbx_prod_to_wawi_item AS src
INNER JOIN
(
    SELECT Cast(artnrvier AS Number) AS itemnr
      , a.*, case when brd.c270_listdescript ilike '% EM' then 'EM'
            when brd.c270_listdescript ilike '% M' then 'M'
            else 'EM/M' end as brand_type_cd
    FROM etl.t_wawi_precore_artikel AS a
    left join     ETL.t_wawi_precore_T270_LISTTYPE brd
    on brd.ctrcode = a.ctrcode
    and c270_listnr = listenknznr
    QUALIFY Row_Number() OVER (PARTITION BY a.ctrcode, artnrvier ORDER BY artikelnr) = 1
) AS waw
ON  src.ctrcode = waw.ctrcode
AND src.itemnr = waw.itemnr
LEFT OUTER JOIN
(
    SELECT
        ctrcode
      , Cast(Substring(itemno, 1, Length(itemno)-4) AS Number) AS itemnr
    FROM etl.t_wawi_precore_t119_status_locked
    GROUP BY 1,2
    HAVING Min(locked) = 1
) AS lck
ON  waw.ctrcode = lck.ctrcode
AND waw.itemnr = lck.itemnr
LEFT OUTER JOIN
(
    SELECT Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) AS itemnr
      , a.*
    FROM etl.t_wawi_precore_artikelbestell AS a
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr ORDER BY artikelnr) = 1
) AS itmo
ON  waw.ctrcode = itmo.ctrcode
AND waw.itemnr = itmo.itemnr
LEFT OUTER JOIN
(
    SELECT Cast(Substring(itemno, 1, Length(itemno)-4) AS Number) AS itemnr
      , a.*
    FROM etl.t_wawi_precore_t220_dangerous_goods AS a
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr ORDER BY itemno) = 1
) as dg
ON  waw.ctrcode = dg.ctrcode
AND waw.itemnr = dg.itemnr
LEFT OUTER JOIN
(
    SELECT Cast(itemnrshort AS Number) AS itma_itemnr
      , a.*
    FROM etl.t_wawi_precore_t214_itemaddinfo AS a
            QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itma_itemnr ORDER BY a.itemnr ) = 1
) AS itma
ON  waw.ctrcode = itma.ctrcode
AND waw.itemnr = itma.itma_itemnr
LEFT OUTER JOIN ETL.t_wawi_precore_t007_descriptions AS adsc
ON  waw.ctrcode = adsc.ctrcode
AND itma.ageflag = adsc.code
AND adsc.type_ = 'AgeLimits'
;

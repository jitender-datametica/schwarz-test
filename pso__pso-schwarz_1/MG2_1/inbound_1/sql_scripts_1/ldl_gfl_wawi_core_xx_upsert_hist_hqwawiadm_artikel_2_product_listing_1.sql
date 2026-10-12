/* Standard processing as per mapping specifications:
*/

-- WAWI_HQ country_1 deduplication mapping table (used by CBX, FV, EKS) XXXX
CREATE OR REPLACE TEMPORARY TABLE ETL.t_wawi_instanz_kzl_map AS (
    SELECT
        int_org_ctr_cd AS wawi_instanz_kzl_tgt
      , party_nat_key_nr AS wawi_instanz_kzl_src
      , ROW_NUMBER() OVER (PARTITION BY party_sid
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
        FROM meta.t_party_key_1 AS pk
        INNER JOIN core_rel.t_internal_organization_1 AS io
        ON  pk.party_sid = io.int_org_sid
        AND pk.dwh_valid_fg
        AND io.dwh_valid_fg
        AND pk.party_key_type_cd = 'COUNTRY_1'
    )
);

-- CBX product to (WAWI) local items
CREATE  OR REPLACE TEMPORARY TABLE ETL.t_cbx_prod_to_wawi_items AS (
        SELECT
            p.prod_sid
          , p.prod_nr
          , iit.wawi_instanz_kzl
         , iit.itemnr
        FROM
        (
            SELECT 
                prod_sid
              , Try_Cast(prod_nr AS Number) AS prod_nr
            FROM CORE_REL.t_product_1
            WHERE prod_sid IN (SELECT prod_sid FROM META.t_product_key_1 WHERE prod_key_type_cd IN ('CBX'))
            AND dwh_valid_fg
            AND Try_Cast(prod_nr AS Number) IS NOT NULL
        ) AS p
        INNER JOIN
        (
            SELECT DISTINCT
                LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
              , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
              , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr_1 WHERE delete_fg IS NULL
        ) AS iit
        ON  p.prod_nr = iit.c215_int_itemnr
    );

-- FV product to (WAWI) local items XXXX
CREATE  OR REPLACE TEMPORARY TABLE ETL.t_fv_prod_to_wawi_item AS (
        SELECT
            p.prod_sid
          , p.prod_nr
          , iit.wawi_instanz_kzl
          , iit.itemnr
        FROM
        (
            SELECT 
                prod_sid
              , Try_Cast(prod_nr AS Number) AS prod_nr
            FROM CORE_REL.t_product_1
            WHERE prod_sid IN (SELECT prod_sid FROM META.t_product_key_1 WHERE prod_key_type_cd IN ('FV'))
            AND dwh_valid_fg
            AND Try_Cast(prod_nr AS Number) IS NOT NULL
        ) AS p
        INNER JOIN
        (
            SELECT DISTINCT
                LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
              , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
              , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr_1 WHERE delete_fg IS NULL
        ) AS iit
        ON  p.prod_nr = iit.c215_int_itemnr
    );

 
--WAWI product to (WAWI) local product - XXX_1
CREATE OR REPLACE TEMPORARY TABLE ETL.t_wawi_prod_to_wawi_item_1 AS (
        SELECT
            prod_sid
          , SPLIT_PART(prod_nat_key_nr, '|',0) AS wawi_instanz_kzl
          , CAST(Split(prod_nat_key_nr, '|')[1] AS NUMBER) AS itemnr
        FROM META.t_product_key_1
        WHERE prod_key_type_cd = 'WAWI'
        AND dwh_valid_fg
    );

--CBX product to (WAWI) local items

CREATE OR REPLACE TEMPORARY TABLE ETL.t_cbx_prod_to_wawi_items AS (
    SELECT
        p.prod_sid
      , p.prod_nr
      , iit.wawi_instanz_kzl
     , iit.itemnr
    FROM
    (
        SELECT 
            prod_sid,
           TRY_CAST(prod_nr AS Number) AS prod_nr
        FROM CORE_REL.t_product_1
        WHERE prod_sid IN (SELECT prod_sid FROM META.t_product_key_1 WHERE prod_key_type_cd IN ('CBX'))
        AND dwh_valid_fg
        AND TRY_CAST(prod_nr AS NUMBER) IS NOT NULL
    ) AS p
    INNER JOIN
    (
        SELECT DISTINCT
            LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
          , CAST(Substring(c215_itemnr, 1, LENGTH(c215_itemnr)-4) AS NUMBER) AS itemnr
          , CAST(c215_int_itemnr AS NUMBER) AS c215_int_itemnr
        FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr_1 WHERE delete_fg IS NULL
    ) AS iit
    ON  p.prod_nr = iit.c215_int_itemnr
);

---------------------------------------------------------------

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
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
SELECT src.prod_sid,
       src.wawi_instanz_kzl as  party_nat_key_nr,
       'COUNTRY_1' as int_org_key_type_cd,
       CASE WHEN src.listenknznr in ( 1, 2) THEN 1 --Normal Assortment
            WHEN src.listenknznr in (5,6) THEN 3 --Test_1 Assortment
            WHEN src.listenknznr in (7,8) THEN 2 --Promotion
            WHEN src.listenknznr in (9,10) THEN 4 --New Listing
            WHEN src.listenknznr in (11,12) THEN 5 -- Delisted
            ELSE 0
       END AS list_type_cd,              
       'WAWI' source_system,
       src.extraction_tmsp extraction_dt,
       src.extraction_tmsp dwh_mapping_tmsp,
       0 tf_error_fg,
       0 deleted_fg,
       0 record_id,
       '${SRC_INPUT_TABLE}' filename,
       'WAWI_HQ' dwh_node_cd,
       '${LOAD_ID}' dwh_load_id        
  FROM 
      ( SELECT --WAWI
             src.prod_sid,
             src.wawi_instanz_kzl,
             waw.LISTENKNZNR,
             waw.extraction_tmsp
        FROM ETL.t_wawi_prod_to_wawi_item_1 AS src
        INNER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_1 AS waw ON  src.wawi_instanz_kzl = LEFT(waw.wawi_instanz_kzl,2)   AND src.itemnr = Cast(waw.artnrvier AS Number) AND delete_fg IS NULL
        QUALIFY ROW_NUMBER() OVER (PARTITION BY src.prod_sid, src.wawi_instanz_kzl ORDER BY waw.listenknznr) = 1
        UNION --FV
        SELECT    
             iit.prod_sid,
             iit.wawi_instanz_kzl,
             waw.listenknznr,
             waw.extraction_tmsp
        FROM ETL.t_fv_prod_to_wawi_item AS iit
        INNER JOIN
           (  SELECT CAST(artnrvier AS NUMBER) AS itemnr, a.*
              FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_1 AS a
              WHERE a.listenknznr is not NULL  AND delete_fg IS NULL
              QUALIFY ROW_NUMBER() OVER (PARTITION BY a.wawi_instanz_kzl, a.artnrvier ORDER BY a.listenknznr) = 1
            ) AS waw  ON  iit.wawi_instanz_kzl = LEFT(waw.wawi_instanz_kzl,2) AND iit.itemnr = waw.itemnr
         INNER JOIN ETL.t_wawi_instanz_kzl_map AS cm ON  waw.wawi_instanz_kzl = cm.wawi_instanz_kzl_src
         QUALIFY ROW_NUMBER() OVER (PARTITION BY iit.prod_sid, cm.wawi_instanz_kzl_tgt ORDER BY  waw.listenknznr) = 1
         UNION --EKS
         SELECT 
             pk.prod_sid, 
             pr.wawi_instanz_kzl,
             artkl.listenknznr, 
             artkl.extraction_tmsp
	  FROM
             ( SELECT 
               a.listenknznr,
               CAST(artnrvier AS NUMBER) AS itemnr,
	       a.wawi_instanz_kzl,
               a.extraction_tmsp
               FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_1 AS a
               WHERE a.listenknznr is not NULL AND delete_fg IS NULL
               QUALIFY ROW_NUMBER() OVER (PARTITION BY wawi_instanz_kzl, itemnr ORDER BY artikelnr) = 1) artkl
          JOIN  etl.t_tcache_eks_item_wawi_item_1 pr  ON pr.wawi_instanz_kzl=LEFT(artkl.wawi_instanz_kzl,2) AND pr.itemno_wawi = artkl.itemnr
          INNER JOIN meta.t_product_key_1 AS pk ON  Cast(pr.prod_num AS String) = pk.prod_nat_key_nr AND pk.prod_key_type_cd = 'EKS' AND pk.dwh_valid_fg
          INNER JOIN ETL.t_wawi_instanz_kzl_map AS cm ON  LEFT(artkl.wawi_instanz_kzl,2) = cm.wawi_instanz_kzl_src
          QUALIFY ROW_NUMBER() OVER (PARTITION BY cm.wawi_instanz_kzl_tgt, pk.prod_sid ORDER BY artkl.listenknznr) = 1
          UNION --CBX
          SELECT           
               prod_sid, 
               wawi_instanz_kzl,
               listenknznr, 
               extraction_tmsp
           FROM 
              (
                 SELECT
                     src.prod_sid,
                     src.prod_nr,
                     src.wawi_instanz_kzl,
                     waw.extraction_tmsp,
                     waw.listenknznr
                 FROM ETL.t_cbx_prod_to_wawi_items AS src
                INNER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_1 AS waw ON  src.wawi_instanz_kzl = LEFT(waw.wawi_instanz_kzl,2) AND src.itemnr = CAST(waw.artnrvier AS NUMBER) AND waw.listenknznr IS NOT NULL
                                                                                            AND delete_fg IS NULL
                INNER JOIN ETL.t_wawi_instanz_kzl_map AS cm ON  LEFT(waw.wawi_instanz_kzl,2) = cm.wawi_instanz_kzl_src
                QUALIFY ROW_NUMBER() OVER (PARTITION BY cm.wawi_instanz_kzl_tgt, src.prod_nr ORDER BY waw.listenknznr) = 1  
               )

       )  src;




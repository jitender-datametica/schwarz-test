/* Standard processing as per mapping specifications:
*/

/*
0.2 init country_1 table and deduplication mapping
*/
CREATE OR REPLACE TEMPORARY TABLE etl.t_ctrcode_map_1 AS (
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
        FROM meta.t_party_key_1 AS pk
        INNER JOIN core_rel.t_internal_organization_1 AS io
        ON  pk.party_sid = io.int_org_sid
        AND pk.dwh_valid_fg
        AND io.dwh_valid_fg
        AND pk.party_key_type_cd = 'COUNTRY_1'
    )
)
;


/*
0.3 CBX product to local items
*/
CREATE OR REPLACE TEMPORARY TABLE etl.t_cbx_prod_to_wawi_items AS (
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
        FROM CORE_REL.t_product_1
        WHERE prod_sid IN (SELECT prod_sid FROM META.t_product_key_1 WHERE prod_key_type_cd IN ('CBX'))
        AND dwh_valid_fg
        AND Try_Cast(prod_nr AS Number) IS NOT NULL
    ) AS p
    INNER JOIN
    (
        SELECT DISTINCT
            ctrcode
          , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
          , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
        FROM etl.t_wawi_precore_t215_int_itemnr_1 
    ) AS iit
    ON  p.prod_nr = iit.c215_int_itemnr
)
;

/*
0.3 add FV product to local items
*/
CREATE OR REPLACE TEMPORARY TABLE etl.t_fv_prod_to_wawi_item AS (
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
        FROM CORE_REL.t_product_1
        WHERE prod_sid IN (SELECT prod_sid FROM META.t_product_key_1 WHERE prod_key_type_cd IN ('FV'))
        AND dwh_valid_fg
        AND Try_Cast(prod_nr AS Number) IS NOT NULL
    ) AS p
    INNER JOIN
    (
        SELECT DISTINCT
            ctrcode
          , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
          , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
        FROM ETL.t_wawi_precore_t215_int_itemnr_1
    ) AS iit
    ON  p.prod_nr = iit.c215_int_itemnr
)
;

/*
0.4 add WaWi product to local items
*/
CREATE OR REPLACE TEMPORARY TABLE etl.t_wawi_prod_to_wawi_item_1 AS (
    SELECT
        p.prod_sid
      , Split(p.prod_nat_key_nr, '|')[0] AS ctrcode
      , m.ctrcode_tgt
      , Cast(Split(p.prod_nat_key_nr, '|')[1] AS Number) AS itemnr
    FROM META.t_product_key_1 p
    left join ETL.t_ctrcode_map_1 m on Split(p.prod_nat_key_nr, '|')[0] = m.ctrcode_src
    WHERE p.prod_key_type_cd = 'WAWI'
    AND p.dwh_valid_fg = 1
)
;


INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_SID,        
        PARTY_NAT_KEY_NR,
        INT_ORG_KEY_TYPE_CD,
        SUP_NAT_KEY_NR,
        SUP_KEY_TYPE_CD,
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
SELECT --CBX
       src.prod_sid,
       src.ctrcode as  party_nat_key_nr,
       'COUNTRY_1' as int_org_key_type_cd,
       src.ctrcode || '|' || LTRIM(src.krednr,'0') as  sup_nat_key_nr,
       'SUPPLIER_1' as sup_key_type_cd,
       'CBX' source_system,
       src.extraction_tmsp extraction_dt,
       src.extraction_tmsp dwh_mapping_tmsp,
       0 tf_error_fg,
       0 deleted_fg,
       0 record_id,
       'wawi_precore_artlieferant_hq' filename,
       'CBX' dwh_node_cd,
        ${LOAD_ID} dwh_load_id 
FROM (       
         SELECT
             l.prod_sid
             ,c.ctrcode_tgt as ctrcode
             ,s.krednr
             ,l.prod_nr
             ,concat (c.ctrcode_tgt ,'|', cast (s.krednr as bigint)) as party_nat_key_nr  
             ,s.extraction_tmsp
         FROM etl.t_cbx_prod_to_wawi_items l  
         LEFT JOIN etl.t_ctrcode_map_1 c ON l.ctrcode = c.ctrcode_src  
         LEFT JOIN
                  ( SELECT CAST (Substring (trim (artikelnr, 0), 1, Length(trim (artikelnr, 0))-4) as varchar (20))  as artikelnr ,
                           ctrcode ,
                           LTRIM(krednr,'0') as krednr,
                           extraction_tmsp
                     FROM etl.t_wawi_precore_artlieferant_hq_1
                   ) s
              ON CAST(l.itemnr as varchar (20)) = s.artikelnr AND l.ctrcode = s.ctrcode
         WHERE s.krednr IS NOT NULL and s.krednr <>''
         QUALIFY Row_Number() OVER (PARTITION BY l.prod_sid ,c.ctrcode_tgt ORDER BY s.krednr) = 1
) src
UNION --FV
SELECT 
       src.prod_sid,
       src.ctrcode as  party_nat_key_nr,
       'COUNTRY_1' as int_org_key_type_cd,
       src.ctrcode || '|' || LTRIM(src.krednr,'0') as  sup_nat_key_nr,
       'SUPPLIER_1' as sup_key_type_cd,
       'FV' source_system,
       src.extraction_tmsp extraction_dt,
       src.extraction_tmsp dwh_mapping_tmsp,
       0 tf_error_fg,
       0 deleted_fg,
       0 record_id,
       'wawi_precore_artlieferant_hq' filename,
       'FV' dwh_node_cd,
        ${LOAD_ID} dwh_load_id 
FROM (       
         SELECT
             l.prod_sid
             ,c.ctrcode_tgt as ctrcode
             ,s.krednr
             ,l.prod_nr
             ,concat (c.ctrcode_tgt ,'|', cast (s.krednr as bigint)) as party_nat_key_nr  
             ,s.extraction_tmsp
         FROM etl .t_fv_prod_to_wawi_item l  
         LEFT JOIN etl.t_ctrcode_map_1 c ON l.ctrcode = c.ctrcode_src  
         LEFT JOIN
                  ( SELECT CAST (Substring (trim (artikelnr, 0), 1, Length(trim (artikelnr, 0))-4) as varchar (20))  as artikelnr ,
                           ctrcode ,
                           LTRIM(krednr,'0') as krednr,
                           extraction_tmsp
                     FROM etl.t_wawi_precore_artlieferant_hq_1
                   ) s
              ON CAST(l.itemnr as varchar (20)) = s.artikelnr AND l.ctrcode = s.ctrcode
         WHERE s.krednr IS NOT NULL and s.krednr <>''
         QUALIFY Row_Number() OVER (PARTITION BY l.prod_sid ,c.ctrcode_tgt ORDER BY s.krednr) = 1
) src
UNION --EKS
SELECT 
       src.prod_sid,
       src.ctrcode as  party_nat_key_nr,
       'COUNTRY_1' as int_org_key_type_cd,
       src.ctrcode || '|' || LTRIM(src.krednr,'0') as  sup_nat_key_nr,
       'SUPPLIER_1' as sup_key_type_cd,
       'EKS' source_system,
       src.extraction_tmsp extraction_dt,
       src.extraction_tmsp dwh_mapping_tmsp,
       0 tf_error_fg,
       0 deleted_fg,
       0 record_id,
       'wawi_precore_artlieferant_hq' filename,
       'EKS' dwh_node_cd,
        ${LOAD_ID} dwh_load_id 
FROM (       
         SELECT
             pk.prod_sid,
             c.ctrcode_tgt AS ctrcode,
             s.krednr,             
             concat (c.ctrcode_tgt ,'|', s.krednr) as party_nat_key_nr,  
             s.extraction_tmsp
         FROM etl.t_wawi_precore_eks_item_wawi_item_1 eks             
         LEFT JOIN etl.t_ctrcode_map_1 c ON eks.ctrcode = c.ctrcode_src  
         LEFT JOIN 
                  ( SELECT CAST (SUBSTRING (TRIM (artikelnr, 0), 1, LENGTH(TRIM (artikelnr, 0))-4) AS varchar (20))  AS artikelnr,
                           ctrcode ,
                           LTRIM(krednr,'0') as krednr,
                           extraction_tmsp 
                     FROM etl.t_wawi_precore_artlieferant_hq_1 
                   ) s 
               ON CAST(eks.itemno_wawi as varchar (20)) = s.artikelnr AND eks.ctrcode = s.ctrcode
         INNER JOIN  meta.t_product_key_1 pk ON CAST(pk.prod_nat_key_nr as varchar) = CAST(eks.prod_num as varchar)  AND pk.prod_key_type_cd = 'EKS'  AND pk.dwh_valid_fg
         WHERE  eks.prod_num is not null AND s.krednr != ''        
         QUALIFY Row_Number() OVER (PARTITION BY c.ctrcode_tgt ,eks.prod_num  ORDER BY s.krednr) = 1
) src
UNION --WAWI
SELECT 
       src.prod_sid,
       src.ctrcode as  party_nat_key_nr,
       'COUNTRY_1' as int_org_key_type_cd,
       src.ctrcode || '|' || LTRIM(src.krednr,'0') as  sup_nat_key_nr,
       'SUPPLIER_1' as sup_key_type_cd,
       'WAWI' source_system,
       src.extraction_tmsp extraction_dt,
       src.extraction_tmsp dwh_mapping_tmsp,
       0 tf_error_fg,
       0 deleted_fg,
       0 record_id,
       'wawi_precore_artlieferant_hq' filename,
       'WAWI' dwh_node_cd,
        ${LOAD_ID} dwh_load_id 
FROM (       
         SELECT
             w.prod_sid,
             c.ctrcode_tgt as ctrcode,
             s.krednr,
             w.itemnr,
             concat (c.ctrcode_tgt ,'|', cast (s.krednr as bigint)) as party_nat_key_nr   ,
             s.extraction_tmsp
         FROM etl.t_wawi_prod_to_wawi_item_1 w
         LEFT JOIN etl.t_ctrcode_map_1 c ON w.ctrcode = c.ctrcode_src  
         LEFT JOIN 
                  ( SELECT CAST (Substring (trim (artikelnr, 0), 1, Length(trim (artikelnr, 0))-4) as varchar (20))  as artikelnr ,
                           ctrcode ,
                           LTRIM(krednr,'0') as krednr,
                           extraction_tmsp 
                     FROM etl.t_wawi_precore_artlieferant_hq_1 
                   ) s 
               ON CAST (w.itemnr as varchar (20)) = s.artikelnr AND w.ctrcode = s.ctrcode         
          WHERE w.itemnr IS NOT NULL AND s.krednr IS NOT NULL and s.krednr <>''
          QUALIFY Row_Number() OVER (PARTITION BY s.artikelnr ,c.ctrcode_tgt ORDER BY s.krednr) = 1
) src
;

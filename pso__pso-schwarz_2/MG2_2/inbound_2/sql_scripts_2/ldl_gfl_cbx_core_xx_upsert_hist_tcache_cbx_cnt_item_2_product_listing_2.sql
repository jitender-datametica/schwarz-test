-- WAWI_HQ country_2 deduplication mapping table (used by CBX, FV, EKS) XXXX
CREATE OR REPLACE TEMPORARY TABLE ETL.t_ctrcode_map_2 AS (
    SELECT
        int_org_ctr_cd AS ctrcode_tgt
      , party_nat_key_nr AS ctrcode_src
      , ROW_NUMBER() OVER (PARTITION BY party_sid
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

--CBX product to (WAWI) local items

CREATE TEMPORARY TABLE ETL.t_cbx_prod_to_wawi_items AS (
    SELECT
        p.prod_sid
      , p.prod_nr
      , iit.ctrcode
     , iit.itemnr
    FROM
    (
        SELECT 
            prod_sid,
           TRY_CAST(prod_nr AS Number) AS prod_nr
        FROM CORE_REL.t_product_2
        WHERE prod_sid IN (SELECT prod_sid FROM META.t_product_key_2 WHERE prod_key_type_cd IN ('CBX'))
        AND dwh_valid_fg
        AND TRY_CAST(prod_nr AS NUMBER) IS NOT NULL
    ) AS p
    INNER JOIN
    (
        SELECT DISTINCT
            ctrcode
          , CAST(Substring(c215_itemnr, 1, LENGTH(c215_itemnr)-4) AS NUMBER) AS itemnr
          , CAST(c215_int_itemnr AS NUMBER) AS c215_int_itemnr
        FROM ETL.t_wawi_precore_t215_int_itemnr_2
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
       src.ctrcode as  party_nat_key_nr,
       'COUNTRY_2' as int_org_key_type_cd,
       CASE WHEN src.listenknznr in ( 1, 2) THEN 1 --Normal Assortment
            WHEN src.listenknznr in (5,6) THEN 3 --Test_2 Assortment
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
      ( 
        SELECT
           src.prod_sid,
           src.prod_nr,
           src.ctrcode,
           waw.extraction_tmsp,
           waw.listenknznr
        FROM etl.t_cbx_prod_to_wawi_items AS src
        INNER JOIN etl.t_wawi_precore_artikel_2 AS waw ON  src.ctrcode = waw.ctrcode AND src.itemnr = CAST(waw.artnrvier AS NUMBER) AND waw.listenknznr IS NOT NULL
        INNER JOIN ETL.t_ctrcode_map_2 AS cm ON  waw.ctrcode = cm.ctrcode_src
        QUALIFY ROW_NUMBER() OVER (PARTITION BY cm.ctrcode_tgt, src.prod_nr ORDER BY waw.listenknznr) = 1
      )  src;




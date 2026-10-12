INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
    PROD_KEY_TYPE_CD,      --NAT_KEY_TYPE
    PROD_NR,               --NAT_KEY
    PROD_GRP_KEY_TYPE_CD,  --NAT_KEY_TYPE
    PROD_GRP_TYPE_CD,   
    PROD_GRP_NR,           --NAT_KEY    
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
    'WAWI'                                                       AS PROD_KEY_TYPE_CD,
    UPPER(ctrcode) || '|' || itemnr                              AS PROD_NR,
    'IFG'                                                        AS PROD_GRP_KEY_TYPE_CD,
    'IFG'                                                        AS PROD_GRP_TYPE_CD,
    src.ITEMGRPNR || '|' || src.FAMILY_CODE                      AS PROD_GRP_NR,
    
    -- FRAMEWORK AND TECHNICAL COLUMNS
    'WAWI_HQ'                                                    AS SOURCE_SYSTEM,
    extraction_tmsp                                              AS EXTRACTION_DT,
    extraction_tmsp                                              AS DWH_MAPPING_TMSP,
    0                                                            AS TF_ERROR_FG,
    0                                                            AS DELETED_FG,
    0                                                            AS RECORD_ID,
    't_${SRC_INPUT_TABLE}'                                       AS FILENAME,
    'WAWI_HQ'                                                    AS DWH_NODE_CD,
    '${LOAD_ID}'                                                 AS DWH_LOAD_ID 
FROM
(
   SELECT
       art.ctrcode
     , art.itemnr
     , fg.itemgrpnr
     , fg.family_code
     , itma.extraction_tmsp
   FROM
   (
       SELECT a.*
         , Cast(artnrvier AS Number) AS itemnr
       FROM ETL.t_wawi_precore_artikel AS a
       QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr ORDER BY artikelnr) = 1
   ) AS art
   LEFT OUTER JOIN
   (
       SELECT DISTINCT
           ctrcode
         , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
         , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
       FROM ETL.t_wawi_precore_t215_int_itemnr
   ) AS ii
   ON  art.ctrcode = ii.ctrcode
   AND art.itemnr = ii.itemnr
   LEFT OUTER JOIN meta.t_product_key AS ipk
   ON  Cast(ii.c215_int_itemnr AS String) = ipk.prod_nat_key_nr
   AND ipk.prod_key_type_cd IN ('CBX', 'FV')
   AND ipk.dwh_valid_fg
   LEFT OUTER JOIN
   (
       SELECT DISTINCT itemno
       FROM ETL.t_wawi_precore_eks_item_wawi_item
   ) AS eks
   ON  ii.c215_int_itemnr = eks.itemno
   INNER JOIN ETL.t_wawi_precore_t214_itemaddinfo AS itma
   ON  art.ctrcode = itma.ctrcode
   AND art.artikelnr = itma.itemnr
   INNER JOIN ETL.t_wawi_precore_t038_itemfamily AS fg
   ON  itma.ctrcode = fg.ctrcode
   AND itma.family_id = fg.family_id
   WHERE
   (
       ii.itemnr IS NULL /* No link to international item number */
       OR
       (
               ipk.prod_sid IS NULL /* International number not found in international keys */
           AND eks.itemno IS NULL
       )
   )
) SRC
;

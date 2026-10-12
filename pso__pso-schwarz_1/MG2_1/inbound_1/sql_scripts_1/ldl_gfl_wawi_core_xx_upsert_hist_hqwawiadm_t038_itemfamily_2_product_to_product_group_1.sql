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
with t038 AS
(
 SELECT src.*
 FROM LDL_WAWI_PRODUCTION.hqwawiadm.t038_itemfamily_1 src
 INNER JOIN ( SELECT wawi_instanz_kzl
                    , Rank() OVER (ORDER BY CASE WHEN wawi_instanz_kzl = 'DE' THEN 1
                                                 WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR') THEN 2
                                                 WHEN wawi_instanz_kzl = 'GR' THEN 3
                                                 WHEN wawi_instanz_kzl IN ('BG', 'CY') THEN 4
                                             END, wawi_instanz_kzl) AS eks_rank
                FROM ( SELECT DISTINCT wawi_instanz_kzl
                       FROM LDL_WAWI_PRODUCTION.hqwawiadm.t038_itemfamily_1
                       WHERE delete_fg IS NULL
                     ) AS a
            ) AS csrc
        ON  csrc.wawi_instanz_kzl = csrc.wawi_instanz_kzl
    WHERE delete_fg IS NULL
    QUALIFY csrc.eks_rank = Min(csrc.eks_rank) OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2), src.C038_FAMILY_ID --)
    --AND Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2), src.C038_FAMILY_ID 
    ORDER BY src.EXTRACTION_TMSP DESC) = 1

),
t214 AS
(
  SELECT * FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t214_itemaddinfo_1 src
  WHERE delete_fg IS NULL 
  QUALIFY Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2),src.C214_ITEMNR ORDER BY src.EXTRACTION_TMSP DESC)=1
),
t215 AS
(
  SELECT * FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr_1 src
  WHERE delete_fg IS NULL
  QUALIFY Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2), src.C215_INT_ITEMNR ORDER BY src.EXTRACTION_TMSP DESC) = 1
)
SELECT
    'WAWI'                                                       AS PROD_KEY_TYPE_CD,
    UPPER(LEFT(wawi_instanz_kzl,2)) || '|' || itemnr             AS PROD_NR,
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
       LEFT(art.wawi_instanz_kzl,2) AS wawi_instanz_kzl
     , art.itemnr
     , fg.c038_itemgrpnr AS itemgrpnr
     , fg.c038_family_code AS family_code
     , itma.extraction_tmsp
   FROM
   (
       SELECT a.*
         , Cast(artnrvier AS Number) AS itemnr
       FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_1 AS a
       WHERE delete_fg IS NULL
       QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, itemnr ORDER BY artikelnr) = 1
   ) AS art_1
   LEFT OUTER JOIN
   (
       SELECT DISTINCT
           wawi_instanz_kzl
         , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
         , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
       FROM t215       
   ) AS ii
   ON  art.wawi_instanz_kzl = ii.wawi_instanz_kzl
   AND art.itemnr = ii.itemnr
   LEFT OUTER JOIN meta.t_product_key_1 AS ipk
   ON  Cast(ii.c215_int_itemnr AS String) = ipk.prod_nat_key_nr
   AND ipk.prod_key_type_cd IN ('CBX', 'FV')
   AND ipk.dwh_valid_fg
   LEFT OUTER JOIN
   (
       SELECT DISTINCT itemno
       FROM etl.t_tcache_eks_item_wawi_item_1
   ) AS eks
   ON  ii.c215_int_itemnr = eks.itemno
   INNER JOIN t214 AS itma
   ON  art.wawi_instanz_kzl = itma.wawi_instanz_kzl
   AND art.artikelnr = itma.c214_itemnr
   INNER JOIN t038 AS fg
   ON  itma.wawi_instanz_kzl = fg.wawi_instanz_kzl
   AND itma.c214_family_id = fg.c038_family_id
   AND
   (
       ii.itemnr IS NULL /* No link to international item_1 number */
       OR
       (
               ipk.prod_sid IS NULL /* International number not found in international keys */
           AND eks.itemno IS NULL
       )
   )
) SRC
;

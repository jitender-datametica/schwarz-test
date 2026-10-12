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
WITH t451 AS
(
  SELECT * 
  FROM  ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t451_integra_masterdata_2 src
  WHERE delete_fg IS NULL
      AND CAST( src.c451_itemnr AS Number) NOT IN ( SELECT CAST( itemno AS Number)
                                                    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item_2
                                                    WHERE delete_fg IS NULL AND NOT itemgrshortdesc BETWEEN 10 AND 13
                                                    
                                                   )
  QUALIFY Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2),    src.c451_itemnr,    src.c451_subitemnr 
                            ORDER BY src.EXTRACTION_TMSP DESC ) =1

)
,t038 AS
(
 SELECT src.*
 FROM LDL_WAWI_PRODUCTION.hqwawiadm.t038_itemfamily_2 src
 INNER JOIN ( SELECT wawi_instanz_kzl
                    , Rank() OVER (ORDER BY CASE WHEN wawi_instanz_kzl = 'DE' THEN 1
                                                 WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR') THEN 2
                                                 WHEN wawi_instanz_kzl = 'GR' THEN 3
                                                 WHEN wawi_instanz_kzl IN ('BG', 'CY') THEN 4
                                             END, wawi_instanz_kzl) AS eks_rank
                FROM ( SELECT DISTINCT wawi_instanz_kzl
                       FROM LDL_WAWI_PRODUCTION.hqwawiadm.t038_itemfamily_2
                       WHERE delete_fg IS NULL
                     ) AS a
            ) AS csrc
        ON  csrc.wawi_instanz_kzl = csrc.wawi_instanz_kzl
    WHERE delete_fg IS NULL
    QUALIFY csrc.eks_rank = Min(csrc.eks_rank) OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2), src.C038_FAMILY_ID --)
    --AND Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2), src.C038_FAMILY_ID 
    ORDER BY src.EXTRACTION_TMSP DESC) = 1

)
SELECT
    'FV'                    AS PROD_KEY_TYPE_CD,
    itemno                  AS PROD_NR,
    'IFG'                   AS PROD_GRP_KEY_TYPE_CD,
    'IFG'                   AS PROD_GRP_TYPE_CD,
    sig_nr || '|' || ifg_nr AS PROD_GRP_NR,
    'WAWI_HQ'               AS SOURCE_SYSTEM,
    extraction_tmsp         AS EXTRACTION_DT,
    extraction_tmsp         AS DWH_MAPPING_TMSP,
    0                       AS TF_ERROR_FG,
    0                       AS DELETED_FG,
    0                       AS RECORD_ID,
    't_${SRC_INPUT_TABLE}'  AS FILENAME,
    'WAWI_HQ'               AS DWH_NODE_CD,
    '${LOAD_ID}'            AS DWH_LOAD_ID 
FROM
(

SELECT
    itemnr.itemnr                                                 AS itemno
  , Cast(Coalesce(eks.itemgrshortdesc, t038.c038_itemgrpnr  ) AS Number) AS sig_nr
  , Cast(Coalesce(eks.itemgroupid    , t038.c038_family_code) AS Number) AS ifg_nr
  ,      Coalesce(eks.extraction_tmsp, waw.extraction_tmsp)       AS extraction_tmsp
FROM
(
    SELECT Cast(c451_itemnr AS Number) AS itemnr
    FROM t451    
    UNION
    SELECT itemno
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item_2
    WHERE itemgrshortdesc BETWEEN 10 AND 13 AND delete_fg IS NULL
) AS itemnr
-- LEFT OUTER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item_2 AS eks
LEFT OUTER JOIN 
   ( SELECT * FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item_2
     WHERE delete_fg IS NULL
     QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1
    )
     AS eks
ON  itemnr.itemnr = eks.itemno
LEFT OUTER JOIN
(
    SELECT a.*
      , Cast(artikelnr AS Number) AS itemnr
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_2 AS a
    WHERE delete_fg IS NULL
    QUALIFY Row_Number() OVER (
        PARTITION BY itemnr
        ORDER BY CASE
            WHEN wawi_instanz_kzl = 'DE' THEN 1
            WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR') THEN 2
            WHEN wawi_instanz_kzl = 'GR' THEN 3
            WHEN wawi_instanz_kzl IN ('BG', 'CY') THEN 4
        END, wawi_instanz_kzl, artikelnr) = 1
) AS waw
ON  itemnr.itemnr = waw.itemnr
LEFT OUTER JOIN 
      (
       SELECT * FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t214_itemaddinfo_2 
       WHERE delete_fg IS NULL 
       QUALIFY Row_Number() OVER (PARTITION BY  LEFT( wawi_instanz_kzl, 2), C214_ITEMNR ORDER BY EXTRACTION_TMSP DESC) = 1
      ) AS itma
    ON  waw.wawi_instanz_kzl = itma.wawi_instanz_kzl
    AND waw.artikelnr = itma.c214_itemnr
LEFT OUTER JOIN t038
    ON  itma.wawi_instanz_kzl = t038.wawi_instanz_kzl
    AND itma.c214_family_id = t038.c038_family_id
WHERE Coalesce(eks.itemgrshortdesc, t038.c038_itemgrpnr) IS NOT NULL
AND Coalesce(eks.itemgroupid, t038.c038_family_code) IS NOT NULL

) SRC
;

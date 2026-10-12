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
  , Cast(Coalesce(eks.itemgrshortdesc, fg.itemgrpnr  ) AS Number) AS sig_nr
  , Cast(Coalesce(eks.itemgroupid    , fg.family_code) AS Number) AS ifg_nr
  ,      Coalesce(eks.extraction_tmsp, waw.extraction_tmsp)       AS extraction_tmsp
FROM
(
    SELECT Cast(c451_itemnr AS Number) AS itemnr
    FROM ETL.t_integra_precore_t451_integra_masterdata
    UNION
    SELECT itemno
    FROM ETL.t_wawi_precore_t026_wawi_item
    WHERE itemgrshortdesc BETWEEN 10 AND 13
) AS itemnr
-- LEFT OUTER JOIN ETL.t_wawi_precore_t026_wawi_item AS eks
LEFT OUTER JOIN ${TEMP_DB}.T_${SRC_INPUT_TABLE} AS eks
ON  itemnr.itemnr = eks.itemno
LEFT OUTER JOIN
(
    SELECT a.*
      , Cast(artikelnr AS Number) AS itemnr
    FROM ETL.t_wawi_precore_artikel AS a
    QUALIFY Row_Number() OVER (
        PARTITION BY itemnr
        ORDER BY CASE
            WHEN ctrcode = 'DE' THEN 1
            WHEN ctrcode NOT IN ('BG', 'CY', 'GR') THEN 2
            WHEN ctrcode = 'GR' THEN 3
            WHEN ctrcode IN ('BG', 'CY') THEN 4
        END, ctrcode, artikelnr) = 1
) AS waw
ON  itemnr.itemnr = waw.itemnr
LEFT OUTER JOIN ETL.t_wawi_precore_t214_itemaddinfo AS itma
    ON  waw.ctrcode = itma.ctrcode
    AND waw.artikelnr = itma.itemnr
LEFT OUTER JOIN ETL.t_wawi_precore_t038_itemfamily AS fg
    ON  itma.ctrcode = fg.ctrcode
    AND itma.family_id = fg.family_id
WHERE Coalesce(eks.itemgrshortdesc, fg.itemgrpnr) IS NOT NULL
AND Coalesce(eks.itemgroupid, fg.family_code) IS NOT NULL
) SRC
;

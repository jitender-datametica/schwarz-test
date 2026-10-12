INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  PROD_VARIANT_NR
, GTIN
, PROD_NR
, PROD_KEY_TYPE_CD
, PROD_VARIANT_KEY_TYPE_CD
, PROD_VARIANT_NAME
, PROD_VARIANT_TYPE_CD
, WEIGHT_BASED_FG
, LOGISTIC_VARIANT_TYPE_CD
, CASE_SIZE_CNT
, SALES_VARIANT_TYPE_CD
, SALES_VARIANT_CONTENT_MEAS
, UNIT_CNT
, UNIT_CONTENT_MEAS
, CONTENT_UOM_CD
, NON_FOOD_VARIANT_TYPE_CD
, SIZE_NAME
, STYLE_NAME
, KIND_NAME
, FRUITS_AND_VEGETABLES_CLASS_CD
, MIN_CALIBER_MEAS
, MAX_CALIBER_MEAS
, CALIBER_UOM_CD
, COUNTRY_OF_ORIGIN_NR
, COUNTRY_OF_ORIGIN_KEY_TYPE_CD
---------------------------------
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
SELECT 
prod_variant_nr,
gtin,
prod_nr,
prod_key_type_cd,
prod_variant_key_type_cd,
prod_variant_name,
prod_variant_type_cd,
weight_based_fg,
logistic_variant_type_cd,
case_size_cnt,
sales_variant_type_cd,
sales_variant_content_meas,
unit_cnt,
unit_content_meas,
content_uom_cd,
non_food_variant_type_cd,
size_name,
style_name,
kind_name,
fruits_and_vegetables_class_cd,
min_caliber_meas,
max_caliber_meas,
caliber_uom_cd,
country_of_origin_nr,
country_of_origin_key_type_cd,
---------------------------------
'FV' AS SOURCE_SYSTEM,
extraction_tmsp AS EXTRACTION_DT,
CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP,
0 AS TF_ERROR_FG,
0 AS DELETED_FG,
0 AS RECORD_ID,
't_${SRC_INPUT_TABLE}' AS FILENAME,
'WAWI_WH' AS DWH_NODE_CD,
'${LOAD_ID}' AS DWH_LOAD_ID 
FROM
(
/* FV_SLS Data*/
SELECT 
    'FV_SLS' AS prod_variant_key_type_cd
  , itm.itemnr ||'|'|| CAST (CAST (itm.subitemnr AS BIGINT) AS string) AS prod_variant_nr
  , 'FV' AS prod_key_type_cd
  , itm.itemnr AS prod_nr
  , NULL AS gtin
  , Coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_variant_name
  , 'SALES' AS prod_variant_type_cd
  , itmo.weight_based_fg
  , NULL AS logistic_variant_type_cd
  , NULL AS case_size_cnt
  , 'FV' AS sales_variant_type_cd
  , CASE WHEN Coalesce(pt1.c271_int_short /*pack_type_eks*/, pt2.c271_int_short /*pack_type_wawi*/) = 'LOSE'
         THEN Null
         ELSE eks.volume * eks.bundlefact
    END AS sales_variant_content_meas
  , CASE WHEN Coalesce(pt1.c271_int_short /*pack_type_eks*/, pt2.c271_int_short /*pack_type_wawi*/) = 'LOSE'
         THEN Null
         ELSE eks.bundlefact
    END AS unit_cnt
  , CASE WHEN Coalesce(pt1.c271_int_short /*pack_type_eks*/, pt2.c271_int_short /*pack_type_wawi*/) = 'LOSE'
         THEN Null
         ELSE eks.volume
    END AS unit_content_meas
  , CASE WHEN Coalesce(pt1.c271_int_short /*pack_type_eks*/, pt2.c271_int_short /*pack_type_wawi*/) = 'LOSE' AND itmo.weight_based_fg = 1
         THEN NULL
         WHEN Coalesce(pt1.c271_int_short /*pack_type_eks*/, pt2.c271_int_short /*pack_type_wawi*/) = 'LOSE' AND itmo.weight_based_fg = 0
         THEN 'PIECE'
         ELSE unf.c277_intunit /*unit_int_desc*/ /* Consolidation needed Stück/Piece/Kus */
    END AS content_uom_cd
  , NULL AS non_food_variant_type_cd
  , NULL AS size_name
  , NULL AS style_name
  , NULL AS kind_name
  , NullIf(itm.c451_class, '-') AS fruits_and_vegetables_class_cd
  , itm.c451_caliber_min AS min_caliber_meas
  , itm.c451_caliber_max AS max_caliber_meas
  , NullIf(itm.c451_caliber_unit, '-') AS caliber_uom_cd
  , itm.extraction_tmsp
  , CASE WHEN itm.c451_origin = '-'
         THEN Null
         ELSE replace(replace(replace(itm.c451_origin ,'. ' ,' ') ,'.') ,' ')
    END AS country_of_origin_nr
  , 'CTRY' AS country_of_origin_key_type_cd
FROM
(
    SELECT
        Cast(c451_itemnr AS Number) AS itemnr
      , Cast(c451_subitemnr AS Number) AS subitemnr
      , c451_class
      , c451_caliber_min
      , c451_caliber_max
      , c451_caliber_unit
      , c451_origin
      , extraction_tmsp
    FROM ETL.T_INTEGRA_PRECORE_T451_INTEGRA_MASTERDATA
    QUALIFY Row_Number() OVER (PARTITION BY itemnr, subitemnr
                               ORDER BY CASE
                                        WHEN ctrcode = 'DE' THEN 1
                                        WHEN ctrcode NOT IN ('BG', 'CY', 'GR') THEN 2
                                        WHEN ctrcode = 'GR' THEN 3
                                        WHEN ctrcode IN ('BG', 'CY') THEN 4
                                     END, ctrcode, wh_nr) = 1
) AS itm
LEFT OUTER JOIN ETL.t_wawi_precore_t026_wawi_item AS eks
ON  itm.itemnr = eks.itemno
LEFT OUTER JOIN ETL.t_wawi_precore_t271_packagetype AS pt1
ON  eks.ctrcode = pt1.ctrcode
AND eks.packageid = pt1.c271_packnr
LEFT OUTER JOIN (
    SELECT c277_eks_link, c277_intunit, SUBSTRING(TRIM(ctrcode),1,2) as ctrcode
    FROM ETL.t_wawi_precore_t277_unitfactors
    WHERE c277_eks_link IS NOT NULL AND c277_intunit IS NOT NULL
    QUALIFY Row_Number() OVER (PARTITION BY c277_eks_link
            ORDER BY CASE
                WHEN ctrcode = 'DE' THEN 1
                WHEN ctrcode NOT IN ('BG', 'CY', 'GR') THEN 2
                WHEN ctrcode = 'GR' THEN 3
                WHEN ctrcode IN ('BG', 'CY') THEN 4
            END, ctrcode) = 1
) AS unf
ON  eks.ctrcode = unf.ctrcode
AND eks.unitid = unf.c277_eks_link
LEFT OUTER JOIN
(
    SELECT a.*
      , Cast(artnrvier AS Number) AS itemnr
    FROM ETL.t_wawi_precore_artikel AS a
    QUALIFY Row_Number() OVER (
        PARTITION BY itemnr
        ORDER BY CASE
            WHEN ctrcode = 'DE' THEN 1
            WHEN ctrcode NOT IN ('BG', 'CY', 'GR') THEN 2
            WHEN ctrcode = 'GR' THEN 3
            WHEN ctrcode in ('BG', 'CY') THEN 4
        END, ctrcode, artikelnr) = 1
) AS waw
ON itm.itemnr = waw.itemnr
LEFT OUTER JOIN ETL.t_wawi_precore_t271_packagetype AS pt2
ON  waw.ctrcode = pt2.ctrcode
AND waw.packung = pt2.c271_packdescript
LEFT OUTER JOIN
(
    select
    ctrcode 
    ,Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) as itemnr 
    ,max (CASE WHEN gewichtsartikel = 1 THEN True ELSE gewichtsartikel END) as weight_based_fg 
    from etl.t_wawi_precore_artikelbestell 
    --where ctrcode ilike 'PL' and Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) =  1579 --Gewichtsflag
    group by ctrcode, Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number)
) AS itmo
ON  waw.ctrcode = itmo.ctrcode
AND waw.itemnr = itmo.itemnr

UNION ALL
/* FV_SLS_UNK Data*/
SELECT
    'FV_SLS_UNK' AS prod_variant_key_type_cd
  , CAST(itm.itemnr AS string) AS prod_variant_nr
  , 'FV' AS prod_key_type_cd
  , itm.itemnr AS prod_nr
  , NULL AS gtin
  , Coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_variant_name
  , 'SALES' AS prod_variant_type_cd
  , itmo.weight_based_fg
  , NULL AS logistic_variant_type_cd
  , NULL AS case_size_cnt
  , 'FV' AS sales_variant_type_cd
  , CASE WHEN Coalesce(pt1.c271_int_short /*pack_type_eks*/, pt2.c271_int_short /*pack_type_wawi*/) = 'LOSE'
         THEN Null
         ELSE eks.volume * eks.bundlefact
    END AS sales_variant_content_meas
  , CASE WHEN Coalesce(pt1.c271_int_short /*pack_type_eks*/, pt2.c271_int_short /*pack_type_wawi*/) = 'LOSE'
         THEN Null
         ELSE eks.bundlefact
    END AS unit_cnt
  , CASE WHEN Coalesce(pt1.c271_int_short /*pack_type_eks*/, pt2.c271_int_short /*pack_type_wawi*/) = 'LOSE'
         THEN Null
         ELSE eks.volume
    END AS unit_content_meas
  , CASE WHEN Coalesce(pt1.c271_int_short /*pack_type_eks*/, pt2.c271_int_short /*pack_type_wawi*/) = 'LOSE' AND itmo.weight_based_fg = 1
         THEN NULL
         WHEN Coalesce(pt1.c271_int_short /*pack_type_eks*/, pt2.c271_int_short /*pack_type_wawi*/) = 'LOSE' AND itmo.weight_based_fg = 0
         THEN 'PIECE'
         ELSE unf.c277_intunit /*unit_int_desc*/ /* Consolidation needed Stück/Piece/Kus */
    END AS content_uom_cd
  , NULL AS non_food_variant_type_cd
  , NULL AS size_name
  , NULL AS style_name
  , NULL AS kind_name
  , NULL AS fruits_and_vegetables_class_cd
  , NULL AS min_caliber_meas
  , NULL AS max_caliber_meas
  , NULL AS caliber_uom_cd
  , itm.extraction_tmsp
  , NULL AS country_of_origin_nr
  , NULL AS country_of_origin_key_type_cd
FROM
(
    SELECT itemnr, Min(extraction_tmsp) AS extraction_tmsp
    FROM
    (
        SELECT
            Cast(c451_itemnr AS Number) AS itemnr
          , c451_subitemnr
          , Min(extraction_tmsp) AS extraction_tmsp
        FROM ETL.t_integra_precore_t451_integra_masterdata
        GROUP BY 1,2
    )
    GROUP BY 1 HAVING Count(*) > 1

    UNION ALL

    SELECT itemno, extraction_tmsp
    FROM ETL.t_wawi_precore_t026_wawi_item
    WHERE itemgrshortdesc BETWEEN 10 AND 13
      AND itemno NOT IN (
            SELECT DISTINCT Cast(c451_itemnr AS Number) AS itemnr
            FROM ETL.t_integra_precore_t451_integra_masterdata
        )
) AS itm
LEFT OUTER JOIN ETL.t_wawi_precore_t026_wawi_item AS eks
ON  itm.itemnr = eks.itemno
LEFT OUTER JOIN ETL.t_wawi_precore_t271_packagetype AS pt1
ON  eks.ctrcode = pt1.ctrcode
AND eks.packageid = pt1.c271_packnr
LEFT OUTER JOIN (
    SELECT c277_eks_link, c277_intunit, substring(trim(ctrcode),1,2) as ctrcode
    FROM ETL.t277_unitfactors
    WHERE c277_eks_link IS NOT NULL AND c277_intunit IS NOT NULL
    QUALIFY Row_Number() OVER (PARTITION BY c277_eks_link
            ORDER BY CASE
                WHEN ctrcode = 'DE' THEN 1
                WHEN ctrcode NOT IN ('BG', 'CY', 'GR') THEN 2
                WHEN ctrcode = 'GR' THEN 3
                WHEN ctrcode IN ('BG', 'CY') THEN 4
            END, ctrcode) = 1
) AS unf
ON  eks.ctrcode = unf.ctrcode
AND eks.unitid = unf.c277_eks_link
LEFT OUTER JOIN
(
    SELECT a.*
      , Cast(artnrvier AS Number) AS itemnr
    FROM ETL.t_wawi_precore_artikel AS a
    QUALIFY Row_Number() OVER (
        PARTITION BY itemnr
        ORDER BY CASE
            WHEN ctrcode = 'DE' THEN 1
            WHEN ctrcode NOT IN ('BG', 'CY', 'GR') THEN 2
            WHEN ctrcode = 'GR' THEN 3
            WHEN ctrcode in ('BG', 'CY') THEN 4
        END, ctrcode, artikelnr) = 1
) AS waw
ON itm.itemnr = waw.itemnr
LEFT OUTER JOIN ETL.t_wawi_precore_t271_packagetype AS pt2
ON  waw.ctrcode = pt2.ctrcode
AND waw.packung = pt2.c271_packdescript
LEFT OUTER JOIN
(
    select
    ctrcode 
    ,Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) as itemnr 
    ,max (CASE WHEN gewichtsartikel = 1 THEN True ELSE gewichtsartikel END) as weight_based_fg 
    from etl.t_wawi_precore_artikelbestell 
    --where ctrcode ilike 'PL' and Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) =  1579 --Gewichtsflag
    group by ctrcode, Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number)
) AS itmo
ON  waw.ctrcode = itmo.ctrcode
AND waw.itemnr = itmo.itemnr

UNION ALL
/* FV_LOG Data*/
SELECT
    'FV_LOG' AS prod_variant_key_type_cd
  , itm.itemnr ||'|'|| CAST (CAST (itm.subitemnr AS BIGINT) AS string) AS prod_variant_nr
  , 'FV' AS prod_key_type_cd
  , itm.itemnr AS prod_nr
  , NULL AS gtin
  , Coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_variant_name
  , 'LOGISTIC' AS prod_variant_type_cd
  , FALSE AS weight_based_fg
  , 'SINGLE' AS logistic_variant_type_cd
  , NULL AS case_size_cnt
  , NULL AS sales_variant_type_cd
  , NULL AS sales_variant_content_meas
  , NULL AS unit_cnt
  , NULL AS unit_content_meas
  , NULL AS content_uom_cd
  , NULL AS non_food_variant_type_cd
  , NULL AS size_name
  , NULL AS style_name
  , NULL AS kind_name
  , NULL AS fruits_and_vegetables_class_cd
  , NULL AS min_caliber_meas
  , NULL AS max_caliber_meas
  , NULL AS caliber_uom_cd
  , itm.extraction_tmsp
  , NULL AS country_of_origin_nr
  , NULL AS country_of_origin_key_type_cd
FROM
(
    SELECT
        Cast(c451_itemnr AS Number) AS itemnr
      , Cast(c451_subitemnr AS Number) AS subitemnr
      , extraction_tmsp
    FROM ETL.T_INTEGRA_PRECORE_T451_INTEGRA_MASTERDATA
    QUALIFY Row_Number() OVER (PARTITION BY itemnr, subitemnr
                               ORDER BY CASE
                                        WHEN ctrcode = 'DE' THEN 1
                                        WHEN ctrcode NOT IN ('BG', 'CY', 'GR') THEN 2
                                        WHEN ctrcode = 'GR' THEN 3
                                        WHEN ctrcode IN ('BG', 'CY') THEN 4
                                     END, ctrcode, wh_nr) = 1

) AS itm
LEFT OUTER JOIN ETL.t_wawi_precore_t026_wawi_item AS eks
ON  itm.itemnr = eks.itemno
LEFT OUTER JOIN
(
    SELECT a.*
      , Cast(artnrvier AS Number) AS itemnr
    FROM ETL.t_wawi_precore_artikel AS a
    QUALIFY Row_Number() OVER (
        PARTITION BY itemnr
        ORDER BY CASE
            WHEN ctrcode = 'DE' THEN 1
            WHEN ctrcode NOT IN ('BG', 'CY', 'GR') THEN 2
            WHEN ctrcode = 'GR' THEN 3
            WHEN ctrcode in ('BG', 'CY') THEN 4
        END, ctrcode, artikelnr) = 1
) AS waw
ON itm.itemnr = waw.itemnr

UNION ALL
/* FV_LOG_UNK Data*/
SELECT
    'FV_LOG_UNK' AS prod_variant_key_type_cd
  , CAST(itm.itemnr AS string) AS prod_variant_nr
  , 'FV' AS prod_key_type_cd
  , itm.itemnr AS prod_nr
  , NULL AS gtin
  , Coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_variant_name
  , 'LOGISTIC' AS prod_variant_type_cd
  , NULL AS weight_based_fg
  , 'SINGLE' AS logistic_variant_type_cd
  , 1 AS case_size_cnt
  , NULL AS sales_variant_type_cd
  , NULL AS sales_variant_content_meas
  , NULL AS unit_cnt
  , NULL AS unit_content_meas
  , NULL AS content_uom_cd
  , NULL AS non_food_variant_type_cd
  , NULL AS size_name
  , NULL AS style_name
  , NULL AS kind_name
  , NULL AS fruits_and_vegetables_class_cd
  , NULL AS min_caliber_meas
  , NULL AS max_caliber_meas
  , NULL AS caliber_uom_cd
  , itm.extraction_tmsp
  , NULL AS country_of_origin_nr
  , NULL AS country_of_origin_key_type_cd
FROM
(
    SELECT itemnr, Min(extraction_tmsp) AS extraction_tmsp
    FROM
    (
        SELECT
            Cast(c451_itemnr AS Number) AS itemnr
          , c451_subitemnr
          , Min(extraction_tmsp) AS extraction_tmsp
        FROM ETL.T_INTEGRA_PRECORE_T451_INTEGRA_MASTERDATA
        GROUP BY 1,2
    )
    GROUP BY 1 HAVING Count(*) > 1

    UNION ALL

    SELECT itemno, extraction_tmsp
    FROM ETL.t_wawi_precore_t026_wawi_item
    WHERE itemgrshortdesc BETWEEN 10 AND 13
      AND itemno NOT IN (
            SELECT DISTINCT Cast(c451_itemnr AS Number) AS itemnr
            FROM ETL.t_integra_precore_t451_integra_masterdata
        )
) AS itm
LEFT OUTER JOIN ETL.t_wawi_precore_t026_wawi_item AS eks
ON  itm.itemnr = eks.itemno
LEFT OUTER JOIN
(
    SELECT a.*
      , Cast(artnrvier AS Number) AS itemnr
    FROM ETL.t_wawi_precore_artikel AS a
    QUALIFY Row_Number() OVER (
        PARTITION BY itemnr
        ORDER BY CASE
            WHEN ctrcode = 'DE' THEN 1
            WHEN ctrcode NOT IN ('BG', 'CY', 'GR') THEN 2
            WHEN ctrcode = 'GR' THEN 3
            WHEN ctrcode in ('BG', 'CY') THEN 4
        END, ctrcode, artikelnr) = 1
) AS waw
ON itm.itemnr = waw.itemnr
)
;

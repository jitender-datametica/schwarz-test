CREATE OR REPLACE TEMPORARY TABLE ETL.WAWI_ITEMS_WITH_DELETION_RANGE as 
(
    WITH wawi_items_with_deleted_dt AS (
    /* Already deleted items */
    SELECT DISTINCT
        ctrcode
      , CASE WHEN Length(c920_itemnr_short) = 11 /* orig_item_nr(7) || case_size(4) */
                  THEN Try_Cast(Substring(c920_itemnr_short, 1, 7) as Number)
                  ELSE Coalesce(
                           Try_Cast(c920_itemnr_short AS Number)
                         , Try_Cast(LTrim(LTrim(c920_itemnr_short, '0'), ' ') AS Number) --?
                       )
        END AS orig_item_nr
      , c920_moddate::Date AS deleted_dt,
      null as min_gueltig_ab
    FROM etl.t_wawi_precore_t920_delitems_1
    WHERE Coalesce(
                  Try_Cast(c920_itemnr_short AS Number)
                , Try_Cast(LTrim(LTrim(c920_itemnr_short, '0'), ' ') AS Number) --?
          ) IS NOT NULL
    UNION ALL
    /* Currently active items */
    SELECT 
        ctrcode
      , artnrvier::Number AS orig_item_nr
      , DATE'9999-12-31' AS deleted_dt
      ,min(gueltig_ab) AS min_gueltig_ab
    FROM etl.t_wawi_precore_artikel_1
    group by 1,2
)
, wawi_items_with_deleted_dt_cses AS (
    /* For item_1 numbers existing in both CS and ES, use only the part from ES -- removed */
    SELECT *
    FROM wawi_items_with_deleted_dt
    /*QUALIFY Max(ctrcode) OVER (PARTITION BY CASE WHEN ctrcode = 'CS' THEN 'ES' ELSE ctrcode END
                                          , orig_item_nr)
            = ctrcode*/
)
, wawi_items_with_range AS (
    SELECT
        ctrcode
      , orig_item_nr
      , Coalesce(
            Lag(deleted_dt) OVER (PARTITION BY ctrcode, orig_item_nr ORDER BY deleted_dt) + 1
          , DATE'1900-01-01'
        ) AS wawi_item_prev_deleted_dt
      , deleted_dt AS wawi_item_deleted_dt
      ,min_gueltig_ab
    FROM wawi_items_with_deleted_dt_cses AS wi
)
SELECT del.*,
CASE WHEN ctrcode='CS' THEN 'ES' ELSE ctrcode END AS country_1,
prev_keys.wawi_item_nat_key_nr, prev_keys.dwh_valid_from_tmsp as prev_dwh_valid_from_tmsp
FROM wawi_items_with_range AS del 
LEFT JOIN META.T_WAWI_ITEM_KEY_1 prev_keys ON--check if key already exists
country_1=split_part(prev_keys.wawi_item_nat_key_nr,'|',1)
and del.orig_item_nr=split_part(prev_keys.wawi_item_nat_key_nr,'|',2)
and prev_keys.dwh_valid_fg=1
qualify row_number() over (partition by country_1,orig_item_nr,wawi_item_deleted_dt order by ctrcode desc)=1
);


--If an item_1 is existing in previous Meta table with valid_from less than last deleted date, and comes in new artikel_1 source with gueltig_ab greater than last deleted dt, generate new sid
CREATE OR REPLACE TEMPORARY TABLE ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_KEYS 
AS 
(
SELECT 
COUNTRY_1,
orig_item_nr,
min_gueltig_ab
FROM
ETL.WAWI_ITEMS_WITH_DELETION_RANGE 
WHERE  wawi_item_deleted_dt='9999-12-31' 
AND (
      wawi_item_nat_key_nr IS NULL --completely new items
      OR  (wawi_item_prev_deleted_dt<>'1900-01-01' --the last deletion date is not null 
          and min_gueltig_ab>wawi_item_prev_deleted_dt --gueltig_ab bigger than last deletion date
            AND wawi_item_prev_deleted_dt>=prev_dwh_valid_from_tmsp)--the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT_1 dwh_valid_from (gueltig_ab)
    )
);

--If an item_1 variant is existing in previous Meta table with valid_from less than last deleted date, and comes in new artikel_1 source with gueltig_ab greater than last deleted dt, generate new sid
CREATE OR REPLACE TEMPORARY TABLE ETL.T_WAWI_PRECORE_ITEM_VARIANT_TEMP AS 
(
SELECT CASE WHEN a.ctrcode='CS' THEN 'ES' ELSE a.ctrcode END AS country_es_cs, CAST(artnrvier AS Number) AS itemnr, try_cast(RIGHT(artikelnr,4) as number) as src_case_size,
country_es_cs || '|' || itemnr || '|' || src_case_size  as wawi_item_variant_nat_key_nr,
a.* , wawi_item_prev_deleted_dt, wawi_item_deleted_dt
    FROM ETL.t_wawi_precore_artikel_1 AS a
INNER JOIN ETL.WAWI_ITEMS_WITH_DELETION_RANGE b on country_es_cs=b.country_1 and itemnr=b.orig_item_nr and b.wawi_item_deleted_dt='9999-12-31' --filter to pick only the correct ES/CS items
        QUALIFY Row_Number() OVER (PARTITION BY country_es_cs || '|' || itemnr || '|' || src_case_size ORDER BY  a.ctrcode desc, artikelnr ASC, extraction_tmsp DESC ) = 1 --pick the latest data. Chose ES variant over CS variant. The sorting by artikelnr is for the code to always pick the same item_1 variant
)
;


CREATE OR REPLACE TEMPORARY TABLE ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_VARIANT_KEYS 
AS 
(
SELECT 
A.wawi_item_variant_nat_key_nr,
A.gueltig_ab
FROM
ETL.T_WAWI_PRECORE_ITEM_VARIANT_TEMP A
LEFT JOIN META.T_WAWI_ITEM_VARIANT_KEY_1 prev_keys 
ON 
country_es_cs=split_part(prev_keys.wawi_item_variant_nat_key_nr,'|',1)
AND A.itemnr=split_part(prev_keys.wawi_item_variant_nat_key_nr,'|',2)
AND A.src_case_size=split_part(prev_keys.wawi_item_variant_nat_key_nr,'|',3)
AND prev_keys.dwh_valid_fg=1
WHERE  wawi_item_deleted_dt='9999-12-31' 
AND (
      prev_keys.wawi_item_variant_nat_key_nr IS NULL --completely new item_1 variants
      OR  (A.wawi_item_prev_deleted_dt<>'1900-01-01' --the last deletion date is not null 
          AND gueltig_ab>A.wawi_item_prev_deleted_dt --gueltig_ab bigger than last deletion date
            AND A.wawi_item_prev_deleted_dt>=prev_keys.dwh_valid_from_tmsp)--the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT_1 dwh_valid_from (gueltig_ab)
    )
);

BEGIN TRANSACTION;

DELETE FROM  META.T_WAWI_ITEM_KEY_1 x
WHERE 1=2;--lock the whole table

DELETE FROM  META.T_WAWI_ITEM_VARIANT_KEY_1 x
WHERE 1=2;--lock the whole table

UPDATE META.T_WAWI_ITEM_KEY_1 x  --should produce 0, the keys should be already generated by xx_upsert_hist_wawi_precore_artikel_2_wawi_item.pset
SET dwh_valid_fg=FALSE,
dwh_valid_to_tmsp=DATEADD(nanosecond,-1,y.min_gueltig_ab),
dwh_updated_tmsp=current_timestamp,
dwh_load_id= ${LOAD_ID}, 
dwh_node_cd='WAWI_HQ'
FROM ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_KEYS y
WHERE y.country_1||'|'||y.orig_item_nr=x.wawi_item_nat_key_nr and dwh_valid_fg=TRUE;




INSERT INTO META.T_WAWI_ITEM_KEY_1 
SELECT
max_sid+ROW_NUMBER() over (ORDER BY y.country_1||'|'||y.orig_item_nr) AS wawi_item_sid,
'WAWI',
Y.min_gueltig_ab,
To_Timestamp_LTZ('9999-12-31 23:59:59.999999999'),
TRUE,
Y.country_1||'|'||y.orig_item_nr,
current_timestamp,
current_timestamp, 
${LOAD_ID}, 
'WAWI_HQ'
FROM ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_KEYS Y
CROSS JOIN (SELECT MAX(wawi_item_sid) max_sid FROM META.T_WAWI_ITEM_KEY_1) Z;


UPDATE META.T_WAWI_ITEM_VARIANT_KEY_1 x  
SET dwh_valid_fg=FALSE,
dwh_valid_to_tmsp=DATEADD(nanosecond,-1,y.gueltig_ab),
dwh_updated_tmsp=current_timestamp,
dwh_load_id=${LOAD_ID} , 
dwh_node_cd='WAWI_HQ'
FROM ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_VARIANT_KEYS y
WHERE y.wawi_item_variant_nat_key_nr=x.wawi_item_variant_nat_key_nr and dwh_valid_fg=TRUE;

INSERT INTO META.T_WAWI_ITEM_VARIANT_KEY_1 
SELECT
max_sid+ROW_NUMBER() over (order by y.wawi_item_variant_nat_key_nr) AS wawi_item_variant_sid ,
'WAWI',
Y.gueltig_ab,
To_Timestamp_LTZ('9999-12-31 23:59:59.999999999'),
TRUE,
wawi_item_variant_nat_key_nr,
current_timestamp,
current_timestamp, 
${LOAD_ID}, 
'WAWI_HQ'
FROM ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_VARIANT_KEYS  Y
CROSS JOIN (SELECT MAX(wawi_item_variant_sid) max_sid FROM META.T_WAWI_ITEM_VARIANT_KEY_1) Z
;

COMMIT;






INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
 (
          WAWI_ITEM_NAT_KEY_NR,
        WAWI_ITEM_KEY_TYPE_CD ,
        WAWI_ITEM_VARIANT_KEY_TYPE_CD,
        WAWI_ITEM_VARIANT_NAT_KEY_NR ,
        country_org_nat_key  ,
        COUNTRY_ORG_KEY_TYPE_CD,
        COUNTRY_ORG_CD ,
        wawi_item_variant_nr ,
        wawi_item_variant_name ,
        wawi_item_variant_descr ,
        wawi_item_variant_creation_dt,
        case_size_cnt  ,
        weight_based_fg  ,
        -- FRAMEWORK AND TECHNICAL COLUMNS
        SOURCE_SYSTEM ,
        EXTRACTION_DT ,
        DWH_MAPPING_TMSP ,
        TF_ERROR_FG ,
        DELETED_FG ,
        RECORD_ID ,
        FILENAME ,
        DWH_NODE_CD ,
        DWH_LOAD_ID 
)

SELECT
    art.country_es_cs || '|' || LTRIM(artnrvier,'0')  WAWI_ITEM_NAT_KEY_NR,
  'WAWI' WAWI_ITEM_KEY_TYPE_CD,
  'WAWI' WAWI_ITEM_VARIANT_KEY_TYPE_CD,
  art.country_es_cs || '|' || itemnr || '|' || src_case_size as WAWI_ITEM_VARIANT_NAT_KEY_NR,
art.country_es_cs as country_org_nat_key,
  'COUNTRY_1' as COUNTRY_ORG_KEY_TYPE_CD,
  art.country_es_cs as COUNTRY_ORG_CD ,
  art.artikelnr as wawi_item_variant_nr,
   TRIM(COALESCE(deutschtext,bez_lang,'Unbekannt')) as wawi_item_variant_name,
  TRIM(art.bez_lang) as wawi_item_variant_descr,
  gueltig_ab   as  wawi_item_variant_creation_dt,  
  RIGHT(art.artikelnr, 4) as case_size_cnt,
  coalesce(itmo.weight_based_fg,0) as weight_based_fg,--?
 --------------------------------
  'WAWI' source_system,
  art.extraction_tmsp extraction_dt,
  art.extraction_tmsp dwh_mapping_tmsp,
  0 tf_error_fg,
  0 deleted_fg,
  0 record_id,
  '${SRC_INPUT_TABLE}' filename,
  'WAWI_HQ' dwh_node_cd,
  '${LOAD_ID}' dwh_load_id
FROM ${TEMP_DB}.T_WAWI_PRECORE_ITEM_VARIANT_TEMP AS art_1
LEFT JOIN (
            select
            ctrcode
            ,Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) as artikelnr
            ,max (CASE WHEN gewichtsartikel = 1 THEN True ELSE gewichtsartikel END) as weight_based_fg
            from ${TEMP_DB}.t_wawi_precore_artikelbestell_1
            group by ctrcode, Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number)
           ) AS itmo
 ON art.ctrcode = itmo.ctrcode AND art.itemnr= itmo.artikelnr
;



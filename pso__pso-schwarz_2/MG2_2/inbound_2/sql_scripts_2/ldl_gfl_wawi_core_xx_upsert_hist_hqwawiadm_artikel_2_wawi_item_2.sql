CREATE OR REPLACE TEMPORARY TABLE ETL.WAWI_ITEMS_WITH_DELETION_RANGE as
(
    WITH wawi_items_with_deleted_dt AS (
    /* Already deleted items */
    SELECT DISTINCT
        LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
      , CASE WHEN Length(c920_itemnr_short) = 11 /* orig_item_nr(7) || case_size(4) */
                  THEN Try_Cast(Substring(c920_itemnr_short, 1, 7) as Number)
                  ELSE Coalesce(
                           Try_Cast(c920_itemnr_short AS Number)
                         , Try_Cast(LTrim(LTrim(c920_itemnr_short, '0'), ' ') AS Number) --?
                       )
        END AS orig_item_nr
      , c920_moddate::Date AS deleted_dt,
      null as min_gueltig_ab
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t920_delitems_2
    WHERE Coalesce(
                  Try_Cast(c920_itemnr_short AS Number)
                , Try_Cast(LTrim(LTrim(c920_itemnr_short, '0'), ' ') AS Number) --?
          ) IS NOT NULL AND delete_fg IS NULL
    UNION ALL
    /* Currently active items */
    SELECT
        LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
      , artnrvier::Number AS orig_item_nr
      , DATE'9999-12-31' AS deleted_dt
      ,min(gueltig_ab) AS min_gueltig_ab
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_2
    group by 1,2
)
, wawi_items_with_deleted_dt_cses AS (
    /* For item_2 numbers existing in both CS and ES, use only the part from ES -- removed */
    SELECT *
    FROM wawi_items_with_deleted_dt
    /*QUALIFY Max(wawi_instanz_kzl) OVER (PARTITION BY CASE WHEN wawi_instanz_kzl = 'CS' THEN 'ES' ELSE wawi_instanz_kzl END
                                          , orig_item_nr)
            = wawi_instanz_kzl*/
)
, wawi_items_with_range AS (
    SELECT
        LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
      , orig_item_nr
      , Coalesce(
            Lag(deleted_dt) OVER (PARTITION BY wawi_instanz_kzl, orig_item_nr ORDER BY deleted_dt) + 1
          , DATE'1900-01-01'
        ) AS wawi_item_prev_deleted_dt
      , deleted_dt AS wawi_item_deleted_dt
      ,min_gueltig_ab
    FROM wawi_items_with_deleted_dt_cses AS wi
)
SELECT del.*,
CASE WHEN wawi_instanz_kzl='CS' THEN 'ES' ELSE LEFT(wawi_instanz_kzl,2) END AS country_2,
prev_keys.wawi_item_nat_key_nr, prev_keys.dwh_valid_from_tmsp as prev_dwh_valid_from_tmsp
FROM wawi_items_with_range AS del
LEFT JOIN META.T_WAWI_ITEM_KEY_2 prev_keys ON--check if key already exists
country_2=split_part(prev_keys.wawi_item_nat_key_nr,'|',1)
and del.orig_item_nr=split_part(prev_keys.wawi_item_nat_key_nr,'|',2)
and prev_keys.dwh_valid_fg=1
qualify row_number() over (partition by country_2,orig_item_nr,wawi_item_deleted_dt order by wawi_instanz_kzl desc)=1
);


--If an item_2 is existing in previous Meta table with valid_from less than last deleted date, and comes in new artikel_2 source with gueltig_ab greater than last deleted dt, generate new sid
CREATE OR REPLACE TEMPORARY TABLE ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_KEYS
AS
(
SELECT
COUNTRY_2,
orig_item_nr,
min_gueltig_ab,
(wawi_item_nat_key_nr IS NULL) AS first_instance_fg --First instance of a NK will get additionally the 1900-01-01 record
FROM
ETL.WAWI_ITEMS_WITH_DELETION_RANGE
WHERE  wawi_item_deleted_dt='9999-12-31'
AND (
      wawi_item_nat_key_nr IS NULL --completely new items
      OR  (wawi_item_prev_deleted_dt<>'1900-01-01' --the last deletion date is not null
          and min_gueltig_ab>wawi_item_prev_deleted_dt --gueltig_ab bigger than last deletion date
            AND wawi_item_prev_deleted_dt>=prev_dwh_valid_from_tmsp)--the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT_2 dwh_valid_from (gueltig_ab)
    )
);

--If an item_2 has already arrived from master data and its SID was generated outside of WAWI-item_2 transformation,
--we continue to use already generated SID
CREATE OR REPLACE TEMPORARY TABLE ETL.WAWI_ITEM_DUMMY_KEY_UPD
AS
(
    SELECT
        wik.wawi_item_sid,
        wik.wawi_item_key_type_cd,
        CASE WHEN seq.seq_num = 0
                 THEN To_Timestamp_LTZ('1900-01-01 00:00:00.000000000')
                 ELSE wi.min_gueltig_ab
        END AS dwh_valid_from_tmsp,
        CASE WHEN seq.seq_num = 0
                 THEN TimestampAdd(ns, -1, wi.min_gueltig_ab)
                 ELSE To_Timestamp_LTZ('9999-12-31 23:59:59.999999999')
        END AS dwh_valid_to_tmsp,
        (seq.seq_num = 1) AS dwh_valid_fg,
        wik.wawi_item_nat_key_nr
    FROM ETL.WAWI_ITEMS_WITH_DELETION_RANGE AS wi
    INNER JOIN meta.t_wawi_item_key_2 AS wik
    ON  wi.country_2 || '|' || wi.orig_item_nr = wik.wawi_item_nat_key_nr
    AND wik.wawi_item_key_type_cd = 'WAWI'
    AND wik.dwh_valid_fg = True
    INNER JOIN core_rel.t_wawi_item_2 AS i
    ON  wik.wawi_item_sid = i.wawi_item_sid
    AND i.dwh_valid_fg = True
    AND i.wawi_item_creation_dt = DATE'1900-01-01'
    CROSS JOIN
    (
        SELECT seq_num
        FROM
        (
            VALUES
            (0)
          , (1)
        ) AS a (seq_num)
    ) AS seq
);

--If an item_2 variant is existing in previous Meta table with valid_from less than last deleted date, and comes in new artikel_2 source with gueltig_ab greater than last deleted dt, generate new sid
CREATE OR REPLACE TEMPORARY TABLE ETL.T_WAWI_PRECORE_ITEM_VARIANT_TEMP AS
(
SELECT CASE WHEN a.wawi_instanz_kzl='CS' THEN 'ES' ELSE LEFT(a.wawi_instanz_kzl,2) END AS country_es_cs, CAST(artnrvier AS Number) AS itemnr, try_cast(RIGHT(artikelnr,4) as number) as src_case_size,
country_es_cs || '|' || itemnr || '|' || src_case_size  as wawi_item_variant_nat_key_nr,
a.* , wawi_item_prev_deleted_dt, wawi_item_deleted_dt
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_2 AS a
INNER JOIN ETL.WAWI_ITEMS_WITH_DELETION_RANGE b on country_es_cs=b.country_2 and itemnr=b.orig_item_nr and b.wawi_item_deleted_dt='9999-12-31' --filter to pick only the correct ES/CS items
        QUALIFY Row_Number() OVER (PARTITION BY country_es_cs || '|' || itemnr || '|' || src_case_size ORDER BY  a.wawi_instanz_kzl desc, artikelnr ASC, extraction_tmsp DESC ) = 1 --pick the latest data. Chose ES variant over CS variant. The sorting by artikelnr is for the code to always pick the same item_2 variant
)
;


CREATE OR REPLACE TEMPORARY TABLE ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_VARIANT_KEYS
AS
(
SELECT
A.wawi_item_variant_nat_key_nr,
A.gueltig_ab,
--First instance of a NK will get additionally the 1900-01-01 record
(prev_keys.wawi_item_variant_nat_key_nr IS NULL) AS first_instance_fg,
--Variant with lowest case size will use the dummy_2 SID if it exists
(dvk.wawi_item_variant_sid IS NOT NULL
 AND Row_Number() OVER (PARTITION BY A.country_es_cs, A.itemnr ORDER BY A.src_case_size) = 1
) AS dummy_sid_reuse_fg,
CASE WHEN Row_Number() OVER (PARTITION BY A.country_es_cs, A.itemnr ORDER BY A.src_case_size) = 1
          THEN dvk.wawi_item_variant_sid
          ELSE Null
END AS wawi_item_variant_sid
FROM
ETL.T_WAWI_PRECORE_ITEM_VARIANT_TEMP A
LEFT JOIN META.T_WAWI_ITEM_VARIANT_KEY_2 prev_keys
ON
country_es_cs=split_part(prev_keys.wawi_item_variant_nat_key_nr,'|',1)
AND A.itemnr=split_part(prev_keys.wawi_item_variant_nat_key_nr,'|',2)
AND A.src_case_size=split_part(prev_keys.wawi_item_variant_nat_key_nr,'|',3)
AND prev_keys.dwh_valid_fg=1
LEFT JOIN ETL.WAWI_ITEM_DUMMY_KEY_UPD dik
ON
A.country_es_cs || '|' || A.itemnr = dik.wawi_item_nat_key_nr
AND dik.dwh_valid_fg = True
LEFT OUTER JOIN META.T_WAWI_ITEM_VARIANT_KEY_2 dvk
ON
dik.wawi_item_nat_key_nr || '|0' = dvk.wawi_item_variant_nat_key_nr
AND dvk.dwh_valid_fg = True
WHERE  wawi_item_deleted_dt='9999-12-31'
AND (
      prev_keys.wawi_item_variant_nat_key_nr IS NULL --completely new item_2 variants
      OR  (A.wawi_item_prev_deleted_dt<>'1900-01-01' --the last deletion date is not null
          AND gueltig_ab>A.wawi_item_prev_deleted_dt --gueltig_ab bigger than last deletion date
            AND A.wawi_item_prev_deleted_dt>=prev_keys.dwh_valid_from_tmsp)--the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT_2 dwh_valid_from (gueltig_ab)
    )
);

BEGIN TRANSACTION;

DELETE FROM  META.T_WAWI_ITEM_KEY_2 x
WHERE 1=2;--lock the whole table

DELETE FROM  META.T_WAWI_ITEM_VARIANT_KEY_2 x
WHERE 1=2;--lock the whole table

-- Keep using the dummy_2 generated SID in case when the NK (country_2, itemnr) is delivered in item_2 data
MERGE INTO META.T_WAWI_ITEM_KEY_2 AS tgt
USING ETL.WAWI_ITEM_DUMMY_KEY_UPD AS src
ON  tgt.wawi_item_sid = src.wawi_item_sid
AND tgt.dwh_valid_from_tmsp = src.dwh_valid_from_tmsp
WHEN MATCHED THEN UPDATE SET
    dwh_valid_to_tmsp = src.dwh_valid_to_tmsp
  , dwh_valid_fg = src.dwh_valid_fg
  , dwh_updated_tmsp = current_timestamp
  , dwh_load_id = ${LOAD_ID}
WHEN NOT MATCHED THEN INSERT
(
    wawi_item_sid,
    wawi_item_key_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    wawi_item_nat_key_nr,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
)
VALUES
(
    src.wawi_item_sid,
    src.wawi_item_key_type_cd,
    src.dwh_valid_from_tmsp,
    src.dwh_valid_to_tmsp,
    src.dwh_valid_fg,
    src.wawi_item_nat_key_nr,
    current_timestamp,
    current_timestamp,
    ${LOAD_ID},
    'WAWI_HQ'
);

UPDATE META.T_WAWI_ITEM_KEY_2 x  --should produce 0, the keys should be already generated by xx_upsert_hist_wawi_precore_artikel_2_wawi_item.pset
SET dwh_valid_fg=FALSE,
dwh_valid_to_tmsp=DATEADD(nanosecond,-1,y.min_gueltig_ab),
dwh_updated_tmsp=current_timestamp,
dwh_load_id= ${LOAD_ID},
dwh_node_cd='WAWI_HQ'
FROM ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_KEYS y
WHERE y.country_2||'|'||y.orig_item_nr=x.wawi_item_nat_key_nr AND dwh_valid_fg=TRUE;

INSERT INTO META.T_WAWI_ITEM_KEY_2
(
    wawi_item_sid,
    wawi_item_key_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    wawi_item_nat_key_nr,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
)
SELECT
src.wawi_item_sid,
'WAWI',
CASE WHEN seq.seq_num = 0
         THEN To_Timestamp_LTZ('1900-01-01 00:00:00.000000000')
         ELSE src.min_gueltig_ab
END,
CASE WHEN seq.seq_num = 0
         THEN TimestampAdd(ns, -1, src.min_gueltig_ab)
         ELSE To_Timestamp_LTZ('9999-12-31 23:59:59.999999999')
END,
(seq.seq_num = 1),
src.country_2||'|'||src.orig_item_nr,
current_timestamp,
current_timestamp,
${LOAD_ID},
'WAWI_HQ'
FROM
(
        -- First generate new SIDs
        SELECT
        max_sid+ROW_NUMBER() OVER (ORDER BY y.country_2||'|'||y.orig_item_nr) AS wawi_item_sid,
        y.country_2,
        y.min_gueltig_ab,
        y.orig_item_nr,
        y.first_instance_fg
        FROM ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_KEYS AS Y
        CROSS JOIN (SELECT MAX(wawi_item_sid) max_sid FROM META.T_WAWI_ITEM_KEY_2) AS Z
) AS src
-- Then join to add the initial line starting from 1900 if needed
INNER JOIN
(
    SELECT seq_num
    FROM
    (
        VALUES
        (0)
      , (1)
    ) AS a (seq_num)
) AS seq
ON  src.first_instance_fg = True
OR  seq.seq_num = 1
;


-- Use the SID given to the dummy_2 variant for the variant with lowest case size
-- when item_2 is delivered
UPDATE META.T_WAWI_ITEM_VARIANT_KEY_2 AS tgt
SET dwh_valid_fg = False,
    dwh_valid_to_tmsp=DATEADD(nanosecond,-1,src.gueltig_ab),
    wawi_item_variant_nat_key_nr = src.wawi_item_variant_nat_key_nr,
    dwh_updated_tmsp=current_timestamp,
    dwh_load_id= ${LOAD_ID}
FROM ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_VARIANT_KEYS AS src
WHERE tgt.wawi_item_variant_sid = src.wawi_item_variant_sid
  AND src.dummy_sid_reuse_fg = True
;

INSERT INTO META.T_WAWI_ITEM_VARIANT_KEY_2
(
    wawi_item_variant_sid,
    wawi_item_variant_key_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    wawi_item_variant_nat_key_nr,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
)
SELECT
    wawi_item_variant_sid,
    'WAWI',
    gueltig_ab,
    To_Timestamp_LTZ('9999-12-31 23:59:59.999999999'),
    True,
    wawi_item_variant_nat_key_nr,
    current_timestamp,
    current_timestamp,
    ${LOAD_ID},
    'WAWI_HQ'
FROM ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_VARIANT_KEYS
WHERE dummy_sid_reuse_fg = True
;

UPDATE META.T_WAWI_ITEM_VARIANT_KEY_2 x
SET dwh_valid_fg=FALSE,
dwh_valid_to_tmsp=DATEADD(nanosecond,-1,y.gueltig_ab),
dwh_updated_tmsp=current_timestamp,
dwh_load_id=${LOAD_ID} ,
dwh_node_cd='WAWI_HQ'
FROM ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_VARIANT_KEYS y
WHERE y.wawi_item_variant_nat_key_nr=x.wawi_item_variant_nat_key_nr
  AND x.dwh_valid_fg=TRUE
  AND y.dummy_sid_reuse_fg=FALSE
;

INSERT INTO META.T_WAWI_ITEM_VARIANT_KEY_2
(
    wawi_item_variant_sid,
    wawi_item_variant_key_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    wawi_item_variant_nat_key_nr,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
)
SELECT
src.wawi_item_variant_sid,
'WAWI',
CASE WHEN seq.seq_num = 0
         THEN To_Timestamp_LTZ('1900-01-01 00:00:00.000000000')
         ELSE src.gueltig_ab
END,
CASE WHEN seq.seq_num = 0
         THEN TimestampAdd(ns, -1, src.gueltig_ab)
         ELSE To_Timestamp_LTZ('9999-12-31 23:59:59.999999999')
END,
(seq.seq_num = 1),
src.wawi_item_variant_nat_key_nr,
current_timestamp,
current_timestamp,
${LOAD_ID},
'WAWI_HQ'
FROM
(
        SELECT
        max_sid+ROW_NUMBER() OVER (ORDER BY y.wawi_item_variant_nat_key_nr) AS wawi_item_variant_sid,
        y.gueltig_ab,
        y.wawi_item_variant_nat_key_nr,
        y.first_instance_fg,
        y.dummy_sid_reuse_fg
        FROM ETL.WAWI_ITEM_NEW_UPD_WAWI_ITEM_VARIANT_KEYS AS y
        CROSS JOIN (SELECT MAX(wawi_item_variant_sid) max_sid FROM META.T_WAWI_ITEM_VARIANT_KEY_2) AS z
) AS src
INNER JOIN
(
    SELECT seq_num
    FROM
    (
        VALUES
        (0)
      , (1)
    ) AS a (seq_num)
) AS seq
ON  src.first_instance_fg = True
OR  seq.seq_num = 1
WHERE src.dummy_sid_reuse_fg = False
;

COMMIT;




CREATE OR REPLACE TEMPORARY TABLE ${TEMP_DB}.T_WAWI_PRECORE_ITEM_TEMP AS
(
SELECT CASE WHEN a.wawi_instanz_kzl='CS' THEN 'ES' ELSE LEFT(a.wawi_instanz_kzl,2) END AS COUNTRY_2, CAST(artnrvier AS Number) AS itemnr,

a.* , min_gueltig_ab
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_2 AS a
INNER JOIN ETL.WAWI_ITEMS_WITH_DELETION_RANGE b on LEFT(a.wawi_instanz_kzl,2)=LEFT(b.wawi_instanz_kzl,2) and itemnr=b.orig_item_nr and b.wawi_item_deleted_dt='9999-12-31' --filter to pick only the correct ES/CS items
        QUALIFY Row_Number() OVER (PARTITION BY COUNTRY_2, itemnr ORDER BY  artikelnr ASC, extraction_tmsp DESC ) = 1 --pick the latest data. The sorting by artikelnr is for the code to always pick the same item_2 variant
)
;



INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
 (
  wawi_item_nat_key_nr,
  wawi_item_key_type_cd,
  country_org_nat_key,
  COUNTRY_ORG_KEY_TYPE_CD,
  COUNTRY_ORG_CD,
  wawi_item_nr,
  wawi_item_name,
  wawi_item_descr,
  wawi_item_creation_dt,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id)
  SELECT
  COUNTRY_2 || '|' || LTRIM(artnrvier,'0') wawi_item_nat_key_nr,--
  'WAWI' wawi_item_key_type_cd, --this is OK probably
  COUNTRY_2 as country_org_nat_key,
  'COUNTRY_2' as COUNTRY_ORG_KEY_TYPE_CD,
  COUNTRY_2 as COUNTRY_ORG_CD ,
  LTRIM(artnrvier,'0') as wawi_item_nr,
  TRIM(COALESCE(deutschtext,bez_lang,'Unbekannt')) as wawi_item_name,
  TRIM(bez_lang)  as wawi_item_descr,
  min_gueltig_ab as  wawi_item_creation_dt,
  'WAWI' source_system,
  art.extraction_tmsp extraction_dt,
  art.extraction_tmsp dwh_mapping_tmsp,
  0 tf_error_fg,
  0 deleted_fg,
  0 record_id,
  '${SRC_INPUT_TABLE}' filename,
  'WAWI_HQ' dwh_node_cd,
  '${LOAD_ID}' dwh_load_id
FROM ${TEMP_DB}.T_WAWI_PRECORE_ITEM_TEMP
 AS art_2

;

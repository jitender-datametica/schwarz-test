INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  dispatch_grp_nr,
  country_org_sid,
  dispatch_grp_descr,
  dispatch_grp_descr_de,
  dispatch_grp_descr_en,
  dwh_load_id,
  dwh_node_cd,
  tf_error_fg,
  error_descr,
  record_id,
  filename
)

SELECT 
  de.dispatch_grp_nr,
  de.int_org_sid AS country_org_sid,
  CASE WHEN de.lang_cd ='DE' THEN de.dispatch_grp_descr ELSE 'unbekannt' END AS dispatch_grp_descr,
  CASE WHEN en.lang_cd ='EN' THEN en.dispatch_grp_descr ELSE 'unknown' END AS dispatch_grp_descr_en,
  CASE WHEN de.lang_cd ='DE' THEN de.dispatch_grp_descr ELSE 'unbekannt' END AS dispatch_grp_descr_de,
  ${LOAD_ID} dwh_load_id,
  de.dwh_node_cd dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'core_rel' filename
FROM
   (
     SELECT 
         *
     FROM core_rel.t_dispatch_group_1
     WHERE lang_cd = 'DE'
  ) de
    LEFT JOIN
  (
    SELECT 
         *
    FROM core_rel.t_dispatch_group_1
    WHERE lang_cd = 'EN'
   ) en ON de.dispatch_grp_nr = en.dispatch_grp_nr AND de.int_org_sid=en.int_org_sid

UNION ALL

SELECT 
  '@' as dispatch_grp_nr,
  -1 AS country_org_sid,
  'unbekannt' AS dispatch_grp_descr,
  'unknown' AS dispatch_grp_descr_en,
  'unbekannt' AS dispatch_grp_descr_de,
  -1 as dwh_load_id,
  'MANUAL' as dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'core_rel' filename
;


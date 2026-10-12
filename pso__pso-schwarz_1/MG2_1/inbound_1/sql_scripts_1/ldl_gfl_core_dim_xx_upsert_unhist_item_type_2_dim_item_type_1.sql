INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  item_type_cd,
  item_type_descr,
  item_type_descr_de,
  item_type_descr_en,
  dwh_load_id,
  dwh_node_cd,
  tf_error_fg,
  error_descr,
  record_id,
  filename
)

SELECT
  de.item_type_cd,
  de.item_type_descr,
  de.item_type_descr AS item_type_descr_de,
  COALESCE (en.item_type_descr , 'unknown') AS item_type_descr_en,
  ${LOAD_ID} dwh_load_id,
  'MANUAL' dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'core_rel' filename
FROM 
   (
     SELECT 
         *
     FROM core_rel.t_item_type_1
     WHERE lang_cd = 'DE'
   ) de
LEFT JOIN
  (
    SELECT 
         *
    FROM core_rel.t_item_type_1
    WHERE lang_cd = 'EN'
   ) en ON de.item_type_cd = en.item_type_cd
UNION
SELECT 
  '@',
  'unbekannt',
  'unbekannt',
  'unknown',
  ${LOAD_ID} dwh_load_id,
  'MANUAL' dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'core_rel' filename;

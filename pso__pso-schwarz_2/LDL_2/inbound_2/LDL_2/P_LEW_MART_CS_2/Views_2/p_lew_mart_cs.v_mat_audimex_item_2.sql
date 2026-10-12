CREATE OR REPLACE VIEW P_LEW_MART_CS.v_mat_audimex_item_2
(
  client_id
, country_iso_cd
, orig_item_nr
, item_descr
, plu_nr
, subitemgroup_id
, descr_short
, ag_reserve
, dwh_load_id
, dwh_created
, dwh_updated  
)
AS

SELECT
   item.client_id
  ,item.country_iso_cd  AS country_iso_cd
  ,item.orig_item_nr    AS orig_item_nr
  ,des.item_descr       AS item_descr
  ,plu.plu_nr          AS plu_nr
  ,itde.subitemgroup_id AS subitemgroup_id
  ,sig.descr_short      AS descr_short
  ,'UWGR'               AS ag_reserve
  ,item.dwh_load_id     AS dwh_load_id
  ,item.dwh_created     AS dwh_created
  ,item.dwh_updated     AS dwh_updated 
FROM P_LEW_MART_CS.v_cs_item_2 AS item_2

LEFT JOIN P_LEW_MART_CS.v_cs_item_2 AS plu
  ON item.client_id = plu.client_id
  AND item.orig_item_nr = plu.orig_item_nr
  AND plu.plu_nr > 0
  
LEFT JOIN P_LEW_MART_CS.v_cs_item_details_2 AS itde
ON item.client_id = itde.client_id
  AND item.orig_item_nr = itde.orig_item_nr
  AND item.case_size = itde.case_size
  AND CURRENT_DATE BETWEEN itde.valid_from AND itde.valid_until
  
LEFT JOIN P_LEW_MART_CS.v_cs_item_descr_2 AS des
ON item.client_id = des.client_id
  AND item.orig_item_nr = des.orig_item_nr
  AND item.case_size = des.case_size
  AND item.country_iso_cd = des.language_iso_cd
  AND CURRENT_DATE BETWEEN des.valid_from AND des.valid_until

LEFT JOIN P_LEW_MART_CS.v_cs_subitemgroup_2 AS sig
ON itde.client_id = sig.client_id
  AND itde.subitemgroup_id = sig.subitemgroup_cd
  AND item.country_iso_cd = sig.language_iso_cd
  AND CURRENT_DATE BETWEEN sig.dwh_valid_from AND sig.dwh_valid_to

WHERE item.case_size >= 0 
AND des.language_iso_cd IS NOT NULL
AND item.orig_item_nr > 0
QUALIFY ROW_NUMBER() OVER (PARTITION BY item.client_id, item.orig_item_nr ORDER BY item.dwh_created desc, des.item_descr desc, plu.plu_nr asc, itde.subitemgroup_id desc) = 1 
;
WITH cte_base AS (SELECT t_item.src_orig_item_nr,
   t_item.src_case_size,
   t_item.client_id AS client,
   t_wawi_itm_item.orig_item_nr_int,
   t_wawi_itm_item.brand_name,
   t_wawi_itm_item.subitemgroup_id,
   t_wawi_itm_item.case_size,
   t_wawi_itm_item.case_size_dec,
   t_wawi_itm_item.unitsize,
   t_wawi_itm_item.packing,
   t_wawi_itm_item.buying_list_type_id,
   t_wawi_itm_item.weight_item_fg,
   t_wawi_itm_item.scale_fg,
   t_item_relevance_classification.client_id,
   t_item_relevance_classification.item_sid,
   t_item_relevance_classification.item_relevance_class_schema_cd,
   t_item_relevance_classification.dwh_valid_from,
   t_item_relevance_classification.dwh_valid_to,
   t_item_relevance_classification.dwh_load_id,
   t_item_relevance_classification.dwh_created,
   t_item_relevance_classification.dwh_updated
  FROM ldl_production_p_lew_core.t_item_1
   INNER JOIN ldl_production_p_lew_core.t_item_relevance_classification_1 ON t_item.client_id =
      t_item_relevance_classification.client_id AND t_item_relevance_classification.dwh_valid_to >= CURRENT_DATE AND
     t_item.item_sid = t_item_relevance_classification.item_sid
   INNER JOIN ldl_production_p_lew_core.t_wawi_itm_item_skey_1 ON t_item.client_id = t_wawi_itm_item_skey.client_id AND
      t_item.item_sid = t_wawi_itm_item_skey.item_sid AND t_wawi_itm_item_skey.dat_rec_end >= DATE_SUB(CURRENT_DATE,
      INTERVAL 1 DAY)
   LEFT JOIN ldl_production_p_lew_core.t_wawi_itm_item_1 ON t_item.client_id = t_wawi_itm_item.client_id AND t_item.item_sid
       = t_wawi_itm_item.item_sid AND t_wawi_itm_item.dat_rec_end >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
  WHERE t_item_relevance_classification.client_id = CAST((SELECT CASE
        WHEN ${COUNTRY_ID} = 2
        THEN '2' -- BE

        WHEN ${COUNTRY_ID} = 3
        THEN '3' -- BG

        WHEN ${COUNTRY_ID} = 4
        THEN '5' -- CY

        WHEN ${COUNTRY_ID} = 5
        THEN '23' -- DE

        WHEN ${COUNTRY_ID} = 6
        THEN '8' -- DK

        WHEN ${COUNTRY_ID} = 7
        THEN '11' -- FI

        WHEN ${COUNTRY_ID} = 8
        THEN '12' -- FR

        WHEN ${COUNTRY_ID} = 9
        THEN '14' -- GR

        WHEN ${COUNTRY_ID} = 10
        THEN '13' -- GB

        WHEN ${COUNTRY_ID} = 11
        THEN '22' -- NL

        WHEN ${COUNTRY_ID} = 12
        THEN '17' -- IE

        WHEN ${COUNTRY_ID} = 13
        THEN '18' -- IT

        WHEN ${COUNTRY_ID} = 14
        THEN '31' -- CS

        WHEN ${COUNTRY_ID} = 15
        THEN '15' -- HR

        WHEN ${COUNTRY_ID} = 16
        THEN '19' -- LT

        WHEN ${COUNTRY_ID} = 17
        THEN '32' -- MT

        WHEN ${COUNTRY_ID} = 18
        THEN '21' -- NI

        WHEN ${COUNTRY_ID} = 19
        THEN '1' -- AT

        WHEN ${COUNTRY_ID} = 20
        THEN '24' -- PL

        WHEN ${COUNTRY_ID} = 21
        THEN '25' -- PT

        WHEN ${COUNTRY_ID} = 22
        THEN '26' -- RO

        WHEN ${COUNTRY_ID} = 23
        THEN '27' -- SE

        WHEN ${COUNTRY_ID} = 24
        THEN '4' -- CH

        WHEN ${COUNTRY_ID} = 25
        THEN '34' -- RS_1

        WHEN ${COUNTRY_ID} = 26
        THEN '29' -- SK

        WHEN ${COUNTRY_ID} = 27
        THEN '28' -- SI

        WHEN ${COUNTRY_ID} = 28
        THEN '10' -- ES

        WHEN ${COUNTRY_ID} = 29
        THEN '6' -- CZ

        WHEN ${COUNTRY_ID} = 30
        THEN '16' -- HU

        WHEN ${COUNTRY_ID} = 31
        THEN '33' -- US

        WHEN ${COUNTRY_ID} = 33
        THEN '9' -- EE

        WHEN ${COUNTRY_ID} = 34
        THEN '20' -- LV

        ELSE NULL
        END AS result) AS FLOAT64)) (SELECT LPAD(CONCAT(TRIM(src_orig_item_nr), LPAD(src_case_size, 4, '0')), 11, '0')
   AS orig_item_nr_int_joined,
   zsummary,
   zrelevantmdm
  FROM (SELECT item_sid,
     src_orig_item_nr,
     src_case_size,
     client,
     STRING_AGG(item_relevance_class_schema_cd, '-' ORDER BY item_sid IS NULL, item_sid) AS zsummary,
     COUNT(DISTINCT CASE
       WHEN item_relevance_class_schema_cd = 'ALR' OR item_relevance_class_schema_cd = 'LBS' OR
          item_relevance_class_schema_cd = 'NEW' OR item_relevance_class_schema_cd = 'OBE'
       THEN 1
       ELSE NULL
       END) AS zrelevantmdm
    FROM cte_base
    GROUP BY item_sid,
     src_orig_item_nr,
     src_case_size,
     client
    HAVING zrelevantmdm = 1) AS t8);
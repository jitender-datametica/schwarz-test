CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_brand_asis_2 AS SELECT client_id,
 item_sid,
 brand_sid,
 brand_type_mark,
 brand_descr
FROM (SELECT A.client_id,
   A.item_sid,
   A.brand_sid,
   A.brand_type_mark,
   D.brand_descr,
   COUNT(*) AS counti
  FROM ldl_p_lew_core_ac.v_item_location_brand_hist_2 AS A
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS B ON A.loc_sid = B.loc_sid AND B.wh_store_mark = 'A' AND B.global_loc_type_cd
      = '0'
   INNER JOIN ldl_p_lew_core_ac.v_location_hist_2 AS C ON B.loc_sid = C.loc_sid AND C.demand_plan_active_fg = 1 AND
      CURRENT_DATE BETWEEN C.dwh_valid_from AND C.dwh_valid_to AND C.deleted_fg = 0
   LEFT JOIN ldl_p_lew_core_ac.v_brand_2 AS DX ON A.client_id = DX.client_id AND A.brand_sid = DX.brand_sid
   LEFT JOIN ldl_p_lew_core_ac.v_client_2 AS CLI ON A.client_id = CLI.client_id
   LEFT JOIN ldl_p_lew_core_ac.v_country_2 AS CTRY ON CLI.country_sid = CTRY.country_sid
   LEFT JOIN ldl_p_lew_core_ac.v_brand_descr_2 AS D ON A.client_id = D.client_id AND A.brand_sid = D.brand_sid AND CTRY.lang_sid
      = D.lang_sid
  WHERE CURRENT_DATE BETWEEN A.dwh_valid_from AND A.dwh_valid_to
   AND A.deleted_fg = 0
  GROUP BY A.client_id,
   A.item_sid,
   A.brand_sid,
   A.brand_type_mark,
   D.brand_descr
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.item_sid AS STRING) ORDER BY counti
        IS NULL, counti, CASE
         WHEN D.brand_descr = '-'
         THEN 2
         ELSE 1
         END IS NULL DESC, CASE
         WHEN D.brand_descr = '-'
         THEN 2
         ELSE 1
         END DESC)) = 1) AS t1_2;
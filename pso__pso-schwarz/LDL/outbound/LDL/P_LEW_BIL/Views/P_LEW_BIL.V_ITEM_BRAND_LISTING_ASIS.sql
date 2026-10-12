CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_brand_listing_asis AS SELECT IT.client_id,
 IT.item_sid,
 IT.item_name,
  CASE
  WHEN IT.src_matnr IS NULL
  THEN WA.brand
  ELSE ib.brand_descr
  END AS brand_descr,
  CASE
  WHEN IT.src_matnr IS NULL
  THEN CAST(WA.buying_list_type_id AS BIGNUMERIC)
  ELSE CAST(CASE
    WHEN ib.brand_type_mark = 'EM' AND il.list_type_mark = 'A'
    THEN 8
    WHEN ib.brand_type_mark = 'M' AND il.list_type_mark = 'A'
    THEN 7
    WHEN ib.brand_type_mark = 'EM' AND il.list_type_mark = 'S'
    THEN 2
    WHEN ib.brand_type_mark = 'M' AND il.list_type_mark = 'S'
    THEN 1
    WHEN ib.brand_type_mark = 'EM' AND il.list_type_mark = '-'
    THEN - 2
    WHEN ib.brand_type_mark = 'M' AND il.list_type_mark = '-'
    THEN - 3
    WHEN ib.brand_type_mark IS NULL AND il.list_type_mark = 'A'
    THEN - 4
    WHEN ib.brand_type_mark IS NULL AND il.list_type_mark = 'S'
    THEN - 5
    ELSE - 1
    END AS BIGNUMERIC)
  END AS buying_list_type_id,
  CASE
  WHEN IT.src_matnr IS NULL
  THEN WA.buying_list_type_desc
  ELSE CASE
   WHEN ib.brand_type_mark = 'EM' AND il.list_type_mark = 'A'
   THEN 'Aktionsartikel EM'
   WHEN ib.brand_type_mark = 'M' AND il.list_type_mark = 'A'
   THEN 'Aktionsartikel M'
   WHEN ib.brand_type_mark = 'EM' AND il.list_type_mark = 'S'
   THEN 'Normalsortiment EM'
   WHEN ib.brand_type_mark = 'M' AND il.list_type_mark = 'S'
   THEN 'Normalsortiment M'
   WHEN ib.brand_type_mark = 'EM' AND il.list_type_mark = '-'
   THEN 'EM ohne Listungsart'
   WHEN ib.brand_type_mark = 'M' AND il.list_type_mark = '-'
   THEN 'M ohne Listungsart'
   WHEN ib.brand_type_mark IS NULL AND il.list_type_mark = 'A'
   THEN 'Aktionsartikel ohne Markenart'
   WHEN ib.brand_type_mark IS NULL AND il.list_type_mark = 'S'
   THEN 'Normalsortiment ohne Markenart'
   ELSE 'Dummy-Artikelart'
   END
  END AS buying_list_type_descr
FROM ldl_p_lew_core_ac.v_item AS IT
 LEFT JOIN (SELECT client_id,
   item_sid,
   brand_sid,
   brand_type_mark,
   brand_descr
  FROM (SELECT A.client_id,
     A.item_sid,
     A.brand_sid,
     A.brand_type_mark,
     F.brand_descr,
     COUNT(*) AS counti
    FROM ldl_p_lew_core_ac.v_item_location_brand_hist AS A
     INNER JOIN ldl_p_lew_core_ac.v_location AS B ON A.loc_sid = B.loc_sid AND B.wh_store_mark = 'A' AND B.global_loc_type_cd
        = '0'
     INNER JOIN ldl_p_lew_core_ac.v_location_hist AS C ON B.loc_sid = C.loc_sid AND C.demand_plan_active_fg = 1 AND
        CURRENT_DATE BETWEEN C.dwh_valid_from AND C.dwh_valid_to AND C.deleted_fg = 0
     LEFT JOIN ldl_p_lew_core_ac.v_client AS D ON A.client_id = D.client_id
     LEFT JOIN ldl_p_lew_core_ac.v_country AS E ON D.country_sid = E.country_sid
     LEFT JOIN ldl_p_lew_core_ac.v_brand_descr AS F ON A.client_id = F.client_id AND A.brand_sid = F.brand_sid AND E.lang_sid
        = F.lang_sid
    WHERE CURRENT_DATE BETWEEN A.dwh_valid_from AND A.dwh_valid_to
     AND A.deleted_fg = 0
    GROUP BY A.client_id,
     A.item_sid,
     A.brand_sid,
     A.brand_type_mark,
     F.brand_descr
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.item_sid AS STRING) ORDER BY counti
          IS NULL, counti, CASE
           WHEN F.brand_descr = '-'
           THEN 2
           ELSE 1
           END IS NULL DESC, CASE
           WHEN F.brand_descr = '-'
           THEN 2
           ELSE 1
           END DESC)) = 1) AS t2) AS ib ON IT.client_id = ib.client_id AND IT.item_sid = ib.item_sid
 LEFT JOIN (SELECT client_id,
   item_sid,
   list_type_mark
  FROM (SELECT A0.client_id,
     A0.item_sid,
     COALESCE(A0.list_type_mark, '-') AS list_type_mark,
     COUNT(*) AS counti
    FROM ldl_p_lew_core_ac.v_item_listing_type_hist AS A0
     INNER JOIN ldl_p_lew_core_ac.v_location AS B0 ON A0.loc_sid = B0.loc_sid AND B0.wh_store_mark = 'A' AND B0.global_loc_type_cd
        = '0'
     INNER JOIN ldl_p_lew_core_ac.v_location_hist AS C0 ON B0.loc_sid = C0.loc_sid AND C0.demand_plan_active_fg = 1 AND
        CURRENT_DATE BETWEEN C0.dwh_valid_from AND C0.dwh_valid_to AND C0.deleted_fg = 0
    WHERE CURRENT_DATE BETWEEN A0.dwh_valid_from AND A0.dwh_valid_to
     AND A0.deleted_fg = 0
    GROUP BY A0.client_id,
     A0.item_sid,
     list_type_mark
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A0.client_id AS STRING), CAST(A0.item_sid AS STRING) ORDER BY counti
          IS NULL, counti)) = 1) AS t8) AS il ON IT.client_id = il.client_id AND IT.item_sid = il.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act AS WA ON IT.client_id = WA.client_id AND IT.item_sid = WA.item_sid;
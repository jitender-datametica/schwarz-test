CREATE OR REPLACE VIEW ldl_p_process_view.v_item_loc_brand_listing_hist_1 AS SELECT ITH.client_id,
 ITH.item_sid,
 ITH.dwh_valid_from,
 ITH.dwh_valid_to,
 IT.item_name,
 t2.loc_sid,
 t2.brand_descr,
  CASE
  WHEN t2.brand_type_mark = 'EM' AND t7.list_type_mark = 'A'
  THEN 8
  WHEN t2.brand_type_mark = 'M' AND t7.list_type_mark = 'A'
  THEN 7
  WHEN t2.brand_type_mark = 'EM' AND t7.list_type_mark = 'S'
  THEN 2
  WHEN t2.brand_type_mark = 'M' AND t7.list_type_mark = 'S'
  THEN 1
  WHEN t2.brand_type_mark = 'EM' AND t7.list_type_mark = '-'
  THEN - 2
  WHEN t2.brand_type_mark = 'M' AND t7.list_type_mark = '-'
  THEN - 3
  WHEN t2.brand_type_mark IS NULL AND t7.list_type_mark = 'A'
  THEN - 4
  WHEN t2.brand_type_mark IS NULL AND t7.list_type_mark = 'S'
  THEN - 5
  ELSE - 1
  END AS buying_list_type_id,
  CASE
  WHEN t2.brand_type_mark = 'EM' AND t7.list_type_mark = 'A'
  THEN 'Aktionsartikel EM'
  WHEN t2.brand_type_mark = 'M' AND t7.list_type_mark = 'A'
  THEN 'Aktionsartikel M'
  WHEN t2.brand_type_mark = 'EM' AND t7.list_type_mark = 'S'
  THEN 'Normalsortiment EM'
  WHEN t2.brand_type_mark = 'M' AND t7.list_type_mark = 'S'
  THEN 'Normalsortiment M'
  WHEN t2.brand_type_mark = 'EM' AND t7.list_type_mark = '-'
  THEN 'EM ohne Listungsart'
  WHEN t2.brand_type_mark = 'M' AND t7.list_type_mark = '-'
  THEN 'M ohne Listungsart'
  WHEN t2.brand_type_mark IS NULL AND t7.list_type_mark = 'A'
  THEN 'Aktionsartikel ohne Markenart'
  WHEN t2.brand_type_mark IS NULL AND t7.list_type_mark = 'S'
  THEN 'Normalsortiment ohne Markenart'
  ELSE 'Dummy_1-Artikelart'
  END AS buying_list_type_descr
FROM ldl_p_lew_core_ac.v_item_hist_1 AS ITH
 INNER JOIN ldl_p_lew_core_ac.v_item_1 AS IT ON ITH.client_id = IT.client_id AND ITH.item_sid = IT.item_sid AND IT.src_matnr
  IS NOT NULL
 LEFT JOIN (SELECT ITH_X.client_id,
   ITH_X.item_sid,
   ITH_X.dwh_valid_from,
   ITH_X.dwh_valid_to,
   itb_x.loc_sid,
   itb_x.brand_type_mark,
   itb_x.brand_descr,
   itb_x.brand_count
  FROM ldl_p_lew_core_ac.v_item_hist_1 AS ITH_X
   LEFT JOIN (SELECT A.client_id,
     A.item_sid,
     A.loc_sid,
     A.brand_sid,
     A.brand_type_mark,
     A.dwh_valid_from,
     A.dwh_valid_to,
     F.brand_descr,
     COUNT(*) AS brand_count
    FROM ldl_p_lew_core_ac.v_item_location_brand_hist_1 AS A
     INNER JOIN ldl_p_lew_core_ac.v_location_1 AS B ON A.loc_sid = B.loc_sid AND B.wh_store_mark = 'A' AND B.global_loc_type_cd
        = '0'
     INNER JOIN ldl_p_lew_core_ac.v_location_hist_1 AS C ON B.loc_sid = C.loc_sid AND C.demand_plan_active_fg = 1 AND A.dwh_valid_from
          <= C.dwh_valid_to AND A.dwh_valid_to >= C.dwh_valid_from AND C.deleted_fg = 0
     LEFT JOIN ldl_p_lew_core_ac.v_client_1 AS D ON A.client_id = D.client_id
     LEFT JOIN ldl_p_lew_core_ac.v_country_1 AS E ON D.country_sid = E.country_sid
     LEFT JOIN ldl_p_lew_core_ac.v_brand_descr_1 AS F ON A.client_id = F.client_id AND A.brand_sid = F.brand_sid AND E.lang_sid
        = F.lang_sid
    WHERE A.deleted_fg = 0
    GROUP BY A.client_id,
     A.item_sid,
     A.loc_sid,
     A.brand_sid,
     A.brand_type_mark,
     A.dwh_valid_from,
     A.dwh_valid_to,
     F.brand_descr) AS itb_x ON ITH_X.client_id = itb_x.client_id AND ITH_X.item_sid = itb_x.item_sid AND ITH_X.dwh_valid_from
       <= itb_x.dwh_valid_to AND ITH_X.dwh_valid_to >= itb_x.dwh_valid_from
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ITH_X.client_id AS STRING), CAST(ITH_X.item_sid AS STRING), CAST(itb_x.loc_sid AS STRING)
        , ITH_X.dwh_valid_from, ITH_X.dwh_valid_to ORDER BY itb_x.brand_count IS NULL, itb_x.brand_count)) = 1) AS t2 ON
     ITH.client_id = t2.client_id AND ITH.item_sid = t2.item_sid AND ITH.dwh_valid_from = t2.dwh_valid_from AND ITH.dwh_valid_to
    = t2.dwh_valid_to
 LEFT JOIN (SELECT ITH_X0.client_id,
   ITH_X0.item_sid,
   itt_x.loc_sid,
   ITH_X0.dwh_valid_from,
   ITH_X0.dwh_valid_to,
   itt_x.list_type_mark,
   itt_x.type_count
  FROM ldl_p_lew_core_ac.v_item_hist_1 AS ITH_X0
   LEFT JOIN (SELECT A0.client_id,
     A0.item_sid,
     A0.loc_sid,
     COALESCE(A0.list_type_mark, '-') AS list_type_mark,
     A0.dwh_valid_from,
     A0.dwh_valid_to,
     COUNT(*) AS type_count
    FROM ldl_p_lew_core_ac.v_item_listing_type_hist_1 AS A0
     INNER JOIN ldl_p_lew_core_ac.v_location_1 AS B0 ON A0.loc_sid = B0.loc_sid AND B0.wh_store_mark = 'A' AND B0.global_loc_type_cd
        = '0'
     INNER JOIN ldl_p_lew_core_ac.v_location_hist_1 AS C0 ON B0.loc_sid = C0.loc_sid AND C0.demand_plan_active_fg = 1 AND
         A0.dwh_valid_from <= C0.dwh_valid_to AND A0.dwh_valid_to >= C0.dwh_valid_from AND C0.deleted_fg = 0
    WHERE A0.deleted_fg = 0
    GROUP BY A0.client_id,
     A0.item_sid,
     A0.loc_sid,
     list_type_mark,
     A0.dwh_valid_from,
     A0.dwh_valid_to) AS itt_x ON ITH_X0.client_id = itt_x.client_id AND ITH_X0.item_sid = itt_x.item_sid AND ITH_X0.dwh_valid_from
       <= itt_x.dwh_valid_to AND ITH_X0.dwh_valid_to >= itt_x.dwh_valid_from
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ITH_X0.client_id AS STRING), CAST(ITH_X0.item_sid AS STRING), CAST(itt_x.loc_sid AS STRING)
        , ITH_X0.dwh_valid_from, ITH_X0.dwh_valid_to ORDER BY itt_x.type_count IS NULL, itt_x.type_count)) = 1) AS t7 ON
      ITH.client_id = t7.client_id AND ITH.item_sid = t7.item_sid AND t2.loc_sid = t7.loc_sid AND ITH.dwh_valid_from =
    t7.dwh_valid_from AND ITH.dwh_valid_to = t7.dwh_valid_to
WHERE ITH.deleted_fg = 0
UNION DISTINCT
SELECT WAH.client_id,
 WAH.item_sid,
 WAH.dat_rec_start AS dwh_valid_from,
 WAH.dat_rec_end AS dwh_valid_to,
 IT.item_name,
 was.loc_sid,
 WAH.brand_name AS brand_descr,
 WAH.buying_list_type_id,
 WAH.buying_list_type_desc AS buying_list_type_descr
FROM ldl_p_lew_core_ac.v_wawi_itm_item_1 AS WAH
 INNER JOIN ldl_p_lew_core_ac.v_item_1 AS IT ON WAH.client_id = IT.client_id AND WAH.item_sid = IT.item_sid AND IT.src_matnr
  IS NULL
 LEFT JOIN (SELECT st_loc_sid AS loc_sid,
   client_id,
   MIN(dat_rec_start) AS dat_rec_start,
   MAX(dat_rec_end) AS dat_rec_end
  FROM ldl_p_lew_core_ac.v_wawi_org_store_1 AS A
  GROUP BY loc_sid,
   client_id) AS was ON WAH.client_id = was.client_id AND WAH.dat_rec_start <= was.dat_rec_end AND WAH.dat_rec_end >=
   was.dat_rec_start;
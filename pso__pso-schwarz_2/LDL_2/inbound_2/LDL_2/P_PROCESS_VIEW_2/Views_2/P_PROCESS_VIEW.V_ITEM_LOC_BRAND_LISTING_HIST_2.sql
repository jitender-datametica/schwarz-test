CREATE OR REPLACE VIEW P_PROCESS_VIEW.V_ITEM_LOC_BRAND_LISTING_HIST_2 as
   SELECT
         ith.client_id,
   ith.item_sid,
   ith.dwh_valid_from,
   ith.dwh_valid_to,
   it.item_name,
   itb.loc_sid,
   itb.brand_descr,
   CASE
          WHEN itb.brand_type_mark = 'EM'  AND itt.list_type_mark = 'A' THEN  8
          WHEN itb.brand_type_mark = 'M'   AND itt.list_type_mark = 'A' THEN  7
          WHEN itb.brand_type_mark = 'EM'  AND itt.list_type_mark = 'S' THEN  2
          WHEN itb.brand_type_mark = 'M'   AND itt.list_type_mark = 'S' THEN  1
          WHEN itb.brand_type_mark = 'EM'  AND itt.list_type_mark = '-' THEN -2
          WHEN itb.brand_type_mark = 'M'   AND itt.list_type_mark = '-' THEN -3
          WHEN itb.brand_type_mark IS NULL AND itt.list_type_mark = 'A' THEN -4
          WHEN itb.brand_type_mark IS NULL AND itt.list_type_mark = 'S' THEN -5
          ELSE                                                               -1
        END AS buying_list_type_id,
   CASE
          WHEN itb.brand_type_mark = 'EM'  AND itt.list_type_mark = 'A' THEN 'Aktionsartikel EM'
          WHEN itb.brand_type_mark = 'M'   AND itt.list_type_mark = 'A' THEN 'Aktionsartikel M'
          WHEN itb.brand_type_mark = 'EM'  AND itt.list_type_mark = 'S' THEN 'Normalsortiment EM'
          WHEN itb.brand_type_mark = 'M'   AND itt.list_type_mark = 'S' THEN 'Normalsortiment M'
          WHEN itb.brand_type_mark = 'EM'  AND itt.list_type_mark = '-' THEN 'EM ohne Listungsart'
          WHEN itb.brand_type_mark = 'M'   AND itt.list_type_mark = '-' THEN 'M ohne Listungsart'
          WHEN itb.brand_type_mark IS NULL AND itt.list_type_mark = 'A' THEN 'Aktionsartikel ohne Markenart'
          WHEN itb.brand_type_mark IS NULL AND itt.list_type_mark = 'S' THEN 'Normalsortiment ohne Markenart'
          ELSE                                                               'Dummy_2-Artikelart'
        END AS buying_list_type_descr

  FROM  p_lew_core_ac.v_item_hist_2 AS ith
   INNER JOIN  p_lew_core_ac.v_item_2 AS it
   ON it.client_id = ith.client_id
   AND it.item_sid = ith.item_sid
   -- select only items from SAP
   AND it.src_matnr IS NOT NULL
   LEFT JOIN
   (
       SELECT
             ith_x.client_id,
   ith_x.item_sid,
   ith_x.dwh_valid_from,
   ith_x.dwh_valid_to,
   itb_x.loc_sid,
   itb_x.brand_type_mark,
   itb_x.brand_descr,
   itb_x.brand_count
      FROM  p_lew_core_ac.v_item_hist_2 AS ith_x
   LEFT JOIN
   (
       SELECT
             a.client_id,
   a.item_sid,
   a.loc_sid,
   a.brand_sid,
   a.brand_type_mark,
   a.dwh_valid_from,
   a.dwh_valid_to,
   f.brand_descr,
   COUNT(*) AS brand_count
          FROM  p_lew_core_ac.v_item_location_brand_hist_2 AS a
   INNER JOIN  p_lew_core_ac.v_location_2 AS b
   ON b.loc_sid = a.loc_sid
   AND b.wh_store_mark = 'A'
   AND b.global_loc_type_cd = '0'
   INNER JOIN  p_lew_core_ac.v_location_hist_2 AS c
   ON c.loc_sid = b.loc_sid
   AND c.demand_plan_active_fg = 1
   -- intersection:
   AND a.dwh_valid_from <= c.dwh_valid_to AND c.dwh_valid_from <= a.dwh_valid_to
   AND c.deleted_fg = 0
   LEFT JOIN  p_lew_core_ac.v_client_2 AS d
   ON d.client_id = a.client_id
   LEFT JOIN  p_lew_core_ac.v_country_2 AS e
   ON e.country_sid = d.country_sid
   LEFT JOIN  p_lew_core_ac.v_brand_descr_2 AS f
   ON f.client_id = a.client_id
   AND f.brand_sid = a.brand_sid
   AND f.lang_sid = e.lang_sid

   WHERE a.deleted_fg = 0
   GROUP BY 1,2,3,4,5,6,7,8
) AS itb_x
   ON itb_x.client_id = ith_x.client_id
   AND itb_x.item_sid = ith_x.item_sid
   -- intersection:
   AND ith_x.dwh_valid_from <= itb_x.dwh_valid_to AND itb_x.dwh_valid_from <= ith_x.dwh_valid_to

   QUALIFY ROW_NUMBER() OVER
   (
       PARTITION BY ith_x.client_id, ith_x.item_sid, itb_x.loc_sid, ith_x.dwh_valid_from, ith_x.dwh_valid_to
       ORDER BY itb_x.brand_count DESC NULLS LAST
   ) = 1
) AS itb
   ON itb.client_id = ith.client_id
   AND itb.item_sid = ith.item_sid
   AND itb.dwh_valid_from = ith.dwh_valid_from
   AND itb.dwh_valid_to = ith.dwh_valid_to
   LEFT JOIN
   (
       SELECT
             ith_x.client_id,
   ith_x.item_sid,
   itt_x.loc_sid,
   ith_x.dwh_valid_from,
   ith_x.dwh_valid_to,
   itt_x.list_type_mark,
   itt_x.type_count
      FROM  p_lew_core_ac.v_item_hist_2 AS ith_x
   LEFT JOIN
   (
       SELECT
             a.client_id,
   a.item_sid,
   a.loc_sid,
   COALESCE(a.list_type_mark,'-') AS list_type_mark,
   a.dwh_valid_from,
   a.dwh_valid_to,
   COUNT(*) AS type_count
          FROM  p_lew_core_ac.v_item_listing_type_hist_2 AS a
   INNER JOIN  p_lew_core_ac.v_location_2 AS b
   ON b.loc_sid = a.loc_sid
   AND b.wh_store_mark = 'A'
   AND b.global_loc_type_cd = '0'
   INNER JOIN  p_lew_core_ac.v_location_hist_2 AS c
   ON c.loc_sid = b.loc_sid
   AND c.demand_plan_active_fg = 1
   -- intersection:
   AND a.dwh_valid_from <= c.dwh_valid_to AND c.dwh_valid_from <= a.dwh_valid_to
   AND c.deleted_fg = 0

   WHERE a.deleted_fg = 0
   GROUP BY 1,2,3,4,5,6
) itt_x
   ON itt_x.client_id = ith_x.client_id
   AND itt_x.item_sid = ith_x.item_sid
   -- intersection:
   AND ith_x.dwh_valid_from <= itt_x.dwh_valid_to AND itt_x.dwh_valid_from <= ith_x.dwh_valid_to

   QUALIFY ROW_NUMBER() OVER
   (
       PARTITION BY ith_x.client_id, ith_x.item_sid, itt_x.loc_sid, ith_x.dwh_valid_from, ith_x.dwh_valid_to
       ORDER BY itt_x.type_count DESC NULLS LAST
   ) = 1
) AS itt
   ON itt.client_id = ith.client_id
   AND itt.item_sid = ith.item_sid
   AND itt.loc_sid = itb.loc_sid
   AND itt.dwh_valid_from = ith.dwh_valid_from
   AND itt.dwh_valid_to = ith.dwh_valid_to
   WHERE ith.deleted_fg = 0

   UNION

   SELECT
         wah.client_id,
   wah.item_sid,
   wah.dat_rec_start AS dwh_valid_from,
   wah.dat_rec_end AS dwh_valid_to,
   it.item_name,
   was.loc_sid AS loc_sid,
   wah.brand_name AS brand_descr,
   wah.buying_list_type_id,
   wah.buying_list_type_desc AS buying_list_type_descr
  FROM  p_lew_core_ac.v_wawi_itm_item_2 AS wah
   INNER JOIN  p_lew_core_ac.v_item_2 AS it
   ON it.client_id = wah.client_id
   AND it.item_sid = wah.item_sid
   -- select only items from WAWI
   AND it.src_matnr IS NULL
   LEFT JOIN
   (
       SELECT
             a.st_loc_sid AS loc_sid,
   a.client_id,
   MIN(a.dat_rec_start) AS dat_rec_start,
   MAX(a.dat_rec_end) AS dat_rec_end
      FROM  p_lew_core_ac.v_wawi_org_store_2 AS a
   GROUP BY 1,2
) AS was
   ON was.client_id = wah.client_id
   -- intersection:
   AND wah.dat_rec_start <= was.dat_rec_end AND was.dat_rec_start <= wah.dat_rec_end
;
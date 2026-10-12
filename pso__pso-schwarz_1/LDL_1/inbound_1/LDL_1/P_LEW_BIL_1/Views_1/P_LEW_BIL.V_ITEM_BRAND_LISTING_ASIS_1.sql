CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_BRAND_LISTING_ASIS_1 as
   /*
   DescStart
   $Revision: 6705 $, $LastChangedBy: hwieber $
   SubjectAreas: Artikelstamm
   DescEnd
   */
   SELECT
     it.client_id,
   it.item_sid,
   it.item_name,
   CASE
       WHEN it.src_matnr IS NULL THEN wa.brand_1
       ELSE                           ib.brand_descr
     END AS brand_descr,
   CASE
       WHEN it.src_matnr IS NULL THEN CAST(wa.buying_list_type_id AS SMALLINT)
       ELSE
         CASE
           WHEN ib.brand_type_mark = 'EM'  AND il.list_type_mark = 'A' THEN  8
           WHEN ib.brand_type_mark = 'M'   AND il.list_type_mark = 'A' THEN  7
           WHEN ib.brand_type_mark = 'EM'  AND il.list_type_mark = 'S' THEN  2
           WHEN ib.brand_type_mark = 'M'   AND il.list_type_mark = 'S' THEN  1
           WHEN ib.brand_type_mark = 'EM'  AND il.list_type_mark = '-' THEN -2
           WHEN ib.brand_type_mark = 'M'   AND il.list_type_mark = '-' THEN -3
           WHEN ib.brand_type_mark IS NULL AND il.list_type_mark = 'A' THEN -4
           WHEN ib.brand_type_mark IS NULL AND il.list_type_mark = 'S' THEN -5
           ELSE                                                             -1
         END
     END AS buying_list_type_id,
   CASE
       WHEN it.src_matnr IS NULL THEN wa.buying_list_type_desc
       ELSE
         CASE
           WHEN ib.brand_type_mark = 'EM'  AND il.list_type_mark = 'A' THEN 'Aktionsartikel EM'
           WHEN ib.brand_type_mark = 'M'   AND il.list_type_mark = 'A' THEN 'Aktionsartikel M'
           WHEN ib.brand_type_mark = 'EM'  AND il.list_type_mark = 'S' THEN 'Normalsortiment EM'
           WHEN ib.brand_type_mark = 'M'   AND il.list_type_mark = 'S' THEN 'Normalsortiment M'
           WHEN ib.brand_type_mark = 'EM'  AND il.list_type_mark = '-' THEN 'EM ohne Listungsart'
           WHEN ib.brand_type_mark = 'M'   AND il.list_type_mark = '-' THEN 'M ohne Listungsart'
           WHEN ib.brand_type_mark IS NULL AND il.list_type_mark = 'A' THEN 'Aktionsartikel ohne Markenart'
           WHEN ib.brand_type_mark IS NULL AND il.list_type_mark = 'S' THEN 'Normalsortiment ohne Markenart'
           ELSE                                                             'Dummy_1-Artikelart'
         END
     END AS buying_list_type_descr

   FROM p_lew_core_ac.v_item_1 it
   LEFT JOIN
   (
     SELECT
       client_id,
   item_sid,
   brand_sid,
   brand_type_mark,
   brand_descr
 FROM
 (
   SELECT
     a.client_id,
   a.item_sid,
   a.brand_sid,
   a.brand_type_mark,
   f.brand_descr,
   COUNT(*) AS counti
 FROM p_lew_core_ac.v_item_location_brand_hist_1 a
   INNER JOIN p_lew_core_ac.v_location_1 b
   ON b.loc_sid=a.loc_sid
   AND b.wh_store_mark = 'A'
   AND b.global_loc_type_cd='0'
   INNER JOIN p_lew_core_ac.v_location_hist_1 c
   ON c.loc_sid=b.loc_sid
   AND c.demand_plan_active_fg = 1
   AND CURRENT_DATE BETWEEN c.dwh_valid_from AND c.dwh_valid_to
   AND c.deleted_fg = 0
   LEFT JOIN p_lew_core_ac.v_client_1 d
   ON d.client_id = a.client_id
   LEFT JOIN p_lew_core_ac.v_country_1 e
   ON e.country_sid = d.country_sid
   LEFT JOIN p_lew_core_ac.v_brand_descr_1 f
   ON f.client_id = a.client_id
   AND f.brand_sid=a.brand_sid
   AND f.lang_sid =e.lang_sid
   WHERE CURRENT_DATE BETWEEN a.dwh_valid_from AND a.dwh_valid_to
   AND a.deleted_fg = 0
   GROUP BY 1,2,3,4,5
 ) x
 QUALIFY ROW_NUMBER() OVER(PARTITION BY client_id,item_sid ORDER BY counti DESC NULLS LAST, CASE WHEN brand_descr='-' THEN 2 ELSE 1 END ASC) = 1
) ib
   ON ib.client_id = it.client_id
   AND ib.item_sid = it.item_sid
   LEFT JOIN
   (
     SELECT
       client_id,
   item_sid,
   list_type_mark
     FROM
     (
       SELECT
         a.client_id,
   a.item_sid,
   COALESCE(a.list_type_mark,'-') AS list_type_mark,
   COUNT(*) AS counti
       FROM p_lew_core_ac.v_item_listing_type_hist_1 a
   INNER JOIN p_lew_core_ac.v_location_1 b
   ON b.loc_sid=a.loc_sid
   AND b.wh_store_mark = 'A'
   AND b.global_loc_type_cd='0'
   INNER JOIN p_lew_core_ac.v_location_hist_1 c
   ON c.loc_sid=b.loc_sid
   AND c.demand_plan_active_fg = 1
   AND CURRENT_DATE BETWEEN c.dwh_valid_from AND c.dwh_valid_to
   AND c.deleted_fg = 0
   WHERE CURRENT_DATE BETWEEN a.dwh_valid_from AND a.dwh_valid_to
   AND a.deleted_fg = 0
   GROUP BY 1,2,3
 ) y
 QUALIFY ROW_NUMBER() OVER(PARTITION BY client_id,item_sid ORDER BY counti DESC NULLS LAST) = 1
) il
   ON il.client_id = it.client_id
   AND il.item_sid = it.item_sid
   LEFT JOIN p_lew_core_ac.v_wawi_itm_item_act_1 wa
   ON wa.client_id = it.client_id
   AND wa.item_sid = it.item_sid
   ;
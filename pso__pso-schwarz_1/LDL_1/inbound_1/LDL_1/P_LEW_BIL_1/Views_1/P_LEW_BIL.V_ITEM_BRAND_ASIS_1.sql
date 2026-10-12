CREATE OR REPLACE VIEW p_lew_bil.v_item_brand_asis_1
AS
/*
#DescStart#
#$Revision: 6426 $, $LastChangedBy: hwieber $
#SubjectAreas#: Artikelstamm
#DescEnd#
*/
SELECT
client_id,
item_sid,
brand_sid,
brand_type_mark,
brand_descr
FROM
(SELECT
a.client_id,
a.item_sid,
a.brand_sid,
a.brand_type_mark,
d.brand_descr,
count(*) as counti
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
LEFT JOIN p_lew_core_ac.v_brand_1 dx
ON dx.client_id = a.client_id
AND dx.brand_sid=a.brand_sid
LEFT JOIN p_lew_core_ac.v_client_1 cli
ON cli.client_id = a.client_id
LEFT JOIN p_lew_core_ac.v_country_1 ctry
ON cli.country_sid = ctry.country_sid
LEFT JOIN p_lew_core_ac.v_brand_descr_1 d
ON d.client_id = a.client_id
AND d.brand_sid=a.brand_sid
AND d.lang_sid =ctry.lang_sid
WHERE CURRENT_DATE BETWEEN a.dwh_valid_from AND a.dwh_valid_to
AND a.deleted_fg = 0
GROUP BY 1,2,3,4,5
) x
QUALIFY ROW_NUMBER() OVER(PARTITION BY client_id,item_sid ORDER BY counti DESC NULLS LAST, CASE WHEN brand_descr='-' THEN 2 ELSE 1 END ASC) = 1;



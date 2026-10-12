CREATE OR REPLACE VIEW idq_production_ldl_apt_results.v_dq_rep_apt_with_item_list_rule_3_2 (rule3_id, ref_calculation_time
, day_id, ref_country_id, country_code, promotionitemid, itemnumber, item_promotion_domain, validfrom_kw,
aktionsbereich_name, cnt_items_nf, cnt_items_f, cnt_items_ogbp, calendarweek_number, calendarweek, calendarweek_de,
calendarweek_en, rule_docu) AS SELECT ROW_NUMBER() OVER (ORDER BY day_id IS NULL, day_id) AS rule3_id,
 CURRENT_DATETIME() AS ref_calculation_time,
 day_id,
 ref_country_id,
 country_code,
 promotionitemid,
 itemnumber,
 item_promotion_domain,
 validfrom_kw,
 aktionsbereich_name,
 cnt_items_nf,
 cnt_items_f,
 cnt_items_ogbp,
 calendarweek_number,
 calendarweek,
 calendarweek_de,
 calendarweek_en,
     '<a href="' || 'https://confluence.schwarz/pages/viewpage.action?pageId=85977813' || '" target="_blank"><img src="'
     ||
   'https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2" width="24" height="24">'
    || '</img></a>' AS rule_docu
FROM idq_production_ldl_apt_results.t_dq_rep_apt_with_item_list_rule_3_2;
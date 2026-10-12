update dbp_data.werbung_kennzahlen_woche_2 from (select mandant_id,
                                                      wup_id,
                                                      art_id,
                                                      bezugsweg_id
                                               from dbp_data.art_wup_status_per_2
                                               where dat_bis = '9999-12-31'
                                               group by 1,2,3,4) b

set art_mutter_bezugsweg_id = b.bezugsweg_id

where dbp_data.werbung_kennzahlen_woche.mandant_id = b.mandant_id and
      dbp_data.werbung_kennzahlen_woche.mutter_wb_id = b.art_id and
      dbp_data.werbung_kennzahlen_woche.wup_id = b.wup_id
;

update dbp_data.werbung_kennzahlen_woche_2 from (select mandant_id,
                                                      wup_id,
                                                      art_id,
                                                      bezugsweg_id
                                               from dbp_data.art_wup_status_per_2
                                               where dat_bis = '9999-12-31'
                                               group by 1,2,3,4) b
								               
set art_mutter_bezugsweg_id = b.bezugsweg_id
								               
where dbp_data.werbung_kennzahlen_woche.mandant_id = b.mandant_id and
      dbp_data.werbung_kennzahlen_woche.art_id = b.art_id and
      dbp_data.werbung_kennzahlen_woche.wup_id = b.wup_id and
      dbp_data.werbung_kennzahlen_woche.art_mutter_bezugsweg_id = -1
;

update dbp_data.werbung_kennzahlen_woche_2 from (select mandant_id,
                                                      kjwo,
                                                      mutter_wb_id,
                                                      max(art_mutter_bezugsweg_id) as bezugsweg_id
                                               from dbp_data.werbung_kennzahlen_woche_2
                                               group by 1,2,3
                                               having count(distinct art_mutter_bezugsweg_id) > 1) b
                                                
set art_mutter_bezugsweg_id = b.bezugsweg_id
                                                
where dbp_data.werbung_kennzahlen_woche.mandant_id = b.mandant_id and
      dbp_data.werbung_kennzahlen_woche.kjwo = b.kjwo and
      dbp_data.werbung_kennzahlen_woche.mutter_wb_id = b.mutter_wb_id
;

update dbp_data.werbung_kennzahlen_woche_2 from (select mandant_id,
                                                      kjwo,
                                                      art_id,
                                                      max(posten_id) as max_posten_id
                                               from dbp_data.werbung_kennzahlen_woche_2
                                               group by 1,2,3) b
                                               
set posten_id = b.max_posten_id

where dbp_data.werbung_kennzahlen_woche.mandant_id = b.mandant_id and
      dbp_data.werbung_kennzahlen_woche.kjwo = b.kjwo and
      dbp_data.werbung_kennzahlen_woche.art_id = b.art_id and
      dbp_data.werbung_kennzahlen_woche.posten_id <> b.max_posten_id
;

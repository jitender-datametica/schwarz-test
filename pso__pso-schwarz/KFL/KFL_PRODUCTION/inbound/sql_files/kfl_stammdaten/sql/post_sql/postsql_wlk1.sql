delete from dbp_data.art_list_wup_zu_per t1
where exists (select *
              from dbp_etl.wlk1 t2
              where t1.mandant_id = t2.mandant_id and
                    t1.art_id = t2.art_id and
                    t1.wup_id = t2.wup_id and 
                    t1.list_quelle_id = collate(t2.list_quelle_id,'en-ci') and
                    t1.struktur_art_id = t2.struktur_art_id and
                    t1.dat_bis >= t2.dat_bis and
                    t2.loesch_fg = 0)
;

update dbp_data.art_list_wup_zu_per from (select mandant_id as mandant_id_
                                                ,art_id as art_id_
                                                ,wup_id as wup_id_
                                                ,collate(list_quelle_id,'en-ci') as list_quelle_id_
                                                ,struktur_art_id as struktur_art_id_
                                                ,min(dat_aend) as dat_aend_
                                          from dbp_etl.wlk1
                                          where loesch_fg = 1
                                          group by all) t1 

set dat_bis = dat_aend_-1
   ,td_update = current_timestamp

where mandant_id = mandant_id_ and 
      art_id = art_id_ and 
      wup_id = wup_id_ and 
      list_quelle_id = list_quelle_id_ and 
      struktur_art_id = struktur_art_id_ and 
      dat_bis >= dat_aend_
;

insert into dbp_data.art_list_wup_zu_per (mandant_id
                                         ,art_id
                                         ,wup_id
                                         ,nb_id
                                         ,dat_von
                                         ,dat_bis
                                         ,baustein_id
                                         ,list_quelle_id
                                         ,struktur_art_id
                                         ,list_sap_id
                                         ,list_komponente_fg
                                         ,td_insert
                                         ,td_update)
select mandant_id
      ,art_id
      ,wup_id
      ,nb_id
      ,dat_von
      ,dat_bis
      ,baustein_id
      ,list_quelle_id
      ,struktur_art_id
      ,list_sap_id
      ,komponente_fg
      ,current_timestamp
      ,current_timestamp
from dbp_etl.wlk1
where loesch_fg = 0
;

update dbp_data.art_list_wup_zu_per from (select mandant_id as mandant_id_
                                                ,art_id as art_id_
                                                ,wup_id as wup_id_
                                                ,max(dat_bis) as max_dat_bis
                                          from dbp_etl.wlk1
                                          where mandant_id in (2,3,4,5,6,7,8)
                                          group by 1,2,3) b

set dat_bis = max_dat_bis,
    td_update = current_date

where mandant_id = mandant_id_
  and art_id = art_id_
  and wup_id = wup_id_
  and dat_bis > max_dat_bis
;

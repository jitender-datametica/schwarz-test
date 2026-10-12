-- AIS

insert into dbp_data.artbew_agg_wt_2 (mandant_id
                                   ,wup_id
                                   ,nb_id
                                   ,dat)
select mandant_id
      ,wup_id
      ,nb_id
      ,dat
from dbp_data.artbew_2
where dat between (select min(dat) from dbp_data.tag_2 where akt_mo = -13) and current_date and
     (mandant_id,wup_id,nb_id,dat) not in (select mandant_id,wup_id,nb_id,dat from dbp_data.artbew_agg_wt_2)
group by 1,2,3,4
;

-- EK-INT

update dbp_etl_process.fww_gld_zeitraum_2 set akt_mo = -13
;

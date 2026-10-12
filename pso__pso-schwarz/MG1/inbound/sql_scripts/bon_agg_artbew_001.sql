create or replace table dbp_etl.bon_agg_artbew_tmp (
  wup_id integer not null,
  mandant_id byteint not null,
  bon_dat date not null,
  xml_name varchar(255)
);

create or replace table dbp_etl.bon_artbew_tgl_delta (
  wup_id integer not null,
  mandant_id byteint not null,
  dat date not null
);

insert into dbp_etl.bon_agg_artbew_tmp (mandant_id
                                       ,wup_id
                                       ,bon_dat
                                       ,xml_name)
select t2.mandant_id
      ,t2.wup_id
      ,t2.bon_dat
      ,t1.xml_name
from dbp_ods.bon_load_status t1
join dbp_ods.ods_bon_transaction t2
  on t1.xml_name=t2.datei_name
where artbew_fg = 0
  and t1.parsebon_time <= current_timestamp() - interval '10 minute'  
  and t2.mandant_id = 1
  and t2.bon_dat < current_date
  and t2.bon_dat > current_date - 90
;

insert into dbp_etl.bon_artbew_tgl_delta (mandant_id
                                         ,wup_id
                                         ,dat)
select mandant_id
      ,wup_id
      ,bon_dat
from dbp_etl.bon_agg_artbew_tmp
where (mandant_id, wup_id, bon_dat) not in (select mandant_id,wup_id,dat from dbp_etl.bon_artbew_tgl_delta)
group by 1,2,3
;

update dbp_ods.bon_load_status
set artbew_fg = 1
where xml_name in (select xml_name from dbp_etl.bon_agg_artbew_tmp)
;

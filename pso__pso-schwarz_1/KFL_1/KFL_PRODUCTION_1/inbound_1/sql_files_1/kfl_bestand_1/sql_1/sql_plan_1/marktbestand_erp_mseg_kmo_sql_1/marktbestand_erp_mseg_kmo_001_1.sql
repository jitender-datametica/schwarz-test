create or replace volatile table _bestand (
  mandant_id integer,
  art_id integer,
  wup_id smallint,
  dat date,
  menge_frei decimal(18,3),
  menge_qual decimal(18,3),
  menge_gesp decimal(18,3)
);

insert into _bestand
select mandant_id,
       art_id,
       wup_id,
       dat,
       menge_lgbest_erp_frei_bme as menge_frei,
       menge_lgbest_erp_qual_bme as menge_qual,
       menge_lgbest_erp_gesp_bme as menge_gesp
from dbp_etl_process.dwh_mardh_monatsendbestand_1
where mandant_id > 1 and
     (mandant_id,dat) in (select mandant_id,max(dat) from dbp_etl_process.dwh_mardh_monatsendbestand_1 where mandant_id > 1 group by 1)
;

create or replace volatile table _lieferung1 as (
select mandant_id,
       art_id,
       wup_id,
       dat_buch as dat,
       sum(case 
             when a.lager_bewart_id = '313' 
             then a.menge_erf
             when a.mandant_id = 2 and
                  a.wup_id in (2700,3900) and
                  a.lager_bewart_id = '315'
             then 0
             else a.menge_lagerbew_bme end) as menge_lief_frei,
       0 as menge_lief_qual,
       0 as menge_lief_gesp
from dbp_data.lagerbew_det_1 a
join dbp_etl_process.mseg_bewart_daria_1 b
  on a.lager_bewart_id = b.lager_bewart_id and
     trim(a.auto_fg) = trim(b.auto_fg_frei) and
     b.relevant_fg = 1
where a.mandant_id > 1 and
      dat_buch between (select min(dat)+1 from _bestand) and current_date
group by 1,2,3,4
union all
select mandant_id,
       art_id,
       wup_id,
       dat_buch as dat,
       0 as menge_lief_frei,
       sum(a.menge_lagerbew_bme) as menge_lief_qual,
       0 as menge_lief_gesp
from dbp_data.lagerbew_det_1 a
join dbp_etl_process.mseg_bewart_daria_1 b
  on a.lager_bewart_id = b.lager_bewart_id and
     trim(a.auto_fg) = trim(b.auto_fg_qual) and
     b.relevant_fg = 1
where a.mandant_id > 1 and
      dat_buch between (select min(dat)+1 from _bestand) and current_date
group by 1,2,3,4
union all
select mandant_id,
       art_id,
       wup_id,
       dat_buch as dat,
       0 as menge_lief_frei,
       0 as menge_lief_qual,
       sum(a.menge_lagerbew_bme) as menge_lief_gesp
from dbp_data.lagerbew_det_1 a
join dbp_etl_process.mseg_bewart_daria_1 b
  on a.lager_bewart_id = b.lager_bewart_id and
     trim(a.auto_fg) = trim(b.auto_fg_gesp) and
     b.relevant_fg = 1
where a.mandant_id > 1 and
      dat_buch between (select min(dat)+1 from _bestand) and current_date
group by 1,2,3,4
);

create or replace volatile table _tage as (
select dat
from dbp_data.tag_1
where dat between (select min(dat)+1 from _bestand) and current_date
);

execute immediate 
$$
begin
  let loop_counter1 integer := (select 1);
  let loop_counter_value integer := 0;

  while ((loop_counter1) > 0) do

  insert into _bestand
  select coalesce(a.mandant_id,b.mandant_id),
         coalesce(a.art_id,b.art_id),
         coalesce(a.wup_id,b.wup_id),
         coalesce(a.dat,b.dat+1),
         zeroifnull(b.menge_frei)+zeroifnull(a.menge_lief_frei),
         zeroifnull(b.menge_qual)+zeroifnull(a.menge_lief_qual),
         zeroifnull(b.menge_gesp)+zeroifnull(a.menge_lief_gesp)
  from (select mandant_id,
               art_id,
               wup_id,
               dat,
               sum(menge_lief_frei) as menge_lief_frei,
               sum(menge_lief_qual) as menge_lief_qual,
               sum(menge_lief_gesp) as menge_lief_gesp
        from _lieferung1
        where dat in (select min(dat) from _tage)
        group by 1,2,3,4) a
  full join (select *
             from _bestand
             where dat in (select min(dat)-1 from _tage)) b
    on a.art_id = b.art_id and
       a.wup_id = b.wup_id and
       a.mandant_id = b.mandant_id and
       a.dat = b.dat+1
   ;

   delete from _tage
   where dat in (select min(dat) from _tage)
   ;
  
   loop_counter1 := (select * from table(result_scan(last_query_id())));
   loop_counter_value := loop_counter_value + 1;
  end while;

  return loop_counter_value;

end;
$$
;

update dbp_data.marktbestand_erp_1 from (select *
                                       from _bestand
                                       where dat between current_date-5 and current_date and
                                             mandant_id > 1) b
                                       
set menge_lgbest_erp_frei_bme = b.menge_frei,
    menge_lgbest_erp_qual_bme = b.menge_qual,
    menge_lgbest_erp_gesp_bme = b.menge_gesp

where dbp_data.marktbestand_erp.mandant_id = b.mandant_id and
      dbp_data.marktbestand_erp.wup_id = b.wup_id and
      dbp_data.marktbestand_erp.art_id = b.art_id and
      dbp_data.marktbestand_erp.dat = b.dat
;

insert into dbp_data.marktbestand_erp_1 (mandant_id
                                      ,art_id
                                      ,wup_id
                                      ,nb_id
                                      ,dat
                                      ,bestand_id
                                      ,bezugsweg_id
                                      ,relevant_fg
                                      ,menge_lgbest_erp_frei_bme
                                      ,menge_lgbest_erp_qual_bme
                                      ,fortschreibung_fg
                                      ,td_insert
                                      ,td_update
                                      ,menge_lgbest_erp_gesp_bme)
select a.mandant_id
      ,a.art_id
      ,a.wup_id
      ,b.nb_id
      ,a.dat
      ,-9999 as bestand_id
      ,1 as bezugsweg_id
      ,0 as relevant_fg
      ,a.menge_frei as menge_lgbest_erp_frei_bme
      ,a.menge_qual as menge_lgbest_erp_qual_bme
      ,0 as fortschreibung_fg
      ,current_timestamp as td_insert
      ,current_timestamp as td_update
      ,a.menge_gesp as menge_lgbest_erp_gesp_bme
from _bestand a
join dbp_data.wup_1 b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id
where (a.mandant_id,a.wup_id,a.art_id,a.dat) not in (select mandant_id,wup_id,art_id,dat
                                                     from dbp_data.marktbestand_erp_1
                                                     where dat between (select min(dat) from _bestand) and current_date and
                                                           mandant_id > 1) and
       a.mandant_id > 1
;

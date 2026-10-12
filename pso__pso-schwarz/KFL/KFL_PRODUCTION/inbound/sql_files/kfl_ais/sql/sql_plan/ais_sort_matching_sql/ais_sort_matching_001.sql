delete from dbp_etl.art_matching_nielsen_per
where kjwo_update < (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per)
;

create or replace volatile table _art_nielsen as (
select *
from dbp_data.art_nielsen
where dat_bis = '9999-12-31'
);

create or replace volatile table _kl_facts as (
select a.mandant_id,
       a.art_id
from dbp_etl.kl_basis_listung a
union
select a.mandant_id,
       a.art_id
from dbp_data.artbew_wo_sum a
join dbp_data.woche_kj_kl b
  on a.kjwo_kl = b.kjwo_kl
join dbp_data.art_wg_zu_per d
  on a.mandant_id = d.mandant_id and
     a.art_id = d.art_id and
     d.arthiertyp_id = 2 and
     d.dat_bis = '9999-12-31'
join (select wg_id
      from dbp_data.wg_filter_zu
      where wg_filter_id = 47
      group by 1) e
  on d.wg_id = e.wg_id
where (a.mandant_id,b.kjwo) in (select x.mandant_id,
                                       x.kjwo
                                from (select b.mandant_id,
                                             c.kjwo,
                                             rank() over (partition by b.mandant_id order by b.mandant_id,c.kjwo desc) * (-1) as akt_wo
                                      from DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM a
                                      join (select mandant_id,
                                                   max(kjmo) as kjmo
                                            from dbp_data.sortiment_leistung
                                            where mandant_id = 1
                                            group by 1) b
                                        on a.kjmo_sort = b.kjmo
                                      join dbp_data.woche c
                                        on c.kjwo <= a.kjwo_bis) x
                                where x.akt_wo between -52 and -1
                                group by 1,2) and
      (a.mandant_id,a.art_id) not in (select mandant_id,art_id
                                      from dbp_data.art_gp_zu_per
                                      where mandant_id = 1 and
                                            gp_id = 5059720 and
                                            dat_bis = '9999-12-31'
                                      group by 1,2) 
group by 1,2
having sum(a.menge) > 0 
);

create or replace volatile table _distinct_nl_arts as (
select a.mandant_id,
       a.art_nielsen_id,
       a.gtin_id
from _art_nielsen a
where a.mandant_id = 1
group by 1,2,3
);

-- step1 for kl-articles

create or replace volatile table _article_matching0 as (
select a.mandant_id,
       a.art_nielsen_id,
       b.art_id,
       a.gtin_id
from _distinct_nl_arts a
join (select *
      from dbp_etl_process.art_gtin a
      where mandant_id = 1 and
           (mandant_id,art_id) not in (select mandant_id,art_id
                                       from dbp_data.art_gp_zu_per
                                       where mandant_id = 1 and
                                             gp_id = 5059720 and
                                             dat_bis = '9999-12-31'
                                       group by 1,2)) b
  on a.gtin_id = b.gtin_id and
     a.mandant_id = b.mandant_id
group by 1,2,3,4
);

-- step2 for kl-articles

insert into _article_matching0
select a.mandant_id,
       -1 as art_nielsen_id,
       a.art_id,
       b.gtin_id
from _kl_facts a
join (select *
      from dbp_etl_process.art_gtin a
      where mandant_id = 1 and
           (mandant_id,art_id) not in (select mandant_id,art_id
                                       from dbp_data.art_gp_zu_per
                                       where mandant_id = 1 and
                                             gp_id = 5059720 and
                                             dat_bis = '9999-12-31'
                                       group by 1,2)) b
  on a.art_id = b.art_id and
     a.mandant_id = b.mandant_id
where (a.mandant_id,a.art_id) not in (select mandant_id,art_id from _article_matching0)
group by 1,2,3,4
;

-- step3 for nl-articles

insert into _article_matching0
select mandant_id,
       art_nielsen_id,
       -1 as art_id,
       gtin_id
from _distinct_nl_arts
where (mandant_id,art_nielsen_id,gtin_id) not in (select mandant_id,art_nielsen_id,gtin_id from _article_matching0)
group by 1,2,3,4
;

create or replace volatile table _nielsen_kl_matching (
  mandant_id byteint not null,
  matching_id integer not null,
  art_nielsen_id integer not null,
  art_id integer not null,
  gtin_id decimal(18,0) not null
);

insert into _nielsen_kl_matching
select mandant_id,
       -1 as matching_id,
       art_nielsen_id,
       art_id,
       gtin_id
from _article_matching0
;

merge into _nielsen_kl_matching a using (select mandant_id,
                                                art_matching_id,
                                                art_nielsen_id,
                                                art_id,
                                                gtin_id
                                         from dbp_etl.art_matching_nielsen_per
                                         group by 1,2,3,4,5) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.art_nielsen_id = b.art_nielsen_id and
     a.gtin_id = b.gtin_id

when matched then update set a.matching_id = b.art_matching_id
;

EXECUTE IMMEDIATE $$
BEGIN
  LET loop_counter1 INTEGER := (select 1);
  LET loop_counter2 INTEGER := (select 1);
  LET loop_counter3 INTEGER := (select 1);
  LET loop_counter_value INTEGER := 0;
  
  WHILE ((loop_counter1+loop_counter2+loop_counter3) > 0) DO
    update _nielsen_kl_matching from (select mandant_id,
                                             max(matching_id) as art_matching_id,
                                             art_id
                                      from _nielsen_kl_matching
                                      where matching_id <> -1 and
                                            art_id <> -1
                                      group by 1,3) b 
                                      
    set matching_id = b.art_matching_id
    
    where _nielsen_kl_matching.mandant_id = b.mandant_id and
          _nielsen_kl_matching.art_id = b.art_id and
          _nielsen_kl_matching.matching_id = -1
    ;
    
    loop_counter1 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));

    update _nielsen_kl_matching from (select mandant_id,
                                             max(matching_id) as art_matching_id,
                                             art_nielsen_id
                                      from _nielsen_kl_matching
                                      where matching_id <> -1 and
                                            art_nielsen_id <> -1
                                      group by 1,3) b 
                                      
    set matching_id = b.art_matching_id
    
    where _nielsen_kl_matching.mandant_id = b.mandant_id and
          _nielsen_kl_matching.art_nielsen_id = b.art_nielsen_id and
          _nielsen_kl_matching.matching_id = -1
    ;

    loop_counter2 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    
    update _nielsen_kl_matching from (select mandant_id,
                                             max(matching_id) as art_matching_id,
                                             gtin_id
                                      from _nielsen_kl_matching
                                      where matching_id <> -1 and
                                            gtin_id not in (-9999,-9998)
                                      group by 1,3) b 
                                      
    set matching_id = b.art_matching_id
    
    where _nielsen_kl_matching.mandant_id = b.mandant_id and
          _nielsen_kl_matching.gtin_id = b.gtin_id and
          _nielsen_kl_matching.matching_id = -1
    ;
  
    loop_counter3 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    loop_counter_value := loop_counter_value + 1;
  END WHILE;

  RETURN loop_counter_value;

END;
$$
;

update _nielsen_kl_matching from (select mandant_id,
                                         max(art_matching_id) as art_matching_id,
                                         gtin_id
                                  from dbp_etl.art_matching_nielsen_per
                                  where art_id <> -1 and
                                        gtin_id not in (-9999,-9998) and
                                        status = 'T'
                                  group by 1,3) b
                                  
set matching_id = b.art_matching_id

where _nielsen_kl_matching.mandant_id = b.mandant_id and
      _nielsen_kl_matching.gtin_id = b.gtin_id and
      _nielsen_kl_matching.matching_id = -1
;

update _nielsen_kl_matching from (select mandant_id,
                                         max(art_matching_id) as art_matching_id,
                                         gtin_id
                                  from dbp_etl.art_matching_nielsen_per
                                  where art_id <> -1 and
                                        gtin_id not in (-9999,-9998) and
                                        status = 'N'
                                  group by 1,3) b
                                  
set matching_id = b.art_matching_id

where _nielsen_kl_matching.mandant_id = b.mandant_id and
      _nielsen_kl_matching.gtin_id = b.gtin_id and
      _nielsen_kl_matching.matching_id = -1
;

update _nielsen_kl_matching from (select mandant_id,
                                         max(matching_id) as art_matching_id,
                                         art_id
                                  from _nielsen_kl_matching
                                  where matching_id <> -1 and
                                        art_id <> -1
                                  group by 1,3) b
                                  
set matching_id = b.art_matching_id

where _nielsen_kl_matching.mandant_id = b.mandant_id and
      _nielsen_kl_matching.art_id = b.art_id and
      _nielsen_kl_matching.matching_id = -1
;

update _nielsen_kl_matching from (select mandant_id,
                                         max(matching_id) as art_matching_id,
                                         art_nielsen_id
                                  from _nielsen_kl_matching
                                  where matching_id <> -1 and
                                        art_nielsen_id <> -1
                                  group by 1,3) b
                                  
set matching_id = b.art_matching_id

where _nielsen_kl_matching.mandant_id = b.mandant_id and
      _nielsen_kl_matching.art_nielsen_id = b.art_nielsen_id and
      _nielsen_kl_matching.matching_id = -1
;

create or replace volatile table _nielsen_kl_matching_final as (
select *
from _nielsen_kl_matching
where matching_id <> -1
);

delete from _nielsen_kl_matching
where matching_id <> -1
;

-- 1st run for kl-/nl-articles

create or replace volatile table _upd_new_match as (
select mandant_id,
      (select max(matching_id) from _nielsen_kl_matching_final where mandant_id = 1) as art_matching_id,
       art_nielsen_id,
       art_id,
       gtin_id,
       dense_rank() over (order by mandant_id,art_id) as rang
from _nielsen_kl_matching
where art_id <> -1 and
      art_nielsen_id <> -1
);

insert into _nielsen_kl_matching_final (mandant_id,
                                        matching_id,
                                        art_nielsen_id,
                                        art_id,
                                        gtin_id)
select a.mandant_id,
       a.art_matching_id+rang,
       a.art_nielsen_id,
       a.art_id,
       a.gtin_id
from _upd_new_match a
;

delete from _nielsen_kl_matching
where (mandant_id,art_id) in (select mandant_id,art_id from _nielsen_kl_matching_final where art_id <> -1 and art_nielsen_id <> -1)
;

-- 2nd run for kl-articles

create or replace volatile table _upd_new_match as (
select mandant_id,
      (select max(matching_id) from _nielsen_kl_matching_final where mandant_id = 1) as art_matching_id,
       art_nielsen_id,
       art_id,
       gtin_id,
       dense_rank() over (order by mandant_id,art_id) as rang
from _nielsen_kl_matching
where art_id <> -1
);

insert into _nielsen_kl_matching_final (mandant_id,
                                        matching_id,
                                        art_nielsen_id,
                                        art_id,
                                        gtin_id)
select a.mandant_id,
       a.art_matching_id+rang,
       a.art_nielsen_id,
       a.art_id,
       a.gtin_id
from _upd_new_match a
;

delete from _nielsen_kl_matching
where (mandant_id,art_id) in (select mandant_id,art_id from _nielsen_kl_matching_final where art_id <> -1)
;

-- 3rd run for nl-articles

create or replace volatile table _upd_new_match as (
select b.mandant_id,
      (select max(matching_id) from _nielsen_kl_matching_final where mandant_id = 1) as art_matching_id,
       b.art_nielsen_id,
       a.art_id,
       a.gtin_id,
       dense_rank() over (order by a.mandant_id,a.art_nielsen_id) as rang
from _nielsen_kl_matching a
join _art_nielsen b
  on a.mandant_id = b.mandant_id and
     a.art_nielsen_id = b.art_nielsen_id
where a.art_nielsen_id <> -1
);

insert into _nielsen_kl_matching_final (mandant_id,
                                        matching_id,
                                        art_nielsen_id,
                                        art_id,
                                        gtin_id)
select a.mandant_id,
       a.art_matching_id+rang,
       a.art_nielsen_id,
       a.art_id,
       a.gtin_id
from _upd_new_match a
;

delete from _nielsen_kl_matching
where (mandant_id,art_nielsen_id) in (select mandant_id,art_nielsen_id from _nielsen_kl_matching_final where art_nielsen_id <> -1)
;

update _nielsen_kl_matching_final from (select mandant_id,
                                               art_id,
                                               count(distinct matching_id) as anz_match,
                                               max(matching_id) as max_match,
                                               min(art_id) as min_art_id,
                                               max(art_id) as max_art_id
                                        from _nielsen_kl_matching_final
                                        where art_id <> -1
                                        group by 1,2
                                        having anz_match > 1 and
                                               min_art_id = max_art_id) b
                                               
set matching_id = max_match

where _nielsen_kl_matching_final.mandant_id = b.mandant_id and
      _nielsen_kl_matching_final.art_id = b.art_id
;

-------------------------------------- INSERT -------------------------------------

create or replace table dbp_etl.art_matching_nielsen_per_final like dbp_etl.art_matching_nielsen_per;

insert into dbp_etl.art_matching_nielsen_per_final
select distinct
       mandant_id,
       matching_id,
       art_id,
       art_nielsen_id,
       gtin_id,
       0,0,0,0,1,'N',null,0,(select c.kjwo
                             from dbp_data.woche a
                             join (select max(kjwo_update) as kjwo_update
                                   from dbp_data.sortiment_leistung
                                   where mandant_id = 1) b
                               on a.kjwo = b.kjwo_update
                             join dbp_data.woche c
                               on a.akt_wo = c.akt_wo-1),current_timestamp,current_timestamp
from _nielsen_kl_matching_final
where (mandant_id,matching_id,art_nielsen_id,art_id) not in (select mandant_id,art_matching_id,art_nielsen_id,art_id from dbp_etl.art_matching_nielsen_per_final)
;

-------------------------------------- TESTING START -------------------------------------

EXECUTE IMMEDIATE $$
BEGIN
  LET loop_counter1 INTEGER := (select 1);
  LET loop_counter2 INTEGER := (select 1);
  LET loop_counter3 INTEGER := (select 1);
  LET loop_counter_value INTEGER := 0;
  
  WHILE ((loop_counter1+loop_counter2+loop_counter3) > 0) DO
    update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               art_nielsen_id
                                                        from dbp_etl.art_matching_nielsen_per_final
                                                        where art_nielsen_id <> -1
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_final.art_nielsen_id = b.art_nielsen_id
    ;
    
    loop_counter1 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));

    update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               art_id
                                                        from dbp_etl.art_matching_nielsen_per_final
                                                        where art_id <> -1
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_final.art_id = b.art_id
    ;

    loop_counter2 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    
    update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               gtin_id
                                                        from dbp_etl.art_matching_nielsen_per_final
                                                        where gtin_id not in (-9999,-9998)
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_final.gtin_id = b.gtin_id
    ;

    loop_counter3 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    
    loop_counter_value := loop_counter_value + 1;
  END WHILE;

RETURN loop_counter_value;

END;
$$
;

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           art_id,
                                                           status
                                                    from dbp_etl_process.art_art_nielsen_groups
                                                    where mandant_id = 1
                                                    group by 1,2,3) b
                  
set status = b.status

where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_id = b.art_id
;

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           art_id,
                                                           wg_id,
                                                           wug_id
                                                    from dbp_data.art_wg_zu_per
                                                    where dat_bis = '9999-12-31' and
                                                          arthiertyp_id = 2 and
                                                          mandant_id = 1
                                                    group by 1,2,3,4) b

set kl_owg_id = b.wg_id,
    kl_uwg_id = b.wug_id
	
where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_id = b.art_id and
      dbp_etl.art_matching_nielsen_per_final.art_id <> -1 and
     (dbp_etl.art_matching_nielsen_per_final.kl_owg_id <> b.wg_id or
      dbp_etl.art_matching_nielsen_per_final.kl_uwg_id <> b.wug_id)
;

update dbp_etl.art_matching_nielsen_per_final from (select *
                                                    from dbp_data.wg_per
                                                    where dat_bis = '9999-12-31' and
                                                          mandant_id = 1 and
                                                          owg_id <> -1) b

set kl_wg_id = b.owg_id
	
where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.kl_owg_id = b.wg_id and
      dbp_etl.art_matching_nielsen_per_final.art_id <> -1 and
      dbp_etl.art_matching_nielsen_per_final.kl_wg_id <> b.owg_id
;

-- 03.02.2019, -dbay-
--
-- Warengruppenhierarchie fuer Matchings ueber alle Ebenen sauber
-- hinstellen!

-- 1. OWG
create or replace volatile table _track_distinct as (
select mandant_id,
       art_matching_id,
       count(*) as anz,
       count(distinct kl_wg_id) as anz_wg
from dbp_etl.art_matching_nielsen_per_final
group by 1,2
having count(distinct kl_wg_id) > 1
);

create or replace volatile table _track_distinct2 as (
select a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       count(*) as anzahl
from dbp_etl.art_matching_nielsen_per_final a
join _track_distinct b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
where a.art_id not in (select art_id from dbp_data.art where mandant_id = 1 and trim(loesch_id) in ('L','R'))
group by 1,2,3,4,5
);

update dbp_etl.art_matching_nielsen_per_final from (
select a.mandant_id,
       a.art_matching_id,
       min(a.kl_wg_id) as kl_wg_id,
       min(a.kl_owg_id) as kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from _track_distinct2 a
join (select mandant_id,
             art_matching_id,
             max(anzahl) as anzahl
      from _track_distinct2
      where kl_wg_id <> -3
      group by 1,2) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id and
     a.anzahl = b.anzahl
where a.kl_wg_id > 0 and a.kl_owg_id > 0 and a.kl_uwg_id >0
group by 1,2
) x

set kl_wg_id = x.kl_wg_id,
    kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_final.mandant_id = x.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id = x.art_matching_id
;

-- 2. WG
create or replace volatile table _track_distinct_owg_1 as (
select mandant_id,
       art_matching_id,
       kl_wg_id,
       count(*) as anz,
       count(distinct kl_owg_id) as anz_owg
from dbp_etl.art_matching_nielsen_per_final
group by 1,2,3
having count(distinct kl_owg_id) > 1
);

create or replace volatile table _track_distinct_owg_2 as (
select a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       count(*) as anzahl
from dbp_etl.art_matching_nielsen_per_final a
join _track_distinct_owg_1 b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
where a.art_id not in (select art_id from dbp_data.art where mandant_id = 1 and trim(loesch_id) in ('L','R'))
group by 1,2,3,4,5
);

update dbp_etl.art_matching_nielsen_per_final from (
select a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       min(a.kl_owg_id) as kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from _track_distinct_owg_2 a
join (select mandant_id,
             art_matching_id,
             kl_wg_id,
             max(anzahl) as anzahl
      from _track_distinct_owg_2
      where kl_owg_id <> -3
      group by 1,2,3) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id and
     a.anzahl = b.anzahl and
     a.kl_wg_id = b.kl_wg_id
where a.kl_wg_id > 0 and a.kl_owg_id > 0 and a.kl_uwg_id >0
group by 1,2,3) x

set kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_final.mandant_id = x.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id = x.art_matching_id
;

-- 3. WGI
create or replace volatile table _track_distinct_uwg_1 as (
select mandant_id,
       art_matching_id,
       kl_wg_id,
       kl_owg_id,
       count(*) as anz,
       count(distinct kl_uwg_id) as anz_uwg
from dbp_etl.art_matching_nielsen_per_final
group by 1,2,3,4
having count(distinct kl_uwg_id) > 1
);

create or replace volatile table _track_distinct_uwg_2 as (
select a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       count(*) as anzahl
from dbp_etl.art_matching_nielsen_per_final a
join _track_distinct_uwg_1 b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id and
     a.kl_wg_id = b.kl_wg_id and
     a.kl_owg_id = b.kl_owg_id
where a.art_id not in (select art_id from dbp_data.art where mandant_id = 1 and trim(loesch_id) in ('L','R'))
group by 1,2,3,4,5
);

update dbp_etl.art_matching_nielsen_per_final from (
select a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from _track_distinct_uwg_2 a
join (select mandant_id,
             art_matching_id,
             kl_wg_id,
             kl_owg_id,
             max(anzahl) as anzahl
      from _track_distinct_uwg_2
      where kl_uwg_id <> -3
      group by 1,2,3,4) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id and
     a.anzahl = b.anzahl and
     a.kl_wg_id = b.kl_wg_id and
     a.kl_owg_id = b.kl_owg_id
where a.kl_wg_id > 0 and a.kl_owg_id > 0 and a.kl_uwg_id >0
group by 1,2,3,4) x

set kl_uwg_id = x.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_final.mandant_id = x.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id = x.art_matching_id
;

-- 03.02.2019, -dbay-
--
-- Warengruppen von BI gepflegt muessen hier angezogen werden.

create or replace volatile table _sort_pflege_fehler as (
select a.*
from dbp_data.art_nielsen_wug_zu_pflege a
left join (select a.mandant_id,
                  a.wg_id,
                  max(wfz.wug_id) as wug_id
           from dbp_data.wg_per a
           join dbp_data.wg_filter_zu wfz
             on a.wg_id = wfz.wg_id and 
                a.mandant_id = wfz.mandant_id and 
                wfz.wg_filter_id = 11 and 
                wfz.arthiertyp_id = 2
           group by 1,2) b
  on a.mandant_id = b.mandant_id and
     a.fb_pflege_wg_id = b.wg_id
where b.wug_id is null and
      a.kalk_vorschl_wg_id <> -1 and
      a.fb_pflege_wg_id <> -1
);

update dbp_data.art_nielsen_wug_zu_pflege from (select *
                                                from _sort_pflege_fehler) b

set fb_pflege_wg_id = -1,
    fb_pflege_wug_id = -1
    
where dbp_data.art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id and
      dbp_data.art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id
;

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           art_nielsen_id,
                                                           case when fb_pflege_wg_id  = -1 then kalk_vorschl_wg_id  else fb_pflege_wg_id  end as wg_id_neu,
                                                           case when fb_pflege_wug_id = -1 then kalk_vorschl_wug_id else fb_pflege_wug_id end as wug_id_neu
                                                    from dbp_data.art_nielsen_wug_zu_pflege
                                                    where mandant_id = 1) b

set kl_owg_id = b.wg_id_neu,
    kl_uwg_id = b.wug_id_neu
	
where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_nielsen_id = b.art_nielsen_id  and
      dbp_etl.art_matching_nielsen_per_final.art_id = -1 and
     (dbp_etl.art_matching_nielsen_per_final.kl_owg_id <> b.wg_id_neu or
      dbp_etl.art_matching_nielsen_per_final.kl_uwg_id <> b.wug_id_neu)
;

update dbp_etl.art_matching_nielsen_per_final from (select *
                                                    from dbp_data.wg_per
                                                    where dat_bis = '9999-12-31' and
                                                          owg_id > 0) b

set kl_wg_id = b.owg_id
	
where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.kl_owg_id = b.wg_id
;

create or replace volatile table _potenzial_hier as (
select mandant_id,
       art_matching_id,
       gtin_id,
       max(kl_wg_id) as kl_wg_id,
       max(kl_owg_id) as kl_owg_id,
       max(kl_uwg_id) as kl_uwg_id
from dbp_etl.art_matching_nielsen_per_final
where (mandant_id,gtin_id) in (select mandant_id,
                                      gtin_id
                               from dbp_etl.art_matching_nielsen_per_final
                               where art_id = -1 and
                                     gtin_id not in (-9999,-9998)
                               group by 1,2
                               having count(*) > 1)
group by 1,2,3
);

update dbp_etl.art_matching_nielsen_per_final from (select *
                                                    from _potenzial_hier) b
                                              
set kl_wg_id  = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id = b.art_matching_id and
      dbp_etl.art_matching_nielsen_per_final.gtin_id = b.gtin_id
;

-- 31.05.2019, -dbay-
--
-- An dieser Stelle wird das Listungskennzeichen platziert. 

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           art_id,
                                                           min(list_kz) as list_kz
                                                    from dbp_etl.kl_basis_listung
                                                    group by 1,2) b
                                  
set list_kz = b.list_kz

where dbp_etl.art_matching_nielsen_per_final.art_id = b.art_id and
      dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id
;

update dbp_etl.art_matching_nielsen_per_final set komponente_fg = 0
;

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           art_id,
                                                           wg_id,
                                                           wug_id
                                                    from dbp_data.art_wg_zu_per
                                                    where dat_bis = '9999-12-31' and
                                                          arthiertyp_id = 2 and
                                                          mandant_id = 1
                                                    group by 1,2,3,4) b

set kl_owg_id = b.wg_id,
    kl_uwg_id = b.wug_id
	
where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_id = b.art_id and
      dbp_etl.art_matching_nielsen_per_final.art_id <> -1 and
     (dbp_etl.art_matching_nielsen_per_final.kl_owg_id <> b.wg_id or
      dbp_etl.art_matching_nielsen_per_final.kl_uwg_id <> b.wug_id)
;

update dbp_etl.art_matching_nielsen_per_final from (select *
                                                    from dbp_data.wg_per
                                                    where dat_bis = '9999-12-31' and
                                                          mandant_id = 1 and
                                                          owg_id <> -1) b

set kl_wg_id = b.owg_id
	
where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.kl_owg_id = b.wg_id and
      dbp_etl.art_matching_nielsen_per_final.art_id <> -1 and
      dbp_etl.art_matching_nielsen_per_final.kl_wg_id <> b.owg_id
;

-- 03.02.2019, -dbay-
--
-- Warengruppenhierarchie fuer Matchings ueber alle Ebenen sauber
-- hinstellen!

-- 1. OWG
create or replace volatile table _track_distinct as (
select mandant_id,
       art_matching_id,
       count(*) as anz,
       count(distinct kl_wg_id) as anz_wg
from dbp_etl.art_matching_nielsen_per_final
group by 1,2
having count(distinct kl_wg_id) > 1
);

create or replace volatile table _track_distinct2 as (
select a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       count(*) as anzahl
from dbp_etl.art_matching_nielsen_per_final a
join _track_distinct b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
where a.art_id not in (select art_id from dbp_data.art where mandant_id = 1 and trim(loesch_id) in ('L','R'))
group by 1,2,3,4,5
);

update dbp_etl.art_matching_nielsen_per_final from (
select a.mandant_id,
       a.art_matching_id,
       min(a.kl_wg_id) as kl_wg_id,
       min(a.kl_owg_id) as kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from _track_distinct2 a
join (select mandant_id,
             art_matching_id,
             max(anzahl) as anzahl
      from _track_distinct2
      where kl_wg_id <> -3
      group by 1,2) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id and
     a.anzahl = b.anzahl
where a.kl_wg_id > 0 and a.kl_owg_id > 0 and a.kl_uwg_id >0
group by 1,2
) x

set kl_wg_id = x.kl_wg_id,
    kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_final.mandant_id = x.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id = x.art_matching_id
;

-- 2. WG
create or replace volatile table _track_distinct_owg_1 as (
select mandant_id,
       art_matching_id,
       kl_wg_id,
       count(*) as anz,
       count(distinct kl_owg_id) as anz_owg
from dbp_etl.art_matching_nielsen_per_final
group by 1,2,3
having count(distinct kl_owg_id) > 1
);

create or replace volatile table _track_distinct_owg_2 as (
select a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       count(*) as anzahl
from dbp_etl.art_matching_nielsen_per_final a
join _track_distinct_owg_1 b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
where a.art_id not in (select art_id from dbp_data.art where mandant_id = 1 and trim(loesch_id) in ('L','R'))
group by 1,2,3,4,5
);

update dbp_etl.art_matching_nielsen_per_final from (
select a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       min(a.kl_owg_id) as kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from _track_distinct_owg_2 a
join (select mandant_id,
             art_matching_id,
             kl_wg_id,
             max(anzahl) as anzahl
      from _track_distinct_owg_2
      where kl_owg_id <> -3
      group by 1,2,3) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id and
     a.anzahl = b.anzahl and
     a.kl_wg_id = b.kl_wg_id
where a.kl_wg_id > 0 and a.kl_owg_id > 0 and a.kl_uwg_id >0
group by 1,2,3) x

set kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_final.mandant_id = x.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id = x.art_matching_id
;

-- 3. WGI
create or replace volatile table _track_distinct_uwg_1 as (
select mandant_id,
       art_matching_id,
       kl_wg_id,
       kl_owg_id,
       count(*) as anz,
       count(distinct kl_uwg_id) as anz_uwg
from dbp_etl.art_matching_nielsen_per_final
group by 1,2,3,4
having count(distinct kl_uwg_id) > 1
);

create or replace volatile table _track_distinct_uwg_2 as (
select a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       count(*) as anzahl
from dbp_etl.art_matching_nielsen_per_final a
join _track_distinct_uwg_1 b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id and
     a.kl_wg_id = b.kl_wg_id and
     a.kl_owg_id = b.kl_owg_id
where a.art_id not in (select art_id from dbp_data.art where mandant_id = 1 and trim(loesch_id) in ('L','R'))
group by 1,2,3,4,5
);

update dbp_etl.art_matching_nielsen_per_final from (
select a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from _track_distinct_uwg_2 a
join (select mandant_id,
             art_matching_id,
             kl_wg_id,
             kl_owg_id,
             max(anzahl) as anzahl
      from _track_distinct_uwg_2
      where kl_uwg_id <> -3
      group by 1,2,3,4) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id and
     a.anzahl = b.anzahl and
     a.kl_wg_id = b.kl_wg_id and
     a.kl_owg_id = b.kl_owg_id
where a.kl_wg_id > 0 and a.kl_owg_id > 0 and a.kl_uwg_id >0
group by 1,2,3,4) x

set kl_uwg_id = x.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_final.mandant_id = x.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id = x.art_matching_id
;

-- correct state settings, only differentiated between 'N' (regular) and 'T' (tupel)
  
update dbp_etl.art_matching_nielsen_per_final from (select art_matching_id,
                                                           count(distinct case when art_id = -1 then null else art_id end) as anz_art,
                                                           count(distinct case when art_nielsen_id = -1 then null else art_nielsen_id end) as anz_art_nielsen
                                                    from dbp_etl.art_matching_nielsen_per_final
                                                    where mandant_id = 1
                                                    group by 1
                                                    having (anz_art = 0 and
                                                            anz_art_nielsen = 1) or
                                                           (anz_art = 1 and
                                                            anz_art_nielsen = 0) or
                                                           (anz_art = 1 and
                                                            anz_art_nielsen = 1)) b

set status = 'N'

where dbp_etl.art_matching_nielsen_per_final.art_matching_id = b.art_matching_id and
      dbp_etl.art_matching_nielsen_per_final.mandant_id = 1
;
  
update dbp_etl.art_matching_nielsen_per_final from (select art_matching_id,
                                                           count(distinct case when art_id = -1 then null else art_id end) as anz_art,
                                                           count(distinct case when art_nielsen_id = -1 then null else art_nielsen_id end) as anz_art_nielsen
                                                    from dbp_etl.art_matching_nielsen_per_final
                                                    where mandant_id = 1
                                                    group by 1
                                                    having anz_art > 1) b

set status = 'T'

where dbp_etl.art_matching_nielsen_per_final.art_matching_id = b.art_matching_id and
      dbp_etl.art_matching_nielsen_per_final.mandant_id = 1
;

-- That's it --

create or replace volatile table _get_it_straight as (
select mandant_id,
       art_nielsen_id,
       max(art_id) as max_art_id,
       min(art_matching_id) as min_match,
       max(art_matching_id) as max_match,
       count(distinct art_matching_id) as anz_match,
       count(distinct case when art_id = -1 then null else art_id end) as anz_art,
       max(kl_wg_id) as kl_wg_id,
       max(kl_owg_id) as kl_owg_id,
       max(kl_uwg_id) as kl_uwg_id
from dbp_etl.art_matching_nielsen_per_final
group by 1,2
having anz_match > 1 and
       anz_art = 1
);

update dbp_etl.art_matching_nielsen_per_final from (select *
                                                    from _get_it_straight) b
                                              
set art_matching_id = b.min_match,
    art_id = b.max_art_id,
    kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id

where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_nielsen_id = b.art_nielsen_id
;

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           art_matching_id,
                                                           max(kl_wg_id) as max_kl_wg_id,
                                                           max(kl_owg_id) as max_kl_owg_id,
                                                           min(kl_uwg_id) as max_kl_uwg_id
                                                    from dbp_etl.art_matching_nielsen_per_final
                                                    group by 1,2
                                                    having count(distinct kl_wg_id)  > 1 or
                                                           count(distinct kl_owg_id) > 1 or
                                                           count(distinct kl_uwg_id) > 1) b
                                                     
set kl_wg_id = b.max_kl_wg_id,
    kl_owg_id = b.max_kl_owg_id,
    kl_uwg_id = b.max_kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id = b.art_matching_id
;

-------- FINAL STEP FOR GROUPS -----------
create or replace volatile table _gp as 
(select mandant_id,art_id
 from dbp_data.art_gp_zu_per
 where mandant_id = 1 and
       gp_id = 5059720 and
       dat_bis = '9999-12-31'
 group by 1,2)
;

create or replace volatile table _track_artikel as (
select b.*
from dbp_data.art_gruppe a
join dbp_data.art_gruppe_art_zu b
  on a.art_gruppe_id = b.art_gruppe_id
where a.art_gruppe_kategorie = 'Sortimentstool' and b.art_id not in (select art_id from _gp) and
      b.mandant_id = 1 and
      a.art_gruppe_id in (select b.art_gruppe_id
                          from dbp_data.art_gruppe a
                          join dbp_data.art_gruppe_art_zu b
                            on a.art_gruppe_id = b.art_gruppe_id
                          where a.art_gruppe_kategorie = 'Sortimentstool' and
                                b.mandant_id = 1 
                          group by 1)
);

insert into dbp_etl.art_matching_nielsen_per_final (mandant_id
                                             ,art_matching_id
                                             ,art_id
                                             ,art_nielsen_id
                                             ,gtin_id
                                             ,kl_art_kat_id
                                             ,kl_wg_id
                                             ,kl_owg_id
                                             ,kl_uwg_id
                                             ,umrech_faktor
                                             ,status
                                             ,list_kz
                                             ,komponente_fg
                                             ,kjwo_update)
select distinct 
       mandant_id
      ,art_matching_id
      ,art_id
      ,art_nielsen_id
      ,gtin_id
      ,kl_art_kat_id
      ,kl_wg_id
      ,kl_owg_id
      ,kl_uwg_id
      ,umrech_faktor
      ,status
      ,list_kz
      ,komponente_fg
      ,kjwo_update
from (select b.mandant_id,
             b.art_matching_id,
             b.art_id,
             -1 as art_nielsen_id,
             c.gtin_id,
             0 as kl_art_kat_id,
             0 as kl_wg_id,
             0 as kl_owg_id,
             0 as kl_uwg_id,
             b.umrech_faktor,
            'N' as status,
            'A' as list_kz,
             0 as komponente_fg,
            (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_final) as kjwo_update
      from (select art_id
            from _track_artikel
            where art_id not in (select art_id from dbp_etl.art_matching_nielsen_per_final)
            group by 1) bx
      join dbp_etl_process.art_art_nielsen_groups b
        on bx.art_id = b.art_id
      join (select mandant_id,
                   art_id,
                   max(gtin_id) as gtin_id
            from dbp_etl_process.art_gtin
            where mandant_id = 1
            group by 1,2) c
        on b.mandant_id = c.mandant_id and
           b.art_id = c.art_id) z
;

update dbp_etl.art_matching_nielsen_per_final from (select x.mandant_id,
                                                           x.art_matching_id,
                                                           max(x.max_match) as max_match
                                                    from (select a.mandant_id,
                                                                 a.art_gruppe_id,
                                                                 b.art_matching_id,
                                                                 max(b.art_matching_id) over (partition by a.mandant_id,a.art_gruppe_id order by a.mandant_id,a.art_gruppe_id) AS max_match
                                                          from dbp_etl_process.art_art_nielsen_groups a
                                                          join dbp_etl.art_matching_nielsen_per_final b
                                                            on a.mandant_id = b.mandant_id and
                                                               a.art_id = b.art_id
                                                          group by 1,2,3) x
                                                    group by 1,2) b
                    
set art_matching_id = b.max_match

where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id = b.art_matching_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id <> b.max_match
;

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           max(art_matching_id) as art_matching_id,
                                                           gtin_id
                                                    from dbp_etl.art_matching_nielsen_per_final
                                                    where gtin_id not in (-9999,-9998)
                                                    group by 1,3
                                                    having count(distinct art_matching_id) > 1) b
                                  
set art_matching_id = b.art_matching_id

where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.gtin_id = b.gtin_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id <> b.art_matching_id
;

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           art_id,
                                                           min(art_matching_id) as min_match,
                                                           max(art_matching_id) as max_match
                                                    from dbp_etl.art_matching_nielsen_per_final
                                                    where art_id <> -1
                                                    group by 1,2
                                                    having count(distinct art_matching_id) > 1) b
                                                    
set art_matching_id = b.max_match

where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_id = b.art_id
;

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           max(art_matching_id) as art_matching_id,
                                                           gtin_id
                                                    from dbp_etl.art_matching_nielsen_per_final
                                                    where gtin_id not in (-9999,-9998)
                                                    group by 1,3
                                                    having count(distinct art_matching_id) > 1) b
                                  
set art_matching_id = b.art_matching_id

where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.gtin_id = b.gtin_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id <> b.art_matching_id
;

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           max(art_matching_id) as art_matching_id,
                                                           art_id
                                                    from dbp_etl.art_matching_nielsen_per_final
                                                    where art_id <> -1
                                                    group by 1,3
                                                    having count(distinct art_matching_id) > 1) b
                                  
set art_matching_id = b.art_matching_id

where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_id = b.art_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id <> b.art_matching_id
;

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           max(art_matching_id) as art_matching_id,
                                                           gtin_id
                                                    from dbp_etl.art_matching_nielsen_per_final
                                                    where gtin_id not in (-9999,-9998)
                                                    group by 1,3
                                                    having count(distinct art_matching_id) > 1) b
                                  
set art_matching_id = b.art_matching_id

where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.gtin_id = b.gtin_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id <> b.art_matching_id
;

update dbp_etl.art_matching_nielsen_per_final from (select mandant_id,
                                                           max(art_matching_id) as art_matching_id,
                                                           art_id
                                                    from dbp_etl.art_matching_nielsen_per_final
                                                    where art_id <> -1
                                                    group by 1,3
                                                    having count(distinct art_matching_id) > 1) b
                                  
set art_matching_id = b.art_matching_id

where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_id = b.art_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id <> b.art_matching_id
;

update dbp_etl.art_matching_nielsen_per_final from (select x.mandant_id,
                                                           x.art_matching_id,
                                                           max(x.max_match) as max_match
                                                    from (select a.mandant_id,
                                                                 a.art_gruppe_id,
                                                                 b.art_matching_id,
                                                                 max(b.art_matching_id) over (partition by a.mandant_id,a.art_gruppe_id order by a.mandant_id,a.art_gruppe_id) AS max_match
                                                          from dbp_etl_process.art_art_nielsen_groups a
                                                          join dbp_etl.art_matching_nielsen_per_final b
                                                            on a.mandant_id = b.mandant_id and
                                                               a.art_id = b.art_id
                                                          group by 1,2,3) x
                                                    group by 1,2) b
                    
set art_matching_id = b.max_match

where dbp_etl.art_matching_nielsen_per_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id = b.art_matching_id and
      dbp_etl.art_matching_nielsen_per_final.art_matching_id <> b.max_match
;

--custom article grouping for beers

create or replace volatile table _part
as
(
  select b.*,a.art_matching_id from dbp_etl.art_matching_nielsen_per_final a
  join _track_artikel b
  on a.mandant_id = b.mandant_id and
  a.art_id = b.art_id
) ;

create or replace volatile table _part_2
as
(
  select distinct
  (select max(ART_MATCHING_ID) from dbp_etl.art_matching_nielsen_per_final where mandant_id = 1) as NEW_MATCHING_ID
  ,ART_MATCHING_ID
  ,ART_GRUPPE_ID
  ,MANDANT_ID
  ,ART_ID
  ,dense_rank() over (order by MANDANT_ID,ART_GRUPPE_ID) as rang
from _part
) ;

create or replace volatile table _part_3
as
(        
select distinct
NEW_MATCHING_ID+RANG as NEW_MATCHING_ID,
ART_MATCHING_ID,
ART_GRUPPE_ID,
MANDANT_ID,
ART_ID
from _part_2  
);

UPDATE dbp_etl.art_matching_nielsen_per_final from (select * from _part_3)b
SET ART_MATCHING_ID = b.NEW_MATCHING_ID
WHERE
dbp_etl.art_matching_nielsen_per_final.MANDANT_ID=b.MANDANT_ID and
dbp_etl.art_matching_nielsen_per_final.ART_MATCHING_ID=b.ART_MATCHING_ID and
dbp_etl.art_matching_nielsen_per_final.ART_ID=b.ART_ID 
;

--bookkeeping of matching_id and unification
create or replace volatile table _group1
as
(
select a.*,b.ART_GRUPPE_ID,COUNT(*) OVER (PARTITION BY ART_MATCHING_ID,ART_GRUPPE_ID) AS num  from dbp_etl.art_matching_nielsen_per_final a
left join _track_artikel b
on 
a.MANDANT_ID=b.MANDANT_ID and
a.ART_ID=b.ART_ID
WHERE 
ART_GRUPPE_ID is not null
);

create or replace volatile table _group2
as
(select a.*,b.ART_GRUPPE_ID,COUNT(*) OVER (PARTITION BY ART_MATCHING_ID,ART_GRUPPE_ID) AS num from dbp_etl.art_matching_nielsen_per a
left join _track_artikel b
on 
a.MANDANT_ID=b.MANDANT_ID and
a.ART_ID=b.ART_ID
where kjwo_update = (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per) 
and ART_GRUPPE_ID is not null
);

update _group1 from (select * from _group2 where ART_GRUPPE_ID is not null)b
set
ART_MATCHING_ID = b.ART_MATCHING_ID
where
_group1.MANDANT_ID=b.MANDANT_ID and 
_group1.ART_ID=b.ART_ID and 
_group1.ART_NIELSEN_ID=b.ART_NIELSEN_ID and 
_group1.GTIN_ID=b.GTIN_ID and 
_group1.ART_GRUPPE_ID=b.ART_GRUPPE_ID and 
_group1.NUM=b.NUM
;

UPDATE dbp_etl.art_matching_nielsen_per_final from (select * from _group1 where ART_GRUPPE_ID is not null)b
SET 
ART_MATCHING_ID = b.ART_MATCHING_ID
WHERE
dbp_etl.art_matching_nielsen_per_final.MANDANT_ID=b.MANDANT_ID and
dbp_etl.art_matching_nielsen_per_final.ART_ID=b.ART_ID and 
dbp_etl.art_matching_nielsen_per_final.ART_NIELSEN_ID=b.ART_NIELSEN_ID and 
dbp_etl.art_matching_nielsen_per_final.GTIN_ID=b.GTIN_ID  
;

--UMRECH_FAKTOR

update dbp_etl.art_matching_nielsen_per_final from (select * from _track_artikel) b
SET
UMRECH_FAKTOR=b.UMRECH_FAKTOR
WHERE
dbp_etl.art_matching_nielsen_per_final.MANDANT_ID=b.MANDANT_ID and
dbp_etl.art_matching_nielsen_per_final.ART_ID=b.ART_ID
;

update dbp_etl.art_matching_nielsen_per_final set status = 'N';
  
update dbp_etl.art_matching_nielsen_per_final from (select art_matching_id,
                                                           count(distinct case when art_id = -1 then null else art_id end) as anz_art,
                                                           count(distinct case when art_nielsen_id = -1 then null else art_nielsen_id end) as anz_art_nielsen
                                                    from dbp_etl.art_matching_nielsen_per_final
                                                    where mandant_id = 1
                                                    group by 1
                                                    having anz_art > 1) b

set status = 'T'

where dbp_etl.art_matching_nielsen_per_final.art_matching_id = b.art_matching_id and
      dbp_etl.art_matching_nielsen_per_final.mandant_id = 1
;

--- Historisierung ---

create or replace volatile table _ek_sort_art_matching_zu_tmp (
  mandant_id byteint,
  art_matching_id number(38,0),
  kombi_art_id varchar(5000),
  kombi_art_nielsen_id varchar(5000),
  kombi_gtin_id varchar(5000),
  dat_von date,
  dat_bis date
);

insert into _ek_sort_art_matching_zu_tmp
select mandant_id,
       art_matching_id,
       substr(replace(trim((listagg(cast(cast(cast(art_id as varchar(600)) as decimal(38,0)) as varchar(38)), ',') within group (order by floor(art_id)) ), ','),' ', ''),1,5000) as art_id,
       substr(replace(trim((listagg(cast(cast(cast(art_nielsen_id as varchar(600)) as decimal(38,0)) as varchar(38)), ',') within group (order by floor(art_nielsen_id)) ), ','),' ', ''),1,5000) as art_nielsen_id,
       substr(replace(trim((listagg(cast(cast(cast(gtin_id as varchar(600)) as decimal(38,0)) as varchar(38)), ',') within group (order by floor(gtin_id)) ), ','),' ', ''),1,5000) as gtin_id,
       '1900-01-01',
       '9999-12-31'
from dbp_etl.art_matching_nielsen_per_final
group by 1,2
;

update dbp_etl_process.ek_sort_art_matching_zu from (select mandant_id,
                                                            art_matching_id
                                                     from dbp_etl_process.ek_sort_art_matching_zu
                                                     where (mandant_id,art_matching_id) not in (select mandant_id,art_matching_id from _ek_sort_art_matching_zu_tmp) and
                                                            dat_bis = '9999-12-31') b
                                                     
set dat_bis = current_date-1

where dbp_etl_process.ek_sort_art_matching_zu.mandant_id = b.mandant_id and
      dbp_etl_process.ek_sort_art_matching_zu.art_matching_id = b.art_matching_id and
      dbp_etl_process.ek_sort_art_matching_zu.dat_bis = '9999-12-31'
;

create or replace volatile table _changes as (
select a.*
from dbp_etl_process.ek_sort_art_matching_zu a
left join _ek_sort_art_matching_zu_tmp b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id and
     a.kombi_art_id = b.kombi_art_id and
     a.kombi_art_nielsen_id = b.kombi_art_nielsen_id
where b.dat_von is null and
      a.dat_bis = '9999-12-31'
);

create or replace volatile table _news as (
select *
from _ek_sort_art_matching_zu_tmp
where (mandant_id,art_matching_id) in (select mandant_id,art_matching_id from _changes)
);

update dbp_etl_process.ek_sort_art_matching_zu from (select *
                                                     from _changes) b
                                                           
set dat_bis = current_date-1

where dbp_etl_process.ek_sort_art_matching_zu.mandant_id = b.mandant_id and
      dbp_etl_process.ek_sort_art_matching_zu.art_matching_id = b.art_matching_id and
      dbp_etl_process.ek_sort_art_matching_zu.dat_bis = '9999-12-31'
;

insert into dbp_etl_process.ek_sort_art_matching_zu (mandant_id,
                                                     art_matching_id,
                                                     kombi_art_id,
                                                     kombi_art_nielsen_id,
                                                     kombi_gtin_id,
                                                     dat_von,
                                                     dat_bis)
select mandant_id,
       art_matching_id,
       kombi_art_id,
       kombi_art_nielsen_id,
       kombi_gtin_id,
       current_date as dat_von,
       '9999-12-31' as dat_bis
from _news
;

--- final exchange

--- 1st: keeping the old, useless records for frontend purpose
insert into dbp_etl.art_matching_nielsen_per_olds
select *
from dbp_etl.art_matching_nielsen_per
where (mandant_id,art_matching_id) not in (select mandant_id,art_matching_id from dbp_etl.art_matching_nielsen_per_final)
;

-- maintenance
delete from dbp_etl.art_matching_nielsen_per_olds
where kjwo_update not in (select kjwo from dbp_data.woche where akt_wo between -6 and 1)
;

--- 2nd: new registration
delete from dbp_etl.art_matching_nielsen_per;
insert into dbp_etl.art_matching_nielsen_per
select *
from dbp_etl.art_matching_nielsen_per_final
;

-- start --

-- correct product groups before transformation

create or replace volatile table _track_distinct as (
select a.mandant_id,
       a.art_matching_id,
       max(d.owg_id) as kl_wg_id,
       max(c.wg_id) as kl_owg_id,
       min(c.wug_id) as kl_uwg_id
from dbp_etl.art_matching_nielsen_per a
join (select mandant_id,
             art_matching_id
      from dbp_etl.art_matching_nielsen_per
      group by 1,2
      having count(distinct kl_wg_id)  > 1 or
             count(distinct kl_owg_id) > 1 or
             count(distinct kl_uwg_id) > 1) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
join dbp_data.art_wg_zu_per c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     c.dat_bis = '9999-12-31' and
     c.arthiertyp_id = 2
join dbp_data.wg_per d
  on a.mandant_id = d.mandant_id and
     c.wg_id = d.wg_id and
     d.arthiertyp_id = 2 and
     d.dat_bis = '9999-12-31'
where c.wg_id in (select wg_id from dbp_data.wg_filter_zu where wg_filter_id = 11 group by 1)
group by 1,2
);

update dbp_etl.art_matching_nielsen_per from (select mandant_id,
                                                     art_matching_id,
                                                     kl_wg_id,
                                                     kl_owg_id,
                                                     kl_uwg_id
                                              from _track_distinct) b
                                                     
set kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per.art_matching_id = b.art_matching_id
;

create or replace volatile table _track_distinct as (
select a.mandant_id,
       a.art_matching_id,
       max(a.kl_wg_id) as kl_wg_id,
       max(a.kl_owg_id) as kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from dbp_etl.art_matching_nielsen_per a
join (select mandant_id,
             art_matching_id
      from dbp_etl.art_matching_nielsen_per
      group by 1,2
      having count(distinct kl_wg_id)  > 1 or
             count(distinct kl_owg_id) > 1 or
             count(distinct kl_uwg_id) > 1) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
where a.kl_owg_id in (select wg_id from dbp_data.wg_filter_zu where wg_filter_id = 11 group by 1)
group by 1,2
);

update dbp_etl.art_matching_nielsen_per from (select mandant_id,
                                                     art_matching_id,
                                                     kl_wg_id,
                                                     kl_owg_id,
                                                     kl_uwg_id
                                              from _track_distinct) b
                                                     
set kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per.art_matching_id = b.art_matching_id
;

create or replace volatile table _track_distinct as (
select a.mandant_id,
       a.art_matching_id,
       max(a.kl_wg_id) as kl_wg_id,
       max(a.kl_owg_id) as kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from dbp_etl.art_matching_nielsen_per a
join (select mandant_id,
             art_matching_id
      from dbp_etl.art_matching_nielsen_per
      group by 1,2
      having count(distinct kl_wg_id)  > 1 or
             count(distinct kl_owg_id) > 1 or
             count(distinct kl_uwg_id) > 1) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
group by 1,2
);

update dbp_etl.art_matching_nielsen_per from (select mandant_id,
                                                     art_matching_id,
                                                     kl_wg_id,
                                                     kl_owg_id,
                                                     kl_uwg_id
                                              from _track_distinct) b
                                                     
set kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per.art_matching_id = b.art_matching_id
;

-- end --



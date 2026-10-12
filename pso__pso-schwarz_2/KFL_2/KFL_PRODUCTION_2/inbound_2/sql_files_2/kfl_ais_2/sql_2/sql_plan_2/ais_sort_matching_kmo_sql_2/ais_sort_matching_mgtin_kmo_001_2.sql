create or replace volatile table _art_nielsen_mgtin as 
(
select distinct mandant_id,art_nielsen_id,gtin_id from dbp_data.art_nielsen_2 where DAT_BIS='9999-12-31'
union
select distinct mandant_id,art_nielsen_id,gtin_ref_id as gtin_id from dbp_etl_process.art_nielsen_gtin_zu_2
) ;

create or replace volatile table _mgtin as
(
select distinct a.*,b.GTIN_REF_ID from _art_nielsen_mgtin a 
join dbp_data.art_nielsen_2 b 
on a.mandant_id = b.mandant_id and a.art_nielsen_id=b.art_nielsen_id
where b.DAT_BIS='9999-12-31'  
);

create or replace volatile table _kl_facts as ( 
select a.mandant_id,
       a.art_id,
       sum(a.umsatz_netto) umsatz_netto
from dbp_data.artbew_wo_sum_2 a
join dbp_data.woche_kj_kl_2 b
  on a.kjwo_kl = b.kjwo_kl
join dbp_data.art_wg_zu_per_2 d
  on a.mandant_id = d.mandant_id and
     a.art_id = d.art_id and
     d.arthiertyp_id = 2 and
     d.dat_bis = '9999-12-31'
join (select wg_id
      from dbp_data.wg_filter_zu_2
      where wg_filter_id = 47
      group by 1) e
  on d.wg_id = e.wg_id
where (a.mandant_id,b.kjwo) in (select x.mandant_id,
                                       x.kjwo
                                from (select b.mandant_id,
                                             c.kjwo,
                                             rank() over (partition by b.mandant_id order by b.mandant_id,c.kjwo desc) * (-1) as akt_wo
                                      from DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_2 a
                                      join (select mandant_id,
                                                   max(kjmo) as kjmo
                                            from dbp_data.sortiment_leistung_2
                                            where mandant_id in (2,3,5,6,7,8)
                                            group by 1) b
                                        on a.kjmo_sort = b.kjmo
                                      join dbp_data.woche_2 c
                                        on c.kjwo <= a.kjwo_bis) x
                                where x.akt_wo between -52 and -1
                                group by 1,2)
group by 1,2
having sum(a.menge) > 0 
);

create or replace volatile table _distinct_nl_arts as (
select a.mandant_id,
       a.art_nielsen_id,
       a.gtin_id
from _art_nielsen_mgtin a
where a.mandant_id in (2,3,5,6,7,8)
group by 1,2,3
);

create or replace volatile table _article_matching0 as (
select a.mandant_id,
       a.art_nielsen_id,
       b.art_id,
       a.gtin_id
from _distinct_nl_arts a
join (select *
      from dbp_etl_process.art_gtin_2 a
      where mandant_id in (2,3,5,6,7,8)) b
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
from dbp_etl.kl_basis_listung_kmo_2 a
join (select *
      from dbp_etl_process.art_gtin_2 a
      where mandant_id in (2,3,5,6,7,8)) b
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

create or replace volatile table _nielsen_kl_matching_kmo (
  mandant_id byteint not null,
  matching_id integer not null,
  art_nielsen_id integer not null,
  art_id integer not null,
  gtin_id decimal(18,0) not null
);

insert into _nielsen_kl_matching_kmo
select mandant_id,
       -1 as matching_id,
       art_nielsen_id,
       art_id,
       gtin_id
from _article_matching0
;

delete from _nielsen_kl_matching_kmo
where (mandant_id,art_id) not in 
(
select
distinct
d.mandant_id,
d.art_id
from
dbp_data.art_wg_zu_per_2 d
join dbp_data.wg_filter_zu_2 wfz
on d.wg_id = wfz.wg_id 
and d.mandant_id = wfz.mandant_id
and wfz.wg_filter_id = 47
and wfz.arthiertyp_id = 2
and d.dat_bis = to_date('9999-12-31', 'yyyy-mm_2-dd')
and d.arthiertyp_id = 2
) and art_id > 0 ;

merge into _nielsen_kl_matching_kmo a using (select mandant_id,
                                                max(art_matching_id) as art_matching_id,
                                                art_nielsen_id,
                                                art_id,
                                                gtin_id
                                         from dbp_etl.art_matching_nielsen_per_kmo_final_2
                                         group by 1,3,4,5) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.art_nielsen_id = b.art_nielsen_id and
     a.gtin_id = b.gtin_id

when matched then update set a.matching_id = b.art_matching_id
;

create or replace volatile table _combined_data as
(
select mandant_id,
       art_matching_id,
       listagg (distinct art_id, ',') within group (order by art_id) as art_id
from dbp_etl.art_matching_nielsen_per_kmo_final_2 where KJWO_UPDATE = (select MAX(KJWO_UPDATE) from dbp_etl.art_matching_nielsen_per_kmo_final_2)
group by 1,2
);

create or replace volatile table _merge_combined_data as
(
select mandant_id,
       matching_id as art_matching_id,
       listagg (distinct art_id, ',') within group (order by art_id) as art_id
from _nielsen_kl_matching_kmo where matching_id <> -1 
group by 1,2
);

create or replace volatile table _delete_unchanged
as
(
select a.*,b.art_id as combi_art_id from  _combined_data a
join _merge_combined_data b on
a.MANDANT_ID = b.MANDANT_ID and 
a.ART_MATCHING_ID = b.ART_MATCHING_ID
where 
a.art_id<>combi_art_id
);

UPDATE _nielsen_kl_matching_kmo FROM (select MANDANT_ID,ART_MATCHING_ID,ART_ID,-1||','||COMBI_ART_ID as COMBI_ART_ID_2 from _delete_unchanged 
where ART_ID <> COMBI_ART_ID_2) b

set matching_id = -1 

where

_nielsen_kl_matching_kmo.MANDANT_ID = b.MANDANT_ID and 
_nielsen_kl_matching_kmo.matching_id = b.ART_MATCHING_ID
;

-- only art_id trigger matching_id change

UPDATE _nielsen_kl_matching_kmo FROM (select a.* ,max(b.art_nielsen_id) as ori_art_nielsen_id,b.art_matching_id as ori_matching_id from (select * from _nielsen_kl_matching_kmo where (mandant_id,art_id) in 
                                      (select MANDANT_ID,ART_ID from _nielsen_kl_matching_kmo where art_id <> -1 group by 1,2 having count(distinct matching_id) = 1 and SUM(distinct CASE WHEN  matching_id = -1 THEN 0 ELSE 1 END) =0)
                                      )  a
                                      join dbp_etl.art_matching_nielsen_per_kmo_final_2 b
                                      on
                                      a.mandant_id=b.mandant_id and
                                      a.art_id = b.art_id and
                                      a.gtin_id = b.gtin_id
                                      where a.art_nielsen_id <> b.art_nielsen_id and (a.mandant_id,a.art_nielsen_id) not in (select 
                                      MANDANT_ID,
                                      ART_NIELSEN_ID 
                                      from _nielsen_kl_matching_kmo
                                      where ART_NIELSEN_ID <> -1
                                      group by 1,2  
                                      having
                                      count(distinct matching_id) > 1 and
                                      count(distinct art_id) > 1)
									  group by 1,2,3,4,5,7) b

SET 
matching_id = b.ori_matching_id

WHERE
_nielsen_kl_matching_kmo.matching_id = -1 and
_nielsen_kl_matching_kmo.art_id = b.art_id and
_nielsen_kl_matching_kmo.GTIN_ID = b.GTIN_ID and
_nielsen_kl_matching_kmo.art_nielsen_id=b.art_nielsen_id and
_nielsen_kl_matching_kmo.mandant_id = b.mandant_id
;

update _nielsen_kl_matching_kmo from (select mandant_id,
                                                               max(matching_id) as matching_id,
                                                               art_id
                                                        from _nielsen_kl_matching_kmo
                                                        where art_id <> -1
                                                        group by 1,3
                                                        having count(distinct matching_id) > 1) b
                                  
    set matching_id = b.matching_id

    where _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
          _nielsen_kl_matching_kmo.art_id = b.art_id ;

update _nielsen_kl_matching_kmo from (select mandant_id,
                                                               max(matching_id) as matching_id,
                                                               ART_NIELSEN_ID
                                                        from _nielsen_kl_matching_kmo
                                                        where art_id <> -1
                                                        group by 1,3
                                                        having count(distinct matching_id) = 1  and max(matching_id)<> -1) b
                                  
    set matching_id = b.matching_id

    where _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
          _nielsen_kl_matching_kmo.ART_NIELSEN_ID = b.ART_NIELSEN_ID ;
          
    update _nielsen_kl_matching_kmo from (select mandant_id,
                                                               max(matching_id) as matching_id,
                                                               art_nielsen_id
                                                        from _nielsen_kl_matching_kmo
                                                        where art_nielsen_id <> -1
                                                        group by 1,3
                                                        having count(distinct matching_id) > 1) b
                                  
    set matching_id = b.matching_id

    where _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
          _nielsen_kl_matching_kmo.art_nielsen_id = b.art_nielsen_id and 
          _nielsen_kl_matching_kmo.art_id = -1 ;
          
UPDATE _nielsen_kl_matching_kmo FROM (select 
                                      a.MANDANT_ID,max(a.ART_MATCHING_ID) ART_MATCHING_ID,a.ART_ID,b.ART_NIELSEN_ID,a.GTIN_ID
                                      from dbp_etl.art_matching_nielsen_per_kmo_final_2 a 
                                      join
                                      _nielsen_kl_matching_kmo b
                                      on
                                      a.art_id = b.art_id and
                                      a.GTIN_ID = b.GTIN_ID and
                                      a.mandant_id = b.mandant_id 
                                      WHERE
                                      b.matching_id = -1
                                      group by 1,3,4,5
                                      ) b
                                      
set MATCHING_ID = b.ART_MATCHING_ID
WHERE 
_nielsen_kl_matching_kmo.art_id = b.art_id and
_nielsen_kl_matching_kmo.GTIN_ID = b.GTIN_ID and
_nielsen_kl_matching_kmo.ART_NIELSEN_ID = b.ART_NIELSEN_ID and
_nielsen_kl_matching_kmo.mandant_id = b.mandant_id and 
_nielsen_kl_matching_kmo.MATCHING_ID = -1 ;

EXECUTE IMMEDIATE $$
BEGIN
  LET loop_counter1 INTEGER := (select 1);
  LET loop_counter2 INTEGER := (select 1);
  LET loop_counter_value INTEGER := 0;
  
  WHILE ((loop_counter1+loop_counter2) > 0) DO
   
   update _nielsen_kl_matching_kmo from (select mandant_id,
                                                               max(matching_id) as matching_id,
                                                               art_nielsen_id,
                                                               art_id
                                                        from _nielsen_kl_matching_kmo
                                                        where art_nielsen_id <> -1
                                                        group by 1,3,4
                                                        having count(distinct matching_id) > 1) b
                                  
    set matching_id = b.matching_id

    where _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
          _nielsen_kl_matching_kmo.art_nielsen_id = b.art_nielsen_id and
          _nielsen_kl_matching_kmo.art_id = b.art_id;
    
    loop_counter1 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));

    update _nielsen_kl_matching_kmo from (select mandant_id,
                                                               max(matching_id) as matching_id,
                                                               gtin_id
                                                        from _nielsen_kl_matching_kmo
                                                        where gtin_id not in (-9999,-9998)
                                                        group by 1,3
                                                        having count(distinct matching_id) > 1) b
                                  
    set matching_id = b.matching_id

    where _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
          _nielsen_kl_matching_kmo.gtin_id = b.gtin_id ;

    loop_counter2 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    
    loop_counter_value := loop_counter_value + 1;
  END WHILE;

RETURN loop_counter_value;

END;
$$
;

UPDATE _nielsen_kl_matching_kmo FROM (select MANDANT_ID,ART_NIELSEN_ID,max(MATCHING_ID) as MATCHING_ID from _nielsen_kl_matching_kmo where art_id <> -1 and (mandant_id,ART_NIELSEN_ID) in (select mandant_id,ART_NIELSEN_ID
                                      from 
                                      _nielsen_kl_matching_kmo
                                      group by 1,2
                                      having count(distinct art_id) = 2 and SUM(CASE WHEN art_id = -1 THEN 1 ELSE 0 END) > 0 and count(distinct matching_id) = 2)
                                      group by 1,2) b

SET matching_id = b.matching_id
WHERE
_nielsen_kl_matching_kmo.MANDANT_ID = b.MANDANT_ID and
_nielsen_kl_matching_kmo.ART_NIELSEN_ID = b.ART_NIELSEN_ID 
;

UPDATE _nielsen_kl_matching_kmo FROM (select distinct a.MANDANT_ID,a.MATCHING_ID,a.ART_ID,a.ART_NIELSEN_ID,a.GTIN_ID,b.ART_MATCHING_ID as ART_MATCHING_ID_OLD
from  _nielsen_kl_matching_kmo a 
join (select * from dbp_etl.art_matching_nielsen_per_kmo_final_2 where KJWO_UPDATE = (select MAX(KJWO_UPDATE) from dbp_etl.art_matching_nielsen_per_kmo_final_2)) b
on a.art_id = b.art_id
and a.gtin_id = b.gtin_id
and a.mandant_id = b.mandant_id
where (a.mandant_id,a.matching_id) in 
(
select
mandant_id,
matching_id
from 
_nielsen_kl_matching_kmo
where matching_id <> - 1 and art_id <> - 1
group by 1,2
having
count(distinct art_id) > 1
) and a.MATCHING_ID <> ART_MATCHING_ID_OLD and a.art_id <> -1) b

SET matching_id = -1
WHERE
_nielsen_kl_matching_kmo.MANDANT_ID = b.MANDANT_ID AND
_nielsen_kl_matching_kmo.ART_ID = b.ART_ID AND
_nielsen_kl_matching_kmo.ART_NIELSEN_ID = b.ART_NIELSEN_ID AND
_nielsen_kl_matching_kmo.GTIN_ID = b.GTIN_ID AND
_nielsen_kl_matching_kmo.matching_id = b.MATCHING_ID
;

UPDATE _nielsen_kl_matching_kmo FROM (select distinct a.MANDANT_ID,a.MATCHING_ID,a.ART_ID,a.ART_NIELSEN_ID,a.GTIN_ID,b.ART_MATCHING_ID as ART_MATCHING_ID_OLD
from  _nielsen_kl_matching_kmo a 
join (select * from dbp_etl.art_matching_nielsen_per_kmo_final_2 where KJWO_UPDATE = (select MAX(KJWO_UPDATE) from dbp_etl.art_matching_nielsen_per_kmo_final_2)) b
on a.art_id = b.art_id
and a.gtin_id = b.gtin_id
and a.mandant_id = b.mandant_id
where (a.mandant_id,a.art_nielsen_id) in 
(
select
mandant_id,
art_nielsen_id
from 
_nielsen_kl_matching_kmo
where matching_id <> - 1 and art_id <> - 1 and art_nielsen_id <> -1 
group by 1,2
having
count(distinct art_id) > 1 
) AND a.MATCHING_ID <> -1) b

SET matching_id = -1
WHERE
_nielsen_kl_matching_kmo.MANDANT_ID = b.MANDANT_ID AND
_nielsen_kl_matching_kmo.ART_ID = b.ART_ID AND
_nielsen_kl_matching_kmo.ART_NIELSEN_ID = b.ART_NIELSEN_ID AND
_nielsen_kl_matching_kmo.GTIN_ID = b.GTIN_ID AND
_nielsen_kl_matching_kmo.matching_id = b.MATCHING_ID
;

create or replace volatile table _nielsen_kl_matching_kmo_final as (
select *
from _nielsen_kl_matching_kmo
where matching_id <> -1
);

delete from _nielsen_kl_matching_kmo
where matching_id <> -1
;



create or replace volatile table _upd_new_match as (
select mandant_id,
      (select max(matching_id) from _nielsen_kl_matching_kmo_final) as art_matching_id,
       art_nielsen_id,
       art_id,
       gtin_id,
       dense_rank() over (order by mandant_id,art_id) as rang
from _nielsen_kl_matching_kmo
where art_id <> -1 and
      art_nielsen_id <> -1
);

insert into _nielsen_kl_matching_kmo_final (mandant_id,
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

delete from _nielsen_kl_matching_kmo
where (mandant_id,art_id) in (select mandant_id,art_id from _nielsen_kl_matching_kmo_final where art_id <> -1 and art_nielsen_id <> -1)
;

-- 2nd run for kl-articles

create or replace volatile table _upd_new_match as (
select mandant_id,
      (select max(matching_id) from _nielsen_kl_matching_kmo_final) as art_matching_id,
       art_nielsen_id,
       art_id,
       gtin_id,
       dense_rank() over (order by mandant_id,art_id) as rang
from _nielsen_kl_matching_kmo
where art_id <> -1
);

insert into _nielsen_kl_matching_kmo_final (mandant_id,
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

delete from _nielsen_kl_matching_kmo
where (mandant_id,art_id) in (select mandant_id,art_id from _nielsen_kl_matching_kmo_final where art_id <> -1)
;

-- 3rd run for nl-articles

create or replace volatile table _upd_new_match as (
select b.mandant_id,
      (select max(matching_id) from _nielsen_kl_matching_kmo_final) as art_matching_id,
       b.art_nielsen_id,
       a.art_id,
       a.gtin_id,
       dense_rank() over (order by a.mandant_id,b.GTIN_REF_ID) as rang
from _nielsen_kl_matching_kmo a
join _mgtin b
  on a.mandant_id = b.mandant_id and
     a.art_nielsen_id = b.art_nielsen_id and 
     a.gtin_id = b.gtin_id
where a.art_nielsen_id <> -1 
);

insert into _nielsen_kl_matching_kmo_final (mandant_id,
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

delete from _nielsen_kl_matching_kmo
where (mandant_id,art_nielsen_id,gtin_id) in (select mandant_id,art_nielsen_id,gtin_id from _nielsen_kl_matching_kmo_final where art_nielsen_id <> -1)
;
      
update _nielsen_kl_matching_kmo_final from (select mandant_id,
                                               art_id,
                                               count(distinct matching_id) as anz_match,
                                               max(matching_id) as max_match,
                                               min(art_id) as min_art_id,
                                               max(art_id) as max_art_id
                                        from _nielsen_kl_matching_kmo_final
                                        where art_id <> -1
                                        group by 1,2
                                        having anz_match > 1 and
                                               min_art_id = max_art_id) b
                                               
set matching_id = max_match

where _nielsen_kl_matching_kmo_final.mandant_id = b.mandant_id and
      _nielsen_kl_matching_kmo_final.art_id = b.art_id
;


update _nielsen_kl_matching_kmo_final from (select mandant_id,
                                               art_id,
                                               count(distinct matching_id) as anz_match,
                                               max(matching_id) as max_match,
                                               min(art_id) as min_art_id,
                                               max(art_id) as max_art_id
                                        from _nielsen_kl_matching_kmo_final
                                        where art_id <> -1
                                        group by 1,2
                                        having anz_match > 1 and
                                               min_art_id = max_art_id) b
                                               
set matching_id = max_match

where _nielsen_kl_matching_kmo_final.mandant_id = b.mandant_id and
      _nielsen_kl_matching_kmo_final.art_id = b.art_id
;

create or replace table dbp_etl.art_matching_nielsen_per_kmo_mgtin_2 like dbp_etl.art_matching_nielsen_per_kmo_2;

insert into dbp_etl.art_matching_nielsen_per_kmo_mgtin_2
select distinct
       mandant_id,
       matching_id,
       art_id,
       art_nielsen_id,
       gtin_id,
       0,0,0,0,1,'N',null,0,(select c.kjwo
                             from dbp_data.woche_2 a
                             join (select max(kjwo_update) as kjwo_update
                                   from dbp_data.sortiment_leistung_2 where mandant_id > 1) b
                               on a.kjwo = b.kjwo_update
                             join dbp_data.woche_2 c
                               on a.akt_wo = c.akt_wo-1),current_timestamp,current_timestamp
from _nielsen_kl_matching_kmo_final
where (mandant_id,matching_id,art_nielsen_id,art_id) not in (select mandant_id,art_matching_id,art_nielsen_id,art_id from dbp_etl.art_matching_nielsen_per_kmo_mgtin_2)
;

EXECUTE IMMEDIATE $$
BEGIN
  LET loop_counter1 INTEGER := (select 1);
  LET loop_counter2 INTEGER := (select 1);
  LET loop_counter3 INTEGER := (select 1);
  LET loop_counter_value INTEGER := 0;
  
  WHILE ((loop_counter1+loop_counter2+loop_counter3) > 0) DO
    update dbp_etl.art_matching_nielsen_per_kmo_mgtin_2 from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               art_nielsen_id
                                                        from dbp_etl.art_matching_nielsen_per_kmo_mgtin_2
                                                        where art_nielsen_id <> -1
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_kmo_mgtin.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_kmo_mgtin.art_nielsen_id = b.art_nielsen_id ;
    
    loop_counter1 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));

    update dbp_etl.art_matching_nielsen_per_kmo_mgtin_2 from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               art_id
                                                        from dbp_etl.art_matching_nielsen_per_kmo_mgtin_2
                                                        where art_id <> -1
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_kmo_mgtin.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_kmo_mgtin.art_id = b.art_id ;

    loop_counter2 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    
    update dbp_etl.art_matching_nielsen_per_kmo_mgtin_2 from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               gtin_id
                                                        from dbp_etl.art_matching_nielsen_per_kmo_mgtin_2
                                                        where gtin_id not in (-9999,-9998)
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_kmo_mgtin.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_kmo_mgtin.gtin_id = b.gtin_id ;

    loop_counter3 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    
    loop_counter_value := loop_counter_value + 1;
  END WHILE;

RETURN loop_counter_value;

END;
$$
;

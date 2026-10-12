create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_1 where DAT_BIS='9999-12-31'
);

delete from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
where kjwo_update in (select kjwo from dbp_data.woche_1 where akt_wo = 0)
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 (mandant_id
                                                            ,art_matching_id
                                                            ,art_id
                                                            ,art_nielsen_id
                                                            ,gtin_id
                                                            ,kl_art_kat_id
                                                            ,kl_wg_id
                                                            ,kl_owg_id
                                                            ,kl_uwg_id
                                                            ,umrech_faktor
                                                            ,status_1
                                                            ,list_kz
                                                            ,komponente_fg
                                                            ,kjwo_update)
select mandant_id
      ,art_matching_id
      ,art_id
      ,art_nielsen_id
      ,gtin_id
      ,kl_art_kat_id
      ,kl_wg_id
      ,kl_owg_id
      ,kl_uwg_id
      ,umrech_faktor
      ,status_1
      ,list_kz
      ,komponente_fg
      ,(select kjwo from dbp_data.woche_1 where akt_wo = 0) as kjwo_update
from dbp_etl.art_matching_nielsen_per_kmo_1
;

delete from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
where kjwo_update in (select kjwo from dbp_data.woche_1 where akt_wo = 1)
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 (mandant_id
                                                            ,art_matching_id
                                                            ,art_id
                                                            ,art_nielsen_id
                                                            ,gtin_id
                                                            ,kl_art_kat_id
                                                            ,kl_wg_id
                                                            ,kl_owg_id
                                                            ,kl_uwg_id
                                                            ,umrech_faktor
                                                            ,status_1
                                                            ,list_kz
                                                            ,komponente_fg
                                                            ,kjwo_update)
select mandant_id
      ,art_matching_id
      ,art_id
      ,art_nielsen_id
      ,gtin_id
      ,kl_art_kat_id
      ,kl_wg_id
      ,kl_owg_id
      ,kl_uwg_id
      ,umrech_faktor
      ,status_1
      ,list_kz
      ,komponente_fg
      ,b.kjwo as kjwo_update
from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 a
join dbp_data.woche_1 b
  on 1 = 1
where b.akt_wo = 1 and
      a.kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1)
;

create or replace volatile table _distinct_nl_arts as (
select a.mandant_id,
       a.art_nielsen_id,
       b.gtin_id,
       sum(a.menge) as menge
from dbp_data.art_nielsen_fakten_kjmo_1 a
join _art_nielsen b
  on a.mandant_id = b.mandant_id and
     a.art_nielsen_id = b.art_nielsen_id
join dbp_data.nielsen_market_1 c
  on a.mandant_id = c.mandant_id and
     a.nielsen_market_id = c.nielsen_market_id
where (a.mandant_id,a.kjmo) in (select x.mandant_id,
                                       x.kjmo
                                from (select mandant_id,
                                             kjmo,
                                             rank() over (partition by mandant_id order by kjmo desc) * (-1) as akt_mo
                                      from dbp_data.art_nielsen_fakten_kjmo_1
		                      where mandant_id in (2,3,5,6,7,8)
                                      group by 1,2) x
                                where x.akt_mo between -12 and -1) and
      a.mandant_id in (2,3,5,6,7,8) and
      c.nielsen_market_cluster_id in (1,2)
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
      from dbp_etl_process.art_gtin_1 a
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
from dbp_etl.kl_basis_listung_kmo_1 a
join (select *
      from dbp_etl_process.art_gtin_1 a
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

create or replace volatile table _nielsen_kl_matching (
  mandant_id byteint not null,
  matching_id integer not null,
  art_nielsen_id integer not null,
  art_id integer not null,
  gtin_id decimal(18,0) not null
);

-- 1st level

insert into _nielsen_kl_matching (mandant_id,
                                  matching_id,
                                  art_nielsen_id,
                                  art_id,
                                  gtin_id)
select mandant_id,
       art_matching_id,
       art_nielsen_id,
       art_id,
       gtin_id
from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
where (mandant_id,art_id,art_nielsen_id) in (select mandant_id,art_id,art_nielsen_id from _article_matching0) and
       kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1) and
      (mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,matching_id,art_id,art_nielsen_id,gtin_id from _nielsen_kl_matching) 
group by 1,2,3,4,5
;

delete from _article_matching0
where (mandant_id,art_nielsen_id,art_id) in (select mandant_id,art_nielsen_id,art_id from _nielsen_kl_matching)
;

-- 2nd level

insert into _nielsen_kl_matching (mandant_id,
                                  matching_id,
                                  art_nielsen_id,
                                  art_id,
                                  gtin_id)
select mandant_id,
       art_matching_id,
       art_nielsen_id,
       art_id,
       gtin_id
from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
where (mandant_id,art_nielsen_id) in (select mandant_id,art_nielsen_id from _article_matching0 where art_nielsen_id <> -1) and
       kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1) and
      (mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,matching_id,art_id,art_nielsen_id,gtin_id from _nielsen_kl_matching) 
group by 1,2,3,4,5
;

delete from _article_matching0
where (mandant_id,art_nielsen_id) in (select mandant_id,art_nielsen_id from _nielsen_kl_matching where art_nielsen_id <> -1)
;

-- 3rd level

insert into _nielsen_kl_matching (mandant_id,
                                  matching_id,
                                  art_nielsen_id,
                                  art_id,
                                  gtin_id)
select mandant_id,
       art_matching_id,
       art_nielsen_id,
       art_id,
       gtin_id
from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
where (mandant_id,art_id,gtin_id) in (select mandant_id,art_id,gtin_id from _article_matching0 where art_id <> -1 and gtin_id not in (-9999,-9998)) and
       kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1) and
      (mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,matching_id,art_id,art_nielsen_id,gtin_id from _nielsen_kl_matching)
group by 1,2,3,4,5
;

delete from _article_matching0
where (mandant_id,art_id,gtin_id) in (select mandant_id,art_id,gtin_id from _nielsen_kl_matching where art_id <> -1 and gtin_id not in (-9999,-9998))
;

-- 4th level

insert into _nielsen_kl_matching (mandant_id,
                                  matching_id,
                                  art_nielsen_id,
                                  art_id,
                                  gtin_id)
select mandant_id,
       art_matching_id,
       art_nielsen_id,
       art_id,
       gtin_id
from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
where (mandant_id,art_id) in (select mandant_id,art_id from _article_matching0 where art_id <> -1) and
       kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1) and
      (mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,matching_id,art_id,art_nielsen_id,gtin_id from _nielsen_kl_matching)
group by 1,2,3,4,5
;

delete from _article_matching0
where (mandant_id,art_id) in (select mandant_id,art_id from _nielsen_kl_matching where art_id <> -1)
;

-- 5th level

insert into _nielsen_kl_matching (mandant_id,
                                  matching_id,
                                  art_nielsen_id,
                                  art_id,
                                  gtin_id)
select mandant_id,
       art_matching_id,
       art_nielsen_id,
       art_id,
       gtin_id
from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
where (mandant_id,gtin_id) in (select mandant_id,gtin_id from _article_matching0 where gtin_id not in (-9999,-9998)) and
       kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1) and
      (mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,matching_id,art_id,art_nielsen_id,gtin_id from _nielsen_kl_matching)
group by 1,2,3,4,5
;

delete from _article_matching0
where (mandant_id,gtin_id) in (select mandant_id,gtin_id from _nielsen_kl_matching where gtin_id not in (-9999,-9998))
;

-- 1st for regular gtins

create or replace volatile table _upd_new_match as (
select b.mandant_id,
       c.max_art_matching_id as art_matching_id,
       b.art_nielsen_id,
       a.art_id,
       a.gtin_id,
       dense_rank() over (order by a.mandant_id,a.gtin_id) as rang
from _article_matching0 a
join _art_nielsen b
  on a.mandant_id = b.mandant_id and
     a.art_nielsen_id = b.art_nielsen_id
join (select mandant_id,
             max(art_matching_id) as max_art_matching_id
      from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
      group by 1) c
  on 1 = 1
where a.gtin_id not in (-9999,-9998)
);

insert into _nielsen_kl_matching (mandant_id,
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

delete from _article_matching0
where (mandant_id,art_nielsen_id) in (select mandant_id,art_nielsen_id from _nielsen_kl_matching where art_nielsen_id <> -1)
;

-- 2nd for company brandings

create or replace volatile table _upd_new_match as (
select b.mandant_id,
       c.max_art_matching_id as art_matching_id,
       b.art_nielsen_id,
       a.art_id,
       a.gtin_id,
       dense_rank() over (order by a.mandant_id,a.art_nielsen_id) as rang
from _article_matching0 a
join _art_nielsen b
  on a.mandant_id = b.mandant_id and
     a.art_nielsen_id = b.art_nielsen_id
join (select mandant_id,
             max(matching_id) as max_art_matching_id
      from _nielsen_kl_matching
      group by 1) c
  on 1 = 1
where a.gtin_id in (-9999,-9998)
);

insert into _nielsen_kl_matching (mandant_id,
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
where a.gtin_id is not null
;

delete from _article_matching0
where (mandant_id,art_nielsen_id) in (select mandant_id,art_nielsen_id from _nielsen_kl_matching where art_nielsen_id <> -1)
;

-- 3rd run for kl-articles

create or replace volatile table _upd_new_match as (
select a.mandant_id,
       c.max_art_matching_id as art_matching_id,
       a.art_nielsen_id,
       a.art_id,
       a.gtin_id,
       dense_rank() over (order by a.mandant_id,a.art_id) as rang
from _article_matching0 a
join (select mandant_id,
             max(matching_id) as max_art_matching_id
      from _nielsen_kl_matching
      group by 1) c
  on 1 = 1
);

insert into _nielsen_kl_matching (mandant_id,
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
where a.gtin_id is not null
;

delete from _article_matching0
where (mandant_id,art_id) in (select mandant_id,art_id from _nielsen_kl_matching)
;

-- start of integrating new article references

delete from _nielsen_kl_matching
where (mandant_id,matching_id) in (select mandant_id,art_matching_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
select a.mandant_id,
       b.art_matching_id,
       a.art_id,
       a.art_nielsen_id,
       a.gtin_id,
       b.kl_art_kat_id,
       b.kl_wg_id,
       b.kl_owg_id,
       b.kl_uwg_id,
       b.umrech_faktor,
       b.status_1,
       b.list_kz,
       b.komponente_fg,
       b.kjwo_update,
       current_timestamp,
       current_timestamp
from _nielsen_kl_matching a
join dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 b
  on a.mandant_id = b.mandant_id and
     a.gtin_id = b.gtin_id and
     a.art_nielsen_id = b.art_nielsen_id
where b.kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1) and
     (a.mandant_id,a.art_id) not in (select mandant_id,art_id
                                     from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
                                     where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
select mandant_id,
       matching_id,
       art_id,
       art_nielsen_id,
       gtin_id,
       0,0,0,0,1,'N',null,0,(select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1),current_timestamp,current_timestamp
from _nielsen_kl_matching
where (mandant_id,matching_id) not in (select mandant_id,art_matching_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1)) and
      (mandant_id,matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
;

-- retracking of eventually missing rows
--
-- 1st on single gtins

create or replace volatile table _upd_new_match as (
select mandant_id,
      (select max(art_matching_id) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where mandant_id in (2,3,5,6,7,8)) as art_matching_id,
       art_nielsen_id,
       -1 as art_id,
       gtin_id,
       dense_rank() over (order by mandant_id,art_nielsen_id) as rang
from _distinct_nl_arts
where (mandant_id,gtin_id) in (select mandant_id,gtin_id
                               from _distinct_nl_arts
                               where (mandant_id,gtin_id) not in (select mandant_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
                               group by 1,2
                               having count(*) = 1)
);

delete from _nielsen_kl_matching;
insert into _nielsen_kl_matching (mandant_id,
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
where a.gtin_id is not null
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
select mandant_id,
       matching_id,
       art_id,
       art_nielsen_id,
       gtin_id,
       0,0,0,0,1,'N',null,0,(select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1),current_timestamp,current_timestamp
from _nielsen_kl_matching
where (mandant_id,matching_id) not in (select mandant_id,art_matching_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1)) and
      (mandant_id,matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
;

-- 2nd on multiple gtins

create or replace volatile table _upd_new_match as (
select mandant_id,
      (select max(art_matching_id) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where mandant_id in (2,3,5,6,7,8)) as art_matching_id,
       art_nielsen_id,
       -1 as art_id,
       gtin_id,
       dense_rank() over (order by mandant_id,gtin_id) as rang
from _distinct_nl_arts
where (mandant_id,gtin_id) in (select mandant_id,gtin_id
                               from _distinct_nl_arts
                               where (mandant_id,gtin_id) not in (select mandant_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
                               group by 1,2
                               having count(*) > 1)
);

delete from _nielsen_kl_matching;
insert into _nielsen_kl_matching (mandant_id,
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
where a.gtin_id is not null
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
select mandant_id,
       matching_id,
       art_id,
       art_nielsen_id,
       gtin_id,
       0,0,0,0,1,'N',null,0,(select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1),current_timestamp,current_timestamp
from _nielsen_kl_matching
where (mandant_id,matching_id) not in (select mandant_id,art_matching_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1)) and
      (mandant_id,matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
;

-- 3rd on art_nielsen_id

create or replace volatile table _upd_new_match as (
select mandant_id,
      (select max(art_matching_id) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where mandant_id in (2,3,5,6,7,8)) as art_matching_id,
       art_nielsen_id,
       -1 as art_id,
       gtin_id,
       dense_rank() over (order by mandant_id,gtin_id) as rang
from _distinct_nl_arts
where (mandant_id,art_nielsen_id) in (select mandant_id,art_nielsen_id
                                      from _distinct_nl_arts
                                      where (mandant_id,art_nielsen_id) not in (select mandant_id,art_nielsen_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
                                      group by 1,2)
);

delete from _nielsen_kl_matching;
insert into _nielsen_kl_matching (mandant_id,
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
where a.gtin_id is not null
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
select mandant_id,
       matching_id,
       art_id,
       art_nielsen_id,
       gtin_id,
       0,0,0,0,1,'N',null,0,(select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1),current_timestamp,current_timestamp
from _nielsen_kl_matching
where (mandant_id,matching_id) not in (select mandant_id,art_matching_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1)) and
      (mandant_id,matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
;

-- 4th on art_id

create or replace volatile table _upd_new_match as (
select mandant_id,
      (select max(art_matching_id) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where mandant_id in (2,3,5,6,7,8)) as art_matching_id,
       art_nielsen_id,
       art_id,
       gtin_id,
       dense_rank() over (order by mandant_id,art_id) as rang
from _article_matching0
where (mandant_id,art_id) in (select mandant_id,art_id
                              from _article_matching0
                              where (mandant_id,art_id) not in (select mandant_id,art_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
                              group by 1,2)
);

delete from _nielsen_kl_matching;
insert into _nielsen_kl_matching (mandant_id,
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
where a.gtin_id is not null
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
select mandant_id,
       matching_id,
       art_id,
       art_nielsen_id,
       gtin_id,
       0,0,0,0,1,'N',null,0,(select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1),current_timestamp,current_timestamp
from _nielsen_kl_matching
where (mandant_id,matching_id) not in (select mandant_id,art_matching_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1)) and
      (mandant_id,matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
;

-- retracking eventually missing rows on kl-side

create or replace volatile table _kl_facts as ( 
select a.mandant_id,
       a.art_id,
       sum(a.umsatz_netto) umsatz_netto
from dbp_data.artbew_wo_sum_1 a
join dbp_data.woche_kj_kl_1 b
  on a.kjwo_kl = b.kjwo_kl
join dbp_data.art_wg_zu_per_1 d
  on a.mandant_id = d.mandant_id and
     a.art_id = d.art_id and
     d.arthiertyp_id = 2 and
     d.dat_bis = '9999-12-31'
join (select wg_id
      from dbp_data.wg_filter_zu_1
      where wg_filter_id = 47
      group by 1) e
  on d.wg_id = e.wg_id
where (a.mandant_id,b.kjwo) in (select x.mandant_id,
                                       x.kjwo
                                from (select b.mandant_id,
                                             c.kjwo,
                                             rank() over (partition by b.mandant_id order by b.mandant_id,c.kjwo desc) * (-1) as akt_wo
                                      from dbp_etl_process.sort_monat_woche_1 a
                                      join (select mandant_id,
                                                   max(kjmo) as kjmo
                                            from dbp_data.sortiment_leistung_1
                                            where mandant_id in (2,3,5,6,7,8)
                                            group by 1) b
                                        on a.kjmo_sort = b.kjmo
                                      join dbp_data.woche_1 c
                                        on c.kjwo <= a.kjwo_sort_bis) x
                                where x.akt_wo between -52 and -1
                                group by 1,2)
group by 1,2
having sum(a.menge) > 0 
);

create or replace volatile table _miss1 as (
select mandant_id,
       null as art_matching_id,
       art_id,
       null as art_nielsen_id,
       null as gtin_id
from _kl_facts
where (mandant_id,art_id) not in (select mandant_id,art_id from dbp_etl.art_matching_nielsen_per_kmo_1)
);

update _miss1 from (select mandant_id,
                           art_id,
                           max(gtin_id) as gtin_id
                    from dbp_etl_process.art_gtin_1
                    where mandant_id in (2,3,5,6,7,8)
                    group by 1,2) b
                            
set gtin_id = b.gtin_id

where _miss1.mandant_id = b.mandant_id and
      _miss1.art_id = b.art_id
;

-- 1st run...standard update with matching_id and art_nielsen_id coming from former matching references

update _miss1 from (select mandant_id,
                           gtin_id,
                           max(art_matching_id) as art_matching_id,
                           max(art_nielsen_id) as art_nielsen_id
                    from dbp_etl.art_matching_nielsen_per_kmo_1
                    where gtin_id in (select gtin_id from _miss1)
                    group by 1,2) b
                    
set art_matching_id = b.art_matching_id,
    art_nielsen_id = b.art_nielsen_id

where _miss1.mandant_id = b.mandant_id and
      _miss1.gtin_id = b.gtin_id
;

delete from _nielsen_kl_matching;
insert into _nielsen_kl_matching (mandant_id,
                                  matching_id,
                                  art_nielsen_id,
                                  art_id,
                                  gtin_id)
select a.mandant_id,
       a.art_matching_id,
       a.art_nielsen_id,
       a.art_id,
       a.gtin_id
from _miss1 a
where a.art_matching_id is not null and
      a.art_nielsen_id is not null and
	  a.gtin_id is not null
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
select mandant_id,
       matching_id,
       art_id,
       art_nielsen_id,
       gtin_id,
       0,0,0,0,1,'N',null,0,(select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1),current_timestamp,current_timestamp
from _nielsen_kl_matching
where (mandant_id,matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
;

delete from _miss1
where art_matching_id is not null and
      art_nielsen_id is not null
;

create or replace volatile table _upd_new_match as (
select a.mandant_id,
       b.max_art_matching_id as art_matching_id,
       -1 as art_nielsen_id,
       a.art_id,
       a.gtin_id,
       dense_rank() over (order by a.mandant_id,a.art_id) as rang
from _miss1 a
join (select mandant_id,
             max(art_matching_id) as max_art_matching_id
      from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
      group by 1) b
  on a.mandant_id = b.mandant_id
where (a.mandant_id,a.art_id) in (select mandant_id,art_id
                                  from _miss1
                                  where (mandant_id,art_id) not in (select mandant_id,art_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
                                  group by 1,2)
);

delete from _nielsen_kl_matching;
insert into _nielsen_kl_matching (mandant_id,
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
where a.gtin_id is not null
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo_1
select mandant_id,
       matching_id,
       art_id,
       art_nielsen_id,
       gtin_id,
       0,0,0,0,1,'N',null,0,(select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1),current_timestamp,current_timestamp
from _nielsen_kl_matching
where (mandant_id,matching_id) not in (select mandant_id,art_matching_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1)) and
      (mandant_id,matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1 where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo_1))
;

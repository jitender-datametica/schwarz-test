--multiple gtin's version

create or replace volatile table _distinct_nl_arts as (
select a.mandant_id,
       a.art_nielsen_id,
       b.gtin_id,
       sum(a.menge) as menge
from dbp_data.art_nielsen_fakten_kjmo a
join (
select distinct mandant_id,art_nielsen_id,gtin_id from dbp_data.art_nielsen where (mandant_id,art_nielsen_id) in (select mandant_id,art_nielsen_id from dbp_etl_process.art_nielsen_gtin_zu)
union
select distinct mandant_id,art_nielsen_id,gtin_ref_id as gtin_id from dbp_etl_process.art_nielsen_gtin_zu
) b
  on a.mandant_id = b.mandant_id and
     a.art_nielsen_id = b.art_nielsen_id
join dbp_data.nielsen_market c
  on a.mandant_id = c.mandant_id and
     a.nielsen_market_id = c.nielsen_market_id
where (a.mandant_id,a.kjmo) in (select x.mandant_id,
                                       x.kjmo
                                from (select mandant_id,
                                             kjmo,
                                             rank() over (partition by mandant_id order by kjmo desc) * (-1) as akt_mo
                                      from dbp_data.art_nielsen_fakten_kjmo
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
      from dbp_etl_process.art_gtin a
      where mandant_id in (2,3,5,6,7,8)) b
  on a.gtin_id = b.gtin_id and
     a.mandant_id = b.mandant_id
group by 1,2,3,4
);

-- step2 for nl-articles

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
from dbp_etl_process.art_art_nielsen_matching_zu_kmo
where (mandant_id,art_id,art_nielsen_id) in (select mandant_id,art_id,art_nielsen_id from _article_matching0) and
       kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo) and
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
from dbp_etl_process.art_art_nielsen_matching_zu_kmo
where (mandant_id,art_nielsen_id) in (select mandant_id,art_nielsen_id from _article_matching0 where art_nielsen_id <> -1) and
       kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo) and
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
from dbp_etl_process.art_art_nielsen_matching_zu_kmo
where (mandant_id,art_id,gtin_id) in (select mandant_id,art_id,gtin_id from _article_matching0 where art_id <> -1 and gtin_id not in (-9999,-9998)) and
       kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo) and
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
from dbp_etl_process.art_art_nielsen_matching_zu_kmo
where (mandant_id,art_id) in (select mandant_id,art_id from _article_matching0 where art_id <> -1) and
       kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo) and
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
from dbp_etl_process.art_art_nielsen_matching_zu_kmo
where (mandant_id,gtin_id) in (select mandant_id,gtin_id from _article_matching0 where gtin_id not in (-9999,-9998)) and
       kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo) and
      (mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,matching_id,art_id,art_nielsen_id,gtin_id from _nielsen_kl_matching)
group by 1,2,3,4,5
;

delete from _article_matching0
where (mandant_id,gtin_id) in (select mandant_id,gtin_id from _nielsen_kl_matching where gtin_id not in (-9999,-9998))
;

-- 1

create or replace volatile table _upd_new_match as (
select 
       DISTINCT
       b.mandant_id,
       c.max_art_matching_id as art_matching_id,
       b.art_nielsen_id,
       a.art_id,
       a.gtin_id,
       dense_rank() over (order by a.mandant_id,a.art_nielsen_id) as rang
from _article_matching0 a
join (
select distinct mandant_id,art_nielsen_id,gtin_id from dbp_data.art_nielsen where (mandant_id,art_nielsen_id) in (select mandant_id,art_nielsen_id from dbp_etl_process.art_nielsen_gtin_zu)
union
select distinct mandant_id,art_nielsen_id,gtin_ref_id as gtin_id from dbp_etl_process.art_nielsen_gtin_zu
) b
  on a.mandant_id = b.mandant_id and
     a.art_nielsen_id = b.art_nielsen_id and a.gtin_id=b.gtin_id
join (select mandant_id,
             max(art_matching_id) as max_art_matching_id
      from dbp_etl_process.art_art_nielsen_matching_zu_kmo
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

-- start of integrating new article references

delete from _nielsen_kl_matching
where (mandant_id,matching_id) in (select mandant_id,art_matching_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo))
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo
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
       b.status,
       b.list_kz,
       b.komponente_fg,
       b.kjwo_update,
       current_timestamp,
       current_timestamp
from _nielsen_kl_matching a
join dbp_etl_process.art_art_nielsen_matching_zu_kmo b
  on a.mandant_id = b.mandant_id and
     a.gtin_id = b.gtin_id and
     a.art_nielsen_id = b.art_nielsen_id
where b.kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo) and
     (a.mandant_id,a.art_id) not in (select mandant_id,art_id
                                     from dbp_etl_process.art_art_nielsen_matching_zu_kmo
                                     where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo))
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo
select mandant_id,
       matching_id,
       art_id,
       art_nielsen_id,
       gtin_id,
       0,0,0,0,1,'N',null,0,(select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo),current_timestamp,current_timestamp
from _nielsen_kl_matching
where (mandant_id,matching_id) not in (select mandant_id,art_matching_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo)) and
      (mandant_id,matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo))
;

-- retracking of eventually missing rows
--
-- single gtins and multipple art_nielsen_id

create or replace volatile table _upd_new_match as (
select mandant_id,
      (select max(art_matching_id) from dbp_etl_process.art_art_nielsen_matching_zu_kmo where mandant_id in (2,3,5,6,7,8)) as art_matching_id,
       art_nielsen_id,
       -1 as art_id,
       gtin_id,
       dense_rank() over (order by mandant_id,art_nielsen_id) as rang
from _distinct_nl_arts
where (mandant_id,gtin_id) in (select mandant_id,gtin_id
                               from _distinct_nl_arts
                               where (mandant_id,gtin_id) not in (select mandant_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo))
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
;

insert into dbp_etl_process.art_art_nielsen_matching_zu_kmo
select mandant_id,
       matching_id,
       art_id,
       art_nielsen_id,
       gtin_id,
       0,0,0,0,1,'N',null,0,(select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo),current_timestamp,current_timestamp
from _nielsen_kl_matching
where (mandant_id,matching_id) not in (select mandant_id,art_matching_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo)) and
      (mandant_id,matching_id,art_id,art_nielsen_id,gtin_id) not in (select mandant_id,art_matching_id,art_id,art_nielsen_id,gtin_id from dbp_etl_process.art_art_nielsen_matching_zu_kmo where kjwo_update in (select max(kjwo_update) from dbp_etl_process.art_art_nielsen_matching_zu_kmo))
;

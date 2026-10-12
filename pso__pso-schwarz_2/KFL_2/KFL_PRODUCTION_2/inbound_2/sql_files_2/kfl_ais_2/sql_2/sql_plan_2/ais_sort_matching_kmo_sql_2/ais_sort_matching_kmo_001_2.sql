create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_2 where DAT_BIS='9999-12-31'
) ;

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
from _art_nielsen a
where a.mandant_id in (2,3,5,6,7,8)
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

--use only articles with WG_FILTER_ID = 47

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

--set matching_id based on previous data

merge into _nielsen_kl_matching_kmo a using (select mandant_id,
                                                max(art_matching_id) as art_matching_id,
                                                art_nielsen_id,
                                                art_id,
                                                gtin_id
                                         from dbp_etl.art_matching_nielsen_per_kmo_2 where KJWO_UPDATE = (select MAX(KJWO_UPDATE) from dbp_etl.art_matching_nielsen_per_kmo_2)
                                         group by 1,3,4,5) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.art_nielsen_id = b.art_nielsen_id and
     a.gtin_id = b.gtin_id

when matched then update set a.matching_id = b.art_matching_id
;

--check if something has been removed compared to the previous data, if so, reset the matching_id if the change is to art_id

create or replace volatile table _combined_data as
(
select mandant_id,
       art_matching_id,
       listagg (distinct art_id, ',') within group (order by art_id) as art_id
from dbp_etl.art_matching_nielsen_per_kmo_2 where KJWO_UPDATE = (select MAX(KJWO_UPDATE) from dbp_etl.art_matching_nielsen_per_kmo_2)
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

EXECUTE IMMEDIATE $$
BEGIN
  LET loop_counter1 INTEGER := (select 1);
  LET loop_counter2 INTEGER := (select 1);
  LET loop_counter3 INTEGER := (select 1);
  LET loop_counter_value INTEGER := 0;
  
  WHILE ((loop_counter1+loop_counter2+loop_counter3) > 0) DO
  
    update _nielsen_kl_matching_kmo from (select mandant_id,
                                             max(matching_id) as art_matching_id,
                                             art_id
                                      from _nielsen_kl_matching_kmo
                                      where matching_id <> -1 and
                                            art_id <> -1
                                      group by 1,3) b 
                                      
    set matching_id = b.art_matching_id
    
    where _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
          _nielsen_kl_matching_kmo.art_id = b.art_id and
          _nielsen_kl_matching_kmo.matching_id = -1 ;
    
    
    loop_counter1 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));

    update _nielsen_kl_matching_kmo from (select mandant_id,
                                             max(matching_id) as art_matching_id,
                                             art_nielsen_id
                                      from _nielsen_kl_matching_kmo
                                      where matching_id <> -1 and
                                            art_nielsen_id <> -1
                                      group by 1,3) b 
                                      
    set matching_id = b.art_matching_id
    
    where _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
          _nielsen_kl_matching_kmo.art_nielsen_id = b.art_nielsen_id and
          _nielsen_kl_matching_kmo.matching_id = -1 ;
    

    loop_counter2 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    
    update _nielsen_kl_matching_kmo from (select mandant_id,
                                             max(matching_id) as art_matching_id,
                                             gtin_id
                                      from _nielsen_kl_matching_kmo
                                      where matching_id <> -1 and
                                            gtin_id not in (-9999,-9998)
                                      group by 1,3) b 
                                      
    set matching_id = b.art_matching_id
    
    where _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
          _nielsen_kl_matching_kmo.gtin_id = b.gtin_id and
          _nielsen_kl_matching_kmo.matching_id = -1 ;
    
  
    loop_counter3 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    loop_counter_value := loop_counter_value + 1;
  END WHILE;

  RETURN loop_counter_value;

END;
$$
;

update _nielsen_kl_matching_kmo from (select mandant_id,
                                         max(matching_id) as art_matching_id,
                                         art_id
                                  from _nielsen_kl_matching_kmo
                                  where matching_id <> -1 and
                                        art_id <> -1
                                  group by 1,3) b
                                  
set matching_id = b.art_matching_id

where _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
      _nielsen_kl_matching_kmo.art_id = b.art_id and
      _nielsen_kl_matching_kmo.matching_id = -1
;

update _nielsen_kl_matching_kmo from (select mandant_id,
                                         max(matching_id) as art_matching_id,
                                         art_nielsen_id
                                  from _nielsen_kl_matching_kmo
                                  where matching_id <> -1 and
                                        art_nielsen_id <> -1
                                  group by 1,3) b
                                  
set matching_id = b.art_matching_id

where _nielsen_kl_matching_kmo.mandant_id = b.mandant_id and
      _nielsen_kl_matching_kmo.art_nielsen_id = b.art_nielsen_id and
      _nielsen_kl_matching_kmo.matching_id = -1
;

create or replace volatile table _nielsen_kl_matching_kmo_final as (
select *
from _nielsen_kl_matching_kmo
where matching_id <> -1
);

delete from _nielsen_kl_matching_kmo
where matching_id <> -1
;

-- 1st run for kl-/nl-articles

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
       dense_rank() over (order by a.mandant_id,a.art_nielsen_id) as rang
from _nielsen_kl_matching_kmo a
join _art_nielsen b
  on a.mandant_id = b.mandant_id and
     a.art_nielsen_id = b.art_nielsen_id
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
where (mandant_id,art_nielsen_id) in (select mandant_id,art_nielsen_id from _nielsen_kl_matching_kmo_final where art_nielsen_id <> -1)
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

-------------------------------------- INSERT -------------------------------------

create or replace table dbp_etl.art_matching_nielsen_per_kmo_final_2 like dbp_etl.art_matching_nielsen_per_kmo_2;

insert into dbp_etl.art_matching_nielsen_per_kmo_final_2
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
where (mandant_id,matching_id,art_nielsen_id,art_id) not in (select mandant_id,art_matching_id,art_nielsen_id,art_id from dbp_etl.art_matching_nielsen_per_kmo_final_2)
;

-------------------------------------- TESTING START -------------------------------------

EXECUTE IMMEDIATE $$
BEGIN
  LET loop_counter1 INTEGER := (select 1);
  LET loop_counter2 INTEGER := (select 1);
  LET loop_counter3 INTEGER := (select 1);
  LET loop_counter_value INTEGER := 0;
  
  WHILE ((loop_counter1+loop_counter2+loop_counter3) > 0) DO
    update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               art_nielsen_id
                                                        from dbp_etl.art_matching_nielsen_per_kmo_final_2
                                                        where art_nielsen_id <> -1
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_kmo_final.art_nielsen_id = b.art_nielsen_id ;
    
    loop_counter1 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));

    update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               art_id
                                                        from dbp_etl.art_matching_nielsen_per_kmo_final_2
                                                        where art_id <> -1
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_kmo_final.art_id = b.art_id ;

    loop_counter2 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    
    update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               gtin_id
                                                        from dbp_etl.art_matching_nielsen_per_kmo_final_2
                                                        where gtin_id not in (-9999,-9998)
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id ;

    loop_counter3 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    
    loop_counter_value := loop_counter_value + 1;
  END WHILE;

RETURN loop_counter_value;

END;
$$
;

--text based tracking for all-kmo countries

CREATE OR REPLACE VOLATILE TABLE _track_text1 AS (
SELECT a.*,
       b.art_nielsen_bez
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2 a
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
WHERE a.art_nielsen_id <> -1 AND
      b.gtin_id <> -9999 AND b.art_nielsen_bez <> 'NO DESCRIPTION'
);

UPDATE _track_text1 SET status_2 = NULL;

UPDATE _track_text1 FROM (SELECT mandant_id,
                                 art_nielsen_bez,
                                 count(distinct art_matching_id) AS anz1,
                                 count(distinct case when art_id = -1 then null else art_id end) AS anz_kl,
                                 count(distinct case when art_nielsen_id = -1 then null else art_nielsen_id end) AS anz_nl
                          FROM _track_text1
                          GROUP BY 1,2
                          HAVING anz_kl in (0,1) and anz_nl = 1) b
                          
SET status_2 = 'N'

WHERE _track_text1.mandant_id = b.mandant_id AND
      _track_text1.art_nielsen_bez = b.art_nielsen_bez
;

UPDATE _track_text1 FROM (SELECT mandant_id,
                                 art_nielsen_bez,
                                 count(distinct art_matching_id) AS anz1,
                                 count(distinct case when art_id = -1 then null else art_id end) AS anz_kl,
                                 count(distinct case when art_nielsen_id = -1 then null else art_nielsen_id end) AS anz_nl
                          FROM _track_text1
                          GROUP BY 1,2
                          HAVING (anz_kl = 0 and anz_nl > 1) or (anz_kl > 1)) b
                          
SET status_2 = 'T'

WHERE _track_text1.mandant_id = b.mandant_id AND
      _track_text1.art_nielsen_bez = b.art_nielsen_bez AND
      _track_text1.status_2 IS NULL
;

CREATE OR REPLACE VOLATILE TABLE _murks_x AS (
SELECT a.mandant_id,
       c.max_match AS art_matching_id,
       a.art_id AS art_id,
       b.art_nielsen_id,
       b.gtin_id,
       0 AS kl_art_kat_id,
       MAX(a.kl_wg_id) AS kl_wg_id,
       MAX(a.kl_owg_id) AS kl_owg_id,
       MAX(a.kl_uwg_id) AS kl_uwg_id,
       MIN(a.umrech_faktor) AS umrech_faktor,
       'T' AS status_2,
       MIN(a.list_kz) AS list_kz,
       0 AS komponente_fg,
       a.kjwo_update
FROM _track_text1 a
JOIN _art_nielsen b
ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_bez = b.art_nielsen_bez AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_nielsen_bez,
             MAX(art_matching_id) AS max_match
      FROM _track_text1
      GROUP BY 1,2) c
  ON a.mandant_id = c.mandant_id AND
     a.art_nielsen_bez = c.art_nielsen_bez
WHERE status_2 = 'T'
GROUP BY 1,2,3,4,5,6,11,13,14
);

INSERT INTO _murks_x
SELECT a.mandant_id,
       c.max_match AS art_matching_id,
       MAX(a.art_id) AS art_id,
       b.art_nielsen_id,
       b.gtin_id,
       0 AS kl_art_kat_id,
       MAX(a.kl_wg_id) AS kl_wg_id,
       MAX(a.kl_owg_id) AS kl_owg_id,
       MAX(a.kl_uwg_id) AS kl_uwg_id,
       MIN(a.umrech_faktor) AS umrech_faktor,
       'N' AS status_2,
       MIN(a.list_kz) AS list_kz,
       0 AS komponente_fg,
       a.kjwo_update
FROM _track_text1 a
JOIN (SELECT mandant_id,
             art_nielsen_bez,
             MAX(art_matching_id) AS max_match
      FROM _track_text1
      GROUP BY 1,2) c
  ON a.mandant_id = c.mandant_id AND
     a.art_nielsen_bez = c.art_nielsen_bez
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_bez = b.art_nielsen_bez AND
     a.art_nielsen_id = b.art_nielsen_id
WHERE status_2 = 'N'
GROUP BY 1,2,4,5,6,11,13,14
;

UPDATE _murks_x FROM (SELECT mandant_id,
                             art_id,
                             MAX(art_matching_id) AS max_art_matching_id
                      FROM _murks_x
                      WHERE (mandant_id,art_id) IN (SELECT mandant_id,
                                                           art_id
                                                    FROM _murks_x
                                                    WHERE art_id <> -1
                                                    GROUP BY 1,2
                                                    HAVING COUNT(*) > 1 AND
                                                           COUNT(DISTINCT art_matching_id) > 1)
                     GROUP BY 1,2) b 
                                                   
SET art_matching_id = b.max_art_matching_id

WHERE _murks_x.mandant_id = b.mandant_id AND
      _murks_x.art_id = b.art_id
;

DELETE FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
WHERE (mandant_id,art_nielsen_id,art_id,gtin_id) IN (SELECT mandant_id,art_nielsen_id,art_id,gtin_id FROM _murks_x)
;

INSERT INTO dbp_etl.art_matching_nielsen_per_kmo_final_2
SELECT *,
       current_timestamp,
       current_timestamp
FROM _murks_x 
;

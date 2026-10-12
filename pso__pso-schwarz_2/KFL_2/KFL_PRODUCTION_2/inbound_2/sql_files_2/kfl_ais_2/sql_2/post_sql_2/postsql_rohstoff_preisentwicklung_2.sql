-------------------------
--- 1. Zeitprioritaet ---
-------------------------

-- Weekly

create or replace volatile table _zwischen as (
select a.*
from dbp_data.rohstoff_preisentwicklung_2 a
join (select rohstoff_nr,
             count(distinct frequenz_cd) as anz
      from dbp_data.rohstoff_preisentwicklung_2
      group by 1
      having anz > 1) b
  on a.rohstoff_nr = b.rohstoff_nr and
     a.frequenz_cd = 'Weekly'
);

delete from dbp_data.rohstoff_preisentwicklung_2
where rohstoff_nr in (select rohstoff_nr from _zwischen)
;

insert into dbp_data.rohstoff_preisentwicklung_2
select *
from _zwischen
;

-- Daily

create or replace volatile table _zwischen as (
select a.*
from dbp_data.rohstoff_preisentwicklung_2 a
join (select rohstoff_nr,
             count(distinct frequenz_cd) as anz
      from dbp_data.rohstoff_preisentwicklung_2
      group by 1
      having anz > 1) b
  on a.rohstoff_nr = b.rohstoff_nr and
     a.frequenz_cd = 'Daily'
);

delete from dbp_data.rohstoff_preisentwicklung_2
where rohstoff_nr in (select rohstoff_nr from _zwischen)
;

insert into dbp_data.rohstoff_preisentwicklung_2
select *
from _zwischen
;

-- Monthly

create or replace volatile table _zwischen as (
select a.*
from dbp_data.rohstoff_preisentwicklung_2 a
join (select rohstoff_nr,
             count(distinct frequenz_cd) as anz
      from dbp_data.rohstoff_preisentwicklung_2
      group by 1
      having anz > 1) b
  on a.rohstoff_nr = b.rohstoff_nr and
     a.frequenz_cd = 'Monthly'
);

delete from dbp_data.rohstoff_preisentwicklung_2
where rohstoff_nr in (select rohstoff_nr from _zwischen)
;

insert into dbp_data.rohstoff_preisentwicklung_2
select *
from _zwischen
;

-------------------------
--- 2. Interpolierung ---
-------------------------

create or replace volatile table _zeit_rohstoff_preisentwicklung as (
select b.dat,
       b.kjmo,
       b.kjqu,
       b.kj,
       b.akt_tag,
       a.*
from dbp_data.rohstoff_preisentwicklung_2 a
join dbp_data.tag_2 b
  on a.dat_rohstoff_preis = b.dat
);

---------------------------------
---           Daily           ---
---------------------------------

create or replace volatile table _tag_check as (
select rohstoff_nr,
       dat,
       akt_tag
from _zeit_rohstoff_preisentwicklung
where frequenz_cd = 'Daily'
group by 1,2,3
);

create or replace volatile table _z0 as (
select rohstoff_nr,
       akt_tag,
       dat,
      (sum(akt_tag) over (partition by rohstoff_nr order by akt_tag desc nulls last rows between current row and 1 following) - akt_tag) as vorher,
       case
         when vorher = 0
         then 1
         when akt_tag - (sum(akt_tag) over (partition by rohstoff_nr order by akt_tag desc nulls last rows between current row and 1 following) - akt_tag) not in (1)
         then 0
         else 1
       end as partition_
from _tag_check
);

create or replace volatile table _z1 as (
select a.rohstoff_nr,
       a.dat,
       b.dat as vorher,
       row_number() over (partition by rohstoff_nr order by a.dat) as group_id,
       a.partition_
from _z0 a
join dbp_data.tag_2 b
  on a.vorher = b.akt_tag
where partition_ = 0
);

create or replace volatile table _z2 as (
select x.group_id,
       max(x.wtag_id) as wtag_id,
       max(x.akt_tag_von) as akt_tag_von,
       max(x.akt_tag_bis) as akt_tag_bis,
       x.rohstoff_nr,
       x.frequenz_cd,
       max(x.dat_rohstoff_preis_von) as dat_rohstoff_preis_von,
       max(x.dat_rohstoff_preis_bis) as dat_rohstoff_preis_bis,
       x.wrg_id,
       x.rohstoff_einh_name,
       max(x.preis_rohstoff_max_von) as preis_rohstoff_max_von,
       max(x.preis_rohstoff_max_bis) as preis_rohstoff_max_bis,
       max(x.dat_von) as dat_von,
       max(x.dat_bis) as dat_bis
from (  
select group_id,
       e.wtag_id,
       d.akt_tag as akt_tag_von,
       null as akt_tag_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       a.dat_rohstoff_preis as dat_rohstoff_preis_von,
       null as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       a.preis_rohstoff_max as preis_rohstoff_max_von,
       null as preis_rohstoff_max_bis,
       b.vorher as dat_von,
       null as dat_bis
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.dat = b.vorher and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.tag_2 d
  on a.dat = d.dat
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all
union all
select group_id,
       e.wtag_id,
       null as akt_wo_von,
       d.akt_tag as akt_wo_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       null as dat_rohstoff_preis_von,
       a.dat_rohstoff_preis as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       null as preis_rohstoff_max_von,
       a.preis_rohstoff_max as preis_rohstoff_max_bis,
       null as dat_von,
       b.dat as dat_bis
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.dat = b.dat and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.tag_2 d
  on a.dat = d.dat
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all) x
group by all
);

create or replace table dbp_etl.rohstoff_preisentwicklung_interpolated_2 like dbp_data.rohstoff_preisentwicklung_2;

insert into dbp_etl.rohstoff_preisentwicklung_interpolated_2 (rohstoff_nr
                                                           ,frequenz_cd
                                                           ,dat_rohstoff_preis
                                                           ,kjwo
                                                           ,wrg_id
                                                           ,rohstoff_einh_name
                                                           ,preis_rohstoff_max
                                                           ,preis_rohstoff_min
                                                           ,preis_rohstoff_avg
                                                           ,preis_gefuellt_fg
                                                           ,td_update
                                                           ,td_insert)
select x.rohstoff_nr,
       x.frequenz_cd,
       x.dat_rohstoff_preis,
       x.kjwo,
       x.wrg_id,
       x.rohstoff_einh_name,
       x.preis_rohstoff_max,
       x.preis_rohstoff_min,
       x.preis_rohstoff_avg,
       1 as preis_gefuellt_fg,
       current_timestamp as td_update,
       current_timestamp as td_insert
from (select a.rohstoff_nr,
             a.frequenz_cd,
             b.dat as dat_rohstoff_preis,
             b.kjwo,
             a.wrg_id,
             a.rohstoff_einh_name,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by a.group_id)+1 as anz,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by b.dat) as faktor,
             a.preis_rohstoff_max_von,
             a.preis_rohstoff_max_bis,
            (a.preis_rohstoff_max_bis-a.preis_rohstoff_max_von)/anz as upscale,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_max,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_min,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_avg
      from _z2 a
      join dbp_data.tag_2 b
        on b.akt_tag between a.akt_tag_von+1 and a.akt_tag_bis-1) x
group by 1,2,3,4,5,6,7,8,9,10,11,12
;

---------------------------------
---          Weekly           ---
---------------------------------

create or replace volatile table _wo_check as (
select rohstoff_nr,
       kjwo
from _zeit_rohstoff_preisentwicklung
where frequenz_cd = 'Weekly'
group by 1,2
);

create or replace volatile table _z0 as (
select rohstoff_nr,
       kjwo,
       (sum(kjwo) over (partition by rohstoff_nr order by kjwo desc nulls last rows between current row and 1 following) - kjwo) as vorher,
       case
         when vorher = 0
         then 1
         when kjwo - (sum(kjwo) over (partition by rohstoff_nr order by kjwo desc nulls last rows between current row and 1 following) - kjwo) not in (1,48,49)
         then 0
         else 1
       end as partition_
from _wo_check
);

create or replace volatile table _z1 as (
select a.*,
       row_number() over (partition by rohstoff_nr order by kjwo) as group_id
from _z0 a
where partition_ = 0
);

create or replace volatile table _z2 as (
select x.group_id,
       max(x.wtag_id) as wtag_id,
       max(x.akt_wo_von) as akt_wo_von,
       max(x.akt_wo_bis) as akt_wo_bis,
       x.rohstoff_nr,
       x.frequenz_cd,
       max(x.dat_rohstoff_preis_von) as dat_rohstoff_preis_von,
       max(x.dat_rohstoff_preis_bis) as dat_rohstoff_preis_bis,
       x.wrg_id,
       x.rohstoff_einh_name,
       max(x.preis_rohstoff_max_von) as preis_rohstoff_max_von,
       max(x.preis_rohstoff_max_bis) as preis_rohstoff_max_bis,
       max(x.kjwo_von) as kjwo_von,
       max(x.kjwo_bis) as kjwo_bis
from (  
select group_id,
       e.wtag_id,
       d.akt_wo as akt_wo_von,
       null as akt_wo_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       a.dat_rohstoff_preis as dat_rohstoff_preis_von,
       null as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       a.preis_rohstoff_max as preis_rohstoff_max_von,
       null as preis_rohstoff_max_bis,
       b.vorher as kjwo_von,
       null as kjwo_bis
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.kjwo = b.vorher and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.woche_2 d
  on a.kjwo = d.kjwo
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all
union all
select group_id,
       e.wtag_id,
       null as akt_wo_von,
       d.akt_wo as akt_wo_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       null as dat_rohstoff_preis_von,
       a.dat_rohstoff_preis as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       null as preis_rohstoff_max_von,
       a.preis_rohstoff_max as preis_rohstoff_max_bis,
       null as kjwo_von,
       b.kjwo as kjwo_bis
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.kjwo = b.kjwo and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.woche_2 d
  on a.kjwo = d.kjwo
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all) x
group by all
);

insert into dbp_etl.rohstoff_preisentwicklung_interpolated_2 (rohstoff_nr
                                                           ,frequenz_cd
                                                           ,dat_rohstoff_preis
                                                           ,kjwo
                                                           ,wrg_id
                                                           ,rohstoff_einh_name
                                                           ,preis_rohstoff_max
                                                           ,preis_rohstoff_min
                                                           ,preis_rohstoff_avg
                                                           ,preis_gefuellt_fg
                                                           ,td_update
                                                           ,td_insert)
select x.rohstoff_nr,
       x.frequenz_cd,
       x.dat_rohstoff_preis,
       x.kjwo,
       x.wrg_id,
       x.rohstoff_einh_name,
       x.preis_rohstoff_max,
       x.preis_rohstoff_min,
       x.preis_rohstoff_avg,
       1 as preis_gefuellt_fg,
       current_timestamp as td_update,
       current_timestamp as td_insert
from (select a.rohstoff_nr,
             a.frequenz_cd,
             b.dat as dat_rohstoff_preis,
             b.kjwo,
             a.wrg_id,
             a.rohstoff_einh_name,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by a.group_id)+1 as anz,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by b.kjwo) as faktor,
             a.preis_rohstoff_max_von,
             a.preis_rohstoff_max_bis,
            (a.preis_rohstoff_max_bis-a.preis_rohstoff_max_von)/anz as upscale,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_max,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_min,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_avg
      from _z2 a
      join dbp_data.tag_2 b
        on b.akt_wo between a.akt_wo_von+1 and a.akt_wo_bis-1 and
           a.wtag_id = b.wtag_id) x
group by 1,2,3,4,5,6,7,8,9,10,11,12
;

---------------------------------
---         Monthly           ---
---------------------------------

create or replace volatile table _mo_check as (
select rohstoff_nr,
       kjmo
from _zeit_rohstoff_preisentwicklung
where frequenz_cd = 'Monthly'
group by 1,2
);

create or replace volatile table _z0 as (
select rohstoff_nr,
       kjmo,
      (sum(kjmo) over (partition by rohstoff_nr order by kjmo desc nulls last rows between current row and 1 following) - kjmo) as vorher,
       case
         when vorher = 0
         then 1
         when kjmo - (sum(kjmo) over (partition by rohstoff_nr order by kjmo desc nulls last rows between current row and 1 following) - kjmo) not in (1,89)
         then 0
         else 1
       end as partition_
from _mo_check
);

create or replace volatile table _z1 as (
select a.*,
       row_number() over (partition by rohstoff_nr order by kjmo) as group_id
from _z0 a
where partition_ = 0
);

create or replace volatile table _z2 as (
select x.group_id,
       max(x.wtag_id) as wtag_id,
       max(x.akt_mo_von) as akt_mo_von,
       max(x.akt_mo_bis) as akt_mo_bis,
       x.rohstoff_nr,
       x.frequenz_cd,
       max(x.dat_rohstoff_preis_von) as dat_rohstoff_preis_von,
       max(x.dat_rohstoff_preis_bis) as dat_rohstoff_preis_bis,
       x.wrg_id,
       x.rohstoff_einh_name,
       max(x.preis_rohstoff_max_von) as preis_rohstoff_max_von,
       max(x.preis_rohstoff_max_bis) as preis_rohstoff_max_bis,
       max(x.kjmo_von) as kjmo_von,
       max(x.kjmo_bis) as kjmo_bis
from (  
select group_id,
       e.wtag_id,
       d.akt_mo as akt_mo_von,
       null as akt_mo_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       a.dat_rohstoff_preis as dat_rohstoff_preis_von,
       null as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       a.preis_rohstoff_max as preis_rohstoff_max_von,
       null as preis_rohstoff_max_bis,
       b.vorher as kjmo_von,
       null as kjmo_bis
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.kjmo = b.vorher and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.monat_2 d
  on a.kjmo = d.kjmo
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all
union all
select group_id,
       e.wtag_id,
       null as akt_mo_von,
       d.akt_mo as akt_mo_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       null as dat_rohstoff_preis_von,
       a.dat_rohstoff_preis as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       null as preis_rohstoff_max_von,
       a.preis_rohstoff_max as preis_rohstoff_max_bis,
       null as kjmo_von,
       b.kjmo as kjmo_bis
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.kjmo = b.kjmo and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.monat_2 d
  on a.kjmo = d.kjmo
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all) x
group by all
);

insert into dbp_etl.rohstoff_preisentwicklung_interpolated_2 (rohstoff_nr
                                                           ,frequenz_cd
                                                           ,dat_rohstoff_preis
                                                           ,kjwo
                                                           ,wrg_id
                                                           ,rohstoff_einh_name
                                                           ,preis_rohstoff_max
                                                           ,preis_rohstoff_min
                                                           ,preis_rohstoff_avg
                                                           ,preis_gefuellt_fg
                                                           ,td_update
                                                           ,td_insert)
select x.rohstoff_nr,
       x.frequenz_cd,
       x.dat_rohstoff_preis,
       x.kjwo,
       x.wrg_id,
       x.rohstoff_einh_name,
       x.preis_rohstoff_max,
       x.preis_rohstoff_min,
       x.preis_rohstoff_avg,
       1 as preis_gefuellt_fg,
       current_timestamp as td_update,
       current_timestamp as td_insert
from (select a.rohstoff_nr,
             a.frequenz_cd,
             b.min_dat as dat_rohstoff_preis,
             c.kjwo,
             a.wrg_id,
             a.rohstoff_einh_name,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by a.group_id)+1 as anz,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by b.kjmo) as faktor,
             a.preis_rohstoff_max_von,
             a.preis_rohstoff_max_bis,
            (a.preis_rohstoff_max_bis-a.preis_rohstoff_max_von)/anz as upscale,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_max,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_min,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_avg
      from _z2 a
      join dbp_data.monat_2 b
        on b.akt_mo between a.akt_mo_von+1 and a.akt_mo_bis-1
      join dbp_data.tag_2 c
        on b.min_dat = c.dat) x
;

---------------------------------
---        Quarterly          ---
---------------------------------

create or replace volatile table _qu_check as (
select rohstoff_nr,
       kjqu
from _zeit_rohstoff_preisentwicklung
where frequenz_cd = 'Quarterly'
group by 1,2
);

create or replace volatile table _z0 as (
select rohstoff_nr,
       kjqu,
      (sum(kjqu) over (partition by rohstoff_nr order by kjqu desc nulls last rows between current row and 1 following) - kjqu) as vorher,
       case
         when vorher = 0
         then 1
         when kjqu - (sum(kjqu) over (partition by rohstoff_nr order by kjqu desc nulls last rows between current row and 1 following) - kjqu) not in (1,97)
         then 0
         else 1
       end as partition_
from _qu_check
);

create or replace volatile table _z1 as (
select a.*,
       row_number() over (partition by rohstoff_nr order by kjqu) as group_id
from _z0 a
where partition_ = 0
);

create or replace volatile table _z2 as (
select x.group_id,
       max(x.wtag_id) as wtag_id,
       max(x.akt_kjqu_von) as akt_kjqu_von,
       max(x.akt_kjqu_bis) as akt_kjqu_bis,
       x.rohstoff_nr,
       x.frequenz_cd,
       max(x.dat_rohstoff_preis_von) as dat_rohstoff_preis_von,
       max(x.dat_rohstoff_preis_bis) as dat_rohstoff_preis_bis,
       x.wrg_id,
       x.rohstoff_einh_name,
       max(x.preis_rohstoff_max_von) as preis_rohstoff_max_von,
       max(x.preis_rohstoff_max_bis) as preis_rohstoff_max_bis,
       max(x.kjqu_von) as kjqu_von,
       max(x.kjqu_bis) as kjqu_bis
from (  
select group_id,
       e.wtag_id,
       d.akt_kjqu as akt_kjqu_von,
       null as akt_kjqu_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       a.dat_rohstoff_preis as dat_rohstoff_preis_von,
       null as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       a.preis_rohstoff_max as preis_rohstoff_max_von,
       null as preis_rohstoff_max_bis,
       b.vorher as kjqu_von,
       null as kjqu_bis
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.kjqu = b.vorher and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.quartal_kj_2 d
  on a.kjqu = d.kjqu
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all
union all
select group_id,
       e.wtag_id,
       null as akt_kjqu_von,
       d.akt_kjqu as akt_kjqu_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       null as dat_rohstoff_preis_von,
       a.dat_rohstoff_preis as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       null as preis_rohstoff_max_von,
       a.preis_rohstoff_max as preis_rohstoff_max_bis,
       null as kjqu_von,
       b.kjqu as kjqu_bis
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.kjqu = b.kjqu and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.monat_2 d
  on a.kjqu = d.kjqu
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all) x
group by all
);

insert into dbp_etl.rohstoff_preisentwicklung_interpolated_2 (rohstoff_nr
                                                           ,frequenz_cd
                                                           ,dat_rohstoff_preis
                                                           ,kjwo
                                                           ,wrg_id
                                                           ,rohstoff_einh_name
                                                           ,preis_rohstoff_max
                                                           ,preis_rohstoff_min
                                                           ,preis_rohstoff_avg
                                                           ,preis_gefuellt_fg
                                                           ,td_update
                                                           ,td_insert)
select x.rohstoff_nr,
       x.frequenz_cd,
       x.dat_rohstoff_preis,
       x.kjwo,
       x.wrg_id,
       x.rohstoff_einh_name,
       x.preis_rohstoff_max,
       x.preis_rohstoff_min,
       x.preis_rohstoff_avg,
       1 as preis_gefuellt_fg,
       current_timestamp as td_update,
       current_timestamp as td_insert
from (select a.rohstoff_nr,
             a.frequenz_cd,
             c.min_dat as dat_rohstoff_preis,
             d.kjwo,
             a.wrg_id,
             a.rohstoff_einh_name,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by a.group_id)+1 as anz,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by b.kjqu) as faktor,
             a.preis_rohstoff_max_von,
             a.preis_rohstoff_max_bis,
            (a.preis_rohstoff_max_bis-a.preis_rohstoff_max_von)/anz as upscale,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_max,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_min,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_avg
      from _z2 a
      join dbp_data.quartal_kj_2 b
        on b.akt_kjqu between a.akt_kjqu_von+1 and a.akt_kjqu_bis-1
      join (select kjqu,
                   min(min_dat) as min_dat
            from dbp_data.monat_2
            group by 1) c
        on b.kjqu = c.kjqu
      join dbp_data.tag_2 d
        on c.min_dat = d.dat) x
;

---------------------------------
---          Yearly           ---
---------------------------------

create or replace volatile table _kj_check as (
select rohstoff_nr,
       kj
from _zeit_rohstoff_preisentwicklung
where frequenz_cd = 'Yearly'
group by 1,2
);

create or replace volatile table _z0 as (
select rohstoff_nr,
       kj,
      (sum(kj) over (partition by rohstoff_nr order by kj desc nulls last rows between current row and 1 following) - kj) as vorher,
       case
         when vorher = 0
         then 1
         when kj - (sum(kj) over (partition by rohstoff_nr order by kj desc nulls last rows between current row and 1 following) - kj) not in (1)
         then 0
         else 1
       end as partition_
from _kj_check
);

create or replace volatile table _z1 as (
select a.*,
       row_number() over (partition by rohstoff_nr order by kj) as group_id
from _z0 a
where partition_ = 0
);

create or replace volatile table _z2 as (
select x.group_id,
       max(x.wtag_id) as wtag_id,
       max(x.akt_kj_von) as akt_kj_von,
       max(x.akt_kj_bis) as akt_kj_bis,
       x.rohstoff_nr,
       x.frequenz_cd,
       max(x.dat_rohstoff_preis_von) as dat_rohstoff_preis_von,
       max(x.dat_rohstoff_preis_bis) as dat_rohstoff_preis_bis,
       x.wrg_id,
       x.rohstoff_einh_name,
       max(x.preis_rohstoff_max_von) as preis_rohstoff_max_von,
       max(x.preis_rohstoff_max_bis) as preis_rohstoff_max_bis,
       max(x.kj_von) as kj_von,
       max(x.kj_bis) as kj_bis
from (  
select group_id,
       e.wtag_id,
       d.akt_kj as akt_kj_von,
       null as akt_kj_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       a.dat_rohstoff_preis as dat_rohstoff_preis_von,
       null as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       a.preis_rohstoff_max as preis_rohstoff_max_von,
       null as preis_rohstoff_max_bis,
       b.vorher as kj_von,
       null as kj_bis
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.kj = b.vorher and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.jahr_kj_2 d
  on a.kj = d.kj
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all
union all
select group_id,
       e.wtag_id,
       null as akt_kj_von,
       d.akt_kj as akt_kj_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       null as dat_rohstoff_preis_von,
       a.dat_rohstoff_preis as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       null as preis_rohstoff_max_von,
       a.preis_rohstoff_max as preis_rohstoff_max_bis,
       null as kj_von,
       b.kj as kj_bis
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.kj = b.kj and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.jahr_kj_2 d
  on a.kj = d.kj
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all) x
group by all
);

insert into dbp_etl.rohstoff_preisentwicklung_interpolated_2 (rohstoff_nr
                                                           ,frequenz_cd
                                                           ,dat_rohstoff_preis
                                                           ,kjwo
                                                           ,wrg_id
                                                           ,rohstoff_einh_name
                                                           ,preis_rohstoff_max
                                                           ,preis_rohstoff_min
                                                           ,preis_rohstoff_avg
                                                           ,preis_gefuellt_fg
                                                           ,td_update
                                                           ,td_insert)
select x.rohstoff_nr,
       x.frequenz_cd,
       x.dat_rohstoff_preis,
       x.kjwo,
       x.wrg_id,
       x.rohstoff_einh_name,
       x.preis_rohstoff_max,
       x.preis_rohstoff_min,
       x.preis_rohstoff_avg,
       1 as preis_gefuellt_fg,
       current_timestamp as td_update,
       current_timestamp as td_insert
from (select a.rohstoff_nr,
             a.frequenz_cd,
             c.min_dat as dat_rohstoff_preis,
             d.kjwo,
             a.wrg_id,
             a.rohstoff_einh_name,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by a.group_id)+1 as anz,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by b.kj) as faktor,
             a.preis_rohstoff_max_von,
             a.preis_rohstoff_max_bis,
            (a.preis_rohstoff_max_bis-a.preis_rohstoff_max_von)/anz as upscale,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_max,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_min,
             a.preis_rohstoff_max_von+(faktor*upscale) as preis_rohstoff_avg
      from _z2 a
      join dbp_data.jahr_kj_2 b
        on b.akt_kj between a.akt_kj_von+1 and a.akt_kj_bis-1
      join (select kj,
                   min(min_dat) as min_dat
            from dbp_data.monat_2
            group by 1) c
        on b.kj = c.kj
      join dbp_data.tag_2 d
        on c.min_dat = d.dat) x
;

insert into dbp_data.rohstoff_preisentwicklung_2 (rohstoff_nr
                                               ,frequenz_cd
                                               ,dat_rohstoff_preis
                                               ,kjwo
                                               ,wrg_id
                                               ,rohstoff_einh_name
                                               ,preis_rohstoff_max
                                               ,preis_rohstoff_min
                                               ,preis_rohstoff_avg
                                               ,preis_gefuellt_fg
                                               ,td_update
                                               ,td_insert)
select rohstoff_nr
      ,frequenz_cd
      ,dat_rohstoff_preis
      ,kjwo
      ,wrg_id
      ,rohstoff_einh_name
      ,preis_rohstoff_max
      ,preis_rohstoff_min
      ,preis_rohstoff_avg
      ,preis_gefuellt_fg
      ,td_update
      ,td_insert
from dbp_etl.rohstoff_preisentwicklung_interpolated_2
;

---------------------------------
--- 3. Faecher                ---
---------------------------------

---------------------------------
---          Daily            ---
---------------------------------

create or replace volatile table _faecher as (
select a.rohstoff_nr,
       max(a.dat_rohstoff_preis) as max_dat_rohstoff_preis_,
       max(b.max_dat_frequenz) as max_dat_frequenz_
from dbp_data.rohstoff_preisentwicklung_2 a
join (select max(dat_rohstoff_preis) as max_dat_frequenz
      from dbp_data.rohstoff_preisentwicklung_2
      where frequenz_cd = 'Daily') b
  on 1 = 1
where a.frequenz_cd = 'Daily'
group by 1
having max_dat_rohstoff_preis_ < max_dat_frequenz_
);

insert into dbp_data.rohstoff_preisentwicklung_2 (rohstoff_nr
                                               ,frequenz_cd
                                               ,dat_rohstoff_preis
                                               ,kjwo
                                               ,wrg_id
                                               ,rohstoff_einh_name
                                               ,preis_rohstoff_max
                                               ,preis_rohstoff_min
                                               ,preis_rohstoff_avg
                                               ,preis_gefuellt_fg
                                               ,td_update
                                               ,td_insert)
select a.rohstoff_nr
      ,a.frequenz_cd
      ,c.dat as dat_rohstoff_preis
      ,c.kjwo
      ,a.wrg_id
      ,a.rohstoff_einh_name
      ,a.preis_rohstoff_max
      ,a.preis_rohstoff_min
      ,a.preis_rohstoff_avg
      ,1 as preis_gefuellt_fg
      ,a.td_update
      ,a.td_insert
from dbp_data.rohstoff_preisentwicklung_2 a
join _faecher b
  on a.rohstoff_nr = b.rohstoff_nr and
     a.dat_rohstoff_preis = b.max_dat_rohstoff_preis_
join dbp_data.tag_2 c
  on c.dat between b.max_dat_rohstoff_preis_+1 and b.max_dat_frequenz_
;

---------------------------------
---          Weekly           ---
---------------------------------

create or replace volatile table _faecher as (
select a.rohstoff_nr,
       max(a.dat_rohstoff_preis) as max_dat_rohstoff_preis_,
       max(b.max_dat_frequenz) as max_dat_frequenz_
from dbp_data.rohstoff_preisentwicklung_2 a
join (select max(dat_rohstoff_preis) as max_dat_frequenz
      from dbp_data.rohstoff_preisentwicklung_2
      where frequenz_cd = 'Weekly') b
  on 1 = 1
where a.frequenz_cd = 'Weekly'
group by 1
having max_dat_rohstoff_preis_ < max_dat_frequenz_
);

insert into dbp_data.rohstoff_preisentwicklung_2 (rohstoff_nr
                                               ,frequenz_cd
                                               ,dat_rohstoff_preis
                                               ,kjwo
                                               ,wrg_id
                                               ,rohstoff_einh_name
                                               ,preis_rohstoff_max
                                               ,preis_rohstoff_min
                                               ,preis_rohstoff_avg
                                               ,preis_gefuellt_fg
                                               ,td_update
                                               ,td_insert)
select a.rohstoff_nr
      ,a.frequenz_cd
      ,c.dat as dat_rohstoff_preis
      ,c.kjwo
      ,a.wrg_id
      ,a.rohstoff_einh_name
      ,a.preis_rohstoff_max
      ,a.preis_rohstoff_min
      ,a.preis_rohstoff_avg
      ,1 as preis_gefuellt_fg
      ,a.td_update
      ,a.td_insert
from dbp_data.rohstoff_preisentwicklung_2 a
join _faecher b
  on a.rohstoff_nr = b.rohstoff_nr and
     a.dat_rohstoff_preis = b.max_dat_rohstoff_preis_
join dbp_data.tag_2 c
  on c.dat between b.max_dat_rohstoff_preis_+1 and b.max_dat_frequenz_ and
     c.wtag_id = 3
;

---------------------------------
---         Monthly           ---
---------------------------------

create or replace volatile table _faecher as (
select x.rohstoff_nr,
       x.max_dat_rohstoff_preis_,
       y.kjmo as kjmo_max,
       x.max_dat_frequenz_,
       z.kjmo as kjmo_max_bis
from (select a.rohstoff_nr,
             max(a.dat_rohstoff_preis) as max_dat_rohstoff_preis_,
             max(b.max_dat_frequenz) as max_dat_frequenz_
      from dbp_data.rohstoff_preisentwicklung_2 a
      join (select max(dat_rohstoff_preis) as max_dat_frequenz
            from dbp_data.rohstoff_preisentwicklung_2
            where frequenz_cd = 'Monthly') b
        on 1 = 1
      where a.frequenz_cd = 'Monthly'
      group by 1
      having max_dat_rohstoff_preis_ < max_dat_frequenz_) x
join dbp_data.monat_2 y
  on x.max_dat_rohstoff_preis_ = y.min_dat
join dbp_data.monat_2 z
  on x.max_dat_frequenz_ = z.min_dat
);

insert into dbp_data.rohstoff_preisentwicklung_2 (rohstoff_nr
                                               ,frequenz_cd
                                               ,dat_rohstoff_preis
                                               ,kjwo
                                               ,wrg_id
                                               ,rohstoff_einh_name
                                               ,preis_rohstoff_max
                                               ,preis_rohstoff_min
                                               ,preis_rohstoff_avg
                                               ,preis_gefuellt_fg
                                               ,td_update
                                               ,td_insert)
select a.rohstoff_nr
      ,a.frequenz_cd
      ,c.min_dat as dat_rohstoff_preis
      ,d.kjwo
      ,a.wrg_id
      ,a.rohstoff_einh_name
      ,a.preis_rohstoff_max
      ,a.preis_rohstoff_min
      ,a.preis_rohstoff_avg
      ,1 as preis_gefuellt_fg
      ,a.td_update
      ,a.td_insert
from dbp_data.rohstoff_preisentwicklung_2 a
join _faecher b
  on a.rohstoff_nr = b.rohstoff_nr and
     a.dat_rohstoff_preis = b.max_dat_rohstoff_preis_
join dbp_data.monat_2 c
  on c.min_dat between b.max_dat_rohstoff_preis_+1 and b.max_dat_frequenz_
join dbp_data.tag_2 d
  on c.min_dat = d.dat
group by all
;

---------------------------------
---       Quarterly           ---
---------------------------------

create or replace volatile table _faecher as (
select x.rohstoff_nr,
       x.max_dat_rohstoff_preis_,
       y.kjqu as kjqu_max,
       x.max_dat_frequenz_,
       z.kjqu as kjqu_max_bis
from (select a.rohstoff_nr,
             max(a.dat_rohstoff_preis) as max_dat_rohstoff_preis_,
             max(b.max_dat_frequenz) as max_dat_frequenz_
      from dbp_data.rohstoff_preisentwicklung_2 a
      join (select max(dat_rohstoff_preis) as max_dat_frequenz
            from dbp_data.rohstoff_preisentwicklung_2
            where frequenz_cd = 'Quarterly') b
        on 1 = 1
      where a.frequenz_cd = 'Quarterly'
      group by 1
      having max_dat_rohstoff_preis_ < max_dat_frequenz_) x
join (select kjqu,
             min(min_dat) as min_dat
      from dbp_data.monat_2
      group by 1) y
  on x.max_dat_rohstoff_preis_ = y.min_dat
join (select kjqu,
             min(min_dat) as min_dat
      from dbp_data.monat_2
      group by 1) z
  on x.max_dat_frequenz_ = z.min_dat
);

insert into dbp_data.rohstoff_preisentwicklung_2 (rohstoff_nr
                                               ,frequenz_cd
                                               ,dat_rohstoff_preis
                                               ,kjwo
                                               ,wrg_id
                                               ,rohstoff_einh_name
                                               ,preis_rohstoff_max
                                               ,preis_rohstoff_min
                                               ,preis_rohstoff_avg
                                               ,preis_gefuellt_fg
                                               ,td_update
                                               ,td_insert)
select a.rohstoff_nr
      ,a.frequenz_cd
      ,c.min_dat as dat_rohstoff_preis
      ,d.kjwo
      ,a.wrg_id
      ,a.rohstoff_einh_name
      ,a.preis_rohstoff_max
      ,a.preis_rohstoff_min
      ,a.preis_rohstoff_avg
      ,1 as preis_gefuellt_fg
      ,a.td_update
      ,a.td_insert
from dbp_data.rohstoff_preisentwicklung_2 a
join _faecher b
  on a.rohstoff_nr = b.rohstoff_nr and
     a.dat_rohstoff_preis = b.max_dat_rohstoff_preis_
join (select kjqu,
             min(min_dat) as min_dat
      from dbp_data.monat_2
      group by 1) c
  on c.min_dat between b.max_dat_rohstoff_preis_+1 and b.max_dat_frequenz_
join dbp_data.tag_2 d
  on c.min_dat = d.dat
group by all
;

---------------------------------
---          Yearly           ---
---------------------------------

create or replace volatile table _faecher as (
select x.rohstoff_nr,
       x.max_dat_rohstoff_preis_,
       y.kj as kjqu_max,
       x.max_dat_frequenz_,
       z.kj as kj_max_bis
from (select a.rohstoff_nr,
             max(a.dat_rohstoff_preis) as max_dat_rohstoff_preis_,
             max(b.max_dat_frequenz) as max_dat_frequenz_
      from dbp_data.rohstoff_preisentwicklung_2 a
      join (select max(dat_rohstoff_preis) as max_dat_frequenz
            from dbp_data.rohstoff_preisentwicklung_2
            where frequenz_cd = 'Yearly') b
        on 1 = 1
      where a.frequenz_cd = 'Yearly'
      group by 1
      having max_dat_rohstoff_preis_ < max_dat_frequenz_) x
join (select kj,
             min(min_dat) as min_dat
      from dbp_data.monat_2
      group by 1) y
  on x.max_dat_rohstoff_preis_ = y.min_dat
join (select kj,
             min(min_dat) as min_dat
      from dbp_data.monat_2
      group by 1) z
  on x.max_dat_frequenz_ = z.min_dat
);

insert into dbp_data.rohstoff_preisentwicklung_2 (rohstoff_nr
                                               ,frequenz_cd
                                               ,dat_rohstoff_preis
                                               ,kjwo
                                               ,wrg_id
                                               ,rohstoff_einh_name
                                               ,preis_rohstoff_max
                                               ,preis_rohstoff_min
                                               ,preis_rohstoff_avg
                                               ,preis_gefuellt_fg
                                               ,td_update
                                               ,td_insert)
select a.rohstoff_nr
      ,a.frequenz_cd
      ,c.min_dat as dat_rohstoff_preis
      ,d.kjwo
      ,a.wrg_id
      ,a.rohstoff_einh_name
      ,a.preis_rohstoff_max
      ,a.preis_rohstoff_min
      ,a.preis_rohstoff_avg
      ,1 as preis_gefuellt_fg
      ,a.td_update
      ,a.td_insert
from dbp_data.rohstoff_preisentwicklung_2 a
join _faecher b
  on a.rohstoff_nr = b.rohstoff_nr and
     a.dat_rohstoff_preis = b.max_dat_rohstoff_preis_
join (select kj,
             min(min_dat) as min_dat
      from dbp_data.monat_2
      group by 1) c
  on c.min_dat between b.max_dat_rohstoff_preis_+1 and b.max_dat_frequenz_
join dbp_data.tag_2 d
  on c.min_dat = d.dat
group by all
;

---------------------------------
--- 4. Unit_2 Conversion        ---
---------------------------------

create or replace volatile table _murks_2 as (
select a.rohstoff_nr,
       a.frequenz_cd,
       a.dat_rohstoff_preis,
       a.kjwo,
       a.wrg_id,
       b.rohstoff_einh_id_nach as rohstoff_einh_name,
       a.preis_rohstoff_max/b.umrechnungsfaktor as preis_rohstoff_max,
       a.preis_rohstoff_min/b.umrechnungsfaktor as preis_rohstoff_min,
       a.preis_rohstoff_avg/b.umrechnungsfaktor as preis_rohstoff_avg,
       a.preis_gefuellt_fg,
       a.td_update,
       a.td_insert
from dbp_data.rohstoff_preisentwicklung_2 a
join dbp_etl_process.rohstoff_umrechnung_2 b
  on lower(a.rohstoff_einh_name) = lower(b.rohstoff_einh_id_von)
);

insert into dbp_data.rohstoff_preisentwicklung_2 (rohstoff_nr
                                               ,frequenz_cd
                                               ,dat_rohstoff_preis
                                               ,kjwo
                                               ,wrg_id
                                               ,rohstoff_einh_name
                                               ,preis_rohstoff_max
                                               ,preis_rohstoff_min
                                               ,preis_rohstoff_avg
                                               ,preis_gefuellt_fg
                                               ,td_update
                                               ,td_insert)
select rohstoff_nr
      ,frequenz_cd
      ,dat_rohstoff_preis
      ,kjwo
      ,wrg_id
      ,rohstoff_einh_name
      ,preis_rohstoff_max
      ,preis_rohstoff_min
      ,preis_rohstoff_avg
      ,preis_gefuellt_fg
      ,td_update
      ,td_insert
from _murks_2
;

---------------------------------
--- 5. Tagesfaecher           ---
---------------------------------

create or replace volatile table _day_daily as (
select rohstoff_nr,
       max(dat_rohstoff_preis) as dat_rohstoff_preis
from dbp_data.rohstoff_preisentwicklung_2
where frequenz_cd = 'Daily' and
      preis_gefuellt_fg = 0
group by 1
);

create or replace volatile table _day_weekly as (
select rohstoff_nr,
       max(dat_rohstoff_preis) as dat_rohstoff_preis,
       max(b.max_dat) as max_dat_null
from dbp_data.rohstoff_preisentwicklung_2 a
left join (select kjwo_ww,
             min(dat) as min_dat,
             max(dat) as max_dat
      from dbp_data.werbewoche_kl_2
      where mandant_id = 2
      group by 1) b
  on a.dat_rohstoff_preis = b.min_dat
where a.frequenz_cd = 'Weekly' and
      a.preis_gefuellt_fg = 0
group by 1
);

update _day_weekly from (select kjwo,
                                min(dat) as min_dat,
                                max(dat) as max_dat
                         from dbp_data.tag_2
                         group by 1) b

set max_dat_null = b.max_dat

where _day_weekly.max_dat_null is null and
      _day_weekly.dat_rohstoff_preis = b.min_dat
;

update _day_weekly set max_dat_null = dat_rohstoff_preis+6
where _day_weekly.max_dat_null is null
;

create or replace volatile table _day_monthly as (
select a.rohstoff_nr,
       max(a.dat_rohstoff_preis) as dat_rohstoff_preis,
       max(b.max_dat) as max_dat_null
from dbp_data.rohstoff_preisentwicklung_2 a
join (select kjmo,
             min(dat) as min_dat,
             max(dat) as max_dat
      from dbp_data.tag_2
      group by 1) b
  on a.dat_rohstoff_preis = b.min_dat
where a.frequenz_cd = 'Monthly' and
      a.preis_gefuellt_fg = 0
group by 1
);

create or replace volatile table _day_quarterly as (
select a.rohstoff_nr,
       max(a.dat_rohstoff_preis) as dat_rohstoff_preis,
       max(b.max_dat) as max_dat_null
from dbp_data.rohstoff_preisentwicklung_2 a
join (select kjqu,
             min(dat) as min_dat,
             max(dat) as max_dat
      from dbp_data.tag_2
      group by 1) b
  on a.dat_rohstoff_preis = b.min_dat
where a.frequenz_cd = 'Quarterly' and
      a.preis_gefuellt_fg = 0
group by 1
);

create or replace volatile table _day_yearly as (
select a.rohstoff_nr,
       max(a.dat_rohstoff_preis) as dat_rohstoff_preis,
       max(b.max_dat) as max_dat_null
from dbp_data.rohstoff_preisentwicklung_2 a
join (select kj,
             min(dat) as min_dat,
             max(dat) as max_dat
      from dbp_data.tag_2
      group by 1) b
  on a.dat_rohstoff_preis = b.min_dat
where a.frequenz_cd = 'Yearly' and
      a.preis_gefuellt_fg = 0
group by 1
);

create or replace volatile table _zeit_rohstoff_preisentwicklung as (
select b.dat,
       b.kjmo,
       b.kjqu,
       b.kj,
       b.akt_tag,
       a.*
from dbp_data.rohstoff_preisentwicklung_2 a
join dbp_data.tag_2 b
  on a.dat_rohstoff_preis = b.dat
);

create or replace volatile table _tag_check as (
select rohstoff_nr,
       dat,
       akt_tag
from _zeit_rohstoff_preisentwicklung
where frequenz_cd <> 'Daily'
group by 1,2,3
);

create or replace volatile table _z0 as (
select rohstoff_nr,
       akt_tag,
       dat,
      (sum(akt_tag) over (partition by rohstoff_nr order by akt_tag desc nulls last rows between current row and 1 following) - akt_tag) as vorher,
       case
         when vorher = 0
         then 1
         when akt_tag - (sum(akt_tag) over (partition by rohstoff_nr order by akt_tag desc nulls last rows between current row and 1 following) - akt_tag) not in (1)
         then 0
         else 1
       end as partition_
from _tag_check
);

create or replace volatile table _z1 as (
select a.rohstoff_nr,
       a.dat,
       b.dat as vorher,
       row_number() over (partition by rohstoff_nr order by a.dat) as group_id,
       a.partition_
from _z0 a
join dbp_data.tag_2 b
  on a.vorher = b.akt_tag
where partition_ = 0
);

create or replace volatile table _z2 as (
select x.group_id,
       max(x.wtag_id) as wtag_id,
       max(x.akt_tag_von) as akt_tag_von,
       max(x.akt_tag_bis) as akt_tag_bis,
       x.rohstoff_nr,
       x.frequenz_cd,
       max(x.dat_rohstoff_preis_von) as dat_rohstoff_preis_von,
       max(x.dat_rohstoff_preis_bis) as dat_rohstoff_preis_bis,
       x.wrg_id,
       x.rohstoff_einh_name,
       x.preis_gefuellt_fg,
       max(x.preis_rohstoff_max_von) as preis_rohstoff_max_von,
       max(x.preis_rohstoff_max_bis) as preis_rohstoff_max_bis,
       max(x.dat_von) as dat_von,
       max(x.dat_bis) as dat_bis
from (  
select group_id,
       e.wtag_id,
       d.akt_tag as akt_tag_von,
       null as akt_tag_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       a.dat_rohstoff_preis as dat_rohstoff_preis_von,
       null as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       a.preis_rohstoff_max as preis_rohstoff_max_von,
       null as preis_rohstoff_max_bis,
       b.vorher as dat_von,
       null as dat_bis,
       a.preis_gefuellt_fg
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.dat = b.vorher and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.tag_2 d
  on a.dat = d.dat
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all
union all
select group_id,
       e.wtag_id,
       null as akt_wo_von,
       d.akt_tag as akt_wo_bis,
       a.rohstoff_nr,
       a.frequenz_cd,
       null as dat_rohstoff_preis_von,
       a.dat_rohstoff_preis as dat_rohstoff_preis_bis,
       a.wrg_id,
       a.rohstoff_einh_name,
       null as preis_rohstoff_max_von,
       a.preis_rohstoff_max as preis_rohstoff_max_bis,
       null as dat_von,
       b.dat as dat_bis,
       a.preis_gefuellt_fg
from _zeit_rohstoff_preisentwicklung a
join _z1 b
  on  a.dat = b.dat and
      a.rohstoff_nr = b.rohstoff_nr
join dbp_data.tag_2 d
  on a.dat = d.dat
join dbp_data.tag_2 e
  on a.dat_rohstoff_preis = e.dat
where b.partition_ = 0
group by all) x
group by all
);

create or replace table dbp_etl.rohstoff_preisentwicklung_interpolated_2 like dbp_data.rohstoff_preisentwicklung_2;

insert into dbp_etl.rohstoff_preisentwicklung_interpolated_2 (rohstoff_nr
                                                           ,frequenz_cd
                                                           ,dat_rohstoff_preis
                                                           ,kjwo
                                                           ,wrg_id
                                                           ,rohstoff_einh_name
                                                           ,preis_rohstoff_max
                                                           ,preis_rohstoff_min
                                                           ,preis_rohstoff_avg
                                                           ,preis_gefuellt_fg
                                                           ,td_update
                                                           ,td_insert)
select x.rohstoff_nr,
       x.frequenz_cd,
       x.dat_rohstoff_preis,
       x.kjwo,
       x.wrg_id,
       x.rohstoff_einh_name,
       x.preis_rohstoff_max,
       x.preis_rohstoff_min,
       x.preis_rohstoff_avg,
       x.preis_gefuellt_fg,
       current_timestamp as td_update,
       current_timestamp as td_insert
from (select a.rohstoff_nr,
             a.frequenz_cd,
             b.dat as dat_rohstoff_preis,
             b.kjwo,
             a.wrg_id,
             a.rohstoff_einh_name,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by a.group_id)+1 as anz,
             sum(1) over (partition by a.group_id,a.rohstoff_nr order by b.dat) as faktor,
             a.preis_rohstoff_max_von,
             a.preis_rohstoff_max_bis,
             a.preis_gefuellt_fg,
            (a.preis_rohstoff_max_bis-a.preis_rohstoff_max_von) as upscale,
             a.preis_rohstoff_max_von as preis_rohstoff_max,
             a.preis_rohstoff_max_von as preis_rohstoff_min,
             a.preis_rohstoff_max_von as preis_rohstoff_avg
      from _z2 a
      join dbp_data.tag_2 b
        on b.akt_tag between a.akt_tag_von+1 and a.akt_tag_bis-1) x
group by 1,2,3,4,5,6,7,8,9,10,11,12
;

delete from dbp_etl.rohstoff_preisentwicklung_interpolated_2
where (rohstoff_nr,rohstoff_einh_name,dat_rohstoff_preis,frequenz_cd,wrg_id) in (select rohstoff_nr,rohstoff_einh_name,dat_rohstoff_preis,frequenz_cd,wrg_id from dbp_data.rohstoff_preisentwicklung_2)
;

insert into dbp_data.rohstoff_preisentwicklung_2 (rohstoff_nr
                                               ,frequenz_cd
                                               ,dat_rohstoff_preis
                                               ,kjwo
                                               ,wrg_id
                                               ,rohstoff_einh_name
                                               ,preis_rohstoff_max
                                               ,preis_rohstoff_min
                                               ,preis_rohstoff_avg
                                               ,preis_gefuellt_fg
                                               ,td_update
                                               ,td_insert)
select rohstoff_nr
      ,frequenz_cd
      ,dat_rohstoff_preis
      ,kjwo
      ,wrg_id
      ,rohstoff_einh_name
      ,preis_rohstoff_max
      ,preis_rohstoff_min
      ,preis_rohstoff_avg
      ,preis_gefuellt_fg
      ,td_update
      ,td_insert
from dbp_etl.rohstoff_preisentwicklung_interpolated_2
;

create or replace volatile table _zeit_rohstoff_preisentwicklung as (
select a.*
from dbp_data.rohstoff_preisentwicklung_2 a
join dbp_data.tag_2 b
  on a.dat_rohstoff_preis = b.dat
where a.frequenz_cd <> 'Daily'
);

create or replace volatile table _tag_check as (
select rohstoff_nr,
       dat_rohstoff_preis
from _zeit_rohstoff_preisentwicklung
where frequenz_cd <> 'Daily'
group by 1,2
);

create or replace volatile table _zeit_rohstoff_preisentwicklung as (
select a.*
from _zeit_rohstoff_preisentwicklung a
join (select rohstoff_nr,
             min(max_dat) as min_max_dat
      from (select rohstoff_nr,
                   max(dat_rohstoff_preis) as max_dat 
            from _tag_check 
            group by 1)
      group by 1) b
  on a.rohstoff_nr = b.rohstoff_nr and
     a.dat_rohstoff_preis = b.min_max_dat
);

create or replace volatile table _days as (
select dat,
       akt_tag,
       kjwo
from dbp_data.tag_2
where dat between (select min(dat_rohstoff_preis) as rohstoff_preis from dbp_data.rohstoff_preisentwicklung_2) and current_date-1
);

create or replace volatile table _snap1 as (
select a.rohstoff_nr
      ,b.dat as dat_rohstoff_preis
      ,a.rohstoff_einh_name
      ,a.wrg_id
      ,a.frequenz_cd
      ,b.kjwo as kjwo
      ,a.preis_rohstoff_max
      ,a.preis_rohstoff_min
      ,a.preis_rohstoff_avg
      ,a.preis_gefuellt_fg
      ,a.td_update
      ,a.td_insert
from _zeit_rohstoff_preisentwicklung a
join _days b
  on 1 = 1
group by all
);

insert into dbp_data.rohstoff_preisentwicklung_2 (rohstoff_nr
                                               ,frequenz_cd
                                               ,dat_rohstoff_preis
                                               ,kjwo
                                               ,wrg_id
                                               ,rohstoff_einh_name
                                               ,preis_rohstoff_max
                                               ,preis_rohstoff_min
                                               ,preis_rohstoff_avg
                                               ,preis_gefuellt_fg
                                               ,td_update
                                               ,td_insert)
select rohstoff_nr
      ,frequenz_cd
      ,dat_rohstoff_preis
      ,kjwo
      ,wrg_id
      ,rohstoff_einh_name
      ,preis_rohstoff_max
      ,preis_rohstoff_min
      ,preis_rohstoff_avg
      ,preis_gefuellt_fg
      ,td_update
      ,td_insert
from _snap1
where (rohstoff_nr,rohstoff_einh_name,dat_rohstoff_preis,frequenz_cd,wrg_id) not in (select rohstoff_nr,rohstoff_einh_name,dat_rohstoff_preis,frequenz_cd,wrg_id from dbp_data.rohstoff_preisentwicklung_2)
;

delete from dbp_data.rohstoff_preisentwicklung_2
where dat_rohstoff_preis >= current_date
;

-- 1. Tag_2

update dbp_data.rohstoff_preisentwicklung_2 from (select *
                                            from _day_daily) b

set preis_gefuellt_fg = 2

where dbp_data.rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr and
      dbp_data.rohstoff_preisentwicklung.dat_rohstoff_preis > b.dat_rohstoff_preis and
      dbp_data.rohstoff_preisentwicklung.frequenz_cd = 'Daily'
;

-- 2. Woche_2

update dbp_data.rohstoff_preisentwicklung_2 from (select *
                                            from _day_weekly) b

set preis_gefuellt_fg = 0

where dbp_data.rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr and
      dbp_data.rohstoff_preisentwicklung.dat_rohstoff_preis between b.dat_rohstoff_preis and b.max_dat_null and
      dbp_data.rohstoff_preisentwicklung.frequenz_cd = 'Weekly'
;

update dbp_data.rohstoff_preisentwicklung_2 from (select *
                                            from _day_weekly) b

set preis_gefuellt_fg = 2

where dbp_data.rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr and
      dbp_data.rohstoff_preisentwicklung.dat_rohstoff_preis > b.max_dat_null and
      dbp_data.rohstoff_preisentwicklung.frequenz_cd = 'Weekly'
;

-- 3. Monat_2

update dbp_data.rohstoff_preisentwicklung_2 from (select *
                                            from _day_monthly) b

set preis_gefuellt_fg = 0

where dbp_data.rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr and
      dbp_data.rohstoff_preisentwicklung.dat_rohstoff_preis between b.dat_rohstoff_preis and b.max_dat_null and
      dbp_data.rohstoff_preisentwicklung.frequenz_cd = 'Monthly'
;

update dbp_data.rohstoff_preisentwicklung_2 from (select *
                                            from _day_monthly) b

set preis_gefuellt_fg = 2

where dbp_data.rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr and
      dbp_data.rohstoff_preisentwicklung.dat_rohstoff_preis > b.max_dat_null and
      dbp_data.rohstoff_preisentwicklung.frequenz_cd = 'Monthly'
;

-- 4. Quartal

update dbp_data.rohstoff_preisentwicklung_2 from (select *
                                            from _day_quarterly) b

set preis_gefuellt_fg = 0

where dbp_data.rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr and
      dbp_data.rohstoff_preisentwicklung.dat_rohstoff_preis between b.dat_rohstoff_preis and b.max_dat_null and
      dbp_data.rohstoff_preisentwicklung.frequenz_cd = 'Quarterly'
;

update dbp_data.rohstoff_preisentwicklung_2 from (select *
                                            from _day_quarterly) b

set preis_gefuellt_fg = 2

where dbp_data.rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr and
      dbp_data.rohstoff_preisentwicklung.dat_rohstoff_preis > b.max_dat_null and
      dbp_data.rohstoff_preisentwicklung.frequenz_cd = 'Quarterly'
;

-- 5. Jahr

update dbp_data.rohstoff_preisentwicklung_2 from (select *
                                            from _day_yearly) b

set preis_gefuellt_fg = 0

where dbp_data.rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr and
      dbp_data.rohstoff_preisentwicklung.dat_rohstoff_preis between b.dat_rohstoff_preis and b.max_dat_null and
      dbp_data.rohstoff_preisentwicklung.frequenz_cd = 'Yearly'
;

update dbp_data.rohstoff_preisentwicklung_2 from (select *
                                            from _day_yearly) b

set preis_gefuellt_fg = 2

where dbp_data.rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr and
      dbp_data.rohstoff_preisentwicklung.dat_rohstoff_preis > b.max_dat_null and
      dbp_data.rohstoff_preisentwicklung.frequenz_cd = 'Yearly'
;

---------------------------------
--- 6. Werbewoche             ---
---------------------------------

update dbp_data.rohstoff_preisentwicklung_2 from (select *
                                                from dbp_data.werbewoche_kl_2
                                                where mandant_id = 2) b

set kjwo = b.kjwo_ww

where dbp_data.rohstoff_preisentwicklung.dat_rohstoff_preis = b.dat
;

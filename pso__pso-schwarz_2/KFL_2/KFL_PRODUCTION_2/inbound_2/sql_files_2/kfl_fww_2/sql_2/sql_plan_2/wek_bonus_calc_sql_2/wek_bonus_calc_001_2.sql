create or replace volatile table _zeitraeume as (
-- KM
select a.mandant_id,
       'KM' as zeitraum_kz,
       b.kjmo as zeit_2,
       min(b.dat) as min_dat,
       max(b.dat) as max_dat,
       min(b.dat) as fake_min_dat,
       min_dat-730 as mseg_min_dat
from dbp_data.mandant_2 a
join dbp_data.tag_2 b
  on 1 = 1
where b.akt_mo_komplett = 0 and
      a.mandant_id in (2,3,4,5,6,7,8) and
      1 = (select 1
           from (select min(dat) as dat
                 from dbp_data.tag_2
                 where akt_mo = 1) a
           join dbp_data.tag_2 b
             on a.dat = b.dat
           where b.dat = current_date)
group by 1,2,3
union
select x.mandant_id,
       x.zeitraum_kz,
       x.zeit_2,
       x.min_dat,
       x.max_dat,
       y.dat as fake_min_dat,
       x.mseg_min_dat
from (select a.mandant_id,
             'KM' as zeitraum_kz,
             b.kjmo as zeit_2,
             min(b.dat) as min_dat,
             max(b.dat) as max_dat,
             current_date-min_dat as abstand,
             case
               when abstand <= 0
               then 7
               when abstand <= 7
               then 7-abstand
               else 0
             end as diff,
             min_dat-730 as mseg_min_dat
      from dbp_data.mandant_2 a
      join dbp_data.tag_2 b
        on 1 = 1
      where b.akt_mo_komplett = 1 and
            a.mandant_id in (2,3,4,5,6,7,8)
      group by 1,2,3) x
join dbp_data.tag_2 y
  on x.min_dat-x.diff = y.dat
union
-- KW
select a.mandant_id,
       'KW' as zeitraum_kz,
       b.kjwo as zeit_2,
       min(b.dat) as min_dat,
       max(b.dat) as max_dat,
       min(b.dat) as fake_min_dat,
       min_dat-730 as mseg_min_dat
from dbp_data.mandant_2 a
join dbp_data.tag_2 b
  on 1 = 1
where b.akt_wo_komplett = 0 and
      a.mandant_id in (2,3,4,5,6,7,8)
group by 1,2,3
union
select x.mandant_id,
       'KW' as zeitraum_kz,
       x.kjwo as zeit_2,
       x.min_dat,
       x.max_dat,
       y.dat as fake_min_dat,
       x.mseg_min_dat
from (select a.mandant_id,
             b.kjwo,
             min(b.dat) as min_dat,
             max(b.dat) as max_dat,
             current_date-min_dat as abstand,
             case
               when abstand <= 0
               then 7
               when abstand <= 7
               then 7-abstand
               else 0
             end as diff,
             min_dat-730 as mseg_min_dat
      from dbp_data.mandant_2 a
      join dbp_data.tag_2 b
        on 1 = 1
      where b.akt_wo_komplett = 1 and
            a.mandant_id in (2,3,4,5,6,7,8)
      group by 1,2) x
join dbp_data.tag_2 y
  on x.min_dat-x.diff = y.dat
union
-- WW
select x.mandant_id,
       'WW' as zeitraum_kz,
       x.kjwo as zeit_2,
       x.min_dat,
       x.max_dat,
       y.dat as fake_min_dat,
       x.mseg_min_dat
from (select a.mandant_id,
             b.kjwo,
             case
               when a.mandant_id = 8 then min(dat)+7
               when a.mandant_id = 2 and  max(dat)+3 >= '2019-02-27' then min(dat)+2
               when a.mandant_id = 7 then min(dat)+2
               else min(dat)+3
             end as min_dat,
             case
               when a.mandant_id = 8 then max(dat)+7
               when a.mandant_id = 2 and  max(dat)+3 >= '2019-02-27' then max(dat)+2
               when a.mandant_id = 7 then max(dat)+2
               else max(dat)+3
             end as max_dat,
             current_date-min_dat as abstand,
             case
               when abstand <= 0
               then 7
               when abstand <= 7
               then 7-abstand
               else 0
             end as diff,
             min_dat-730 as mseg_min_dat
      from dbp_data.mandant_2 a
      join dbp_data.tag_2 b
        on 1 = 1
      where b.akt_wo_komplett between 0 and 1 and
            a.mandant_id in (2,3,4,5,6,7)
      group by 1,2) x
join dbp_data.tag_2 y
  on x.min_dat-x.diff = y.dat
);

/***************************************************/
/*    s t a r t   n o r m a l e   a r t i k e l    */
/***************************************************/

create or replace volatile table _artbew_snap_kp as (
select a.mandant_id,
       b.zeitraum_kz,
       b.zeit_2,
       a.art_id,
       a.gp_id,
       a.dat,
       a.wup_id,
       case
         when a.bq_findung_id = 28
         then 1
         else 0
       end as kopf_fg,
       sum(a.menge) as menge,
       sum(a.umsatz_netto) as umsatz_netto
from dbp_data.artbew_2 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.dat between b.fake_min_dat and b.max_dat
group by 1,2,3,4,5,6,7,8
);

insert into _artbew_snap_kp
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       b.komponente_art_id,
       a.gp_id,
       a.dat,
       a.wup_id,
       0 as kopf_fg,
       sum(b.menge) as menge,
       sum(b.umsatz_netto) as umsatz_netto
from _artbew_snap_kp a
join dbp_data.artbew_stueckliste_zu_2 b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.dat = b.dat and
     a.wup_id = b.wup_id
where a.kopf_fg = 1
group by 1,2,3,4,5,6,7,8
;

delete from _artbew_snap_kp
where kopf_fg = 1
;

create or replace volatile table _artbew_snap as (
select mandant_id,
       zeitraum_kz,
       zeit_2,
       art_id,
       gp_id,
       wup_id,
       sum(menge) as menge,
       sum(umsatz_netto) as umsatz_netto
from _artbew_snap_kp
group by 1,2,3,4,5,6
);

create or replace volatile table _mseg_snap1 as (
select xxx.mandant_id,
       xxx.zeitraum_kz,
       xxx.zeit_2,
       xxx.dat_buch,
       xxx.art_id,
       xxx.gp_id,
       xxx.menge_lagerbew_bme,
       xxx.zeile,
       sum(xxx.menge_lagerbew_bme) over (partition by xxx.mandant_id,xxx.art_id,xxx.zeitraum_kz,xxx.zeit_2 order by zeile rows between unbounded preceding and current row) as accum
from (select a.mandant_id,
             b.zeitraum_kz,
             b.zeit_2,
             a.dat_buch,
             a.art_id,
             a.gp_id,
	     a.menge_lagerbew_bme,
	     row_number() over (partition by a.mandant_id,a.art_id,b.zeitraum_kz,b.zeit_2 order by a.dat_buch desc, a.gp_id desc, a.menge_lagerbew_bme desc) as zeile
      from dbp_data.lagerbew_det_2 a
      join _zeitraeume b
        on a.mandant_id = b.mandant_id and
           a.dat_buch between b.mseg_min_dat and b.max_dat
      where (a.mandant_id,a.art_id,b.zeitraum_kz,b.zeit_2) in (select mandant_id,art_id,zeitraum_kz,zeit_2 from _artbew_snap) and
             a.gp_id <> -1 and
             case 
               when a.mandant_id = 4 and a.gp_id = 6100 then 1
               when a.gp_id >= 10000 then 1
               else 0
             end = 1 and
             a.lager_bewart_id in ('101','102','901','902','161','162') and
             a.menge_lagerbew_bme > 0) xxx_2
);

create or replace volatile table _mseg_row_counter as (
select x.mandant_id,
       x.zeitraum_kz,
       x.zeit_2,
       x.art_id,
       min(x.gp_id) as gp_id,
       min(x.zeile) as zeile,
       max(b.menge) as menge
from _mseg_snap1 x
join (select mandant_id,
             zeitraum_kz,
             zeit_2,
             art_id,
             sum(menge) as menge
      from _artbew_snap
      where gp_id <> -1
      group by 1,2,3,4) b
  on x.mandant_id = b.mandant_id and
     x.art_id = b.art_id and
     x.zeitraum_kz = b.zeitraum_kz and
     x.zeit_2 = b.zeit_2
where x.accum - b.menge >= 0
group by 1,2,3,4
);

create or replace volatile table _mseg_snap2 as (
select a.*
from _mseg_snap1 a
join _mseg_row_counter b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2 and
     a.zeile <= b.zeile
group by 1,2,3,4,5,6,7,8,9
);

create or replace volatile table _mseg_snap3 as (
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 2
);

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 3
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 4
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 5
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 6
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 7
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 8
;

create or replace volatile table _mseg_snap4 as (
select a.*,
       case
         when b.menge is null
         then a.menge_lagerbew_bme
         else a.menge_lagerbew_bme-(a.accum-b.menge)
       end as neue_menge,
       a.ek_nettonetto-a.ek_mep as ek_diff,
       a.ek_nettonetto-a.ek_mep_vor_fwu as ek_diff_fwu,
       ek_diff*neue_menge as boni,
       ek_diff_fwu*neue_menge as boni_fwu,
       x.min_dat as dat_von,
       x.max_dat as dat_bis	   
from _mseg_snap3 a
join _zeitraeume x
  on a.mandant_id = x.mandant_id and
     a.zeitraum_kz = x.zeitraum_kz and
     a.zeit_2 = x.zeit_2
left join _mseg_row_counter b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2 and
     a.zeile = b.zeile
);

create or replace volatile table _mseg_snap5 as (
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.art_id,
       sum(a.neue_menge) as we_menge,
       sum(a.boni) as boni,
       sum(a.boni_fwu) as boni_fwu
from _mseg_snap4 a
group by 1,2,3,4
);

create or replace volatile table _hilfe as (
select a.mandant_id,
       b.zeitraum_kz,
       b.zeit_2,
       a.art_id,
       sum(a.menge) as menge
from dbp_data.artbew_2 a
join (select a.mandant_id,
             a.zeitraum_kz,
             a.zeit_2,
             a.art_id,
             b.fake_min_dat,
             b.max_dat
      from _mseg_snap5 a
      join _zeitraeume b
        on a.mandant_id = b.mandant_id and
           a.zeitraum_kz = b.zeitraum_kz and
           a.zeit_2 = b.zeit_2
      group by 1,2,3,4,5,6) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.dat between b.fake_min_dat and b.max_dat
group by 1,2,3,4
);

create or replace volatile table _testit as (
select a.mandant_id
      ,a.art_id
      ,a.zeitraum_kz
      ,b.min_dat as dat_von
      ,b.max_dat as dat_bis
      ,cast(coalesce(a.boni,0) as decimal(18,4)) as betrag_kmep
      ,coalesce(c.menge,0) as menge_artbew_sum
      ,cast(zeroifnull(coalesce(a.boni,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh
      ,cast(zeroifnull(coalesce(a.boni_fwu,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh_o_fwu
from _mseg_snap5 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2
left join (select *
           from _hilfe) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     a.zeitraum_kz = c.zeitraum_kz and
     a.zeit_2 = c.zeit_2
union
select a.mandant_id
      ,a.art_id
      ,'WW' as zeitraum_kz
      ,b.min_dat as dat_von
      ,b.max_dat as dat_bis
      ,cast(coalesce(a.boni,0) as decimal(18,4)) as betrag_kmep
      ,coalesce(c.menge,0) as menge_artbew_sum
      ,cast(zeroifnull(coalesce(a.boni,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh
      ,cast(zeroifnull(coalesce(a.boni_fwu,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh_o_fwu
from _mseg_snap5 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2
left join (select *
           from _hilfe) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     a.zeitraum_kz = c.zeitraum_kz and
     a.zeit_2 = c.zeit_2
where b.zeitraum_kz = 'KW' and
      b.mandant_id = 8
);

/***************************************************/
/*    s t a r t   d i s p l a y   a r t i k e l    */
/***************************************************/

---------- 0. display-analyse ----------

create or replace volatile table _relevante_artikel_1 as (
select a.mandant_id,
       a.dat_von,
       a.dat_bis,
       a.art_id as kopf_art_id,
       b.art_id as pos_art_id,
       b.komponentenmenge,
       b.komponentenmenge_einh_id
from dbp_data.stueckliste_2 a
join dbp_data.stueckliste_det_2 b
  on a.mandant_id = b.mandant_id and
     a.stueckliste_id = b.stueckliste_id and
     b.dat_bis = '9999-12-31'
where (a.mandant_id,a.art_id) in (select mandant_id,art_id from dbp_data.art_2 where artikeltyp_id = 12 and mandant_id > 1 and (mandant_id,art_id) not in (select mandant_id,art_id from dbp_etl_process.ekc_deny_displays_2)) 
);

create or replace volatile table _nums as (
select mandant_id,
       kopf_art_id,
       count(distinct pos_art_id) as anz
from _relevante_artikel_1
group by 1,2
);

create or replace volatile table _mseg_snap0 as (
select a.*
from dbp_data.lagerbew_det_2 a
join (select mandant_id,kopf_art_id from _relevante_artikel_1 group by 1,2) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.kopf_art_id
where a.mandant_id > 1
);

create or replace volatile table _shit as (
select a.mandant_id,
       b.zeitraum_kz,
       b.zeit_2,
       a.dat_buch,
       c.dat_von,
       c.dat_bis,
       d.kopf_art_id as kopf_art_id,
       d.pos_art_id as art_id,
       a.gp_id,
       a.menge_lagerbew_bme*d.komponentenmenge as menge_lagerbew_bme_
from _mseg_snap0 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.dat_buch between b.mseg_min_dat and b.max_dat
join (select mandant_id,
             kopf_art_id,
             dat_von,
             dat_bis
      from _relevante_artikel_1
      group by 1,2,3,4) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.kopf_art_id and
     a.dat_buch between c.dat_von and c.dat_bis
join _relevante_artikel_1 d
  on a.mandant_id = d.mandant_id and
     c.kopf_art_id = d.kopf_art_id and
     a.dat_buch between d.dat_von and d.dat_bis
where a.gp_id <> -1 and
      case 
        when a.mandant_id = 4 and a.gp_id = 6100 then 1
        when a.gp_id >= 10000 then 1 else 0
      end = 1 and
      a.lager_bewart_id in ('101','102','901','902','161','162')
group by 1,2,3,4,5,6,7,8,9,10
);

create or replace volatile table _zwischen as (
select x.*
from (select *
      from _shit a
      qualify row_number() over (partition by a.mandant_id,a.art_id,a.zeitraum_kz,a.zeit_2 order by a.dat_buch desc) = 1) x
);

create or replace volatile table _verarbeitung1 as (
select a.mandant_id,
       a.kopf_art_id,
       count(distinct a.art_id) as anz_pos,
       max(b.anz) as anz_vorgabe
from _zwischen a
join _nums b
  on a.mandant_id = b.mandant_id and
     a.kopf_art_id = b.kopf_art_id
group by 1,2
having anz_pos = anz_vorgabe
);

create or replace volatile table _verarbeitung2 as (
select a.mandant_id,
       a.kopf_art_id,
       count(distinct a.art_id) as anz_pos,
       max(b.anz) as anz_vorgabe
from _zwischen a
join _nums b
  on a.mandant_id = b.mandant_id and
     a.kopf_art_id = b.kopf_art_id
group by 1,2
having anz_pos <> anz_vorgabe
);

---------- 1. display-verarbeitung ----------

create or replace volatile table _relevante_artikel_1 as (
select a.mandant_id,
       a.dat_von,
       a.dat_bis,
       a.art_id as kopf_art_id,
       b.art_id as pos_art_id,
       b.komponentenmenge,
       b.komponentenmenge_einh_id
from dbp_data.stueckliste_2 a
join dbp_data.stueckliste_det_2 b
  on a.mandant_id = b.mandant_id and
     a.stueckliste_id = b.stueckliste_id and
     b.dat_bis = '9999-12-31'
where (a.mandant_id,a.art_id) in (select mandant_id,art_id from dbp_data.art_2 where artikeltyp_id = 12 and mandant_id > 1 and (mandant_id,art_id) not in (select mandant_id,art_id from dbp_etl_process.ekc_deny_displays_2)) and
      (a.mandant_id,a.art_id) in (select mandant_id,kopf_art_id from _verarbeitung1)
);

create or replace volatile table _mseg_snap0 as (
select a.*
from dbp_data.lagerbew_det_2 a
join (select mandant_id,kopf_art_id from _relevante_artikel_1 group by 1,2) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.kopf_art_id
where a.mandant_id > 1
);

create or replace volatile table _shit as (
select a.mandant_id,
       b.zeitraum_kz,
       b.zeit_2,
       a.dat_buch,
       c.dat_von,
       c.dat_bis,
       d.kopf_art_id as kopf_art_id,
       d.pos_art_id as art_id,
	   a.gp_id,
	   a.menge_lagerbew_bme*d.komponentenmenge as menge_lagerbew_bme_
from _mseg_snap0 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.dat_buch between b.mseg_min_dat and b.max_dat
join (select mandant_id,
             kopf_art_id,
             dat_von,
             dat_bis
      from _relevante_artikel_1
      group by 1,2,3,4) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.kopf_art_id and
     a.dat_buch between c.dat_von and c.dat_bis
join _relevante_artikel_1 d
  on a.mandant_id = d.mandant_id and
     c.kopf_art_id = d.kopf_art_id and
     a.dat_buch between d.dat_von and d.dat_bis
where a.gp_id <> -1 and
      case 
        when a.mandant_id = 4 and a.gp_id = 6100 then 1
        when a.gp_id >= 10000 then 1 else 0
      end = 1 and
      a.lager_bewart_id in ('101','102','901','902','161','162')
group by 1,2,3,4,5,6,7,8,9,10
);

create or replace volatile table _zwischen as (
select x.*
from (select *
      from _shit a
      qualify row_number() over (partition by a.mandant_id,a.art_id,a.zeitraum_kz,a.zeit_2 order by a.dat_buch desc) = 1) x
);

create or replace volatile table _relevante_artikel_2 as (
select a.mandant_id,
       a.dat_von,
       a.dat_bis,
       max(a.art_id) as kopf_art_id,
       b.art_id as pos_art_id,
       b.komponentenmenge,
       b.komponentenmenge_einh_id
from dbp_data.stueckliste_2 a
join dbp_data.stueckliste_det_2 b
  on a.mandant_id = b.mandant_id and
     a.stueckliste_id = b.stueckliste_id and
     b.dat_bis = '9999-12-31'
where (a.mandant_id,a.art_id) in (select mandant_id,art_id from dbp_data.art_2 where artikeltyp_id = 12 and mandant_id > 1 and (mandant_id,art_id) not in (select mandant_id,art_id from dbp_etl_process.ekc_deny_displays_2))  
  and (a.mandant_id,a.art_id) in (select mandant_id,kopf_art_id from _zwischen)
group by 1,2,3,5,6,7
);

create or replace volatile table _artbew_snap_kp_0 as (
select a.mandant_id,
       b.zeitraum_kz,
       b.zeit_2,
       a.art_id,
	   a.gp_id,
	   a.dat,
	   a.wup_id,
	   case
	      when a.bq_findung_id = 28
		  then 1
		  else 0
	   end as kopf_fg,
	   sum(a.menge) as menge,
	   sum(a.umsatz_netto) as umsatz_netto
from dbp_data.artbew_2 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.dat between b.fake_min_dat and b.max_dat
group by 1,2,3,4,5,6,7,8
);

create or replace volatile table _artbew_snap_kp as (
select distinct a.*
from _artbew_snap_kp_0 a
join (select mandant_id,pos_art_id from _relevante_artikel_2 group by 1,2) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.pos_art_id
);

create or replace volatile table _artbew_snap as (
select mandant_id,
       zeitraum_kz,
       zeit_2,
       art_id,
       gp_id,
       wup_id,
       sum(menge) as menge,
       sum(umsatz_netto) as umsatz_netto
from _artbew_snap_kp
group by 1,2,3,4,5,6
);

create or replace volatile table _mseg_snap0 as (
select a.*
from dbp_data.lagerbew_det_2 a
join (select mandant_id,kopf_art_id from _relevante_artikel_2 group by 1,2) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.kopf_art_id
where a.mandant_id > 1
);

create or replace volatile table _mseg_snap1 as (
select xxx.mandant_id,
       xxx.zeitraum_kz,
       xxx.zeit_2,
       xxx.dat_buch,
       xxx.kopf_art_id,
       xxx.art_id,
       xxx.gp_id,
       xxx.menge_lagerbew_bme_ as menge_lagerbew_bme,
       xxx.zeile,
	   sum(xxx.menge_lagerbew_bme_) over (partition by xxx.mandant_id,xxx.art_id,xxx.zeitraum_kz,xxx.zeit_2 order by zeile rows between unbounded preceding and current row) as accum
from (select x.mandant_id,
             x.zeitraum_kz,
             x.zeit_2,
             x.dat_buch,
             x.kopf_art_id,
             x.art_id,
             x.gp_id,
             x.kopf_fg,
             x.lagerbew_beleg_id,
             sum(x.menge_lagerbew_bme) as menge_lagerbew_bme_,
             row_number() over (partition by x.mandant_id,x.art_id,x.zeitraum_kz,x.zeit_2 order by x.dat_buch desc, x.kopf_fg asc, x.lagerbew_beleg_id asc, x.gp_id desc, menge_lagerbew_bme_ desc) as zeile
      from (select a.mandant_id,
                   b.zeitraum_kz,
                   b.zeit_2,
                   a.dat_buch,
                   d.kopf_art_id as kopf_art_id,
                   a.lagerbew_beleg_id,
                   a.art_id,
	               a.gp_id,
	               a.menge_lagerbew_bme,
                   1 as kopf_fg
            from dbp_data.lagerbew_det_2 a
            join _zeitraeume b
              on a.mandant_id = b.mandant_id and
                 a.dat_buch between b.mseg_min_dat and b.max_dat
            join (select mandant_id,
                         kopf_art_id,
                         dat_von,
                         dat_bis
                  from _relevante_artikel_2
                  group by 1,2,3,4) c
              on a.mandant_id = c.mandant_id and
                 a.art_id = c.kopf_art_id and
                 a.dat_buch between c.dat_von and c.dat_bis
            join _relevante_artikel_2 d
              on a.mandant_id = d.mandant_id and
                 c.kopf_art_id = d.kopf_art_id
            where (a.mandant_id,a.art_id,b.zeitraum_kz,b.zeit_2) in (select mandant_id,art_id,zeitraum_kz,zeit_2 from _artbew_snap) and
                   a.gp_id <> -1 and
                   case 
                     when a.mandant_id = 4 and a.gp_id = 6100 then 1
                     when a.gp_id >= 10000 then 1
                     else 0
                   end = 1 and
                   a.lager_bewart_id in ('101','102','901','902','161','162') and
                   a.menge_lagerbew_bme > 0
            union
            select a.mandant_id,
                   b.zeitraum_kz,
                   b.zeit_2,
                   a.dat_buch,
                   d.kopf_art_id as kopf_art_id,
                   a.lagerbew_beleg_id,
                   d.pos_art_id as art_id,
	               a.gp_id,
	               a.menge_lagerbew_bme*d.komponentenmenge as menge_lagerbew_bme,
                   1 as kopf_fg
            from _mseg_snap0 a
            join _zeitraeume b
              on a.mandant_id = b.mandant_id and
                 a.dat_buch between b.mseg_min_dat and b.max_dat
            join (select mandant_id,
                         kopf_art_id,
                         dat_von,
                         dat_bis
                  from _relevante_artikel_2
                  group by 1,2,3,4) c
              on a.mandant_id = c.mandant_id and
                 a.art_id = c.kopf_art_id and
                 a.dat_buch between c.dat_von and c.dat_bis
            join _relevante_artikel_2 d
              on a.mandant_id = d.mandant_id and
                 c.kopf_art_id = d.kopf_art_id and
                 a.dat_buch between d.dat_von and d.dat_bis
            where a.gp_id <> -1 and
                  case 
                    when a.mandant_id = 4 and a.gp_id = 6100 then 1
                    when a.gp_id >= 10000 then 1
                    else 0
                  end = 1 and
                  a.lager_bewart_id in ('101','102','901','902','161','162') and
                  a.menge_lagerbew_bme > 0
            union
            select a.mandant_id,
                   b.zeitraum_kz,
                   b.zeit_2,
                   a.dat_buch,
                   9999 as kopf_art_id,
                   a.lagerbew_beleg_id,
                   a.art_id,
	               a.gp_id,
	               a.menge_lagerbew_bme,
                   0 as kopf_fg
            from dbp_data.lagerbew_det_2 a
            join _zeitraeume b
              on a.mandant_id = b.mandant_id and
                 a.dat_buch between b.mseg_min_dat and b.max_dat
            where (a.mandant_id,a.art_id,b.zeitraum_kz,b.zeit_2) in (select mandant_id,art_id,zeitraum_kz,zeit_2 from _artbew_snap) and
                   a.gp_id <> -1 and
                   case 
                     when a.mandant_id = 4 and a.gp_id = 6100 then 1
                     when a.gp_id >= 10000 then 1
                     else 0
                   end = 1 and
                   a.lager_bewart_id in ('101','102','901','902','161','162') and
                   a.menge_lagerbew_bme > 0) x
      group by 1,2,3,4,5,6,7,8,9) xxx_2
);

create or replace volatile table _mseg_row_counter as (
select x.mandant_id,
       x.zeitraum_kz,
       x.zeit_2,
       max(x.kopf_art_id) as kopf_art_id,
       x.art_id,
       min(x.gp_id) as gp_id,
       min(x.zeile) as zeile,
       max(b.menge) as menge
from _mseg_snap1 x
join (select mandant_id,
             zeitraum_kz,
             zeit_2,
             art_id,
             sum(menge) as menge
      from _artbew_snap
      where gp_id <> -1
      group by 1,2,3,4) b
  on x.mandant_id = b.mandant_id and
     x.art_id = b.art_id and
     x.zeitraum_kz = b.zeitraum_kz and
     x.zeit_2 = b.zeit_2
where x.accum - b.menge >= 0
group by 1,2,3,5
);

create or replace volatile table _mseg_snap2 as (
select a.*
from _mseg_snap1 a
join _mseg_row_counter b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2 and
	 a.zeile <= b.zeile
group by 1,2,3,4,5,6,7,8,9,10
);

create or replace volatile table _positionen_tmp as (
select distinct
       c.*,
       a.zeitraum_kz,
       a.zeit_2,
       a.gp_id,
       a.dat_buch
from _mseg_snap1 a
join _relevante_artikel_2 c
  on a.kopf_art_id = c.kopf_art_id and
     a.mandant_id = c.mandant_id and
     a.dat_buch between c.dat_von and c.dat_bis
where (c.mandant_id,a.zeitraum_kz,a.zeit_2,a.art_id,a.dat_buch) in (select mandant_id,zeitraum_kz,zeit_2,art_id,dat_buch from _mseg_snap2)
);

create or replace volatile table _positionen as (
select distinct
       a.*,
       b.ek_nettonetto,
       b.ek_mep,
       coalesce(a.komponentenmenge*b.ek_mep,a.komponentenmenge*c.ek_mep) as gesamt_pos_wert
from _positionen_tmp a
left join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     a.pos_art_id = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
left join dbp_data.art_gp_wup_zu_per_2 c
  on a.mandant_id = c.mandant_id and
     a.pos_art_id = c.art_id and
     c.wup_id = -1 and
     a.dat_buch between c.dat_von and c.dat_bis
qualify row_number() over (partition by a.mandant_id,a.dat_von,a.dat_bis,a.kopf_art_id,a.pos_art_id,a.zeit_2,a.zeitraum_kz,a.komponentenmenge,a.dat_buch order by gesamt_pos_wert desc) = 1
);

create or replace volatile table _positionen2 as (
select a.*,
       zeroifnull(a.gesamt_pos_wert/nullifzero(b.gesamt_pos_wert_sum)) as gesamt_pos_wert_prozent
from _positionen a
join (select mandant_id,
             kopf_art_id,
             zeitraum_kz,
             zeit_2,
             sum(gesamt_pos_wert) as gesamt_pos_wert_sum
      from _positionen
      group by 1,2,3,4) b
  on a.mandant_id = b.mandant_id and
     a.kopf_art_id = b.kopf_art_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2
);

create or replace volatile table _mseg_snap3 as (
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 2
);

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 3
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 4
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 5
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 6
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 7
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 8
;

create or replace volatile table _mseg_snap4 as (
select distinct
       a.*,
       case
         when b.menge is null
         then a.menge_lagerbew_bme
         else a.menge_lagerbew_bme-(a.accum-b.menge)
       end as neue_menge,
       a.ek_nettonetto-a.ek_mep as ek_diff,
       a.ek_nettonetto-a.ek_mep_vor_fwu as ek_diff_fwu,
       x.min_dat as dat_von,
       x.max_dat as dat_bis,
       cast(cast(ek_diff as float)*coalesce(cast(y.gesamt_pos_wert_prozent as float),1)/coalesce(cast(y.komponentenmenge as float),1) as float) as ek_stueck,
       cast(cast(ek_diff_fwu as float)*coalesce(cast(y.gesamt_pos_wert_prozent as float),1)/coalesce(cast(y.komponentenmenge as float),1) as float) as ek_stueck_fwu
from _mseg_snap3 a
join _zeitraeume x
  on a.mandant_id = x.mandant_id and
     a.zeitraum_kz = x.zeitraum_kz and
     a.zeit_2 = x.zeit_2
left join (select mandant_id,
                  kopf_art_id,
                  pos_art_id,
                  zeitraum_kz,
                  zeit_2,
                  komponentenmenge,
                  sum(gesamt_pos_wert_prozent) as gesamt_pos_wert_prozent
           from _positionen2
           group by 1,2,3,4,5,6) y
  on a.mandant_id = y.mandant_id and
     a.kopf_art_id = y.kopf_art_id and
     a.art_id = y.pos_art_id and
     a.zeitraum_kz = y.zeitraum_kz and
     a.zeit_2 = y.zeit_2
left join _mseg_row_counter b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2 and
     a.zeile = b.zeile
);

create or replace volatile table _mseg_snap5_v1 as (
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.art_id,
       sum(a.ek_stueck*b.we_menge) as boni,
       sum(a.ek_stueck_fwu*b.we_menge) as boni_fwu
from _mseg_snap4 a
join (select mandant_id,
             zeitraum_kz,
             zeit_2,
             art_id,
             zeile,
             neue_menge as we_menge
      from _mseg_snap4
      group by 1,2,3,4,5,6) b
  on a.mandant_id = b.mandant_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2 and
     a.art_id = b.art_id and
     a.zeile = b.zeile
group by 1,2,3,4
);

create or replace volatile table _hilfe_v1 as (
select a.mandant_id,
       b.zeitraum_kz,
       b.zeit_2,
       a.art_id,
       sum(a.menge) as menge
from dbp_data.artbew_2 a
join (select a.mandant_id,
             a.zeitraum_kz,
             a.zeit_2,
             a.art_id,
             b.fake_min_dat,
             b.max_dat
      from _mseg_snap5_v1 a
      join _zeitraeume b
        on a.mandant_id = b.mandant_id and
           a.zeitraum_kz = b.zeitraum_kz and
           a.zeit_2 = b.zeit_2
      group by 1,2,3,4,5,6) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.dat between b.fake_min_dat and b.max_dat
group by 1,2,3,4
);

---------- 2. display-verarbeitung ----------

create or replace volatile table _relevante_artikel_1 as (
select a.mandant_id,
       a.dat_von,
       a.dat_bis,
       a.art_id as kopf_art_id,
       b.art_id as pos_art_id,
       b.komponentenmenge,
       b.komponentenmenge_einh_id
from dbp_data.stueckliste_2 a
join dbp_data.stueckliste_det_2 b
  on a.mandant_id = b.mandant_id and
     a.stueckliste_id = b.stueckliste_id and
     b.dat_bis = '9999-12-31'
where (a.mandant_id,a.art_id) in (select mandant_id,art_id from dbp_data.art_2 where artikeltyp_id = 12 and mandant_id > 1 and (mandant_id,art_id) not in (select mandant_id,art_id from dbp_etl_process.ekc_deny_displays_2)) and
      (a.mandant_id,a.art_id) in (select mandant_id,kopf_art_id from _verarbeitung2)
);

create or replace volatile table _mseg_snap0 as (
select a.*
from dbp_data.lagerbew_det_2 a
join (select mandant_id,kopf_art_id from _relevante_artikel_1 group by 1,2) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.kopf_art_id
where a.mandant_id > 1
);

create or replace volatile table _shit as (
select a.mandant_id,
       b.zeitraum_kz,
       b.zeit_2,
       a.dat_buch,
       c.dat_von,
       c.dat_bis,
       d.kopf_art_id as kopf_art_id,
       d.pos_art_id as art_id,
	   a.gp_id,
	   a.menge_lagerbew_bme*d.komponentenmenge as menge_lagerbew_bme_
from _mseg_snap0 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.dat_buch between b.mseg_min_dat and b.max_dat
join (select mandant_id,
             kopf_art_id,
             dat_von,
             dat_bis
      from _relevante_artikel_1
      group by 1,2,3,4) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.kopf_art_id and
     a.dat_buch between c.dat_von and c.dat_bis
join _relevante_artikel_1 d
  on a.mandant_id = d.mandant_id and
     c.kopf_art_id = d.kopf_art_id and
     a.dat_buch between d.dat_von and d.dat_bis
where a.gp_id <> -1 and
      case 
        when a.mandant_id = 4 and a.gp_id = 6100 then 1
        when a.gp_id >= 10000 then 1 else 0
      end = 1 and
      a.lager_bewart_id in ('101','102','901','902','161','162')
group by 1,2,3,4,5,6,7,8,9,10
);

create or replace volatile table _zwischen as (
select x.*
from (select *
      from _shit a
      qualify row_number() over (partition by a.mandant_id,a.art_id,a.kopf_art_id,a.zeitraum_kz,a.zeit_2 order by a.dat_buch desc) = 1) x
);

create or replace volatile table _relevante_artikel_2 as (
select a.mandant_id,
       a.dat_von,
       a.dat_bis,
       max(a.art_id) as kopf_art_id,
       b.art_id as pos_art_id,
       b.komponentenmenge,
       b.komponentenmenge_einh_id
from dbp_data.stueckliste_2 a
join dbp_data.stueckliste_det_2 b
  on a.mandant_id = b.mandant_id and
     a.stueckliste_id = b.stueckliste_id and
     b.dat_bis = '9999-12-31'
where (a.mandant_id,a.art_id) in (select mandant_id,art_id from dbp_data.art_2 where artikeltyp_id = 12 and mandant_id > 1 and (mandant_id,art_id) not in (select mandant_id,art_id from dbp_etl_process.ekc_deny_displays_2)) 
  and (a.mandant_id,a.art_id) in (select mandant_id,kopf_art_id from _zwischen)
group by 1,2,3,5,6,7
);

create or replace volatile table _artbew_snap_kp_0 as (
select a.mandant_id,
       b.zeitraum_kz,
       b.zeit_2,
       a.art_id,
       a.gp_id,
       a.dat,
       a.wup_id,
       case
         when a.bq_findung_id = 28
         then 1
         else 0
       end as kopf_fg,
       sum(a.menge) as menge,
       sum(a.umsatz_netto) as umsatz_netto
from dbp_data.artbew_2 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.dat between b.fake_min_dat and b.max_dat
group by 1,2,3,4,5,6,7,8
);

create or replace volatile table _artbew_snap_kp as (
select distinct a.*
from _artbew_snap_kp_0 a
join (select mandant_id,pos_art_id from _relevante_artikel_2 group by 1,2) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.pos_art_id
);

create or replace volatile table _artbew_snap as (
select mandant_id,
       zeitraum_kz,
       zeit_2,
       art_id,
	   gp_id,
	   wup_id,
	   sum(menge) as menge,
	   sum(umsatz_netto) as umsatz_netto
from _artbew_snap_kp
group by 1,2,3,4,5,6
);

create or replace volatile table _mseg_snap0 as (
select a.*
from dbp_data.lagerbew_det_2 a
join (select mandant_id,kopf_art_id from _relevante_artikel_2 group by 1,2) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.kopf_art_id
where a.mandant_id > 1
);

create or replace volatile table _mseg_snap1 as (
select xxx.mandant_id,
       xxx.zeitraum_kz,
       xxx.zeit_2,
       xxx.dat_buch,
       xxx.kopf_art_id,
       xxx.art_id,
       xxx.gp_id,
       xxx.menge_lagerbew_bme_ as menge_lagerbew_bme,
       xxx.zeile,
	   sum(xxx.menge_lagerbew_bme_) over (partition by xxx.mandant_id,xxx.art_id,xxx.zeitraum_kz,xxx.zeit_2 order by zeile rows between unbounded preceding and current row) as accum
from (select x.mandant_id,
             x.zeitraum_kz,
             x.zeit_2,
             x.dat_buch,
             x.kopf_art_id,
             x.art_id,
             x.gp_id,
             x.kopf_fg,
             x.lagerbew_beleg_id,
             sum(x.menge_lagerbew_bme) as menge_lagerbew_bme_,
             row_number() over (partition by x.mandant_id,x.art_id,x.zeitraum_kz,x.zeit_2 order by x.dat_buch desc, x.kopf_fg asc, x.lagerbew_beleg_id asc, x.gp_id desc, menge_lagerbew_bme_ desc) as zeile
      from (select a.mandant_id,
                   b.zeitraum_kz,
                   b.zeit_2,
                   a.dat_buch,
                   d.kopf_art_id as kopf_art_id,
                   a.lagerbew_beleg_id,
                   a.art_id,
	               a.gp_id,
	               a.menge_lagerbew_bme,
                   1 as kopf_fg
            from dbp_data.lagerbew_det_2 a
            join _zeitraeume b
              on a.mandant_id = b.mandant_id and
                 a.dat_buch between b.mseg_min_dat and b.max_dat
            join (select mandant_id,
                         kopf_art_id,
                         dat_von,
                         dat_bis
                  from _relevante_artikel_2
                  group by 1,2,3,4) c
              on a.mandant_id = c.mandant_id and
                 a.art_id = c.kopf_art_id and
                 a.dat_buch between c.dat_von and c.dat_bis
            join _relevante_artikel_2 d
              on a.mandant_id = d.mandant_id and
                 c.kopf_art_id = d.kopf_art_id
            where (a.mandant_id,a.art_id,b.zeitraum_kz,b.zeit_2) in (select mandant_id,art_id,zeitraum_kz,zeit_2 from _artbew_snap) and
                   a.gp_id <> -1 and
                   case 
                     when a.mandant_id = 4 and a.gp_id = 6100 then 1
                     when a.gp_id >= 10000 then 1
                     else 0
                   end = 1 and
                   a.lager_bewart_id in ('101','102','901','902','161','162') and
                   a.menge_lagerbew_bme > 0
            union all
            select a.mandant_id,
                   b.zeitraum_kz,
                   b.zeit_2,
                   a.dat_buch,
                   d.kopf_art_id as kopf_art_id,
                   a.lagerbew_beleg_id,
                   d.pos_art_id as art_id,
	               a.gp_id,
	               a.menge_lagerbew_bme*d.komponentenmenge as menge_lagerbew_bme,
                   1 as kopf_fg
            from _mseg_snap0 a
            join _zeitraeume b
              on a.mandant_id = b.mandant_id and
                 a.dat_buch between b.mseg_min_dat and b.max_dat
            join (select mandant_id,
                         kopf_art_id,
                         dat_von,
                         dat_bis
                  from _relevante_artikel_2
                  group by 1,2,3,4) c
              on a.mandant_id = c.mandant_id and
                 a.art_id = c.kopf_art_id and
                 a.dat_buch between c.dat_von and c.dat_bis
            join _relevante_artikel_2 d
              on a.mandant_id = d.mandant_id and
                 c.kopf_art_id = d.kopf_art_id and
                 a.dat_buch between d.dat_von and d.dat_bis
            where a.gp_id <> -1 and
                  case 
                    when a.mandant_id = 4 and a.gp_id = 6100 then 1
                    when a.gp_id >= 10000 then 1
                    else 0
                  end = 1 and
                  a.lager_bewart_id in ('101','102','901','902','161','162') and
                  a.menge_lagerbew_bme > 0
            union all
            select a.mandant_id,
                   b.zeitraum_kz,
                   b.zeit_2,
                   a.dat_buch,
                   9999 as kopf_art_id,
                   a.lagerbew_beleg_id,
                   a.art_id,
	               a.gp_id,
	               a.menge_lagerbew_bme,
                   0 as kopf_fg
            from dbp_data.lagerbew_det_2 a
            join _zeitraeume b
              on a.mandant_id = b.mandant_id and
                 a.dat_buch between b.mseg_min_dat and b.max_dat
            where (a.mandant_id,a.art_id,b.zeitraum_kz,b.zeit_2) in (select mandant_id,art_id,zeitraum_kz,zeit_2 from _artbew_snap) and
                   a.gp_id <> -1 and
                   case 
                     when a.mandant_id = 4 and a.gp_id = 6100 then 1
                     when a.gp_id >= 10000 then 1
                     else 0
                   end = 1 and
                   a.lager_bewart_id in ('101','102','901','902','161','162') and
                   a.menge_lagerbew_bme > 0) x
      group by 1,2,3,4,5,6,7,8,9) xxx_2
);

create or replace volatile table _mseg_row_counter as (
select x.mandant_id,
       x.zeitraum_kz,
       x.zeit_2,
       max(x.kopf_art_id) as kopf_art_id,
       x.art_id,
       min(x.gp_id) as gp_id,
       min(x.zeile) as zeile,
       max(b.menge) as menge
from _mseg_snap1 x
join (select mandant_id,
             zeitraum_kz,
             zeit_2,
             art_id,
             sum(menge) as menge
      from _artbew_snap
      where gp_id <> -1
      group by 1,2,3,4) b
  on x.mandant_id = b.mandant_id and
     x.art_id = b.art_id and
     x.zeitraum_kz = b.zeitraum_kz and
     x.zeit_2 = b.zeit_2
where x.accum - b.menge >= 0
group by 1,2,3,5
);

create or replace volatile table _mseg_snap2 as (
select a.*
from _mseg_snap1 a
join _mseg_row_counter b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2 and
     a.zeile <= b.zeile
group by 1,2,3,4,5,6,7,8,9,10
);

create or replace volatile table _positionen_tmp as (
select distinct
       c.*,
       a.zeitraum_kz,
       a.zeit_2,
       a.gp_id,
       a.dat_buch
from _mseg_snap1 a
join _relevante_artikel_2 c
  on a.kopf_art_id = c.kopf_art_id and
     a.mandant_id = c.mandant_id and
     a.dat_buch between c.dat_von and c.dat_bis
where (c.mandant_id,a.zeitraum_kz,a.zeit_2,a.art_id,a.dat_buch) in (select mandant_id,zeitraum_kz,zeit_2,art_id,dat_buch from _mseg_snap2)
);

create or replace volatile table _positionen as (
select distinct
       a.*,
       b.ek_nettonetto,
       b.ek_mep,
       coalesce(a.komponentenmenge*b.ek_mep,a.komponentenmenge*c.ek_mep) as gesamt_pos_wert
from _positionen_tmp a
left join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     a.pos_art_id = b.art_id and
	 a.gp_id = b.gp_id and
	 b.wup_id = -1 and
	 a.dat_buch between b.dat_von and b.dat_bis
left join dbp_data.art_gp_wup_zu_per_2 c
  on a.mandant_id = c.mandant_id and
     a.pos_art_id = c.art_id and
	 c.wup_id = -1 and
	 a.dat_buch between c.dat_von and c.dat_bis
qualify row_number() over (partition by a.mandant_id,a.dat_von,a.dat_bis,a.kopf_art_id,a.pos_art_id,a.zeit_2,a.zeitraum_kz,a.komponentenmenge,a.dat_buch order by gesamt_pos_wert desc) = 1
);

create or replace volatile table _positionen2 as (
select a.*,
       a.gesamt_pos_wert/b.gesamt_pos_wert_sum as gesamt_pos_wert_prozent
from _positionen a
join (select mandant_id,
             kopf_art_id,
             zeitraum_kz,
             zeit_2,
             sum(gesamt_pos_wert) as gesamt_pos_wert_sum
      from _positionen
      group by 1,2,3,4) b
  on a.mandant_id = b.mandant_id and
     a.kopf_art_id = b.kopf_art_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2
);

create or replace volatile table _mseg_snap3 as (
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 2
);

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 3
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 4
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 5
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 6
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 7
;

insert into _mseg_snap3
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.dat_buch,
       a.kopf_art_id,
       a.art_id,
       a.gp_id,
       a.menge_lagerbew_bme,
       a.zeile,
       a.accum,
       cast(b.ek_nettonetto as decimal(18,4)) as ek_nettonetto,
       cast(b.ek_mep as decimal(18,4)) as ek_mep,    
       cast(b.ek_mep_vor_fwu as decimal(18,4)) as ek_mep_vor_fwu
from _mseg_snap2 a
join dbp_data.art_gp_wup_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     case
       when a.kopf_art_id = 9999
       then a.art_id
       else a.kopf_art_id 
     end = b.art_id and
     a.gp_id = b.gp_id and
     b.wup_id = -1 and
     a.dat_buch between b.dat_von and b.dat_bis
where a.mandant_id = 8
;

create or replace volatile table _mseg_snap4 as (
select distinct
       a.*,
       case
         when b.menge is null
         then a.menge_lagerbew_bme
         else a.menge_lagerbew_bme-(a.accum-b.menge)
       end as neue_menge,
       a.ek_nettonetto-a.ek_mep as ek_diff,
       a.ek_nettonetto-a.ek_mep_vor_fwu as ek_diff_fwu,
       x.min_dat as dat_von,
       x.max_dat as dat_bis,
       cast(cast(ek_diff as float)*coalesce(cast(y.gesamt_pos_wert_prozent as float),1)/coalesce(cast(y.komponentenmenge as float),1) as float) as ek_stueck,
       cast(cast(ek_diff_fwu as float)*coalesce(cast(y.gesamt_pos_wert_prozent as float),1)/coalesce(cast(y.komponentenmenge as float),1) as float) as ek_stueck_fwu
from _mseg_snap3 a
join _zeitraeume x
  on a.mandant_id = x.mandant_id and
     a.zeitraum_kz = x.zeitraum_kz and
     a.zeit_2 = x.zeit_2
left join (select mandant_id,
                  kopf_art_id,
                  pos_art_id,
                  zeitraum_kz,
                  zeit_2,
                  komponentenmenge,
                  sum(gesamt_pos_wert_prozent) as gesamt_pos_wert_prozent
           from _positionen2
           group by 1,2,3,4,5,6) y
  on a.mandant_id = y.mandant_id and
     a.kopf_art_id = y.kopf_art_id and
     a.art_id = y.pos_art_id and
     a.zeitraum_kz = y.zeitraum_kz and
     a.zeit_2 = y.zeit_2
left join _mseg_row_counter b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2 and
     a.zeile = b.zeile
);

create or replace volatile table _mseg_snap5_v2 as (
select a.mandant_id,
       a.zeitraum_kz,
       a.zeit_2,
       a.art_id,
       sum(a.ek_stueck*b.we_menge) as boni,
       sum(a.ek_stueck_fwu*b.we_menge) as boni_fwu
from _mseg_snap4 a
join (select mandant_id,
             zeitraum_kz,
             zeit_2,
             art_id,
             zeile,
             neue_menge as we_menge
      from _mseg_snap4
      group by 1,2,3,4,5,6) b
  on a.mandant_id = b.mandant_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2 and
     a.art_id = b.art_id and
     a.zeile = b.zeile
group by 1,2,3,4
);

create or replace volatile table _hilfe_v2 as (
select a.mandant_id,
       b.zeitraum_kz,
       b.zeit_2,
       a.art_id,
       sum(a.menge) as menge
from dbp_data.artbew_2 a
join (select a.mandant_id,
             a.zeitraum_kz,
             a.zeit_2,
             a.art_id,
             b.fake_min_dat,
             b.max_dat
      from _mseg_snap5_v2 a
      join _zeitraeume b
        on a.mandant_id = b.mandant_id and
           a.zeitraum_kz = b.zeitraum_kz and
           a.zeit_2 = b.zeit_2
      group by 1,2,3,4,5,6) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.dat between b.fake_min_dat and b.max_dat
group by 1,2,3,4
);

delete from _testit
where (mandant_id,art_id,zeitraum_kz,dat_von,dat_bis) in (select a.mandant_id
                                                                ,a.art_id
                                                                ,a.zeitraum_kz
                                                                ,b.min_dat as dat_von
                                                                ,b.max_dat as dat_bis
                                                          from _mseg_snap5_v1 a
                                                          join _zeitraeume b
                                                            on a.mandant_id = b.mandant_id and
                                                               a.zeitraum_kz = b.zeitraum_kz and
                                                               a.zeit_2 = b.zeit_2
                                                          union
                                                          select a.mandant_id
                                                                ,a.art_id
                                                                ,'WW' as zeitraum_kz
                                                                ,b.min_dat as dat_von
                                                                ,b.max_dat as dat_bis
                                                          from _mseg_snap5_v1 a
                                                          join _zeitraeume b
                                                            on a.mandant_id = b.mandant_id and
                                                               a.zeitraum_kz = b.zeitraum_kz and
                                                               a.zeit_2 = b.zeit_2
                                                          where b.zeitraum_kz = 'KW' and
                                                                b.mandant_id = 8
                                                          union
                                                          select a.mandant_id
                                                                ,a.art_id
                                                                ,a.zeitraum_kz
                                                                ,b.min_dat as dat_von
                                                                ,b.max_dat as dat_bis
                                                          from _mseg_snap5_v2 a
                                                          join _zeitraeume b
                                                            on a.mandant_id = b.mandant_id and
                                                               a.zeitraum_kz = b.zeitraum_kz and
                                                               a.zeit_2 = b.zeit_2
                                                          union
                                                          select a.mandant_id
                                                                ,a.art_id
                                                                ,'WW' as zeitraum_kz
                                                                ,b.min_dat as dat_von
                                                                ,b.max_dat as dat_bis
                                                          from _mseg_snap5_v2 a
                                                          join _zeitraeume b
                                                            on a.mandant_id = b.mandant_id and
                                                               a.zeitraum_kz = b.zeitraum_kz and
                                                               a.zeit_2 = b.zeit_2
                                                          where b.zeitraum_kz = 'KW' and
                                                                b.mandant_id = 8)
;

insert into _testit (mandant_id
                    ,art_id
                    ,zeitraum_kz
                    ,dat_von
                    ,dat_bis
                    ,betrag_kmep
                    ,menge_artbew_sum
                    ,betrag_kmep_einh
                    ,betrag_kmep_einh_o_fwu)
select a.mandant_id
      ,a.art_id
      ,a.zeitraum_kz
      ,b.min_dat as dat_von
      ,b.max_dat as dat_bis
      ,cast(coalesce(a.boni,0) as decimal(18,4)) as betrag_kmep
      ,coalesce(c.menge,0) as menge_artbew_sum
      ,cast(zeroifnull(coalesce(a.boni,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh
      ,cast(zeroifnull(coalesce(a.boni_fwu,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh_fwu
from _mseg_snap5_v1 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2
left join (select *
           from _hilfe_v1) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     a.zeitraum_kz = c.zeitraum_kz and
     a.zeit_2 = c.zeit_2
union
select a.mandant_id
      ,a.art_id
      ,'WW' as zeitraum_kz
      ,b.min_dat as dat_von
      ,b.max_dat as dat_bis
      ,cast(coalesce(a.boni,0) as decimal(18,4)) as betrag_kmep
      ,coalesce(c.menge,0) as menge_artbew_sum
      ,cast(zeroifnull(coalesce(a.boni,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh
      ,cast(zeroifnull(coalesce(a.boni_fwu,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh_fwu
from _mseg_snap5_v1 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2
left join (select *
           from _hilfe_v1) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     a.zeitraum_kz = c.zeitraum_kz and
     a.zeit_2 = c.zeit_2
where b.zeitraum_kz = 'KW' and
      b.mandant_id = 8
;

insert into _testit (mandant_id
                    ,art_id
                    ,zeitraum_kz
                    ,dat_von
                    ,dat_bis
                    ,betrag_kmep
                    ,menge_artbew_sum
                    ,betrag_kmep_einh
                    ,betrag_kmep_einh_o_fwu)
select a.mandant_id
      ,a.art_id
      ,a.zeitraum_kz
      ,b.min_dat as dat_von
      ,b.max_dat as dat_bis
      ,cast(coalesce(a.boni,0) as decimal(18,4)) as betrag_kmep
      ,coalesce(c.menge,0) as menge_artbew_sum
      ,cast(zeroifnull(coalesce(a.boni,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh
      ,cast(zeroifnull(coalesce(a.boni_fwu,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh_fwu
from _mseg_snap5_v2 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2
left join (select *
           from _hilfe_v2) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     a.zeitraum_kz = c.zeitraum_kz and
     a.zeit_2 = c.zeit_2
where (a.mandant_id,a.art_id,a.zeitraum_kz,a.zeit_2) not in (select mandant_id,art_id,zeitraum_kz,zeit_2 from _mseg_snap5_v1)
union
select a.mandant_id
      ,a.art_id
      ,'WW' as zeitraum_kz
      ,b.min_dat as dat_von
      ,b.max_dat as dat_bis
      ,cast(coalesce(a.boni,0) as decimal(18,4)) as betrag_kmep
      ,coalesce(c.menge,0) as menge_artbew_sum
      ,cast(zeroifnull(coalesce(a.boni,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh
      ,cast(zeroifnull(coalesce(a.boni_fwu,0)/nullifzero(c.menge)) as decimal(18,4)) as betrag_kmep_einh_fwu
from _mseg_snap5_v2 a
join _zeitraeume b
  on a.mandant_id = b.mandant_id and
     a.zeitraum_kz = b.zeitraum_kz and
     a.zeit_2 = b.zeit_2
left join (select *
           from _hilfe_v2) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     a.zeitraum_kz = c.zeitraum_kz and
     a.zeit_2 = c.zeit_2
where b.zeitraum_kz = 'KW' and
      b.mandant_id = 8 and
     (a.mandant_id,a.art_id,a.zeitraum_kz,a.zeit_2) not in (select mandant_id,art_id,zeitraum_kz,zeit_2 from _mseg_snap5_v1)
;

delete from dbp_data.art_umsatz_kmep_zu_per_2
where (mandant_id,dat_von,dat_bis,zeitraum_kz) in (select mandant_id,dat_von,dat_bis,zeitraum_kz from _testit)
;

insert into dbp_data.art_umsatz_kmep_zu_per_2 (mandant_id
                                            ,art_id
                                            ,zeitraum_kz
                                            ,dat_von
                                            ,dat_bis
                                            ,menge_artbew_sum
                                            ,betrag_kmep
                                            ,betrag_kmep_einh
                                            ,wrg_id
                                            ,betrag_kmep_einh_o_fwu)
select a.mandant_id
      ,a.art_id
      ,a.zeitraum_kz
      ,a.dat_von
      ,a.dat_bis
      ,a.menge_artbew_sum
      ,null as betrag_kmep
      ,a.betrag_kmep_einh
      ,b.default_wrg as wrg_id
      ,a.betrag_kmep_einh_o_fwu
from _testit a
join dbp_data.mandant_2 b
  on a.mandant_id = b.mandant_id
;

delete from dbp_etl_process.ekc_artbew_kmep_2
where (mandant_id,dat_von,dat_bis,zeitraum_kz) in (select mandant_id,dat_von,dat_bis,zeitraum_kz from _testit)
;

insert into dbp_etl_process.ekc_artbew_kmep_2 (mandant_id
                                            ,art_id
                                            ,zeitraum_kz
                                            ,dat_von
                                            ,dat_bis
                                            ,betrag_kmep
                                            ,menge_artbew_sum
                                            ,betrag_kmep_einh
                                            ,wrg_id
                                            ,betrag_kmep_einh_o_fwu)
select a.mandant_id
      ,a.art_id
      ,a.zeitraum_kz
      ,a.dat_von
      ,a.dat_bis
      ,a.betrag_kmep
      ,a.menge_artbew_sum
      ,a.betrag_kmep_einh
      ,b.default_wrg as wrg_id
      ,a.betrag_kmep_einh_o_fwu
from _testit a
join dbp_data.mandant_2 b
  on a.mandant_id = b.mandant_id
;

create or replace table dbp_etl.bon_artbew_dat_1  (
  dat date not null
, unique (dat)
);

create or replace table dbp_etl.bon_artbew_tag_1 (
   mandant_id byteint not null
  ,wup_id     integer not null
  ,dat        date not null
);

create or replace table dbp_etl.bon_kopf_verkauf_1 (
  mandant_id byteint,
  wup_id integer,
  bon_dat date,
  kl_art_id integer,
  ean_kasse decimal(26,0),
  mwst_id byteint,
  wg_id smallint,
  umsatz_brutto decimal(18,4),
  menge decimal(18,3),
  aktion_id char(10) collate 'en-ci' not null,
  talon_id decimal(36,0),
  bon_id varchar(25) collate 'en-cs',
  bon_zeile integer,
  -- 01.08.2021, -bartosiewicz-
  kundenkarte_id varchar(255) collate 'en-ci',
  kundenkarte_typ_id smallint not null default 0,
  bonuskauf_id varchar(20) collate 'en-ci',
  customer_promotion_fg smallint default 0 ,
  promotion_art varchar(100) collate 'en-cs',
  bby_bewart smallint,
  bby_unique smallint,
  personal_unique smallint,
  personal smallint,
  bby_aktion char(10) collate 'en-ci' not null,
  important varchar(2) collate 'en-ci',
  loyalty_berechtigt_fg smallint default 0
);

create or replace table dbp_etl.bon_artbew_tmp_talon_1 (
 mandant_id       byteint not null
,wup_id           integer not null
,dat              date not null
,kl_art_id        integer not null
,ean_kasse        decimal (26,0)
,mwst_id          byteint
,wg_id            smallint
,aktion_id        char(10)  not null
,umsatz_brutto    decimal (18,4)
,menge            decimal (18,3)
,talon_id         decimal (36,0) not null default 0
,talon_id_aus_bon decimal (36,0) not null default 0
,bon_id           varchar(25)
   -- 01.08.2021, -bartosiewicz-
,kundenkarte_id  varchar(255) collate 'en-ci'
,kundenkarte_typ_id smallint not null default 0
,bonuskauf_id varchar(20) collate 'en-ci'
,customer_promotion_fg smallint default 0 
,promotion_art varchar(100) collate 'en-cs'
,aktion_id_obv varchar(10) collate 'en-ci'
,bon_zeile integer
,stichlogik smallint
,bby_bewart smallint
,bby_unique smallint
,personal_unique smallint
,personal smallint
,bby_aktion char(10) collate 'en-ci' not null
,important varchar(2) collate 'en-ci'
,loyalty_berechtigt_fg smallint default 0
);

-- 14.10.2019, -dbay-
--
-- an dieser stelle werden talons, die nur abgepackte ware enthalten, nicht fuer die talon-aufloesung mehr vorgesehen. in dem talon, beginnend in der regel mit dem string "99", werden sowohl der 
-- zugrundeliegende artikel_1 als auch der umsatzbruttowert festgeschrieben. das entspricht dem unten angefuegten filterkriterium, um diese von den normalen talons (beginnend mit "90") auszuschliessen.

create or replace transient table _neue_talons as (
select mandant_id
      ,wup_id
      ,talon_id
      ,sum(umsatz_brutto) as umsatz_brutto_talon
from dbp_ods.ods_talon_det_1
where artbew_fg = 0 and
      not (substr(cast(talon_id as varchar(100)),1,2) <> '90' and
      charindex(cast(talon_id as varchar(100)),cast(kl_art_id as varchar(10))) > 0 and
      charindex(cast(talon_id as varchar(100)),cast(cast(umsatz_brutto*100 as int) as varchar(100))) > 0)
group by 1,2,3
);

create or replace table dbp_etl.de_artbew_bon_promotion_track_1 (
  mandant_id            byteint,
  bon_id                varchar(25) ,
  dat_booking           date,
  kl_art_id             integer,
  bon_zeile             integer,
  bonuskauf_id          char(20) ,
  konditionsart_id      char(10) ,
  umsatz_brutto         decimal(18,4),
  umsatz_promo_brutto   decimal(18,4),
  menge_promo   decimal(18,3),
  customer_promotion_fg smallint default 0 ,
  promotion_art varchar(100) collate 'en-cs',
  lfd_nr integer,
  wup_id integer
);

insert into dbp_etl.bon_artbew_dat_1 (dat)
select x.dat
from (select dat
      from dbp_etl.bon_artbew_tgl_delta_1
      group by 1
      union
      select k.bon_dat as dat
      from (select mandant_id
                  ,wup_id
                  ,talon_id
                  ,umsatz_brutto_talon
            from _neue_talons) t
      join dbp_ods.ods_bon_verkauf_1 v
        on t.mandant_id = v.mandant_id and 
           t.wup_id = v.wup_id and 
           t.talon_id = v.talon_id and 
           v.talon_id <> 0 and 
           umsatz_brutto_talon = v.umsatz_brutto
      join dbp_ods.ods_bon_kopf_1 k
        on v.mandant_id = k.mandant_id and 
           v.wup_id = k.wup_id and 
           v.bon_id = k.bon_id 
      where (k.bon_id, k.wup_id) not in (select bon_id,wup_id from dbp_ods.ods_bon_storno_1) and 
             k.turnover_fg = 1 and 
             k.bon_dat < current_date
      group by 1) x
where x.dat is not null
;

insert into dbp_etl.bon_artbew_tag_1 (mandant_id
                                   ,wup_id
                                   ,dat)
select mandant_id
      ,wup_id
      ,dat
from dbp_etl.bon_artbew_tgl_delta_1
;

insert into dbp_etl.bon_artbew_tag_1 (mandant_id
                                   ,wup_id
                                   ,dat)
select k.mandant_id
      ,k.wup_id
      ,k.bon_dat as dat
from (select mandant_id
            ,wup_id
            ,talon_id
            ,umsatz_brutto_talon
      from _neue_talons) t
join dbp_ods.ods_bon_verkauf_1 v
  on t.mandant_id = v.mandant_id and 
     t.wup_id = v.wup_id and 
     t.talon_id = v.talon_id and 
     v.talon_id <> 0 and 
     umsatz_brutto_talon = v.umsatz_brutto
join dbp_ods.ods_bon_kopf_1 k
  on v.mandant_id = k.mandant_id and 
     v.wup_id = k.wup_id and 
     v.bon_id = k.bon_id
where (k.mandant_id,k.wup_id,dat) in (select a.mandant_id,a.wup_id,a.dat from dbp_data.artbew_1 a join dbp_etl.bon_artbew_dat_1 d on a.dat = d.dat where a.mandant_id = 1) and 
      (k.mandant_id,k.wup_id,dat) not in (select mandant_id,wup_id,dat from dbp_etl.bon_artbew_tag_1) and 
      (k.bon_id,k.wup_id) not in (select bon_id,wup_id from dbp_ods.ods_bon_storno_1) and 
       k.turnover_fg = 1 and 
       k.bon_dat < current_date
group by 1,2,3
;

insert into dbp_etl.de_artbew_bon_promotion_track_1 (mandant_id
                                                  ,bon_id
                                                  ,dat_booking
                                                  ,kl_art_id
                                                  ,bon_zeile
                                                  ,bonuskauf_id
                                                  ,konditionsart_id
                                                  ,customer_promotion_fg
                                                  ,promotion_art
                                                  ,umsatz_brutto
                                                  ,umsatz_promo_brutto
                                                  ,menge_promo
                                                  ,lfd_nr
                                                  ,wup_id)
select p.mandant_id
      ,p.bon_id
      ,p.bon_dat
      ,p.kl_art_id
      ,p.bon_zeile
      ,p.bonuskauf_id
      ,p.konditionsart_id
      ,p.customer_promotion_fg
      ,p.promotion_art
      ,sum(p.betrag_promo_brutto * (-1)) as umsatz_brutto
      ,sum(p.umsatz_promo_brutto) as umsatz_promo_brutto
      ,sum(p.menge_promo) as menge_promo
      ,promotion_lfd_nr
      ,wup_id
from dbp_ods.ods_promotion_1 p
-- 09.01.2023, -dbay
-- filter killed due to interferences regarding loyalty.
-- where coalesce(p.betrag_promo_brutto, 0) <> 0
where p.mandant_id = 1 and
      p.bon_dat between (select min(dat) from dbp_etl.bon_artbew_tag_1) and (select max(dat) from dbp_etl.bon_artbew_tag_1)
group by 1,2,3,4,5,6,7,8,9,13,14
;

create or replace table dbp_etl.de_bd_for_promotion_1 as (
select *
from dbp_ods.ods_promotion_1
where bon_dat between (select min(dat) from dbp_etl.bon_artbew_tag_1) and (select max(dat) from dbp_etl.bon_artbew_tag_1) and
      mandant_id = 1
);

create or replace volatile table _track_zbon_zbov_unique as (
select mandant_id,
       bon_id,
       bon_zeile,
       bon_dat,
       wup_id,
       1 as flag
from dbp_etl.de_bd_for_promotion_1
where (mandant_id,bon_id,bon_zeile,bon_dat,wup_id) in (select mandant_id,
                                                              bon_id,
                                                              bon_zeile,
                                                              bon_dat,
                                                              wup_id
                                                       from dbp_etl.de_bd_for_promotion_1
                                                       where konditionsart_id in ('ZBON','ZBOV') and
                                                             mandant_id = 1
                                                       group by 1,2,3,4,5) and
       konditionsart_id not in ('ZRT3','ZTAG','ZGEB') and
       mandant_id = 1
group by 1,2,3,4,5
having count(distinct konditionsart_id) = 1
);

create or replace volatile table _track_zbon_zbov as (
select mandant_id,
       bon_id,
       bon_zeile,
       bon_dat,
       wup_id,
       promotion_lfd_nr,
       1 as flag
from dbp_etl.de_bd_for_promotion_1
where konditionsart_id in ('ZBON','ZBOV') and
      mandant_id = 1
group by 1,2,3,4,5,6
);

create or replace volatile table _de_perf_01 as (
select a.mandant_id
      ,a.bon_id
      ,a.dat_booking
      ,a.bon_zeile
      ,max(a.bonuskauf_id) as bonuskauf_id
      ,a.customer_promotion_fg
      ,a.promotion_art
      ,max(coalesce(b.aktion_id,'')) as aktion_id
      ,sum(a.umsatz_brutto) as promotion_brutto
      ,case when a.dat_booking < '2022-04-01' then null when a.konditionsart_id in ('ZBON','ZBOV') then 'N' else 'Y' end as important
      ,case when a.dat_booking < '2022-04-01' then 0 else coalesce(y.flag,0) end as bby_bewart
      ,case when a.dat_booking < '2022-04-01' then 0 else coalesce(x.flag,0) end as bby_unique
from dbp_etl.de_artbew_bon_promotion_track_1 a
left join _track_zbon_zbov_unique x
  on a.mandant_id = x.mandant_id and
     a.wup_id = x.wup_id and
     a.bon_id = x.bon_id and
     a.bon_zeile = x.bon_zeile and
     a.dat_booking = x.bon_dat
left join _track_zbon_zbov y
  on a.mandant_id = y.mandant_id and
     a.wup_id = y.wup_id and
     a.bon_id = y.bon_id and
     a.bon_zeile = y.bon_zeile and
     a.lfd_nr = y.promotion_lfd_nr and
     a.dat_booking = y.bon_dat
left join dbp_data.l_bonuskauf_1 b
  on a.mandant_id = b.mandant_id and
     a.bonuskauf_id = b.bonuskauf_id and
     a.dat_booking between b.dat_von and b.dat_bis
group by 1,2,3,4,6,7,10,11,12
);

create or replace volatile table _xx1 as (
select a.*
from dbp_ods.ods_bon_verkauf_1 a
join dbp_etl.bon_artbew_tag_1 x
  on a.mandant_id = x.mandant_id and 
     a.wup_id = x.wup_id and 
     a.bon_dat = x.dat
where a.wg_id <> 822
);

insert into dbp_etl.bon_kopf_verkauf_1 (mandant_id
                                     ,wup_id
                                     ,bon_dat
                                     ,kl_art_id
                                     ,ean_kasse
                                     ,mwst_id
                                     ,wg_id
                                     ,umsatz_brutto
                                     ,menge
                                     ,aktion_id
                                     ,talon_id
                                     ,bon_id
                                     ,bon_zeile
                                     ,kundenkarte_id
                                     ,kundenkarte_typ_id
                                     ,bonuskauf_id
                                     ,customer_promotion_fg
                                     ,promotion_art
                                     ,bby_bewart
                                     ,bby_unique
                                     ,bby_aktion
                                     ,important
                                     ,loyalty_berechtigt_fg)
select k.mandant_id
      ,k.wup_id
      ,k.bon_dat
      ,v.kl_art_id
      ,coalesce(case
                  when trim(t.kassensystem_name) <> 'KPOS'
                  then v.ean_kasse
                  else case
                         when trim(v.barcode_string) = '' 
                         then v.ean_kasse
                         when length(v.barcode_string) > 26
                         then -9999
                         when try_to_number(v.barcode_string) is not null
                         then cast(to_number(v.barcode_string) as decimal(26,0))
                         else v.ean_kasse
                       end
                end,v.ean_kasse) as ean_kasse
      ,v.mwst_id
      ,v.wg_id
      ,v.umsatz_brutto
      ,v.menge
      ,coalesce(case
                  when trim(t.kassensystem_name) = 'KPOS' and
                       p.aktion_id <> ''
                  then p.aktion_id
                  when trim(t.kassensystem_name) = 'KPOS' and
                       p.aktion_id = ''
                  then v.aktion_id
                  else v.aktion_id
                end,v.aktion_id) as aktion_id
      ,v.talon_id
      ,k.bon_id
      ,v.bon_zeile
      ,k.kundenkarte_id
      ,k.kundenkarte_typ_id
      ,p.bonuskauf_id
      ,p.customer_promotion_fg
      ,p.promotion_art
      ,p.bby_bewart
      ,p.bby_unique
      ,v.aktion_id as bby_aktion
      ,p.important
      ,k.loyalty_berechtigt_fg
from dbp_ods.ods_bon_kopf_1 k

join dbp_etl.bon_artbew_tag_1 x
  on k.mandant_id = x.mandant_id and 
     k.wup_id = x.wup_id and 
     k.bon_dat = x.dat

join dbp_ods.ods_bon_transaction_1 t
  on k.mandant_id = t.mandant_id and 
     k.bon_id = t.bon_id and 
     k.wup_id = t.wup_id and 
     k.bon_dat = t.bon_dat

join _xx1 v
  on k.mandant_id = v.mandant_id and 
     k.wup_id = v.wup_id and 
     k.bon_id = v.bon_id and 
     k.bon_dat = v.bon_dat

left join _de_perf_01 p
  on v.mandant_id = p.mandant_id and
     v.bon_id = p.bon_id and
     v.bon_dat = p.dat_booking and
     v.bon_zeile = p.bon_zeile

where (k.bon_id, k.wup_id) not in (select bon_id,wup_id from dbp_ods.ods_bon_storno_1) and
       k.turnover_fg = 1 and
       v.wg_id not in (822)
;

-- 14.08.2017, -dbay-
--
-- Wichtiger Bereinigungsschritt, um etwaige Zeilenstornos in den Warengruppenerfassartikeln, die zu einer Vervielfachung in den ARTBEW_1-Zahlen fuehren, zu eliminieren! Hierzu wird eine_1 View
-- angesprochen, in der bis zu 10 Stornos (!) pro Bon getrackt werden. In der gesamten Historie aller Bon-Daten lag die Hoechstgrenze bei 7 Auspraegungen.

delete from dbp_etl_process.artbew_zeilen_stornos_1;
insert into dbp_etl_process.artbew_zeilen_stornos_1
select mandant_id
      ,wup_id
      ,bon_dat
      ,kl_art_id
      ,ean_kasse
      ,mwst_id
      ,wg_id
      ,umsatz_brutto
      ,menge
      ,aktion_id
      ,talon_id
      ,bon_id
      ,bon_zeile
      ,kundenkarte_id
      ,kundenkarte_typ_id
      ,bonuskauf_id
      ,customer_promotion_fg
      ,promotion_art
      ,bby_bewart
      ,bby_unique
      ,bby_aktion
      ,important
from dbp_etl.bon_kopf_verkauf_1
;

delete from dbp_etl.bon_kopf_verkauf_1
where (mandant_id,wup_id,bon_dat,bon_id,kl_art_id,bon_zeile,talon_id) in (select mandant_id,wup_id,bon_dat,bon_id,kl_art_id,bon_zeile,talon_id from dbp_etl_process.v_ais_clean_row_cancellation_1)
;

create or replace volatile table _retoure as (
select k.mandant_id
      ,k.wup_id
      ,k.bon_dat as dat
      ,0 as talon_art_korrekt
      ,v.kl_art_id
      ,coalesce(case
                  when trim(t.kassensystem_name) <> 'KPOS'
                  then v.ean_kasse
                  else case
                         when trim(v.barcode_string) = '' 
                         then v.ean_kasse
                         when length(v.barcode_string) > 26
                         then -9999
                         else cast(to_number(v.barcode_string) as decimal(26,0))
                       end
                end,v.ean_kasse) as ean_kasse
      ,v.mwst_id
      ,v.wg_id
      ,v.umsatz_brutto
      ,v.menge * menge_fg as menge
      ,v.aktion_id
      ,0 as talon_id
      ,0 as talon_id_aus_bon
      ,k.bon_id
      ,k.kundenkarte_id
      ,k.kundenkarte_typ_id
      ,z.bonuskauf_id
      ,z.customer_promotion_fg
      ,z.promotion_art
      ,v.aktion_id as aktion_id_obv  
      ,v.bon_zeile
      ,z.bby_bewart
      ,z.bby_unique
      ,v.aktion_id as bby_aktion
      ,z.important
      ,k.loyalty_berechtigt_fg
from dbp_ods.ods_bon_kopf_1 k
join dbp_ods.ods_bon_transaction_1 t
  on k.mandant_id = t.mandant_id and 
     k.bon_id = t.bon_id and 
     k.wup_id = t.wup_id and 
     k.bon_dat = t.bon_dat
join dbp_ods.ods_bon_retoure_1 v
  on k.mandant_id = v.mandant_id and 
     k.wup_id = v.wup_id and 
     k.bon_id = v.bon_id and 
     k.bon_dat = v.bon_dat and 
     coalesce(v.talon_id, 0) = 0
join dbp_etl.bon_artbew_tag_1 p
  on k.mandant_id = p.mandant_id and 
     k.wup_id = p.wup_id and 
     k.bon_dat = p.dat
left join (select z.mandant_id
                 ,z.wup_id
                 ,z.bon_id
                 ,z.bon_dat
                 ,z.kl_art_id
                 ,z.bon_zeile
                 ,z.bonuskauf_id
                 ,z.customer_promotion_fg
                 ,z.promotion_art
                 ,case when z.bon_dat < '2022-04-01' then null when z.konditionsart_id in ('ZBON','ZBOV') then 'N' else 'Y' end as important
                 ,case when z.bon_dat < '2022-04-01' then 0 else coalesce(y.flag,0) end as bby_bewart
                 ,case when z.bon_dat < '2022-04-01' then 0 else coalesce(x.flag,0) end as bby_unique
           from dbp_etl.de_bd_for_promotion_1 z
           left join _track_zbon_zbov_unique x
             on z.mandant_id = x.mandant_id and
                z.wup_id = x.wup_id and
                z.bon_id = x.bon_id and
                z.bon_zeile = x.bon_zeile and
                z.bon_dat = x.bon_dat
           left join _track_zbon_zbov y
             on z.mandant_id = y.mandant_id and
                z.wup_id = y.wup_id and
                z.bon_id = y.bon_id and
                z.bon_zeile = y.bon_zeile and
                z.promotion_lfd_nr = y.promotion_lfd_nr and
                z.bon_dat = y.bon_dat
           group by 1,2,3,4,5,6,7,8,9,10,11,12) z
  on k.mandant_id = z.mandant_id and 
     k.wup_id  = z.wup_id and 
     k.bon_id  = z.bon_id and 
     k.bon_dat = z.bon_dat and 
     v.kl_art_id = z.kl_art_id and 
     v.bon_zeile = z.bon_zeile
where (k.bon_id, k.bon_dat) not in (select bon_id,bon_dat from dbp_ods.ods_bon_storno_1) and 
       k.turnover_fg = 1 and
       v.wg_id not in (822)
);

create or replace table dbp_etl.retoure_x_1 as (
select *
from _retoure
);

insert into dbp_etl.bon_artbew_tmp_talon_1 (mandant_id
                                         ,wup_id
                                         ,dat
                                         ,kl_art_id
                                         ,ean_kasse
                                         ,mwst_id
                                         ,wg_id
                                         ,aktion_id
                                         ,umsatz_brutto
                                         ,menge
                                         ,talon_id
                                         ,talon_id_aus_bon
                                         ,bon_id
                                         ,kundenkarte_id
                                         ,kundenkarte_typ_id
                                         ,bonuskauf_id
                                         ,customer_promotion_fg
                                         ,promotion_art 
                                         ,aktion_id_obv  
                                         ,bon_zeile
                                         ,bby_bewart
                                         ,bby_unique
                                         ,bby_aktion
                                         ,important
                                         ,stichlogik
                                         ,loyalty_berechtigt_fg)
select mandant_id
      ,wup_id
      ,dat
      ,kl_art_id
      ,ean_kasse
      ,mwst_id
      ,wg_id
      ,aktion_id
      ,sum(umsatz_brutto) as umsatz_brutto
      ,sum(menge) as menge
      ,talon_id
      ,talon_id_aus_bon
      ,max(bon_id) as bon_id
      ,kundenkarte_id
      ,kundenkarte_typ_id
      ,max(bonuskauf_id) as bonuskauf_id
      ,customer_promotion_fg
      ,promotion_art 
      ,aktion_id_obv 
      ,bon_zeile
      ,bby_bewart
      ,bby_unique
      ,bby_aktion
      ,important
      ,stichlogik
      ,loyalty_berechtigt_fg
from (select mandant_id
            ,wup_id
            ,dat
            ,kl_art_id
            ,ean_kasse
            ,mwst_id
            ,wg_id
            ,aktion_id
            ,umsatz_brutto
            ,menge
            ,talon_id
            ,talon_id_aus_bon
            ,bon_id
            ,kundenkarte_id
            ,kundenkarte_typ_id
            ,bonuskauf_id
            ,customer_promotion_fg
            ,promotion_art 
            ,aktion_id_obv 
            ,bon_zeile
            ,bby_bewart
            ,bby_unique
            ,bby_aktion
            ,important
            ,stichlogik
            ,loyalty_berechtigt_fg
            ,row_number() over(partition by p.mandant_id,p.bon_id,p.dat,p.wup_id,p.bon_zeile,p.kl_art_id,p.ean_kasse order by p.stichlogik,p.bonuskauf_id desc) as rk
      from (select mandant_id
                  ,wup_id
                  ,dat
                  ,kl_art_id
                  ,ean_kasse
                  ,mwst_id
                  ,wg_id
                  ,aktion_id
                  ,sum(umsatz_brutto) as umsatz_brutto
                  ,sum(menge) as menge
                  ,talon_id
                  ,talon_id_aus_bon
                  ,bon_id
                  ,kundenkarte_id
                  ,kundenkarte_typ_id
                  ,max(bonuskauf_id) as bonuskauf_id
                  ,customer_promotion_fg
                  ,promotion_art
                  ,aktion_id_obv
                  ,bon_zeile
                  ,bby_bewart
                  ,bby_unique
                  ,bby_aktion
                  ,important
                  ,case when promotion_art = 'PERSONAL_SMP' then 99 when important = 'N' and bby_unique = 0 then 9 when promotion_art='PERSONAL' then 1 else case when promotion_art='CUSTOMER' then 2 else case when promotion_art='COMMON' then 3 else 4 end end end as stichlogik
                  ,loyalty_berechtigt_fg
            from (select x.mandant_id
                        ,x.wup_id
                        ,x.bon_dat as dat
                        ,case 
                           when a.kl_art_id is not null and 
                                t.mandant_id is not null
                           then 1
                           else 0
                         end as talon_art_korrekt
                        ,case 
                           when talon_art_korrekt = 1
                           then t.kl_art_id
                           else coalesce(tx.kl_art_id,x.kl_art_id)
                         end as kl_art_id
                        ,case 
                           when talon_art_korrekt = 1
                           then 0
                           else x.ean_kasse
                         end as ean_kasse
                        ,case 
                           when talon_art_korrekt = 1
                           then mw.mwst_id
                           else coalesce(tw.mwst_id,x.mwst_id)
                         end as mwst_id
                        ,case 
                           when talon_art_korrekt = 1
                           then t.wg_id
                           else coalesce(tx.wg_id,x.wg_id)
                         end as wg_id
                        ,coalesce(t.umsatz_brutto,(tx.umsatz_brutto/nullifzero(ts.umsatz_brutto_talon))*x.umsatz_brutto,x.umsatz_brutto + coalesce(c.coupon_betrag, 0.0000)) as umsatz_brutto
                        ,coalesce(case when t.menge = 0 then 1 else t.menge end,case when tx.menge = 0 then 1 else tx.menge end,x.menge) as menge
                        ,case 
                           when talon_art_korrekt = 1
                           then t.aktion_id
                           else coalesce(tx.aktion_id,x.aktion_id)
                         end as aktion_id
                        ,coalesce(t.talon_id,tx.talon_id,0) as talon_id
                        ,case 
                           when t.talon_id is null
                           then coalesce(x.talon_id, 0)
                           else 0
                         end as talon_id_aus_bon
                        ,x.bon_id
                        ,x.kundenkarte_id
                        ,x.kundenkarte_typ_id
                        ,x.bonuskauf_id
                        ,x.customer_promotion_fg
                        ,x.promotion_art
                        ,x.aktion_id as aktion_id_obv
                        ,x.bon_zeile
                        ,x.bby_bewart
                        ,x.bby_unique
                        ,x.bby_aktion
                        ,x.important
                        ,x.loyalty_berechtigt_fg
                  from dbp_etl.bon_kopf_verkauf_1 x
                  left join (select mandant_id
                                   ,wup_id
                                   ,talon_id
                                   ,sum(umsatz_brutto) as umsatz_brutto_talon
                             from dbp_ods.ods_talon_det_1
                             where turnover_fg = 1
                             group by 1,2,3) ts
                    on x.mandant_id = ts.mandant_id and 
                       x.wup_id = ts.wup_id and 
                       x.talon_id = ts.talon_id
                  left join dbp_ods.ods_talon_det_1 t
                    on x.mandant_id = t.mandant_id and 
                       x.wup_id = t.wup_id and
                       x.talon_id = t.talon_id and 
                       t.turnover_fg = 1 and 
                       ts.umsatz_brutto_talon = x.umsatz_brutto
                  left join dbp_ods.ods_talon_det_1 tx
                    on x.mandant_id = tx.mandant_id and 
                       x.wup_id = tx.wup_id and
                       x.talon_id = tx.talon_id and 
                       tx.turnover_fg = 1 and 
                       ts.umsatz_brutto_talon <> x.umsatz_brutto
                  left join (select mandant_id
                                   ,kl_art_id
                                   ,mwst_id
                             from dbp_data.art_1
                             where kl_art_id <> 0
                             qualify row_number() over (partition by mandant_id,kl_art_id order by art_id desc) = 1) a
                    on t.kl_art_id = a.kl_art_id and 
                       t.mandant_id = a.mandant_id
                  left join (select mandant_id
                                   ,kl_art_id
                                   ,mwst_id
                             from dbp_data.art_1
                             where kl_art_id <> 0
                             qualify row_number() over (partition by mandant_id,kl_art_id order by art_id desc) = 1) ax
                    on tx.kl_art_id = ax.kl_art_id and 
                       tx.mandant_id = ax.mandant_id
                  left join dbp_data.mwst_per_1 mw
                    on mw.mandant_id = t.mandant_id and 
                       x.bon_dat between mw.dat_von and mw.dat_bis and 
                       coalesce(t.mwst, 0) <> 0 and 
                       t.mwst = mw.mwst and 
                       mw.mwst_id <> 4
                  left join dbp_data.mwst_per_1 tw
                    on mw.mandant_id = tx.mandant_id and 
                       x.bon_dat between mw.dat_von and mw.dat_bis and 
                       coalesce(tx.mwst, 0) <> 0 and 
                       tx.mwst = mw.mwst and 
                       mw.mwst_id <> 4
                  left join (select mandant_id
                                   ,wup_id
                                   ,bon_id
                                   ,bon_zeile
                                   ,sum(coupon_betrag) as coupon_betrag
                             from dbp_ods.ods_coupon_1
                             where coupon_kz = 1
                             group by 1,2,3,4) c
                    on x.mandant_id = c.mandant_id and 
                       x.wup_id = c.wup_id and 
                       x.bon_id = c.bon_id and 
                       x.bon_zeile = c.bon_zeile and 
                       x.talon_id = 0
                  union all
                  select *
                  from _retoure) a
                  group by mandant_id,wup_id,dat,kl_art_id,ean_kasse,mwst_id,wg_id,aktion_id,talon_id,talon_id_aus_bon,kundenkarte_id,kundenkarte_typ_id,customer_promotion_fg,promotion_art
                          ,aktion_id_obv,bon_zeile,stichlogik,bby_bewart,bby_unique,bby_aktion,important,bon_id,loyalty_berechtigt_fg) p) tmp
where tmp.rk = 1
group by mandant_id,wup_id,dat,kl_art_id,ean_kasse,mwst_id,wg_id,aktion_id,talon_id,talon_id_aus_bon,kundenkarte_id,kundenkarte_typ_id,customer_promotion_fg
        ,promotion_art,aktion_id_obv,bon_zeile,bby_bewart,bby_unique,bby_aktion,important,stichlogik,loyalty_berechtigt_fg
;

-- WG_ID = 822

create or replace volatile table _track_zbon_zbov_unique_personal as (
select a.mandant_id,
       a.bon_id,
       a.bon_zeile,
       a.bon_dat,
       a.wup_id,
       a.promotion_art,
       1 as flag,
       max(b.anz) as anz,
       max(b.bonrabatt) as bonrabatt
from dbp_etl.de_bd_for_promotion_1 a
join (select mandant_id,
             bon_id,
             bon_zeile,
             bon_dat,
             wup_id,
             count(distinct promotion_art) as anz,
             max(case when konditionsart_id in ('ZBON','ZBOV') then 1 else 0 end) as bonrabatt
      from dbp_etl.de_bd_for_promotion_1
      group by 1,2,3,4,5) b
  on a.mandant_id = b.mandant_id and
     a.bon_id = b.bon_id and
     a.bon_zeile = b.bon_zeile and
     a.bon_dat = b.bon_dat and
     a.wup_id = b.wup_id
where (a.mandant_id,a.bon_id,a.bon_zeile,a.bon_dat,a.wup_id) in (select mandant_id,
                                                                        bon_id,
                                                                        bon_zeile,
                                                                        bon_dat,
                                                                        wup_id
                                                                 from dbp_etl.de_bd_for_promotion_1
                                                                 where promotion_art = 'PERSONAL'
                                                                 group by 1,2,3,4,5) and
       a.konditionsart_id not in ('ZRT3','ZTAG','ZGEB')
group by 1,2,3,4,5,6
having count(distinct promotion_art) = 1 and
       max(b.bonrabatt) = 0 and
       max(b.anz) = 1
);

create or replace volatile table _track_zbon_zbov_personal as (
select mandant_id,
       bon_id,
       bon_zeile,
       bon_dat,
       wup_id,
       1 as flag
from dbp_etl.de_bd_for_promotion_1
where (mandant_id,bon_id,bon_zeile,bon_dat,wup_id) in (select mandant_id,
                                                              bon_id,
                                                              bon_zeile,
                                                              bon_dat,
                                                              wup_id
                                                       from dbp_etl.de_bd_for_promotion_1
                                                       where promotion_art = 'PERSONAL'
                                                       group by 1,2,3,4,5) and
       konditionsart_id not in ('ZRT3','ZTAG','ZGEB')
group by 1,2,3,4,5
);

create or replace volatile table _de_perf_01 as (
select a.mandant_id
      ,a.bon_id
      ,a.dat_booking
      ,a.bon_zeile
      ,max(a.bonuskauf_id) as bonuskauf_id
      ,a.customer_promotion_fg
      ,a.promotion_art
      ,max(coalesce(b.aktion_id,'')) as aktion_id
      ,sum(a.umsatz_brutto) as promotion_brutto
      ,case when a.dat_booking < '2022-04-01' then null when a.konditionsart_id in ('ZBON','ZBOV') then 'N' else 'Y' end as important
      ,case when a.dat_booking < '2022-04-01' then 0 else coalesce(y.flag,0) end as bby_bewart
      ,case when a.dat_booking < '2022-04-01' then 0 else coalesce(x.flag,0) end as bby_unique
      ,case when a.dat_booking < '2022-04-01' then 0 else coalesce(w.flag,0) end as personal_unique
      ,case when a.dat_booking < '2022-04-01' then 0 else coalesce(u.flag,0) end as personal
from dbp_etl.de_artbew_bon_promotion_track_1 a
left join _track_zbon_zbov_unique x
  on a.mandant_id = x.mandant_id and
     a.wup_id = x.wup_id and
     a.bon_id = x.bon_id and
     a.bon_zeile = x.bon_zeile and
     a.dat_booking = x.bon_dat
left join _track_zbon_zbov y
  on a.mandant_id = y.mandant_id and
     a.wup_id = y.wup_id and
     a.bon_id = y.bon_id and
     a.bon_zeile = y.bon_zeile and
     a.lfd_nr = y.promotion_lfd_nr and
     a.dat_booking = y.bon_dat
left join _track_zbon_zbov_unique_personal w
  on a.mandant_id = w.mandant_id and
     a.wup_id = w.wup_id and
     a.bon_id = w.bon_id and
     a.bon_zeile = w.bon_zeile and
     a.dat_booking = w.bon_dat
left join _track_zbon_zbov_personal u
  on a.mandant_id = u.mandant_id and
     a.wup_id = u.wup_id and
     a.bon_id = u.bon_id and
     a.bon_zeile = u.bon_zeile and
     a.dat_booking = u.bon_dat
left join dbp_data.l_bonuskauf_1 b
  on a.mandant_id = b.mandant_id and
     a.bonuskauf_id = b.bonuskauf_id and
     a.dat_booking between b.dat_von and b.dat_bis
group by 1,2,3,4,6,7,10,11,12,13,14
);

insert into dbp_etl.bon_kopf_verkauf_1 (mandant_id
                                     ,wup_id
                                     ,bon_dat
                                     ,kl_art_id
                                     ,ean_kasse
                                     ,mwst_id
                                     ,wg_id
                                     ,umsatz_brutto
                                     ,menge
                                     ,aktion_id
                                     ,talon_id
                                     ,bon_id
                                     ,bon_zeile
                                     ,kundenkarte_id
                                     ,kundenkarte_typ_id
                                     ,bonuskauf_id
                                     ,customer_promotion_fg
                                     ,promotion_art
                                     ,bby_bewart
                                     ,bby_unique
                                     ,bby_aktion
                                     ,important
                                     ,personal_unique
                                     ,personal
                                     ,loyalty_berechtigt_fg)
select k.mandant_id
      ,k.wup_id
      ,k.bon_dat
      ,v.kl_art_id
      ,coalesce(case
                  when trim(t.kassensystem_name) <> 'KPOS'
                  then v.ean_kasse
                  else case
                         when trim(v.barcode_string) = '' 
                         then v.ean_kasse
                         when length(v.barcode_string) > 26
                         then -9999
                         when try_to_number(v.barcode_string) is not null
                         then cast(to_number(v.barcode_string) as decimal(26,0))
                         else v.ean_kasse
                       end
                end,v.ean_kasse) as ean_kasse
      ,v.mwst_id
      ,v.wg_id
      ,v.umsatz_brutto
      ,v.menge
      ,coalesce(case
                  when trim(t.kassensystem_name) = 'KPOS' and
                       p.aktion_id <> ''
                  then p.aktion_id
                  when trim(t.kassensystem_name) = 'KPOS' and
                       p.aktion_id = ''
                  then v.aktion_id
                  else v.aktion_id
                end,v.aktion_id) as aktion_id
      ,v.talon_id
      ,k.bon_id
      ,v.bon_zeile
      ,k.kundenkarte_id
      ,k.kundenkarte_typ_id
      ,p.bonuskauf_id
      ,p.customer_promotion_fg
      ,p.promotion_art
      ,p.bby_bewart
      ,p.bby_unique
      ,v.aktion_id as bby_aktion
      ,case when p.personal_unique = 1 and coalesce(v.aktion_id,'') = '' then 'B' when p.personal = 1 then 'C' else p.important end as important
      ,p.personal_unique
      ,p.personal
      ,k.loyalty_berechtigt_fg
from dbp_ods.ods_bon_kopf_1 k

join dbp_etl.bon_artbew_tag_1 x
  on k.mandant_id = x.mandant_id and 
     k.wup_id = x.wup_id and 
     k.bon_dat = x.dat

join dbp_ods.ods_bon_transaction_1 t
  on k.mandant_id = t.mandant_id and 
     k.bon_id = t.bon_id and 
     k.wup_id = t.wup_id and 
     k.bon_dat = t.bon_dat

join dbp_ods.ods_bon_verkauf_1 v
  on k.mandant_id = v.mandant_id and 
     k.wup_id = v.wup_id and 
     k.bon_id = v.bon_id and 
     k.bon_dat = v.bon_dat

left join _de_perf_01 p
  on v.mandant_id = p.mandant_id and
     v.bon_id = p.bon_id and
     v.bon_dat = p.dat_booking and
     v.bon_zeile = p.bon_zeile

where (k.bon_id, k.wup_id) not in (select bon_id,wup_id from dbp_ods.ods_bon_storno_1) and
       k.turnover_fg = 1 and
       v.wg_id in (822)
;

create or replace volatile table _retoure as (
select k.mandant_id
      ,k.wup_id
      ,k.bon_dat as dat
      ,0 as talon_art_korrekt
      ,v.kl_art_id
      ,coalesce(case
                  when trim(t.kassensystem_name) <> 'KPOS'
                  then v.ean_kasse
                  else case
                         when trim(v.barcode_string) = '' 
                         then v.ean_kasse
                         when length(v.barcode_string) > 26
                         then -9999
                         else cast(to_number(v.barcode_string) as decimal(26,0))
                       end
                end,v.ean_kasse) as ean_kasse
      ,v.mwst_id
      ,v.wg_id
      ,v.umsatz_brutto
      ,v.menge * menge_fg as menge
      ,v.aktion_id
      ,0 as talon_id
      ,0 as talon_id_aus_bon
      ,k.bon_id
      ,k.kundenkarte_id
      ,k.kundenkarte_typ_id
      ,z.bonuskauf_id
      ,z.customer_promotion_fg
      ,z.promotion_art
      ,v.aktion_id as aktion_id_obv  
      ,v.bon_zeile
      ,z.bby_bewart
      ,z.bby_unique
      ,v.aktion_id as bby_aktion
      ,case when z.personal_unique = 1 and coalesce(v.aktion_id,'') = '' then 'B' when z.personal = 1 then 'C' else z.important end as important
      ,z.personal_unique
      ,z.personal
      ,k.loyalty_berechtigt_fg
from dbp_ods.ods_bon_kopf_1 k
join dbp_ods.ods_bon_transaction_1 t
  on k.mandant_id = t.mandant_id and 
     k.bon_id = t.bon_id and 
     k.wup_id = t.wup_id and 
     k.bon_dat = t.bon_dat
join dbp_ods.ods_bon_retoure_1 v
  on k.mandant_id = v.mandant_id and 
     k.wup_id = v.wup_id and 
     k.bon_id = v.bon_id and 
     k.bon_dat = v.bon_dat and 
     coalesce(v.talon_id, 0) = 0
join dbp_etl.bon_artbew_tag_1 p
  on k.mandant_id = p.mandant_id and 
     k.wup_id = p.wup_id and 
     k.bon_dat = p.dat
left join (select z.mandant_id
                 ,z.wup_id
                 ,z.bon_id
                 ,z.bon_dat
                 ,z.kl_art_id
                 ,z.bon_zeile
                 ,z.bonuskauf_id
                 ,z.customer_promotion_fg
                 ,z.promotion_art
                 ,case when z.bon_dat < '2022-04-01' then null when z.konditionsart_id in ('ZBON','ZBOV') then 'N' else 'Y' end as important
                 ,case when z.bon_dat < '2022-04-01' then 0 else coalesce(y.flag,0) end as bby_bewart
                 ,case when z.bon_dat < '2022-04-01' then 0 else coalesce(x.flag,0) end as bby_unique
                 ,case when z.bon_dat < '2022-04-01' then 0 else coalesce(w.flag,0) end as personal_unique
                 ,case when z.bon_dat < '2022-04-01' then 0 else coalesce(u.flag,0) end as personal
           from dbp_etl.de_bd_for_promotion_1 z
           left join _track_zbon_zbov_unique x
             on z.mandant_id = x.mandant_id and
                z.wup_id = x.wup_id and
                z.bon_id = x.bon_id and
                z.bon_zeile = x.bon_zeile and
                z.bon_dat = x.bon_dat
           left join _track_zbon_zbov y
             on z.mandant_id = y.mandant_id and
                z.wup_id = y.wup_id and
                z.bon_id = y.bon_id and
                z.bon_zeile = y.bon_zeile and
                z.promotion_lfd_nr = y.promotion_lfd_nr and
                z.bon_dat = y.bon_dat
           left join _track_zbon_zbov_unique_personal w
             on z.mandant_id = w.mandant_id and
                z.wup_id = w.wup_id and
                z.bon_id = w.bon_id and
                z.bon_zeile = w.bon_zeile and
                z.bon_dat = w.bon_dat
           left join _track_zbon_zbov_personal u
             on z.mandant_id = u.mandant_id and
                z.wup_id = u.wup_id and
                z.bon_id = u.bon_id and
                z.bon_zeile = u.bon_zeile and
                z.bon_dat = u.bon_dat
           group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14) z
  on k.mandant_id = z.mandant_id and 
     k.wup_id  = z.wup_id and 
     k.bon_id  = z.bon_id and 
     k.bon_dat = z.bon_dat and 
     v.kl_art_id = z.kl_art_id and 
     v.bon_zeile = z.bon_zeile
where (k.bon_id, k.bon_dat) not in (select bon_id,bon_dat from dbp_ods.ods_bon_storno_1) and 
       k.turnover_fg = 1 and
       v.wg_id in (822)
);

insert into dbp_etl.bon_artbew_tmp_talon_1 (mandant_id
                                         ,wup_id
                                         ,dat
                                         ,kl_art_id
                                         ,ean_kasse
                                         ,mwst_id
                                         ,wg_id
                                         ,aktion_id
                                         ,umsatz_brutto
                                         ,menge
                                         ,talon_id
                                         ,talon_id_aus_bon
                                         ,bon_id
                                         ,kundenkarte_id
                                         ,kundenkarte_typ_id
                                         ,bonuskauf_id
                                         ,customer_promotion_fg
                                         ,promotion_art 
                                         ,aktion_id_obv  
                                         ,bon_zeile
                                         ,bby_bewart
                                         ,bby_unique
                                         ,bby_aktion
                                         ,important
                                         ,stichlogik
                                         ,loyalty_berechtigt_fg)
select mandant_id
      ,wup_id
      ,dat
      ,kl_art_id
      ,ean_kasse
      ,mwst_id
      ,wg_id
      ,aktion_id
      ,sum(umsatz_brutto) as umsatz_brutto
      ,sum(menge) as menge
      ,talon_id
      ,talon_id_aus_bon
      ,max(bon_id) as bon_id
      ,kundenkarte_id
      ,kundenkarte_typ_id
      ,max(bonuskauf_id) as bonuskauf_id
      ,customer_promotion_fg
      ,promotion_art 
      ,aktion_id_obv 
      ,bon_zeile
      ,bby_bewart
      ,bby_unique
      ,bby_aktion
      ,important
      ,stichlogik
      ,loyalty_berechtigt_fg
from (select mandant_id
            ,wup_id
            ,dat
            ,kl_art_id
            ,ean_kasse
            ,mwst_id
            ,wg_id
            ,aktion_id
            ,umsatz_brutto
            ,menge
            ,talon_id
            ,talon_id_aus_bon
            ,bon_id
            ,kundenkarte_id
            ,kundenkarte_typ_id
            ,bonuskauf_id
            ,customer_promotion_fg
            ,promotion_art 
            ,aktion_id_obv 
            ,bon_zeile
            ,bby_bewart
            ,bby_unique
            ,bby_aktion
            ,important
            ,stichlogik
            ,loyalty_berechtigt_fg
            ,row_number() over(partition by p.mandant_id,p.bon_id,p.dat,p.wup_id,p.bon_zeile,p.kl_art_id,p.ean_kasse order by p.stichlogik,p.bonuskauf_id desc) as rk
      from (select mandant_id
                  ,wup_id
                  ,dat
                  ,kl_art_id
                  ,ean_kasse
                  ,mwst_id
                  ,wg_id
                  ,aktion_id
                  ,sum(umsatz_brutto) as umsatz_brutto
                  ,sum(menge) as menge
                  ,talon_id
                  ,talon_id_aus_bon
                  ,bon_id
                  ,kundenkarte_id
                  ,kundenkarte_typ_id
                  ,max(bonuskauf_id) as bonuskauf_id
                  ,customer_promotion_fg
                  ,promotion_art
                  ,aktion_id_obv
                  ,bon_zeile
                  ,bby_bewart
                  ,bby_unique
                  ,bby_aktion
                  ,important
                  ,case when personal = 1 and wg_id = 822 then 100 when promotion_art = 'PERSONAL_SMP' then 99 when important = 'N' and bby_unique = 0 then 9 when promotion_art='PERSONAL' then 1 else case when promotion_art='CUSTOMER' then 2 else case when promotion_art='COMMON' then 3 else 4 end end end as stichlogik 
                  ,loyalty_berechtigt_fg
            from (select x.mandant_id
                        ,x.wup_id
                        ,x.bon_dat as dat
                        ,case 
                           when a.kl_art_id is not null and 
                                t.mandant_id is not null
                           then 1
                           else 0
                         end as talon_art_korrekt
                        ,case 
                           when talon_art_korrekt = 1
                           then t.kl_art_id
                           else coalesce(tx.kl_art_id,x.kl_art_id)
                         end as kl_art_id
                        ,case 
                           when talon_art_korrekt = 1
                           then 0
                           else x.ean_kasse
                         end as ean_kasse
                        ,case 
                           when talon_art_korrekt = 1
                           then mw.mwst_id
                           else coalesce(tw.mwst_id,x.mwst_id)
                         end as mwst_id
                        ,case 
                           when talon_art_korrekt = 1
                           then t.wg_id
                           else coalesce(tx.wg_id,x.wg_id)
                         end as wg_id
                        ,coalesce(t.umsatz_brutto,(tx.umsatz_brutto/nullifzero(ts.umsatz_brutto_talon))*x.umsatz_brutto,x.umsatz_brutto + coalesce(c.coupon_betrag, 0.0000)) as umsatz_brutto
                        ,coalesce(case when t.menge = 0 then 1 else t.menge end,case when tx.menge = 0 then 1 else tx.menge end,x.menge) as menge
                        ,case 
                           when talon_art_korrekt = 1
                           then t.aktion_id
                           else coalesce(tx.aktion_id,x.aktion_id)
                         end as aktion_id
                        ,coalesce(t.talon_id,tx.talon_id,0) as talon_id
                        ,case 
                           when t.talon_id is null
                           then coalesce(x.talon_id, 0)
                           else 0
                         end as talon_id_aus_bon
                        ,x.bon_id
                        ,x.kundenkarte_id
                        ,x.kundenkarte_typ_id
                        ,x.bonuskauf_id
                        ,x.customer_promotion_fg
                        ,x.promotion_art
                        ,x.aktion_id as aktion_id_obv
                        ,x.bon_zeile
                        ,x.bby_bewart
                        ,x.bby_unique
                        ,x.bby_aktion
                        ,x.important
                        ,x.personal_unique
                        ,x.personal
                        ,x.loyalty_berechtigt_fg
                  from  (select *
                         from dbp_etl.bon_kopf_verkauf_1
                         where wg_id = 822) x
                  left join (select mandant_id
                                   ,wup_id
                                   ,talon_id
                                   ,sum(umsatz_brutto) as umsatz_brutto_talon
                             from dbp_ods.ods_talon_det_1
                             where turnover_fg = 1
                             group by 1,2,3) ts
                    on x.mandant_id = ts.mandant_id and 
                       x.wup_id = ts.wup_id and 
                       x.talon_id = ts.talon_id
                  left join dbp_ods.ods_talon_det_1 t
                    on x.mandant_id = t.mandant_id and 
                       x.wup_id = t.wup_id and
                       x.talon_id = t.talon_id and 
                       t.turnover_fg = 1 and 
                       ts.umsatz_brutto_talon = x.umsatz_brutto
                  left join dbp_ods.ods_talon_det_1 tx
                    on x.mandant_id = tx.mandant_id and 
                       x.wup_id = tx.wup_id and
                       x.talon_id = tx.talon_id and 
                       tx.turnover_fg = 1 and 
                       ts.umsatz_brutto_talon <> x.umsatz_brutto
                  left join (select mandant_id
                                   ,kl_art_id
                                   ,mwst_id
                             from dbp_data.art_1
                             where kl_art_id <> 0
                             qualify row_number() over (partition by mandant_id,kl_art_id order by art_id desc) = 1) a
                    on t.kl_art_id = a.kl_art_id and 
                       t.mandant_id = a.mandant_id
                  left join (select mandant_id
                                   ,kl_art_id
                                   ,mwst_id
                             from dbp_data.art_1
                             where kl_art_id <> 0
                             qualify row_number() over (partition by mandant_id,kl_art_id order by art_id desc) = 1) ax
                    on tx.kl_art_id = ax.kl_art_id and 
                       tx.mandant_id = ax.mandant_id
                  left join dbp_data.mwst_per_1 mw
                    on mw.mandant_id = t.mandant_id and 
                       x.bon_dat between mw.dat_von and mw.dat_bis and 
                       coalesce(t.mwst, 0) <> 0 and 
                       t.mwst = mw.mwst and 
                       mw.mwst_id <> 4
                  left join dbp_data.mwst_per_1 tw
                    on mw.mandant_id = tx.mandant_id and 
                       x.bon_dat between mw.dat_von and mw.dat_bis and 
                       coalesce(tx.mwst, 0) <> 0 and 
                       tx.mwst = mw.mwst and 
                       mw.mwst_id <> 4
                  left join (select mandant_id
                                   ,wup_id
                                   ,bon_id
                                   ,bon_zeile
                                   ,sum(coupon_betrag) as coupon_betrag
                             from dbp_ods.ods_coupon_1
                             where coupon_kz = 1
                             group by 1,2,3,4) c
                    on x.mandant_id = c.mandant_id and 
                       x.wup_id = c.wup_id and 
                       x.bon_id = c.bon_id and 
                       x.bon_zeile = c.bon_zeile and 
                       x.talon_id = 0
                  union all
                  select *
                  from _retoure) a
                  group by mandant_id,wup_id,dat,kl_art_id,ean_kasse,mwst_id,wg_id,aktion_id,talon_id,talon_id_aus_bon,kundenkarte_id,kundenkarte_typ_id,customer_promotion_fg,promotion_art
                          ,aktion_id_obv,bon_zeile,stichlogik,bby_bewart,bby_unique,bby_aktion,important,bon_id,loyalty_berechtigt_fg) p) tmp
where tmp.rk = 1
group by mandant_id,wup_id,dat,kl_art_id,ean_kasse,mwst_id,wg_id,aktion_id,talon_id,talon_id_aus_bon,kundenkarte_id,kundenkarte_typ_id,customer_promotion_fg
        ,promotion_art,aktion_id_obv,bon_zeile,bby_bewart,bby_unique,bby_aktion,important,stichlogik,loyalty_berechtigt_fg
;

create or replace transient table _crm_keys as (
select mandant_id,
       wup_id,
       kundenkarte_id,
       bon_dat as dat,
       count(distinct case when bon_id <> '' then bon_id else null end) as anz_bon
from (select mandant_id,
             wup_id,
             kundenkarte_id,
             bon_dat,
             bon_id,
             kl_art_id
       from dbp_etl.bon_kopf_verkauf_1
       union all
       select mandant_id,
              wup_id,
              kundenkarte_id,
              dat as bon_dat,
              bon_id,
              kl_art_id
       from _retoure
       union all
       select mandant_id,
             wup_id,
             kundenkarte_id,
             dat as bon_dat,
             bon_id,
             kl_art_id
       from dbp_etl.retoure_x_1) x
where (mandant_id,kl_art_id) not in (select mandant_id,floor(art_id/100) as kl_art_id
                                     from dbp_data.art_wg_zu_per_1
                                     where mandant_id = 1 and
                                           arthiertyp_id = 2 and
                                           dat_bis = '9999-12-31' and
                                           wg_id = 961)
group by 1,2,3,4
);

delete from dbp_etl.bon_artbew_tgl_delta_1
where dat > current_date
;

delete from dbp_etl.bon_artbew_tmp_talon_1
where dat > current_date
;

delete from dbp_etl.bon_artbew_tgl_delta_1 using dbp_data.wup_1
where dbp_etl.bon_artbew_tgl_delta.mandant_id = dbp_data.wup.mandant_id
and dbp_etl.bon_artbew_tgl_delta.wup_id     = dbp_data.wup.wup_id
and dbp_etl.bon_artbew_tgl_delta.dat        < dbp_data.wup.dat_von
;

delete from dbp_etl.bon_artbew_tmp_talon_1 using dbp_data.wup_1
where dbp_etl.bon_artbew_tmp_talon.mandant_id = dbp_data.wup.mandant_id
and dbp_etl.bon_artbew_tmp_talon.wup_id     = dbp_data.wup.wup_id
and dbp_etl.bon_artbew_tmp_talon.dat        < dbp_data.wup.dat_von
;

create or replace table dbp_etl.bd_for_promotion_de_1 as (
select *
from dbp_ods.ods_promotion_1
where mandant_id = 1
);

create or replace volatile table _test as (
select op.bon_id, 
       op.wup_id, 
       op.mandant_id, 
       op.bon_dat, 
       op.kl_art_id,
       b.art_id,
       op.bon_zeile, 
       op.bonuskauf_id, 
       op.customer_promotion_fg,
       op.promotion_art,
       ab.aktionsart_id,
       c.aktionsart_bez,
       ab.aktion_typ_id,
       d.aktion_typ_bez
from dbp_etl.bd_for_promotion_de_1 op
join (select mandant_id,
             kl_art_id,
             max(art_id) as art_id
      from dbp_data.art_1
      group by 1,2) b
  on op.mandant_id = b.mandant_id and
     op.kl_art_id = b.kl_art_id
left join (select b.mandant_id, 
                  b.bonuskauf_id, 
                  a.aktion_typ_id,
                  a.aktionsart_id
           from dbp_data.aktion_1 a
           left join dbp_data.l_bonuskauf_1 b
             on a.aktion_id = b.aktion_id and 
                a.mandant_id = b.mandant_id
           group by 1,2,3,4) ab
  on op.bonuskauf_id = ab.bonuskauf_id and 
     op.mandant_id = ab.mandant_id
left join dbp_data.aktionsart_spr_zu_1 c
  on op.mandant_id = c.mandant_id and
     ab.aktionsart_id = c.aktionsart_id
left join dbp_data.l_aktion_typ_1 d
  on op.mandant_id = d.mandant_id and
     ab.aktion_typ_id = d.aktion_typ_id
group by all
);

create or replace table dbp_etl.bon_artbew_tmp_talon_db_1 like dbp_etl.bon_artbew_tmp_talon_1;
alter table dbp_etl.bon_artbew_tmp_talon_db_1 add standard_aktion_id varchar(1000),
                                aktionsart_id varchar(1000),
                                aktionsart_bez varchar(1000),
                                aktion_typ_id_2 varchar(1000),
                                aktion_typ_bez varchar(1000),
                                aktionsart_std varchar(1000),
                                aktionsart_bez_std varchar(1000)
;

insert into dbp_etl.bon_artbew_tmp_talon_db_1 (mandant_id
                                         ,wup_id
                                         ,dat
                                         ,kl_art_id
                                         ,ean_kasse
                                         ,mwst_id
                                         ,wg_id
                                         ,aktion_id
                                         ,umsatz_brutto
                                         ,menge
                                         ,talon_id
                                         ,talon_id_aus_bon
                                         ,bon_id
                                         ,kundenkarte_id
                                         ,kundenkarte_typ_id
                                         ,bonuskauf_id
                                         ,customer_promotion_fg
                                         ,promotion_art 
                                         ,aktion_id_obv  
                                         ,bon_zeile
                                         ,bby_bewart
                                         ,bby_unique
                                         ,bby_aktion
                                         ,important
                                         ,stichlogik
                                         ,loyalty_berechtigt_fg
                                         ,standard_aktion_id
                                         ,aktionsart_id
                                         ,aktionsart_bez
                                         ,aktion_typ_id_2
                                         ,aktion_typ_bez
                                         ,aktionsart_std
                                         ,aktionsart_bez_std)
select z.mandant_id
      ,z.wup_id
      ,z.dat
      ,z.kl_art_id
      ,z.ean_kasse
      ,z.mwst_id
      ,z.wg_id
      ,z.aktion_id
      ,z.umsatz_brutto
      ,z.menge
      ,z.talon_id
      ,z.talon_id_aus_bon
      ,z.bon_id
      ,z.kundenkarte_id
      ,z.kundenkarte_typ_id
      ,z.bonuskauf_id
      ,z.customer_promotion_fg
      ,z.promotion_art 
      ,z.aktion_id_obv  
      ,z.bon_zeile
      ,z.bby_bewart
      ,z.bby_unique
      ,z.bby_aktion
      ,z.important
      ,z.stichlogik
      ,z.loyalty_berechtigt_fg
      ,zz.standard_aktion_id_
      ,xxxxx.aktionsart_id
      ,xxxxx.aktionsart_bez
      ,xxxxx.aktion_typ_id
      ,xxxxx.aktion_typ_bez
      ,yyyyy.aktionsart_std
      ,yyyyy.aktionsart_bez_std
from dbp_etl.bon_artbew_tmp_talon_1 z
left join _test xxxxx
  on z.bon_id = xxxxx.bon_id and 
     z.wup_id = xxxxx.wup_id and 
     z.mandant_id = xxxxx.mandant_id and 
     z.dat = xxxxx.bon_dat and 
     z.kl_art_id = xxxxx.kl_art_id and 
     z.bon_zeile = xxxxx.bon_zeile
left join (select b.mandant_id,
                  b.wup_id,
                  b.kl_art_id,
                  b.dat,
                  max(a.aktion_id) as standard_aktion_id_
           from dbp_data.aktion_art_wup_zu_1 a
           join dbp_etl.bon_artbew_tmp_talon_1 b
             on floor(a.art_id/100) = b.kl_art_id and
                a.mandant_id = b.mandant_id and
                a.wup_id = b.wup_id
           join dbp_data.aktion_1 c
             on a.mandant_id = c.mandant_id and
                a.aktion_id = c.aktion_id and
                b.dat between c.dat_von and c.dat_bis
           where a.grund_sperrung is null and
                 case 
                   when c.mandant_id = 1 
                   then c.preisaktiviert_fg 
                   else 0
                 end = 1
           group by all) zz
on z.mandant_id = zz.mandant_id and
   z.wup_id = zz.wup_id and
   z.kl_art_id = zz.kl_art_id and
   z.dat = zz.dat
left join (select a.mandant_id,
                  a.aktion_id,
                  max(a.aktionsart_id) as aktionsart_std,
                  max(b.aktionsart_bez) as aktionsart_bez_std
           from dbp_data.aktion_1 a
           join dbp_data.aktionsart_spr_zu_1 b
             on a.mandant_id = b.mandant_id and
                a.aktionsart_id = b.aktionsart_id and
                b.spr_id = 22
           group by all) yyyyy
  on zz.mandant_id = yyyyy.mandant_id and
     zz.standard_aktion_id_ = yyyyy.aktion_id
group by all
;

alter table dbp_etl.bon_artbew_tmp_talon_1 add aktionsart_id varchar(1000),
                                             aktionsart_bez varchar(1000),
                                             aktion_typ_id_2 varchar(1000),
                                             aktion_typ_bez varchar(1000)
;

update dbp_etl.bon_artbew_tmp_talon_1 from (
select mandant_id
      ,wup_id
      ,dat
      ,kl_art_id
      ,ean_kasse
      ,mwst_id
      ,wg_id
      ,aktion_id
      ,umsatz_brutto
      ,menge
      ,talon_id
      ,talon_id_aus_bon
      ,bon_id
      ,kundenkarte_id
      ,kundenkarte_typ_id
      ,bonuskauf_id
      ,customer_promotion_fg
      ,promotion_art 
      ,aktion_id_obv  
      ,bon_zeile
      ,bby_bewart
      ,bby_unique
      ,bby_aktion
      ,important
      ,stichlogik
      ,loyalty_berechtigt_fg
      ,case
         when trim(aktionsart_std) <> '' and aktionsart_std is not null 
         then aktionsart_std||','||trim(listagg(distinct cast(aktionsart_id as varchar(600)), ',') within group (order by null ),',')
         else trim(listagg(distinct cast(aktionsart_id as varchar(600)), ',') within group (order by null ),',')
       end as aktionsart_id_liste,
       case
         when trim(aktionsart_bez_std) <> '' and aktionsart_bez_std is not null
         then aktionsart_bez_std||','||trim(listagg(distinct cast(aktionsart_bez as varchar(600)), ',') within group (order by null ),',')
         else trim(listagg(distinct cast(aktionsart_bez as varchar(600)), ',') within group (order by null ),',')
       end as aktionsart_bez_liste,
       trim(listagg(distinct cast(aktion_typ_id_2 as varchar(600)), ',') within group (order by null ),',') as aktion_typ_liste,
       trim(listagg(distinct cast(aktion_typ_bez as varchar(600)), ',') within group (order by null ),',') as aktion_typ_bez_liste,
       aktionsart_std,
       aktionsart_bez_std
from dbp_etl.bon_artbew_tmp_talon_db_1 a
group by all) b

set aktionsart_id = aktionsart_id_liste,
    aktionsart_bez = aktionsart_bez_liste,
    aktion_typ_id_2 = aktion_typ_liste,
    aktion_typ_bez = aktion_typ_bez_liste

where dbp_etl.bon_artbew_tmp_talon.mandant_id                         = b.mandant_id and
      dbp_etl.bon_artbew_tmp_talon.wup_id                             = b.wup_id and                            
      dbp_etl.bon_artbew_tmp_talon.dat                                = b.dat and                               
      dbp_etl.bon_artbew_tmp_talon.kl_art_id                          = b.kl_art_id and                         
      coalesce(dbp_etl.bon_artbew_tmp_talon.ean_kasse,-1)             = coalesce(b.ean_kasse,-1) and            
      coalesce(dbp_etl.bon_artbew_tmp_talon.mwst_id,-1)               = coalesce(b.mwst_id,-1) and              
      coalesce(dbp_etl.bon_artbew_tmp_talon.wg_id,-1)                 = coalesce(b.wg_id,-1) and                
      dbp_etl.bon_artbew_tmp_talon.aktion_id                          = b.aktion_id and                         
      coalesce(dbp_etl.bon_artbew_tmp_talon.umsatz_brutto,-1)         = coalesce(b.umsatz_brutto,-1) and        
      coalesce(dbp_etl.bon_artbew_tmp_talon.menge,-1)                 = coalesce(b.menge,-1) and                
      dbp_etl.bon_artbew_tmp_talon.talon_id                           = b.talon_id and                          
      dbp_etl.bon_artbew_tmp_talon.talon_id_aus_bon                   = b.talon_id_aus_bon and                  
      coalesce(dbp_etl.bon_artbew_tmp_talon.bon_id,'-1')              = coalesce(b.bon_id,'-1') and             
      coalesce(dbp_etl.bon_artbew_tmp_talon.kundenkarte_id,'-1')      = coalesce(b.kundenkarte_id,'-1') and     
      dbp_etl.bon_artbew_tmp_talon.kundenkarte_typ_id                 = b.kundenkarte_typ_id and                
      coalesce(dbp_etl.bon_artbew_tmp_talon.bonuskauf_id,'-1')        = coalesce(b.bonuskauf_id,'-1') and       
      coalesce(dbp_etl.bon_artbew_tmp_talon.customer_promotion_fg,-1) = coalesce(b.customer_promotion_fg,-1) and
      coalesce(dbp_etl.bon_artbew_tmp_talon.promotion_art,'-1')       = coalesce(b.promotion_art,'-1') and      
      coalesce(dbp_etl.bon_artbew_tmp_talon.aktion_id_obv,'-1')       = coalesce(b.aktion_id_obv,'-1') and      
      coalesce(dbp_etl.bon_artbew_tmp_talon.bon_zeile,-1)             = coalesce(b.bon_zeile,-1) and            
      coalesce(dbp_etl.bon_artbew_tmp_talon.bby_bewart,-1)            = coalesce(b.bby_bewart,-1) and           
      coalesce(dbp_etl.bon_artbew_tmp_talon.bby_unique,-1)            = coalesce(b.bby_unique,-1) and           
      coalesce(dbp_etl.bon_artbew_tmp_talon.bby_aktion,'-1')          = coalesce(b.bby_aktion,'-1') and           
      coalesce(dbp_etl.bon_artbew_tmp_talon.important,'-1')           = coalesce(b.important,'-1') and           
      coalesce(dbp_etl.bon_artbew_tmp_talon.stichlogik,-1)            = coalesce(b.stichlogik,-1) and
      coalesce(dbp_etl.bon_artbew_tmp_talon.loyalty_berechtigt_fg,-1) = coalesce(b.loyalty_berechtigt_fg,-1)
;

update dbp_etl.bon_artbew_tmp_talon_1 set aktionsart_id = substr(aktionsart_id,1,length(aktionsart_id)-1),
                                        aktionsart_bez = substr(aktionsart_bez,1,length(aktionsart_bez)-1)
where endswith(aktionsart_id,',')
;

update dbp_etl.bon_artbew_tmp_talon_1 set aktion_typ_id_2 = substr(aktion_typ_id_2,1,length(aktion_typ_id_2)-1),
                                        aktion_typ_bez = substr(aktion_typ_bez,1,length(aktion_typ_bez)-1)
where endswith(aktion_typ_id_2,',')
;

-- zmp-einschub, 12.03.2026, -dbay-

alter table dbp_etl.bon_artbew_tmp_talon_1 add bewart_det_id_zmp integer
;

create or replace volatile table _check_zmp1 as (
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.bon_zeile,
       a.konditionsart_id,
       a.promotion_art,
       a.customer_promotion_fg,
       coalesce(d.aktion_id,c.aktion_id) as aktion_id,
       c.aktion_id as aktion_id_verkauf,
       a.bonuskauf_id,
       c.ean_kasse,
       a.kl_art_id,
       a.menge_promo,
       a.betrag_promo_brutto,
       a.umsatz_promo_brutto,
       b.bon_id as bon_id_kopf
from dbp_ods.ods_promotion_1 a
join dbp_ods.ods_bon_kopf_1 b
  on a.bon_id = b.bon_id and 
     a.wup_id = b.wup_id and 
     a.bon_dat = b.bon_dat and 
     a.mandant_id = b.mandant_id
join dbp_ods.ods_bon_verkauf_1 c
  on b.mandant_id = c.mandant_id and
     b.bon_id = c.bon_id and
     b.bon_dat = c.bon_dat and
     b.wup_id = c.wup_id and
     a.bon_zeile = c.bon_zeile
left join dbp_data.l_bonuskauf_1 d
  on a.mandant_id = d.mandant_id and
     a.bonuskauf_id = d.bonuskauf_id and
     a.bon_dat between d.dat_von and d.dat_bis
where (a.mandant_id,a.bon_id,a.bon_zeile,a.bon_dat,a.wup_id) in (select mandant_id,
                                                                        bon_id,
                                                                        bon_zeile,
                                                                        bon_dat,
                                                                        wup_id
                                                                 from dbp_ods.ods_promotion_1
                                                                 where konditionsart_id in ('ZMP') and
                                                                       mandant_id = 1
                                                                 group by 1,2,3,4,5) and
     
      b.turnover_fg = 1 and 
      b.suspended_fg = 0 and 
      b.kunde_fg = 1
group by all
);

update _check_zmp1 set promotion_art = 'PERSONAL'
where promotion_art = 'XTRA'
;

create or replace volatile table _unique_ as (
select x.mandant_id,
       x.wup_id,
       x.bon_dat,
       x.bon_id,
       x.bon_zeile,
       case
         when x.max_aktion_verkauf = '' and x.akt_fg = 0
         then 100111
         when x.max_aktion_verkauf = '' and x.akt_fg = 1
         then 100241
         else 100211
       end as bewart_det_id
from (select a.mandant_id,
             a.wup_id,
             a.bon_dat,
             a.bon_id,
             a.bon_zeile,
             max(b.akt_fg) as akt_fg,
             max(a.aktion_id) as max_aktion,
             max(a.aktion_id_verkauf) as max_aktion_verkauf,
             count(distinct a.promotion_art) as anz_promo,
             count(distinct a.konditionsart_id) as anz_kond,
             max(a.promotion_art) as max_promo,
             min(a.promotion_art) as min_promo,
             max(a.konditionsart_id) as max_kond,
             min(a.konditionsart_id) as min_kond
      from _check_zmp1 a
      join (select a.mandant_id,
                   a.wup_id,
                   a.bon_dat,
                   a.bon_id,
                   a.bon_zeile,
                   case
                     when max(abs(a.betrag_promo_brutto)) <> 0.01
                     then 1
                     else 0
                   end as akt_fg
            from _check_zmp1 a
            where a.mandant_id = 1 and
                  a.konditionsart_id not in ('ZRT3','ZK03') and
                  a.konditionsart_id = 'ZMP'
            group by all) b
        on a.mandant_id = b.mandant_id and
           a.wup_id = b.wup_id and
           a.bon_dat = b.bon_dat and
           a.bon_id = b.bon_id and
           a.bon_zeile = b.bon_zeile
      where a.mandant_id = 1 and
            a.konditionsart_id not in ('ZRT3','ZK03') and
            case
            when a.konditionsart_id = 'ZMP' and
                 abs(a.betrag_promo_brutto) <> 0.01
            then 0
            else 1
            end = 1
      group by all
      having anz_promo = 1 and
             min_promo = 'PERSONAL' and
             anz_kond = 1) x
group by all
);

insert into _unique_
select x.mandant_id,
       x.wup_id,
       x.bon_dat,
       x.bon_id,
       x.bon_zeile,
       100241 as bewart_det_id
from (select a.mandant_id,
             a.wup_id,
             a.bon_dat,
             a.bon_id,
             a.bon_zeile,
             max(a.aktion_id) as max_aktion,
             count(distinct case when a.promotion_art = '' then null else a.promotion_art end) as anz_promo,
             count(distinct a.konditionsart_id) as anz_kond,
             max(a.promotion_art) as max_promo,
             min(case when a.promotion_art = '' then 'ZZZZ' else a.promotion_art end) as min_promo,
             max(a.konditionsart_id) as max_kond,
             min(a.konditionsart_id) as min_kond
      from _check_zmp1 a 
      where a.mandant_id = 1
      group by all
      having anz_kond = 2 and
             max_kond = 'ZMP' and min_kond = 'ZAR1' and
             max_promo = 'PERSONAL' and
             min_promo = 'PERSONAL') x
where (x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile) not in (select x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile from _unique_ x)
group by all
;

insert into _unique_
select x.mandant_id,
       x.wup_id,
       x.bon_dat,
       x.bon_id,
       x.bon_zeile,
       100231 as bewart_det_id
from (select a.mandant_id,
             a.wup_id,
             a.bon_dat,
             a.bon_id,
             a.bon_zeile,
             max(a.aktion_id) as max_aktion,
             count(distinct case when a.promotion_art = '' then null else a.promotion_art end) as anz_promo,
             count(distinct a.konditionsart_id) as anz_kond,
             max(a.promotion_art) as max_promo,
             min(case when a.promotion_art = '' then 'ZZZZ' else a.promotion_art end) as min_promo,
             max(a.konditionsart_id) as max_kond,
             min(a.konditionsart_id) as min_kond
      from _check_zmp1 a 
      where a.mandant_id = 1
      group by all
      having anz_kond = 2 and
             max_promo = 'PERSONAL' and
             min_promo = 'CUSTOMER') x
where (x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile) not in (select x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile from _unique_ x)
group by all
;

insert into _unique_
select x.mandant_id,
       x.wup_id,
       x.bon_dat,
       x.bon_id,
       x.bon_zeile,
       case
         when x.max_aktion_verkauf = '' and x.akt_fg = 0
         then 100121
         when x.max_aktion_verkauf = '' and x.akt_fg = 1
         then 100241
         else 100211
       end as bewart_det_id
from (select a.mandant_id,
             a.wup_id,
             a.bon_dat,
             a.bon_id,
             a.bon_zeile,
             max(b.akt_fg) as akt_fg,
             max(a.aktion_id) as max_aktion,
             max(a.aktion_id_verkauf) as max_aktion_verkauf,
             count(distinct case when a.promotion_art = '' then null else a.promotion_art end) as anz_promo,
             count(distinct a.konditionsart_id) as anz_kond,
             max(a.promotion_art) as max_promo,
             min(case when a.promotion_art = '' then 'ZZZZ' else a.promotion_art end) as min_promo,
             max(a.konditionsart_id) as max_kond,
             min(a.konditionsart_id) as min_kond
      from _check_zmp1 a
      join (select a.mandant_id,
                   a.wup_id,
                   a.bon_dat,
                   a.bon_id,
                   a.bon_zeile,
                   case
                     when max(abs(a.betrag_promo_brutto)) <> 0.01
                     then 1
                     else 0
                   end as akt_fg
            from _check_zmp1 a
            where a.mandant_id = 1 and
                  a.konditionsart_id = 'ZMP'
            group by all) b
        on a.mandant_id = b.mandant_id and
           a.wup_id = b.wup_id and
           a.bon_dat = b.bon_dat and
           a.bon_id = b.bon_id and
           a.bon_zeile = b.bon_zeile
      where a.mandant_id = 1
      group by all
      having anz_kond = 2 and
             max_promo = 'PERSONAL_SMP' and
             min_promo = 'PERSONAL') x
where (x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile) not in (select x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile from _unique_ x)
group by all
;

create or replace volatile table _unique_100221 as (
select x.mandant_id,
       x.wup_id,
       x.bon_dat,
       x.bon_id,
       x.bon_zeile,
       100221 as bewart_det_id
from (select a.mandant_id,
             a.wup_id,
             a.bon_dat,
             a.bon_id,
             a.bon_zeile,
             max(a.aktion_id) as max_aktion,
             count(distinct case when a.promotion_art = '' then null else a.promotion_art end) as anz_promo,
             count(distinct a.konditionsart_id) as anz_kond,
             max(a.promotion_art) as max_promo,
             min(case when a.promotion_art = '' then 'ZZZZ' else a.promotion_art end) as min_promo,
             max(a.konditionsart_id) as max_kond,
             min(a.konditionsart_id) as min_kond
      from _check_zmp1 a 
      where a.mandant_id = 1
      group by all
      having anz_kond = 2 and
             max_promo = 'PERSONAL' and
             min_promo = 'COMMON') x
group by all
);

delete from _unique_
where (mandant_id,wup_id,bon_dat,bon_id,bon_zeile) in (select x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile from _unique_100221 x)
;

insert into _unique_
select x.mandant_id,
       x.wup_id,
       x.bon_dat,
       x.bon_id,
       x.bon_zeile,
       100221 as bewart_det_id
from (select a.mandant_id,
             a.wup_id,
             a.bon_dat,
             a.bon_id,
             a.bon_zeile,
             max(a.aktion_id) as max_aktion,
             count(distinct case when a.promotion_art = '' then null else a.promotion_art end) as anz_promo,
             count(distinct a.konditionsart_id) as anz_kond,
             max(a.promotion_art) as max_promo,
             min(case when a.promotion_art = '' then 'ZZZZ' else a.promotion_art end) as min_promo,
             max(a.konditionsart_id) as max_kond,
             min(a.konditionsart_id) as min_kond
      from _check_zmp1 a 
      where a.mandant_id = 1
      group by all
      having anz_kond = 2 and
             max_promo = 'PERSONAL' and
             min_promo = 'COMMON') x
group by all
;

insert into _unique_
select x.mandant_id,
       x.wup_id,
       x.bon_dat,
       x.bon_id,
       x.bon_zeile,
       case
         when x.max_aktion_verkauf = '' and x.akt_fg = 0
         then 100131
         when x.max_aktion_verkauf = '' and x.akt_fg = 1
         then 100241
         else 100211
       end as bewart_det_id
from (select a.mandant_id,
             a.wup_id,
             a.bon_dat,
             a.bon_id,
             a.bon_zeile,
             max(b.akt_fg) as akt_fg,
             max(a.aktion_id) as max_aktion,
             max(a.aktion_id_verkauf) as max_aktion_verkauf,
             count(distinct case when a.promotion_art = '' then null else a.promotion_art end) as anz_promo,
             count(distinct a.konditionsart_id) as anz_kond,
             max(a.promotion_art) as max_promo,
             min(case when a.promotion_art = '' then 'ZZZZ' else a.promotion_art end) as min_promo,
             max(a.konditionsart_id) as max_kond,
             listagg(distinct a.konditionsart_id) as avg_kond,
             min(a.konditionsart_id) as min_kond
      from _check_zmp1 a
      join (select a.mandant_id,
                   a.wup_id,
                   a.bon_dat,
                   a.bon_id,
                   a.bon_zeile,
                   case
                     when max(abs(a.betrag_promo_brutto)) <> 0.01
                     then 1
                     else 0
                   end as akt_fg
            from _check_zmp1 a
            where a.mandant_id = 1 and
                  a.konditionsart_id = 'ZMP'
            group by all) b
        on a.mandant_id = b.mandant_id and
           a.wup_id = b.wup_id and
           a.bon_dat = b.bon_dat and
           a.bon_id = b.bon_id and
           a.bon_zeile = b.bon_zeile
      where a.mandant_id = 1
      group by all
      having anz_kond = 2 and
            (avg_kond like '%ZBOV%' or
             avg_kond like '%ZBON%') and
             max_promo = 'PERSONAL' and
             min_promo = 'PERSONAL') x
where (x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile) not in (select x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile from _unique_ x)
group by all
;

insert into _unique_
select x.mandant_id,
       x.wup_id,
       x.bon_dat,
       x.bon_id,
       x.bon_zeile,
       100221 as bewart_det_id
from (select a.mandant_id,
             a.wup_id,
             a.bon_dat,
             a.bon_id,
             a.bon_zeile,
             max(a.aktion_id) as max_aktion,
             count(distinct case when a.promotion_art = '' then null else a.promotion_art end) as anz_promo,
             count(distinct a.konditionsart_id) as anz_kond,
             max(a.promotion_art) as max_promo,
             listagg(distinct a.promotion_art) as avg_promo,
             min(case when a.promotion_art = '' then 'ZZZZ' else a.promotion_art end) as min_promo,
             max(a.konditionsart_id) as max_kond,
             listagg(distinct a.konditionsart_id) as avg_kond,
             min(a.konditionsart_id) as min_kond
      from _check_zmp1 a 
      where a.mandant_id = 1
      group by all
      having anz_kond = 3 and
             anz_promo = 2 and
            (avg_kond like '%ZBOV%' or
             avg_kond like '%ZBON%') and
             max_promo = 'PERSONAL' and
             min_promo = 'COMMON') x
where (x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile) not in (select x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile from _unique_ x)
group by all
;

insert into _unique_
select x.mandant_id,
       x.wup_id,
       x.bon_dat,
       x.bon_id,
       x.bon_zeile,
       100231 as bewart_det_id
from (select a.mandant_id,
             a.wup_id,
             a.bon_dat,
             a.bon_id,
             a.bon_zeile,
             max(a.aktion_id) as max_aktion,
             count(distinct case when a.promotion_art = '' then null else a.promotion_art end) as anz_promo,
             count(distinct a.konditionsart_id) as anz_kond,
             max(a.promotion_art) as max_promo,
             listagg(distinct a.promotion_art) as avg_promo,
             min(case when a.promotion_art = '' then 'ZZZZ' else a.promotion_art end) as min_promo,
             max(a.konditionsart_id) as max_kond,
             listagg(distinct a.konditionsart_id) as avg_kond,
             min(a.konditionsart_id) as min_kond
      from _check_zmp1 a 
      where a.mandant_id = 1
      group by all
      having anz_kond = 3 and
             anz_promo = 2 and
             max_promo = 'PERSONAL' and
             min_promo = 'COMMON' and
             avg_promo like '%CUSTOMER%') x
where (x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile) not in (select x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile from _unique_ x)
group by all
;

insert into _unique_
select x.mandant_id,
       x.wup_id,
       x.bon_dat,
       x.bon_id,
       x.bon_zeile,
       case
         when x.max_aktion_verkauf = '' and x.akt_fg = 0
         then 100111
         else 9999
       end as bewart_det_id_
from (select a.mandant_id,
             a.wup_id,
             a.bon_dat,
             a.bon_id,
             a.bon_zeile,
             max(b.akt_fg) as akt_fg,
             max(a.aktion_id) as max_aktion,
             max(a.aktion_id_verkauf) as max_aktion_verkauf,
             count(distinct case when a.promotion_art = '' then null else a.promotion_art end) as anz_promo,
             count(distinct a.konditionsart_id) as anz_kond,
             max(a.promotion_art) as max_promo,
             min(case when a.promotion_art = '' then 'ZZZZ' else a.promotion_art end) as min_promo,
             max(a.konditionsart_id) as max_kond,
             min(a.konditionsart_id) as min_kond
      from _check_zmp1 a
      join (select a.mandant_id,
                   a.wup_id,
                   a.bon_dat,
                   a.bon_id,
                   a.bon_zeile,
                   case
                     when max(abs(a.betrag_promo_brutto)) <> 0.01
                     then 1
                     else 0
                   end as akt_fg
            from _check_zmp1 a
            where a.mandant_id = 1 and
                  a.konditionsart_id = 'ZMP'
            group by all) b
        on a.mandant_id = b.mandant_id and
           a.wup_id = b.wup_id and
           a.bon_dat = b.bon_dat and
           a.bon_id = b.bon_id and
           a.bon_zeile = b.bon_zeile
      where a.mandant_id = 1
      group by all
      having anz_promo = 1 and
            ((min_promo = 'COMMON' and max_promo = 'COMMON') or 
             (min_promo = 'CUSTOMER' and max_promo = 'COMMON')) and
             anz_kond = 1) x
where (x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile) not in (select x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile from _unique_ x)
group by all
having bewart_det_id_ in (100111)
;

update dbp_etl.bon_artbew_tmp_talon_1 from (select *
                                          from _unique_) b

set bewart_det_id_zmp = b.bewart_det_id

where dbp_etl.bon_artbew_tmp_talon.mandant_id = b.mandant_id and
      dbp_etl.bon_artbew_tmp_talon.wup_id = b.wup_id and
      dbp_etl.bon_artbew_tmp_talon.dat = b.bon_dat and
      dbp_etl.bon_artbew_tmp_talon.bon_id = b.bon_id and
      dbp_etl.bon_artbew_tmp_talon.bon_zeile = b.bon_zeile and
      dbp_etl.bon_artbew_tmp_talon.umsatz_brutto/nullifzero(dbp_etl.bon_artbew_tmp_talon.menge) <> 0.01
;

create or replace volatile table _zmp01 as (
select b.mandant_id,
       b.bon_id,
       b.bon_id_kopf,
       b.bon_zeile,
       b.wup_id,
       b.bon_dat,
       sum(b.betrag_promo_brutto) as betrag_promo,
       sum(b.umsatz_promo_brutto) as umsatz_promo,
       cast(abs(umsatz_promo/nullifzero(betrag_promo)) as int) as menge
from dbp_ods.ods_bon_verkauf_1 a
join _check_zmp1 b
  on a.mandant_id = b.mandant_id and 
     a.wup_id = b.wup_id and 
     a.bon_dat = b.bon_dat and 
     a.bon_zeile = b.bon_zeile and 
     a.bon_id = b.bon_id
where a.mandant_id = 1 and 
      abs(b.betrag_promo_brutto) = 0.01 and
      b.betrag_promo_brutto < 0 and (b.umsatz_promo_brutto < 0 or b.umsatz_promo_brutto = 0.01)
group by all
);

update dbp_etl.bon_artbew_tmp_talon_1 from (select *
                                          from _zmp01) b

set umsatz_brutto = umsatz_brutto-b.betrag_promo

where dbp_etl.bon_artbew_tmp_talon.mandant_id = b.mandant_id and
      dbp_etl.bon_artbew_tmp_talon.wup_id = b.wup_id and
      dbp_etl.bon_artbew_tmp_talon.dat = b.bon_dat and
      dbp_etl.bon_artbew_tmp_talon.bon_id = b.bon_id and
      dbp_etl.bon_artbew_tmp_talon.bon_zeile = b.bon_zeile
;

create or replace volatile table _zmp02 as (
select b.mandant_id,
       b.bon_id,
       b.bon_id_kopf,
       b.bon_zeile,
       b.wup_id,
       b.bon_dat,
       sum(case
             when abs(b.betrag_promo_) <> 0.01 and
                  b.betrag_promo_ > 0
             then  0.01
             else -0.01
           end) as betrag_promo_
from dbp_ods.ods_bon_verkauf_1 a
join (select mandant_id,
             bon_id,
             bon_id_kopf,
             bon_zeile,
             wup_id,
             bon_dat,
             sum(betrag_promo_brutto) as betrag_promo_
      from _check_zmp1
      where abs(betrag_promo_brutto) <> 0.01 and
            konditionsart_id = 'ZMP'
      group by all
      having abs(betrag_promo_) <> 0.01) b
  on a.mandant_id = b.mandant_id and 
     a.wup_id = b.wup_id and 
     a.bon_dat = b.bon_dat and 
     a.bon_zeile = b.bon_zeile and 
     a.bon_id = b.bon_id
where a.mandant_id = 1-- and 
      --abs(b.betrag_promo_brutto) <> 0.01
group by all
);

update dbp_etl.bon_artbew_tmp_talon_1 set umsatz_brutto = 0
where (mandant_id,wup_id,dat,bon_id) in (select mandant_id,wup_id,bon_dat,bon_id from _zmp01) and
       umsatz_brutto/nullifzero(menge) = 0.01
;

update dbp_etl.bon_artbew_tmp_talon_1 from (select *
                                          from _zmp02) b
                                          
set umsatz_brutto = umsatz_brutto+b.betrag_promo_

where dbp_etl.bon_artbew_tmp_talon.mandant_id = b.mandant_id and
      dbp_etl.bon_artbew_tmp_talon.wup_id = b.wup_id and
      dbp_etl.bon_artbew_tmp_talon.dat = b.bon_dat and
      dbp_etl.bon_artbew_tmp_talon.bon_id = b.bon_id and
      dbp_etl.bon_artbew_tmp_talon.bon_zeile = b.bon_zeile and
      dbp_etl.bon_artbew_tmp_talon.umsatz_brutto/nullifzero(dbp_etl.bon_artbew_tmp_talon.menge) <> 0.01 and
      dbp_etl.bon_artbew_tmp_talon.umsatz_brutto <> 0
;

create or replace volatile table _zmp03 as (
select b.mandant_id,
       b.bon_id,
       b.bon_id_kopf,
       b.bon_zeile,
       b.wup_id,
       b.bon_dat,
       sum(b.betrag_promo_brutto) as betrag_promo,
       max(b.umsatz_promo_brutto) as umsatz_promo,
       cast(abs(umsatz_promo/nullifzero(betrag_promo)) as int) as menge
from dbp_ods.ods_bon_verkauf_1 a
join _check_zmp1 b
  on a.mandant_id = b.mandant_id and 
     a.wup_id = b.wup_id and 
     a.bon_dat = b.bon_dat and 
     a.bon_zeile = b.bon_zeile and 
     a.bon_id = b.bon_id
where a.mandant_id = 1 and 
      abs(b.betrag_promo_brutto) = 0.01 and
      b.betrag_promo_brutto < 0 and b.umsatz_promo_brutto > 0 and b.umsatz_promo_brutto <> 0.01
group by all
);

update dbp_etl.bon_artbew_tmp_talon_1 from (select *
                                          from _zmp03) b
                                          
set umsatz_brutto = umsatz_promo

where dbp_etl.bon_artbew_tmp_talon.mandant_id = b.mandant_id and
      dbp_etl.bon_artbew_tmp_talon.wup_id = b.wup_id and
      dbp_etl.bon_artbew_tmp_talon.dat = b.bon_dat and
      dbp_etl.bon_artbew_tmp_talon.bon_id = b.bon_id and
      dbp_etl.bon_artbew_tmp_talon.bon_zeile = b.bon_zeile and
      dbp_etl.bon_artbew_tmp_talon.umsatz_brutto/nullifzero(dbp_etl.bon_artbew_tmp_talon.menge) <> 0.01 and
      dbp_etl.bon_artbew_tmp_talon.umsatz_brutto <> 0
;

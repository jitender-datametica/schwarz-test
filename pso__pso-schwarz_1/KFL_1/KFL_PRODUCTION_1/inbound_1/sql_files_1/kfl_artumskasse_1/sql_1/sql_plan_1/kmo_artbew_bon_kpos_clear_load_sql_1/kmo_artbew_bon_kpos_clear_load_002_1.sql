create or replace table dbp_etl.kmo_artbew_bon_1  (
  -- informationen stammen aus bon kopf
  mandant_id          byteint,
  bon_id              varchar(25) collate 'en-ci',
  dat_booking         date,
  wup_id              integer,
  bon_zeile           integer,
  kl_art_id           integer,
  ean_kasse           decimal(26,0),
  menge               decimal(18,4),
  umsatz_brutto       decimal(18,4),
  wg_id               integer,
  aktion_id           char(10) collate 'en-ci' not null,
  lkp_art_id          integer,
  lkp_nb_id           smallint,
  lkp_wg_id           smallint,
  lkp_arthiertyp_id   byteint,
  lkp_zek_id          varchar(3),
  lkp_mwst_id         byteint,
  lkp_posten_id       char(4) collate 'en-ci',
  lkp_umrechnungskurs float,
  lkp_mwst            decimal(12,2),
  lkp_wrg             char(3) collate 'en-ci',
  kundenkarte_id      varchar(255) collate 'en-ci',    
  kundenkarte_typ_id  byteint not null default 0,
  bonuskauf_id        varchar(20) collate 'en-ci',
  bonuskauf_id_lb     varchar(20) collate 'en-ci',
  aktion_typ_id       char(4) collate 'en-ci',
  konditionsart_id char(4) collate 'en-ci',    
  vk_aktion_brutto decimal(9,3),-- not null,                        
  vk_brutto decimal(9,2),-- not null,
  betrag_promo_brutto_bby decimal(18,4),
  betrag_promo_brutto_kdn decimal(18,4),
  betrag_promo_brutto_kdp decimal(18,4),
  betrag_promo_brutto_null decimal(18,4),                                   
  bde_kundenkarte_id varchar(255) collate 'en-ci',
  customer_promotion_fg smallint default 0 ,
  promotion_art varchar(100) collate 'en-cs',
  important varchar(1),
  bewart_det_id integer,
  standard_aktion_id char(10) collate 'en-ci' not null,
  loyalty_berechtigt_fg integer
);

create or replace table dbp_etl.kmo_artbew_bon_promotion_1  (
  mandant_id            byteint,
  bon_id                varchar(25) collate 'en-ci',
  dat_booking           date,
  kl_art_id             integer,
  bon_zeile             integer,
  bonuskauf_id          char(20) collate 'en-ci',
  konditionsart_id      char(10) collate 'en-ci',
  umsatz_brutto         decimal(18,4),
  umsatz_promo_brutto   decimal(18,4),
  menge_promo           decimal(18,3)
);

drop table if exists dbp_etl.kmo_artbew_bon_dat_1;

create table dbp_etl.kmo_artbew_bon_dat_1  (
  dat date not null
);

create or replace table dbp_etl.kmo_artbew_bon_delta_1  (
  mandant_id  byteint not null,
  wup_id      integer not null,
  dat_booking date not null,
  xml_name    varchar(255)
);

insert into dbp_etl.kmo_artbew_bon_delta_1 (mandant_id
                                         ,wup_id
                                         ,dat_booking
                                         ,xml_name)
select mandant_id
      ,wup_id
      ,dat_booking
      ,xml_name
from dbp_etl.kmo_artbew_bon_delta_main_1
where dat_booking >= '2022-04-01'
;

create or replace table dbp_etl.bd_for_promotion_1 as (
select *
from dbp_ods.ods_promotion_1
where bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1)
);

update dbp_etl.bd_for_promotion_1 set promotion_art = 'PERSONAL'
where promotion_art = 'XTRA'
;

create or replace volatile table _track_zbon_zbov_unique as (
select mandant_id,
       bon_id,
       bon_zeile,
       bon_dat,
       wup_id,
       1 as flag
from dbp_etl.bd_for_promotion_1
where (mandant_id,bon_id,bon_zeile,bon_dat,wup_id) in (select mandant_id,
                                                              bon_id,
                                                              bon_zeile,
                                                              bon_dat,
                                                              wup_id
                                                       from dbp_etl.bd_for_promotion_1
                                                       where konditionsart_id in ('ZBON','ZBOV')
                                                       group by 1,2,3,4,5) and
       konditionsart_id not in ('ZRT3','ZTAG','ZGEB') and
       promotion_art not in ('PERSONAL_SMP')
group by 1,2,3,4,5
having count(distinct konditionsart_id) = 1
);

create or replace volatile table _track_zbon_zbov_unique_smp as (
select mandant_id,
       bon_id,
       bon_zeile,
       bon_dat,
       wup_id,
       1 as flag
from dbp_etl.bd_for_promotion_1
where (mandant_id,bon_id,bon_zeile,bon_dat,wup_id) in (select mandant_id,
                                                              bon_id,
                                                              bon_zeile,
                                                              bon_dat,
                                                              wup_id
                                                       from dbp_etl.bd_for_promotion_1
                                                       where promotion_art = 'PERSONAL_SMP'
                                                       group by 1,2,3,4,5) and
       konditionsart_id not in ('ZRT3','ZTAG','ZGEB')
group by 1,2,3,4,5
having count(distinct promotion_art) = 1
);

create or replace volatile table _track_zbon_zbov as (
select mandant_id,
       bon_id,
       bon_zeile,
       bon_dat,
       wup_id,
       promotion_lfd_nr,
       1 as flag
from dbp_etl.bd_for_promotion_1
where konditionsart_id in ('ZBON','ZBOV')
group by 1,2,3,4,5,6
);

-- WG_ID <> 822

create or replace transient table _zwischen1_1 as (
select k.mandant_id
      ,k.bon_id
      ,k.dat_booking
      ,k.wup_id
      ,k.wrg_id 
      ,z.kl_art_id
      ,coalesce(case 
                  when trim(z.barcode_string) = '' then coalesce(z.ean_kasse,0)
                  when length(z.barcode_string) > 26 then -9999
                  when try_to_number(z.barcode_string) is null then -9999
                  else cast(z.barcode_string as bigint)
                end,coalesce(z.ean_kasse,0)) as ean_kasse
      ,z.bon_zeile
      ,case 
         when k.kunde_fg = 0 then z.menge * (-1) else z.menge 
       end as menge_
      ,case 
         when k.kunde_fg = 0 then z.umsatz_brutto * (-1) else z.umsatz_brutto
       end as umsatz_brutto_
      ,z.wg_id 
      ,z.aktion_id
      ,k.kundenkarte_id
      ,k.kundenkarte_typ_id
      ,p.bonuskauf_id
      ,case 
         when trim(p.bonrabatt_bewart) in ('Y') and trim(z.aktion_id) = '' then 'KDB'
         when trim(p.aktion_typ_id) in ('KDP') then 'KDP' 
         when trim(p.aktion_typ_id) in ('KPB','KDN') then 'KDN'
         else 'KDA' 
       end as aktion_typ_id_
      ,a.vk_aktion_brutto
      ,vk.vk_brutto
      ,case 
         when customer_promotion_fg = 0 and ((trim(p.bonrabatt_bewart) in ('Y') and aktion_typ_id_ = 'KDB') or trim(p.bonrabatt_bby) in ('Y')) then p.betrag_promo_brutto
         when customer_promotion_fg = 1 and promotion_art in ('CUSTOMER') and trim(p.aktion_typ_id) in ('KPB','KDN','KDP','KDB') and trim(p.bonrabatt_bby) in ('Y') and bde.kundenkarte_id is null then p.betrag_promo_brutto
         when trim(p.aktion_typ_id) in ('KPB','KDN','KDP','KDB') and trim(promotion_art) in ('COMMON','PERSONAL') and trim(p.bonrabatt_bby) in ('Y') then p.betrag_promo_brutto
         else null
       end as betrag_promo_brutto_bby
      ,case 
         when customer_promotion_fg = 1 and promotion_art = 'CUSTOMER' and trim(p.aktion_typ_id) in ('KDN') and trim(p.bonrabatt_bby) in ('Y') and bde.kundenkarte_id is null and important = 'N' then null
         when trim(p.aktion_typ_id) in ('KPB', 'KDN') and important='Y' then p.betrag_promo_brutto 
         else null
       end as betrag_promo_brutto_kdn
      ,case when trim(p.aktion_typ_id) = 'KDP' and bonrabatt_bby='N' then p.betrag_promo_brutto else null end as betrag_promo_brutto_kdp
      ,case when (trim(p.aktion_typ_id) is null or trim(p.aktion_typ_id) = '') and aktion_typ_id_ <> 'KDB' and trim(p.bonrabatt_bby) in ('N') then p.betrag_promo_brutto else null end as betrag_promo_brutto_null
      ,p.konditionsart_id
      ,p.bonuskauf_id_lb 
      ,bde.kundenkarte_id AS bde_kundenkarte_id	
      ,p.customer_promotion_fg
      ,case when promotion_art = 'PERSONAL_SMP' then 99 when important = 'N' and bonrabatt_bewart = 'N' then 9 when promotion_art='PERSONAL' then 1 else case when promotion_art='CUSTOMER' or promotion_art='PAYBACK' then 2 else case when promotion_art='COMMON' then 3 else 4 end end end as stichlogik					   
      ,case when p.bonuskauf_id is not null and p.bonuskauf_id <> 0 and p.bonuskauf_id_lb is null then 1 else 0 end as bonus_flag
      ,case when p.smp_unique = 'Y' and z.aktion_id = '' then 'A' else p.important end as important
      ,a.aktion_id as standard_aktion_id
      ,k.loyalty_berechtigt_fg
from dbp_ods.ods_bon_kopf_1 k
join (select mandant_id
            ,wup_id
            ,dat_booking
      from dbp_etl.kmo_artbew_bon_delta_1
      group by 1,2,3) d
  on k.mandant_id = d.mandant_id and 
     k.wup_id = d.wup_id and 
     k.dat_booking = d.dat_booking
join dbp_ods.ods_bon_verkauf_1 z
  on k.mandant_id = z.mandant_id and 
     k.bon_id = z.bon_id and 
     k.wup_id = z.wup_id 
join dbp_ods.ods_bon_transaction_1 t
  on k.mandant_id = t.mandant_id and 
     k.bon_id = t.bon_id and 
     k.wup_id = t.wup_id 
left join dbp_data.aktion_art_wup_zu_1 a
  on z.aktion_id = a.aktion_id and 
     z.mandant_id = a.mandant_id and 
     z.wup_id = a.wup_id and 
     z.kl_art_id = a.art_id/10
left join dbp_data.art_wup_vk_per_1 vk_1
  on z.bon_dat between vk.dat_von and vk.dat_bis and 
     z.kl_art_id = vk.art_id/10 and 
     z.mandant_id = vk.mandant_id and 
     z.wup_id = vk.wup_id
left join dbp_data.bewart_det_ecommerce_1 bde
  on k.kundenkarte_id = bde.kundenkarte_id and 
     k.mandant_id = bde.mandant_id
left join (select op.bon_id, 
                  op.wup_id, 
                  op.mandant_id, 
                  op.bon_dat, 
                  op.kl_art_id, 
                  op.bon_zeile, 
                  op.bonuskauf_id, 
                  op.customer_promotion_fg,
                  op.promotion_art,
                  sum(op.betrag_promo_brutto) as betrag_promo_brutto,
                  case when op.konditionsart_id in ('ZRT3','ZTAG','ZGEB') then 'N' else 'Y' end as konditionsart_id,
                  case when op.konditionsart_id in ('ZBON','ZBOV') then 'N' else 'Y' end as important,
                  ab.aktion_typ_id aktion_typ_id,
                  ab.bonuskauf_id as bonuskauf_id_lb,
                  case when x.flag = 1 then 'Y' else 'N' end as bonrabatt_bewart,
                  case when y.flag = 1 and aktion_typ_id <> '' then 'Y' else 'N' end as bonrabatt_bby,
                  case when z.flag = 1 then 'Y' else 'N' end as smp_unique
           from dbp_etl.bd_for_promotion_1 op
           left join _track_zbon_zbov_unique x
             on op.mandant_id = x.mandant_id and
                op.wup_id = x.wup_id and
                op.bon_id = x.bon_id and
                op.bon_zeile = x.bon_zeile and
                op.bon_dat = x.bon_dat
           left join _track_zbon_zbov y
             on op.mandant_id = y.mandant_id and
                op.wup_id = y.wup_id and
                op.bon_id = y.bon_id and
                op.bon_zeile = y.bon_zeile and
                op.promotion_lfd_nr = y.promotion_lfd_nr and
                op.bon_dat = y.bon_dat
           left join _track_zbon_zbov_unique_smp z
             on op.mandant_id = z.mandant_id and
                op.wup_id = z.wup_id and
                op.bon_id = z.bon_id and
                op.bon_zeile = z.bon_zeile and
                op.bon_dat = z.bon_dat
           left join (select b.mandant_id, 
                             b.bonuskauf_id, 
                             max(a.aktion_typ_id) aktion_typ_id 
                      from dbp_data.aktion_1 a
                      left join dbp_data.l_bonuskauf_1 b
                        on a.aktion_id = b.aktion_id and 
                           a.mandant_id = b.mandant_id
                      group by 1,2) ab
             on op.bonuskauf_id = ab.bonuskauf_id and 
                op.mandant_id = ab.mandant_id
           group by 1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17) p
  on k.bon_id = p.bon_id and 
     k.wup_id = p.wup_id and 
     k.mandant_id = p.mandant_id and 
     k.bon_dat = p.bon_dat and 
     z.kl_art_id = p.kl_art_id and 
     z.bon_zeile = p.bon_zeile
where k.mandant_id > 1 and 
      k.kunde_fg = 1 and 
      k.turnover_fg = 1 and
      k.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
      z.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
      t.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
     (case when k.kasse_typ_id <> 3 then 1 else 0 end ) = 1 and 
     (k.bon_id, k.wup_id) not in (select bon_id, wup_id from dbp_ods.ods_bon_storno_1) and
      z.wg_id not in (822)
union
select k.mandant_id
      ,k.bon_id
      ,k.dat_booking
      ,k.wup_id
      ,k.wrg_id 
      ,z.kl_art_id
      ,coalesce(case 
                  when trim(z.barcode_string) = '' then coalesce(z.ean_kasse,0)
                  when length(z.barcode_string) > 26 then -9999
                  when try_to_number(z.barcode_string) is null then -9999
                  else cast(z.barcode_string as bigint)
                end,coalesce(z.ean_kasse,0)) as ean_kasse
      ,z.bon_zeile
      ,case when k.kunde_fg = 0 then z.menge * (-1)
            else z.menge
       end * z.menge_fg as menge_
      ,case when k.kunde_fg = 0 then z.umsatz_brutto * (-1)
            else z.umsatz_brutto
       end as umsatz_brutto_
      ,z.wg_id 
      ,z.aktion_id
      ,k.kundenkarte_id
      ,k.kundenkarte_typ_id
      ,p.bonuskauf_id
      ,case when trim(p.bonrabatt_bewart) in ('Y') and trim(z.aktion_id) = '' then 'KDB'
            when trim(p.aktion_typ_id) in ('KDP') then 'KDP' 
            when trim(p.aktion_typ_id) in ('KPB','KDN') then 'KDN'
            else 'KDA' 
       end as aktion_typ_id_
      ,a.vk_aktion_brutto
      ,vk.vk_brutto
      ,case 
         when customer_promotion_fg = 0 and ((trim(p.bonrabatt_bewart) in ('Y') and aktion_typ_id_ = 'KDB') or trim(p.bonrabatt_bby) in ('Y')) then p.betrag_promo_brutto
         when customer_promotion_fg = 1 and promotion_art in ('CUSTOMER') and trim(p.aktion_typ_id) in ('KPB','KDN','KDP','KDB') and trim(p.bonrabatt_bby) in ('Y') and bde.kundenkarte_id is null then p.betrag_promo_brutto
         when trim(p.aktion_typ_id) in ('KPB','KDN','KDP','KDB') and trim(promotion_art) in ('COMMON','PERSONAL') and trim(p.bonrabatt_bby) in ('Y') then p.betrag_promo_brutto
         else null
       end as betrag_promo_brutto_bby
      ,case 
         when customer_promotion_fg = 1 and promotion_art = 'CUSTOMER' and trim(p.aktion_typ_id) in ('KDN') and trim(p.bonrabatt_bby) in ('Y') and bde.kundenkarte_id is null then null
         when trim(p.aktion_typ_id) in ('KPB', 'KDN') and important='Y' then p.betrag_promo_brutto 
         else null 
       end as betrag_promo_brutto_kdn
      ,case when trim(p.aktion_typ_id) = 'KDP' and bonrabatt_bby='N' then p.betrag_promo_brutto else null end as betrag_promo_brutto_kdp
      ,case when trim(p.aktion_typ_id) is null and aktion_typ_id_ <> 'KDB' and trim(p.bonrabatt_bby) in ('N') then p.betrag_promo_brutto else null end as betrag_promo_brutto_null
      ,p.konditionsart_id
      ,p.bonuskauf_id_lb 
      ,bde.kundenkarte_id AS bde_kundenkarte_id	
      ,p.customer_promotion_fg
      ,case when promotion_art = 'PERSONAL_SMP' then 99 when important = 'N' and bonrabatt_bewart = 'N' then 9 when promotion_art='PERSONAL' then 1 else case when promotion_art='CUSTOMER' or promotion_art='PAYBACK' then 2 else case when promotion_art='COMMON' then 3 else 4 end end end as stichlogik					   
      ,case when p.bonuskauf_id is not null and p.bonuskauf_id <> 0 and p.bonuskauf_id_lb is null then 1 else 0 end as bonus_flag
      ,case when p.smp_unique = 'Y' and z.aktion_id = '' then 'Z' else p.important end as important
      ,a.aktion_id as standard_aktion_id
      ,k.loyalty_berechtigt_fg
from dbp_ods.ods_bon_kopf_1 k
join (select mandant_id
            ,wup_id
            ,dat_booking
      from dbp_etl.kmo_artbew_bon_delta_1
      group by 1,2,3) d
  on k.mandant_id = d.mandant_id and 
     k.wup_id = d.wup_id and 
     k.dat_booking = d.dat_booking
join dbp_ods.ods_bon_retoure_1 z
  on k.mandant_id = z.mandant_id and 
     k.bon_id = z.bon_id and 
     k.wup_id = z.wup_id 
join dbp_ods.ods_bon_transaction_1 t
  on k.mandant_id = t.mandant_id and 
     k.bon_id = t.bon_id and 
     k.wup_id = t.wup_id 
left join dbp_data.aktion_art_wup_zu_1 a
  on z.aktion_id = a.aktion_id and 
     z.mandant_id = a.mandant_id and 
     z.wup_id = a.wup_id and 
     z.kl_art_id = a.art_id/10
left join dbp_data.art_wup_vk_per_1 vk_1
  on z.bon_dat between vk.dat_von and vk.dat_bis and 
     z.kl_art_id = vk.art_id/10 and 
     z.mandant_id = vk.mandant_id and 
     z.wup_id = vk.wup_id
left join dbp_data.bewart_det_ecommerce_1 bde
  on k.kundenkarte_id = bde.kundenkarte_id and 
     k.mandant_id = bde.mandant_id
left join (select op.bon_id, 
                  op.wup_id, 
                  op.mandant_id, 
                  op.bon_dat, 
                  op.kl_art_id, 
                  op.bon_zeile, 
                  op.bonuskauf_id, 
                  op.customer_promotion_fg,
                  op.promotion_art,
                  sum(op.betrag_promo_brutto) as betrag_promo_brutto,
                  case when op.konditionsart_id in ('ZRT3','ZTAG','ZGEB') then 'N' else 'Y' end as konditionsart_id,
                  case when op.konditionsart_id in ('ZBON','ZBOV') then 'N' else 'Y' end as important,
                  ab.aktion_typ_id aktion_typ_id,
                  ab.bonuskauf_id as bonuskauf_id_lb,
                  case when x.flag = 1 then 'Y' else 'N' end as bonrabatt_bewart,
                  case when y.flag = 1 then 'Y' else 'N' end as bonrabatt_bby,
                  case when z.flag = 1 then 'Y' else 'N' end as smp_unique
           from dbp_etl.bd_for_promotion_1 op
           left join _track_zbon_zbov_unique x
             on op.mandant_id = x.mandant_id and
                op.wup_id = x.wup_id and
                op.bon_id = x.bon_id and
                op.bon_zeile = x.bon_zeile and
                op.bon_dat = x.bon_dat
           left join _track_zbon_zbov y
             on op.mandant_id = y.mandant_id and
                op.wup_id = y.wup_id and
                op.bon_id = y.bon_id and
                op.bon_zeile = y.bon_zeile and
                op.promotion_lfd_nr = y.promotion_lfd_nr and
                op.bon_dat = y.bon_dat
           left join _track_zbon_zbov_unique_smp z
             on op.mandant_id = z.mandant_id and
                op.wup_id = z.wup_id and
                op.bon_id = z.bon_id and
                op.bon_zeile = z.bon_zeile and
                op.bon_dat = z.bon_dat
           left join (select b.mandant_id, 
                             b.bonuskauf_id, 
                             max(a.aktion_typ_id) aktion_typ_id 
                      from dbp_data.aktion_1 a
                      left join dbp_data.l_bonuskauf_1 b
                        on a.aktion_id = b.aktion_id and 
                           a.mandant_id = b.mandant_id
                      group by 1,2) ab
             on op.bonuskauf_id = ab.bonuskauf_id and 
                op.mandant_id = ab.mandant_id
           group by 1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17) p
  on k.bon_id = p.bon_id and 
     k.wup_id = p.wup_id and 
     k.mandant_id = p.mandant_id and 
     k.bon_dat = p.bon_dat and 
     z.kl_art_id = p.kl_art_id and 
     z.bon_zeile = p.bon_zeile
where k.mandant_id > 1 and 
      k.kunde_fg = 1 and 
      k.turnover_fg = 1 and
      k.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
      z.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
      t.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
     (case when k.kasse_typ_id <> 3 then 1 else 0 end) = 1 and 
     (k.bon_id, k.wup_id) not in (select bon_id,wup_id from dbp_ods.ods_bon_storno_1) and
      z.wg_id not in (822)
);

insert into dbp_etl.kmo_artbew_bon_1 (mandant_id
                                   ,bon_id
                                   ,dat_booking
                                   ,wup_id
                                   ,lkp_wrg
                                   ,kl_art_id
                                   ,ean_kasse
                                   ,bon_zeile
                                   ,menge
                                   ,umsatz_brutto
                                   ,wg_id
                                   ,aktion_id
                                   ,kundenkarte_id
                                   ,kundenkarte_typ_id
                                   ,bonuskauf_id
                                   ,aktion_typ_id
                                   ,vk_aktion_brutto
                                   ,vk_brutto
                                   ,betrag_promo_brutto_bby
                                   ,betrag_promo_brutto_kdn
                                   ,betrag_promo_brutto_kdp
                                   ,betrag_promo_brutto_null  
                                   ,konditionsart_id
                                   ,bonuskauf_id_lb
                                   ,bde_kundenkarte_id
                                   ,customer_promotion_fg
                                   ,promotion_art
                                   ,important
                                   ,standard_aktion_id
                                   ,loyalty_berechtigt_fg)
select temp.mandant_id
      ,temp.bon_id
      ,temp.dat_booking
      ,temp.wup_id
      ,temp.wrg_id
      ,temp.kl_art_id
      ,temp.ean_kasse
      ,temp.bon_zeile
      ,temp.menge_
      ,temp.umsatz_brutto_
      ,temp.wg_id
      ,temp.aktion_id
      ,temp.kundenkarte_id
      ,temp.kundenkarte_typ_id
      ,temp.bonuskauf_id
      ,temp.aktion_typ_id
      ,temp.vk_aktion_brutto
      ,temp.vk_brutto
      ,temp.betrag_promo_brutto_bby
      ,temp.betrag_promo_brutto_kdn
      ,temp.betrag_promo_brutto_kdp
      ,temp.betrag_promo_brutto_null
      ,temp.konditionsart_id
      ,temp.bonuskauf_id_lb
      ,temp.bde_kundenkarte_id
      ,temp.customer_promotion_fg
      ,case when temp.stichlogik=1 then 'PERSONAL' when temp.stichlogik=2 then 'CUSTOMER' when temp.stichlogik=3 then 'COMMON' when temp.stichlogik=99 then 'SMP' else '' end as promotion_art
      ,temp.important
      ,temp.standard_aktion_id
      ,temp.loyalty_berechtigt_fg
from (select p.mandant_id
            ,p.bon_id
            ,p.dat_booking
            ,p.wup_id
            ,p.wrg_id
            ,p.kl_art_id
            ,p.ean_kasse
            ,p.bon_zeile
            ,p.menge_
            ,p.umsatz_brutto_
            ,p.wg_id
            ,p.aktion_id
            ,p.standard_aktion_id
            ,p.kundenkarte_id
            ,p.kundenkarte_typ_id
            ,p.bonuskauf_id
            ,p.aktion_typ_id
            ,p.vk_aktion_brutto
            ,p.vk_brutto
            ,p.betrag_promo_brutto_bby
            ,p.betrag_promo_brutto_kdn
            ,p.betrag_promo_brutto_kdp
            ,p.betrag_promo_brutto_null
            ,p.konditionsart_id
            ,p.bonuskauf_id_lb					 
            ,p.bde_kundenkarte_id
            ,p.customer_promotion_fg
            ,p.stichlogik
            ,p.bonus_flag
            ,p.important
            ,p.loyalty_berechtigt_fg
            ,row_number() over(partition by p.mandant_id, p.bon_id, p.dat_booking, p.wup_id, p.bon_zeile, p.kl_art_id, p.ean_kasse
                               order by p.stichlogik, p.aktion_typ_id desc, p.konditionsart_id desc, p.bonuskauf_id, p.bonuskauf_id_lb, p.menge_) as rk
      from (select mandant_id
                  ,bon_id
                  ,dat_booking
                  ,wup_id
                  ,kl_art_id
                  ,ean_kasse
                  ,bon_zeile
                  ,menge_
                  ,umsatz_brutto_
                  ,wg_id
                  ,aktion_id
                  ,kundenkarte_id
                  ,kundenkarte_typ_id
                  ,max(case when stichlogik in (99,9) then null else bonuskauf_id end) as bonuskauf_id
                  ,max(case when stichlogik in (99,9) then null else aktion_typ_id_ end) as aktion_typ_id
                  ,vk_aktion_brutto
                  ,vk_brutto
                  ,sum(betrag_promo_brutto_bby) as betrag_promo_brutto_bby
                  ,sum(betrag_promo_brutto_kdn) as betrag_promo_brutto_kdn
                  ,sum(betrag_promo_brutto_kdp) as betrag_promo_brutto_kdp
                  ,sum(betrag_promo_brutto_null) as betrag_promo_brutto_null
                  ,konditionsart_id
                  ,max(case when stichlogik in (99,9) then null else bonuskauf_id_lb end) as bonuskauf_id_lb
                  ,bde_kundenkarte_id
                  ,max(case when stichlogik in (99,9) then null else customer_promotion_fg end) as customer_promotion_fg
                  ,min(stichlogik) as stichlogik
                  ,bonus_flag
                  ,wrg_id
                  ,max(case when stichlogik in (99) then null else important end) as important
                  ,coalesce(standard_aktion_id,'') as standard_aktion_id
                  ,loyalty_berechtigt_fg
            from (select *
                  from _zwischen1_1) x
            where to_number(ean_kasse) is not null
            group by all) p) temp
where temp.rk = 1
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
from dbp_etl.bd_for_promotion_1 a
join (select mandant_id,
             bon_id,
             bon_zeile,
             bon_dat,
             wup_id,
             count(distinct promotion_art) as anz,
             max(case when konditionsart_id in ('ZBON','ZBOV') then 1 else 0 end) as bonrabatt
      from dbp_etl.bd_for_promotion_1
      where konditionsart_id not in ('ZRT3','ZTAG','ZGEB')
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
                                                                 from dbp_etl.bd_for_promotion_1
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
from dbp_etl.bd_for_promotion_1
where (mandant_id,bon_id,bon_zeile,bon_dat,wup_id) in (select mandant_id,
                                                              bon_id,
                                                              bon_zeile,
                                                              bon_dat,
                                                              wup_id
                                                       from dbp_etl.bd_for_promotion_1
                                                       where promotion_art = 'PERSONAL'
                                                       group by 1,2,3,4,5) and
       konditionsart_id not in ('ZRT3','ZTAG','ZGEB')
group by 1,2,3,4,5
);

create or replace transient table _zwischen2 as (
select k.mandant_id
      ,k.bon_id
      ,k.dat_booking
      ,k.wup_id
      ,k.wrg_id 
      ,z.kl_art_id
      ,coalesce(case 
                  when trim(z.barcode_string) = '' then coalesce(z.ean_kasse,0)
                  when length(z.barcode_string) > 26 then -9999
                  when try_to_number(z.barcode_string) is null then -9999
                  else cast(z.barcode_string as bigint)
                end,coalesce(z.ean_kasse,0)) as ean_kasse
      ,z.bon_zeile
      ,case 
         when k.kunde_fg = 0 then z.menge * (-1) else z.menge 
       end as menge_
      ,case 
         when k.kunde_fg = 0 then z.umsatz_brutto * (-1) else z.umsatz_brutto
       end as umsatz_brutto_
      ,z.wg_id 
      ,z.aktion_id
      ,k.kundenkarte_id
      ,k.kundenkarte_typ_id
      ,p.bonuskauf_id
      ,case 
         when trim(p.bonrabatt_bewart) in ('Y') and trim(z.aktion_id) = '' then 'KDB'
         when trim(p.aktion_typ_id) in ('KDP') then 'KDP' 
         when trim(p.aktion_typ_id) in ('KPB','KDN') then 'KDN'
         else 'KDA' 
       end as aktion_typ_id_
      ,a.vk_aktion_brutto
      ,vk.vk_brutto
      ,case 
         when customer_promotion_fg = 0 and ((trim(p.bonrabatt_bewart) in ('Y') and aktion_typ_id_ = 'KDB') or trim(p.bonrabatt_bby) in ('Y')) then p.betrag_promo_brutto
         when customer_promotion_fg = 1 and promotion_art in ('CUSTOMER') and trim(p.aktion_typ_id) in ('KPB','KDN','KDP','KDB') and trim(p.bonrabatt_bby) in ('Y') and bde.kundenkarte_id is null then p.betrag_promo_brutto
         when trim(p.aktion_typ_id) in ('KPB','KDN','KDP','KDB') and trim(promotion_art) in ('COMMON','PERSONAL') and trim(p.bonrabatt_bby) in ('Y') then p.betrag_promo_brutto
         else null
       end as betrag_promo_brutto_bby
      ,case 
         when customer_promotion_fg = 1 and promotion_art = 'CUSTOMER' and trim(p.aktion_typ_id) in ('KDN') and trim(p.bonrabatt_bby) in ('Y') and bde.kundenkarte_id is null and important = 'N' then null
         when trim(p.aktion_typ_id) in ('KPB', 'KDN') and important='Y' then p.betrag_promo_brutto 
         else null
       end as betrag_promo_brutto_kdn
      ,case when trim(p.aktion_typ_id) = 'KDP' and bonrabatt_bby='N' then p.betrag_promo_brutto else null end as betrag_promo_brutto_kdp
      ,case when (trim(p.aktion_typ_id) is null or trim(p.aktion_typ_id) = '') and aktion_typ_id_ <> 'KDB' and trim(p.bonrabatt_bby) in ('N') then p.betrag_promo_brutto else null end as betrag_promo_brutto_null
      ,p.konditionsart_id
      ,p.bonuskauf_id_lb 
      ,bde.kundenkarte_id AS bde_kundenkarte_id	
      ,p.customer_promotion_fg
      ,case when p.personal = 'Y' and z.wg_id = 822 then 100 when promotion_art = 'PERSONAL_SMP' then 99 when important = 'N' and bonrabatt_bewart = 'N' then 9 when promotion_art='PERSONAL' then 1 else case when promotion_art='CUSTOMER' or promotion_art='PAYBACK' then 2 else case when promotion_art='COMMON' then 3 else 4 end end end as stichlogik					   
      ,case when p.bonuskauf_id is not null and p.bonuskauf_id <> 0 and p.bonuskauf_id_lb is null then 1 else 0 end as bonus_flag
      ,case when p.smp_unique = 'Y' and z.aktion_id = '' then 'A' when p.personal_unique = 'Y' and z.aktion_id = '' then 'B' when p.personal = 'Y' then 'C' else p.important end as important
      ,a.aktion_id as standard_aktion_id
      ,k.loyalty_berechtigt_fg
from dbp_ods.ods_bon_kopf_1 k
join (select mandant_id
            ,wup_id
            ,dat_booking
      from dbp_etl.kmo_artbew_bon_delta_1
      group by 1,2,3) d
  on k.mandant_id = d.mandant_id and 
     k.wup_id = d.wup_id and 
     k.dat_booking = d.dat_booking
join dbp_ods.ods_bon_verkauf_1 z
  on k.mandant_id = z.mandant_id and 
     k.bon_id = z.bon_id and 
     k.wup_id = z.wup_id 
join dbp_ods.ods_bon_transaction_1 t
  on k.mandant_id = t.mandant_id and 
     k.bon_id = t.bon_id and 
     k.wup_id = t.wup_id 
left join dbp_data.aktion_art_wup_zu_1 a
  on z.aktion_id = a.aktion_id and 
     z.mandant_id = a.mandant_id and 
     z.wup_id = a.wup_id and 
     z.kl_art_id = a.art_id/10
left join dbp_data.art_wup_vk_per_1 vk_1
  on z.bon_dat between vk.dat_von and vk.dat_bis and 
     z.kl_art_id = vk.art_id/10 and 
     z.mandant_id = vk.mandant_id and 
     z.wup_id = vk.wup_id
left join dbp_data.bewart_det_ecommerce_1 bde
  on k.kundenkarte_id = bde.kundenkarte_id and 
     k.mandant_id = bde.mandant_id
left join (select op.bon_id, 
                  op.wup_id, 
                  op.mandant_id, 
                  op.bon_dat, 
                  op.kl_art_id, 
                  op.bon_zeile, 
                  op.bonuskauf_id, 
                  op.customer_promotion_fg,
                  op.promotion_art,
                  sum(op.betrag_promo_brutto) as betrag_promo_brutto,
                  case when op.konditionsart_id in ('ZRT3','ZTAG','ZGEB') then 'N' else 'Y' end as konditionsart_id,
                  case when op.konditionsart_id in ('ZBON','ZBOV') then 'N' else 'Y' end as important,
                  ab.aktion_typ_id aktion_typ_id,
                  ab.bonuskauf_id as bonuskauf_id_lb,
                  case when x.flag = 1 then 'Y' else 'N' end as bonrabatt_bewart,
                  case when y.flag = 1 and aktion_typ_id <> '' then 'Y' else 'N' end as bonrabatt_bby,
                  case when z.flag = 1 then 'Y' else 'N' end as smp_unique,
                  case when w.flag = 1 then 'Y' else 'N' end as personal_unique,
                  case when u.flag = 1 then 'Y' else 'N' end as personal
           from dbp_etl.bd_for_promotion_1 op
           left join _track_zbon_zbov_unique x
             on op.mandant_id = x.mandant_id and
                op.wup_id = x.wup_id and
                op.bon_id = x.bon_id and
                op.bon_zeile = x.bon_zeile and
                op.bon_dat = x.bon_dat
           left join _track_zbon_zbov y
             on op.mandant_id = y.mandant_id and
                op.wup_id = y.wup_id and
                op.bon_id = y.bon_id and
                op.bon_zeile = y.bon_zeile and
                op.promotion_lfd_nr = y.promotion_lfd_nr and
                op.bon_dat = y.bon_dat
           left join _track_zbon_zbov_unique_smp z
             on op.mandant_id = z.mandant_id and
                op.wup_id = z.wup_id and
                op.bon_id = z.bon_id and
                op.bon_zeile = z.bon_zeile and
                op.bon_dat = z.bon_dat
           left join _track_zbon_zbov_unique_personal w
             on op.mandant_id = w.mandant_id and
                op.wup_id = w.wup_id and
                op.bon_id = w.bon_id and
                op.bon_zeile = w.bon_zeile and
                op.bon_dat = w.bon_dat
           left join _track_zbon_zbov_personal u
             on op.mandant_id = u.mandant_id and
                op.wup_id = u.wup_id and
                op.bon_id = u.bon_id and
                op.bon_zeile = u.bon_zeile and
                op.bon_dat = u.bon_dat
           left join (select b.mandant_id, 
                             b.bonuskauf_id, 
                             max(a.aktion_typ_id) aktion_typ_id 
                      from dbp_data.aktion_1 a
                      left join dbp_data.l_bonuskauf_1 b
                        on a.aktion_id = b.aktion_id and 
                           a.mandant_id = b.mandant_id
                      group by 1,2) ab
             on op.bonuskauf_id = ab.bonuskauf_id and 
                op.mandant_id = ab.mandant_id
           group by 1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19) p
  on k.bon_id = p.bon_id and 
     k.wup_id = p.wup_id and 
     k.mandant_id = p.mandant_id and 
     k.bon_dat = p.bon_dat and 
     z.kl_art_id = p.kl_art_id and 
     z.bon_zeile = p.bon_zeile
where k.mandant_id > 1 and 
      k.kunde_fg = 1 and 
      k.turnover_fg = 1 and
      k.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
      z.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
      t.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
     (case when k.kasse_typ_id <> 3 then 1 else 0 end ) = 1 and 
     (k.bon_id, k.wup_id) not in (select bon_id, wup_id from dbp_ods.ods_bon_storno_1) and
      z.wg_id in (822)
union
select k.mandant_id
      ,k.bon_id
      ,k.dat_booking
      ,k.wup_id
      ,k.wrg_id 
      ,z.kl_art_id
      ,coalesce(case 
                  when trim(z.barcode_string) = '' then coalesce(z.ean_kasse,0)
                  when length(z.barcode_string) > 26 then -9999
                  when try_to_number(z.barcode_string) is null then -9999
                  else cast(z.barcode_string as bigint)
                end,coalesce(z.ean_kasse,0)) as ean_kasse
      ,z.bon_zeile
      ,case when k.kunde_fg = 0 then z.menge * (-1)
            else z.menge
       end * z.menge_fg as menge_
      ,case when k.kunde_fg = 0 then z.umsatz_brutto * (-1)
            else z.umsatz_brutto
       end as umsatz_brutto_
      ,z.wg_id 
      ,z.aktion_id
      ,k.kundenkarte_id
      ,k.kundenkarte_typ_id
      ,p.bonuskauf_id
      ,case when trim(p.bonrabatt_bewart) in ('Y') and trim(z.aktion_id) = '' then 'KDB'
            when trim(p.aktion_typ_id) in ('KDP') then 'KDP' 
            when trim(p.aktion_typ_id) in ('KPB','KDN') then 'KDN'
            else 'KDA' 
       end as aktion_typ_id_
      ,a.vk_aktion_brutto
      ,vk.vk_brutto
      ,case 
         when customer_promotion_fg = 0 and ((trim(p.bonrabatt_bewart) in ('Y') and aktion_typ_id_ = 'KDB') or trim(p.bonrabatt_bby) in ('Y')) then p.betrag_promo_brutto
         when customer_promotion_fg = 1 and promotion_art in ('CUSTOMER') and trim(p.aktion_typ_id) in ('KPB','KDN','KDP','KDB') and trim(p.bonrabatt_bby) in ('Y') and bde.kundenkarte_id is null then p.betrag_promo_brutto
         when trim(p.aktion_typ_id) in ('KPB','KDN','KDP','KDB') and trim(promotion_art) in ('COMMON','PERSONAL') and trim(p.bonrabatt_bby) in ('Y') then p.betrag_promo_brutto
         else null
       end as betrag_promo_brutto_bby
      ,case 
         when customer_promotion_fg = 1 and promotion_art = 'CUSTOMER' and trim(p.aktion_typ_id) in ('KDN') and trim(p.bonrabatt_bby) in ('Y') and bde.kundenkarte_id is null then null
         when trim(p.aktion_typ_id) in ('KPB', 'KDN') and important='Y' then p.betrag_promo_brutto 
         else null 
       end as betrag_promo_brutto_kdn
      ,case when trim(p.aktion_typ_id) = 'KDP' and bonrabatt_bby='N' then p.betrag_promo_brutto else null end as betrag_promo_brutto_kdp
      ,case when trim(p.aktion_typ_id) is null and aktion_typ_id_ <> 'KDB' and trim(p.bonrabatt_bby) in ('N') then p.betrag_promo_brutto else null end as betrag_promo_brutto_null
      ,p.konditionsart_id
      ,p.bonuskauf_id_lb 
      ,bde.kundenkarte_id AS bde_kundenkarte_id	
      ,p.customer_promotion_fg
      ,case when p.personal = 'Y' and z.wg_id = 822 then 100 when promotion_art = 'PERSONAL_SMP' then 99 when important = 'N' and bonrabatt_bewart = 'N' then 9 when promotion_art='PERSONAL' then 1 else case when promotion_art='CUSTOMER' or promotion_art='PAYBACK' then 2 else case when promotion_art='COMMON' then 3 else 4 end end end as stichlogik					   
      ,case when p.bonuskauf_id is not null and p.bonuskauf_id <> 0 and p.bonuskauf_id_lb is null then 1 else 0 end as bonus_flag
      ,case when p.smp_unique = 'Y' and z.aktion_id = '' then 'A' when p.personal_unique = 'Y' and z.aktion_id = '' then 'B' when p.personal = 'Y' then 'C' else p.important end as important
      ,a.aktion_id as standard_aktion_id
      ,k.loyalty_berechtigt_fg
from dbp_ods.ods_bon_kopf_1 k
join (select mandant_id
            ,wup_id
            ,dat_booking
      from dbp_etl.kmo_artbew_bon_delta_1
      group by 1,2,3) d
  on k.mandant_id = d.mandant_id and 
     k.wup_id = d.wup_id and 
     k.dat_booking = d.dat_booking
join dbp_ods.ods_bon_retoure_1 z
  on k.mandant_id = z.mandant_id and 
     k.bon_id = z.bon_id and 
     k.wup_id = z.wup_id 
join dbp_ods.ods_bon_transaction_1 t
  on k.mandant_id = t.mandant_id and 
     k.bon_id = t.bon_id and 
     k.wup_id = t.wup_id 
left join dbp_data.aktion_art_wup_zu_1 a
  on z.aktion_id = a.aktion_id and 
     z.mandant_id = a.mandant_id and 
     z.wup_id = a.wup_id and 
     z.kl_art_id = a.art_id/10
left join dbp_data.art_wup_vk_per_1 vk_1
  on z.bon_dat between vk.dat_von and vk.dat_bis and 
     z.kl_art_id = vk.art_id/10 and 
     z.mandant_id = vk.mandant_id and 
     z.wup_id = vk.wup_id
left join dbp_data.bewart_det_ecommerce_1 bde
  on k.kundenkarte_id = bde.kundenkarte_id and 
     k.mandant_id = bde.mandant_id
left join (select op.bon_id, 
                  op.wup_id, 
                  op.mandant_id, 
                  op.bon_dat, 
                  op.kl_art_id, 
                  op.bon_zeile, 
                  op.bonuskauf_id, 
                  op.customer_promotion_fg,
                  op.promotion_art,
                  sum(op.betrag_promo_brutto) as betrag_promo_brutto,
                  case when op.konditionsart_id in ('ZRT3','ZTAG','ZGEB') then 'N' else 'Y' end as konditionsart_id,
                  case when op.konditionsart_id in ('ZBON','ZBOV') then 'N' else 'Y' end as important,
                  ab.aktion_typ_id aktion_typ_id,
                  ab.bonuskauf_id as bonuskauf_id_lb,
                  case when x.flag = 1 then 'Y' else 'N' end as bonrabatt_bewart,
                  case when y.flag = 1 then 'Y' else 'N' end as bonrabatt_bby,
                  case when z.flag = 1 then 'Y' else 'N' end as smp_unique,
                  case when w.flag = 1 then 'Y' else 'N' end as personal_unique,
                  case when u.flag = 1 then 'Y' else 'N' end as personal
           from dbp_etl.bd_for_promotion_1 op
           left join _track_zbon_zbov_unique x
             on op.mandant_id = x.mandant_id and
                op.wup_id = x.wup_id and
                op.bon_id = x.bon_id and
                op.bon_zeile = x.bon_zeile and
                op.bon_dat = x.bon_dat
           left join _track_zbon_zbov y
             on op.mandant_id = y.mandant_id and
                op.wup_id = y.wup_id and
                op.bon_id = y.bon_id and
                op.bon_zeile = y.bon_zeile and
                op.promotion_lfd_nr = y.promotion_lfd_nr and
                op.bon_dat = y.bon_dat
           left join _track_zbon_zbov_unique_smp z
             on op.mandant_id = z.mandant_id and
                op.wup_id = z.wup_id and
                op.bon_id = z.bon_id and
                op.bon_zeile = z.bon_zeile and
                op.bon_dat = z.bon_dat
           left join _track_zbon_zbov_unique_personal w
             on op.mandant_id = w.mandant_id and
                op.wup_id = w.wup_id and
                op.bon_id = w.bon_id and
                op.bon_zeile = w.bon_zeile and
                op.bon_dat = w.bon_dat
           left join _track_zbon_zbov_personal u
             on op.mandant_id = u.mandant_id and
                op.wup_id = u.wup_id and
                op.bon_id = u.bon_id and
                op.bon_zeile = u.bon_zeile and
                op.bon_dat = u.bon_dat
           left join (select b.mandant_id, 
                             b.bonuskauf_id, 
                             max(a.aktion_typ_id) aktion_typ_id 
                      from dbp_data.aktion_1 a
                      left join dbp_data.l_bonuskauf_1 b
                        on a.aktion_id = b.aktion_id and 
                           a.mandant_id = b.mandant_id
                      group by 1,2) ab
             on op.bonuskauf_id = ab.bonuskauf_id and 
                op.mandant_id = ab.mandant_id
           group by 1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19) p
  on k.bon_id = p.bon_id and 
     k.wup_id = p.wup_id and 
     k.mandant_id = p.mandant_id and 
     k.bon_dat = p.bon_dat and 
     z.kl_art_id = p.kl_art_id and 
     z.bon_zeile = p.bon_zeile
where k.mandant_id > 1 and 
      k.kunde_fg = 1 and 
      k.turnover_fg = 1 and
      k.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
      z.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
      t.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and 
     (case when k.kasse_typ_id <> 3 then 1 else 0 end) = 1 and 
     (k.bon_id, k.wup_id) not in (select bon_id,wup_id from dbp_ods.ods_bon_storno_1) and
      z.wg_id in (822)
);

insert into dbp_etl.kmo_artbew_bon_1 (mandant_id
                                   ,bon_id
                                   ,dat_booking
                                   ,wup_id
                                   ,lkp_wrg
                                   ,kl_art_id
                                   ,ean_kasse
                                   ,bon_zeile
                                   ,menge
                                   ,umsatz_brutto
                                   ,wg_id
                                   ,aktion_id
                                   ,kundenkarte_id
                                   ,kundenkarte_typ_id
                                   ,bonuskauf_id
                                   ,aktion_typ_id
                                   ,vk_aktion_brutto
                                   ,vk_brutto
                                   ,betrag_promo_brutto_bby
                                   ,betrag_promo_brutto_kdn
                                   ,betrag_promo_brutto_kdp
                                   ,betrag_promo_brutto_null  
                                   ,konditionsart_id
                                   ,bonuskauf_id_lb
                                   ,bde_kundenkarte_id
                                   ,customer_promotion_fg
                                   ,promotion_art
                                   ,important
                                   ,standard_aktion_id
                                   ,loyalty_berechtigt_fg)
select temp.mandant_id
      ,temp.bon_id
      ,temp.dat_booking
      ,temp.wup_id
      ,temp.wrg_id
      ,temp.kl_art_id
      ,temp.ean_kasse
      ,temp.bon_zeile
      ,temp.menge_
      ,temp.umsatz_brutto_
      ,temp.wg_id
      ,temp.aktion_id
      ,temp.kundenkarte_id
      ,temp.kundenkarte_typ_id
      ,temp.bonuskauf_id
      ,temp.aktion_typ_id
      ,temp.vk_aktion_brutto
      ,temp.vk_brutto
      ,temp.betrag_promo_brutto_bby
      ,temp.betrag_promo_brutto_kdn
      ,temp.betrag_promo_brutto_kdp
      ,temp.betrag_promo_brutto_null
      ,temp.konditionsart_id
      ,temp.bonuskauf_id_lb
      ,temp.bde_kundenkarte_id
      ,temp.customer_promotion_fg
      ,case when temp.stichlogik=1 then 'PERSONAL' when temp.stichlogik=2 then 'CUSTOMER' when temp.stichlogik=3 then 'COMMON' when temp.stichlogik=99 then 'SMP' else '' end as promotion_art
      ,temp.important
      ,temp.standard_aktion_id
      ,temp.loyalty_berechtigt_fg
from (select p.mandant_id
            ,p.bon_id
            ,p.dat_booking
            ,p.wup_id
            ,p.wrg_id
            ,p.kl_art_id
            ,p.ean_kasse
            ,p.bon_zeile
            ,p.menge_
            ,p.umsatz_brutto_
            ,p.wg_id
            ,p.aktion_id
            ,p.standard_aktion_id
            ,p.kundenkarte_id
            ,p.kundenkarte_typ_id
            ,p.loyalty_berechtigt_fg
            ,p.bonuskauf_id
            ,p.aktion_typ_id
            ,p.vk_aktion_brutto
            ,p.vk_brutto
            ,p.betrag_promo_brutto_bby
            ,p.betrag_promo_brutto_kdn
            ,p.betrag_promo_brutto_kdp
            ,p.betrag_promo_brutto_null
            ,p.konditionsart_id
            ,p.bonuskauf_id_lb					 
            ,p.bde_kundenkarte_id
            ,p.customer_promotion_fg
            ,p.stichlogik
            ,p.bonus_flag
            ,p.important
            ,row_number() over(partition by p.mandant_id, p.bon_id, p.dat_booking, p.wup_id, p.bon_zeile, p.kl_art_id, p.ean_kasse
                               order by p.stichlogik, p.aktion_typ_id desc, p.konditionsart_id desc, p.bonuskauf_id, p.bonuskauf_id_lb, p.menge_) as rk
      from (select mandant_id
                  ,bon_id
                  ,dat_booking
                  ,wup_id
                  ,kl_art_id
                  ,ean_kasse
                  ,bon_zeile
                  ,menge_
                  ,umsatz_brutto_
                  ,wg_id
                  ,aktion_id
                  ,kundenkarte_id
                  ,kundenkarte_typ_id
                  ,max(case when stichlogik in (99,9) then null else bonuskauf_id end) as bonuskauf_id
                  ,max(case when stichlogik in (99,9) then null else aktion_typ_id_ end) as aktion_typ_id
                  ,vk_aktion_brutto
                  ,vk_brutto
                  ,sum(betrag_promo_brutto_bby) as betrag_promo_brutto_bby
                  ,sum(betrag_promo_brutto_kdn) as betrag_promo_brutto_kdn
                  ,sum(betrag_promo_brutto_kdp) as betrag_promo_brutto_kdp
                  ,sum(betrag_promo_brutto_null) as betrag_promo_brutto_null
                  ,konditionsart_id
                  ,max(case when stichlogik in (99,9) then null else bonuskauf_id_lb end) as bonuskauf_id_lb
                  ,bde_kundenkarte_id
                  ,max(case when stichlogik in (99,9) then null else customer_promotion_fg end) as customer_promotion_fg
                  ,min(stichlogik) as stichlogik
                  ,bonus_flag
                  ,wrg_id
                  ,max(case when stichlogik in (99) then null else important end) as important
                  ,coalesce(standard_aktion_id,'') as standard_aktion_id
                  ,loyalty_berechtigt_fg
            from (select *
                  from _zwischen2) x
            where to_number(ean_kasse) is not null
            group by all) p) temp
where temp.rk = 1
;

insert into dbp_etl_process.artbew_bon_empties_1 (mandant_id,
                                                wup_id,
                                                td_insert,
                                                td_update)
select a.mandant_id,
       a.wup_id,
       current_timestamp as td_insert,
       current_timestamp as td_update
from dbp_ods.ods_bon_leergut_1 a
join dbp_ods.ods_bon_zahlung_1 b
  on a.mandant_id = b.mandant_id and
     a.barcode_leergut = b.barcode_leergut and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat
join dbp_ods.ods_bon_transaction_1 c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.bon_dat = c.bon_dat and
     c.transaction_name = 'RetailTransaction' and
     a.barcode_leergut is not null and
     trim(a.barcode_leergut) <> ''
where b.kpos_zahlung_typ_id = 'BBN' and
      a.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and
     (a.mandant_id,a.wup_id) not in (select mandant_id,wup_id from dbp_etl_process.artbew_bon_empties_1)
group by 1,2
;

create or replace volatile table _track_empties as (
select a.*
from dbp_ods.ods_bon_leergut_1 a
join (select mandant_id
            ,wup_id
            ,dat_booking
      from dbp_etl.kmo_artbew_bon_delta_1 
      group by 1,2,3) d
  on a.mandant_id = d.mandant_id and 
     a.wup_id = d.wup_id and 
     a.bon_dat = d.dat_booking
where a.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and
     (a.mandant_id,a.wup_id) in (select mandant_id,wup_id from dbp_etl_process.artbew_bon_empties_1) and
      a.barcode_leergut is not null
);

create or replace volatile table _leergut as (
select a.mandant_id
      ,a.bon_id
      ,a.bon_dat as dat_booking
      ,a.wup_id
      ,a.kl_art_id
      ,a.ean_kasse
      ,9999 as bon_zeile
      ,sum(case 
             when b.kunde_fg = 0
             then a.menge
             else a.menge * (-1)
           end) as menge
      ,sum(case
             when b.kunde_fg = 0
             then a.umsatz_brutto * (-1)
             else a.umsatz_brutto
           end) as umsatz_brutto
      ,b.wrg_id
      ,999 as wg_id
      ,'' as aktion_id
      ,b.kundenkarte_id
      ,b.kundenkarte_typ_id
      ,null as bonuskauf_id
      ,null as aktion_typ_id
      ,null as konditionsart_id
      ,0 as vk_aktion_brutto
      ,0 as vk_brutto
      ,0 as betrag_promo_brutto_kdn
      ,0 as betrag_promo_brutto_kdp
      ,0 as betrag_promo_brutto_null
      ,null as bonuskauf_id_lb
      ,null as bde_kundenkarte_id
      ,0 as customer_promotion_fg
      ,'' as promotion_art
      ,null as important
      ,b.loyalty_berechtigt_fg
from _track_empties a
join dbp_ods.ods_bon_kopf_1 b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_id = b.bon_id and
     a.bon_dat = b.bon_dat
join dbp_data.mandant_1 c
  on a.mandant_id = c.mandant_id
group by all
);


insert into dbp_etl.kmo_artbew_bon_1 (mandant_id
                                   ,bon_id
                                   ,dat_booking
                                   ,wup_id
                                   ,lkp_wrg
                                   ,kl_art_id
                                   ,ean_kasse
                                   ,bon_zeile
                                   ,menge
                                   ,umsatz_brutto
                                   ,wg_id
                                   ,aktion_id
                                   ,kundenkarte_id
                                   ,kundenkarte_typ_id
                                   ,bonuskauf_id
                                   ,aktion_typ_id
                                   ,vk_aktion_brutto
                                   ,vk_brutto
                                   ,betrag_promo_brutto_kdn
                                   ,betrag_promo_brutto_kdp
                                   ,betrag_promo_brutto_null  
                                   ,konditionsart_id
                                   ,bonuskauf_id_lb
                                   ,bde_kundenkarte_id
                                   ,customer_promotion_fg
                                   ,promotion_art
                                   ,important
                                   ,standard_aktion_id
                                   ,loyalty_berechtigt_fg)
select mandant_id
      ,bon_id
      ,dat_booking
      ,wup_id
      ,wrg_id
      ,kl_art_id
      ,coalesce(ean_kasse,0) as ean_kasse
      ,bon_zeile
      ,menge
      ,umsatz_brutto
      ,wg_id
      ,aktion_id
      ,kundenkarte_id
      ,kundenkarte_typ_id
      ,bonuskauf_id
      ,aktion_typ_id
      ,vk_aktion_brutto
      ,vk_brutto
      ,betrag_promo_brutto_kdn
      ,betrag_promo_brutto_kdp
      ,betrag_promo_brutto_null  
      ,konditionsart_id
      ,bonuskauf_id_lb
      ,bde_kundenkarte_id
      ,customer_promotion_fg
      ,promotion_art
      ,important
      ,'' as standard_aktion_id
      ,loyalty_berechtigt_fg
from _leergut
;

update dbp_etl.kmo_artbew_bon_1
from dbp_data.wup_1 w

set lkp_nb_id = w.nb_id

where dbp_etl.kmo_artbew_bon.mandant_id = w.mandant_id
  and dbp_etl.kmo_artbew_bon.wup_id = w.wup_id
;

update dbp_etl.kmo_artbew_bon_1

set lkp_art_id = dt.art_id
  , lkp_zek_id = dt.zek_id
  , lkp_mwst_id = dt.mwst_id 
  , lkp_posten_id = dt.posten_id 

from (select mandant_id
            ,kl_art_id
            ,art_id
            ,zek_id
            ,mwst_id
            ,posten_id 
      from dbp_data.art_1 a
      qualify row_number() over (partition by mandant_id, kl_art_id order by art_id desc) = 1) dt 

where dbp_etl.kmo_artbew_bon.mandant_id = dt.mandant_id and 
     dbp_etl.kmo_artbew_bon.kl_art_id = dt.kl_art_id
;

-- 27.06.2022, dbay: spec0157445, historical tracking of tax ids
create or replace volatile table _tage as (
select dat_booking
from dbp_etl.kmo_artbew_bon_1
group by 1
);

create or replace volatile table _min_tage as (
select min(dat_booking) as min_dat_booking
from dbp_etl.kmo_artbew_bon_1
);

create or replace volatile table _art_per as (
select a.*,
       b.dat_booking
from (select a.*
      from dbp_data.art_per_1 a
      join _min_tage b
        on a.dat_bis >= b.min_dat_booking) a
join _tage b
  on b.dat_booking BETWEEN a.dat_von AND a.dat_bis
);

update dbp_etl.kmo_artbew_bon_1 from (select *
                                    from _art_per) b

set lkp_mwst_id = b.mwst_id,
    lkp_posten_id = b.posten_id

where dbp_etl.kmo_artbew_bon.dat_booking = b.dat_booking and
      dbp_etl.kmo_artbew_bon.mandant_id = b.mandant_id and
      dbp_etl.kmo_artbew_bon.lkp_art_id = b.art_id
;

update dbp_etl.kmo_artbew_bon_1
from dbp_data.art_wg_zu_per_1 w

set lkp_wg_id = w.wg_id
  , lkp_arthiertyp_id = w.arthiertyp_id

where dbp_etl.kmo_artbew_bon.mandant_id = w.mandant_id
  and dbp_etl.kmo_artbew_bon.lkp_art_id = w.art_id
  and w.dat_bis = to_date('9999-12-31','yyyy-mm_1-dd')
  and w.arthiertyp_id = 2
;

-- 30.09.2022, -dbay-
--
-- Two updates are taking place for enrichment of countries switching to EUR
-- as new currency.

-- 1. setting the default currency for all rows.

update dbp_etl.kmo_artbew_bon_1
from dbp_data.kurs_1 k

set lkp_umrechnungskurs = k.umrechnungskurs 

where dbp_etl.kmo_artbew_bon.lkp_wrg = k.von_wrg_id 
  --and dbp_etl.kmo_artbew_bon.dat_booking between k.dat_von and k.dat_bis 
  and k.dat_bis = '9999-12-31'
  and k.kurstyp_id = 3
  and k.nach_wrg_id = 'EUR'
;

-- 2. here is the specific update for our currency changes.

update dbp_etl.kmo_artbew_bon_1 from (select *
                                    from dbp_data.mandant_wrg_zu_per_1
                                    where current_date between dat_von and dat_bis and
                                          von_wrg_id is not null) b

set lkp_wrg = b.wrg_id,
    lkp_umrechnungskurs = cast(1 as float)/cast(b.umrechnungskurs as float)
    
where dbp_etl.kmo_artbew_bon.mandant_id = b.mandant_id and
      dbp_etl.kmo_artbew_bon.lkp_wrg = b.von_wrg_id
;

update dbp_etl.kmo_artbew_bon_1 
from dbp_data.mwst_per_1 m

set lkp_mwst = m.mwst

where dbp_etl.kmo_artbew_bon.mandant_id = m.mandant_id
  and dbp_etl.kmo_artbew_bon.lkp_mwst_id = m.mwst_id
  and dbp_etl.kmo_artbew_bon.dat_booking between m.dat_von and m.dat_bis
;

delete from dbp_etl.kmo_artbew_bon_1
where lkp_art_id is null  
   or lkp_arthiertyp_id is null 
   or lkp_mwst is null 
   or lkp_mwst_id is null 
   or lkp_nb_id is null 
   or lkp_posten_id is null 
   or lkp_umrechnungskurs is null 
   or lkp_wg_id is null 
   or lkp_wrg is null 
   or lkp_zek_id is null
;

insert into dbp_etl.kmo_artbew_bon_dat_1 (dat)
select dat_booking
from dbp_etl.kmo_artbew_bon_1
group by dat_booking
;

delete from dbp_etl.kmo_artbew_bon_1
where dat_booking > current_date-1
;

insert into dbp_etl.kmo_artbew_bon_promotion_1 (mandant_id
                                             ,bon_id
                                             ,dat_booking
                                             ,kl_art_id
                                             ,bon_zeile
                                             ,bonuskauf_id
                                             ,konditionsart_id
                                             ,umsatz_brutto
                                             ,umsatz_promo_brutto
                                             ,menge_promo)
select k.mandant_id
      ,k.bon_id
      ,k.dat_booking
      ,k.kl_art_id
      ,k.bon_zeile
      ,p.bonuskauf_id
      ,p.konditionsart_id
      ,sum(p.betrag_promo_brutto * (-1)) as umsatz_brutto
      ,sum(p.umsatz_promo_brutto) as umsatz_promo_brutto
      ,sum(p.menge_promo) as menge_promo
from dbp_etl.kmo_artbew_bon_1 k
join dbp_ods.ods_promotion_1 p
  on k.mandant_id = p.mandant_id and 
     k.bon_id = p.bon_id and 
     k.bon_zeile = p.bon_zeile and p.wup_id >= 1000 and p.wup_id <= 9999 and 
     p.kl_art_id is not null
-- 09.01.2023, -dbay-
-- filter killed due to interferences regarding loyalty.
-- where coalesce(p.betrag_promo_brutto, 0) <> 0
group by 1,2,3,4,5,6,7
;

-- zmp-einschub, 12.03.2026, -dbay-

alter table dbp_etl.kmo_artbew_bon_1 add bewart_det_id_zmp integer
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
                                                                       mandant_id > 1
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
            where a.mandant_id > 1 and
                  a.konditionsart_id not in ('ZRT3','ZK03') and
                  a.konditionsart_id = 'ZMP'
            group by all) b
        on a.mandant_id = b.mandant_id and
           a.wup_id = b.wup_id and
           a.bon_dat = b.bon_dat and
           a.bon_id = b.bon_id and
           a.bon_zeile = b.bon_zeile
      where a.mandant_id > 1 and
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
      where a.mandant_id > 1
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
      where a.mandant_id > 1
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
            where a.mandant_id > 1 and
                  a.konditionsart_id = 'ZMP'
            group by all) b
        on a.mandant_id = b.mandant_id and
           a.wup_id = b.wup_id and
           a.bon_dat = b.bon_dat and
           a.bon_id = b.bon_id and
           a.bon_zeile = b.bon_zeile
      where a.mandant_id > 1
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
      where a.mandant_id > 1
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
      where a.mandant_id > 1
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
            where a.mandant_id > 1 and
                  a.konditionsart_id = 'ZMP'
            group by all) b
        on a.mandant_id = b.mandant_id and
           a.wup_id = b.wup_id and
           a.bon_dat = b.bon_dat and
           a.bon_id = b.bon_id and
           a.bon_zeile = b.bon_zeile
      where a.mandant_id > 1
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
      where a.mandant_id > 1
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
      where a.mandant_id > 1
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
            where a.mandant_id > 1 and
                  a.konditionsart_id = 'ZMP'
            group by all) b
        on a.mandant_id = b.mandant_id and
           a.wup_id = b.wup_id and
           a.bon_dat = b.bon_dat and
           a.bon_id = b.bon_id and
           a.bon_zeile = b.bon_zeile
      where a.mandant_id > 1
      group by all
      having anz_promo = 1 and
            ((min_promo = 'COMMON' and max_promo = 'COMMON') or 
             (min_promo = 'CUSTOMER' and max_promo = 'COMMON')) and
             anz_kond = 1) x
where (x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile) not in (select x.mandant_id,x.wup_id,x.bon_dat,x.bon_id,x.bon_zeile from _unique_ x)
group by all
having bewart_det_id_ in (100111)
;

update dbp_etl.kmo_artbew_bon_1 from (select *
                                    from _unique_) b

set bewart_det_id_zmp = b.bewart_det_id

where dbp_etl.kmo_artbew_bon.mandant_id = b.mandant_id and
      dbp_etl.kmo_artbew_bon.wup_id = b.wup_id and
      dbp_etl.kmo_artbew_bon.dat_booking = b.bon_dat and
      dbp_etl.kmo_artbew_bon.bon_id = b.bon_id and
      dbp_etl.kmo_artbew_bon.bon_zeile = b.bon_zeile and
      dbp_etl.kmo_artbew_bon.umsatz_brutto/nullifzero(dbp_etl.kmo_artbew_bon.menge) <> 0.01
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
where a.mandant_id > 1 and 
      abs(b.betrag_promo_brutto) = 0.01 and
      b.betrag_promo_brutto < 0 and (b.umsatz_promo_brutto < 0 or b.umsatz_promo_brutto = 0.01)
group by all
);

update dbp_etl.kmo_artbew_bon_1 from (select *
                                    from _zmp01) b

set umsatz_brutto = umsatz_brutto-b.betrag_promo

where dbp_etl.kmo_artbew_bon.mandant_id = b.mandant_id and
      dbp_etl.kmo_artbew_bon.wup_id = b.wup_id and
      dbp_etl.kmo_artbew_bon.dat_booking = b.bon_dat and
      dbp_etl.kmo_artbew_bon.bon_id = b.bon_id and
      dbp_etl.kmo_artbew_bon.bon_zeile = b.bon_zeile
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
where a.mandant_id > 1
group by all
);

update dbp_etl.kmo_artbew_bon_1 set umsatz_brutto = 0
where (mandant_id,wup_id,dat_booking,bon_id) in (select mandant_id,wup_id,bon_dat,bon_id from _zmp01) and
       umsatz_brutto/nullifzero(menge) = 0.01
;

update dbp_etl.kmo_artbew_bon_1 from (select *
                                    from _zmp02) b
                                          
set umsatz_brutto = umsatz_brutto+b.betrag_promo_

where dbp_etl.kmo_artbew_bon.mandant_id = b.mandant_id and
      dbp_etl.kmo_artbew_bon.wup_id = b.wup_id and
      dbp_etl.kmo_artbew_bon.dat_booking = b.bon_dat and
      dbp_etl.kmo_artbew_bon.bon_id = b.bon_id and
      dbp_etl.kmo_artbew_bon.bon_zeile = b.bon_zeile and
      dbp_etl.kmo_artbew_bon.umsatz_brutto/nullifzero(dbp_etl.kmo_artbew_bon.menge) <> 0.01 and
      dbp_etl.kmo_artbew_bon.umsatz_brutto <> 0
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
where a.mandant_id > 1 and 
      abs(b.betrag_promo_brutto) = 0.01 and
      b.betrag_promo_brutto < 0 and b.umsatz_promo_brutto > 0 and b.umsatz_promo_brutto <> 0.01
group by all
);

update dbp_etl.kmo_artbew_bon_1 from (select *
                                    from _zmp03) b
                                          
set umsatz_brutto = umsatz_promo

where dbp_etl.kmo_artbew_bon.mandant_id = b.mandant_id and
      dbp_etl.kmo_artbew_bon.wup_id = b.wup_id and
      dbp_etl.kmo_artbew_bon.dat_booking = b.bon_dat and
      dbp_etl.kmo_artbew_bon.bon_id = b.bon_id and
      dbp_etl.kmo_artbew_bon.bon_zeile = b.bon_zeile and
      dbp_etl.kmo_artbew_bon.umsatz_brutto/nullifzero(dbp_etl.kmo_artbew_bon.menge) <> 0.01 and
      dbp_etl.kmo_artbew_bon.umsatz_brutto <> 0
;

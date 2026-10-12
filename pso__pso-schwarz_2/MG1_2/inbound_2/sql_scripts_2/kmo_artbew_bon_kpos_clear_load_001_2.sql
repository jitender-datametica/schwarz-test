create or replace table dbp_etl.kmo_artbew_bon_2  (
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
  vk_aktion_brutto decimal(9,3),
  vk_brutto decimal(9,2),
  betrag_promo_brutto_kdn decimal(18,4),
  betrag_promo_brutto_kdp decimal(18,4),
  betrag_promo_brutto_null decimal(18,4),
  bde_kundenkarte_id varchar(255) collate 'en-ci'
);

create or replace table dbp_etl.kmo_artbew_bon_promotion_2 (
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

create or replace table dbp_etl.kmo_artbew_bon_dat_2 (
  dat date not null
);

create or replace table dbp_etl.kmo_artbew_bon_delta_2 (
  mandant_id  byteint not null,
  wup_id      integer not null,
  dat_booking date not null,
  xml_name    varchar(255)
);

insert into dbp_etl.kmo_artbew_bon_delta_2 (mandant_id
                                         ,wup_id
                                         ,dat_booking
                                         ,xml_name)
select mandant_id
      ,wup_id
      ,dat_booking
      ,xml_name
from dbp_etl.kmo_artbew_bon_delta_main_2
where dat_booking <= '2022-03-31'
;

insert into dbp_etl.kmo_artbew_bon_2 (mandant_id
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
                                   ,bde_kundenkarte_id)
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
      ,temp.betrag_promo_brutto_kdn
      ,temp.betrag_promo_brutto_kdp
      ,temp.betrag_promo_brutto_null
      ,temp.konditionsart_id
      ,temp.bonuskauf_id_lb
      ,temp.bde_kundenkarte_id
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
            ,p.kundenkarte_id
            ,p.kundenkarte_typ_id
            ,p.bonuskauf_id
            ,p.aktion_typ_id
            ,p.vk_aktion_brutto
            ,p.vk_brutto
            ,p.betrag_promo_brutto_kdn
            ,p.betrag_promo_brutto_kdp
            ,p.betrag_promo_brutto_null
            ,p.konditionsart_id
            ,p.bonuskauf_id_lb					 
            ,p.bde_kundenkarte_id
            ,p.bonus_flag
            ,row_number() over(partition by p.mandant_id, p.bon_id, p.dat_booking, p.wup_id, p.bon_zeile, p.kl_art_id, p.ean_kasse
                               order by p.aktion_typ_id desc, p.konditionsart_id desc, p.bonuskauf_id, p.bonuskauf_id_lb) as rk
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
                  ,max(bonuskauf_id) as bonuskauf_id
                  ,max(aktion_typ_id) as aktion_typ_id
                  ,vk_aktion_brutto
                  ,vk_brutto
                  ,sum(betrag_promo_brutto_kdn) as betrag_promo_brutto_kdn
                  ,sum(betrag_promo_brutto_kdp) as betrag_promo_brutto_kdp
                  ,sum(betrag_promo_brutto_null) as betrag_promo_brutto_null
                  ,konditionsart_id
                  ,max(bonuskauf_id_lb) as bonuskauf_id_lb
                  ,bde_kundenkarte_id
                  ,bonus_flag
                  ,wrg_id
            from (select k.mandant_id
                        ,k.bon_id
                        ,k.dat_booking
                        ,k.wup_id
                        ,k.wrg_id
                        ,z.kl_art_id
                        ,coalesce(case 
                                    when trim(z.barcode_string) = '' 
                                    then coalesce(z.ean_kasse,0)
                                    when length(z.barcode_string) > 26 
                                    then -9999 
                                    else cast(z.barcode_string as bigint) 
                                  end,coalesce(z.ean_kasse,0)) as ean_kasse
                        ,z.bon_zeile
                        ,case when k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                              then z.menge * (-1)
                              else z.menge
                         end as menge_
                        ,case when k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                              then z.umsatz_brutto * (-1)
                              else z.umsatz_brutto
                         end as umsatz_brutto_
                        ,z.wg_id 
                        ,z.aktion_id
                        ,k.kundenkarte_id
                        ,k.kundenkarte_typ_id
                        ,p.bonuskauf_id
                        ,case when trim(p.aktion_typ_id) in ('KDP') then 'KDP' 
                              when trim(p.aktion_typ_id) in ('KPB', 'KDN') then 'KDN' 
                              else 'KDA' 
                         end as aktion_typ_id
                        ,a.vk_aktion_brutto
                        ,vk.vk_brutto
                        ,case when trim(p.aktion_typ_id) in ('KPB','KDN') then p.betrag_promo_brutto else null end as betrag_promo_brutto_kdn
                        ,case when trim(p.aktion_typ_id) = 'KDP' then p.betrag_promo_brutto else null end as betrag_promo_brutto_kdp
                        ,case when trim(p.aktion_typ_id) is null then p.betrag_promo_brutto else null end as betrag_promo_brutto_null
                        ,p.konditionsart_id
                        ,p.bonuskauf_id_lb 
                        ,bde.kundenkarte_id as bde_kundenkarte_id
                        ,case when p.bonuskauf_id is not null and p.bonuskauf_id <> 0 and p.bonuskauf_id_lb is null then 1 else 0 end as bonus_flag
                  from dbp_ods.ods_bon_kopf_2 k
                  join (select mandant_id
                              ,wup_id
                              ,dat_booking
                        from dbp_etl.kmo_artbew_bon_delta_2 
                        group by 1,2,3) d
                    on k.mandant_id = d.mandant_id and 
                       k.wup_id = d.wup_id and 
                       k.dat_booking = d.dat_booking
                  join dbp_ods.ods_bon_verkauf_2 z
                    on k.mandant_id = z.mandant_id and 
                       k.bon_id = z.bon_id and 
                       k.wup_id = z.wup_id 
                  join dbp_ods.ods_bon_transaction_2 t
                    on k.mandant_id = t.mandant_id and 
                       k.bon_id = t.bon_id and 
                       k.wup_id = t.wup_id 
                  left join dbp_data.aktion_art_wup_zu_2 a
                    on z.aktion_id = a.aktion_id and 
                       z.mandant_id = a.mandant_id and 
                       z.wup_id = a.wup_id and 
                       z.kl_art_id = a.art_id/10
                  left join dbp_data.art_wup_vk_per_2 vk_2
                    on z.bon_dat between vk.dat_von and vk.dat_bis and 
                       z.kl_art_id = vk.art_id/10 and 
                       z.mandant_id = vk.mandant_id and 
                       z.wup_id = vk.wup_id
                  left join dbp_data.bewart_det_ecommerce_2 bde
                    on k.kundenkarte_id = bde.kundenkarte_id and 
                       k.mandant_id = bde.mandant_id
                  left join (select op.bon_id, 
                                    op.wup_id, 
                                    op.mandant_id, 
                                    op.bon_dat, 
                                    op.kl_art_id, 
                                    op.bon_zeile, 
                                    op.bonuskauf_id, 
                                    sum(op.betrag_promo_brutto) as betrag_promo_brutto,		   
                                    case when op.konditionsart_id in ('ZRT3','ZTAG','ZGEB') then 'N' else 'Y' end as konditionsart_id,  
                                    ab.aktion_typ_id aktion_typ_id,
                                    ab.bonuskauf_id as bonuskauf_id_lb
                             from dbp_ods.ods_promotion_2 op
                             left join (select b.mandant_id,
                                               b.bonuskauf_id,
                                               max(a.aktion_typ_id) aktion_typ_id
                                        from dbp_data.aktion_2 a
                                        left join dbp_data.l_bonuskauf_2 b
                                          on a.aktion_id = b.aktion_id and 
                                             a.mandant_id = b.mandant_id
                                        group by 1,2) ab
                               on op.bonuskauf_id = ab.bonuskauf_id and 
                                  op.mandant_id = ab.mandant_id
                             group by 1,2,3,4,5,6,7,9,10,11) p
                    on k.bon_id = p.bon_id and 
                       k.wup_id = p.wup_id and 
                       k.mandant_id = p.mandant_id and 
                       k.bon_dat = p.bon_dat and 
                       z.kl_art_id = p.kl_art_id and 
                       z.bon_zeile = p.bon_zeile
                  where k.mandant_id > 1 and 
                        k.kunde_fg = 1 and 
                        k.turnover_fg = 1 and 
                        k.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_2) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_2) and 
                        z.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_2) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_2) and 
                        t.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_2) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_2) and 
                        (case when k.kasse_typ_id <> 3 then 1 else 0 end ) = 1 and 
                        (k.bon_id, k.wup_id) not in (select bon_id, wup_id from dbp_ods.ods_bon_storno_2)
                  union
                  select k.mandant_id
                        ,k.bon_id
                        ,k.dat_booking
                        ,k.wup_id
                        ,k.wrg_id
                        ,z.kl_art_id
                        ,coalesce(case 
                                    when trim(z.barcode_string) = '' 
                                    then coalesce(z.ean_kasse,0)
                                    when length(z.barcode_string) > 26 
                                    then -9999 
                                    else cast(z.barcode_string as bigint) 
                                  end,coalesce(z.ean_kasse,0)) as ean_kasse
                        ,z.bon_zeile
                         -- mengen flag beruecksichtigen (vorgabe david vom 18.03.) 
                        ,case when k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                              then z.menge * (-1)
                              else z.menge
                         end * z.menge_fg as menge_
                        ,case when k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                              then z.umsatz_brutto * (-1)
                              else z.umsatz_brutto
                         end as umsatz_brutto_
                        ,z.wg_id 
                        ,z.aktion_id
                        ,k.kundenkarte_id
                        ,k.kundenkarte_typ_id
                        ,p.bonuskauf_id
                        ,case when trim(p.aktion_typ_id) in ('KDP') then 'KDP' 
                              when trim(p.aktion_typ_id) in ('KPB','KDN') then 'KDN' 
                              else 'KDA' 
                         end as aktion_typ_id
                        ,a.vk_aktion_brutto
                        ,vk.vk_brutto
                        ,case when trim(p.aktion_typ_id) in ('KPB','KDN') then p.betrag_promo_brutto else null end as betrag_promo_brutto_kdn
                        ,case when trim(p.aktion_typ_id) = 'KDP' then p.betrag_promo_brutto else null end as betrag_promo_brutto_kdp
                        ,case when trim(p.aktion_typ_id) is null then p.betrag_promo_brutto else null end as betrag_promo_brutto_null 
                        ,p.konditionsart_id  
                        ,p.bonuskauf_id_lb
                        ,bde.kundenkarte_id as bde_kundenkarte_id			
                        ,case when p.bonuskauf_id is not null and p.bonuskauf_id <> 0 and p.bonuskauf_id_lb is null then 1 else 0 end as bonus_flag
                  from dbp_ods.ods_bon_kopf_2 k
                  join (select mandant_id
                              ,wup_id
                              ,dat_booking
                        from dbp_etl.kmo_artbew_bon_delta_2 
                        group by 1,2,3) d
                    on k.mandant_id = d.mandant_id and 
                       k.wup_id = d.wup_id and 
                       k.dat_booking = d.dat_booking
                  join dbp_ods.ods_bon_retoure_2 z
                    on k.mandant_id = z.mandant_id and 
                       k.bon_id = z.bon_id and 
                       k.wup_id = z.wup_id 
                  join dbp_ods.ods_bon_transaction_2 t
                    on k.mandant_id = t.mandant_id and 
                       k.bon_id = t.bon_id and 
                       k.wup_id = t.wup_id
                  left join dbp_data.aktion_art_wup_zu_2 a
                    on z.aktion_id = a.aktion_id and 
                       z.mandant_id = a.mandant_id and 
                       z.wup_id = a.wup_id and 
                       z.kl_art_id = a.art_id/10
                  left join dbp_data.art_wup_vk_per_2 vk_2
                    on z.bon_dat between vk.dat_von and vk.dat_bis and 
                       z.kl_art_id = vk.art_id/10 and 
                       z.mandant_id = vk.mandant_id and 
                       z.wup_id = vk.wup_id
                  left join dbp_data.bewart_det_ecommerce_2 bde
                    on k.kundenkarte_id = bde.kundenkarte_id and 
                       k.mandant_id = bde.mandant_id
                  left join (select op.bon_id, 
                                    op.wup_id, 
                                    op.mandant_id, 
                                    op.bon_dat, 
                                    op.kl_art_id, 
                                    op.bon_zeile, 
                                    op.bonuskauf_id, 
                                    sum(op.betrag_promo_brutto) as betrag_promo_brutto,
		                    case when op.konditionsart_id in ('ZRT3','ZTAG','ZGEB') then 'N' else 'Y' end as konditionsart_id,
		                    ab.aktion_typ_id aktion_typ_id,
		                    ab.bonuskauf_id as bonuskauf_id_lb
	                           from dbp_ods.ods_promotion_2 op
                             left join (select b.mandant_id, 
	                                       b.bonuskauf_id, 
			                       max(a.aktion_typ_id) aktion_typ_id 
	                                from dbp_data.aktion_2 a
                                        left join dbp_data.l_bonuskauf_2 b
                                          on a.aktion_id = b.aktion_id and 
                                             a.mandant_id = b.mandant_id
                                        group by 1,2) ab
                               on op.bonuskauf_id = ab.bonuskauf_id and 
                                  op.mandant_id = ab.mandant_id
                             group by 1,2,3,4,5,6,7,9,10,11) p
                    on k.bon_id = p.bon_id and 
                       k.wup_id = p.wup_id and 
                       k.mandant_id = p.mandant_id and 
                       k.bon_dat = p.bon_dat and 
                       z.kl_art_id = p.kl_art_id and 
                       z.bon_zeile = p.bon_zeile
                  where k.mandant_id > 1 and 
                        k.kunde_fg = 1 and 
                        k.turnover_fg = 1 and 
                        k.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_2) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_2) and 
                        z.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_2) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_2) and 
                        t.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_2) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_2) and
                       (case when k.kasse_typ_id <> 3 then 1 else 0 end) = 1 and 
                       (k.bon_id, k.wup_id) not in (select bon_id,wup_id from dbp_ods.ods_bon_storno_2)) x
            where to_number(ean_kasse) is not null
            group by 1,2,3,4,5,6,7,8,9,10,11,12,13,16,17,21,23,24,25) p) temp
where temp.rk = 1
;

insert into dbp_etl_process.artbew_bon_empties_2 (mandant_id,
                                                wup_id,
                                                td_insert,
                                                td_update)
select a.mandant_id,
       a.wup_id,
       current_timestamp as td_insert,
       current_timestamp as td_update
from dbp_ods.ods_bon_leergut_2 a
join dbp_ods.ods_bon_zahlung_2 b
  on a.mandant_id = b.mandant_id and
     a.barcode_leergut = b.barcode_leergut and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat
join dbp_ods.ods_bon_transaction_2 c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.bon_dat = c.bon_dat and
     c.transaction_name = 'RetailTransaction'
where b.kpos_zahlung_typ_id = 'BBN' and
      a.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_2) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_2) and
     (a.mandant_id,a.wup_id) not in (select mandant_id,wup_id from dbp_etl_process.artbew_bon_empties_2)
group by 1,2
;

create or replace volatile table _track_empties as (
select a.*
from dbp_ods.ods_bon_leergut_2 a
join (select mandant_id
            ,wup_id
            ,dat_booking
      from dbp_etl.kmo_artbew_bon_delta_2 
      group by 1,2,3) d
  on a.mandant_id = d.mandant_id and 
     a.wup_id = d.wup_id and 
     a.bon_dat = d.dat_booking
where a.bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_2) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_2) and
     (a.mandant_id,a.wup_id) in (select mandant_id,wup_id from dbp_etl_process.artbew_bon_empties_2) and
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
from _track_empties a
join dbp_ods.ods_bon_kopf_2 b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_id = b.bon_id and
     a.bon_dat = b.bon_dat
join dbp_data.mandant_2 c
  on a.mandant_id = c.mandant_id
group by 1,2,3,4,5,6,7,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24
);

insert into dbp_etl.kmo_artbew_bon_2 (mandant_id
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
                                   ,bde_kundenkarte_id)
select mandant_id
      ,bon_id
      ,dat_booking
      ,wup_id
      ,wrg_id
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
from _leergut
;

update dbp_etl.kmo_artbew_bon_2
from dbp_data.wup_2 w

set lkp_nb_id = w.nb_id

where dbp_etl.kmo_artbew_bon.mandant_id = w.mandant_id
  and dbp_etl.kmo_artbew_bon.wup_id = w.wup_id
;

update dbp_etl.kmo_artbew_bon_2

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
      from dbp_data.art_2 a
      qualify row_number() over (partition by mandant_id, kl_art_id order by art_id desc) = 1) dt 
      
where dbp_etl.kmo_artbew_bon.mandant_id = dt.mandant_id and 
      dbp_etl.kmo_artbew_bon.kl_art_id = dt.kl_art_id
;

-- 27.06.2022, dbay: spec0157445, historical tracking of tax ids
update dbp_etl.kmo_artbew_bon_2 from (select *
                                    from dbp_data.art_per_2) b

set lkp_mwst_id = b.mwst_id

where dbp_etl.kmo_artbew_bon.dat_booking between b.dat_von and b.dat_bis and
      dbp_etl.kmo_artbew_bon.mandant_id = b.mandant_id and
      dbp_etl.kmo_artbew_bon.lkp_art_id = b.art_id and
      dbp_etl.kmo_artbew_bon.lkp_mwst_id <> b.mwst_id
;

update dbp_etl.kmo_artbew_bon_2
from dbp_data.art_wg_zu_per_2 w

set lkp_wg_id = w.wg_id
  , lkp_arthiertyp_id = w.arthiertyp_id

where dbp_etl.kmo_artbew_bon.mandant_id = w.mandant_id
  and dbp_etl.kmo_artbew_bon.lkp_art_id = w.art_id
  and w.dat_bis = to_date('9999-12-31','yyyy-mm_2-dd')
  and w.arthiertyp_id = 2
;

-- 30.09.2022, -dbay-
--
-- Two updates are taking place for enrichment of countries switching to EUR
-- as new currency.

-- 1. setting the default currency for all rows.

update dbp_etl.kmo_artbew_bon_2
from dbp_data.kurs_2 k

set lkp_umrechnungskurs = k.umrechnungskurs 

where dbp_etl.kmo_artbew_bon.lkp_wrg = k.von_wrg_id 
  --and dbp_etl.kmo_artbew_bon.dat_booking between k.dat_von and k.dat_bis 
  and k.dat_bis = '9999-12-31'
  and k.kurstyp_id = 3
  and k.nach_wrg_id = 'EUR'
;

-- 2. here is the specific update for our currency changes.

update dbp_etl.kmo_artbew_bon_2 from (select *
                                    from dbp_data.mandant_wrg_zu_per_2
                                    where current_date between dat_von and dat_bis and
                                          von_wrg_id is not null) b

set lkp_wrg = b.wrg_id,
    lkp_umrechnungskurs = cast(1 as float)/cast(b.umrechnungskurs as float)
    
where dbp_etl.kmo_artbew_bon.mandant_id = b.mandant_id and
      dbp_etl.kmo_artbew_bon.lkp_wrg = b.von_wrg_id
;

update dbp_etl.kmo_artbew_bon_2 
from dbp_data.mwst_per_2 m

set lkp_mwst = m.mwst

where dbp_etl.kmo_artbew_bon.mandant_id = m.mandant_id
  and dbp_etl.kmo_artbew_bon.lkp_mwst_id = m.mwst_id
  and dbp_etl.kmo_artbew_bon.dat_booking between m.dat_von and m.dat_bis
;

delete from dbp_etl.kmo_artbew_bon_2
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

insert into dbp_etl.kmo_artbew_bon_dat_2 (dat)
select dat_booking
from dbp_etl.kmo_artbew_bon_2
group by dat_booking
;

delete from dbp_etl.kmo_artbew_bon_2
where dat_booking > current_date-1
;

-- dbay, 13.12.2022
-- Spendenartikel (u.a. Weihnachten) raus.
-- Jetzt neu mit Artikel_2 202685400.

delete from dbp_etl.kmo_artbew_bon_2
where mandant_id = 2 and
      lkp_art_id in (818410,202685400)
;

insert into dbp_etl.kmo_artbew_bon_promotion_2 (mandant_id
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
from dbp_etl.kmo_artbew_bon_2 k
join dbp_ods.ods_promotion_2 p
  on k.mandant_id = p.mandant_id and 
     k.bon_id = p.bon_id and 
     k.bon_zeile = p.bon_zeile and 
     p.wup_id >= 1000 and p.wup_id <= 9999 and 
     p.kl_art_id is not null
-- 09.01.2023, -dbay-
-- filter killed due to interferences regarding loyalty.
-- where coalesce(p.betrag_promo_brutto, 0) <> 0
group by 1,2,3,4,5,6,7
;

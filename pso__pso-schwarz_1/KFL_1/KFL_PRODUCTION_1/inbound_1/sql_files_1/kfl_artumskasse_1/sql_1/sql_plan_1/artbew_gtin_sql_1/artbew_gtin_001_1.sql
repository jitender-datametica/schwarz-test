create or replace table dbp_etl.kmo_artbew_bon_1  (
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
  kundenkarte_id      varchar(255) collate 'en-ci'      
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

create or replace table dbp_etl.kmo_artbew_bon_delta_1  (
  mandant_id  byteint not null,
  wup_id      integer not null,
  dat_booking date not null,
  xml_name    varchar(255)
);

create or replace table dbp_etl.artbew_kmo_tmp_1  (
  wup_id integer not null,
  mandant_id byteint not null,
  bewart_id smallint not null ,
  gp_id integer not null,
  nb_id smallint not null ,
  art_id integer not null,
  dat date not null,
  aktion_id char(10) collate 'en-ci' not null default '          '   ,
  promo_fg byteint not null default 0  ,
  ean_kasse decimal(26,0) not null default 0 ,
  einkaufsorganisation_id smallint ,
  herst_id integer ,
  mwst_id byteint not null ,
  menge decimal(18,3) ,
  wrg_1 char(3) collate 'en-ci' ,
  umsatz_netto decimal(18,4),
  diff_umsatz_netto_konz decimal(18,4) ,
  umsatz_mwst_betrag decimal(18,4),
  diff_umsatz_mwst_betrag_konz decimal(18,4) ,
  ek_brutto decimal(18,4),
  diff_ek_brutto_konz decimal(18,4),
  ek_netto decimal(18,4),
  diff_ek_netto_konz decimal(18,4),
  ek_nettonetto decimal(18,4),
  diff_ek_nettonetto_konz decimal(18,4),
  ek_kal_basis decimal(18,4),
  diff_ek_kal_basis_konz decimal(18,4),
  ek_mep decimal(18,4),
  diff_ek_mep_konz decimal(18,4),
  einstandspreis decimal(18,4),
  diff_einstandspreis_konz decimal(18,4),
  logkostenzuschlag decimal(18,4),
  diff_logkostenzuschlag_konz decimal(18,4),
  bezugsweg_id byteint ,
  ek_netto_bnk decimal(18,4),
  diff_ek_netto_bnk_konz decimal(18,4),
  ek_netto_bnk_sachk decimal(18,4),
  diff_ek_netto_bnk_sachk_konz decimal(18,4),
  posten_id char(2) collate 'en-ci' ,
  bq_findung_id byteint ,
  ek_gld decimal(18,4) ,
  diff_ek_gld_konz decimal(18,4) 
);

insert into dbp_etl.kmo_artbew_bon_delta_1 (mandant_id
                                         ,wup_id
                                         ,dat_booking
                                         ,xml_name)
select t.mandant_id
      ,t.wup_id
      ,t.bon_dat
      ,t.datei_name
from dbp_ods.ods_bon_transaction_1 t
where t.mandant_id in (3,5,6,8) and 
      cast(t.bon_dat as date) between current_date-10 and current_date-1
group by 1,2,3,4
;

create volatile table _snap_bon_kopf as
select *
from dbp_ods.ods_bon_kopf_1
where bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and
      mandant_id in (3,5,6,8)
;

create volatile table _snap_bon_verkauf as
select *
from dbp_ods.ods_bon_verkauf_1
where bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and
      mandant_id in (3,5,6,8)
;

create volatile table _snap_bon_transaction as
select *
from dbp_ods.ods_bon_transaction_1
where bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and
      mandant_id in (3,5,6,8)
;

create volatile table _snap_bon_retoure as
select *
from dbp_ods.ods_bon_retoure_1
where bon_dat between (select min(dat_booking)-14 from dbp_etl.kmo_artbew_bon_delta_1) and (select max(dat_booking) from dbp_etl.kmo_artbew_bon_delta_1) and
      mandant_id in (3,5,6,8)
;

insert into dbp_etl.kmo_artbew_bon_1 (mandant_id
                                   ,bon_id
                                   ,dat_booking
                                   ,wup_id
                                   ,kl_art_id
                                   ,ean_kasse
                                   ,bon_zeile
                                   ,menge
                                   ,umsatz_brutto
                                   ,wg_id
                                   ,aktion_id
                                   ,lkp_art_id
                                   ,lkp_nb_id
                                   ,lkp_wg_id
                                   ,lkp_arthiertyp_id
                                   ,lkp_zek_id
                                   ,lkp_mwst_id
                                   ,lkp_posten_id
                                   ,lkp_wrg)
select mandant_id
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
      ,art_id as lkp_art_id
      ,nb_id as lkp_nb_id
      ,stamm_wg as lkp_wg_id
      ,arthiertyp_id as lkp_arthiertyp_id
      ,zek_id as lkp_zek_id
      ,mwst_id as lkp_mwst_id
      ,posten_id as lkp_posten_id
      ,wrg_id as lkp_wrg
from (select k.mandant_id
            ,k.bon_id
            ,k.dat_booking
            ,k.wup_id
            ,z.kl_art_id
            ,coalesce(case 
                        when trim(z.barcode_string) = '' then coalesce(z.ean_kasse,0)
                        when length(z.barcode_string) > 26 then -9999
                        when try_to_number(z.barcode_string) is null then -9999
                        else cast(z.barcode_string as bigint)
                      end,coalesce(z.ean_kasse,0)) as ean_kasse
            ,z.bon_zeile
            ,case when k.kunde_fg = 0
            then z.menge * (-1)
            else z.menge
            end as menge_
            ,case when k.kunde_fg = 0
            then z.umsatz_brutto * (-1)
            else z.umsatz_brutto
            end as umsatz_brutto_
            ,z.wg_id
            ,z.aktion_id
            ,x0.posten_id
            ,x0.mwst_id
            ,x0.art_id
            ,x0.zek_id
            ,x1.wg_id as stamm_wg
            ,x1.arthiertyp_id
            ,k.wrg_id
            ,0 as nb_id
      from _snap_bon_kopf k
      join (select mandant_id
                  ,wup_id
                  ,dat_booking
            from dbp_etl.kmo_artbew_bon_delta_1
            group by 1,2,3) d
        on k.mandant_id = d.mandant_id and 
           k.wup_id = d.wup_id and 
           k.bon_dat = d.dat_booking
      join _snap_bon_verkauf z
        on k.mandant_id = z.mandant_id and 
           k.bon_id = z.bon_id and 
           k.wup_id = z.wup_id and 
           k.bon_dat = z.bon_dat
      join _snap_bon_transaction t
        on k.mandant_id = t.mandant_id and 
           k.bon_id = t.bon_id and 
           k.wup_id = t.wup_id and 
           k.bon_dat = t.bon_dat
      join (select mandant_id
                  ,kl_art_id
                  ,art_id
                  ,zek_id
                  ,mwst_id
                  ,posten_id
            from dbp_data.art_1 a
            qualify row_number() over (partition by mandant_id,kl_art_id order by art_id desc) = 1) x0
        on z.mandant_id = x0.mandant_id and
           z.kl_art_id = x0.kl_art_id
      join dbp_data.art_wg_zu_per_1 x1
        on x0.mandant_id = x1.mandant_id and
           x0.art_id = x1.art_id and 
           x1.arthiertyp_id = 2 and
           x1.dat_bis = to_date('9999-12-31','yyyy-mm_1-dd')
      join dbp_data.mandant_1 x2
        on k.mandant_id = x2.mandant_id
      where k.kunde_fg = 1 and 
            k.turnover_fg = 1 and 
           (case when k.kasse_typ_id <> 3 then 1 else 0 end) = 1 and 
           (k.bon_id, k.wup_id) not in (select bon_id,wup_id from dbp_ods.ods_bon_storno_1)
      union
      select k.mandant_id
            ,k.bon_id
            ,k.dat_booking
            ,k.wup_id
            ,z.kl_art_id
            ,coalesce(case 
                        when trim(z.barcode_string) = '' then coalesce(z.ean_kasse,0)
                        when length(z.barcode_string) > 26 then -9999
                        when try_to_number(z.barcode_string) is null then -9999
                        else cast(z.barcode_string as bigint)
                      end,coalesce(z.ean_kasse,0)) as ean_kasse
            ,z.bon_zeile
            ,case 
               when k.kunde_fg = 0
               then z.menge * (-1)
               else z.menge
             end * z.menge_fg as menge_
            ,case 
               when k.kunde_fg = 0
               then z.umsatz_brutto * (-1)
               else z.umsatz_brutto
             end as umsatz_brutto_
            ,z.wg_id
            ,z.aktion_id
            ,x0.posten_id
            ,x0.mwst_id
            ,x0.art_id
            ,x0.zek_id
            ,x1.wg_id as stamm_wg
            ,x1.arthiertyp_id
            ,k.wrg_id
            ,0 as nb_id
      from _snap_bon_kopf k
      join (select mandant_id
                  ,wup_id
                  ,dat_booking
            from dbp_etl.kmo_artbew_bon_delta_1
            group by 1,2,3) d
        on k.mandant_id = d.mandant_id and 
           k.wup_id = d.wup_id and 
           k.bon_dat = d.dat_booking
      join _snap_bon_retoure z
        on k.mandant_id = z.mandant_id and 
           k.bon_id = z.bon_id and 
           k.wup_id = z.wup_id and 
           k.bon_dat = z.bon_dat
      join _snap_bon_transaction t
        on k.mandant_id = t.mandant_id and 
           k.bon_id = t.bon_id and 
           k.wup_id = t.wup_id and 
           k.bon_dat = t.bon_dat
      join (select mandant_id
                  ,kl_art_id
                  ,art_id
                  ,zek_id
                  ,mwst_id
                  ,posten_id
                  from dbp_data.art_1 a
                  qualify row_number() over (partition by mandant_id,kl_art_id order by art_id desc) = 1) x0
        on z.mandant_id = x0.mandant_id and
           z.kl_art_id = x0.kl_art_id
      join dbp_data.art_wg_zu_per_1 x1
        on x0.mandant_id = x1.mandant_id and
           x0.art_id = x1.art_id and
           x1.arthiertyp_id = 2 and
           x1.dat_bis = to_date('9999-12-31','yyyy-mm_1-dd')
      join dbp_data.mandant_1 x2
        on k.mandant_id = x2.mandant_id
      where k.kunde_fg = 1 and 
            k.turnover_fg = 1 and 
           (case when k.kasse_typ_id <> 3 then 1 else 0 end) = 1 and 
           (k.bon_id, k.wup_id) not in (select bon_id,wup_id from dbp_ods.ods_bon_storno_1)) x
where ean_kasse = 0 or ean_kasse is not null
;

create or replace volatile table _tage as (
select dat
from dbp_data.tag_1
where dat between current_date-10 and current_date-1
);

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

update dbp_etl.kmo_artbew_bon_1 from (select a.mandant_id,
                                           b.dat,
                                           a.mwst_id,
                                           a.mwst
                                    from dbp_data.mwst_per_1 a
                                    join _tage b
                                      on b.dat between a.dat_von and a.dat_bis
                                    where a.mandant_id in (3,5,6,8)) b

set lkp_mwst = b.mwst

where dbp_etl.kmo_artbew_bon.mandant_id = b.mandant_id and
      dbp_etl.kmo_artbew_bon.dat_booking = b.dat and
      dbp_etl.kmo_artbew_bon.lkp_mwst_id = b.mwst_id
;

update dbp_etl.kmo_artbew_bon_1 from (select *
                                    from dbp_data.art_per_1) b

set lkp_mwst_id = b.mwst_id

where dbp_etl.kmo_artbew_bon.dat_booking between b.dat_von and b.dat_bis and
      dbp_etl.kmo_artbew_bon.mandant_id = b.mandant_id and
      dbp_etl.kmo_artbew_bon.lkp_art_id = b.art_id and
      dbp_etl.kmo_artbew_bon.lkp_mwst_id <> b.mwst_id
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
     k.bon_zeile = p.bon_zeile
where coalesce(p.betrag_promo_brutto, 0) <> 0
group by 1,2,3,4,5,6,7
;

insert into dbp_etl.artbew_kmo_tmp_1 (mandant_id
                                   ,wup_id
                                   ,nb_id
                                   ,art_id
                                   ,gp_id
                                   ,einkaufsorganisation_id
                                   ,bewart_id
                                   ,dat
                                   ,aktion_id
                                   ,herst_id
                                   ,mwst_id
                                   ,wrg_1
                                   ,posten_id
                                   ,bezugsweg_id
                                   ,menge
                                   ,umsatz_netto
                                   ,umsatz_mwst_betrag
                                   ,promo_fg
                                   ,ean_kasse
                                   ,diff_umsatz_netto_konz
                                   ,diff_umsatz_mwst_betrag_konz)
select mandant_id
      ,wup_id
      ,nb_id
      ,art_id
      ,gp_id
      ,einkaufsorganisation_id
      ,bewart_id
      ,dat
      ,aktion_id
      ,herst_id
      ,mwst_id
      ,wrg_1
      ,posten_id
      ,bezugsweg_id
      ,menge
      ,umsatz_netto
      ,umsatz_mwst_betrag
      ,promo_fg
      ,ean_kasse
      ,diff_umsatz_netto_konz
      ,diff_umsatz_mwst_betrag_konz
from (select l.mandant_id as mandant_id
            ,l.wup_id as wup_id
            ,lkp_nb_id as nb_id
            ,lkp_art_id as art_id
            ,-1 as gp_id
            ,-1 as einkaufsorganisation_id
            ,case when l.aktion_id <> '' then 1002 else 1001 end as bewart_id
            ,dat_booking as dat
            ,l.aktion_id
            ,-1 as herst_id
            ,lkp_mwst_id as mwst_id
            ,lkp_wrg as wrg_1
            ,coalesce(lkp_posten_id, ' ') as posten_id
            ,0 as bezugsweg_id
            ,menge_ as menge
            ,umsatz_brutto_ * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as umsatz_brutto_ohne_promo
            ,umsatz_brutto_ * lkp_umrechnungskurs as umsatz_brutto_ohne_promo_conv
            ,cast(umsatz_brutto_ohne_promo/(1+(lkp_mwst/100)) as decimal(18,4)) as umsatz_netto
            ,umsatz_brutto_ohne_promo-umsatz_netto as umsatz_mwst_betrag
            ,promo_fg
            ,ean_kasse
            ,lkp_umrechnungskurs as umrechnungskurs
            ,(cast(umsatz_brutto_/(1+(lkp_mwst/100)) as decimal(18, 4))) * lkp_umrechnungskurs as diff_umsatz_netto_konz
            ,umsatz_brutto_ohne_promo_conv-diff_umsatz_netto_konz as diff_umsatz_mwst_betrag_konz
      from (select mandant_id
                  ,wup_id
                  ,lkp_nb_id
                  ,lkp_art_id
                  ,lkp_posten_id
                  ,dat_booking
                  ,lkp_mwst
                  ,lkp_mwst_id
                  ,lkp_wrg
                  ,lkp_umrechnungskurs
                  ,promo_fg
                  ,ean_kasse
                  ,aktion_id
                  ,sum(umsatz_brutto) as umsatz_brutto_
                  ,sum(menge) as menge_
                  ,sum(umsatz_promotion_brutto) as umsatz_promotion_brutto_
            from (select z.mandant_id
                        ,z.bon_id
                        ,z.wup_id
                        ,z.lkp_nb_id
                        ,z.lkp_art_id
                        ,z.lkp_posten_id
                        ,z.dat_booking
                        ,z.bon_zeile
                        ,z.umsatz_brutto
                        ,z.menge
                        ,z.lkp_mwst
                        ,z.lkp_mwst_id
                        ,z.lkp_wrg
                        ,z.lkp_umrechnungskurs
                        ,coalesce(promotion_brutto, 0) as umsatz_promotion_brutto
                        ,case 
                           when umsatz_promotion_brutto <> 0
                           then 1
                           else 0
                         end as promo_fg
                        ,z.ean_kasse
                        ,z.aktion_id
                  from dbp_etl.kmo_artbew_bon_1 z
                  left join (select mandant_id
                                   ,bon_id
                                   ,dat_booking
                                   ,bon_zeile
                                   ,sum(umsatz_brutto) as promotion_brutto
                             from dbp_etl.kmo_artbew_bon_promotion_1
                             group by 1,2,3,4) p
                    on z.mandant_id = p.mandant_id and 
                       z.bon_id = p.bon_id and 
                       z.dat_booking = p.dat_booking and 
                       z.bon_zeile = p.bon_zeile) z
            group by 1,2,3,4,5,6,7,8,9,10,11,12,13) l
      left join (select *,
                        1 as conv_fg
                 from dbp_data.mandant_wrg_zu_per_1
                 where von_wrg_id is not null and
                       wrg_id <> von_wrg_id and
                       current_date between dat_von and dat_bis) y
        on l.mandant_id = y.mandant_id and
           l.lkp_wrg = y.wrg_id) a
;

delete from dbp_data.artbew_gtin_1
where mandant_id in (3,5,6,8) and
      dat between current_date-10 and current_date-1
;

insert into dbp_data.artbew_gtin_1 (mandant_id
                                 ,wup_id
                                 ,dat
                                 ,art_id
                                 ,gp_id
                                 ,bewart_id
                                 ,aktion_id
                                 ,promo_fg
                                 ,ean_kasse
                                 ,nb_id
                                 ,herst_id
                                 ,mwst_id
                                 ,wrg_1
                                 ,menge
                                 ,umsatz_netto
                                 ,diff_umsatz_netto_konz
                                 ,umsatz_mwst_betrag
                                 ,diff_umsatz_mwst_betrag_konz)
select mandant_id
      ,wup_id
      ,dat
      ,art_id
      ,gp_id
      ,bewart_id
      ,aktion_id
      ,promo_fg
      ,ean_kasse
      ,nb_id
      ,herst_id
      ,mwst_id
      ,wrg_1
      ,menge_sum
      ,umsatz_netto_sum
      ,diff_umsatz_netto_konz
      ,umsatz_mwst_betrag_sum
      ,diff_umsatz_mwst_betrag_konz
from (select mandant_id
            ,wup_id
            ,dat
            ,art_id
            ,gp_id
            ,bewart_id
            ,aktion_id
            ,promo_fg
            ,ean_kasse
            ,nb_id
            ,herst_id
            ,mwst_id
            ,wrg_1
            ,sum(menge) as menge_sum
            ,sum(umsatz_netto) as umsatz_netto_sum
            ,sum(umsatz_mwst_betrag) as umsatz_mwst_betrag_sum
            ,sum(diff_umsatz_netto_konz) diff_umsatz_netto_konz
            ,sum(diff_umsatz_mwst_betrag_konz) diff_umsatz_mwst_betrag_konz
      from dbp_etl.artbew_kmo_tmp_1
      where mandant_id in (3,5,6,8) and
            dat between current_date-10 and current_date-1
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13) a
;

delete from dbp_data.artbew_gtin_1
where mandant_id in (1,2,4,7) and
      dat between current_date-10 and current_date-1
;

insert into dbp_data.artbew_gtin_1 (mandant_id
                                 ,wup_id
                                 ,dat
                                 ,art_id
                                 ,gp_id
                                 ,bewart_id
                                 ,aktion_id
                                 ,promo_fg
                                 ,ean_kasse
                                 ,nb_id
                                 ,herst_id
                                 ,mwst_id
                                 ,wrg_1
                                 ,menge
                                 ,umsatz_netto
                                 ,diff_umsatz_netto_konz
                                 ,umsatz_mwst_betrag
                                 ,diff_umsatz_mwst_betrag_konz)
select mandant_id
      ,wup_id
      ,dat
      ,art_id
      ,gp_id
      ,bewart_id
      ,aktion_id
      ,promo_fg
      ,ean_kasse
      ,nb_id
      ,herst_id
      ,mwst_id
      ,wrg_1
      ,menge
      ,umsatz_netto
      ,diff_umsatz_netto_konz
      ,umsatz_mwst_betrag
      ,diff_umsatz_mwst_betrag_konz
from dbp_data.artbew_1
where mandant_id in (1,2,4,7) and
      dat between current_date-10 and current_date-1
;

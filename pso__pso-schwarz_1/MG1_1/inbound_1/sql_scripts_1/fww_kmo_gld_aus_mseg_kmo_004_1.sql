insert into dbp_etl.gld_dat_1 (dat)
select dat
from dbp_data.tag_1
where dat between (select min(dat) from dbp_data.tag_1 where akt_mo = -12) and current_date and
      dat not in (select dat from dbp_etl.gld_dat_1)
;

create or replace table dbp_etl.tmp_art_wup_tag_gld_1 (
  art_id integer not null,
  mandant_id byteint not null,
  wup_id integer not null,
  nb_id smallint not null,
  dat date not null,
  ek_gld decimal(18,4),
  umrechnungskurs float
);

create or replace table dbp_etl.snap_art_wup_tag_gld_1 as (
select x.mandant_id,
       x.art_id,
       x.wup_id,
       x.nb_id,
       x.dat_buch,
       sum(cast(x.sum_betrag as decimal(18,4))) as sum_betrag,
       sum(cast(x.sum_menge as decimal(18,4)))  as sum_menge
from (select mandant_id
            ,art_id
            ,wup_id
            ,nb_id
            ,dat_buch
            ,abs(sum(cast((betrag_lagerbew ) as decimal(18,4)))) as sum_betrag
            ,abs(sum(menge_lagerbew_bme)) as sum_menge
      from dbp_data.lagerbew_det_1 l
      join dbp_etl.gld_dat_1 d
        on dat_buch = dat
      where l.lager_bewart_id in ('251','252') and 
            l.mandant_id > 1
      group by 1,2,3,4,5
      union all
      select mandant_id
            ,art_id
            ,wup_id
            ,nb_id
            ,dat_buch
            ,abs(sum(cast((betrag_lagerbew ) as decimal(18,4)))) as sum_betrag
            ,abs(sum(menge_lagerbew_bme)) as sum_menge
      from dbp_data.lagerbew_det_delta_1 l
      join dbp_etl.gld_dat_1 d
        on dat_buch = dat
      where l.lager_bewart_id in ('251','252') and 
            l.mandant_id > 1
      group by 1,2,3,4,5) x
group by 1,2,3,4,5
);

insert into dbp_etl.tmp_art_wup_tag_gld_1 (mandant_id
                                        ,art_id
                                        ,wup_id
                                        ,nb_id
                                        ,dat
                                        ,ek_gld
                                        ,umrechnungskurs)
select a.mandant_id
      ,a.art_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat_buch
      ,case
         when sum_menge = 0 
         then 0 /*bei division durch 0: ek_gld = 0*/
         else sum_betrag/sum_menge
       end as ek_gld
      ,k.umrechnungskurs
from dbp_etl.snap_art_wup_tag_gld_1 a
join dbp_data.mandant_1 m
  on a.mandant_id = m.mandant_id
join dbp_data.kurs_1 k
  on k.von_wrg_id = m.default_wrg and 
     k.kurstyp_id = 3 and
     k.nach_wrg_id = 'EUR' and
     --a.dat_buch between k.dat_von and k.dat_bis
     k.dat_bis = '9999-12-31'
;

insert into dbp_etl_process.ekc_artbew_agg_wt_1 (mandant_id,
                                               wup_id,
                                               nb_id,
                                               dat)
select mandant_id,
       wup_id,
       nb_id,
       dat
from dbp_etl.tmp_art_wup_tag_gld_1
where (mandant_id,wup_id,nb_id,dat) not in (select mandant_id,wup_id,nb_id,dat from dbp_etl_process.ekc_artbew_agg_wt_1)
group by 1,2,3,4
;

create or replace table dbp_etl.fehlende_art_wup_tag_gld_1 as (
select a.mandant_id,
       a.wup_id,
       a.art_id,
       a.dat
from (select a.mandant_id,
             a.wup_id,
             a.art_id,
             a.dat
      from dbp_data.artbew_1 a
      join dbp_etl.gld_dat_1 c
        on a.dat = c.dat
      where a.mandant_id > 1
      group by 1,2,3,4) a
left join dbp_etl.tmp_art_wup_tag_gld_1 b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat
where b.umrechnungskurs is null
group by 1,2,3,4
);

create or replace table dbp_etl.abweichende_art_wup_tag_gld_1 as (
select b.mandant_id,
       b.dat,
       b.wup_id,
       b.art_id,
       b.ek_gld,
       b.umrechnungskurs
from dbp_data.artbew_1 a
join dbp_data.art_1 d
  on a.mandant_id = d.mandant_id and
     a.art_id = d.art_id
join dbp_etl.gld_dat_1 c
  on a.dat = c.dat
join dbp_etl.tmp_art_wup_tag_gld_1 b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat
where  a.ek_gld <> cast(b.ek_gld*a.menge as decimal(18,4)) and
       a.art_id > -1 and
       d.wg_art_fg = 0
group by 1,2,3,4,5,6
);

-- 1. Update - Artikel_1 ohne MSEG-Bewegung auf 0.
update dbp_data.artbew_1 from (select *
                             from dbp_etl.fehlende_art_wup_tag_gld_1) b

set ek_gld = 0,
    diff_ek_gld_konz = 0

where dbp_data.artbew.mandant_id = b.mandant_id and
      dbp_data.artbew.wup_id = b.wup_id and
      dbp_data.artbew.art_id = b.art_id and
      dbp_data.artbew.dat = b.dat and
      dbp_data.artbew.mandant_id > 1
;

-- 2. Update - Unbekannte Artikel_1 auf Spanne 0%.
update dbp_data.artbew_1
from dbp_etl.gld_dat_1

set ek_gld = umsatz_netto
   ,diff_ek_gld_konz = diff_umsatz_netto_konz

where dbp_data.artbew.dat = dbp_etl.gld_dat.dat and 
      dbp_data.artbew.mandant_id > 1 and
      dbp_data.artbew.art_id = -1
;

-- 3. Update - WG-Erfassartikel auf EK1N.
update dbp_data.artbew_1
from dbp_data.art_1 a
    ,dbp_etl.gld_dat_1

set ek_gld = ek_netto
   ,diff_ek_gld_konz = diff_ek_netto_konz

where dbp_data.artbew.dat = dbp_etl.gld_dat.dat and 
      dbp_data.artbew.mandant_id > 1 and
      dbp_data.artbew.mandant_id = a.mandant_id and 
      dbp_data.artbew.art_id = a.art_id and 
      dbp_data.artbew.art_id > -1 and 
      a.wg_art_fg = 1 /*warengruppenerfassartikel*/
;

-- 4. Update - Regulaeres Update auf unterschiedliche EK-GLD-Werte.
update dbp_data.artbew_1 from (select *
                             from dbp_etl.abweichende_art_wup_tag_gld_1) b
set ek_gld = b.ek_gld*menge
   ,diff_ek_gld_konz = b.ek_gld*menge*b.umrechnungskurs

where dbp_data.artbew.mandant_id = b.mandant_id and
      dbp_data.artbew.wup_id = b.wup_id and
      dbp_data.artbew.art_id = b.art_id and
      dbp_data.artbew.dat = b.dat and
      dbp_data.artbew.mandant_id > 1
;

drop table if exists dbp_etl.gld_dat_1;
drop table if exists dbp_etl.tmp_art_wup_tag_gld_1;

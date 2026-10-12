create or replace volatile table _dedup as (
select *
from ${TEMP_TABLE}
qualify row_number() over (partition by art_id,mandant_id,bewertungskreis_id order by art_id,mandant_id,bewertungskreis_id,dat_aenderung desc) = 1
);

delete from _dedup
where (mandant_id,art_id) in (select mandant_id,art_id 
                              from dbp_data.art_wg_zu_per_2
                              where arthiertyp_id = 2 and
                                    dat_bis = '9999-12-31' and
                                    wg_id = 961)
;

create or replace volatile table _xxx as (
select a.mandant_id,
       a.bewertungskreis_id,
       a.art_id,
       a.gjmo_bis,
       c.gjmo+100 as gjmo
from _dedup a
join dbp_data.monat_2 b
  on a.gjmo_bis-100 = b.gjmo
join dbp_data.monat_2 c
  on b.akt_mo-1 = c.akt_mo
group by 1,2,3,4,5
union
select a.mandant_id,
       a.bewertungskreis_id,
       a.art_id,
       a.gjmo_bis,
       c.gjmo+100 as gjmo
from _dedup a
join dbp_data.monat_2 b
  on a.gjmo-100 = b.gjmo
join dbp_data.monat_2 c
  on b.akt_mo-1 = c.akt_mo
group by 1,2,3,4,5  
);

update dbp_data.art_bewertungskreis_periode_2 from (select a.mandant_id,
                                                         a.bewertungskreis_id,
                                                         a.art_id,
                                                         a.gjmo_bis,
                                                         c.gjmo+100 as gjmo
                                                  from _dedup a
                                                  join dbp_data.monat_2 b
                                                    on a.gjmo_bis-100 = b.gjmo
                                                  join dbp_data.monat_2 c
                                                    on b.akt_mo-1 = c.akt_mo
                                                  where a.gjmo_bis <> 999912
                                                  group by 1,2,3,4,5
                                                  union
                                                  select a.mandant_id,
                                                         a.bewertungskreis_id,
                                                         a.art_id,
                                                         a.gjmo_bis,
                                                         b.gjmo
                                                  from _dedup a
                                                  join (select mandant_id,
                                                               gjmo
                                                        from _xxx
                                                        group by 1,2) b
                                                    on a.mandant_id = b.mandant_id
                                                  where a.gjmo_bis = 999912
                                                  group by 1,2,3,4,5) b
                                 
set gjmo_bis = b.gjmo

where dbp_data.art_bewertungskreis_periode.mandant_id = b.mandant_id and
      dbp_data.art_bewertungskreis_periode.bewertungskreis_id = b.bewertungskreis_id and
      dbp_data.art_bewertungskreis_periode.art_id = b.art_id and
     (dbp_data.art_bewertungskreis_periode.gjmo_bis = b.gjmo_bis or
      dbp_data.art_bewertungskreis_periode.gjmo_bis = 999912)
;

update _dedup set gjmo = gjmo_bis
where gjmo = 190001
;

delete from dbp_data.art_bewertungskreis_periode_2
where (mandant_id,bewertungskreis_id,art_id,gjmo) in (select mandant_id,bewertungskreis_id,art_id,gjmo from _dedup)
;

insert into dbp_data.art_bewertungskreis_periode_2 (mandant_id
                                                 ,art_id
                                                 ,bewertungskreis_id
                                                 ,wrg_id
                                                 ,dat_aenderung
                                                 ,menge_bestand_bme
                                                 ,wert_bestand
                                                 ,vk_wert
                                                 ,mbew_fg
                                                 ,gjmo
                                                 ,gjmo_bis
                                                 ,bewertung_klasse_id
                                                 ,preis_steuer_kz
                                                 ,gld
                                                 ,standard_preis
                                                 ,dat_letzte_preisaenderung
                                                 ,vk_wert_netto)
select mandant_id
      ,art_id
      ,bewertungskreis_id
      ,wrg_id
      ,dat_aenderung
      ,menge_bestand_bme
      ,wert_bestand
      ,vk_wert
      ,mbew_fg
      ,gjmo
      ,gjmo_bis
      ,bewertung_klasse_id
      ,preis_steuer_kz
      ,gld
      ,standard_preis
      ,dat_letzte_preisaenderung
      ,vk_wert_netto
from _dedup
;

update dbp_data.art_bewertungskreis_periode_2
set gjmo = gjmo_ab_

from (select
  mandant_id
 ,art_id
 ,bewertungskreis_id
 ,gjmo_bis
 ,to_date(to_char(gjmo_bis),'yyyymm') as gjmo_bis_dat
 ,lag(gjmo_bis_dat,1) over (partition by mandant_id,art_id,bewertungskreis_id order by gjmo_bis_dat asc nulls last) as lag_test
 ,case 
    when lag_test is null
    then to_date(to_char(gjmo),'yyyymm')
    else add_months(lag_test, 1)
  end as dat_ab
 ,to_number(to_char(dat_ab,'yyyymm')) as gjmo_ab_ 
 from dbp_data.art_bewertungskreis_periode_2
 where try_to_date(to_char(gjmo),'yyyymm') is not null
 qualify gjmo_ab_ <> gjmo) d
 where dbp_data.art_bewertungskreis_periode.mandant_id        = d.mandant_id
  and dbp_data.art_bewertungskreis_periode.art_id             = d.art_id
  and dbp_data.art_bewertungskreis_periode.bewertungskreis_id = d.bewertungskreis_id
  and dbp_data.art_bewertungskreis_periode.gjmo_bis           = d.gjmo_bis
  and dbp_data.art_bewertungskreis_periode.gjmo              <> d.gjmo_ab_
;

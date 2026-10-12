-- Neu fuer die Filialumgliederung

create or replace volatile table _backshop_umgliederung as (
select a.mandant_id,
       a.art_id,
       c.wup_id,
       c.nb_id,
       a.art_id as art_id_ref,
       c.orig_wup_id as wup_id_ref,
       c.nb_id as nb_id_ref,
       c.dat_von+50 as dat_bis_ref,
       1.00 as faktor_ref,
       current_timestamp as td_insert,
       current_timestamp as td_update
from dbp_data.art_wg_zu_per_2 a
join dbp_data.wg_filter_zu_2 b
  on a.wg_id = b.wg_id and
     a.mandant_id = b.mandant_id and 
     b.wg_filter_id = 3 and
     b.arthiertyp_id = 2
join dbp_data.wup_2 c
  on 1 = 1 and
     c.wup_aenderung_grund_id = 0 and
     c.wup_id <> c.orig_wup_id and
     current_date <= c.dat_von+50
where a.dat_bis = '9999-12-31' AND 
      a.arthiertyp_id = 2 and
      a.mandant_id = 1
);

update dbp_data.art_wup_status_referenz_2 from (select mandant_id,
                                                     wup_id,
                                                     art_id,
                                                     wup_id_ref,
                                                     dat_bis_ref
                                              from _backshop_umgliederung
                                              group by 1,2,3,4,5) b
                                              
set dat_bis_ref = b.dat_bis_ref

where dbp_data.art_wup_status_referenz.mandant_id = b.mandant_id and
      dbp_data.art_wup_status_referenz.wup_id = b.wup_id and
      dbp_data.art_wup_status_referenz.art_id = b.art_id and
      dbp_data.art_wup_status_referenz.wup_id_ref = b.wup_id_ref
;

delete from dbp_data.art_wup_status_referenz_2
where (mandant_id,wup_id,art_id,wup_id_ref,art_id_ref) in (select mandant_id,wup_id,art_id,wup_id_ref,art_id_ref from _backshop_umgliederung)
;

insert into dbp_data.art_wup_status_referenz_2 (mandant_id
                                             ,art_id
                                             ,wup_id
                                             ,nb_id
                                             ,art_id_ref
                                             ,wup_id_ref
                                             ,nb_id_ref
                                             ,dat_bis_ref
                                             ,faktor_ref
                                             ,td_insert
                                             ,td_update)
select mandant_id
      ,art_id
      ,wup_id
      ,nb_id
      ,art_id_ref
      ,wup_id_ref
      ,nb_id_ref
      ,dat_bis_ref
      ,faktor_ref
      ,td_insert
      ,td_update
from _backshop_umgliederung
where (mandant_id,wup_id,art_id,wup_id_ref) not in (select mandant_id,wup_id,art_id,wup_id_ref from dbp_data.art_wup_status_referenz_2)
;

create or replace table dbp_etl.vis_agg_tmp_2 (
  art_id integer not null,
  mandant_id byteint not null,
  wup_id integer not null,
  nb_id smallint not null,
  dat date not null,
  menge_prognose decimal(9,3) not null,
  menge_prognose_max decimal(9,3) not null,
  menge_prognose_aktion decimal(9,3) not null,
  min_sicherh_bestand decimal(18,3) not null,
  listung_id byteint not null,
  aktion_fg byteint not null,
  menge_check decimal(9,3) not null,
  anteil_01 decimal(9,2) not null,
  anteil_02 decimal(9,2) not null,
  anteil_03 decimal(9,2) not null,
  anteil_04 decimal(9,2) not null,
  tagesmenge smallint not null,
  gff_menge_stueck smallint not null,
  fs1_menge_stueck smallint not null,
  fs2_menge_stueck smallint not null,
  erw_absatz_spaet smallint not null,
  erw_absatz_abend smallint not null,
  avg_menge_abschrift smallint not null,
  wup_cluster_id smallint not null default -1 ,
  wug_cluster_id smallint not null default -1 ,
  back_drehklasse_id char(2) collate 'de-ci' not null default '  ',
  aktion_id char(10) collate 'de-ci' not null default '          ' ,
  menge_schnitt decimal(18,3)
);

create or replace table dbp_etl.vis_fur_tmp_2 (
  mandant_id byteint not null,
  art_id integer not null,
  wup_id integer not null,
  dat date not null,
  menge_fur_mean decimal(18,3) not null,
  menge_fur_max  decimal(18,3) not null,
  menge_fur_aktion decimal(18,3) not null
);

create or replace table dbp_etl.vis_ods_tmp_2 (
  mandant_id byteint not null,
  art_id integer not null,
  wup_id integer not null,
  wtag_id byteint not null,
  aktion_fg byteint not null,
  menge_ods decimal(18,3) not null,
  anz_ods smallint not null,
  menge_schnitt decimal(18,3) not null,
  back_drehklasse_id char(2) not null,
  menge_01 decimal(18,3) not null,
  menge_02 decimal(18,3) not null,
  menge_03 decimal(18,3) not null,
  menge_04 decimal(18,3) not null,
  menge_16 decimal(18,3) not null,
  anz_16 smallint not null
);

create or replace volatile table _vaus as (
select *
from dbp_data.vaus_wup_oeffnung_zu_per_2
);

update _vaus set zeit_von = 28800 /*mfialkiewicz'08:00:00'*/, zeit_bis = 72000/*mfialkiewicz'20:00:00'*/
where mandant_id = 7 and
      wup_oeffnungs_typ_id = 7 and
      wup_id = 4400 and
      zeit_von = 0 and
      zeit_bis = 0
;

insert into dbp_etl.vis_agg_tmp_2 (art_id,
                                 mandant_id,
                                 wup_id,
                                 nb_id,
                                 dat,
                                 menge_prognose,
                                 menge_prognose_max,
                                 menge_prognose_aktion,
                                 min_sicherh_bestand,
                                 listung_id,
                                 aktion_fg,
                                 menge_check,
                                 anteil_01,
                                 anteil_02,
                                 anteil_03,
                                 anteil_04,
                                 tagesmenge,
                                 gff_menge_stueck,
                                 fs1_menge_stueck,
                                 fs2_menge_stueck,
                                 erw_absatz_spaet,
                                 erw_absatz_abend,
                                 avg_menge_abschrift,
                                 wup_cluster_id,
                                 wug_cluster_id,
                                 back_drehklasse_id,
                                 aktion_id,
                                 menge_schnitt)
select a.art_id
      ,a.mandant_id
      ,awsp.wup_id
      ,awsp.nb_id
      ,zeit.dat
      ,0 as menge_prognose
      ,0 as menge_prognose_max
      ,0 as menge_prognose_aktion
      ,awsp.min_sicherh_bestand
      ,awzp.listung_id 
      ,0 as aktion_fg
      ,0 as menge_check
      ,0 as anteil_01
      ,0 as anteil_02
      ,0 as anteil_03
      ,0 as anteil_04
      ,0 as tagesmenge
      ,0 as gff_menge_stueck
      ,0 as fs1_menge_stueck
      ,0 as fs2_menge_stueck
      ,0 as erw_absatz_spaet
      ,0 as erw_absatz_abend
      ,0 as avg_menge_abschrift
      ,0 as wup_cluster_id
      ,0 as wug_cluser_id
      ,'' as back_drehklasse_id
      ,'' as aktion_id,
      0 as menge_schnitt
from dbp_data.art_2 a

join dbp_data.art_wup_status_per_2 awsp
  on a.art_id = awsp.art_id and 
     a.mandant_id = awsp.mandant_id and 
     awsp.dat_bis = '9999-12-31' and 
     awsp.nb_id = 0

join dbp_data.art_wup_zu_per_2 awzp
  on awsp.art_id = awzp.art_id and 
     awsp.mandant_id = awzp.mandant_id and 
     awsp.wup_id = awzp.wup_id and 
     awzp.dat_bis = '9999-12-31' and 
     awzp.nb_id = 0
     
join (select b.dat
      from (select *
            from dbp_data.tag_2
            where dat = current_date) a
      join dbp_data.tag_2 b
        on a.wo_dat_bis + 1 = b.wo_dat_von 
      group by 1) zeit_2
  on 1 = 1

where (a.mandant_id, a.art_id) in (-- alle backshop-artikel_2 
                                   select awzp.mandant_id,
                                          awzp.art_id 
                                   from dbp_data.art_wg_zu_per_2 awzp
                                   join dbp_data.wg_filter_zu_2 wfz
                                     on awzp.wg_id = wfz.wg_id and 
                                        awzp.mandant_id = wfz.mandant_id and 
                                        wfz.wg_filter_id = 3 and 
                                        wfz.arthiertyp_id = 2
                                   where awzp.dat_bis = '9999-12-31' and 
                                         awzp.arthiertyp_id = 2) and 
      (awsp.mandant_id, awsp.wup_id) in (-- eroeffnete filialen
                                         select mandant_id,
                                                wup_id 
                                         from dbp_data.wup_2
                                         where nb_id = 0 and 
                                               dat_eroeffnung-10 < current_date and
                                                -- filialen mit backshop daten
                                              (mandant_id,wup_id) in (select mandant_id,wup_id 
                                                                      from dbp_data.wup_backshop_per_2
                                                                      where dat_bis = '9999-12-31')
                                         group by 1,2) and 
       a.dat_bis = '9999-12-31'
;

delete from dbp_etl.vis_agg_tmp_2 
where mandant_id = 3 and
      wup_id = 1031
;

insert into dbp_etl.vis_agg_tmp_2 (art_id,
                                 mandant_id,
                                 wup_id,
                                 nb_id,
                                 dat,
                                 menge_prognose,
                                 menge_prognose_max,
                                 menge_prognose_aktion,
                                 min_sicherh_bestand,
                                 listung_id,
                                 aktion_fg,
                                 menge_check,
                                 anteil_01,
                                 anteil_02,
                                 anteil_03,
                                 anteil_04,
                                 tagesmenge,
                                 gff_menge_stueck,
                                 fs1_menge_stueck,
                                 fs2_menge_stueck,
                                 erw_absatz_spaet,
                                 erw_absatz_abend,
                                 avg_menge_abschrift,
                                 wup_cluster_id,
                                 wug_cluster_id,
                                 back_drehklasse_id,
                                 aktion_id,
                                 menge_schnitt)
select distinct
       a.art_id
      ,a.mandant_id
      ,awzp.wup_id
      ,awzp.nb_id
      ,zeit.dat
      ,0 as menge_prognose
      ,0 as menge_prognose_max
      ,0 as menge_prognose_aktion
      ,0
      ,awzp.listung_id 
      ,0 as aktion_fg
      ,0 as menge_check
      ,0 as anteil_01
      ,0 as anteil_02
      ,0 as anteil_03
      ,0 as anteil_04
      ,0 as tagesmenge
      ,0 as gff_menge_stueck
      ,0 as fs1_menge_stueck
      ,0 as fs2_menge_stueck
      ,0 as erw_absatz_spaet
      ,0 as erw_absatz_abend
      ,0 as avg_menge_abschrift
      ,0 as wup_cluster_id
      ,0 as wug_cluser_id
      ,'' as back_drehklasse_id
      ,'' as aktion_id,
      0 as menge_schnitt
from dbp_data.art_2 a

join dbp_data.art_wup_zu_per_2 awzp
  on a.art_id = awzp.art_id and 
     a.mandant_id = awzp.mandant_id and 
     awzp.dat_bis = '9999-12-31' and 
     awzp.nb_id = 0
     
join (select b.dat
      from (select *
            from dbp_data.tag_2
            where dat = current_date) a
      join dbp_data.tag_2 b
        on a.wo_dat_bis + 1 = b.wo_dat_von 
      group by 1) zeit_2
  on 1 = 1

where (a.mandant_id, a.art_id) in (-- alle backshop-artikel_2 
                                   select awzp.mandant_id,
                                          awzp.art_id 
                                   from dbp_data.art_wg_zu_per_2 awzp
                                   join dbp_data.wg_filter_zu_2 wfz
                                     on awzp.wg_id = wfz.wg_id and 
                                        awzp.mandant_id = wfz.mandant_id and 
                                        wfz.wg_filter_id = 3 and 
                                        wfz.arthiertyp_id = 2
                                   where awzp.dat_bis = '9999-12-31' and 
                                         awzp.arthiertyp_id = 2) and 
      (awzp.mandant_id, awzp.wup_id) in (-- eroeffnete filialen
                                         select mandant_id,
                                                wup_id 
                                         from dbp_data.wup_2
                                         where nb_id = 0 and 
                                               dat_eroeffnung-10 < current_date and
                                                -- filialen mit backshop daten
                                              (mandant_id,wup_id) in (select mandant_id,wup_id 
                                                                      from dbp_data.wup_backshop_per_2
                                                                      where dat_bis = '9999-12-31')
                                         group by 1,2) and 
       a.dat_bis = '9999-12-31' and
       awzp.mandant_id = 3 and
       awzp.wup_id = 1031
;

update dbp_etl.vis_agg_tmp_2 from (select a.mandant_id,
                                        a.wup_id,
                                        a.art_id,
                                        min(a.dat) as min_dat,
                                        min(b.dat_von) as min_dat_von
                                 from dbp_etl.vis_agg_tmp_2 a
                                 join dbp_data.art_wup_zu_per_2 b
                                   on a.art_id = b.art_id and 
                                      a.mandant_id = b.mandant_id and 
                                      a.wup_id = b.wup_id 
                                 where b.listung_id = 1
                                 group by 1,2,3
                                 having min_dat_von >= min_dat-21) b
                                                
set listung_id = 2

where dbp_etl.vis_agg_tmp.mandant_id = b.mandant_id and
      dbp_etl.vis_agg_tmp.wup_id = b.wup_id and
      dbp_etl.vis_agg_tmp.art_id = b.art_id
;

create or replace volatile table _upd_posten as (
select b.*,
       max(a.aktion_id) as aktion_id_
from dbp_data.aktion_art_wup_zu_2 a
join dbp_etl.vis_agg_tmp_2 b
  on a.art_id = b.art_id and
     a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.nb_id = b.nb_id 
join dbp_data.aktion_2 c
  on a.mandant_id = c.mandant_id and
     a.aktion_id = c.aktion_id and
     b.dat between c.dat_von and c.dat_bis+7
join dbp_data.art_2 d
  on a.mandant_id = d.mandant_id and
     a.art_id = d.art_id and
     d.dat_bis = '9999-12-31' and
     d.posten_id in ('PN','SP','PS','1')
where a.grund_sperrung is null and
      case
        when c.mandant_id = 1
        then c.preisaktiviert_fg
        when c.mandant_id > 1 and
             a.dat_preisaktiviert <> '1900-01-01' and
            (c.mandant_id,c.aktion_id) not in (select mandant_id,aktion_id
                                               from dbp_data.l_bonuskauf_2)
        then 1
        else 0
      end = 1
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
         18,19,20,21,22,23,24,25,26,27,28
);

update dbp_etl.vis_agg_tmp_2 from (select mandant_id,
                                        art_id,
                                        wup_id
                                 from _upd_posten
                                 group by 1,2,3) b
                                                
set listung_id = 4

where dbp_etl.vis_agg_tmp.mandant_id = b.mandant_id and
      dbp_etl.vis_agg_tmp.wup_id = b.wup_id and
      dbp_etl.vis_agg_tmp.art_id = b.art_id
;

create or replace volatile table _snapshot_2 as (
select a.mandant_id,
       a.wup_id,
       a.art_id,
       a.dat
from dbp_msi_data.backshop_prognose_neu_2 a
join (select b.dat
      from (select *
            from dbp_data.tag_2
            where dat = current_date) a
      join dbp_data.tag_2 b
        on a.wo_dat_von-1 = b.wo_dat_bis
      group by 1) x
  on a.dat = x.dat
where a.listung_id_backshop = 4 and
     (a.mandant_id,a.art_id,a.wup_id) not in (select mandant_id,art_id,wup_id from _upd_posten)
group by 1,2,3,4
);

update dbp_etl.vis_agg_tmp_2 set listung_id = 5 -- Posten AS!

from (select a.mandant_id,
             a.wup_id,
             a.art_id,
             min(a.dat) as min_dat,
             max(b.max_dat_bis) as max_dat_bis_
      from _snapshot_2 a
      join (select y.mandant_id,
                   y.wup_id,
                   y.art_id,
                   y.dat_von,
                   max(y.dat_bis) as max_dat_bis
            from dbp_data.art_list_wup_zu_per_2 y
            join (select mandant_id,
                         wup_id,
                         art_id,
                         min(dat_von) as min_dat_von
                  from dbp_data.art_list_wup_zu_per_2
                  where list_quelle_id = 'c' and
                        current_date between dat_von and dat_bis+28
                  group by 1,2,3) x
              on y.mandant_id = x.mandant_id and
                 y.wup_id = x.wup_id and
                 y.art_id = x.art_id and
                 y.dat_von = x.min_dat_von
            where y.list_quelle_id = 'C'
            group by 1,2,3,4) b
        on a.art_id = b.art_id and 
           a.mandant_id = b.mandant_id and 
           a.wup_id = b.wup_id 
      group by 1,2,3
      having max_dat_bis_ <= min_dat+28) b

where dbp_etl.vis_agg_tmp.mandant_id = b.mandant_id and
      dbp_etl.vis_agg_tmp.wup_id = b.wup_id and
      dbp_etl.vis_agg_tmp.art_id = b.art_id 
;

update dbp_etl.vis_agg_tmp_2 set listung_id = 3

from (select a.mandant_id,
             a.wup_id,
             a.art_id,
             min(a.dat) as min_dat,
             max(b.max_dat_bis) as max_dat_bis_
      from dbp_etl.vis_agg_tmp_2 a
      join (select y.mandant_id,
                   y.wup_id,
                   y.art_id,
                   y.dat_von,
                   max(y.dat_bis) as max_dat_bis
            from dbp_data.art_list_wup_zu_per_2 y
            join (select mandant_id,
                         wup_id,
                         art_id,
                         min(dat_von) as min_dat_von
                  from dbp_data.art_list_wup_zu_per_2
                  where list_quelle_id = 'C' and
                        current_date between dat_von and dat_bis+28
                  group by 1,2,3) x
              on y.mandant_id = x.mandant_id and
                 y.wup_id = x.wup_id and
                 y.art_id = x.art_id and
                 y.dat_von = x.min_dat_von
            where y.list_quelle_id = 'c'
            group by 1,2,3,4) b
        on a.art_id = b.art_id and 
           a.mandant_id = b.mandant_id and 
           a.wup_id = b.wup_id 
      group by 1,2,3
      having max_dat_bis_ <= min_dat+28) b

where dbp_etl.vis_agg_tmp.mandant_id = b.mandant_id and
      dbp_etl.vis_agg_tmp.wup_id = b.wup_id and
      dbp_etl.vis_agg_tmp.art_id = b.art_id and
      dbp_etl.vis_agg_tmp.listung_id not in (2,4,5)
;

delete from dbp_etl.vis_agg_tmp_2
where listung_id = 0
;

create or replace volatile table _update as (
select b.*,
       max(a.aktion_id) as aktion_id_
from dbp_data.aktion_art_wup_zu_2 a
join dbp_etl.vis_agg_tmp_2 b
  on a.art_id = b.art_id and
     a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.nb_id = b.nb_id 
join dbp_data.aktion_2 c
  on a.mandant_id = c.mandant_id and
     a.aktion_id = c.aktion_id and
     b.dat between c.dat_von and c.dat_bis
where a.grund_sperrung is null and
      case
        when c.mandant_id = 1
        then c.preisaktiviert_fg
        when c.mandant_id > 1 and
             a.dat_preisaktiviert <> '1900-01-01' and
            (c.mandant_id,c.aktion_id) not in (select mandant_id,aktion_id
                                               from dbp_data.l_bonuskauf_2)
        then 1
        else 0
      end = 1
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
         18,19,20,21,22,23,24,25,26,27,28
);

update dbp_etl.vis_agg_tmp_2 from (select *
                                 from _update) b

set aktion_fg = 1,
    aktion_id = b.aktion_id_
						  
where dbp_etl.vis_agg_tmp.mandant_id = b.mandant_id and
      dbp_etl.vis_agg_tmp.wup_id = b.wup_id and
      dbp_etl.vis_agg_tmp.nb_id = b.nb_id and
      dbp_etl.vis_agg_tmp.art_id = b.art_id and
      dbp_etl.vis_agg_tmp.dat = b.dat
;

create or replace volatile table _zwischentabelle (
  mandant_id byteint,
  wup_id integer,
  kl_art_id integer,
  dat date,
  letzter_abverkauf time,
  wtag_id integer,
  back_intervall smallint,
  menge decimal(18,3),
  menge_abschrift integer
);

create or replace volatile table _track_bake_articles as (
select awzp.mandant_id
      ,case 
         when awzp.mandant_id > 1
         then floor(awzp.art_id/10)
         else floor(awzp.art_id/100)
       end as kl_art_id 
from dbp_data.art_wg_zu_per_2 awzp
join dbp_data.wg_filter_zu_2 wfz
  on awzp.wg_id = wfz.wg_id and 
     awzp.mandant_id = wfz.mandant_id and 
     wfz.wg_filter_id = 3 and 
     wfz.arthiertyp_id = 2
where awzp.dat_bis = '9999-12-31' and 
      awzp.arthiertyp_id = 2
);

create or replace volatile table _track_bons as (
select a.*
from dbp_ods.ods_bon_verkauf_2 a
join _track_bake_articles b
  on a.mandant_id = b.mandant_id and
     a.kl_art_id = b.kl_art_id
where a.bon_dat between current_date-49 and current_date-1 and
     (a.mandant_id,a.wup_id) in (select mandant_id,wup_id 
                                 from dbp_data.wup_backshop_per_2
                                 where dat_bis = '9999-12-31')
);

insert into _zwischentabelle
select t01.mandant_id
      ,x.wup_id
      ,case 
         when t01.mandant_id > 1
         then floor(x.art_id/10)
         else floor(x.art_id/100)
       end as kl_art_id
      ,t01.bon_dat as dat
      ,to_time(to_char(extract(hour from t01.start_bon_zeile)||':00:00'),'HH24:MI:SS') as letzer_abverkauf
      ,mod(datediff(day,'1900-01-01',dat), 7)+1 as wtag_id
      ,hour(t01.start_bon_zeile) as back_intervall
      ,sum(t01.menge*x.faktor_ref) as menge
      ,sum(0) as menge_abschrift
from _track_bons t01
join dbp_data.art_wup_status_referenz_2 x
  on t01.mandant_id = x.mandant_id and
     t01.wup_id = x.wup_id_ref and
     t01.kl_art_id = case 
                       when t01.mandant_id > 1
                       then floor(x.art_id_ref/10)
                       else floor(x.art_id_ref/100)
                     end and
     t01.bon_dat <= x.dat_bis_ref
group by 1,2,3,4,5,6,7
;

insert into _zwischentabelle
select t01.mandant_id
      ,t02.aktuell_wup_id as wup_id
      ,t01.kl_art_id
      ,t01.bon_dat as dat
      ,to_time(to_char( extract(hour from t01.start_bon_zeile)||':00:00'),'HH24:MI:SS') as letzer_abverkauf
      ,mod(datediff(day,'1900-01-01',dat), 7)+1 as wtag_id
      ,hour(t01.start_bon_zeile) as back_intervall
      ,sum(t01.menge) as menge
      ,sum(0) as menge_abschrift
from _track_bons t01
join dbp_data.wup_2 t02
  on t01.wup_id = t02.wup_id and
     t01.mandant_id = t02.mandant_id
where (t01.mandant_id,t02.aktuell_wup_id,t01.kl_art_id,dat) not in (select mandant_id,wup_id,kl_art_id,dat from _zwischentabelle)
group by 1,2,3,4,5,6,7
;

UPDATE _zwischentabelle SET letzter_abverkauf = CASE
                                                  WHEN CAST(SUBSTR(CAST(letzter_abverkauf AS CHAR(8)),1,2) AS INTEGER) <= 21
                                                  THEN to_time(to_char((TRIM(CAST(SUBSTR(CAST(letzter_abverkauf AS CHAR(8)),1,2) as INTEGER)+1)) ||':00:00' ), 'HH24:MI:SS') 
                                                   ELSE to_time('22:00:00', 'HH24:MI:SS')  
                                                END
;

INSERT INTO DBP_ETL.vis_fur_tmp_2 (mandant_id
                                ,art_id
                                ,wup_id
                                ,dat
                                ,menge_fur_mean
                                ,menge_fur_max
                                ,menge_fur_aktion)
SELECT t01.mandant_id
      ,t01.art_id
      ,t01.wup_id
      ,t01.dat
      ,CASE WHEN t01.menge_prognose = 0 AND t01.menge_prognose_max <> 0 THEN t01.menge_prognose_max ELSE t01.menge_prognose END AS menge_fur_mean
      ,CASE WHEN t01.menge_prognose_max = 0 AND t01.menge_prognose <> 0 THEN t01.menge_prognose ELSE t01.menge_prognose_max END AS menge_fur_max
      ,t01.menge_prognose_aktion AS menge_fur_aktion
FROM DBP_DATA.fur_prognose_2 t01
JOIN (SELECT MIN(b.dat) AS min_dat,
             MAX(b.dat) AS max_dat
      FROM (SELECT *
            FROM DBP_DATA.tag_2
            WHERE dat = CURRENT_DATE) a
      JOIN DBP_DATA.tag_2 b
        ON a.wo_dat_bis + 1 = b.wo_dat_von) t02 
  ON 1 = 1
WHERE (t01.mandant_id,t01.art_id) IN (-- nur Backshop-Artikel_2
                                      SELECT awzp.mandant_id,
                                             awzp.art_id 
                                      FROM DBP_DATA.art_wg_zu_per_2 awzp
                                      JOIN DBP_DATA.wg_filter_zu_2 wfz
                                        ON awzp.wg_id = wfz.wg_id AND 
                                           awzp.mandant_id = wfz.mandant_id AND 
                                           wfz.wg_filter_id = 3 AND 
                                           wfz.arthiertyp_id = 2
                                      WHERE awzp.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND 
                                            awzp.arthiertyp_id = 2) AND 
       t01.dat BETWEEN t02.min_dat AND t02.max_dat -- Folgewoche von Mo. bis So.
;

DELETE FROM DBP_ETL.vis_fur_tmp_2
WHERE (mandant_id,art_id,wup_id,dat) IN (SELECT x.mandant_id,
                                                x.art_id,
                                                x.wup_id,
                                                z.dat
                                         FROM DBP_DATA.fur_prognose_2 x
                                         JOIN (SELECT mandant_id,
                                                      art_id,
                                                      wup_id,
                                                     --mfialkiewicz
                                                     MOD(datediff(day,'1900-01-01',dat), 7)  + 1 AS wtag_id,
                                                     MAX(dat) AS max_dat
                                               FROM DBP_DATA.fur_prognose_2
                                               WHERE (mandant_id,art_id) IN (SELECT mandant_id,
                                                                                    art_id
                                                                             FROM DBP_ETL.vis_agg_tmp_2
                                                                             WHERE listung_id = 3) AND
                                                      dat BETWEEN CURRENT_DATE()-60 AND (SELECT MAX(b.dat) AS max_dat
                                                                               FROM (SELECT *
                                                                                     FROM DBP_DATA.tag_2
                                                                                     WHERE dat = CURRENT_DATE) a
                                                                               JOIN DBP_DATA.tag_2 b
                                                                                 ON a.wo_dat_bis + 1 = b.wo_dat_von) AND
                                                     (menge_prognose <> 0 OR
                                                      menge_prognose_max <> 0)
                                               GROUP BY 1,2,3,4) y
                                           ON x.mandant_id = y.mandant_id AND
                                                x.art_id = y.art_id AND
                                                x.wup_id = y.wup_id AND
                                                x.dat = y.max_dat
                                         JOIN (SELECT b.wtag_id,
                                                      b.dat
                                               FROM (SELECT *
                                                     FROM DBP_DATA.tag_2
                                                     WHERE dat = CURRENT_DATE()) a
                                               JOIN DBP_DATA.tag_2 b
                                                 ON a.wo_dat_bis + 1 = b.wo_dat_von) z
                                           ON y.wtag_id = z.wtag_id) AND
      menge_fur_mean = 0 AND
      menge_fur_max = 0 AND
      menge_fur_aktion = 0
;

INSERT INTO DBP_ETL.vis_fur_tmp_2 (mandant_id
                                               ,art_id
                                               ,wup_id
                                               ,dat
                                               ,menge_fur_mean
                                               ,menge_fur_max
                                               ,menge_fur_aktion) 
SELECT t01.mandant_id
      ,t01.art_id
      ,t01.wup_id
      ,t03.dat
      ,CASE WHEN t01.menge_prognose = 0 THEN t01.menge_prognose_max ELSE t01.menge_prognose END AS menge_fur_mean
      ,CASE WHEN t01.menge_prognose_max = 0 THEN t01.menge_prognose ELSE t01.menge_prognose_max END AS menge_fur_max
      ,t01.menge_prognose_aktion AS menge_fur_aktion
FROM DBP_DATA.fur_prognose_2 t01
JOIN (SELECT mandant_id,
             art_id,
             wup_id,
             MOD(datediff(day,'1900-01-01',dat), 7)  + 1 AS wtag_id,
      MAX(dat) AS max_dat
      FROM DBP_DATA.fur_prognose_2
      WHERE (mandant_id,art_id) IN (SELECT mandant_id,
                                           art_id
                                    FROM DBP_ETL.vis_agg_tmp_2
                                    WHERE listung_id = 3) AND
             dat BETWEEN CURRENT_DATE()-60 AND (SELECT MAX(b.dat) AS max_dat
                                      FROM (SELECT *
                                            FROM DBP_DATA.tag_2
                                            WHERE dat = CURRENT_DATE()) a
                                      JOIN DBP_DATA.tag_2 b
                                        ON a.wo_dat_bis + 1 = b.wo_dat_von) AND
            (menge_prognose <> 0 OR
             menge_prognose_max <> 0)
      GROUP BY 1,2,3,4) t02
  ON t01.mandant_id = t02.mandant_id AND
     t01.art_id = t02.art_id AND
     t01.wup_id = t02.wup_id AND
     t01.dat = t02.max_dat
JOIN (SELECT b.wtag_id,
             b.dat
      FROM (SELECT *
            FROM DBP_DATA.tag_2
            WHERE dat = CURRENT_DATE()) a
      JOIN DBP_DATA.tag_2 b
        ON a.wo_dat_bis + 1 = b.wo_dat_von) t03
  ON t02.wtag_id = t03.wtag_id
WHERE (t01.mandant_id,t01.wup_id,t01.art_id,t03.dat) NOT IN (SELECT mandant_id,wup_id,art_id,dat
                                                             FROM DBP_ETL.vis_fur_tmp_2)
;

INSERT INTO DBP_ETL.vis_ods_tmp_2 (mandant_id
                                               ,wup_id
                                               ,art_id
                                               ,wtag_id
                                               ,aktion_fg
                                               ,menge_ods
                                               ,anz_ods
                                               ,menge_schnitt
                                               ,back_drehklasse_id
                                               ,menge_01
                                               ,menge_02
                                               ,menge_03
                                               ,menge_04
                                               ,menge_16
                                               ,anz_16)
SELECT x.mandant_id
      ,x.wup_id
      ,c.art_id
      ,x.wtag_id
      ,0 AS aktion_fg
      ,SUM(x.menge*COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END,1)) AS menge_ods -- Gesamtmenge (ueber 49 Tage) pro Wochentag
      ,COUNT(DISTINCT x.dat) AS anz_ods   -- Anzahl Tage mit Abverkauf pro Wochentag
      ,menge_ods/anz_ods AS menge_schnitt
      ,'' back_drehklasse_id
      ,SUM(CASE WHEN x.back_intervall IN (4,5,6,7,8,9) THEN x.menge*COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END,1) ELSE 0 END) AS menge_01  -- Backintervall 01
      ,SUM(CASE WHEN x.back_intervall IN (4,5,6,7,8,9,10,11,12,13) THEN x.menge*COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END,1) ELSE 0 END) AS menge_02  -- Backintervall 02
      ,SUM(CASE WHEN x.back_intervall IN (11,12,13,14,15,16,17) THEN x.menge*COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END,1) ELSE 0 END) AS menge_03  -- Backintervall 03
      ,SUM(CASE WHEN x.back_intervall IN (0,1,2,3,16,17,18,19,20,21,22,23,24) THEN x.menge*COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END,1) ELSE 0 END) AS menge_04  -- Backintervall 04
      ,SUM(CASE WHEN x.back_intervall BETWEEN 4 AND 16 THEN x.menge*COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END,1) ELSE 0 END)                  AS menge_16  -- Kontrolle 16 Uhr
      ,COUNT(DISTINCT CASE WHEN x.back_intervall BETWEEN 4 AND 16 THEN x.dat END)                                           AS anz_16    -- Kontrolle 16 Uhr
FROM _zwischentabelle x
JOIN DBP_DATA.art_2 c
  ON x.mandant_id = c.mandant_id AND
     x.kl_art_id = c.kl_art_id AND
     c.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
LEFT JOIN (SELECT a.mandant_id,
                  a.art_id,
                  b.inhalt_menge
           FROM DBP_DATA.art_backshop_zu_2 a
           JOIN DBP_DATA.art_backshop_2 b
             ON a.mandant_id = b.mandant_id AND
                a.bestell_art_id = b.bestell_art_id) y
  ON c.mandant_id = y.mandant_id AND
     c.art_id = y.art_id
GROUP BY 1,2,3,4
;

UPDATE DBP_ETL.vis_ods_tmp_2 SET back_drehklasse_id = b.back_drehklasse_id
FROM (SELECT                                           x.mandant_id,
                                                       x.wup_id,
                                                       x.art_id,
                                                       MOD(datediff(day,'1900-01-01',x.dat), 7)  + 1 AS wtag_id,
                                                       CASE
                                                         WHEN x.menge_fur_aktion <> 0
                                                         THEN x.menge_fur_aktion
                                                         WHEN x.menge_fur_max <> 0
                                                         THEN x.menge_fur_max
                                                         ELSE x.menge_fur_mean
                                                       END AS prognose_menge,
                                                       CASE
	                                     WHEN prognose_menge >= 0  AND prognose_menge < 10
	                                     THEN 'LD'
	                                     WHEN prognose_menge >= 10 AND prognose_menge < 25
	                                     THEN 'MD'
	                                     ELSE 'SD' 
                                                       END AS back_drehklasse_id
                                                FROM DBP_ETL.vis_fur_tmp_2 x
                                                GROUP BY 1,2,3,4,5,6) b
								 
WHERE DBP_ETL.vis_ods_tmp.mandant_id = b.mandant_id AND
      DBP_ETL.vis_ods_tmp.wup_id = b.wup_id AND
      DBP_ETL.vis_ods_tmp.art_id = b.art_id AND
      DBP_ETL.vis_ods_tmp.wtag_id = b.wtag_id
;

UPDATE DBP_ETL.vis_ods_tmp_2 SET back_drehklasse_id = 'LD'
WHERE back_drehklasse_id = ''
;

CREATE or replace VOLATILE TABLE _markt_oeffnungen (
  mandant_id BYTEINT,
  wup_id INTEGER,
  wtag_id BYTEINT,
  --mfialkiewicz
  offen_von time /*INTEGER*/,
  offen_bis time /*INTEGER*/
) ;

INSERT INTO _markt_oeffnungen
SELECT a.mandant_id,
       a.wup_id,
       a.wup_oeffnungs_typ_id AS wtag_id,
       --CAST(CASE WHEN CAST(a.zeit_von AS INTEGER FORMAT '99:99:99') = '00:00:00' THEN '00:01:00' ELSE CAST(a.zeit_von AS INTEGER FORMAT '99:99:99') END AS INTEGER FORMAT '99:99:99') AS offen_von,
       --CAST(CASE WHEN CAST(a.zeit_bis AS INTEGER FORMAT '99:99:99') = '00:00:00' THEN '23:59:00' ELSE CAST(a.zeit_bis AS INTEGER FORMAT '99:99:99') END AS INTEGER FORMAT '99:99:99') AS offen_bis
       --mfialkiewicz
       case when try_to_time(lpad(cast(cast(a.zeit_von as integer) as varchar),6,'0'), 'HH24MISS') = '000000'  
          THEN '00:00:00' else try_to_time(lpad(cast(cast(a.zeit_von as integer) as varchar),6,'0'), 'HH24MISS') end as offen_von,
       case when try_to_time(lpad(cast(cast(a.zeit_bis as integer) as varchar),6,'0'), 'HH24MISS') IS NULL or try_to_time(lpad(cast(cast(a.zeit_bis as integer) as varchar),6,'0'), 'HH24MISS')  = '000000'
          THEN '00:00:00' else try_to_time(lpad(cast(cast(a.zeit_bis as integer) as varchar),6,'0'), 'HH24MISS') end as offen_bis
  FROM _vaus a
GROUP BY 1,2,3,4,5
;

CREATE or replace VOLATILE TABLE _x_abs AS (
SELECT a1.mandant_id,
       a1.wup_id,
       a1.art_id,
       CASE
         WHEN a1.wtag_id IN (7,1)
         THEN 6
         ELSE a1.wtag_id-1
       END AS wtag_id_,
       CASE
         WHEN a1.wtag_id IN (1)
         THEN a1.dat-2
         ELSE a1.dat-1
       END AS dat_,
       SUM(a1.menge_abschrift) AS menge_abschrift
FROM (SELECT a.mandant_id,
             a.wup_id,
             a.art_id,
             --((a.dat - CURRENT_DATE '1900-01-01') MOD 7) + 1 AS wtag_id,
             --mfialkiewicz
             MOD(datediff(day,'1900-01-01',a.dat), 7)  + 1 AS wtag_id,
             a.dat,
             COUNT(DISTINCT a.dat) AS anzahl,
             SUM(a.menge_abschrift) AS menge_abschrift
      FROM DBP_DATA.marktabschriften_2 a
      JOIN (SELECT a.mandant_id,
                   a.wup_id,
                   b.art_id
            FROM _zwischentabelle a
            JOIN DBP_DATA.art_2 b
              ON a.kl_art_id = b.kl_art_id AND
                 a.mandant_id = b.mandant_id AND
                 b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
            WHERE a.mandant_id = 1
            GROUP BY 1,2,3) b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           a.art_id = b.art_id
      WHERE a.dat BETWEEN CURRENT_DATE()-49 AND CURRENT_DATE()-1 AND
            a.abschriftart_id IN (SELECT b.abschriftart_id
                                              FROM DBP_DATA.l_abschriftart_int_2 a
                                              JOIN DBP_DATA.abschriftart_int_zu_2 b
                                                ON a.abschriftart_int_id = b.abschriftart_int_id
                                              WHERE a.abschriftart_thema_int_id = 1 AND
                                                    b.mandant_id = 1
                                              GROUP BY 1) 
      GROUP BY 1,2,3,4,5) a1
GROUP BY 1,2,3,4,5
);

CREATE or replace VOLATILE TABLE _x_abs_kmo AS (
SELECT a1.mandant_id,
       a1.wup_id,
       a1.art_id,
       CASE
         WHEN a1.mandant_id = 8
         THEN a1.wtag_id-1
         ELSE a1.wtag_id
       END AS wtag_id_,
       CASE
         WHEN a1.mandant_id = 8
         THEN a1.dat-1
         ELSE a1.dat
       END AS dat_,
       SUM(a1.menge_abschrift) AS menge_abschrift
FROM (SELECT a.mandant_id,
             a.wup_id,
             a.art_id,
          -- ((a.dat - CURRENT_DATE '1900-01-01') MOD 7) + 1 AS wtag_id,
       --mfialkiewicz
             MOD(datediff(day,'1900-01-01',a.dat), 7)  + 1 AS wtag_id,
             a.dat,
             COUNT(DISTINCT a.dat) AS anzahl,
             SUM(a.menge_abschrift) AS menge_abschrift
      FROM DBP_DATA.marktabschriften_2 a
      JOIN (SELECT a.mandant_id,
                   a.wup_id,
                   b.art_id
            FROM _zwischentabelle a
            JOIN DBP_DATA.art_2 b
              ON a.kl_art_id = b.kl_art_id AND
                 a.mandant_id = b.mandant_id AND
                 b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
            WHERE a.mandant_id > 1
            GROUP BY 1,2,3) b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           a.art_id = b.art_id
      WHERE a.dat BETWEEN CURRENT_DATE()-49 AND CURRENT_DATE()-1 AND
            a.abschriftart_id IN (SELECT b.abschriftart_id
                                              FROM DBP_DATA.l_abschriftart_int_2 a
                                              JOIN DBP_DATA.abschriftart_int_zu_2 b
                                                ON a.abschriftart_int_id = b.abschriftart_int_id
                                              WHERE a.abschriftart_thema_int_id = 1 AND
                                                    b.mandant_id > 1
                                              GROUP BY 1) 
      GROUP BY 1,2,3,4,5) a1
GROUP BY 1,2,3,4,5
);

UPDATE _zwischentabelle SET menge_abschrift = b.menge_abschrift

FROM (SELECT *
                              FROM _x_abs
                              --WHERE menge_abschrift > 3
                              ) b
					  
WHERE _zwischentabelle.mandant_id = b.mandant_id AND
      _zwischentabelle.wup_id = b.wup_id AND
      _zwischentabelle.kl_art_id = CASE WHEN b.mandant_id = 1 THEN floor(b.art_id/100) ELSE floor(b.art_id/10) END AND
      _zwischentabelle.dat = b.dat_
;

UPDATE _zwischentabelle SET menge_abschrift = b.menge_abschrift

FROM (SELECT *
                              FROM _x_abs_kmo) b
					  
WHERE _zwischentabelle.mandant_id = b.mandant_id AND
      _zwischentabelle.wup_id = b.wup_id AND
      _zwischentabelle.kl_art_id = CASE WHEN b.mandant_id = 1 THEN floor(b.art_id/100) ELSE floor(b.art_id/10) END AND
      _zwischentabelle.dat = b.dat_
;

UPDATE _zwischentabelle SET letzter_abverkauf = CASE
                                                  WHEN menge_abschrift <> 0
                                                  --THEN CAST('22:00:00' AS INTEGER FORMAT '99:99:99')
                                                  --mfialkiewicz
                                                   then to_time('22:00:00')
                                                   ELSE letzter_abverkauf
                                                END
;

CREATE or replace VOLATILE TABLE _max_abv (
  mandant_id BYTEINT,
  wup_id INTEGER,
  art_id INTEGER,
  dat DATE,
  wtag_id BYTEINT,
  aktion_fg BYTEINT,
  back_drehklasse_id CHAR(2),
  wug_cluster_id SMALLINT,
  wup_cluster_id SMALLINT,
  letzter_abverkauf_avg time/*INTEGER*/,
  --mfialkiewicz
  offen_von time /*INTEGER*/,
  offen_bis time /*INTEGER*/,
  menge_schnitt DECIMAL(18,3)
) ;

INSERT INTO _max_abv (mandant_id,
                      wup_id,
                      art_id,
                      dat,
                      wtag_id,
                      aktion_fg,
                      back_drehklasse_id,
                      wug_cluster_id,
                      wup_cluster_id,
                      letzter_abverkauf_avg,
                      offen_von,
                      offen_bis,
                      menge_schnitt)
SELECT a.mandant_id,
       a.wup_id,
       c.art_id,
       c.dat,
       a.wtag_id,
       c.aktion_fg,
       c.back_drehklasse_id,
       c.wug_cluster_id,
       c.wup_cluster_id,
       a.letzter_abverkauf,
       d.offen_von,
       d.offen_bis,
       c.menge_schnitt
FROM (SELECT x.mandant_id,
             x.wup_id,
             x.kl_art_id,
             x.wtag_id,
             --CAST(CAST(TIME '00:00:00' + CAST(AVG(CAST(SUBSTR(x.letzter_abverkauf,1,2) AS INT)* 3600) AS INT) * INTERVAL '00:00:01' HOUR TO SECOND AS CHAR(8)) AS INT ) AS letzter_abverkauf
        --mfialkiewicz
        to_time(lpad(to_char(avg(substr(x.letzter_abverkauf,1,2)) :: int),2,'0') || ':' || 
        lpad(to_char(cast(abs(((avg(substr(x.letzter_abverkauf,1,2)) - (avg(substr(x.letzter_abverkauf,1,2))::int)) * 60 ::int)) as int)) ,2,'0') || ':' || 
        lpad(to_char(cast(abs((3600 * ( (avg(substr(x.letzter_abverkauf,1,2)) - (avg(substr(x.letzter_abverkauf,1,2))::int)) -
                          (((avg(substr(x.letzter_abverkauf,1,2)) - (avg(substr(x.letzter_abverkauf,1,2))::int)) * 60::int)/60) )::int))  as int)),2,'0')) AS letzter_abverkauf  
      FROM (SELECT mandant_id,
                   wup_id,
                   kl_art_id,
                   dat,
                   wtag_id,
                   CASE
                     WHEN MAX(letzter_abverkauf) < '14:00:00'
                     THEN '14:00:00'
                     ELSE MAX(letzter_abverkauf)
                   END AS letzter_abverkauf
             FROM _zwischentabelle
            GROUP BY 1,2,3,4,5) x
      GROUP BY 1,2,3,4) a
JOIN (SELECT x.mandant_id,
             x.wup_id,
             x.art_id,
             d.dat,
             x.wtag_id,
             d.aktion_fg,
             x.back_drehklasse_id,
             COALESCE(b.wug_cluster_id,b1.wug_cluster_id,5) AS wug_cluster_id,
             COALESCE(e.wup_cluster_id,f.wup_cluster_id, 1) AS wup_cluster_id,
             x.menge_schnitt
      FROM DBP_ETL.vis_ods_tmp_2 x
      JOIN DBP_ETL.vis_agg_tmp_2 d
        ON x.mandant_id = d.mandant_id AND
           x.art_id = d.art_id AND
           x.wup_id = d.wup_id AND
         --((d.dat - CURRENT_DATE '1900-01-01') MOD 7) + 1 = x.wtag_id
           --mfialkiewicz
           MOD(datediff(day,'1900-01-01',d.dat), 7)  + 1 = x.wtag_id
      JOIN DBP_DATA.art_wg_zu_per_2 a
        ON x.mandant_id = a.mandant_id AND
           x.art_id = a.art_id AND
           a.arthiertyp_id = 2 AND
           CURRENT_DATE() BETWEEN a.dat_von AND a.dat_bis
      LEFT JOIN DBP_DATA.back_wug_cluster_zu_2 b
        ON a.mandant_id = b.mandant_id AND
           a.wug_id = b.wug_id AND
           a.wg_id = b.wg_id
      LEFT JOIN (SELECT x.mandant_id,
                        MAX(x.wug_cluster_id) AS wug_cluster_id
                 FROM DBP_DATA.back_wug_cluster_zu_2 x
                 JOIN (SELECT mandant_id,
                              wg_id,
                              wug_id
                       FROM DBP_DATA.back_wug_cluster_zu_2
                       WHERE (mandant_id,wug_cluster_id) IN (SELECT mandant_id,wug_cluster_id FROM DBP_DATA.back_vorgabe_2)
                       GROUP BY 1,2,3) y
                   ON x.mandant_id = y.mandant_id AND
                      x.wg_id = y.wg_id AND
                      x.wug_id = y.wug_id
                 GROUP BY 1) b1
        ON a.mandant_id = b1.mandant_id
      LEFT JOIN DBP_DATA.back_vorgabe_2 c
        ON a.mandant_id = c.mandant_id AND
           b.wug_cluster_id = c.wug_cluster_id AND
           x.back_drehklasse_id = c.back_drehklasse_id AND
           d.aktion_fg = c.aktion_fg
      LEFT JOIN (SELECT x.mandant_id,
                        x.wup_id,
                        x.nb_id,
                        MAX(x.wup_cluster_id) AS wup_cluster_id
                 FROM DBP_DATA.back_wup_cluster_zu_2 x
                 JOIN (SELECT mandant_id,
                              wup_id,
                              nb_id,
                              MIN(prio) AS prio
                       FROM DBP_DATA.back_wup_cluster_zu_2
                       WHERE (mandant_id,wup_cluster_id) IN (SELECT mandant_id,wup_cluster_id FROM DBP_DATA.back_vorgabe_2)
                       GROUP BY 1,2,3) y
                   ON x.mandant_id = y.mandant_id AND
                      x.wup_id = y.wup_id AND
                      x.nb_id = y.nb_id AND
                      x.prio = y.prio
                 GROUP BY 1,2,3) e
        ON x.mandant_id = e.mandant_id AND
           x.wup_id = e.wup_id
      LEFT JOIN (SELECT x.mandant_id,
                        MAX(x.wup_cluster_id) AS wup_cluster_id
                 FROM DBP_DATA.back_wup_cluster_zu_2 x
                 JOIN (SELECT mandant_id,
                              wup_id,
                              nb_id,
                              MIN(prio) AS prio
                       FROM DBP_DATA.back_wup_cluster_zu_2
                       WHERE (mandant_id,wup_cluster_id) IN (SELECT mandant_id,wup_cluster_id FROM DBP_DATA.back_vorgabe_2)
                       GROUP BY 1,2,3) y
                   ON x.mandant_id = y.mandant_id AND
                      x.wup_id = y.wup_id AND
                      x.nb_id = y.nb_id AND
                      x.prio = y.prio
                 GROUP BY 1) f
        ON x.mandant_id = f.mandant_id) c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.kl_art_id = CASE
                     WHEN c.mandant_id > 1
                     THEN floor(c.art_id/10)
                     ELSE floor(c.art_id/100)
                   END AND
     a.wtag_id = c.wtag_id
JOIN _markt_oeffnungen d
  ON a.mandant_id = d.mandant_id AND
     a.wup_id = d.wup_id AND
     a.wtag_id = d.wtag_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
;

CREATE or replace VOLATILE TABLE _max_abv2 (
  mandant_id BYTEINT,
  wup_id INTEGER,
  art_id INTEGER,
  dat DATE,
  wtag_id BYTEINT,
  aktion_fg BYTEINT,
  back_drehklasse_id CHAR(2),
  wug_cluster_id SMALLINT,
  wup_cluster_id SMALLINT,
  letzter_abverkauf_avg  TIME /*mfialkiewiczINTEGER*/,
  menge_schnitt DECIMAL(18,3),
  menge_pro_min DECIMAL(18,3),
  aufschlag_uhrzeit_tmp SMALLINT,
  aufschlag_uhrzeit_la_prozent DECIMAL(9,4),
  aufschlag_zeit DECIMAL(9,2),
  ant_mag DECIMAL(9,2),
  faktor_ist DECIMAL(9,2),
  min_gesamt_fs DECIMAL(9,2),
  ant_min_fs DECIMAL(9,2),
  prognoseart CHAR(10) COLLATE 'de-ci'
) ;

INSERT INTO _max_abv2 (mandant_id,
                       wup_id,
                       art_id,
                       dat,
                       wtag_id,
                       aktion_fg,
                       back_drehklasse_id,
                       wug_cluster_id,
                       wup_cluster_id,
                       letzter_abverkauf_avg,
                       menge_schnitt,
                       menge_pro_min,
                       aufschlag_uhrzeit_tmp,
                       aufschlag_uhrzeit_la_prozent,
                       aufschlag_zeit,
                       ant_mag,
                       faktor_ist,
                       min_gesamt_fs,
                       ant_min_fs,
                       prognoseart)
SELECT x.mandant_id,
       x.wup_id,
       x.art_id,
       x.dat,
       x.wtag_id,
       x.aktion_fg,
       x.back_drehklasse_id,
       x.wug_cluster_id,
       x.wup_cluster_id,
       x.letzter_abverkauf_avg,
       x.menge_schnitt,
       x.menge_pro_min,
       x.aufschlag_uhrzeit_tmp,
       x.aufschlag_uhrzeit_la_prozent,
       x.aufschlag_zeit,
       x.ant_mag,
       x.faktor_ist,
       x.min_gesamt_fs,
       x.ant_min_fs,
       x.prognoseart
FROM (SELECT a.mandant_id,
             a.wup_id,
             a.art_id,
             a.dat,
             a.wtag_id,
             a.aktion_fg,
             a.back_drehklasse_id,
             a.wug_cluster_id,
             a.wup_cluster_id,
             a.letzter_abverkauf_avg,
             a.menge_schnitt,
             a.offen_von,
             a.offen_bis,
             --mfialkiewicz
             --CAST((a.offen_bis-a.offen_von)/10000 AS INT) AS stu,
             (substr(substr(a.offen_bis,0,2)*3600 + substr(a.offen_bis,4,2)*60 + substr(a.offen_bis,7,2),1,charindex('.',substr(a.offen_bis,0,2)*3600 + substr(a.offen_bis,4,2)*60 + substr(a.offen_bis,7,2),1)-1)
                  - substr(substr(a.offen_von,0,2)*3600 + substr(a.offen_von,4,2)*60 + substr(a.offen_von,7,2),1,charindex('.',substr(a.offen_von,0,2)*3600 + substr(a.offen_von,4,2)*60 + substr(a.offen_von,7,2),1)-1) 
             )/3600 as stu,
             CASE
                 WHEN CAST(SUBSTR(CAST(a.offen_bis AS CHAR(8)),4,2) AS INT) <> 0
                 THEN stu + 0.5
                 ELSE stu
             END AS stu2,
            ZEROIFNULL((a.menge_schnitt/NULLIFZERO(CAST(stu2 AS DEC(18,8)))))/60 AS menge_pro_min,
            (CAST(SUBSTR(CAST(a.offen_bis AS CHAR(8)),1,2) AS INT)-1-CAST(SUBSTR(CAST(a.letzter_abverkauf_avg AS CHAR(8)),1,2) AS INT)) AS murks, 
            ROUND(((CAST(SUBSTR(CAST(a.offen_bis AS CHAR(8)),1,2) AS INT)-1-CAST(SUBSTR(CAST(a.letzter_abverkauf_avg AS CHAR(8)),1,2) AS INT))*60-CAST(SUBSTR(CAST(a.letzter_abverkauf_avg AS CHAR(8)),4,2) AS INT))*menge_pro_min,0) AS aufschlag_uhrzeit_tmp,
             /*CASE
               WHEN a.letzter_abverkauf_avg > 203000
               THEN 0
               ELSE*/ CASE
                       -- WHEN a.letzter_abverkauf_avg > a.offen_bis-10000 /* minus 1 Stunde */
                       --mfialkiewicz
                          WHEN a.letzter_abverkauf_avg >  
                          to_time(to_timestamp(substr(substr(a.offen_bis,0,2)*3600 + substr('17:00:00',4,2)*60 + substr(a.offen_bis,7,2),1,charindex('.',substr(a.offen_bis,0,2)*3600 + substr(a.offen_bis,4,2)*60 + substr(a.offen_bis,7,2),1)-1) -3600))  
                          THEN 0
                      ELSE ROUND(ZEROIFNULL(aufschlag_uhrzeit_tmp/NULLIFZERO(a.menge_schnitt)),2)
                    END
             /*END*/ AS aufschlag_uhrzeit_la_prozent_tmp,
             CASE
               WHEN aufschlag_uhrzeit_la_prozent_tmp > 0.6
               THEN 0.6
               ELSE aufschlag_uhrzeit_la_prozent_tmp
             END AS aufschlag_uhrzeit_la_prozent,
             b.aufschlag_zeit,
             b.ant_mag,
             b.faktor_ist,
-- 30.08.2017, -dbay-
-- An dieser Stelle jetzt das Abgreifen der neuen Tabelle "art_backshop_fruehstart_2",
-- um je nach Markt-/Artikelvorgabe die fixe Mindestfruehstartmenge zu ueberschreiben.
             COALESCE(c.fruehstart_menge,b.min_gesamt_fs) AS min_gesamt_fs,
             b.ant_min_fs,
             b.prognoseart
FROM _max_abv a
JOIN DBP_DATA.back_vorgabe_2 b
  ON a.mandant_id = b.mandant_id AND
     a.back_drehklasse_id = b.back_drehklasse_id AND
     a.wug_cluster_id = b.wug_cluster_id AND
     a.aktion_fg = b.aktion_fg AND
     a.wup_cluster_id = b.wup_cluster_id
LEFT JOIN DBP_DATA.art_backshop_fruehstart_2 c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id AND
     a.wup_id = c.wup_id) x
;

UPDATE DBP_ETL.vis_ods_tmp_2 SET menge_ods = 0,
                                              menge_01  = 0,
                                              menge_02  = 0,
                                              menge_03  = 0,
                                              menge_04  = 0,
                                              menge_16  = 0
WHERE (mandant_id,CASE 
                    WHEN mandant_id > 1
                    THEN floor(art_id/10)
                    ELSE floor(art_id/100)
                  END) NOT IN (SELECT a.mandant_id,
                                      CASE 
                                        WHEN a.mandant_id > 1
                                        THEN floor(a.art_id/10)
                                        ELSE floor(a.art_id/100)
                                      END
                                      FROM DBP_DATA.art_backshop_zu_2 a
                                      JOIN DBP_DATA.art_backshop_2 b
                                        ON a.mandant_id = b.mandant_id AND
                                           a.bestell_art_id = b.bestell_art_id)
;

CREATE or replace VOLATILE TABLE _vis_fur_tmp_calculation 
     (
      mandant_id BYTEINT,
      art_id INTEGER,
      wup_id INTEGER,
      dat DATE,
      menge_fur_mean DECIMAL(18,3),
      menge_fur_max DECIMAL(18,3),
      menge_fur_aktion DECIMAL(18,3),
      aktion_fg BYTEINT,
      back_drehklasse_id CHAR(2),
      wug_cluster_id SMALLINT,
      wup_cluster_id SMALLINT,
      letzter_abverkauf_avg TIME /*mfialkiewicz INTEGER*/,
      menge_schnitt DECIMAL(18,3),
      menge_pro_min DECIMAL(18,3),
      aufschlag_uhrzeit_tmp SMALLINT,
      aufschlag_uhrzeit_la_prozent DECIMAL(9,2),
      aufschlag_zeit DECIMAL(9,2),
      ant_mag DECIMAL(9,2),
      faktor_ist DECIMAL(9,2),
      min_gesamt_fs DECIMAL(9,2),
      ant_min_fs DECIMAL(9,2),
      prognoseart CHAR(10) COLLATE 'de-ci',
      tagesmenge_fur INTEGER
) ;

INSERT INTO _vis_fur_tmp_calculation (mandant_id,
                                      art_id,
                                      wup_id,
                                      dat,
                                      menge_fur_mean,
                                      menge_fur_max,
                                      menge_fur_aktion,
                                      aktion_fg,
                                      back_drehklasse_id,
                                      wug_cluster_id,
                                      wup_cluster_id,
                                      letzter_abverkauf_avg,
                                      menge_schnitt,
                                      menge_pro_min,
                                      aufschlag_uhrzeit_tmp,
                                      aufschlag_uhrzeit_la_prozent,
                                      aufschlag_zeit,
                                      ant_mag,
                                      faktor_ist,
                                      min_gesamt_fs,
                                      ant_min_fs,
                                      prognoseart,
                                      tagesmenge_fur)
SELECT a.mandant_id,
       a.art_id,
       a.wup_id,
       a.dat,
       COALESCE(b.menge_fur_mean,0) AS menge_fur_mean_,
       COALESCE(b.menge_fur_max,0) AS menge_fur_max_,
       COALESCE(b.menge_fur_aktion,0) AS menge_fur_aktion_,
       a.aktion_fg,
       a.back_drehklasse_id,
       a.wug_cluster_id,
       a.wup_cluster_id,
       a.letzter_abverkauf_avg,
       a.menge_schnitt,
       a.menge_pro_min,
       a.aufschlag_uhrzeit_tmp,
       a.aufschlag_uhrzeit_la_prozent,
       a.aufschlag_zeit,
       a.ant_mag,
       a.faktor_ist,
       a.min_gesamt_fs,
       a.ant_min_fs,
       a.prognoseart,
       CASE
         WHEN menge_fur_aktion_ <> 0
         THEN ROUND(GREATEST(a.min_gesamt_fs,menge_fur_aktion_+(menge_fur_aktion_*CASE WHEN a.aufschlag_zeit = 0 THEN 0 ELSE a.aufschlag_uhrzeit_la_prozent END)),0)
         WHEN a.prognoseart = 'FC_MEAN'
         THEN ROUND(GREATEST(a.min_gesamt_fs,menge_fur_mean_+(menge_fur_mean_*CASE WHEN a.aufschlag_zeit = 0 THEN 0 ELSE a.aufschlag_uhrzeit_la_prozent END)),0)
         WHEN a.prognoseart = 'FC_MAX'
         THEN ROUND(GREATEST(a.min_gesamt_fs,menge_fur_max_ +(menge_fur_max_ *CASE WHEN a.aufschlag_zeit = 0 THEN 0 ELSE a.aufschlag_uhrzeit_la_prozent END)),0)
         ELSE ROUND(GREATEST(a.min_gesamt_fs,menge_fur_max_ +(menge_fur_max_ *CASE WHEN a.aufschlag_zeit = 0 THEN 0 ELSE a.aufschlag_uhrzeit_la_prozent END)),0)
       END tagesmenge_fur
FROM _max_abv2 a
LEFT JOIN DBP_ETL.vis_fur_tmp_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat = b.dat
;

CREATE or replace VOLATILE TABLE _vis_ods_tmp_calculation1 AS (
SELECT DISTINCT 
       a.*,
       b.dat,
       b.wug_cluster_id,
       b.wup_cluster_id,
       b.menge_pro_min,
       b.aufschlag_uhrzeit_la_prozent,
       b.aufschlag_zeit,
       b.ant_mag,
       b.faktor_ist,
       b.min_gesamt_fs,
       b.ant_min_fs,
       b.prognoseart,
       b.tagesmenge_fur,
       c2.ofen_typ_id,
       c2.blech_belegung,
       c3.back_programm_id,
       CASE
         WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
         THEN 0
         ELSE ROUND(CAST((a.menge_02/a.anz_ods)/a.menge_schnitt AS DECIMAL(18,3)),2)
       END AS ist_anteil_ffs,
       CASE
         WHEN GREATEST(b.ant_mag,ist_anteil_ffs*b.faktor_ist) > 1
         THEN 1
         ELSE GREATEST(b.ant_mag,ist_anteil_ffs*b.faktor_ist)
       END AS soll_anteil_ffs,
       b.tagesmenge_fur*soll_anteil_ffs AS gff_stueck_ungerundet,
       CASE
         WHEN c2.blech_belegung = 0
         THEN 0
         ELSE gff_stueck_ungerundet/c2.blech_belegung
       END AS gff_blech_ungerundet,
         CASE 
         WHEN c2.blech_belegung = 0 
         THEN 0 
         ELSE ROUND(gff_blech_ungerundet,0) 
       END AS gff_blech_gerundet,
       CASE
         WHEN c2.blech_belegung = 0 THEN 0
         WHEN (a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2) AND 
               GREATEST(ROUND(gff_stueck_ungerundet,0),b.min_gesamt_fs) <= b.tagesmenge_fur 
         THEN GREATEST(ROUND(gff_stueck_ungerundet,0),b.min_gesamt_fs)
         WHEN gff_blech_gerundet * c2.blech_belegung <= b.tagesmenge_fur 
         THEN gff_blech_gerundet * c2.blech_belegung
         ELSE ROUND(gff_stueck_ungerundet,0)
       END AS gff_stueck_gerundet,
       CASE
         WHEN a.anz_ods = 0
         THEN 0
         ELSE a.menge_01/a.anz_ods
       END AS summe_10,
       CASE
         WHEN a.anz_ods = 0
         THEN 0
         ELSE a.menge_02/a.anz_ods
       END AS summe_14,
       CASE
         WHEN summe_14 = 0
         THEN 0
         ELSE summe_10/summe_14 
       END AS ist_anteil_fs,
       CASE
         WHEN c3.back_programm_id = 999 OR gff_blech_gerundet < 1.5
         THEN 1.000
         ELSE b.ant_min_fs
       END AS mindestanteil_fs,
       GREATEST(ist_anteil_fs,mindestanteil_fs) AS soll_anteil_fs,
       CASE
         WHEN c.nb_id IS NOT NULL
         THEN c.fruehstart_menge
         WHEN gff_stueck_gerundet = 0 THEN 4
         WHEN soll_anteil_fs = 1 THEN gff_stueck_gerundet 
         ELSE CASE 
                WHEN gff_blech_gerundet <= 2 
                THEN gff_stueck_gerundet
                ELSE CASE 
                       WHEN c2.blech_belegung = 0 
                       THEN 0
                       WHEN ROUND((gff_stueck_gerundet*soll_anteil_fs/c2.blech_belegung)+0.4999,0)*c2.blech_belegung < b.min_gesamt_fs 
                       THEN b.min_gesamt_fs
                       ELSE ROUND((gff_stueck_gerundet*soll_anteil_fs/c2.blech_belegung)+0.4999,0)*c2.blech_belegung
                     END
              END
       END AS fs_in_stueck,
       CASE 
         WHEN c2.blech_belegung = 0 
         THEN 0 
         ELSE ROUND(fs_in_stueck/c2.blech_belegung,1) 
       END AS fs_in_blech
FROM DBP_ETL.vis_ods_tmp_2 a
JOIN _vis_fur_tmp_calculation b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     --a.wtag_id = ((b.dat - CURRENT_DATE '1900-01-01') MOD 7) + 1
     --mfialkiewicz
     a.wtag_id =  MOD(datediff(day,'1900-01-01',b.dat), 7) + 1
LEFT JOIN DBP_DATA.art_backshop_fruehstart_2 c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id AND
     a.wup_id = c.wup_id
JOIN DBP_DATA.wup_backshop_per_2 c1
  ON a.mandant_id = c1.mandant_id AND
     a.wup_id = c1.wup_id AND
     c1.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') AND
     c1.nb_id = 0
JOIN (SELECT a.mandant_id,
             a.art_id,
             a.ofen_typ_id,
             b.blech_belegung
      FROM (SELECT mandant_id,
                   art_id,
                   MAX(ofen_typ_id) AS ofen_typ_id
            FROM DBP_DATA.art_ofentyp_zu_2
            GROUP BY 1,2) a
      JOIN DBP_DATA.art_ofentyp_zu_2 b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id AND
           a.ofen_typ_id = b.ofen_typ_id) c2
  ON a.mandant_id = c2.mandant_id AND
     a.art_id = c2.art_id
JOIN (SELECT mandant_id,
             art_id,
             MAX(back_programm_id) AS back_programm_id
      FROM DBP_DATA.art_backprogramm_zu_2
      GROUP BY 1,2) c3
  ON a.mandant_id = c3.mandant_id AND
     a.art_id = c3.art_id
);

CREATE or replace transient TABLE _vis_ods_tmp_calculation2 AS (
SELECT a.*,
       CASE
         WHEN a.gff_stueck_gerundet = 0 THEN 0
         WHEN a.gff_stueck_gerundet = a.fs_in_stueck THEN 0
         ELSE a.blech_belegung*(a.gff_stueck_gerundet - a.fs_in_stueck)/COALESCE(a.blech_belegung,1)
       END fsc_in_stueck,
       CASE
         WHEN fsc_in_stueck = 0 THEN 0
         ELSE a.blech_belegung*CEIL(fsc_in_stueck/COALESCE(a.blech_belegung,1))
       END AS fsc_in_blech,
       CASE
         WHEN a.soll_anteil_fs = 0 THEN 0
         ELSE CASE
                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0 THEN 0
                ELSE ZEROIFNULL(CAST((a.menge_03/a.anz_ods)/NULLIFZERO(a.menge_schnitt) AS DECIMAL(18,3)))
              END
       END AS anteil_abv_nachmittag,
       CASE
         WHEN a.tagesmenge_fur = 0 THEN 0
         ELSE ZEROIFNULL(CAST((a.menge_04/a.anz_ods)/NULLIFZERO(a.menge_schnitt) AS DECIMAL(18,3)))
       END anteil_abv_abend,
       CAST(a.tagesmenge_fur*anteil_abv_nachmittag AS INTEGER)+1 AS erwarteter_abv_nachmittag,
       CAST(a.tagesmenge_fur*anteil_abv_abend AS INTEGER)+1 AS erwarteter_abv_abend,
       CAST(0 AS DECIMAL(18,3)) AS menge_abschrift_schnitt
FROM _vis_ods_tmp_calculation1 a
);

CREATE or replace VOLATILE TABLE _marktabs1 AS (
SELECT x1.*,
       ROUND(CAST(menge_abschrift_ AS DECIMAL(18,3))/CAST(y.anz_ods AS DECIMAL(18,3)),0) AS schnitt
FROM (SELECT x.mandant_id,
             x.wup_id,
             x.art_id,
             x.wtag_id_ AS wtag_id_,
             SUM(x.menge_abschrift) AS menge_abschrift_
      FROM (SELECT a1.mandant_id,
                   a1.wup_id,
                   a1.art_id,
                   CASE
                     WHEN a1.wtag_id IN (7,1)
                     THEN 6
                     ELSE a1.wtag_id-1
                   END AS wtag_id_,
                   SUM(a1.menge_abschrift) AS menge_abschrift
            FROM (SELECT a.mandant_id,
                         a.wup_id,
                         a.art_id,
                         MOD(datediff(day,'1900-01-01',a.dat), 7) + 1 AS wtag_id,
                         a.dat,
                         COUNT(DISTINCT a.dat) AS anzahl,
                         SUM(a.menge_abschrift) AS menge_abschrift
                  FROM DBP_DATA.marktabschriften_2 a
                  JOIN (SELECT mandant_id,
                               wup_id,
                               art_id
                        FROM _vis_ods_tmp_calculation2
                        WHERE mandant_id = 1
                        GROUP BY 1,2,3) b
                    ON a.mandant_id = b.mandant_id AND
                       a.wup_id = b.wup_id AND
                       a.art_id = b.art_id
                  WHERE a.dat BETWEEN CURRENT_DATE()-49 AND CURRENT_DATE()-1 AND
                        a.abschriftart_id IN (SELECT b.abschriftart_id
                                              FROM DBP_DATA.l_abschriftart_int_2 a
                                              JOIN DBP_DATA.abschriftart_int_zu_2 b
                                                ON a.abschriftart_int_id = b.abschriftart_int_id
                                              WHERE a.abschriftart_thema_int_id = 1 AND
                                                    b.mandant_id = 1
                                              GROUP BY 1)
                  GROUP BY 1,2,3,4,5) a1
            GROUP BY 1,2,3,4) x
      GROUP BY 1,2,3,4) x1
JOIN _vis_ods_tmp_calculation2 y
  ON x1.mandant_id = y.mandant_id AND
     x1.wup_id = y.wup_id AND
     x1.art_id = y.art_id AND
     x1.wtag_id_ = y.wtag_id
);

CREATE or replace VOLATILE TABLE _marktabs1_kmo AS (
SELECT x1.*,
       ROUND(CAST(menge_abschrift_ AS DECIMAL(18,3))/CAST(y.anz_ods AS DECIMAL(18,3)),0) AS schnitt
FROM (SELECT x.mandant_id,
             x.wup_id,
             x.art_id,
             x.wtag_id_ AS wtag_id_,
             SUM(x.menge_abschrift) AS menge_abschrift_
      FROM (SELECT a1.mandant_id,
                   a1.wup_id,
                   a1.art_id,
                   CASE
                     WHEN a1.mandant_id = 8
                     THEN a1.wtag_id-1
                     ELSE a1.wtag_id
                   END AS wtag_id_,
                   SUM(a1.menge_abschrift) AS menge_abschrift
            FROM (SELECT a.mandant_id,
                         a.wup_id,
                         a.art_id,
                         MOD(datediff(day,'1900-01-01',a.dat), 7)  + 1 AS wtag_id,
                         a.dat,
                         COUNT(DISTINCT a.dat) AS anzahl,
                         SUM(a.menge_abschrift) AS menge_abschrift
                  FROM DBP_DATA.marktabschriften_2 a
                  JOIN (SELECT mandant_id,
                               wup_id,
                               art_id
                        FROM _vis_ods_tmp_calculation2
                        WHERE mandant_id > 1
                        GROUP BY 1,2,3) b
                    ON a.mandant_id = b.mandant_id AND
                       a.wup_id = b.wup_id AND
                       a.art_id = b.art_id
                  WHERE a.dat BETWEEN CURRENT_DATE()-49 AND CURRENT_DATE()-1 AND
                        a.abschriftart_id IN (SELECT b.abschriftart_id
                                              FROM DBP_DATA.l_abschriftart_int_2 a
                                              JOIN DBP_DATA.abschriftart_int_zu_2 b
                                                ON a.abschriftart_int_id = b.abschriftart_int_id
                                              WHERE a.abschriftart_thema_int_id = 1 AND
                                                    b.mandant_id > 1
                                              GROUP BY 1)
                  GROUP BY 1,2,3,4,5) a1
            GROUP BY 1,2,3,4) x
      GROUP BY 1,2,3,4) x1
JOIN _vis_ods_tmp_calculation2 y
  ON x1.mandant_id = y.mandant_id AND
     x1.wup_id = y.wup_id AND
     x1.art_id = y.art_id AND
     x1.wtag_id_ = y.wtag_id
);

UPDATE _vis_ods_tmp_calculation2 SET menge_abschrift_schnitt = b.schnitt

FROM (SELECT * FROM _marktabs1) b
									    
WHERE _vis_ods_tmp_calculation2.mandant_id = b.mandant_id AND
      _vis_ods_tmp_calculation2.wup_id = b.wup_id AND
      _vis_ods_tmp_calculation2.art_id = b.art_id AND
      _vis_ods_tmp_calculation2.wtag_id = b.wtag_id_
;

UPDATE _vis_ods_tmp_calculation2 SET menge_abschrift_schnitt = b.schnitt

FROM (SELECT *
                                       FROM _marktabs1_kmo) b
									   
WHERE _vis_ods_tmp_calculation2.mandant_id = b.mandant_id AND
      _vis_ods_tmp_calculation2.wup_id = b.wup_id AND
      _vis_ods_tmp_calculation2.art_id = b.art_id AND
      _vis_ods_tmp_calculation2.wtag_id = b.wtag_id_
;

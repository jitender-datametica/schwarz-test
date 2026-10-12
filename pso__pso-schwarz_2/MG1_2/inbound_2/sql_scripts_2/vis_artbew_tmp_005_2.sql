create or replace table dbp_etl.vis_artbew_tmp_2 (
  mandant_id byteint not null,
  nb_id smallint not null,
  wup_id integer not null,
  abt_id smallint not null,
  wg_id smallint not null,
  arthiertyp_id byteint not null,
  gj smallint not null, 
  kjmo integer not null, 
  kjwo integer not null,
  mo_kj byteint not null,
  akt_gj smallint not null,
  akt_mo smallint not null,
  akt_wo smallint not null,
  akt_tag smallint not null,
  wtag_id byteint not null, 
  dat date not null,
  wrg_id char(3) not null,
  ums_netto decimal(18,2),
  ums_netto_wvj decimal(18,2),
  ums_netto_wvvj decimal(18,2),
  ums_netto_kvj decimal(18,2),
  ums_netto_kvvj decimal(18,2),
  ums_brutto decimal(18,2),
  ums_brutto_wvj decimal(18,2),
  ums_brutto_wvvj decimal(18,2),
  ums_brutto_kvj decimal(18,2),
  ums_brutto_kvvj decimal(18,2),
  menge_absatz decimal(18,3),
  menge_absatz_kvj decimal(18,3),
  menge_absatz_kvvj decimal(18,3),
  menge_absatz_wvj decimal(18,3),
  ums_netto_af decimal(18,2),
  ums_netto_af_wvj decimal(18,2),
  ums_netto_af_wvvj decimal(18,2),
  ums_netto_af_kvj decimal(18,2),
  ums_netto_af_kvvj decimal(18,2),
  ums_netto_sa decimal(18,2),
  ums_netto_sa_wvj decimal(18,2),
  ums_netto_sa_wvvj decimal(18,2),
  ums_netto_sa_kvj decimal(18,2),
  ums_netto_sa_kvvj decimal(18,2),
  menge_absatz_af decimal(18,3),
  menge_absatz_af_kvj decimal(18,3),
  menge_absatz_af_wvj decimal(18,3),
  menge_absatz_sa decimal(18,3),
  menge_absatz_sa_kvj decimal(18,3),
  menge_absatz_sa_wvj decimal(18,3)
);

create or replace table dbp_etl.vis_artbew_abschrift_tmp_2 (
  mandant_id byteint not null,
  nb_id smallint not null,
  wup_id integer not null,
  abt_id smallint not null,
  wg_id smallint not null,
  arthiertyp_id byteint not null,
  gj smallint not null, 
  kjmo integer not null, 
  kjwo integer not null,
  mo_kj byteint not null,
  akt_gj smallint not null,
  akt_mo smallint not null,
  akt_wo smallint not null,
  akt_tag smallint not null,
  wtag_id byteint not null, 
  dat date not null,
  wrg_id char(3) not null,
  ums_netto decimal(18,2),
  ums_netto_wvj decimal(18,2),
  ums_netto_wvvj decimal(18,2),
  ums_netto_kvj decimal(18,2),
  ums_netto_kvvj decimal(18,2),
  ums_brutto decimal(18,2),
  ums_brutto_wvj decimal(18,2),
  ums_brutto_wvvj decimal(18,2),
  ums_brutto_kvj decimal(18,2),
  ums_brutto_kvvj decimal(18,2)
);

create or replace volatile table _murks_2 as (
select a.mandant_id,
       a.dat,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       2 as arthiertyp_id,
       c.wg_id,
       a.wrg_2 as umsatz_wrg,
       sum(a.umsatz_netto) as umsatz_netto,
       sum(a.umsatz_netto+a.umsatz_mwst_betrag) as umsatz_brutto,
       sum(case when d.arthiertyp_id is not null then 0 else a.menge end) as menge
from dbp_data.artbew_2 a
join dbp_data.art_wg_zu_per_2 c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     c.arthiertyp_id = 2 and
     c.dat_bis = '9999-12-31'
left join (select mandant_id,
                  art_id,
                  arthiertyp_id
           from dbp_data.art_wg_zu_per_2
           where arthiertyp_id = 2 and
                 dat_bis = '9999-12-31' and
                 wg_id = 823 and
                 wug_id in (2,3,4)
           group by 1,2,3) d
  on a.mandant_id = d.mandant_id and
     a.art_id = d.art_id
where a.dat between (select min(join_dat) from dbp_etl.dat_vj_vergleich_2) and (select max(join_dat) from dbp_etl.dat_vj_vergleich_2) and not
      (a.bewart_id = 1010) and not
      (a.mandant_id = 6 and 
       a.art_id in (98001300,98001310,98001320)) and not
      (a.mandant_id = 1 and
       a.art_id in (590006700,590006900)) and not
      (a.mandant_id = 2 and 
       a.art_id in (818410,202685400,1485930,207699370)) and not
     ((a.mandant_id,a.art_id) in (select mandant_id,art_id
                                  from dbp_data.art_wg_zu_per_2
                                  where mandant_id = 1 and
                                        arthiertyp_id = 2 and
                                        dat_bis = '9999-12-31' and
                                        wg_id = 969)) and not
     ((a.mandant_id,a.art_id) in (select mandant_id,art_id
                                  from dbp_data.art_wg_zu_per_2
                                  where mandant_id = 7 and
                                        arthiertyp_id = 2 and
                                        dat_bis = '9999-12-31' and
                                        wg_id = 969 and
                                        wug_id = 6)) and not
     ((a.mandant_id,a.art_id) in (select mandant_id,art_id 
                                  from dbp_data.art_wg_zu_per_2
                                  where mandant_id = 7 and
                                        arthiertyp_id = 2 and
                                        dat_bis = '9999-12-31' and
                                        wg_id = 980)) and not
     ((a.mandant_id,c.wg_id) in (select mandant_id,wg_id from dbp_data.wg_filter_zu_2 where wg_filter_id = 49)) and not
     ((a.mandant_id,a.art_id) in (select mandant_id,art_id
                                  from dbp_data.art_wg_zu_per_2
                                  where mandant_id in (2,5,6) and
                                        arthiertyp_id = 2 and
                                        dat_bis = '9999-12-31' and
                                        wg_id = 969 and
                                        wug_id between 1 and 4)) /*and not
     ((a.mandant_id,a.art_id,a.umsatz_mwst_betrag) in (select mandant_id,art_id,0
                                                       from dbp_data.art_wg_zu_per_2
                                                       where mandant_id = 1 and
                                                             arthiertyp_id = 2 and
                                                             dat_bis = '9999-12-31' and
                                                             wg_id in (818,969)))*/
group by 1,2,3,4,5,6,7,8
);

insert into _murks_2 (mandant_id,
                    dat,
                    wup_id,
                    nb_id,
                    bewart_id,
                    arthiertyp_id,
                    wg_id,
                    umsatz_wrg,
                    umsatz_netto,
                    umsatz_brutto,
                    menge)
select a.mandant_id
      ,a.dat
      ,a.wup_id
      ,a.nb_id
      ,1001 as bewart_id
      ,a.arthiertyp_id
      ,a.wg_id
      ,a.umsatz_wrg
      ,sum(a.umsatz_netto) as umsatz_netto
      ,sum(a.umsatz_brutto) as umsatz_brutto
      ,sum(a.menge) as menge
from dbp_data.artbew_wg_sum_2 a
join dbp_data.mandant_2 b
  on a.mandant_id = b.mandant_id and
     a.umsatz_wrg = b.default_wrg
where a.dat between (select min(join_dat) from dbp_etl.dat_vj_vergleich_2) and (select max(join_dat) from dbp_etl.dat_vj_vergleich_2) and
     (a.nb_id <> 0 or
      a.wg_id < 100 or
      a.bewart_id = 1010)
group by 1,2,3,4,5,6,7,8
;
 
insert into dbp_etl.vis_artbew_tmp_2 (mandant_id,
                                    nb_id,
                                    wup_id,
                                    abt_id,
                                    wg_id,
                                    arthiertyp_id,
                                    gj,
                                    kjmo,
                                    kjwo,
                                    mo_kj,
                                    dat,
                                    akt_gj,
                                    akt_mo,
                                    akt_wo,
                                    akt_tag,
                                    wtag_id,
                                    wrg_id,
                                    ums_netto,
                                    ums_netto_wvj,
                                    ums_netto_wvvj,
                                    ums_netto_kvj,
                                    ums_netto_kvvj,
                                    ums_brutto,
                                    ums_brutto_wvj,
                                    ums_brutto_wvvj,
                                    ums_brutto_kvj,
                                    ums_brutto_kvvj,
                                    menge_absatz,
                                    menge_absatz_kvj,
                                    menge_absatz_kvvj,
                                    menge_absatz_wvj,
                                    ums_netto_af,
                                    ums_netto_af_wvj,
                                    ums_netto_af_wvvj,
                                    ums_netto_af_kvj,
                                    ums_netto_af_kvvj,
                                    ums_netto_sa,
                                    ums_netto_sa_wvj,
                                    ums_netto_sa_wvvj,
                                    ums_netto_sa_kvj,
                                    ums_netto_sa_kvvj,
                                    menge_absatz_af,
                                    menge_absatz_af_kvj,
                                    menge_absatz_af_wvj,
                                    menge_absatz_sa,
                                    menge_absatz_sa_kvj,
                                    menge_absatz_sa_wvj)
select mandant_id
      ,nb_id
      ,wup_id
      ,abt_id
      ,wg_id   
      ,arthiertyp_id
      ,gj
      ,kjmo
      ,kjwo
      ,mo_kj
      ,dat
      ,akt_gj
      ,akt_mo
      ,akt_wo
      ,akt_tag
      ,wtag_id
      ,wrg_id
      ,ums_netto
      ,ums_netto_wvj
      ,ums_netto_wvvj
      ,ums_netto_kvj
      ,ums_netto_kvvj
      ,ums_brutto
      ,ums_brutto_wvj
      ,ums_brutto_wvvj
      ,ums_brutto_kvj
      ,ums_brutto_kvvj
      ,menge_absatz
      ,menge_absatz_kvj
      ,menge_absatz_kvvj
      ,menge_absatz_wvj
      ,ums_netto_af
      ,ums_netto_af_wvj
      ,ums_netto_af_wvvj
      ,ums_netto_af_kvj
      ,ums_netto_af_kvvj
      ,ums_netto_sa
      ,ums_netto_sa_wvj
      ,ums_netto_sa_wvvj
      ,ums_netto_sa_kvj
      ,ums_netto_sa_kvvj
      ,menge_absatz_af
      ,menge_absatz_af_kvj
      ,menge_absatz_af_wvj
      ,menge_absatz_sa
      ,menge_absatz_sa_kvj
      ,menge_absatz_sa_wvj
from (select dt1.mandant_id
            ,dt1.nb_id
            ,dt1.wup_id
            ,t4.abt_id
            ,t3.wg_id
            ,t3.arthiertyp_id
            ,dt1.gj
            ,dt1.kjmo
            ,dt1.kjwo
            ,dt1.mo_kj
            ,dt1.dat
            ,dt1.akt_gj
            ,dt1.akt_mo
            ,dt1.akt_wo
            ,dt1.akt_tag
            ,dt1.wtag_id
            ,t3.umsatz_wrg wrg_id
            ,sum(umsatz_netto * akt_gj_fg) as ums_netto
            ,sum(umsatz_netto * vj_wt_1_fg) as ums_netto_wvj
            ,sum(umsatz_netto * vj_wt_2_fg) as ums_netto_wvvj
            ,sum(umsatz_netto * vj_1_fg) as ums_netto_kvj
            ,sum(umsatz_netto * vj_2_fg) as ums_netto_kvvj
            ,sum(umsatz_brutto * akt_gj_fg) as ums_brutto
            ,sum(umsatz_brutto * vj_wt_1_fg) as ums_brutto_wvj
            ,sum(umsatz_brutto * vj_wt_2_fg) as ums_brutto_wvvj
            ,sum(umsatz_brutto * vj_1_fg) as ums_brutto_kvj
            ,sum(umsatz_brutto * vj_2_fg) as ums_brutto_kvvj
            ,sum(t3.menge * akt_gj_fg) as menge_absatz
            ,sum(t3.menge * vj_1_fg) as menge_absatz_kvj
            ,sum(t3.menge * vj_2_fg) as menge_absatz_kvvj
            ,sum(t3.menge * vj_wt_1_fg) as menge_absatz_wvj
            ,sum(case when t3.bewart_id = 1001 then t3.umsatz_netto * akt_gj_fg else 0 end) as ums_netto_af
            ,sum(case when t3.bewart_id = 1001 then t3.umsatz_netto * vj_wt_1_fg else 0 end) as ums_netto_af_wvj
            ,sum(case when t3.bewart_id = 1001 then t3.umsatz_netto * vj_wt_2_fg else 0 end) as ums_netto_af_wvvj
            ,sum(case when t3.bewart_id = 1001 then t3.umsatz_netto * vj_1_fg else 0 end) as ums_netto_af_kvj
            ,sum(case when t3.bewart_id = 1001 then t3.umsatz_netto * vj_2_fg else 0 end) as ums_netto_af_kvvj
            ,sum(case when t3.bewart_id = 1002 then t3.umsatz_netto * akt_gj_fg else 0 end) as ums_netto_sa
            ,sum(case when t3.bewart_id = 1002 then t3.umsatz_netto * vj_wt_1_fg else 0 end) as ums_netto_sa_wvj
            ,sum(case when t3.bewart_id = 1002 then t3.umsatz_netto * vj_wt_2_fg else 0 end) as ums_netto_sa_wvvj
            ,sum(case when t3.bewart_id = 1002 then t3.umsatz_netto * vj_1_fg else 0 end) as ums_netto_sa_kvj
            ,sum(case when t3.bewart_id = 1002 then t3.umsatz_netto * vj_2_fg else 0 end) as ums_netto_sa_kvvj
            ,sum(case when t3.bewart_id = 1001 then t3.menge * akt_gj_fg else 0 end) as menge_absatz_af
            ,sum(case when t3.bewart_id = 1001 then t3.menge * vj_1_fg else 0 end) as menge_absatz_af_kvj
            ,sum(case when t3.bewart_id = 1001 then t3.menge * vj_wt_1_fg else 0 end) as menge_absatz_af_wvj
            ,sum(case when t3.bewart_id = 1002 then t3.menge * akt_gj_fg else 0 end) as menge_absatz_sa
            ,sum(case when t3.bewart_id = 1002 then t3.menge * vj_1_fg else 0 end) as menge_absatz_sa_kvj
            ,sum(case when t3.bewart_id = 1002 then t3.menge * vj_wt_1_fg else 0 end) as menge_absatz_sa_wvj
      from dbp_etl.dat_vj_vergleich_2 dt1
      join _murks_2 t3
        on dt1.mandant_id = t3.mandant_id and 
           dt1.nb_id = t3.nb_id and 
           dt1.wup_id = t3.wup_id and
           dt1.join_dat = t3.dat
      join dbp_data.wg_per_2 t4                                                                            
        on t3.mandant_id = t4.mandant_id and 
           t3.wg_id = t4.wg_id and 
           t4.arthiertyp_id = 2 and 
           t4.dat_bis = '9999-12-31'
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17) dt2
;

insert into dbp_etl.vis_artbew_tmp_2 (mandant_id,
                                    nb_id,
                                    wup_id,
                                    abt_id,
                                    wg_id,
                                    arthiertyp_id,
                                    gj,
                                    kjmo,
                                    kjwo,
                                    mo_kj,
                                    dat,
                                    akt_gj,
                                    akt_mo,
                                    akt_wo,
                                    akt_tag,
                                    wtag_id,
                                    wrg_id,
                                    ums_netto,
                                    ums_netto_wvj,
                                    ums_netto_wvvj,
                                    ums_netto_kvj,
                                    ums_netto_kvvj,
                                    ums_brutto,
                                    ums_brutto_wvj,
                                    ums_brutto_wvvj,
                                    ums_brutto_kvj,
                                    ums_brutto_kvvj,
                                    menge_absatz,
                                    menge_absatz_kvj,
                                    menge_absatz_kvvj,
                                    menge_absatz_wvj,
                                    ums_netto_af,
                                    ums_netto_af_wvj,
                                    ums_netto_af_wvvj,
                                    ums_netto_af_kvj,
                                    ums_netto_af_kvvj,
                                    ums_netto_sa,
                                    ums_netto_sa_wvj,
                                    ums_netto_sa_wvvj,
                                    ums_netto_sa_kvj,
                                    ums_netto_sa_kvvj,
                                    menge_absatz_af,
                                    menge_absatz_af_kvj,
                                    menge_absatz_af_wvj,
                                    menge_absatz_sa,
                                    menge_absatz_sa_kvj,
                                    menge_absatz_sa_wvj)
select dt1.mandant_id,
       dt1.nb_id,
       dt1.wup_id,
       dt1.abt_id,
       dt1.wg_id,
       dt1.arthiertyp_id,
       t1.gj,
       t1.kjmo,
       t1.kjwo,
       t1.mo_kj,
       t1.dat,
       t1.akt_gj,
       t1.akt_mo,
       t1.akt_wo,
       t1.akt_tag,
       t1.wtag_id,
       dt1.wrg_id,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0
from (select wg_id
            ,gj
            ,wup_id
            ,nb_id
            ,mandant_id
            ,abt_id
            ,wrg_id
            ,arthiertyp_id
      from dbp_etl.vis_artbew_tmp_2 t2
      group by 1,2,3,4,5,6,7,8) dt1
join (select *
      from dbp_data.tag_2
      where akt_gj in (0,-1,-2) or
           (akt_gj = 1 and
            substr(cast(kjmo as varchar(6)),5,2) in ('03','04','05','06','07','08','09','10','11','12'))) t1_2
  on t1.gj = dt1.gj
where not exists (select * from dbp_etl.vis_artbew_tmp_2 t3 where t3.dat = t1.dat and t3.wg_id = dt1.wg_id and t3.wup_id = dt1.wup_id and t3.mandant_id = dt1.mandant_id)
;

delete from dbp_etl.vis_artbew_abschrift_tmp_2 
where mandant_id in (${MANDANT_2});

insert into dbp_etl.vis_artbew_abschrift_tmp_2 (mandant_id,
                                              nb_id,
                                              wup_id,
                                              abt_id,
                                              wg_id,
                                              arthiertyp_id,
                                              gj,
                                              kjmo,
                                              kjwo,
                                              mo_kj,
                                              dat,
                                              akt_gj,
                                              akt_mo,
                                              akt_wo,
                                              akt_tag,
                                              wtag_id,
                                              wrg_id,
                                              ums_netto,
                                              ums_netto_wvj,
                                              ums_netto_wvvj,
                                              ums_netto_kvj,
                                              ums_netto_kvvj,
                                              ums_brutto,
                                              ums_brutto_wvj,
                                              ums_brutto_wvvj,
                                              ums_brutto_kvj,
                                              ums_brutto_kvvj)
select mandant_id,
       nb_id,
       wup_id,
       abt_id,
       wg_id,
       arthiertyp_id,
       gj,
       kjmo,
       kjwo,
       mo_kj,
       dat,
       akt_gj,
       akt_mo,
       akt_wo,
       akt_tag,
       wtag_id,
       wrg_id,
       ums_netto,
       ums_netto_wvj,
       ums_netto_wvvj,
       ums_netto_kvj,
       ums_netto_kvvj,
       ums_brutto,
       ums_brutto_wvj,
       ums_brutto_wvvj,
       ums_brutto_kvj,
       ums_brutto_kvvj
from dbp_etl.vis_artbew_tmp_2
;

update dbp_etl.vis_artbew_tmp_2

set wup_id = wup_id_

from (select t1.mandant_id as mandant_id_
            ,t1.nb_id as nb_id_
            ,t2.wup_id as wup_id_
            ,t1.wup_id as wup_id_alt_
      from dbp_data.wup_2 t1_2
      join dbp_data.wup_2 t2
        on t2.wup_id_alt = t1.wup_id and 
           t2.nb_id = t1.nb_id and 
           t2.mandant_id = t1.mandant_id and 
           t2.dat_von <= current_date) x1
where mandant_id = mandant_id_ and 
      nb_id = nb_id_ and 
      wup_id = wup_id_alt_
;



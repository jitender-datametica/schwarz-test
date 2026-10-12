create or replace table dbp_etl.vis_monat_ums_wg_tmp_2 (
  mandant_id byteint not null,
  nb_id smallint not null,
  wup_id integer not null,
  wrg_id char(3) collate 'en-ci' not null,
  abt_id smallint not null,
  wg_id smallint not null,
  arthiertyp_id byteint not null,
  gj smallint not null,
  kjmo integer not null,
  akt_gj smallint not null,
  akt_mo smallint not null,
  mo_kj byteint not null,
  ums_netto decimal(18,2) not null,
  ums_netto_wvj decimal(18,2) not null,
  ums_netto_wvvj decimal(18,2) not null,
  ums_netto_kvj decimal(18,2) not null,
  ums_netto_kvvj decimal(18,2) not null,
  ums_brutto decimal(18,2) not null,
  ums_brutto_wvj decimal(18,2) not null,
  ums_brutto_wvvj decimal(18,2) not null,
  ums_brutto_kvj decimal(18,2) not null,
  ums_brutto_kvvj decimal(18,2) not null,
  ums_netto_plan decimal(18,2) not null,
  ums_netto_plan_extern decimal(18,2) not null,
  menge_absatz decimal(18,3) not null default 0,
  menge_absatz_kvj decimal(18,3) not null default 0,
  menge_absatz_kvvj decimal(18,3) not null default 0
);

create or replace table dbp_etl.vis_monat_ums_wg_abs_tmp_2 like dbp_etl.vis_monat_ums_wg_tmp_2;

insert into dbp_etl.vis_monat_ums_wg_tmp_2 (mandant_id
                                         ,nb_id
                                         ,wup_id
                                         ,wrg_id
                                         ,abt_id
                                         ,wg_id
                                         ,arthiertyp_id
                                         ,gj
                                         ,kjmo
                                         ,akt_gj
                                         ,akt_mo
                                         ,mo_kj
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
                                         ,ums_netto_plan
                                         ,ums_netto_plan_extern
                                         ,menge_absatz
                                         ,menge_absatz_kvj
                                         ,menge_absatz_kvvj)
select dt1.mandant_id
      ,dt1.nb_id
      ,dt1.wup_id
      ,dt1.wrg_id
      ,dt1.abt_id
      ,dt1.wg_id
      ,dt1.arthiertyp_id
      ,dt1.gj
      ,dt1.kjmo
      ,dt1.akt_gj
      ,dt1.akt_mo
      ,dt1.mo_kj
      ,dt1.ums_netto
      ,dt1.ums_netto_wvj
      ,dt1.ums_netto_wvvj
      ,dt1.ums_netto_kvj
      ,dt1.ums_netto_kvvj
      ,dt1.ums_brutto
      ,dt1.ums_brutto_wvj
      ,dt1.ums_brutto_wvvj
      ,dt1.ums_brutto_kvj
      ,dt1.ums_brutto_kvvj
      ,0
      ,0
      ,dt1.menge_absatz
      ,dt1.menge_absatz_kvj
      ,dt1.menge_absatz_kvvj
from (select a.mandant_id
            ,a.nb_id
            ,a.wup_id
            ,a.wrg_id
            ,a.abt_id
            ,a.wg_id
            ,a.arthiertyp_id
            ,a.gj
            ,a.kjmo
            ,a.akt_gj
            ,a.akt_mo
            ,a.mo_kj
            ,coalesce(m.gjmo,a.kjmo) as gjmo
            ,sum(a.ums_netto) as ums_netto
            ,sum(a.ums_netto_wvj) as ums_netto_wvj
            ,sum(a.ums_netto_wvvj) as ums_netto_wvvj
            ,sum(a.ums_netto_kvj) as ums_netto_kvj
            ,sum(a.ums_netto_kvvj) as ums_netto_kvvj
            ,sum(a.ums_brutto) as ums_brutto
            ,sum(a.ums_brutto_wvj) as ums_brutto_wvj
            ,sum(a.ums_brutto_wvvj) as ums_brutto_wvvj
            ,sum(a.ums_brutto_kvj) as ums_brutto_kvj
            ,sum(a.ums_brutto_kvvj) as ums_brutto_kvvj
            ,sum(a.menge_absatz) as menge_absatz
            ,sum(a.menge_absatz_kvj) as menge_absatz_kvj
            ,sum(a.menge_absatz_kvvj) as menge_absatz_kvvj
from dbp_etl.vis_artbew_tmp_2 a
left join dbp_data.monat_2 m
  on m.kjmo = a.kjmo
group by 1,2,3,4,5,6,7,8,9,10,11,12,13) dt1
;

insert into dbp_etl.vis_monat_ums_wg_tmp_2 (mandant_id
                                         ,nb_id
                                         ,wup_id
                                         ,wrg_id
                                         ,abt_id
                                         ,wg_id
                                         ,arthiertyp_id
                                         ,gj
                                         ,kjmo
                                         ,akt_gj
                                         ,akt_mo
                                         ,mo_kj
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
                                         ,ums_netto_plan
                                         ,ums_netto_plan_extern
                                         ,menge_absatz
                                         ,menge_absatz_kvj
                                         ,menge_absatz_kvvj)
select mandant_id
      ,t1.nb_id
      ,t1.wup_id
      ,t2.nach_wrg_id as wgr_id
      ,t1.abt_id
      ,t1.wg_id
      ,t1.arthiertyp_id
      ,t1.gj
      ,t1.kjmo
      ,t1.akt_gj
      ,t1.akt_mo
      ,t1.mo_kj
      ,t1.ums_netto * t2.umrechnungskurs as ums_netto
      ,t1.ums_netto_wvj * t2.umrechnungskurs as ums_netto_wvj
      ,t1.ums_netto_wvvj * t2.umrechnungskurs as ums_netto_wvvj
      ,t1.ums_netto_kvj * t2.umrechnungskurs as ums_netto_kvj
      ,t1.ums_netto_kvvj * t2.umrechnungskurs as ums_netto_kvvj
      ,t1.ums_brutto * t2.umrechnungskurs as ums_brutto
      ,t1.ums_brutto_wvj * t2.umrechnungskurs as ums_brutto_wvj
      ,t1.ums_brutto_wvvj * t2.umrechnungskurs as ums_brutto_wvvj
      ,t1.ums_brutto_kvj * t2.umrechnungskurs as ums_brutto_kvj
      ,t1.ums_brutto_kvvj * t2.umrechnungskurs as ums_brutto_kvvj
      ,t1.ums_netto_plan * t2.umrechnungskurs as ums_netto_plan
      ,t1.ums_netto_plan_extern * t2.umrechnungskurs as ums_netto_plan_extern
      ,t1.menge_absatz
      ,t1.menge_absatz_kvj
      ,t1.menge_absatz_kvvj
from dbp_etl.vis_monat_ums_wg_tmp_2 t1_2
join dbp_data.kurs_2 t2
  on t2.von_wrg_id = t1.wrg_id and 
     t2.dat_bis = '9999-12-31' and 
     t2.nach_wrg_id = 'EUR' and 
     t2.kurstyp_id = 3
where t1.wrg_id <> 'EUR'
;

delete from dbp_etl.vis_monat_ums_wg_abs_tmp_2
where mandant_id in (select mandant_id from dbp_etl.vis_mandant_2)
;

insert into dbp_etl.vis_monat_ums_wg_abs_tmp_2 (mandant_id
                                             ,nb_id
                                             ,wup_id
                                             ,wrg_id
                                             ,abt_id
                                             ,wg_id
                                             ,arthiertyp_id
                                             ,gj
                                             ,kjmo
                                             ,akt_gj
                                             ,akt_mo
                                             ,mo_kj
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
                                             ,ums_netto_plan
                                             ,ums_netto_plan_extern)
select mandant_id
      ,nb_id
      ,wup_id
      ,wrg_id
      ,abt_id
      ,wg_id
      ,arthiertyp_id
      ,gj
      ,kjmo
      ,akt_gj
      ,akt_mo
      ,mo_kj
      ,coalesce(ums_netto,0) as ums_netto
      ,coalesce(ums_netto_wvj,0) as ums_netto_wvj
      ,coalesce(ums_netto_wvvj,0) as ums_netto_wvvj
      ,coalesce(ums_netto_kvj,0) as ums_netto_kvj
      ,coalesce(ums_netto_kvvj,0) as ums_netto_kvvj
      ,coalesce(ums_brutto,0) as ums_brutto
      ,coalesce(ums_brutto_wvj,0) as ums_brutto_wvj
      ,coalesce(ums_brutto_wvvj,0) as ums_brutto_wvvj
      ,coalesce(ums_brutto_kvj,0) as ums_brutto_kvj
      ,coalesce(ums_brutto_kvvj,0) as ums_brutto_kvvj
      ,coalesce(ums_netto_plan,0) as ums_netto_plan
      ,coalesce(ums_netto_plan_extern,0) as ums_netto_plan_extern
from dbp_etl.vis_monat_ums_wg_tmp_2
;

delete from dbp_msi_data.vis_monat_umsatz_wg_2
where mandant_id in (select mandant_id from dbp_etl.vis_mandant_2)
;

insert into dbp_msi_data.vis_monat_umsatz_wg_2 (mandant_id
                                             ,nb_id
                                             ,wup_id
                                             ,wrg_id
                                             ,abt_id
                                             ,wg_id
                                             ,arthiertyp_id
                                             ,gj
                                             ,kjmo
                                             ,ums_netto
                                             ,ums_netto_kvj
                                             ,ums_brutto
                                             ,ums_brutto_kvj
                                             ,ums_netto_kvvj
                                             ,ums_netto_plan
                                             ,menge_absatz
                                             ,menge_absatz_kvj
                                             ,menge_absatz_kvvj)
select mandant_id
      ,nb_id
      ,wup_id
      ,wrg_id
      ,abt_id
      ,wg_id
      ,arthiertyp_id
      ,gj
      ,kjmo
      ,sum(ums_netto) as ums_netto
      ,sum(ums_netto_kvj) as ums_netto_kvj
      ,sum(ums_brutto) as ums_brutto
      ,sum(ums_brutto_kvj) as ums_brutto_kvj
      ,sum(ums_netto_kvvj) as ums_netto_kvvj
      ,sum(ums_netto_plan) as ums_netto_plan
      ,sum(menge_absatz) as menge_absatz
      ,sum(menge_absatz_kvj) as menge_absatz_kvj
      ,sum(menge_absatz_kvvj) as menge_absatz_kvvj
from dbp_etl.vis_monat_ums_wg_tmp_2
group by 1,2,3,4,5,6,7,8,9
;

delete from dbp_data.coi_ump_hwg_sum_2
where mandant_id = 1
;

insert into dbp_data.coi_ump_hwg_sum_2 (mandant_id
                                     ,wup_id
                                     ,nb_id
                                     ,dat
                                     ,hwg_id
                                     ,wrg_id
                                     ,umsatz_netto)
select vis.mandant_id
      ,vis.wup_id
      ,vis.nb_id
      ,vis.dat as dat
      ,v05.hwg_id
      ,vis.wrg_id
      ,sum(vis.ums_netto) as umsatz_netto
from dbp_msi_data.vis_tag_umsatz_wg_2 as vis 
join dbp_data.wg_per_2 as v04
  on vis.mandant_id = v04.mandant_id and 
     vis.wg_id = v04.wg_id and 
     vis.arthiertyp_id = v04.arthiertyp_id and 
     v04.dat_bis = '9999-12-31'
join dbp_data.owg_per_2 as v05
  on v04.mandant_id = v05.mandant_id and 
     v04.owg_id = v05.owg_id and 
     v04.arthiertyp_id = v05.arthiertyp_id and 
     v05.dat_bis = '9999-12-31'
where vis.mandant_id = 1
group by 1,2,3,4,5,6
;

insert into dbp_data.coi_ump_hwg_sum_2 (mandant_id
                                     ,wup_id
                                     ,nb_id
                                     ,dat
                                     ,hwg_id
                                     ,wrg_id
                                     ,umsatz_netto)
select vis.mandant_id,
       vis.wup_id,
       vis.nb_id,
       t.dat_vj as dat,
       v05.hwg_id,
       vis.wrg_id,
       sum(vis.ums_netto_wvj) as umsatz_netto
from dbp_msi_data.vis_tag_umsatz_wg_2 vis
join dbp_data.tag_2 t
  on vis.dat = t.dat
join dbp_data.wg_per_2 as v04
  on vis.mandant_id = v04.mandant_id and
     vis.wg_id = v04.wg_id and
     vis.arthiertyp_id = v04.arthiertyp_id and
     v04.dat_bis = '9999-12-31'
join dbp_data.owg_per_2 as v05
  on v04.mandant_id = v05.mandant_id and 
     v04.owg_id = v05.owg_id and 
     v04.arthiertyp_id = v05.arthiertyp_id and 
     v05.dat_bis = '9999-12-31'
where t.dat_vj < (select min(dat) from dbp_msi_data.vis_tag_umsatz_wg_2) and 
      vis.mandant_id = 1 and 
     (vis.mandant_id,vis.wup_id,vis.nb_id,t.dat_vj) not in (select mandant_id,wup_id,nb_id,dat from dbp_data.coi_ump_hwg_sum_2 where mandant_id = 1)
group by 1,2,3,4,5,6
;

create or replace table dbp_etl.vis_monat_ums_knd_tmp_2 (
  mandant_id byteint not null,
  nb_id smallint not null,
  wup_id integer not null,
  wrg_id char(3) collate 'en-ci' not null,
  gj smallint not null,
  akt_gj smallint not null,
  kjmo integer not null,
  akt_mo smallint not null,
  mo_kj byteint not null,
  ums_netto decimal(18,2),
  ums_netto_kvj decimal(18,2),
  ums_netto_kvvj decimal(18,2),
  ums_netto_plan decimal(18,2),
  ums_netto_plan_extern decimal(18,2),
  anz_kunde integer,
  anz_kunde_kvj integer,
  anz_kunde_kvvj integer,
  offen integer,
  offen_kvj integer,
  offen_kvvj integer,
  rohertrag decimal(18,2),
  rohertrag_kvj decimal(18,2),
  rohertrag_plan decimal(18,2),
  pers_kost decimal(18,2),
  pers_kost_kvj decimal(18,2),
  pers_kost_plan decimal(18,2),
  pers_ohne decimal(18,2),
  pers_ohne_kvj decimal(18,2),
  pers_ohne_plan decimal(18,2),
  pers_std decimal(18,2),
  pers_std_kvj decimal(18,2),
  pers_std_plan decimal(18,2),
  pers_auq decimal(18,2),
  pers_auq_kvj decimal(18,2),
  pers_fluq decimal(18,2),
  pers_fluq_kvj decimal(18,2)
);

create or replace table dbp_etl.vis_ker_ums_monat_tmp_2 (
  mandant_id byteint not null,
  nb_id smallint not null,
  wup_id integer not null,
  wrg_id char(3) collate 'en-ci' not null,
  gj smallint not null,
  akt_gj smallint not null,
  kjmo integer not null,
  akt_mo smallint not null,
  mo_kj byteint not null,
  ums_netto_ker decimal(18,2),
  ums_netto_ker_kvj decimal(18,2),
  ums_netto_ker_kvvj decimal(18,2),
  ums_netto_ker_plan decimal(18,2),
  ums_netto decimal(18,2),
  ums_netto_plan decimal(18,2),
  ums_netto_plan_extern decimal(18,2)
);

insert into dbp_etl.vis_ker_ums_monat_tmp_2 (mandant_id
                                          ,nb_id
                                          ,wup_id
                                          ,gj
                                          ,kjmo
                                          ,akt_gj
                                          ,akt_mo
                                          ,mo_kj
                                          ,wrg_id
                                          ,ums_netto_ker
                                          ,ums_netto_ker_kvj
                                          ,ums_netto_ker_kvvj
                                          ,ums_netto_ker_plan
                                          ,ums_netto
                                          ,ums_netto_plan
                                          ,ums_netto_plan_extern)
select kr.mandant_id
      ,kr.nb_id
      ,kr.wup_id
      ,kr.gj
      ,kr.kjmo
      ,kr.akt_gj
      ,kr.akt_mo
      ,kr.mo_kj
      ,kr.umsatz_wrg as wrg_id
      ,sum(kr.ums_n_ker) as ums_netto_ker
      ,sum(kr.ums_n_ker_kvj) as ums_netto_ker_kvj
      ,sum(kr.ums_n_ker_kvvj) as ums_netto_ker_kvvj
      ,sum(kr.ums_n_ker_plan) as ums_netto_ker_plan
      ,0 as ums_netto
      ,0 as ums_netto_plan
      ,0 as ums_netto_plan_extern
from dbp_etl.vis_ker_monat_wup_tmp_2 kr
group by 1,2,3,4,5,6,7,8,9
;

insert into dbp_etl.vis_ker_ums_monat_tmp_2 (mandant_id
                                          ,nb_id
                                          ,wup_id
                                          ,gj
                                          ,kjmo
                                          ,akt_gj
                                          ,akt_mo
                                          ,mo_kj
                                          ,wrg_id
                                          ,ums_netto_ker
                                          ,ums_netto_ker_kvj
                                          ,ums_netto_ker_kvvj
                                          ,ums_netto_ker_plan
                                          ,ums_netto
                                          ,ums_netto_plan
                                          ,ums_netto_plan_extern)
select ums.mandant_id
      ,ums.nb_id
      ,ums.wup_id
      ,ums.gj
      ,ums.kjmo
      ,ums.akt_gj
      ,ums.akt_mo
      ,ums.mo_kj
      ,ums.wrg_id
      ,0 as ums_netto_ker
      ,0 as ums_netto_ker_kvj
      ,0 as ums_netto_ker_kvvj
      ,0 as ums_netto_ker_plan
      ,sum(ums.ums_netto) as ums_netto
      ,sum(ums.ums_netto_plan) as ums_netto_plan
      ,sum(ums.ums_netto_plan_extern) as ums_netto_plan_extern
from dbp_etl.vis_monat_ums_wg_tmp_2 ums
group by 1,2,3,4,5,6,7,8,9
;

insert into dbp_etl.vis_ker_ums_monat_tmp_2 (mandant_id
                                          ,nb_id
                                          ,wup_id
                                          ,wrg_id
                                          ,gj
                                          ,akt_gj
                                          ,kjmo
                                          ,akt_mo
                                          ,mo_kj
                                          ,ums_netto_ker
                                          ,ums_netto_ker_kvj
                                          ,ums_netto_ker_kvvj
                                          ,ums_netto_ker_plan
                                          ,ums_netto
                                          ,ums_netto_plan
                                          ,ums_netto_plan_extern)
select a.mandant_id,
       a.nb_id,
       a.wup_id,
       c.wrg_id,
       b.gj,
       b.akt_gj,
       a.kjmo,
       b.akt_mo,
       b.mo_kj,
       0 as ums_netto_ker,
       0 as ums_netto_ker_kvj,
       0 as ums_netto_ker_kvvj,
       0 as ums_netto_ker_plan,
       0 as ums_netto,
       0 as ums_netto_plan,
       0 as ums_netto_plan_extern
from dbp_etl_process.personalstd_2 a
join dbp_data.monat_2 b
  on a.kjmo = b.kjmo
join (select mandant_id,
             wrg_id
      from dbp_etl.vis_ker_ums_monat_tmp_2
      group by 1,2) c
  on a.mandant_id = c.mandant_id
where (a.mandant_id,a.wup_id,a.kjmo) not in (select mandant_id,
                                                    wup_id,
                                                    kjmo
                                             from dbp_etl.vis_ker_ums_monat_tmp_2) and
       a.kjmo between (select kjmo from dbp_data.monat_2 where akt_mo = -2) and (select kjmo from dbp_data.monat_2 where akt_mo = 1) and
       a.mandant_id in (select mandant_id from dbp_etl.vis_mandant_2) and
      (a.stunden_ist <> 0 or
       a.stunden_plan <> 0)
;

insert into dbp_etl.vis_ker_ums_monat_tmp_2 (mandant_id
                                          ,nb_id
                                          ,wup_id
                                          ,gj
                                          ,kjmo
                                          ,akt_gj
                                          ,akt_mo
                                          ,mo_kj
                                          ,wrg_id
                                          ,ums_netto_ker
                                          ,ums_netto_ker_kvj
                                          ,ums_netto_ker_kvvj
                                          ,ums_netto_ker_plan
                                          ,ums_netto
                                          ,ums_netto_plan
                                          ,ums_netto_plan_extern)
select v.mandant_id
      ,v.nb_id
      ,v.wup_id
      ,v.gj
      ,v.kjmo
      ,v.akt_gj
      ,v.akt_mo
      ,m.mo_kj
      ,v.wrg_id
      ,0 as ums_netto_ker
      ,0 as ums_netto_ker_kvj
      ,0 as ums_netto_ker_kvvj
      ,0 as ums_netto_ker_plan
      ,0 as ums_netto
      ,sum(v.ums_netto_plan) as ums_netto_plan
      ,sum(v.ums_netto_plan_extern) as ums_netto_plan_extern
from dbp_etl.vis_tag_ums_wup_tmp_2 v
join dbp_data.monat_2 m
  on m.kjmo = v.kjmo
group by 1,2,3,4,5,6,7,8,9
;

insert into dbp_etl.vis_monat_ums_knd_tmp_2 (mandant_id
                                          ,nb_id
                                          ,wup_id
                                          ,wrg_id
                                          ,gj
                                          ,kjmo
                                          ,akt_gj
                                          ,akt_mo
                                          ,mo_kj
                                          ,ums_netto
                                          ,ums_netto_kvj
                                          ,ums_netto_kvvj
                                          ,ums_netto_plan
                                          ,ums_netto_plan_extern)
select dt1.mandant_id
      ,dt1.nb_id
      ,dt1.wup_id
      ,dt1.wrg_id
      ,dt1.gj
      ,dt1.kjmo
      ,dt1.akt_gj
      ,dt1.akt_mo
      ,dt1.mo_kj
      ,dt1.ums_netto
      ,dt1.ums_netto_kvj
      ,dt1.ums_netto_kvvj
      ,dt1.ums_netto_plan
      ,dt1.ums_netto_plan_extern
from (select d1.mandant_id
            ,d1.nb_id
            ,d1.wup_id
            ,d1.wrg_id
            ,d1.gj
            ,d1.kjmo
            ,d1.akt_gj
            ,d1.akt_mo
            ,d1.mo_kj
            ,case
               when bk.akt_buchungs_schluss <=0 or mod(d1.kjmo,100) = 13 then coalesce(d1.ums_netto_ker,d1.ums_netto)
               when d1.mandant_id = 1 and (bk.akt_fruehinfo1=0 or mod(d1.kjmo,100) = 13) then coalesce(d1.ums_netto_ker,d1.ums_netto)
               else d1.ums_netto
             end as ums_netto
            ,d1.ums_netto_ker_kvj as ums_netto_kvj
            ,d1.ums_netto_ker_kvvj as ums_netto_kvvj
            ,case
               when bk.akt_buchungs_schluss <=0 or mod(d1.kjmo,100) = 13 then coalesce(d1.ums_netto_ker_plan,d1.ums_netto_plan)
               when d1.mandant_id = 1 and (bk.akt_fruehinfo1=0 or mod(d1.kjmo,100) = 13) then coalesce(d1.ums_netto_ker_plan,d1.ums_netto_plan)
               else d1.ums_netto_plan
             end as ums_netto_plan
            ,d1.ums_netto_plan_extern as ums_netto_plan_extern
from (select mandant_id
            ,nb_id
            ,wup_id
            ,wrg_id
            ,gj
            ,kjmo
            ,akt_gj
            ,akt_mo
            ,mo_kj
            ,sum(ums_netto) as ums_netto
            ,sum(ums_netto_ker) as ums_netto_ker
            ,sum(ums_netto_ker_kvj) as ums_netto_ker_kvj
            ,sum(ums_netto_ker_kvvj) as ums_netto_ker_kvvj
            ,sum(ums_netto_ker_plan) as ums_netto_ker_plan
            ,sum(ums_netto_plan) as ums_netto_plan
            ,sum(ums_netto_plan_extern) as ums_netto_plan_extern
      from dbp_etl.vis_ker_ums_monat_tmp_2             
      group by 1,2,3,4,5,6,7,8,9) d1 
left join dbp_data.l_buchungsstatus_ker_2 bk
  on d1.kjmo = bk.kj_ker_mo_id) dt1
;

update dbp_etl.vis_monat_ums_knd_tmp_2 from (select mandant_id as mandant_id_
                                                 ,nb_id as nb_id_
                                                 ,wup_id as wup_id_
                                                 ,kjmo as kjmo_
                                                 ,sum(anz_kunde) as kunde_anz_
                                                 ,sum(anz_kunde_kvj) as kunde_anz_kvj_
                                                 ,sum(anz_kunde_kvvj) as kunde_anz_kvvj_
                                                 ,sum(anz_offen) as offen_
                                                 ,sum(anz_offen_kvj) as offen_kvj_
                                                 ,sum(anz_offen_kvvj) as offen_kvvj_
                                           from dbp_etl.vis_kunde_wup_tmp_2
                                           group by 1,2,3,4) x1
set anz_kunde = kunde_anz_
   ,anz_kunde_kvj = kunde_anz_kvj_
   ,anz_kunde_kvvj = kunde_anz_kvvj_
   ,offen = offen_
   ,offen_kvj = offen_kvj_
   ,offen_kvvj = offen_kvvj_

where mandant_id = mandant_id_ and 
      nb_id = nb_id_ and 
      wup_id = wup_id_ and 
      kjmo = kjmo_
;

update dbp_etl.vis_monat_ums_knd_tmp_2 from (select t1.mandant_id as mandant_id_
                                                 ,t1.nb_id as nb_id_
                                                 ,t1.wup_id as wup_id_
                                                 ,t1.kjmo as kjmo_
                                                 ,t1.pers_std as pers_std_
                                                 ,t1.pers_std_kvj as pers_std_kvj_
                                                 ,t1.pers_std_plan as pers_std_plan_
                                                 ,zeroifnull(abwesenheit_tage * 100 / nullifzero(anz_tage)) as pers_auq_
                                                 ,zeroifnull(abwesenheit_tage_kvj * 100 / nullifzero(anz_tage_kvj)) as pers_auq_kvj_
                                                 ,zeroifnull(pers_austritte * 100 / nullifzero(pers_anz)) as pers_fluq_
                                                 ,zeroifnull(pers_austritte_kvj *100 / nullifzero(pers_anz_kvj)) as pers_fluq_kvj_
                                           from dbp_etl.vis_personal_wup_tmp1_2 t1_2) x2
set pers_std = pers_std_
   ,pers_std_kvj = pers_std_kvj_
   ,pers_std_plan = pers_std_plan_
   ,pers_auq = pers_auq_
   ,pers_auq_kvj = pers_auq_kvj_
   ,pers_fluq = pers_fluq_
   ,pers_fluq_kvj = pers_fluq_kvj_

where mandant_id = mandant_id_ and 
      nb_id = nb_id_ and 
      wup_id = wup_id_ and 
      kjmo = kjmo_     
;

update dbp_etl.vis_monat_ums_knd_tmp_2 from (select t1.mandant_id as mandant_id_
                                                 ,t1.nb_id as nb_id_
                                                 ,t1.wup_id as wup_id_
                                                 ,t1.kjmo as kjmo_
                                                 ,t1.umsatz_wrg as wrg_id_
                                                 ,sum(t1.rohertrag) as rohertrag_
                                                 ,sum(t1.rohertrag_kvj) as rohertrag_kvj_
                                                 ,sum(t1.rohertrag_plan) as rohertrag_plan_
                                                 ,sum(t1.pk_ker) as pers_kost_
                                                 ,sum(t1.pk_ker_kvj) as pers_kost_kvj_
                                                 ,sum(t1.pk_ker_plan) as pers_kost_plan_
                                                 ,sum(t1.pk_ohne) as pers_ohne_
                                                 ,sum(t1.pk_ohne_kvj) as pers_ohne_kvj_
                                                 ,sum(t1.pk_ohne_plan) as pers_ohne_plan_
                                           from dbp_etl.vis_ker_monat_wup_tmp_2 t1_2
                                           group by 1,2,3,4,5) x3
set rohertrag = rohertrag_
   ,rohertrag_kvj = rohertrag_kvj_
   ,rohertrag_plan = rohertrag_plan_
   ,pers_kost = pers_kost_
   ,pers_kost_kvj = pers_kost_kvj_
   ,pers_kost_plan = pers_kost_plan_
   ,pers_ohne = pers_ohne_
   ,pers_ohne_kvj = pers_ohne_kvj_
   ,pers_ohne_plan = pers_ohne_plan_

where mandant_id = mandant_id_ and 
      nb_id = nb_id_ and 
      wup_id = wup_id_ and 
      kjmo = kjmo_ and 
      wrg_id = wrg_id_
;

delete from dbp_msi_data.vis_monat_ums_kunde_pers_wup_2
where mandant_id in  (select mandant_id from dbp_etl.vis_mandant_2)
;

insert into dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 (mandant_id
                                                      ,nb_id
                                                      ,wup_id
                                                      ,wrg_id
                                                      ,kjmo
                                                      ,gj
                                                      ,akt_gj
                                                      ,akt_mo
                                                      ,mo_kj
                                                      ,ums_netto
                                                      ,ums_netto_kvj
                                                      ,ums_netto_kvvj
                                                      ,ums_netto_plan
                                                      ,ums_netto_plan_extern
                                                      ,anz_kunde
                                                      ,anz_kunde_kvj
                                                      ,anz_kunde_kvvj
                                                      ,anz_offen
                                                      ,anz_offen_kvj
                                                      ,anz_offen_kvvj
                                                      ,rohertrag
                                                      ,rohertrag_kum
                                                      ,rohertrag_kvj
                                                      ,rohertrag_kvj_kum
                                                      ,rohertrag_plan
                                                      ,rohertrag_plan_kum
                                                      ,pers_kosten
                                                      ,pers_kosten_kum
                                                      ,pers_kosten_kvj
                                                      ,pers_kosten_kvj_kum
                                                      ,pers_kosten_plan
                                                      ,pers_kosten_plan_kum
                                                      ,pers_k_ohne
                                                      ,pers_k_ohne_kum
                                                      ,pers_k_ohne_kvj
                                                      ,pers_k_ohne_kvj_kum
                                                      ,pers_k_ohne_plan
                                                      ,pers_k_ohne_plan_kum
                                                      ,pers_std
                                                      ,pers_std_kum
                                                      ,pers_std_kvj
                                                      ,pers_std_kvj_kum
                                                      ,pers_std_plan
                                                      ,pers_std_plan_kum
                                                      ,pers_auq
                                                      ,pers_auq_kum
                                                      ,pers_auq_kvj
                                                      ,pers_auq_kvj_kum
                                                      ,pers_fluq
                                                      ,pers_fluq_kum
                                                      ,pers_fluq_kvj
                                                      ,pers_fluq_kvj_kum
                                                      ,td_insert
                                                      ,td_update)
select mandant_id
      ,nb_id
      ,wup_id
      ,wrg_id
      ,kjmo
      ,gj
      ,akt_gj
      ,akt_mo
      ,mo_kj
      ,coalesce(ums_netto,0)
      ,coalesce(ums_netto_kvj,0)
      ,coalesce(ums_netto_kvvj,0)
      ,coalesce(ums_netto_plan,0)
      ,coalesce(ums_netto_plan_extern,0)
      ,coalesce(anz_kunde,0)
      ,coalesce(anz_kunde_kvj,0)
      ,coalesce(anz_kunde_kvvj,0)
      ,coalesce(offen,0)
      ,coalesce(offen_kvj,0)
      ,coalesce(offen_kvvj,0)
      ,coalesce(rohertrag,0)
      ,0 as rohertrag_kum
      ,coalesce(rohertrag_kvj,0)
      ,0 as rohertrag_kvj_kum
      ,coalesce(rohertrag_plan,0)
      ,0 as rohertrag_plan_kum
      ,coalesce(pers_kost,0)
      ,0 as pers_kosten_kum
      ,coalesce(pers_kost_kvj,0)
      ,0 as pers_kosten_kvj_kum
      ,coalesce(pers_kost_plan,0)
      ,0 as pers_kosten_plan_kum
      ,coalesce(pers_ohne,0)
      ,0 as pers_k_ohne_kum
      ,coalesce(pers_ohne_kvj,0)
      ,0 as pers_k_ohne_kvj_kum
      ,coalesce(pers_ohne_plan,0)
      ,0 as pers_k_ohne_plan_kum
      ,coalesce(pers_std,0)
      ,0 as pers_std_kum
      ,coalesce(pers_std_kvj,0)
      ,0 as pers_std_kvj_kum
      ,coalesce(pers_std_plan,0)
      ,0 as pers_std_plan_kum
      ,coalesce(pers_auq,0)
      ,0 as pers_auq_kum
      ,coalesce(pers_auq_kvj,0)
      ,0 as pers_auq_kvj_kum
      ,coalesce(pers_fluq,0)
      ,0 as pers_fluq_kum
      ,coalesce(pers_fluq_kvj,0)
      ,0 as pers_fluq_kvj_kum
      ,current_timestamp as td_insert
      ,current_timestamp as td_update
from (select v.mandant_id
            ,v.nb_id
            ,v.wup_id
            ,v.wrg_id
            ,v.gj
            ,v.akt_gj
            ,v.kjmo
            ,coalesce(m.gjmo,v.kjmo) as gjmo
            ,v.akt_mo
            ,v.mo_kj
            ,v.ums_netto
            ,v.ums_netto_kvj
            ,v.ums_netto_kvvj
            ,0 as ums_netto_plan
            ,0 as ums_netto_plan_extern
            ,v.anz_kunde
            ,v.anz_kunde_kvj
            ,v.anz_kunde_kvvj
            ,v.offen
            ,v.offen_kvj
            ,v.offen_kvvj
            ,v.rohertrag
            ,v.rohertrag_kvj
            ,v.rohertrag_plan
            ,v.pers_kost
            ,v.pers_kost_kvj
            ,v.pers_kost_plan
            ,v.pers_ohne
            ,v.pers_ohne_kvj
            ,v.pers_ohne_plan
            ,v.pers_std
            ,v.pers_std_kvj
            ,v.pers_std_plan
            ,v.pers_auq
            ,v.pers_auq_kvj
            ,v.pers_fluq
            ,v.pers_fluq_kvj
from dbp_etl.vis_monat_ums_knd_tmp_2 v
join dbp_etl.vis_mandant_2 vm
  on vm.mandant_id = v.mandant_id
left join dbp_data.monat_2 m
  on m.kjmo = v.kjmo   
) dt1
;

update dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 from (select mandant_id,
                                                              wup_id,
                                                              nb_id,
                                                              wrg_id,
                                                              kjmo,
                                                              sum(ums_netto_plan) as ums_netto_plan,
                                                              sum(ums_netto_plan_extern) as ums_netto_plan_extern
                                                       from dbp_msi_data.vis_tag_umsatz_kunde_wup_2
                                                       group by 1,2,3,4,5) b
set ums_netto_plan = b.ums_netto_plan,
    ums_netto_plan_extern = b.ums_netto_plan_extern
where dbp_msi_data.vis_monat_ums_kunde_pers_wup.mandant_id = b.mandant_id and
      dbp_msi_data.vis_monat_ums_kunde_pers_wup.wup_id = b.wup_id and
      dbp_msi_data.vis_monat_ums_kunde_pers_wup.nb_id = b.nb_id and
      dbp_msi_data.vis_monat_ums_kunde_pers_wup.wrg_id = b.wrg_id and
      dbp_msi_data.vis_monat_ums_kunde_pers_wup.kjmo = b.kjmo
;

create or replace volatile table _murks_2 as (
select a.mandant_id
      ,b.nb_id
      ,b.wup_id
      ,a.wrg_id
      ,a.kjmo
      ,a.gj
      ,a.akt_gj
      ,a.akt_mo
      ,a.mo_kj                       
      ,sum(distinct a.ums_netto) as ums_netto
      ,sum(distinct a.ums_netto_kvj) as ums_netto_kvj
      ,sum(distinct a.ums_netto_kvvj) as ums_netto_kvvj
      ,sum(distinct a.ums_netto_plan) as ums_netto_plan
      ,sum(distinct a.ums_netto_plan_extern) as ums_netto_plan_extern
      ,sum(distinct a.anz_kunde) as anz_kunde
      ,sum(distinct a.anz_kunde_kvj) as anz_kunde_kvj
      ,sum(distinct a.anz_kunde_kvvj) as anz_kunde_kvvj
      ,sum(distinct a.anz_offen) as anz_offen
      ,sum(distinct a.anz_offen_kvj) as anz_offen_kvj
      ,sum(distinct a.anz_offen_kvvj) as anz_offen_kvvj
      ,sum(distinct a.rohertrag) as rohertrag
      ,sum(distinct a.rohertrag_kvj) as rohertrag_kvj
      ,sum(distinct a.rohertrag_plan) as rohertrag_plan
      ,sum(distinct a.pers_kosten) as pers_kosten
      ,sum(distinct a.pers_kosten_kvj) as pers_kosten_kvj
      ,sum(distinct a.pers_kosten_plan) as pers_kosten_plan
      ,sum(distinct a.pers_k_ohne) as pers_k_ohne
      ,sum(distinct a.pers_k_ohne_kvj) as pers_k_ohne_kvj
      ,sum(distinct a.pers_k_ohne_plan) as pers_k_ohne_plan
      ,sum(distinct a.pers_std) as pers_std
      ,sum(distinct a.pers_std_kvj) as pers_std_kvj
      ,sum(distinct a.pers_std_plan) as pers_std_plan
      ,sum(distinct a.pers_auq) as pers_auq
      ,sum(distinct a.pers_auq_kvj) as pers_auq_kvj
      ,sum(distinct a.pers_fluq) as pers_fluq
      ,sum(distinct a.pers_fluq_kvj) as pers_fluq_kvj
      ,max(a.td_insert) as td_insert
      ,max(a.td_update) as td_update
from dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 a
join dbp_data.wup_2 b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id
where (a.mandant_id,a.wup_id) in (select mandant_id,wup_id
                                  from dbp_msi_data.vis_monat_ums_kunde_pers_wup_2
                                  group by 1,2
                                  having count(distinct nb_id) > 1)
group by 1,2,3,4,5,6,7,8,9
);

delete from dbp_msi_data.vis_monat_ums_kunde_pers_wup_2
where (mandant_id,wup_id) in (select mandant_id,wup_id from _murks_2)
;

insert into dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 (mandant_id
                                                      ,nb_id
                                                      ,wup_id
                                                      ,wrg_id
                                                      ,kjmo
                                                      ,gj
                                                      ,akt_gj
                                                      ,akt_mo
                                                      ,mo_kj
                                                      ,ums_netto
                                                      ,ums_netto_kvj
                                                      ,ums_netto_kvvj
                                                      ,ums_netto_plan
                                                      ,ums_netto_plan_extern
                                                      ,anz_kunde
                                                      ,anz_kunde_kvj
                                                      ,anz_kunde_kvvj
                                                      ,anz_offen
                                                      ,anz_offen_kvj
                                                      ,anz_offen_kvvj
                                                      ,rohertrag
                                                      ,rohertrag_kum
                                                      ,rohertrag_kvj
                                                      ,rohertrag_kvj_kum
                                                      ,rohertrag_plan
                                                      ,rohertrag_plan_kum
                                                      ,pers_kosten
                                                      ,pers_kosten_kum
                                                      ,pers_kosten_kvj
                                                      ,pers_kosten_kvj_kum
                                                      ,pers_kosten_plan
                                                      ,pers_kosten_plan_kum
                                                      ,pers_k_ohne
                                                      ,pers_k_ohne_kum
                                                      ,pers_k_ohne_kvj
                                                      ,pers_k_ohne_kvj_kum
                                                      ,pers_k_ohne_plan
                                                      ,pers_k_ohne_plan_kum
                                                      ,pers_std
                                                      ,pers_std_kum
                                                      ,pers_std_kvj
                                                      ,pers_std_kvj_kum
                                                      ,pers_std_plan
                                                      ,pers_std_plan_kum
                                                      ,pers_auq
                                                      ,pers_auq_kum
                                                      ,pers_auq_kvj
                                                      ,pers_auq_kvj_kum
                                                      ,pers_fluq
                                                      ,pers_fluq_kum
                                                      ,pers_fluq_kvj
                                                      ,pers_fluq_kvj_kum
                                                      ,td_insert
                                                      ,td_update)
select mandant_id
      ,nb_id
      ,wup_id
      ,wrg_id
      ,kjmo
      ,gj
      ,akt_gj
      ,akt_mo
      ,mo_kj
      ,ums_netto
      ,ums_netto_kvj
      ,ums_netto_kvvj
      ,ums_netto_plan
      ,ums_netto_plan_extern
      ,anz_kunde
      ,anz_kunde_kvj
      ,anz_kunde_kvvj
      ,anz_offen
      ,anz_offen_kvj
      ,anz_offen_kvvj
      ,rohertrag
      ,0 as rohertrag_kum
      ,rohertrag_kvj
      ,0 as rohertrag_kvj_kum
      ,rohertrag_plan
      ,0 as rohertrag_plan_kum
      ,pers_kosten
      ,0 as pers_kosten_kum
      ,pers_kosten_kvj
      ,0 as pers_kosten_kvj_kum
      ,pers_kosten_plan
      ,0 as pers_kosten_plan_kum
      ,pers_k_ohne
      ,0 as pers_k_ohne_kum
      ,pers_k_ohne_kvj
      ,0 as pers_k_ohne_kvj_kum
      ,pers_k_ohne_plan
      ,0 as pers_k_ohne_plan_kum
      ,pers_std
      ,0 as pers_std_kum
      ,pers_std_kvj
      ,0 as pers_std_kvj_kum
      ,pers_std_plan
      ,0 as pers_std_plan_kum
      ,pers_auq
      ,0 as pers_auq_kum
      ,pers_auq_kvj
      ,0 as pers_auq_kvj_kum
      ,pers_fluq
      ,0 as pers_fluq_kum
      ,pers_fluq_kvj
      ,0 as pers_fluq_kvj_kum
      ,td_insert
      ,td_update
from _murks_2
;

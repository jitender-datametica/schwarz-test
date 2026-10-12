create or replace table dbp_etl.vis_plan_tag_wup_tmp_2 (
   mandant_id byteint not null,
   nb_id smallint not null,
   wup_id integer not null,
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
   plan_tag_fg byteint ,
   ums_netto_plan decimal(18,2),
   ums_netto_plan_extern decimal(18,2)
);

insert into dbp_etl.vis_plan_tag_wup_tmp_2 (mandant_id
                                         ,nb_id
                                         ,wup_id
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
                                         ,plan_tag_fg
                                         ,ums_netto_plan
                                         ,ums_netto_plan_extern)
select t1.mandant_id
      ,t1.nb_id
      ,t2.wup_id
      ,t1.gj 
      ,t1.kjmo
      ,t1.kjwo
      ,t1.mo_kj
      ,t1.join_dat
      ,t1.akt_gj
      ,t1.akt_mo
      ,t1.akt_wo
      ,t1.akt_tag
      ,t1.wtag_id
      ,t2.wrg_id
      ,t2.plan_tag_fg
      ,t2.umsatz_netto_plan as ums_netto_plan
      ,coalesce(t2.umsatz_netto_plan_extern,0) as ums_netto_plan_extern
from dbp_data.wup_plan_tag_2 t2
join dbp_etl.dat_vj_vergleich_2 t1_2
  on t1.mandant_id = t2.mandant_id and 
     t1.wup_id = t2.wup_id and 
     t1.join_dat = t2.dat and 
     t1.akt_gj_fg = 1
;

insert into dbp_etl.vis_plan_tag_wup_tmp_2 (gj
	                                 ,kjmo
                                         ,kjwo
                                         ,mo_kj
                                         ,dat
                                         ,akt_gj
                                         ,akt_mo
                                         ,akt_wo
                                         ,akt_tag
                                         ,wtag_id
                                         ,mandant_id
                                         ,wup_id
                                         ,nb_id
                                         ,plan_tag_fg
                                         ,wrg_id
                                         ,ums_netto_plan
                                         ,ums_netto_plan_extern)
select dt2.gj
      ,dt2.kjmo
      ,dt2.kjwo
      ,dt2.mo_kj
      ,dt2.dat
      ,dt2.akt_gj
      ,dt2.akt_mo
      ,dt2.akt_wo
      ,dt2.akt_tag
      ,dt2.wtag_id
      ,coalesce(t2.mandant_id,dt2.mandant_id) as mandant_id
      ,coalesce(t2.wup_id,dt2.wup_id) as wup_id
      ,coalesce(t2.nb_id,dt2.nb_id) as nb_id
      ,coalesce(t2.plan_tag_fg,dt2.plan_tag_fg) as plan_tag_fg
      ,coalesce(t2.wrg_id,dt2.wrg_id) as wrg_id
      ,0 as ums_netto_plan
      ,0 as ums_netto_plan_extern
from (select t1.gj
            ,t1.kjmo
            ,t1.kjwo
            ,t1.mo_kj
            ,t1.dat
            ,t1.akt_gj
            ,t1.akt_mo
            ,t1.akt_wo
            ,t1.akt_tag
            ,t1.wtag_id
            ,mandant_id
            ,dt1.wup_id
            ,nb_id
            ,plan_tag_fg
            ,wrg_id
from dbp_data.tag_2 t1_2
join (select mandant_id
            ,wup_id
            ,nb_id
            ,plan_tag_fg
            ,wrg_id
            ,min(dat) as dat_min
            ,max(dat) as dat_max
      from dbp_etl.vis_plan_tag_wup_tmp_2
      group by 1,2,3,4,5) dt1
  on t1.dat between dat_min  and dat_max) dt2
left join dbp_etl.vis_plan_tag_wup_tmp_2 t2
on dt2.dat > t2.dat and 
   dt2.gj = t2.gj and
   dt2.wup_id = t2.wup_id and
   dt2.nb_id = t2.nb_id and 
   dt2.plan_tag_fg = t2.plan_tag_fg and
   dt2.mandant_id = t2.mandant_id and
   dt2.wrg_id = t2.wrg_id
where (dt2.mandant_id, dt2.wup_id, dt2.dat) not in (select mandant_id,wup_id,dat from dbp_etl.vis_plan_tag_wup_tmp_2) 
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
;

update dbp_etl.vis_plan_tag_wup_tmp_2

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

create or replace table dbp_etl.vis_plan_monat_abt_tmp_2 (
   mandant_id byteint not null,
   nb_id smallint not null,
   wup_id integer not null,
   abt_id smallint not null,
   arthiertyp_id byteint not null,
   gj smallint not null,
   kjmo integer not null,
   akt_gj smallint not null,
   akt_mo smallint not null,
   mo_kj byteint not null,
   wrg_id char(3) not null,
   ums_netto_plan decimal(18,2) not null
);

insert into dbp_etl.vis_plan_monat_abt_tmp_2 (mandant_id 
                                           ,nb_id 
                                           ,wup_id 
                                           ,abt_id 
                                           ,arthiertyp_id 
                                           ,gj 
                                           ,kjmo 
                                           ,akt_gj 
                                           ,akt_mo 
                                           ,mo_kj 
                                           ,wrg_id 
                                           ,ums_netto_plan)
select t1.mandant_id 
      ,t1.nb_id 
      ,t1.wup_id 
      ,t1.abt_id 
      ,'2'
      ,t3.gj 
      ,t3.kjmo 
      ,t3.akt_gj 
      ,t3.akt_mo 
      ,t3.mo_kj 
      ,t1.umsatz_netto_plan_wrg 
      ,sum(t1.umsatz_netto_plan) as ums_netto_plan
from dbp_data.wup_abt_per_2 t1_2
join dbp_etl.vis_mandant_2 vm
  on vm.mandant_id = t1.mandant_id
join dbp_data.monat_2 t3
  on t3.gjmo = t1.gjmo and 
     t3.akt_gj = 0 
where exists (select * from dbp_etl.dat_vj_vergleich_2 td1 where td1.gj = t3.gj and td1.kjmo = t3.kjmo and td1.mandant_id = t1.mandant_id and td1.wup_id = t1.wup_id and td1.nb_id = t1.nb_id)
group by 1,2,3,4,5,6,7,8,9,10,11
;

update dbp_etl.vis_plan_monat_abt_tmp_2

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

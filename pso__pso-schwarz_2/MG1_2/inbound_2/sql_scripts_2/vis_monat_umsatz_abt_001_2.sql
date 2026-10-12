create or replace table dbp_etl.vis_monat_ums_abt_tmp_2 like dbp_msi_data.vis_monat_umsatz_abt_2;

insert into dbp_etl.vis_monat_ums_abt_tmp_2 (mandant_id
                                          ,nb_id
                                          ,wup_id
                                          ,wrg_id
                                          ,abt_id
                                          ,arthiertyp_id
                                          ,gj
                                          ,akt_gj
                                          ,kjmo
                                          ,akt_mo
                                          ,mo_kj
                                          ,ums_netto
                                          ,ums_netto_kvj
                                          ,ums_netto_kvvj
                                          ,ums_netto_plan)
select dt1.mandant_id
      ,dt1.nb_id
      ,dt1.wup_id
      ,dt1.wrg_id
      ,dt1.abt_id
      ,dt1.arthiertyp_id
      ,dt1.gj
      ,dt1.akt_gj
      ,dt1.kjmo
      ,dt1.akt_mo
      ,dt1.mo_kj
      ,dt1.ums_netto
      ,dt1.ums_netto_kvj
      ,dt1.ums_netto_kvvj
      ,0 as ums_netto_plan
from (select a.mandant_id
            ,a.nb_id
            ,a.wup_id
            ,a.wrg_id
            ,a.abt_id
            ,a.arthiertyp_id
            ,a.gj
            ,a.akt_gj
            ,a.kjmo
            ,coalesce(m.gjmo,a.kjmo) as gjmo
            ,a.akt_mo
            ,a.mo_kj
            ,sum(a.ums_netto) as ums_netto
            ,sum(a.ums_netto_kvj) as ums_netto_kvj
            ,sum(a.ums_netto_kvvj) as ums_netto_kvvj
      from dbp_etl.vis_artbew_tmp_2 a
      left join dbp_data.monat_2 m
        on m.kjmo = a.kjmo
      group by 1,2,3,4,5,6,7,8,9,10,11,12) dt1
;

insert into dbp_etl.vis_monat_ums_abt_tmp_2 (mandant_id
                                          ,nb_id
                                          ,wup_id
                                          ,wrg_id
                                          ,abt_id
                                          ,arthiertyp_id
                                          ,gj
                                          ,akt_gj
                                          ,kjmo
                                          ,akt_mo
                                          ,mo_kj
                                          ,ums_netto
                                          ,ums_netto_kvj
                                          ,ums_netto_kvvj
                                          ,ums_netto_plan)
select dt1.mandant_id
      ,dt1.nb_id
      ,dt1.wup_id
      ,dt1.wrg_id
      ,dt1.abt_id
      ,dt1.arthiertyp_id
      ,dt1.gj
      ,dt1.akt_gj
      ,dt1.kjmo
      ,dt1.akt_mo
      ,dt1.mo_kj
      ,0
      ,0
      ,0
      ,dt1.ums_netto_plan
from (select mandant_id
            ,p.nb_id
            ,p.wup_id
            ,p.wrg_id
            ,p.abt_id
            ,p.arthiertyp_id
            ,p.gj
            ,p.akt_gj
            ,p.kjmo
            ,coalesce(m.gjmo,p.kjmo) as gjmo
            ,p.akt_mo
            ,p.mo_kj
            ,sum(p.ums_netto_plan) as ums_netto_plan
      from dbp_etl.vis_plan_monat_abt_tmp_2 p
      left join dbp_data.monat_2 m
        on m.kjmo = p.kjmo
      group by 1,2,3,4,5,6,7,8,9,10,11,12) dt1
;

insert into dbp_etl.vis_monat_ums_abt_tmp_2 (mandant_id
                                          ,nb_id
                                          ,wup_id
                                          ,wrg_id
                                          ,abt_id
                                          ,arthiertyp_id
                                          ,gj
                                          ,akt_gj
                                          ,kjmo
                                          ,akt_mo
                                          ,mo_kj
                                          ,ums_netto
                                          ,ums_netto_kvj
                                          ,ums_netto_kvvj
                                          ,ums_netto_plan)
select mandant_id
      ,t1.nb_id
      ,t1.wup_id
      ,t2.nach_wrg_id as wgr_id
      ,t1.abt_id
      ,t1.arthiertyp_id
      ,t1.gj
      ,t1.akt_gj
      ,t1.kjmo
      ,t1.akt_mo
      ,t1.mo_kj
      ,t1.ums_netto * t2.umrechnungskurs
      ,t1.ums_netto_kvj * t2.umrechnungskurs
      ,t1.ums_netto_kvvj * t2.umrechnungskurs
      ,ums_netto_plan * t2.umrechnungskurs
from dbp_etl.vis_monat_ums_abt_tmp_2 t1_2
join dbp_data.kurs_2 t2
  on t2.von_wrg_id = t1.wrg_id and 
     t2.dat_bis = '9999-12-31' and 
     t2.nach_wrg_id = 'EUR' and 
     t2.kurstyp_id = 3
where t1.wrg_id <> 'EUR'
;

delete from dbp_msi_data.vis_monat_umsatz_abt_2
where mandant_id in (${MANDANT_2}) and 
     (mandant_id,kjmo,wup_id,wrg_id,arthiertyp_id,abt_id) in (select mandant_id,kjmo,wup_id,wrg_id,arthiertyp_id,abt_id from dbp_etl.vis_monat_ums_abt_tmp_2)
;

delete from dbp_msi_data.vis_monat_umsatz_abt_2
where mandant_id in (${MANDANT_2}) and (mandant_id,wup_id) in (select mandant_id,wup_id from dbp_data.wup_2 where umzugsfiliale_fg = 1)
;

insert into dbp_msi_data.vis_monat_umsatz_abt_2 (mandant_id
                                              ,nb_id
                                              ,wup_id
                                              ,wrg_id
                                              ,abt_id
                                              ,arthiertyp_id
                                              ,gj
                                              ,akt_gj
                                              ,kjmo
                                              ,akt_mo
                                              ,mo_kj
                                              ,ums_netto
                                              ,ums_netto_kvj
                                              ,ums_netto_kvvj
                                              ,ums_netto_plan)
select mandant_id
      ,nb_id
      ,wup_id
      ,wrg_id
      ,abt_id
      ,arthiertyp_id
      ,gj
      ,akt_gj
      ,kjmo
      ,akt_mo
      ,mo_kj
      ,sum(ums_netto) as ums_netto
      ,sum(ums_netto_kvj) as ums_netto_kvj
      ,sum(ums_netto_kvvj) as ums_netto_kvvj
      ,sum(ums_netto_plan) as ums_netto_plan
from dbp_etl.vis_monat_ums_abt_tmp_2
group by 1,2,3,4,5,6,7,8,9,10,11
;

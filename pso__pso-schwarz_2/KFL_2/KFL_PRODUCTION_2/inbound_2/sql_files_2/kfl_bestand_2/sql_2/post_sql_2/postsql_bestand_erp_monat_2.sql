create or replace volatile table _dedup as (
select *
from ${TEMP_TABLE}
qualify row_number() over (partition by mandant_id,art_id,wup_id,lagerort_id order by mard_fg desc) = 1
);

create or replace volatile table _xxx as (
select a.mandant_id,
       a.wup_id,
       a.art_id,
       a.lagerort_id,
       a.gjmo_bis,
       c.gjmo+100 as gjmo,
       a.gjmo_bis as zeit_org
from _dedup a
join dbp_data.monat_2 b
  on a.gjmo_bis-100 = b.gjmo
join dbp_data.monat_2 c
  on b.akt_mo-1 = c.akt_mo
group by 1,2,3,4,5,6,7
union
select a.mandant_id,
       a.wup_id,
       a.art_id,
       a.lagerort_id,
       a.gjmo_bis,
       c.gjmo+100 as gjmo,
       a.gjmo as zeit_org
from _dedup a
join dbp_data.monat_2 b
  on a.gjmo-100 = b.gjmo
join dbp_data.monat_2 c
  on b.akt_mo-1 = c.akt_mo
group by 1,2,3,4,5,6,7
);

update dbp_data.bestand_erp_monat_2 from (select a.mandant_id,
                                               a.wup_id,
                                               a.art_id,
                                               a.gjmo_bis,
                                               a.lagerort_id,
                                               c.gjmo+100 as gjmo
                                        from _dedup a
                                        join dbp_data.monat_2 b
                                          on a.gjmo_bis-100 = b.gjmo
                                        join dbp_data.monat_2 c
                                          on b.akt_mo-1 = c.akt_mo
                                        where a.gjmo_bis <> 999912
                                        group by 1,2,3,4,5,6
                                        union
                                        select a.mandant_id,
                                               a.wup_id,
                                               a.art_id,
                                               a.gjmo_bis,
                                               a.lagerort_id,
                                               b.gjmo
                                        from _dedup a
                                        join (select mandant_id,
                                                     gjmo
                                              from _xxx
                                              group by 1,2) b
                                          on a.mandant_id = b.mandant_id
                                        where a.gjmo_bis = 999912
                                        group by 1,2,3,4,5,6) b
                                     
set gjmo_bis = b.gjmo
    
where dbp_data.bestand_erp_monat.mandant_id = b.mandant_id and
      dbp_data.bestand_erp_monat.wup_id = b.wup_id and
      dbp_data.bestand_erp_monat.art_id = b.art_id and
      dbp_data.bestand_erp_monat.lagerort_id = b.lagerort_id and
     (dbp_data.bestand_erp_monat.gjmo_bis = b.gjmo_bis or
      dbp_data.bestand_erp_monat.gjmo_bis = 999912)
;
    
update _dedup set gjmo = gjmo_bis
where gjmo = 190001
;
    
delete from dbp_data.bestand_erp_monat_2
where (mandant_id,wup_id,art_id,gjmo) in (select mandant_id,wup_id,art_id,gjmo from _dedup)
;
    
insert into dbp_data.bestand_erp_monat_2 (art_id
                                       ,mandant_id
                                       ,wup_id
                                       ,nb_id
                                       ,gjmo
                                       ,lagerort_id
                                       ,menge_lgbest_erp_frei_bme
                                       ,menge_lgbest_erp_umlag_bme
                                       ,menge_lgbest_erp_qual_bme
                                       ,menge_lgbest_erp_nf_charge_bme
                                       ,menge_lgbest_erp_gesp_bme
                                       ,menge_lgbest_erp_ret_gesp_bme
                                       ,gjmo_bis
                                       ,mard_fg
                                       ,datzeit_daten_abzug
                                       ,vk_brutto
                                       ,td_update
                                       ,td_insert)
select art_id
      ,mandant_id
      ,wup_id
      ,nb_id
      ,gjmo
      ,lagerort_id
      ,menge_lgbest_erp_frei_bme
      ,menge_lgbest_erp_umlag_bme
      ,menge_lgbest_erp_qual_bme
      ,menge_lgbest_erp_nf_charge_bme
      ,menge_lgbest_erp_gesp_bme
      ,menge_lgbest_erp_ret_gesp_bme
      ,gjmo_bis
      ,mard_fg
      ,datzeit_daten_abzug
      ,vk_brutto
      ,current_timestamp as td_update
      ,current_timestamp as td_insert
from _dedup
;

update dbp_data.bestand_erp_monat_2 from (select a.mandant_id,
                                               a.wup_id,
                                               a.art_id,
                                               a.lagerort_id,
                                               a.gjmo_bis,
                                               count(*) as anz,
                                               max(a.gjmo) as max_gjmo,
                                               min(a.gjmo) as min_gjmo,
                                               min(a.gjmo_bis) as min_gjmo_bis,
                                               max(c.gjmo) as upd_gjmo_bis
                                        from dbp_data.bestand_erp_monat_2 a
                                        join dbp_data.monat_2 b
                                          on a.gjmo_bis = b.gjmo
                                        join dbp_data.monat_2 c
                                          on b.akt_mo+1 = c.akt_mo
                                        group by 1,2,3,4,5
                                        having count(*) > 1) b
                                        
set gjmo_bis = gjmo

where dbp_data.bestand_erp_monat.mandant_id = b.mandant_id and 
      dbp_data.bestand_erp_monat.art_id = b.art_id and 
      dbp_data.bestand_erp_monat.wup_id = b.wup_id and 
      dbp_data.bestand_erp_monat.lagerort_id = b.lagerort_id and 
      dbp_data.bestand_erp_monat.gjmo >= b.min_gjmo
;

update dbp_data.bestand_erp_monat_2 from (select mandant_id
                                              ,art_id
                                              ,wup_id
                                              ,lagerort_id
                                              ,gjmo_bis
                                              ,to_date(to_char(gjmo_bis),'yyyymm') as gjmo_bis_dat
                                              ,lag(gjmo_bis_dat,1) over (partition by mandant_id,art_id,wup_id,lagerort_id order by gjmo_bis_dat asc nulls last) as lag_test
                                              ,case 
                                                 when lag_test is null
                                                 then to_date(to_char(gjmo),'yyyymm')
                                                 else add_months(lag_test, 1)
                                               end as dat_ab
                                              ,to_number(to_char(dat_ab,'yyyymm')) as gjmo_ab_
                                        from dbp_data.bestand_erp_monat_2
                                        qualify gjmo_ab_ <> gjmo) d 

set gjmo = gjmo_ab_

where dbp_data.bestand_erp_monat.mandant_id = d.mandant_id and 
      dbp_data.bestand_erp_monat.art_id = d.art_id and 
      dbp_data.bestand_erp_monat.wup_id = d.wup_id and 
      dbp_data.bestand_erp_monat.lagerort_id = d.lagerort_id and 
      dbp_data.bestand_erp_monat.gjmo_bis = d.gjmo_bis and 
      dbp_data.bestand_erp_monat.gjmo <> d.gjmo_ab_
;

-- 28.12.2022, -dbay-
-- Performance!

create or replace volatile table _awzp as (
select *
from dbp_data.art_wup_zu_per_2
where dat_bis >= (select min(to_date(to_char(gjmo_bis),'yyyymm')) from _dedup) and
      mandant_id in (select mandant_id from _dedup group by 1)
);

update dbp_data.bestand_erp_monat_2 from (select t2.mandant_id as mandant_id_,
                                               t2.art_id as art_id_,
                                               t2.wup_id as wup_id_,
                                               t1.vk_brutto as vk_brutto_,
                                               t2.gjmo_bis as gjmo_bis_ ,
                                               t2.lagerort_id lagerort_id_,
                                               t1.wrg_id as wrg_id_
                                      	from _awzp t1_2
                                        join _dedup t2
                                          on t1.mandant_id = t2.mandant_id and 
	                                     t1.art_id = t2.art_id and 
	                                     t1.wup_id = t2.wup_id and 
	                                     to_date(to_char(t2.gjmo_bis),'yyyymm') between t1.dat_von and t1.dat_bis) b

set vk_brutto = b.vk_brutto_,
    wrg_id = b.wrg_id_

where mandant_id = b.mandant_id_ and
      art_id = b.art_id_ and
      wup_id = b.wup_id_ and
      gjmo_bis = b.gjmo_bis_ and
      lagerort_id = b.lagerort_id_
;

update dbp_data.bestand_erp_monat_2 from (select mandant_id,
                                               default_wrg
                                        from dbp_data.mandant_2) b
                                        
set wrg_id = b.default_wrg

where dbp_data.bestand_erp_monat.mandant_id = b.mandant_id and
      dbp_data.bestand_erp_monat.wrg_id is null 
;

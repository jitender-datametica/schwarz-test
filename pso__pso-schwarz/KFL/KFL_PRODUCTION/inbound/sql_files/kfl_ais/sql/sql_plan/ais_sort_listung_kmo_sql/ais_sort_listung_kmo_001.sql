create or replace volatile table _art_list_wup_zu_per as (
select a.*,
       b.wg_id
from dbp_data.art_list_wup_zu_per a
join dbp_data.art_wg_zu_per b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
	 b.arthiertyp_id = 2 and
	 b.dat_bis = '9999-12-31'
join dbp_data.wup c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id
where a.mandant_id = ${mandant_id} and
      b.wg_id in (select wg_id from dbp_data.wg_filter_zu where wg_filter_id = 47) and
      current_date between a.dat_von and a.dat_bis and
      trim(a.list_quelle_id) in ('1','3','7','c') and
      floor(a.art_id/10) = a.struktur_art_id and
      a.nb_id = 0 and
      c.nb_id = 0 and
      c.dat_eroeffnung <= current_date 
);

create or replace volatile table _sst as (
select a.mandant_id,
       a.art_id,
       a.wup_id
from _art_list_wup_zu_per a
join dbp_etl_process.sm_wup_wg_zu_per c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.wg_id = c.wg_id and
     c.dat_bis = '9999-12-31' and
     c.sm_id between 1 and 9
join dbp_data.wup b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id
where c.sm_id is not null and
      trim(a.list_quelle_id) in ('1','7') and
      b.nb_id = 0 and
      b.dat_eroeffnung < current_date 
group by 1,2,3
union
select a.mandant_id,
       a.art_id,
       a.wup_id
from _art_list_wup_zu_per a
join dbp_etl_process.sm_wup_wg_zu_per c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.wg_id = c.wg_id and
     c.dat_bis = '9999-12-31' and
     c.sm_id between 1 and 9
join dbp_data.wup b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id
where c.sm_id is not null and
      trim(a.list_quelle_id) in ('3') and
     (a.mandant_id,a.baustein_id) not in (select mandant_id,baustein_id
                                          from dbp_etl.baustein_wsop
                                          where current_date between dat_von and dat_bis and
					                                      mandant_id = ${mandant_id}) and
      b.nb_id = 0 and
      b.dat_eroeffnung < current_date
group by 1,2,3
);

create or replace volatile table _ksst as (
select a.mandant_id,
       a.art_id,
       a.wup_id
from _art_list_wup_zu_per a
join dbp_etl_process.sm_wup_wg_zu_per c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.wg_id = c.wg_id and
     c.dat_bis = '9999-12-31' and
     cast(substr(c.ksm_id,2,1) as int) between 1 and 9
join dbp_data.wup b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id
where c.ksm_id is not null and
      trim(a.list_quelle_id) in ('1','7') and
      b.nb_id = 0 and
      b.dat_eroeffnung < current_date 
group by 1,2,3
union
select a.mandant_id,
       a.art_id,
       a.wup_id
from _art_list_wup_zu_per a
join dbp_etl_process.sm_wup_wg_zu_per c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.wg_id = c.wg_id and
     c.dat_bis = '9999-12-31' and
     cast(substr(trim(c.ksm_id),2,1) as int) between 1 and 9
join dbp_data.wup b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id
where c.ksm_id is not null and 
      trim(a.list_quelle_id) in ('3') and
     (a.mandant_id,a.baustein_id) not in (select mandant_id,baustein_id
	                                        from dbp_etl.baustein_wsop
                                          where current_date between dat_von and dat_bis and
                                                mandant_id = ${mandant_id}) and
      b.nb_id = 0 and
      b.dat_eroeffnung < current_date
group by 1,2,3
);

create or replace volatile table _sonstige_bst as (
select a.mandant_id,
       a.art_id,
       a.wup_id
from _art_list_wup_zu_per a
join dbp_data.wup b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id
where trim(a.list_quelle_id) in ('3') and
     (a.mandant_id,a.baustein_id) in (select mandant_id,baustein_id
                                      from dbp_etl.baustein_wsop
                                      where current_date between dat_von and dat_bis and
                                            mandant_id = ${mandant_id}) and
      b.nb_id = 0 and
      b.dat_eroeffnung < current_date
group by 1,2,3
);

create or replace volatile table _einzel_markt as (
select a.mandant_id,
       a.art_id,
       a.wup_id,
       a.wg_id
from _art_list_wup_zu_per a
join dbp_data.wup b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id
where trim(a.list_quelle_id) in ('c') and
      b.nb_id = 0 and
      b.dat_eroeffnung < current_date
group by 1,2,3,4
union
select a.mandant_id,
       a.art_id,
       a.wup_id,
       a.wg_id
from _art_list_wup_zu_per a
join dbp_etl_process.art_sm_vw_zu_per c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     current_date between c.dat_von and c.dat_bis and
     c.sm_id = -2
join dbp_data.wup b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id
where trim(a.list_quelle_id) in ('1') and
      b.nb_id = 0 and
      b.dat_eroeffnung < current_date
group by 1,2,3,4
);

create or replace volatile table _gesamtsicht as (
select a.mandant_id,
       a.art_id,
       a.wup_id
from dbp_data.art_list_wup_zu_per a
join dbp_data.art_wg_zu_per b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
	 b.arthiertyp_id = 2 and
	 b.dat_bis = '9999-12-31'
join dbp_data.wup c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id
where a.mandant_id = ${mandant_id} and
      b.wg_id in (select wg_id from dbp_data.wg_filter_zu where wg_filter_id = 47) and
      current_date between a.dat_von and a.dat_bis and
      trim(a.list_quelle_id) not in ('2') and
      floor(a.art_id/10) = a.struktur_art_id and
      a.nb_id = 0 and
      c.nb_id = 0 and
      c.dat_eroeffnung <= current_date 
group by 1,2,3
);

create or replace volatile table _gesamt_sicht as (
select x.mandant_id,
       x.art_id,
       count(distinct x.wup_id) as anz_markt
from _gesamtsicht x
group by 1,2
);

create or replace volatile table _sst_org as (
select x.mandant_id,
       x.art_id,
       count(distinct x.wup_id) as anz_markt
from _sst x
group by 1,2
);

create or replace volatile table _ksst_org as (
select x.mandant_id,
       x.art_id,
       count(distinct x.wup_id) as anz_markt
from _ksst x
group by 1,2
);

create or replace  volatile table _bst as (
select x.mandant_id,
       x.art_id,
       count(distinct x.wup_id) as anz_markt
from _sonstige_bst x
group by 1,2
);

create or replace  volatile table _mkt as (
select x.mandant_id,
       x.art_id,
       count(distinct x.wup_id) as anz_markt
from _einzel_markt x
group by 1,2
);

update dbp_data.sortiment_leistung set anz_maerkte_sst = b.anz_markt

from (select *
      from _sst_org) b
												
where dbp_data.sortiment_leistung.art_id = b.art_id and
      dbp_data.sortiment_leistung.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id}) and
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id
;

update dbp_data.sortiment_leistung set anz_maerkte_k_sst = b.anz_markt

from (select *
      from _ksst_org) b
												
where dbp_data.sortiment_leistung.art_id = b.art_id and
      dbp_data.sortiment_leistung.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id}) and
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id
;

update dbp_data.sortiment_leistung set anz_maerkte_baustein_sonstige = b.anz_markt

from (select *
      from _bst) b
												
where dbp_data.sortiment_leistung.art_id = b.art_id and
      dbp_data.sortiment_leistung.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id}) and
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id
;

update dbp_data.sortiment_leistung set anz_maerkte_listung_einzel = b.anz_markt

from (select *
      from _mkt) b
												
where dbp_data.sortiment_leistung.art_id = b.art_id and
      dbp_data.sortiment_leistung.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id}) and
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id
;

update dbp_data.sortiment_leistung set anz_maerkte_listung_gesamt = b.anz_markt

from (select *
      from _gesamt_sicht) b
												
where dbp_data.sortiment_leistung.art_id = b.art_id and
      dbp_data.sortiment_leistung.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id}) and
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id
;

update dbp_data.sortiment_leistung set listung_sst_mvke = cast(floor(b.sm_id) as varchar(2))

from (select x.mandant_id,
             x.art_id,
             min(x.sm_id) as sm_id
      from (select mandant_id,
                   art_id,
                   case when sm_id = 6 then 5 else sm_id end as sm_id
            from dbp_etl_process.art_sm_vw_zu_per
            where mandant_id = ${mandant_id} and
                  current_date between dat_von and dat_bis) x
      group by 1,2) b
                                                    
where dbp_data.sortiment_leistung.mandant_id = b.mandant_id and
      dbp_data.sortiment_leistung.art_id = b.art_id and
      dbp_data.sortiment_leistung.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})
;

update dbp_data.sortiment_leistung set listung_k_sst_mvke = trim(b.ksm_id)

from (select mandant_id,
             art_id,
             min(ksm_id) as ksm_id
      from dbp_etl_process.art_sm_vw_zu_per
      where mandant_id = ${mandant_id} and
            current_date between dat_von and dat_bis and
            trim(ksm_id) in ('R','K1','K2','K3','K4','K5','K6','K7','K8','K9')
      group by 1,2) b
                                                    
where dbp_data.sortiment_leistung.mandant_id = b.mandant_id and
      dbp_data.sortiment_leistung.art_id = b.art_id and
      dbp_data.sortiment_leistung.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})
;

update dbp_data.sortiment_leistung set listung_k_sst_mvke = NULL
where trim(listung_k_sst_mvke) not in ('R','K1','K2','K3','K4','K5','K6','K7','K8','K9') and
      kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})  and
      mandant_id = ${mandant_id}
;

update dbp_data.sortiment_leistung set listung_sst_mvke = NULL
where trim(listung_sst_mvke) not in ('-2','1','2','3','4','5') and
      kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})  and
      mandant_id = ${mandant_id}
;

update dbp_data.sortiment_leistung set listung_sst_mvke = 'R'
where trim(listung_sst_mvke) in ('-2') and
      kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})  and
      mandant_id = ${mandant_id}
;

update dbp_data.sortiment_leistung set anz_maerkte_sst = 0
where anz_maerkte_sst is null and
      kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})  and
      mandant_id = ${mandant_id}
;

update dbp_data.sortiment_leistung set anz_maerkte_k_sst = 0
where anz_maerkte_k_sst is null and
      kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})  and
      mandant_id = ${mandant_id}
;

update dbp_data.sortiment_leistung set anz_maerkte_baustein_sonstige = 0
where anz_maerkte_baustein_sonstige is null and
      kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})  and
      mandant_id = ${mandant_id}
;

update dbp_data.sortiment_leistung set anz_maerkte_listung_einzel = 0
where anz_maerkte_listung_einzel is null and
      kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})  and
      mandant_id = ${mandant_id}
;

update dbp_data.sortiment_leistung set anz_maerkte_listung_gesamt = 0
where anz_maerkte_listung_gesamt is null and
      kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id}) and
      mandant_id = ${mandant_id}
;

create or replace  volatile table _murks1 as (
select a.mandant_id,
       b.art_id,
       a.wup_id,
       a.wg_id,
       case when a.sm_id = 6 then 5 else a.sm_id end as sm_id,
       a.ksm_id
from dbp_data.sm_wup_wg_zu_per a
join (select x1.mandant_id,
             x1.art_id,
             x2.wg_id
      from dbp_data.sortiment_leistung x1
      join dbp_data.art_wg_zu_per x2
        on x1.mandant_id = x2.mandant_id and
           x1.art_id = x2.art_id and
           x2.arthiertyp_id = 2 and
           x2.dat_bis = '9999-12-31'
      where x1.art_id is not null and
            x1.mandant_id = ${mandant_id} and
            x1.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})
      group by 1,2,3) b
  on a.mandant_id = b.mandant_id and
     a.wg_id = b.wg_id
join dbp_data.wup c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.nb_id = c.nb_id
where a.mandant_id = ${mandant_id} and
      a.arthiertyp_id = 2 and
      current_date between a.dat_von and a.dat_bis and
      current_date between c.dat_von and c.dat_bis and
     (a.sm_id between 1 and 6 or trim(a.ksm_id) in ('K1','K2','K3','K4','K5','K6','K7','K8','K9')) and
      a.nb_id = 0
group by 1,2,3,4,5,6
);

create or replace  volatile table _track_ist as (
select x1.mandant_id,
       x1.art_id,
       x1.listung_sst_mvke,
       x1.listung_k_sst_mvke
from dbp_data.sortiment_leistung x1
where x1.art_id is not null and
      x1.mandant_id = ${mandant_id} and
      x1.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})
group by 1,2,3,4
);

create or replace  volatile table _test_sst as (
select a.*
from _murks1 a
join _track_ist b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.sm_id >= cast(b.listung_sst_mvke as int)
where b.listung_sst_mvke is not null and
      b.listung_sst_mvke not in ('N/A','R')
);

create or replace  volatile table _test_ksst as (
select a.*
from _murks1 a
join _track_ist b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     cast(substr(trim(a.ksm_id),2,1) as int) >= cast(substr(trim(b.listung_k_sst_mvke),2,1) as int)
where b.listung_k_sst_mvke is not null and
      b.listung_k_sst_mvke not in ('N/A','R')
);

create or replace  volatile table _upd_sst as (
select mandant_id,
       art_id,
       count(distinct wup_id) as anz_markt
from _test_sst
group by 1,2
);

create or replace  volatile table _upd_ksst as (
select mandant_id,
       art_id,
       count(distinct wup_id) as anz_markt
from _test_ksst
group by 1,2
);

update dbp_data.sortiment_leistung set max_anz_maerkte_sst = b.anz_markt

from (select *
      from _upd_sst) b
                                              
where dbp_data.sortiment_leistung.mandant_id = b.mandant_id and
      dbp_data.sortiment_leistung.art_id = b.art_id and
      dbp_data.sortiment_leistung.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})
;

update dbp_data.sortiment_leistung set max_anz_maerkte_k_sst = b.anz_markt

from (select *
      from _upd_ksst) b
                                              
where dbp_data.sortiment_leistung.mandant_id = b.mandant_id and
      dbp_data.sortiment_leistung.art_id = b.art_id and
      dbp_data.sortiment_leistung.kjwo_update in (select max(kjwo_update) from dbp_data.sortiment_leistung where mandant_id = ${mandant_id})
;

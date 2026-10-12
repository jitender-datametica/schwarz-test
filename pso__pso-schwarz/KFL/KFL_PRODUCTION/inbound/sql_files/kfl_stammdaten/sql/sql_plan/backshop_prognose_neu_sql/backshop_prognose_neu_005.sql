delete from dbp_etl.vis_ods_tmp_calculation2
where dat in (select dat
              from _vis_ods_tmp_calculation2)
;

insert into dbp_etl.vis_ods_tmp_calculation2
select *
from _vis_ods_tmp_calculation2
;

update dbp_etl.vis_agg_tmp from (select *
                                 from dbp_etl.vis_fur_tmp) a

set menge_prognose = a.menge_fur_mean,
    menge_prognose_max = a.menge_fur_max,
    menge_prognose_aktion = a.menge_fur_aktion

where dbp_etl.vis_agg_tmp.mandant_id = a.mandant_id and 
      dbp_etl.vis_agg_tmp.art_id     = a.art_id     and 
      dbp_etl.vis_agg_tmp.wup_id     = a.wup_id     and 
      dbp_etl.vis_agg_tmp.dat        = a.dat
;

update dbp_etl.vis_agg_tmp from (select mandant_id,
                                        case
                                          when mandant_id > 1
                                          then floor(art_id/10) 
                                          else floor(art_id/100)
                                        end as kl_art_id,
                                        wup_id,
                                        wtag_id,
                                        coalesce(max(wug_cluster_id),-1) as wug_cluster_id_,
                                        coalesce(max(wup_cluster_id),-1) as wup_cluster_id_,
                                        coalesce(max(back_drehklasse_id),'-1') as back_drehklasse_id_,
                                        sum(menge_16) as menge_16,
                                        sum(menge_01) as menge_01,
                                        sum(menge_02) as menge_02,
                                        sum(menge_03) as menge_03,
                                        sum(menge_04) as menge_04,
                                        sum(anz_16) as anz_16,
                                        sum(anz_ods) as anz_ods,
                                        coalesce(sum(tagesmenge_fur),0) as tagesmenge,
                                        case 
                                          when back_drehklasse_id_ = 'LD' 
                                          then coalesce(sum(fs_in_stueck+fsc_in_stueck),0)
                                          else coalesce(sum(fs_in_stueck+fsc_in_blech),0)
                                        end as gff_menge_stueck,
                                        coalesce(sum(fs_in_stueck),0) as fs1_menge_stueck,
                                        case 
                                          when back_drehklasse_id_ = 'LD' 
                                          then coalesce(sum(fsc_in_stueck),0)
                                          else coalesce(sum(fsc_in_blech),0)
                                        end fs2_menge_stueck,
                                        coalesce(sum(erwarteter_abv_nachmittag),0) as erw_absatz_spaet,
                                        coalesce(sum(erwarteter_abv_abend),0) as erw_absatz_abend,
                                        coalesce(sum(menge_abschrift_schnitt),0) as avg_menge_abschrift,
                                        coalesce(sum(menge_schnitt),0) as menge_schnitt
                                 from _vis_ods_tmp_calculation2
                                 group by 1,2,3,4
                                 having erw_absatz_spaet < 10000) a

set menge_check         = zeroifnull(a.menge_16  / nullifzero(a.anz_16))
   ,anteil_01           = zeroifnull(a.menge_01  / nullifzero(a.anz_ods))
   ,anteil_02           = zeroifnull(a.menge_02  / nullifzero(a.anz_ods))
   ,anteil_03           = zeroifnull(a.menge_03  / nullifzero(a.anz_ods))
   ,anteil_04           = zeroifnull(a.menge_04  / nullifzero(a.anz_ods))
   ,tagesmenge          = a.tagesmenge
   ,gff_menge_stueck    = a.gff_menge_stueck
   ,fs1_menge_stueck    = a.fs1_menge_stueck
   ,fs2_menge_stueck    = a.fs2_menge_stueck
   ,erw_absatz_spaet    = a.erw_absatz_spaet
   ,erw_absatz_abend    = a.erw_absatz_abend
   ,avg_menge_abschrift = a.avg_menge_abschrift
   ,wug_cluster_id      = a.wug_cluster_id_
   ,back_drehklasse_id  = a.back_drehklasse_id_
   ,wup_cluster_id      = a.wup_cluster_id_
   ,menge_schnitt       = a.menge_schnitt

where dbp_etl.vis_agg_tmp.mandant_id = a.mandant_id and 
      dbp_etl.vis_agg_tmp.wup_id     = a.wup_id     and
      case
        when dbp_etl.vis_agg_tmp.mandant_id > 1
        then floor(dbp_etl.vis_agg_tmp.art_id/10)
        else floor(dbp_etl.vis_agg_tmp.art_id/100)
      end = a.kl_art_id     and
      mod(datediff(day,'1900-01-01',dbp_etl.vis_agg_tmp.dat), 7) + 1= a.wtag_id
;

update dbp_etl.vis_agg_tmp from (select a.*,
                                        case
                                          when a.menge_fur_aktion <> 0
                                          then a.menge_fur_aktion
                                          when a.menge_fur_max <> 0
                                          then a.menge_fur_max
                                          else a.menge_fur_mean
                                        end as prognose_menge
                                 from dbp_etl.vis_fur_tmp a
                                 where prognose_menge <> 0) b
                                  
set tagesmenge = b.prognose_menge

where dbp_etl.vis_agg_tmp.mandant_id = b.mandant_id and
      dbp_etl.vis_agg_tmp.art_id = b.art_id and
      dbp_etl.vis_agg_tmp.wup_id = b.wup_id and
      dbp_etl.vis_agg_tmp.dat = b.dat
;

update dbp_etl.vis_agg_tmp set gff_menge_stueck = tagesmenge * 0.65,
                               fs1_menge_stueck = tagesmenge * 0.65,
                               erw_absatz_spaet = tagesmenge * 0.20,
                               erw_absatz_abend = tagesmenge * 0.15
where menge_schnitt = 0 and
      back_drehklasse_id <> ''
;

update dbp_etl.vis_agg_tmp set gff_menge_stueck = tagesmenge * 0.65,
                               fs1_menge_stueck = tagesmenge * 0.65,
                               erw_absatz_spaet = tagesmenge * 0.20,
                               erw_absatz_abend = tagesmenge * 0.15,
                               back_drehklasse_id = 'LD'
where menge_schnitt = 0 and
      back_drehklasse_id = ''
;

update dbp_etl.vis_agg_tmp set gff_menge_stueck = fs1_menge_stueck
where gff_menge_stueck = 0 and
      fs1_menge_stueck <> 0
;

update dbp_etl.vis_agg_tmp set gff_menge_stueck = fs1_menge_stueck
where fs1_menge_stueck > gff_menge_stueck
;

create or replace volatile table _dup_check as (
select a.*
from dbp_etl.vis_agg_tmp a
join (select mandant_id,
             art_id,
             wup_id,
             dat
      from dbp_etl.vis_agg_tmp
      group by 1,2,3,4
      having count(*) > 1) b
  on a.art_id = b.art_id and
     a.wup_id = b.wup_id and
     a.dat = b.dat and
     a.mandant_id = b.mandant_id
qualify row_number () over (partition by a.mandant_id,a.art_id,a.wup_id,a.dat
                            order by a.mandant_id,a.art_id,a.wup_id,a.dat) = 1
);

delete from dbp_etl.vis_agg_tmp
where (mandant_id,art_id,wup_id,dat) in (select mandant_id,art_id,wup_id,dat from _dup_check)
;

insert into dbp_etl.vis_agg_tmp
select *
from _dup_check
;

create or replace volatile table _kill_nd as (
select a.*
from dbp_data.art_wup_status_per a
join dbp_data.art_wg_zu_per b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     b.arthiertyp_id = 2 and
     b.dat_bis = '9999-12-31'
where a.mandant_id = 1 and 
      current_date between a.dat_von and a.dat_bis and
      b.wg_id in (select wg_id 
                  from dbp_data.wg_filter_zu
                  where wg_filter_id = 3 and
                        arthiertyp_id = 2) and
      a.dispomerkmal = 'ND'
);

delete from dbp_etl.vis_agg_tmp
where (mandant_id,art_id,wup_id) in (select mandant_id,art_id,wup_id from _kill_nd)
;

delete from dbp_etl.vis_agg_tmp
where mod(datediff(day,'1900-01-01',dat), 7) + 1 = 7 and
      menge_prognose = 0 and
      menge_prognose_max = 0 and
      menge_prognose_aktion = 0 and
      mandant_id = 1
;

create or replace volatile table _posten as (
select a.mandant_id,
       a.wup_id,
       a.art_id,
       b.dat,
       min(c.dat_von) as dat_von,
       max(c.dat_bis+7)  as dat_bis
from dbp_data.aktion_art_wup_zu a
join dbp_etl.vis_agg_tmp b
  on a.art_id = b.art_id and
     a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.nb_id = b.nb_id 
join dbp_data.aktion c
  on a.mandant_id = c.mandant_id and
     a.aktion_id = c.aktion_id and
     b.dat between c.dat_von and c.dat_bis+7
join dbp_data.art d
  on a.mandant_id = d.mandant_id and
     a.art_id = d.art_id and
     d.dat_bis = '9999-12-31' and
     d.posten_id in ('PN','SP','PS','1')
where (a.mandant_id, a.art_id) in (select awzp.mandant_id,
                                          awzp.art_id 
                                   from dbp_data.art_wg_zu_per awzp
                                   join dbp_data.wg_filter_zu wfz
                                     on awzp.wg_id = wfz.wg_id and 
                                        awzp.mandant_id = wfz.mandant_id and 
                                        wfz.wg_filter_id = 3 and 
                                        wfz.arthiertyp_id = 2
                                   where awzp.dat_bis = '9999-12-31' and 
                                         awzp.arthiertyp_id = 2) and
       a.grund_sperrung is null and
       case
         when c.mandant_id = 1
         then c.preisaktiviert_fg
         when c.mandant_id > 1 and
              a.dat_preisaktiviert <> '1900-01-01' and
             (c.mandant_id,c.aktion_id) not in (select mandant_id,aktion_id
                                                from dbp_data.l_bonuskauf)
         then 1
         else 0
       end = 1
group by 1,2,3,4
);

create or replace volatile table _listung as (
select a.mandant_id,
       awsp.wup_id,
       a.art_id,
       a.posten_id,
       awzp.dat_von,
       awzp.dat_bis,
       awzp.listung_id
from dbp_data.art a
join dbp_data.art_wup_status_per awsp
  on a.art_id = awsp.art_id and 
     a.mandant_id = awsp.mandant_id and 
     awsp.dat_bis = '9999-12-31' and 
     awsp.nb_id = 0
join dbp_data.art_wup_zu_per awzp
  on awsp.art_id = awzp.art_id and 
     awsp.mandant_id = awzp.mandant_id and 
     awsp.wup_id = awzp.wup_id and 
     awzp.dat_bis = '9999-12-31' and 
     awzp.nb_id = 0
where (a.mandant_id, a.art_id) in (select awzp.mandant_id,
                                          awzp.art_id 
                                   from dbp_data.art_wg_zu_per awzp
                                   join dbp_data.wg_filter_zu wfz
                                     on awzp.wg_id = wfz.wg_id and 
                                        awzp.mandant_id = wfz.mandant_id and 
                                        wfz.wg_filter_id = 3 and 
                                        wfz.arthiertyp_id = 2
                                   where awzp.dat_bis = '9999-12-31' and 
                                         awzp.arthiertyp_id = 2) and
      awzp.listung_id = 1
group by 1,2,3,4,5,6,7
);

update dbp_etl.vis_agg_tmp from (select *
                                 from _listung) b

set listung_id = 1

where dbp_etl.vis_agg_tmp.mandant_id = b.mandant_id and
      dbp_etl.vis_agg_tmp.wup_id = b.wup_id and
      dbp_etl.vis_agg_tmp.art_id = b.art_id and
      dbp_etl.vis_agg_tmp.listung_id = 4
;

update dbp_etl.vis_agg_tmp from (select *
                                 from _posten) b

set listung_id = 4

where dbp_etl.vis_agg_tmp.mandant_id = b.mandant_id and
      dbp_etl.vis_agg_tmp.wup_id = b.wup_id and
      dbp_etl.vis_agg_tmp.art_id = b.art_id and
      dbp_etl.vis_agg_tmp.dat = b.dat and
      dbp_etl.vis_agg_tmp.listung_id = 1
;

update dbp_etl.vis_agg_tmp from (select mandant_id,
                                        art_id,
                                        max(wup_cluster_id) as max_wup_cluster_id,
                                        max(wug_cluster_id) as max_wug_cluster_id
                                 from dbp_etl.vis_agg_tmp
                                 group by 1,2) b
                                 
set wup_cluster_id = b.max_wup_cluster_id,
    wug_cluster_id = b.max_wug_cluster_id

where dbp_etl.vis_agg_tmp.mandant_id = b.mandant_id and
      dbp_etl.vis_agg_tmp.art_id = b.art_id and
     (dbp_etl.vis_agg_tmp.wup_cluster_id <> b.max_wup_cluster_id or
      dbp_etl.vis_agg_tmp.wug_cluster_id <> b.max_wug_cluster_id)
;

update dbp_etl.vis_agg_tmp from (select mandant_id,
                                        aktuell_wup_id,
                                        orig_wup_id
                                 from dbp_data.wup
                                 where wup_aenderung_grund_id = 3 and
                                       aktuell_wup_id <> orig_wup_id and
                                       mandant_id = 1) b

set wup_id = b.aktuell_wup_id

where dbp_etl.vis_agg_tmp.mandant_id = b.mandant_id and
      dbp_etl.vis_agg_tmp.wup_id = b.orig_wup_id
;

delete from dbp_etl.vis_agg_tmp 
where mandant_id = 7 and 
      art_id in (207787430,207787440,207787450,207787460,207785630,207787470,207787480,207787490,207787500,207787510,
                 208458010,001495830,208931090,209026960,202153500,205535570,208453460,000718190,207258760,208693700,
                 208861940,209003140,202153500,208997150,208982160,208294480,208425100,208931090,207847310,208693700,
                 1495830,208453460)
;

delete from dbp_msi_data.backshop_prognose_neu
where (dat) in (select dat from dbp_etl.vis_agg_tmp)
;

insert into dbp_msi_data.backshop_prognose_neu (art_id
                                               ,mandant_id
                                               ,wup_id
                                               ,nb_id
                                               ,dat
                                               ,menge_prognose
                                               ,menge_prognose_max
                                               ,menge_prognose_aktion
                                               ,listung_id_backshop
                                               ,menge_check
                                               ,anteil_01
                                               ,anteil_02
                                               ,anteil_03
                                               ,anteil_04
                                               ,menge
                                               ,wup_cluster_id
                                               ,wug_cluster_id
                                               ,back_drehklasse_id
                                               ,aktion_id
                                               ,menge_abschrift
                                               ,menge_tag
                                               ,menge_gff
                                               ,menge_gs
                                               ,menge_spaet
                                               ,menge_abend)
select art_id
      ,mandant_id
      ,wup_id
      ,nb_id
      ,dat
      ,menge_prognose
      ,menge_prognose_max
      ,menge_prognose_aktion
      ,listung_id
      ,menge_check
      ,anteil_01
      ,anteil_02
      ,anteil_03
      ,anteil_04
      ,menge_schnitt
      ,wup_cluster_id
      ,wug_cluster_id
      ,back_drehklasse_id
      ,aktion_id
      ,case when avg_menge_abschrift >= 1000 then 0 else avg_menge_abschrift end
      ,case when tagesmenge < 4 then 4 else tagesmenge end
      ,case when tagesmenge < 4 then 4 else gff_menge_stueck end
      ,case when tagesmenge < 4 then 4 else fs1_menge_stueck end
      ,case when tagesmenge < 4 then 1 else erw_absatz_spaet end
      ,case when tagesmenge < 4 then 1 else erw_absatz_abend end
from dbp_etl.vis_agg_tmp
where (wup_cluster_id NOT IN (0,-1) or
       tagesmenge > 0)
;

create or replace volatile table _step1 as (
select a.mandant_id,
       a.art_id,
       a.wup_id,
       max(a.dat) as dat_vier,
       min(b.akt_wo) as akt_wo_von,
       max(b.akt_wo) as akt_wo_bis,
       min(b.kjwo) as kjwo_von,
       max(b.kjwo) as kjwo_bis,
       count(distinct b.kjwo) as anz
from dbp_msi_data.backshop_prognose_neu a
join (select a.mandant_id,
             a.wup_id,
	     a.art_id,
	     count(distinct b.akt_wo) as anz,
	     max(b.kjwo) as kjwo
      from dbp_msi_data.backshop_prognose_neu a
      join dbp_data.tag b
        on a.dat = b.dat
      where a.listung_id_backshop = 4
      group by 1,2,3
      having anz > 1) c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.art_id = c.art_id
join dbp_data.tag b
  on a.dat = b.dat and
     c.kjwo = b.kjwo
where a.listung_id_backshop = 4
group by 1,2,3
);

delete from _step1
where anz = 2 and
      akt_wo_bis = (select max(akt_wo_bis) from _step1) and
      akt_wo_von = (select max(akt_wo_bis) from _step1)-1
;

create or replace volatile table _step2 as (
select a.*,
       a.akt_wo_von+1 as akt_wo_bis_track,
       akt_wo_bis_track-1 as akt_wo_von_as,
       akt_wo_bis_track+2 as akt_wo_bis_as,
       b.kjwo as kjwo_bis_track,
       c.kjwo as kjwo_von_as,
       d.kjwo as kjwo_bis_as
from _step1 a
join dbp_data.woche b
  on a.akt_wo_von+1 = b.akt_wo
join dbp_data.woche c
  on a.akt_wo_von = c.akt_wo
join dbp_data.woche d
  on a.akt_wo_von+3 = d.akt_wo
);

update dbp_msi_data.backshop_prognose_neu from (select a.*,
                                                       b.dat
                                                from _step2 a
						join dbp_data.tag b
						  on b.kjwo between a.kjwo_von_as and a.kjwo_bis_as
                                                where b.dat > a.dat_vier) b

set listung_id_backshop = 5

where dbp_msi_data.backshop_prognose_neu.mandant_id = b.mandant_id and
      dbp_msi_data.backshop_prognose_neu.art_id = b.art_id and
      dbp_msi_data.backshop_prognose_neu.wup_id = b.wup_id and
      dbp_msi_data.backshop_prognose_neu.dat = b.dat and
      dbp_msi_data.backshop_prognose_neu.aktion_id = ''
;

create or replace volatile table _kill_art1 as (
select a.art_id,
       a.wup_id,
       a.mandant_id,
       max(b.dat) as max_dat
from _step2 a
join dbp_data.tag b
  on b.kjwo between a.kjwo_von_as and a.kjwo_bis_as
group by 1,2,3
);

create or replace volatile table _kill_art2 as (
select a.art_id,
       a.wup_id,
       a.mandant_id,
       min(b.dat) as min_dat
from _step2 a
join dbp_data.tag b
  on b.kjwo between a.kjwo_von_as and a.kjwo_bis_as
group by 1,2,3
);

delete from dbp_msi_data.backshop_prognose_neu
where (wup_id,mandant_id,art_id,dat,listung_id_backshop) in (select a.wup_id,
                                                                    a.mandant_id,
                                                                    a.art_id,
                                                                    a.dat,
                                                                    a.listung_id_backshop
                                                             from dbp_msi_data.backshop_prognose_neu a
                                                             join _kill_art1 b
                                                               on a.mandant_id = b.mandant_id and
                                                                  a.art_id = b.art_id and
                                                                  a.wup_id = b.wup_id and
                                                                  a.dat > b.max_dat and
                                                                  a.listung_id_backshop = 5)
;

delete from dbp_msi_data.backshop_prognose_neu
where (wup_id,mandant_id,art_id,dat,listung_id_backshop) in (select a.wup_id,
                                                                    a.mandant_id,
                                                                    a.art_id,
                                                                    a.dat,
                                                                    a.listung_id_backshop
                                                             from dbp_msi_data.backshop_prognose_neu a
                                                             join _kill_art2 b
                                                               on a.mandant_id = b.mandant_id and
                                                                  a.art_id = b.art_id and
                                                                  a.wup_id = b.wup_id and
                                                                  a.dat < b.min_dat and
                                                                  a.listung_id_backshop = 5)
;

drop table _vis_ods_tmp_calculation2;

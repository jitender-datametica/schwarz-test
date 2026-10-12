-- Lagerbestaende

delete from dbp_data.lagerbestand_erp_per
where (mandant_id,art_id) in (select mandant_id,art_id 
                              from dbp_data.art_wg_zu_per
                              where arthiertyp_id = 2 and
                                    dat_bis = '9999-12-31' and
                                    wg_id = 961)
;

create or replace volatile table _tage as (
select dat
from dbp_data.tag
where dat between current_date-5 and current_date
);

create or replace volatile table _step01 as (
select mandant_id
      ,wup_id
      ,nb_id
      ,lagerort_id
      ,art_id
      ,dat
      ,sum(menge_lgbest_erp_frei_bme) as menge_lgbest_erp_frei_bme
      ,sum(menge_lgbest_erp_umlag_bme) as menge_lgbest_erp_umlag_bme
      ,sum(menge_lgbest_erp_qual_bme) as menge_lgbest_erp_qual_bme
      ,sum(menge_lgbest_erp_nf_charge_bme) as menge_lgbest_erp_nf_charge_bme
      ,sum(menge_lgbest_erp_gesp_bme) as menge_lgbest_erp_gesp_bme
      ,sum(menge_lgbest_erp_ret_gesp_bme) as menge_lgbest_erp_ret_gesp_bme
      ,sum(menge_lgbest_erp_frei_bme+menge_lgbest_erp_umlag_bme+menge_lgbest_erp_qual_bme+menge_lgbest_erp_nf_charge_bme+menge_lgbest_erp_gesp_bme+menge_lgbest_erp_ret_gesp_bme) as menge_lgbest_erp_gesamt_bme
      ,sperr_id
      ,gjmo_buch
      ,lagerort_loesch_fg
      ,pflege_status
      ,sum(menge_lgbest_erp_kolli) as menge_lgbest_erp_kolli
      ,sum(menge_lgbest_erp_palette) as menge_lgbest_erp_palette
      ,sum(betrag_lgbest_erp) as ek_netto
      ,wrg_id
      ,sum(vk_netto_lgbest_erp) as vk_netto
from dbp_data.lagerbestand_erp_per a
join _tage b
  on b.dat between a.dat_von and a.dat_bis
group by 1,2,3,4,5,6,14,15,16,17,21
);

create or replace volatile table _dat (
  dat date
);

create or replace volatile table _dat_min (
  dat date
);

create or replace volatile table _vol_art_gp_wup_zu_per (
  mandant_id              smallint not null,
  art_id                  integer not null,
  gp_id                   integer not null,
  wup_id                  integer not null,
  nb_id                   smallint,
  einkaufsorganisation_id smallint not null,
  dat                     date not null,
  ek_brutto               decimal(18,4),
  ek_netto                decimal(18,4),
  ek_nettonetto           decimal(18,4),
  ek_kal_basis            decimal(18,4),
  ek_mep                  decimal(18,4),
  einstandspreis          decimal(18,4),
  logistikkostenzuschlag  decimal(18,4),
  ek_netto_bnk            decimal(18,4),
  ek_netto_bnk_sachk      decimal(18,4)
);

insert into _dat (dat)
select dat
from dbp_data.tag
where dat between current_date-5 and current_date
group by 1
;

insert into _dat_min (dat)
select min(dat)
from dbp_data.tag
where dat between current_date-5 and current_date
having min(dat) is not null
;

insert into _vol_art_gp_wup_zu_per
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,dat
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
)
select
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,dat
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
from
(
  select
     mandant_id
    ,wup_id
    ,nb_id
    ,art_id
    ,gp_id
    ,einkaufsorganisation_id
    ,dat_von
    ,dat_bis
    ,wrg_id
    ,cast(ek_brutto          as decimal(18,4))*coalesce(komponentenmenge,1) as ek_brutto
    ,cast(ek_netto           as decimal(18,4))*coalesce(komponentenmenge,1) as ek_netto
    ,cast(ek_nettonetto      as decimal(18,4))*coalesce(komponentenmenge,1) as ek_nettonetto
    ,cast(ek_kal_basis       as decimal(18,4))*coalesce(komponentenmenge,1) as ek_kal_basis
    ,cast(ek_mep             as decimal(18,4))*coalesce(komponentenmenge,1) as ek_mep
    ,cast(einstandspreis     as decimal(18,4))*coalesce(komponentenmenge,1) as einstandspreis
    ,logistikkostenzuschlag*coalesce(komponentenmenge,1) as logistikkostenzuschlag
    ,cast(ek_netto_bnk       as decimal(18,4))*coalesce(komponentenmenge,1) as ek_netto_bnk
    ,cast(ek_netto_bnk_sachk as decimal(18,4))*coalesce(komponentenmenge,1) as ek_netto_bnk_sachk
  from dbp_data.art_gp_wup_zu_per a

  inner join _dat_min m
  on a.dat_bis >= m.dat) a

-- auf tag auffaechern
inner join _dat d
on d.dat between a.dat_von and a.dat_bis
;

create or replace table dbp_etl.lagerbestand_erp_per_step02 like dbp_msi_data.lagerbestand_erp_tag_sum;
create or replace table dbp_etl.lagerbestand_erp_per_step03 like dbp_msi_data.lagerbestand_erp_tag_sum;

insert into dbp_etl.lagerbestand_erp_per_step02 (mandant_id
                                                ,wup_id
                                                ,nb_id
                                                ,lagerort_id
                                                ,art_id
                                                ,dat
                                                ,menge_lgbest_erp_frei_bme
                                                ,menge_lgbest_erp_umlag_bme
                                                ,menge_lgbest_erp_qual_bme
                                                ,menge_lgbest_erp_nf_charge_bme
                                                ,menge_lgbest_erp_gesp_bme
                                                ,menge_lgbest_erp_ret_gesp_bme
                                                ,menge_lgbest_erp_gesamt_bme
                                                ,sperr_id
                                                ,gjmo_buch
                                                ,lagerort_loesch_fg
                                                ,pflege_status
                                                ,menge_lgbest_erp_kolli
                                                ,menge_lgbest_erp_palette
                                                ,ek_netto
                                                ,wrg_id
                                                ,vk_netto
                                                ,gp_id)
select mandant_id
      ,wup_id
      ,nb_id
      ,lagerort_id
      ,art_id
      ,dat
      ,menge_lgbest_erp_frei_bme
      ,menge_lgbest_erp_umlag_bme
      ,menge_lgbest_erp_qual_bme
      ,menge_lgbest_erp_nf_charge_bme
      ,menge_lgbest_erp_gesp_bme
      ,menge_lgbest_erp_ret_gesp_bme
      ,menge_lgbest_erp_gesamt_bme
      ,sperr_id
      ,gjmo_buch
      ,lagerort_loesch_fg
      ,pflege_status
      ,menge_lgbest_erp_kolli
      ,menge_lgbest_erp_palette
      ,ek_netto
      ,wrg_id
      ,vk_netto
      ,0 as gp_id
from _step01
;

update dbp_etl.lagerbestand_erp_per_step02 set betrag_vk_netto_lgbest_erp_frei = case when menge_lgbest_erp_gesamt_bme = 0 then 0 else (vk_netto/menge_lgbest_erp_gesamt_bme)*menge_lgbest_erp_frei_bme end,
                                               betrag_vk_netto_lgbest_erp_qual = case when menge_lgbest_erp_gesamt_bme = 0 then 0 else (vk_netto/menge_lgbest_erp_gesamt_bme)*menge_lgbest_erp_qual_bme end,
                                               betrag_vk_netto_lgbest_erp_gesamt = vk_netto,
                                               ek_logistik = case when menge_lgbest_erp_gesamt_bme = 0 then 0 else ek_netto/menge_lgbest_erp_gesamt_bme end,
                                               betrag_ek_logistik_lgbest_erp_gesamt = ek_netto
;

create or replace volatile table _lagerbestand_erp_per_step03 as (
select a.mandant_id
      ,a.wup_id
      ,a.nb_id
      ,a.lagerort_id
      ,a.art_id
      ,a.dat
      ,coalesce(x.gp_id,a.gp_id) as gp_id
      ,a.posten_id
      ,a.menge_lgbest_erp_frei_bme
      ,a.menge_lgbest_erp_umlag_bme
      ,a.menge_lgbest_erp_qual_bme
      ,a.menge_lgbest_erp_nf_charge_bme
      ,a.menge_lgbest_erp_gesp_bme
      ,a.menge_lgbest_erp_ret_gesp_bme
      ,a.menge_lgbest_erp_gesamt_bme
      ,a.sperr_id
      ,a.gjmo_buch
      ,a.lagerort_loesch_fg
      ,a.pflege_status
      ,a.menge_lgbest_erp_kolli
      ,a.menge_lgbest_erp_palette
      ,a.wrg_id
      ,coalesce(a.vk_netto/nullifzero(a.menge_lgbest_erp_gesamt_bme),0) as vk_netto
      ,a.betrag_vk_netto_lgbest_erp_frei
      ,a.betrag_vk_netto_lgbest_erp_qual
      ,a.betrag_vk_netto_lgbest_erp_gesamt
      ,a.vk_netto_konz
      ,a.betrag_vk_netto_lgbest_erp_frei_konz
      ,a.betrag_vk_netto_lgbest_erp_qual_konz
      ,a.betrag_vk_netto_lgbest_erp_gesamt_konz
      ,coalesce(agw.ek_netto, agww.ek_netto, agwww.ek_netto,0) as ek_netto
      ,a.menge_lgbest_erp_frei_bme   * coalesce(agw.ek_netto, agww.ek_netto, agwww.ek_netto,0) as betrag_ek_netto_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme   * coalesce(agw.ek_netto, agww.ek_netto, agwww.ek_netto,0) as betrag_ek_netto_lgbest_erp_qual
      ,a.ek_netto_konz
      ,a.betrag_ek_netto_lgbest_erp_frei_konz
      ,a.betrag_ek_netto_lgbest_erp_qual_konz
      ,coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk, agwww.ek_netto_bnk,0) as ek_netto_bnk
      ,a.menge_lgbest_erp_frei_bme   * coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk, agwww.ek_netto_bnk,0) as betrag_ek_netto_bnk_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme   * coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk, agwww.ek_netto_bnk,0) as betrag_ek_netto_bnk_lgbest_erp_qual
      ,a.ek_netto_bnk_konz
      ,a.betrag_ek_netto_bnk_lgbest_erp_frei_konz
      ,a.betrag_ek_netto_bnk_lgbest_erp_qual_konz
      ,coalesce(agw.ek_nettonetto, agww.ek_nettonetto, agwww.ek_nettonetto,0) as ek_nettonetto
      ,a.menge_lgbest_erp_frei_bme   * coalesce(agw.ek_nettonetto, agww.ek_nettonetto, agwww.ek_nettonetto,0) as betrag_ek_nettonetto_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme   * coalesce(agw.ek_nettonetto, agww.ek_nettonetto, agwww.ek_nettonetto,0) as betrag_ek_nettonetto_lgbest_erp_qual
      ,a.ek_nettonetto_konz
      ,a.betrag_ek_nettonetto_lgbest_erp_frei_konz
      ,a.betrag_ek_nettonetto_lgbest_erp_qual_konz
      ,coalesce(agw.ek_mep-coalesce(agw.logistikkostenzuschlag,0), agww.ek_mep-coalesce(agww.logistikkostenzuschlag,0), agwww.ek_mep-coalesce(agwww.logistikkostenzuschlag,0),0) as ek_mep_olk
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.ek_mep-coalesce(agw.logistikkostenzuschlag,0), agww.ek_mep-coalesce(agww.logistikkostenzuschlag,0), agwww.ek_mep-coalesce(agwww.logistikkostenzuschlag,0),0) as betrag_ek_mep_olk_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.ek_mep-coalesce(agw.logistikkostenzuschlag,0), agww.ek_mep-coalesce(agww.logistikkostenzuschlag,0), agwww.ek_mep-coalesce(agwww.logistikkostenzuschlag,0),0) as betrag_ek_mep_olk_lgbest_erp_qual
      ,a.ek_mep_olk_konz
      ,a.betrag_ek_mep_olk_lgbest_erp_frei_konz
      ,a.betrag_ek_mep_olk_lgbest_erp_qual_konz
      ,coalesce(agw.einstandspreis, agww.einstandspreis, agwww.einstandspreis,0) as ek_einstandspreis
      ,a.menge_lgbest_erp_frei_bme   * coalesce(agw.einstandspreis, agww.einstandspreis, agwww.einstandspreis,0) as betrag_ek_einstandspreis_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme   * coalesce(agw.einstandspreis, agww.einstandspreis, agwww.einstandspreis,0) as betrag_ek_einstandspreis_lgbest_erp_qual
      ,a.ek_einstandspreis_konz
      ,a.betrag_ek_einstandspreis_lgbest_erp_frei_konz
      ,a.betrag_ek_einstandspreis_lgbest_erp_qual_konz
      ,current_timestamp as td_update
      ,current_timestamp as td_insert
      ,a.ek_logistik
      ,a.betrag_ek_logistik_lgbest_erp_gesamt
      ,a.betrag_ek_logistik_lgbest_erp_gesamt_konz
      ,a.ek_logistik_konz

from dbp_etl.lagerbestand_erp_per_step02 a
join _dat d
  on a.dat = d.dat

-- lieferant und ausstiegspunkt ermitteln
left join dbp_data.art_gp_nm_zu_per x
 on a.mandant_id = x.mandant_id and 
    a.wup_id = x.wup_id and 
    a.art_id = x.art_id and 
    a.dat between x.dat_von and x.dat_bis

left join dbp_data.ek_orderbuch xxx
  on a.mandant_id = xxx.mandant_id and 
     x.gp_id = xxx.wup_id and 
     a.art_id = xxx.art_id and 
     a.dat between xxx.dat_von and xxx.dat_bis

-- betriebsuebergreifender ek preis
left join _vol_art_gp_wup_zu_per agwww
  on x.mandant_id = agwww.mandant_id and 
     x.gp_id = agwww.wup_id and
     x.art_id = agwww.art_id and 
     coalesce(xxx.gp_id,x.gp_id) = agwww.gp_id and 
     a.dat = agwww.dat

-- betriebsspezifischer ek preis
left join _vol_art_gp_wup_zu_per agw
  on x.mandant_id = agw.mandant_id and 
     x.vz_wup_id = agw.wup_id and 
     x.art_id = agw.art_id and 
     coalesce(xxx.gp_id,x.gp_id) = agw.gp_id and
     a.dat = agw.dat

-- betriebsuebergreifender ek preis
left join _vol_art_gp_wup_zu_per agww
  on x.mandant_id = agww.mandant_id and 
     -1 = agww.wup_id and 
     x.art_id = agww.art_id and 
     x.gp_id = agww.gp_id and 
     a.dat = agww.dat

where a.mandant_id = 1
);

insert into dbp_etl.lagerbestand_erp_per_step03 (mandant_id
                                                ,art_id
                                                ,wup_id
                                                ,nb_id
                                                ,lagerort_id
                                                ,dat
                                                ,gp_id
                                                ,posten_id
                                                ,wrg_id
                                                ,sperr_id
                                                ,gjmo_buch
                                                ,lagerort_loesch_fg
                                                ,pflege_status
                                                ,menge_lgbest_erp_frei_bme
                                                ,menge_lgbest_erp_umlag_bme
                                                ,menge_lgbest_erp_qual_bme
                                                ,menge_lgbest_erp_nf_charge_bme
                                                ,menge_lgbest_erp_gesp_bme
                                                ,menge_lgbest_erp_ret_gesp_bme
                                                ,menge_lgbest_erp_gesamt_bme
                                                ,menge_lgbest_erp_kolli
                                                ,menge_lgbest_erp_palette
                                                ,vk_netto
                                                ,vk_netto_konz
                                                ,betrag_vk_netto_lgbest_erp_frei
                                                ,betrag_vk_netto_lgbest_erp_frei_konz
                                                ,betrag_vk_netto_lgbest_erp_qual
                                                ,betrag_vk_netto_lgbest_erp_qual_konz
                                                ,betrag_vk_netto_lgbest_erp_gesamt
                                                ,betrag_vk_netto_lgbest_erp_gesamt_konz
                                                ,ek_netto
                                                ,ek_netto_konz
                                                ,betrag_ek_netto_lgbest_erp_frei
                                                ,betrag_ek_netto_lgbest_erp_frei_konz
                                                ,betrag_ek_netto_lgbest_erp_qual
                                                ,betrag_ek_netto_lgbest_erp_qual_konz
                                                ,ek_netto_bnk
                                                ,ek_netto_bnk_konz
                                                ,betrag_ek_netto_bnk_lgbest_erp_frei
                                                ,betrag_ek_netto_bnk_lgbest_erp_frei_konz
                                                ,betrag_ek_netto_bnk_lgbest_erp_qual
                                                ,betrag_ek_netto_bnk_lgbest_erp_qual_konz
                                                ,ek_nettonetto
                                                ,ek_nettonetto_konz
                                                ,betrag_ek_nettonetto_lgbest_erp_frei
                                                ,betrag_ek_nettonetto_lgbest_erp_frei_konz
                                                ,betrag_ek_nettonetto_lgbest_erp_qual
                                                ,betrag_ek_nettonetto_lgbest_erp_qual_konz
                                                ,ek_mep_olk
                                                ,ek_mep_olk_konz
                                                ,betrag_ek_mep_olk_lgbest_erp_frei
                                                ,betrag_ek_mep_olk_lgbest_erp_frei_konz
                                                ,betrag_ek_mep_olk_lgbest_erp_qual
                                                ,betrag_ek_mep_olk_lgbest_erp_qual_konz
                                                ,ek_einstandspreis
                                                ,ek_einstandspreis_konz
                                                ,betrag_ek_einstandspreis_lgbest_erp_frei
                                                ,betrag_ek_einstandspreis_lgbest_erp_frei_konz
                                                ,betrag_ek_einstandspreis_lgbest_erp_qual
                                                ,betrag_ek_einstandspreis_lgbest_erp_qual_konz
                                                ,ek_logistik
                                                ,ek_logistik_konz
                                                ,betrag_ek_logistik_lgbest_erp_gesamt
                                                ,betrag_ek_logistik_lgbest_erp_gesamt_konz
                                                ,td_update
                                                ,td_insert)
select mandant_id
      ,art_id
      ,wup_id
      ,nb_id
      ,lagerort_id
      ,dat
      ,gp_id
      ,posten_id
      ,wrg_id
      ,sperr_id
      ,gjmo_buch
      ,lagerort_loesch_fg
      ,pflege_status
      ,menge_lgbest_erp_frei_bme
      ,menge_lgbest_erp_umlag_bme
      ,menge_lgbest_erp_qual_bme
      ,menge_lgbest_erp_nf_charge_bme
      ,menge_lgbest_erp_gesp_bme
      ,menge_lgbest_erp_ret_gesp_bme
      ,menge_lgbest_erp_gesamt_bme
      ,menge_lgbest_erp_kolli
      ,menge_lgbest_erp_palette
      ,vk_netto
      ,vk_netto_konz
      ,betrag_vk_netto_lgbest_erp_frei
      ,betrag_vk_netto_lgbest_erp_frei_konz
      ,betrag_vk_netto_lgbest_erp_qual
      ,betrag_vk_netto_lgbest_erp_qual_konz
      ,betrag_vk_netto_lgbest_erp_gesamt
      ,betrag_vk_netto_lgbest_erp_gesamt_konz
      ,ek_netto
      ,ek_netto_konz
      ,betrag_ek_netto_lgbest_erp_frei
      ,betrag_ek_netto_lgbest_erp_frei_konz
      ,betrag_ek_netto_lgbest_erp_qual
      ,betrag_ek_netto_lgbest_erp_qual_konz
      ,ek_netto_bnk
      ,ek_netto_bnk_konz
      ,betrag_ek_netto_bnk_lgbest_erp_frei
      ,betrag_ek_netto_bnk_lgbest_erp_frei_konz
      ,betrag_ek_netto_bnk_lgbest_erp_qual
      ,betrag_ek_netto_bnk_lgbest_erp_qual_konz
      ,ek_nettonetto
      ,ek_nettonetto_konz
      ,betrag_ek_nettonetto_lgbest_erp_frei
      ,betrag_ek_nettonetto_lgbest_erp_frei_konz
      ,betrag_ek_nettonetto_lgbest_erp_qual
      ,betrag_ek_nettonetto_lgbest_erp_qual_konz
      ,ek_mep_olk
      ,ek_mep_olk_konz
      ,betrag_ek_mep_olk_lgbest_erp_frei
      ,betrag_ek_mep_olk_lgbest_erp_frei_konz
      ,betrag_ek_mep_olk_lgbest_erp_qual
      ,betrag_ek_mep_olk_lgbest_erp_qual_konz
      ,ek_einstandspreis
      ,ek_einstandspreis_konz
      ,betrag_ek_einstandspreis_lgbest_erp_frei
      ,betrag_ek_einstandspreis_lgbest_erp_frei_konz
      ,betrag_ek_einstandspreis_lgbest_erp_qual
      ,betrag_ek_einstandspreis_lgbest_erp_qual_konz
      ,ek_logistik
      ,ek_logistik_konz
      ,betrag_ek_logistik_lgbest_erp_gesamt
      ,betrag_ek_logistik_lgbest_erp_gesamt_konz
      ,td_update
      ,td_insert
from _lagerbestand_erp_per_step03
;

create or replace volatile table _lagerbestand_erp_per_step03_kmo as (
select a.mandant_id
      ,a.wup_id
      ,a.nb_id
      ,a.lagerort_id
      ,a.art_id
      ,a.dat
      ,coalesce(x.gp_id,a.gp_id) as gp_id
      ,a.posten_id
      ,a.menge_lgbest_erp_frei_bme
      ,a.menge_lgbest_erp_umlag_bme
      ,a.menge_lgbest_erp_qual_bme
      ,a.menge_lgbest_erp_nf_charge_bme
      ,a.menge_lgbest_erp_gesp_bme
      ,a.menge_lgbest_erp_ret_gesp_bme
      ,a.menge_lgbest_erp_gesamt_bme
      ,a.sperr_id
      ,a.gjmo_buch
      ,a.lagerort_loesch_fg
      ,a.pflege_status
      ,a.menge_lgbest_erp_kolli
      ,a.menge_lgbest_erp_palette
      ,a.wrg_id
      ,coalesce(a.vk_netto/nullifzero(a.menge_lgbest_erp_gesamt_bme),0) as vk_netto
      ,a.betrag_vk_netto_lgbest_erp_frei
      ,a.betrag_vk_netto_lgbest_erp_qual
      ,a.betrag_vk_netto_lgbest_erp_gesamt
      ,a.vk_netto_konz
      ,a.betrag_vk_netto_lgbest_erp_frei_konz
      ,a.betrag_vk_netto_lgbest_erp_qual_konz
      ,a.betrag_vk_netto_lgbest_erp_gesamt_konz
      ,coalesce(agw.ek_netto, agww.ek_netto,0) as ek_netto
      ,a.menge_lgbest_erp_frei_bme   * coalesce(agw.ek_netto, agww.ek_netto,0) as betrag_ek_netto_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme   * coalesce(agw.ek_netto, agww.ek_netto,0) as betrag_ek_netto_lgbest_erp_qual
      ,a.ek_netto_konz
      ,a.betrag_ek_netto_lgbest_erp_frei_konz
      ,a.betrag_ek_netto_lgbest_erp_qual_konz
      ,coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk,0) as ek_netto_bnk
      ,a.menge_lgbest_erp_frei_bme   * coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk,0) as betrag_ek_netto_bnk_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme   * coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk,0) as betrag_ek_netto_bnk_lgbest_erp_qual
      ,a.ek_netto_bnk_konz
      ,a.betrag_ek_netto_bnk_lgbest_erp_frei_konz
      ,a.betrag_ek_netto_bnk_lgbest_erp_qual_konz
      ,coalesce(agw.ek_nettonetto, agww.ek_nettonetto,0) as ek_nettonetto
      ,a.menge_lgbest_erp_frei_bme   * coalesce(agw.ek_nettonetto, agww.ek_nettonetto,0) as betrag_ek_nettonetto_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme   * coalesce(agw.ek_nettonetto, agww.ek_nettonetto,0) as betrag_ek_nettonetto_lgbest_erp_qual
      ,a.ek_nettonetto_konz
      ,a.betrag_ek_nettonetto_lgbest_erp_frei_konz
      ,a.betrag_ek_nettonetto_lgbest_erp_qual_konz
      ,coalesce(agw.ek_mep, agww.ek_mep,0) as ek_mep_olk
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.ek_mep, agww.ek_mep,0) as betrag_ek_mep_olk_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.ek_mep, agww.ek_mep,0) as betrag_ek_mep_olk_lgbest_erp_qual
      ,a.ek_mep_olk_konz
      ,a.betrag_ek_mep_olk_lgbest_erp_frei_konz
      ,a.betrag_ek_mep_olk_lgbest_erp_qual_konz
      ,coalesce(agw.einstandspreis, agww.einstandspreis,0) as ek_einstandspreis
      ,a.menge_lgbest_erp_frei_bme   * coalesce(agw.einstandspreis, agww.einstandspreis,0) as betrag_ek_einstandspreis_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme   * coalesce(agw.einstandspreis, agww.einstandspreis,0) as betrag_ek_einstandspreis_lgbest_erp_qual
      ,a.ek_einstandspreis_konz
      ,a.betrag_ek_einstandspreis_lgbest_erp_frei_konz
      ,a.betrag_ek_einstandspreis_lgbest_erp_qual_konz
      ,current_timestamp as td_update
      ,current_timestamp as td_insert
      ,a.ek_logistik
      ,a.betrag_ek_logistik_lgbest_erp_gesamt
      ,a.betrag_ek_logistik_lgbest_erp_gesamt_konz
      ,a.ek_logistik_konz

from dbp_etl.lagerbestand_erp_per_step02 a
join _dat d
  on a.dat = d.dat

-- lieferant und ausstiegspunkt ermitteln
left join dbp_data.art_gp_nm_zu_per x
  on a.mandant_id = x.mandant_id
 and a.wup_id = x.wup_id
 and a.art_id = x.art_id 
 and a.dat between x.dat_von and x.dat_bis 

-- betriebsspezifischer ek preis 
left join _vol_art_gp_wup_zu_per agw
  on x.mandant_id = agw.mandant_id 
 and x.vz_wup_id = agw.wup_id 
 and x.art_id = agw.art_id
 and x.gp_id = agw.gp_id 
 and a.dat = agw.dat

-- betriebsuebergreifender ek preis
left join _vol_art_gp_wup_zu_per agww
  on x.mandant_id = agww.mandant_id 
 and -1 = agww.wup_id 
 and x.art_id = agww.art_id
 and x.gp_id = agww.gp_id 
 and a.dat = agww.dat

where a.mandant_id > 1
);

insert into dbp_etl.lagerbestand_erp_per_step03 (mandant_id
                                                ,art_id
                                                ,wup_id
                                                ,nb_id
                                                ,lagerort_id
                                                ,dat
                                                ,gp_id
                                                ,posten_id
                                                ,wrg_id
                                                ,sperr_id
                                                ,gjmo_buch
                                                ,lagerort_loesch_fg
                                                ,pflege_status
                                                ,menge_lgbest_erp_frei_bme
                                                ,menge_lgbest_erp_umlag_bme
                                                ,menge_lgbest_erp_qual_bme
                                                ,menge_lgbest_erp_nf_charge_bme
                                                ,menge_lgbest_erp_gesp_bme
                                                ,menge_lgbest_erp_ret_gesp_bme
                                                ,menge_lgbest_erp_gesamt_bme
                                                ,menge_lgbest_erp_kolli
                                                ,menge_lgbest_erp_palette
                                                ,vk_netto
                                                ,vk_netto_konz
                                                ,betrag_vk_netto_lgbest_erp_frei
                                                ,betrag_vk_netto_lgbest_erp_frei_konz
                                                ,betrag_vk_netto_lgbest_erp_qual
                                                ,betrag_vk_netto_lgbest_erp_qual_konz
                                                ,betrag_vk_netto_lgbest_erp_gesamt
                                                ,betrag_vk_netto_lgbest_erp_gesamt_konz
                                                ,ek_netto
                                                ,ek_netto_konz
                                                ,betrag_ek_netto_lgbest_erp_frei
                                                ,betrag_ek_netto_lgbest_erp_frei_konz
                                                ,betrag_ek_netto_lgbest_erp_qual
                                                ,betrag_ek_netto_lgbest_erp_qual_konz
                                                ,ek_netto_bnk
                                                ,ek_netto_bnk_konz
                                                ,betrag_ek_netto_bnk_lgbest_erp_frei
                                                ,betrag_ek_netto_bnk_lgbest_erp_frei_konz
                                                ,betrag_ek_netto_bnk_lgbest_erp_qual
                                                ,betrag_ek_netto_bnk_lgbest_erp_qual_konz
                                                ,ek_nettonetto
                                                ,ek_nettonetto_konz
                                                ,betrag_ek_nettonetto_lgbest_erp_frei
                                                ,betrag_ek_nettonetto_lgbest_erp_frei_konz
                                                ,betrag_ek_nettonetto_lgbest_erp_qual
                                                ,betrag_ek_nettonetto_lgbest_erp_qual_konz
                                                ,ek_mep_olk
                                                ,ek_mep_olk_konz
                                                ,betrag_ek_mep_olk_lgbest_erp_frei
                                                ,betrag_ek_mep_olk_lgbest_erp_frei_konz
                                                ,betrag_ek_mep_olk_lgbest_erp_qual
                                                ,betrag_ek_mep_olk_lgbest_erp_qual_konz
                                                ,ek_einstandspreis
                                                ,ek_einstandspreis_konz
                                                ,betrag_ek_einstandspreis_lgbest_erp_frei
                                                ,betrag_ek_einstandspreis_lgbest_erp_frei_konz
                                                ,betrag_ek_einstandspreis_lgbest_erp_qual
                                                ,betrag_ek_einstandspreis_lgbest_erp_qual_konz
                                                ,ek_logistik
                                                ,ek_logistik_konz
                                                ,betrag_ek_logistik_lgbest_erp_gesamt
                                                ,betrag_ek_logistik_lgbest_erp_gesamt_konz
                                                ,td_update
                                                ,td_insert)
select mandant_id
      ,art_id
      ,wup_id
      ,nb_id
      ,lagerort_id
      ,dat
      ,gp_id
      ,posten_id
      ,wrg_id
      ,sperr_id
      ,gjmo_buch
      ,lagerort_loesch_fg
      ,pflege_status
      ,menge_lgbest_erp_frei_bme
      ,menge_lgbest_erp_umlag_bme
      ,menge_lgbest_erp_qual_bme
      ,menge_lgbest_erp_nf_charge_bme
      ,menge_lgbest_erp_gesp_bme
      ,menge_lgbest_erp_ret_gesp_bme
      ,menge_lgbest_erp_gesamt_bme
      ,menge_lgbest_erp_kolli
      ,menge_lgbest_erp_palette
      ,vk_netto
      ,vk_netto_konz
      ,betrag_vk_netto_lgbest_erp_frei
      ,betrag_vk_netto_lgbest_erp_frei_konz
      ,betrag_vk_netto_lgbest_erp_qual
      ,betrag_vk_netto_lgbest_erp_qual_konz
      ,betrag_vk_netto_lgbest_erp_gesamt
      ,betrag_vk_netto_lgbest_erp_gesamt_konz
      ,ek_netto
      ,ek_netto_konz
      ,betrag_ek_netto_lgbest_erp_frei
      ,betrag_ek_netto_lgbest_erp_frei_konz
      ,betrag_ek_netto_lgbest_erp_qual
      ,betrag_ek_netto_lgbest_erp_qual_konz
      ,ek_netto_bnk
      ,ek_netto_bnk_konz
      ,betrag_ek_netto_bnk_lgbest_erp_frei
      ,betrag_ek_netto_bnk_lgbest_erp_frei_konz
      ,betrag_ek_netto_bnk_lgbest_erp_qual
      ,betrag_ek_netto_bnk_lgbest_erp_qual_konz
      ,ek_nettonetto
      ,ek_nettonetto_konz
      ,betrag_ek_nettonetto_lgbest_erp_frei
      ,betrag_ek_nettonetto_lgbest_erp_frei_konz
      ,betrag_ek_nettonetto_lgbest_erp_qual
      ,betrag_ek_nettonetto_lgbest_erp_qual_konz
      ,ek_mep_olk
      ,ek_mep_olk_konz
      ,betrag_ek_mep_olk_lgbest_erp_frei
      ,betrag_ek_mep_olk_lgbest_erp_frei_konz
      ,betrag_ek_mep_olk_lgbest_erp_qual
      ,betrag_ek_mep_olk_lgbest_erp_qual_konz
      ,ek_einstandspreis
      ,ek_einstandspreis_konz
      ,betrag_ek_einstandspreis_lgbest_erp_frei
      ,betrag_ek_einstandspreis_lgbest_erp_frei_konz
      ,betrag_ek_einstandspreis_lgbest_erp_qual
      ,betrag_ek_einstandspreis_lgbest_erp_qual_konz
      ,ek_logistik
      ,ek_logistik_konz
      ,betrag_ek_logistik_lgbest_erp_gesamt
      ,betrag_ek_logistik_lgbest_erp_gesamt_konz
      ,td_update
      ,td_insert
from _lagerbestand_erp_per_step03_kmo
;

create or replace volatile table _lagerbestand_erp_per_step04 as (
select a.mandant_id
      ,a.wup_id
      ,a.nb_id
      ,a.lagerort_id
      ,a.art_id
      ,a.dat
      ,a.gp_id
      ,a.posten_id
      ,a.menge_lgbest_erp_frei_bme
      ,a.menge_lgbest_erp_umlag_bme
      ,a.menge_lgbest_erp_qual_bme
      ,a.menge_lgbest_erp_nf_charge_bme
      ,a.menge_lgbest_erp_gesp_bme
      ,a.menge_lgbest_erp_ret_gesp_bme
      ,a.menge_lgbest_erp_gesamt_bme
      ,a.sperr_id
      ,a.gjmo_buch
      ,a.lagerort_loesch_fg
      ,a.pflege_status
      ,a.menge_lgbest_erp_kolli
      ,a.menge_lgbest_erp_palette
      ,a.wrg_id
      ,a.vk_netto
      ,a.betrag_vk_netto_lgbest_erp_frei
      ,a.betrag_vk_netto_lgbest_erp_qual
      ,a.betrag_vk_netto_lgbest_erp_gesamt
      ,a.vk_netto*d1.umrechnungskurs as vk_netto_konz
      ,a.betrag_vk_netto_lgbest_erp_frei*d1.umrechnungskurs as betrag_vk_netto_lgbest_erp_frei_konz
      ,a.betrag_vk_netto_lgbest_erp_qual*d1.umrechnungskurs as betrag_vk_netto_lgbest_erp_qual_konz
      ,a.betrag_vk_netto_lgbest_erp_gesamt*d1.umrechnungskurs as betrag_vk_netto_lgbest_erp_gesamt_konz
      ,a.ek_netto
      ,a.betrag_ek_netto_lgbest_erp_frei
      ,a.betrag_ek_netto_lgbest_erp_qual
      ,a.ek_netto*d1.umrechnungskurs as ek_netto_konz
      ,a.betrag_ek_netto_lgbest_erp_frei*d1.umrechnungskurs as betrag_ek_netto_lgbest_erp_frei_konz
      ,a.betrag_ek_netto_lgbest_erp_qual*d1.umrechnungskurs as betrag_ek_netto_lgbest_erp_qual_konz
      ,a.ek_netto_bnk
      ,a.betrag_ek_netto_bnk_lgbest_erp_frei
      ,a.betrag_ek_netto_bnk_lgbest_erp_qual
      ,a.ek_netto_bnk*d1.umrechnungskurs as ek_netto_bnk_konz
      ,a.betrag_ek_netto_bnk_lgbest_erp_frei*d1.umrechnungskurs as betrag_ek_netto_bnk_lgbest_erp_frei_konz
      ,a.betrag_ek_netto_bnk_lgbest_erp_qual*d1.umrechnungskurs as betrag_ek_netto_bnk_lgbest_erp_qual_konz
      ,a.ek_nettonetto
      ,a.betrag_ek_nettonetto_lgbest_erp_frei
      ,a.betrag_ek_nettonetto_lgbest_erp_qual
      ,a.ek_nettonetto*d1.umrechnungskurs as ek_nettonetto_konz
      ,a.betrag_ek_nettonetto_lgbest_erp_frei*d1.umrechnungskurs as betrag_ek_nettonetto_lgbest_erp_frei_konz
      ,a.betrag_ek_nettonetto_lgbest_erp_qual*d1.umrechnungskurs as betrag_ek_nettonetto_lgbest_erp_qual_konz
      ,a.ek_mep_olk as  ek_mep_olk
      ,a.betrag_ek_mep_olk_lgbest_erp_frei as betrag_ek_mep_olk_lgbest_erp_frei
      ,a.betrag_ek_mep_olk_lgbest_erp_qual as betrag_ek_mep_olk_lgbest_erp_qual
      ,a.ek_mep_olk*d1.umrechnungskurs as ek_mep_olk_konz
      ,a.betrag_ek_mep_olk_lgbest_erp_frei*d1.umrechnungskurs as betrag_ek_mep_olk_lgbest_erp_frei_konz
      ,a.betrag_ek_mep_olk_lgbest_erp_qual*d1.umrechnungskurs as betrag_ek_mep_olk_lgbest_erp_qual_konz
      ,a.ek_einstandspreis
      ,a.betrag_ek_einstandspreis_lgbest_erp_frei
      ,a.betrag_ek_einstandspreis_lgbest_erp_qual
      ,a.ek_einstandspreis*d1.umrechnungskurs as ek_einstandspreis_konz
      ,a.betrag_ek_einstandspreis_lgbest_erp_frei*d1.umrechnungskurs as betrag_ek_einstandspreis_lgbest_erp_frei_konz
      ,a.betrag_ek_einstandspreis_lgbest_erp_qual*d1.umrechnungskurs as betrag_ek_einstandspreis_lgbest_erp_qual_konz
      ,a.td_update
      ,a.td_insert
      ,a.ek_logistik
      ,a.betrag_ek_logistik_lgbest_erp_gesamt
      ,a.betrag_ek_logistik_lgbest_erp_gesamt*d1.umrechnungskurs as betrag_ek_logistik_lgbest_erp_gesamt_konz
      ,a.ek_logistik*d1.umrechnungskurs as ek_logistik_konz
from dbp_etl.lagerbestand_erp_per_step03 a
join dbp_data.kurs d1
  on a.wrg_id = d1.von_wrg_id and
     d1.dat_bis = '9999-12-31' and
     d1.nach_wrg_id = 'EUR' and
     d1.kurstyp_id = 3
);

create or replace volatile table _tage as (
select dat
from _lagerbestand_erp_per_step04
group by 1
);

create or replace volatile table _min_tage as (
select min(dat) as min_dat
from _lagerbestand_erp_per_step04
);

create or replace volatile table _art_per as (
select a.*,
       b.dat
from (select a.*
      from dbp_data.art_per a
      join _min_tage b
        on a.dat_bis >= b.min_dat) a
join _tage b
  on b.dat BETWEEN a.dat_von AND a.dat_bis
);

update _lagerbestand_erp_per_step04 from (select *
                                          from _art_per) b

set posten_id = b.posten_id

where _lagerbestand_erp_per_step04.dat = b.dat and
      _lagerbestand_erp_per_step04.mandant_id = b.mandant_id and
      _lagerbestand_erp_per_step04.art_id = b.art_id
;

create or replace volatile table _lagerbestand_erp_per_step05 as (
select mandant_id
      ,art_id
      ,wup_id
      ,nb_id
      ,lagerort_id
      ,dat
      ,gp_id
      ,posten_id
      ,wrg_id
      ,max(sperr_id) as sperr_id
      ,max(gjmo_buch) as gjmo_buch
      ,max(lagerort_loesch_fg) as lagerort_loesch_fg
      ,max(pflege_status) as pflege_status
      ,sum(menge_lgbest_erp_frei_bme) as menge_lgbest_erp_frei_bme
      ,sum(menge_lgbest_erp_umlag_bme) as menge_lgbest_erp_umlag_bme
      ,sum(menge_lgbest_erp_qual_bme) as menge_lgbest_erp_qual_bme
      ,sum(menge_lgbest_erp_nf_charge_bme) as menge_lgbest_erp_nf_charge_bme
      ,sum(menge_lgbest_erp_gesp_bme) as menge_lgbest_erp_gesp_bme
      ,sum(menge_lgbest_erp_ret_gesp_bme) as menge_lgbest_erp_ret_gesp_bme
      ,sum(menge_lgbest_erp_gesamt_bme) as menge_lgbest_erp_gesamt_bme
      ,sum(menge_lgbest_erp_kolli) as menge_lgbest_erp_kolli
      ,sum(menge_lgbest_erp_palette) as menge_lgbest_erp_palette
      ,max(vk_netto) as vk_netto
      ,max(vk_netto_konz) as vk_netto_konz
      ,sum(betrag_vk_netto_lgbest_erp_frei) as betrag_vk_netto_lgbest_erp_frei
      ,sum(betrag_vk_netto_lgbest_erp_frei_konz) as betrag_vk_netto_lgbest_erp_frei_konz
      ,sum(betrag_vk_netto_lgbest_erp_qual) as betrag_vk_netto_lgbest_erp_qual
      ,sum(betrag_vk_netto_lgbest_erp_qual_konz) as betrag_vk_netto_lgbest_erp_qual_konz
      ,sum(betrag_vk_netto_lgbest_erp_gesamt) as betrag_vk_netto_lgbest_erp_gesamt
      ,sum(betrag_vk_netto_lgbest_erp_gesamt_konz) as betrag_vk_netto_lgbest_erp_gesamt_konz
      ,max(ek_netto) as ek_netto
      ,max(ek_netto_konz) as ek_netto_konz
      ,sum(betrag_ek_netto_lgbest_erp_frei) as betrag_ek_netto_lgbest_erp_frei
      ,sum(betrag_ek_netto_lgbest_erp_frei_konz) as betrag_ek_netto_lgbest_erp_frei_konz
      ,sum(betrag_ek_netto_lgbest_erp_qual) as betrag_ek_netto_lgbest_erp_qual
      ,sum(betrag_ek_netto_lgbest_erp_qual_konz) as betrag_ek_netto_lgbest_erp_qual_konz
      ,max(ek_netto_bnk) as ek_netto_bnk
      ,max(ek_netto_bnk_konz) as ek_netto_bnk_konz
      ,sum(betrag_ek_netto_bnk_lgbest_erp_frei) as betrag_ek_netto_bnk_lgbest_erp_frei
      ,sum(betrag_ek_netto_bnk_lgbest_erp_frei_konz) as betrag_ek_netto_bnk_lgbest_erp_frei_konz
      ,sum(betrag_ek_netto_bnk_lgbest_erp_qual) as betrag_ek_netto_bnk_lgbest_erp_qual
      ,sum(betrag_ek_netto_bnk_lgbest_erp_qual_konz) as betrag_ek_netto_bnk_lgbest_erp_qual_konz
      ,max(ek_nettonetto) as ek_nettonetto
      ,max(ek_nettonetto_konz) as ek_nettonetto_konz
      ,sum(betrag_ek_nettonetto_lgbest_erp_frei) as betrag_ek_nettonetto_lgbest_erp_frei
      ,sum(betrag_ek_nettonetto_lgbest_erp_frei_konz) as betrag_ek_nettonetto_lgbest_erp_frei_konz
      ,sum(betrag_ek_nettonetto_lgbest_erp_qual) as betrag_ek_nettonetto_lgbest_erp_qual
      ,sum(betrag_ek_nettonetto_lgbest_erp_qual_konz) as betrag_ek_nettonetto_lgbest_erp_qual_konz
      ,max(ek_mep_olk) as ek_mep_olk
      ,max(ek_mep_olk_konz) as ek_mep_olk_konz
      ,sum(betrag_ek_mep_olk_lgbest_erp_frei) as betrag_ek_mep_olk_lgbest_erp_frei
      ,sum(betrag_ek_mep_olk_lgbest_erp_frei_konz) as betrag_ek_mep_olk_lgbest_erp_frei_konz
      ,sum(betrag_ek_mep_olk_lgbest_erp_qual) as betrag_ek_mep_olk_lgbest_erp_qual
      ,sum(betrag_ek_mep_olk_lgbest_erp_qual_konz) as betrag_ek_mep_olk_lgbest_erp_qual_konz
      ,max(ek_einstandspreis) as ek_einstandspreis
      ,max(ek_einstandspreis_konz) as ek_einstandspreis_konz
      ,sum(betrag_ek_einstandspreis_lgbest_erp_frei) as betrag_ek_einstandspreis_lgbest_erp_frei
      ,sum(betrag_ek_einstandspreis_lgbest_erp_frei_konz) as betrag_ek_einstandspreis_lgbest_erp_frei_konz
      ,sum(betrag_ek_einstandspreis_lgbest_erp_qual) as betrag_ek_einstandspreis_lgbest_erp_qual
      ,sum(betrag_ek_einstandspreis_lgbest_erp_qual_konz) as betrag_ek_einstandspreis_lgbest_erp_qual_konz
      ,max(ek_logistik) as ek_logistik
      ,max(ek_logistik_konz) as ek_logistik_konz
      ,sum(betrag_ek_logistik_lgbest_erp_gesamt) as betrag_ek_logistik_lgbest_erp_gesamt
      ,sum(betrag_ek_logistik_lgbest_erp_gesamt_konz) as betrag_ek_logistik_lgbest_erp_gesamt_konz
      ,max(current_timestamp) as td_update
      ,max(current_timestamp) as td_insert
from _lagerbestand_erp_per_step04
group by 1,2,3,4,5,6,7,8,9
);

delete from dbp_msi_data.lagerbestand_erp_tag_sum
where dat between current_date-5 and current_date
;

insert into dbp_msi_data.lagerbestand_erp_tag_sum (mandant_id
                                                  ,wup_id
                                                  ,nb_id
                                                  ,lagerort_id
                                                  ,art_id
                                                  ,dat
                                                  ,gp_id
                                                  ,posten_id
                                                  ,menge_lgbest_erp_frei_bme
                                                  ,menge_lgbest_erp_umlag_bme
                                                  ,menge_lgbest_erp_qual_bme
                                                  ,menge_lgbest_erp_nf_charge_bme
                                                  ,menge_lgbest_erp_gesp_bme
                                                  ,menge_lgbest_erp_ret_gesp_bme
                                                  ,menge_lgbest_erp_gesamt_bme
                                                  ,sperr_id
                                                  ,gjmo_buch
                                                  ,lagerort_loesch_fg
                                                  ,pflege_status
                                                  ,menge_lgbest_erp_kolli
                                                  ,menge_lgbest_erp_palette
                                                  ,wrg_id
                                                  ,vk_netto
                                                  ,betrag_vk_netto_lgbest_erp_frei
                                                  ,betrag_vk_netto_lgbest_erp_qual
                                                  ,betrag_vk_netto_lgbest_erp_gesamt
                                                  ,vk_netto_konz
                                                  ,betrag_vk_netto_lgbest_erp_frei_konz
                                                  ,betrag_vk_netto_lgbest_erp_qual_konz
                                                  ,betrag_vk_netto_lgbest_erp_gesamt_konz
                                                  ,ek_netto
                                                  ,betrag_ek_netto_lgbest_erp_frei
                                                  ,betrag_ek_netto_lgbest_erp_qual
                                                  ,ek_netto_konz
                                                  ,betrag_ek_netto_lgbest_erp_frei_konz
                                                  ,betrag_ek_netto_lgbest_erp_qual_konz
                                                  ,ek_netto_bnk
                                                  ,betrag_ek_netto_bnk_lgbest_erp_frei
                                                  ,betrag_ek_netto_bnk_lgbest_erp_qual
                                                  ,ek_netto_bnk_konz
                                                  ,betrag_ek_netto_bnk_lgbest_erp_frei_konz
                                                  ,betrag_ek_netto_bnk_lgbest_erp_qual_konz
                                                  ,ek_nettonetto
                                                  ,betrag_ek_nettonetto_lgbest_erp_frei
                                                  ,betrag_ek_nettonetto_lgbest_erp_qual
                                                  ,ek_nettonetto_konz
                                                  ,betrag_ek_nettonetto_lgbest_erp_frei_konz
                                                  ,betrag_ek_nettonetto_lgbest_erp_qual_konz
                                                  ,ek_mep_olk
                                                  ,betrag_ek_mep_olk_lgbest_erp_frei
                                                  ,betrag_ek_mep_olk_lgbest_erp_qual
                                                  ,ek_mep_olk_konz
                                                  ,betrag_ek_mep_olk_lgbest_erp_frei_konz
                                                  ,betrag_ek_mep_olk_lgbest_erp_qual_konz
                                                  ,ek_einstandspreis
                                                  ,betrag_ek_einstandspreis_lgbest_erp_frei
                                                  ,betrag_ek_einstandspreis_lgbest_erp_qual
                                                  ,ek_einstandspreis_konz
                                                  ,betrag_ek_einstandspreis_lgbest_erp_frei_konz
                                                  ,betrag_ek_einstandspreis_lgbest_erp_qual_konz
                                                  ,td_update
                                                  ,td_insert
                                                  ,ek_logistik
                                                  ,betrag_ek_logistik_lgbest_erp_gesamt
                                                  ,betrag_ek_logistik_lgbest_erp_gesamt_konz
                                                  ,ek_logistik_konz
                                                  ,umrechnungskurs_hist)
select mandant_id
      ,wup_id
      ,nb_id
      ,lagerort_id
      ,art_id
      ,dat
      ,gp_id
      ,posten_id
      ,menge_lgbest_erp_frei_bme
      ,menge_lgbest_erp_umlag_bme
      ,menge_lgbest_erp_qual_bme
      ,menge_lgbest_erp_nf_charge_bme
      ,menge_lgbest_erp_gesp_bme
      ,menge_lgbest_erp_ret_gesp_bme
      ,menge_lgbest_erp_gesamt_bme
      ,sperr_id
      ,gjmo_buch
      ,lagerort_loesch_fg
      ,pflege_status
      ,menge_lgbest_erp_kolli
      ,menge_lgbest_erp_palette
      ,wrg_id
      ,vk_netto
      ,betrag_vk_netto_lgbest_erp_frei
      ,betrag_vk_netto_lgbest_erp_qual
      ,betrag_vk_netto_lgbest_erp_gesamt
      ,vk_netto_konz
      ,betrag_vk_netto_lgbest_erp_frei_konz
      ,betrag_vk_netto_lgbest_erp_qual_konz
      ,betrag_vk_netto_lgbest_erp_gesamt_konz
      ,ek_netto
      ,betrag_ek_netto_lgbest_erp_frei
      ,betrag_ek_netto_lgbest_erp_qual
      ,ek_netto_konz
      ,betrag_ek_netto_lgbest_erp_frei_konz
      ,betrag_ek_netto_lgbest_erp_qual_konz
      ,ek_netto_bnk
      ,betrag_ek_netto_bnk_lgbest_erp_frei
      ,betrag_ek_netto_bnk_lgbest_erp_qual
      ,ek_netto_bnk_konz
      ,betrag_ek_netto_bnk_lgbest_erp_frei_konz
      ,betrag_ek_netto_bnk_lgbest_erp_qual_konz
      ,ek_nettonetto
      ,betrag_ek_nettonetto_lgbest_erp_frei
      ,betrag_ek_nettonetto_lgbest_erp_qual
      ,ek_nettonetto_konz
      ,betrag_ek_nettonetto_lgbest_erp_frei_konz
      ,betrag_ek_nettonetto_lgbest_erp_qual_konz
      ,ek_mep_olk
      ,betrag_ek_mep_olk_lgbest_erp_frei
      ,betrag_ek_mep_olk_lgbest_erp_qual
      ,ek_mep_olk_konz
      ,betrag_ek_mep_olk_lgbest_erp_frei_konz
      ,betrag_ek_mep_olk_lgbest_erp_qual_konz
      ,ek_einstandspreis
      ,betrag_ek_einstandspreis_lgbest_erp_frei
      ,betrag_ek_einstandspreis_lgbest_erp_qual
      ,ek_einstandspreis_konz
      ,betrag_ek_einstandspreis_lgbest_erp_frei_konz
      ,betrag_ek_einstandspreis_lgbest_erp_qual_konz
      ,a.td_update
      ,a.td_insert
      ,ek_logistik
      ,betrag_ek_logistik_lgbest_erp_gesamt
      ,betrag_ek_logistik_lgbest_erp_gesamt_konz
      ,ek_logistik_konz
      ,k.umrechnungskurs as umrechnungskurs_hist
from _lagerbestand_erp_per_step04 a
left join dbp_data.kurs k
  on a.wrg_id = k.von_wrg_id and
     a.dat between k.dat_von and k.dat_bis and
     k.nach_wrg_id = 'EUR' and 
     k.kurstyp_id = 3
where dat between current_date-5 and current_date
;

-- Marktbestaende

-- 11.11.2025, -dba-
--
-- Unplausible Buchungen ueber '343','344' (vornehmlich in RO)
-- werden hier durchs Setzen des Auto-Flags auf '1' respektive
-- '2' das Abgreifen durch die Bewegungsartenlogik unterbunden.
create or replace volatile table _fix_implausible_amounts as (
select mandant_id,
       dat_buch,
       art_id,
       wup_id,
       sum(menge_lagerbew_bme) as menge_frei
from dbp_data.lagerbew_det_1
where mandant_id > 1 and
     (mandant_id,wup_id) not in (select mandant_id,wup_id from dbp_data.wup_1 where nb_id = -111) and
      dat_buch >= '2025-10-01' and
     (menge_lagerbew_bme >  99999 or
      menge_lagerbew_bme < -99999) and
      auto_fg not in ('Y','1','2') and
      lager_bewart_id in ('343','344')
group by 1,2,3,4
having menge_frei = 0
);

update dbp_data.lagerbew_det_1 from (select *
                                   from _fix_implausible_amounts) b

set auto_fg = case
                when auto_fg = 'X'
                then '1'
                else '2'
              end

where dbp_data.lagerbew_det.mandant_id = b.mandant_id and
      dbp_data.lagerbew_det.wup_id = b.wup_id and
      dbp_data.lagerbew_det.art_id = b.art_id and
      dbp_data.lagerbew_det.dat_buch = b.dat_buch and
      dbp_data.lagerbew_det.lager_bewart_id in ('343','344')
;

create or replace volatile table _tracker as (
select v01.mandant_id,
       v01.wup_id
from dbp_data.wup_1 v01
where (((v01.dat_eroeffnung < current_date or
         v01.dat_eroeffnung< current_date+45) and
         v01.dat_von is not null) -- Eroeffnungsdatum in Zukunft
       or v01.nb_id <> 0
       or v01.wup_id = 9203) -- Filterung von Zentralfilialen
      and not v01.wup_id between 1 and 999 -- Filterung der IWT-Betriebe
      and v01.nb_id <> 99
);

delete from dbp_data.marktbestand_erp_1
where (mandant_id,art_id) in (select mandant_id,art_id 
                              from dbp_data.art_wg_zu_per_1
                              where arthiertyp_id = 2 and
                                    dat_bis = '9999-12-31' and
                                    wg_id = 961)
;

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
from dbp_data.tag_1
where dat between current_date-5 and current_date
group by 1
;

insert into _dat_min (dat)
select min(dat)
from dbp_data.tag_1
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
  from dbp_data.art_gp_wup_zu_per_1 a

  inner join _dat_min m
  on a.dat_bis >= m.dat) a

-- auf tag_1 auffaechern
inner join _dat d
on d.dat between a.dat_von and a.dat_bis
;

create or replace volatile table _marktbestand_erp_step01 (
	mandant_id number(38,0) not null,
	art_id number(38,0) not null,
	wup_id number(38,0) not null,
	nb_id number(38,0) not null,
	dat date not null,
	gp_id number(38,0) not null,
	bezugsweg_id number(38,0) not null,
	relevant_fg number(38,0) not null,
	posten_id varchar(2),
	menge_lgbest_erp_frei_bme number(38,3),
	menge_lgbest_erp_qual_bme number(38,3),
	menge_lgbest_erp_gesp_bme number(38,3),
	wrg_id varchar(3) not null,
	vk_netto number(38,4),
	betrag_vk_netto_lgbest_erp_frei number(38,4),
	betrag_vk_netto_lgbest_erp_qual number(38,4),
	vk_netto_konz number(38,4),
	betrag_vk_netto_lgbest_erp_frei_konz number(38,4),
	betrag_vk_netto_lgbest_erp_qual_konz number(38,4),
	ek_netto number(38,4),
	betrag_ek_netto_lgbest_erp_frei number(38,4),
	betrag_ek_netto_lgbest_erp_qual number(38,4),
	ek_netto_konz number(38,4),
	betrag_ek_netto_lgbest_erp_frei_konz number(38,4),
	betrag_ek_netto_lgbest_erp_qual_konz number(38,4),
	ek_netto_bnk number(38,4),
	betrag_ek_netto_bnk_lgbest_erp_frei number(38,4),
	betrag_ek_netto_bnk_lgbest_erp_qual number(38,4),
	ek_netto_bnk_konz number(38,4),
	betrag_ek_netto_bnk_lgbest_erp_frei_konz number(38,4),
	betrag_ek_netto_bnk_lgbest_erp_qual_konz number(38,4),
	ek_nettonetto number(38,4),
	betrag_ek_nettonetto_lgbest_erp_frei number(38,4),
	betrag_ek_nettonetto_lgbest_erp_qual number(38,4),
	ek_nettonetto_konz number(38,4),
	betrag_ek_nettonetto_lgbest_erp_frei_konz number(38,4),
	betrag_ek_nettonetto_lgbest_erp_qual_konz number(38,4),
	ek_mep_olk number(38,4),
	betrag_ek_mep_olk_lgbest_erp_frei number(38,4),
	betrag_ek_mep_olk_lgbest_erp_qual number(38,4),
	ek_mep_olk_konz number(38,4),
	betrag_ek_mep_olk_lgbest_erp_frei_konz number(38,4),
	betrag_ek_mep_olk_lgbest_erp_qual_konz number(38,4),
	ek_einstandspreis number(38,4),
	betrag_ek_einstandspreis_lgbest_erp_frei number(38,4),
	betrag_ek_einstandspreis_lgbest_erp_qual number(38,4),
	ek_einstandspreis_konz number(38,4),
	betrag_ek_einstandspreis_lgbest_erp_frei_konz number(38,4),
	betrag_ek_einstandspreis_lgbest_erp_qual_konz number(38,4),
	td_update timestamp_ltz(9),
	td_insert timestamp_ltz(9)
);

insert into _marktbestand_erp_step01
select a.mandant_id
      ,a.art_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,coalesce(x.gp_id,0) as gp_id
      ,a.bezugsweg_id
      ,a.relevant_fg
      ,null as posten_id
      ,a.menge_lgbest_erp_frei_bme
      ,a.menge_lgbest_erp_qual_bme
      ,a.menge_lgbest_erp_gesp_bme
      ,y.default_wrg
      ,0 as vk_netto
      ,0 as betrag_vk_netto_lgbest_erp_frei
      ,0 as betrag_vk_netto_lgbest_erp_qual
      ,0 as vk_netto_konz
      ,0 as betrag_vk_netto_lgbest_erp_frei_konz
      ,0 as betrag_vk_netto_lgbest_erp_qual_konz
      ,coalesce(agw.ek_netto, agww.ek_netto,0) as ek_netto
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.ek_netto, agww.ek_netto,0) as betrag_ek_netto_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.ek_netto, agww.ek_netto,0) as betrag_ek_netto_lgbest_erp_qual
      ,null as ek_netto_konz
      ,null as betrag_ek_netto_lgbest_erp_frei_konz
      ,null as betrag_ek_netto_lgbest_erp_qual_konz
      ,coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk,0) as ek_netto_bnk
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk,0) as betrag_ek_netto_bnk_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk,0) as betrag_ek_netto_bnk_lgbest_erp_qual
      ,null as ek_netto_bnk_konz
      ,null as betrag_ek_netto_bnk_lgbest_erp_frei_konz
      ,null as betrag_ek_netto_bnk_lgbest_erp_qual_konz
      ,coalesce(agw.ek_nettonetto, agww.ek_nettonetto,0) as ek_nettonetto
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.ek_nettonetto, agww.ek_nettonetto,0) as betrag_ek_nettonetto_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.ek_nettonetto, agww.ek_nettonetto,0) as betrag_ek_nettonetto_lgbest_erp_qual
      ,null as ek_nettonetto_konz
      ,null as betrag_ek_nettonetto_lgbest_erp_frei_konz
      ,null as betrag_ek_nettonetto_lgbest_erp_qual_konz
      ,coalesce(agw.ek_mep-coalesce(agw.logistikkostenzuschlag,0), agww.ek_mep-coalesce(agww.logistikkostenzuschlag,0),0) as ek_mep_olk
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.ek_mep-coalesce(agw.logistikkostenzuschlag,0), agww.ek_mep-coalesce(agww.logistikkostenzuschlag,0),0) as betrag_ek_mep_olk_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.ek_mep-coalesce(agw.logistikkostenzuschlag,0), agww.ek_mep-coalesce(agww.logistikkostenzuschlag,0),0) as betrag_ek_mep_olk_lgbest_erp_qual
      ,null as ek_mep_olk_konz
      ,null as betrag_ek_mep_olk_lgbest_erp_frei_konz
      ,null as betrag_ek_mep_olk_lgbest_erp_qual_konz
      ,coalesce(agw.einstandspreis, agww.einstandspreis,0) as ek_einstandspreis
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.einstandspreis, agww.einstandspreis,0) as betrag_ek_einstandspreis_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.einstandspreis, agww.einstandspreis,0) as betrag_ek_einstandspreis_lgbest_erp_qual
      ,null as einstandspreis_konz
      ,null as betrag_einstandspreis_lgbest_erp_frei_konz
      ,null as betrag_einstandspreis_lgbest_erp_qual_konz
      ,current_timestamp as td_update
      ,current_timestamp as td_insert
from dbp_data.marktbestand_erp_1 a

join dbp_data.mandant_1 y
  on a.mandant_id = y.mandant_id

-- lieferant und ausstiegspunkt ermitteln
left join dbp_data.art_gp_nm_zu_per_1 x
  on a.mandant_id = x.mandant_id
 and a.wup_id = x.wup_id
 and a.art_id = x.art_id 
 and a.dat between x.dat_von and x.dat_bis 
          
-- betriebsspezifischer ek preis 
left join _vol_art_gp_wup_zu_per agw
  on x.mandant_id   = agw.mandant_id 
 and x.vz_wup_id = agw.wup_id 
 and x.art_id    = agw.art_id
 and x.gp_id     = agw.gp_id 
 and a.dat       = agw.dat
        
-- betriebsuebergreifender ek preis
left join _vol_art_gp_wup_zu_per agww
  on x.mandant_id = agww.mandant_id 
 and -1        = agww.wup_id 
 and x.art_id  = agww.art_id
 and x.gp_id   = agww.gp_id 
 and a.dat     = agww.dat

where a.mandant_id > 1 and
      a.dat between current_date-5 and current_date
;

insert into _marktbestand_erp_step01
select a.mandant_id
      ,a.art_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,coalesce(x.gp_id,0) as gp_id
      ,a.bezugsweg_id
      ,a.relevant_fg
      ,null as posten_id
      ,a.menge_lgbest_erp_frei_bme
      ,a.menge_lgbest_erp_qual_bme
      ,a.menge_lgbest_erp_gesp_bme
      ,y.default_wrg
      ,0 as vk_netto
      ,0 as betrag_vk_netto_lgbest_erp_frei
      ,0 as betrag_vk_netto_lgbest_erp_qual
      ,0 as vk_netto_konz
      ,0 as betrag_vk_netto_lgbest_erp_frei_konz
      ,0 as betrag_vk_netto_lgbest_erp_qual_konz
      ,coalesce(agw.ek_netto, agww.ek_netto, agwww.ek_netto,0) as ek_netto
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.ek_netto, agww.ek_netto, agwww.ek_netto,0) as betrag_ek_netto_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.ek_netto, agww.ek_netto, agwww.ek_netto,0) as betrag_ek_netto_lgbest_erp_qual
      ,null as ek_netto_konz
      ,null as betrag_ek_netto_lgbest_erp_frei_konz
      ,null as betrag_ek_netto_lgbest_erp_qual_konz
      ,coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk, agwww.ek_netto_bnk, 0) as ek_netto_bnk
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk, agwww.ek_netto_bnk,0) as betrag_ek_netto_bnk_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.ek_netto_bnk, agww.ek_netto_bnk, agwww.ek_netto_bnk,0) as betrag_ek_netto_bnk_lgbest_erp_qual
      ,null as ek_netto_bnk_konz
      ,null as betrag_ek_netto_bnk_lgbest_erp_frei_konz
      ,null as betrag_ek_netto_bnk_lgbest_erp_qual_konz
      ,coalesce(agw.ek_nettonetto, agww.ek_nettonetto, agwww.ek_nettonetto,0) as ek_nettonetto
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.ek_nettonetto, agww.ek_nettonetto, agwww.ek_nettonetto,0) as betrag_ek_nettonetto_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.ek_nettonetto, agww.ek_nettonetto, agwww.ek_nettonetto,0) as betrag_ek_nettonetto_lgbest_erp_qual
      ,null as ek_nettonetto_konz
      ,null as betrag_ek_nettonetto_lgbest_erp_frei_konz
      ,null as betrag_ek_nettonetto_lgbest_erp_qual_konz
      ,coalesce(agw.ek_mep-coalesce(agw.logistikkostenzuschlag,0), agww.ek_mep-coalesce(agww.logistikkostenzuschlag,0), agwww.ek_mep-coalesce(agwww.logistikkostenzuschlag,0),0) as ek_mep_olk
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.ek_mep-coalesce(agw.logistikkostenzuschlag,0), agww.ek_mep-coalesce(agww.logistikkostenzuschlag,0), agwww.ek_mep-coalesce(agwww.logistikkostenzuschlag,0),0) as betrag_ek_mep_olk_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.ek_mep-coalesce(agw.logistikkostenzuschlag,0), agww.ek_mep-coalesce(agww.logistikkostenzuschlag,0), agwww.ek_mep-coalesce(agwww.logistikkostenzuschlag,0),0) as betrag_ek_mep_olk_lgbest_erp_qual
      ,null as ek_mep_olk_konz
      ,null as betrag_ek_mep_olk_lgbest_erp_frei_konz
      ,null as betrag_ek_mep_olk_lgbest_erp_qual_konz
      ,coalesce(agw.einstandspreis, agww.einstandspreis, agwww.einstandspreis,0) as ek_einstandspreis
      ,a.menge_lgbest_erp_frei_bme * coalesce(agw.einstandspreis, agww.einstandspreis, agwww.einstandspreis,0) as betrag_ek_einstandspreis_lgbest_erp_frei
      ,a.menge_lgbest_erp_qual_bme * coalesce(agw.einstandspreis, agww.einstandspreis, agwww.einstandspreis,0) as betrag_ek_einstandspreis_lgbest_erp_qual
      ,null as einstandspreis_konz
      ,null as betrag_einstandspreis_lgbest_erp_frei_konz
      ,null as betrag_einstandspreis_lgbest_erp_qual_konz
      ,current_timestamp as td_update
      ,current_timestamp as td_insert

from dbp_data.marktbestand_erp_1 a
join dbp_data.mandant_1 y
  on a.mandant_id = y.mandant_id

-- lieferant und ausstiegspunkt ermitteln
left join dbp_data.art_gp_nm_zu_per_1 x
 on a.mandant_id = x.mandant_id and 
    a.wup_id = x.wup_id and 
    a.art_id = x.art_id and 
    a.dat between x.dat_von and x.dat_bis

left join dbp_data.ek_orderbuch_1 xxx_1
  on a.mandant_id = xxx.mandant_id and 
     x.gp_id = xxx.wup_id and 
     a.art_id = xxx.art_id and 
     a.dat between xxx.dat_von and xxx.dat_bis

-- betriebsuebergreifender ek preis
left join _vol_art_gp_wup_zu_per agwww
  on x.mandant_id = agwww.mandant_id and 
     x.gp_id        = agwww.wup_id and
     x.art_id  = agwww.art_id and 
     coalesce(xxx.gp_id,x.gp_id)   = agwww.gp_id and 
     a.dat     = agwww.dat

-- betriebsspezifischer ek preis
left join _vol_art_gp_wup_zu_per agw
  on x.mandant_id   = agw.mandant_id and 
     x.vz_wup_id = agw.wup_id and 
     x.art_id    = agw.art_id and 
     coalesce(xxx.gp_id,x.gp_id)     = agw.gp_id and
     a.dat       = agw.dat

-- betriebsuebergreifender ek preis
left join _vol_art_gp_wup_zu_per agww
  on x.mandant_id = agww.mandant_id and 
     -1        = agww.wup_id and 
     x.art_id  = agww.art_id and 
     x.gp_id   = agww.gp_id and 
     a.dat     = agww.dat

where a.mandant_id = 1 and
      a.dat between current_date-5 and current_date
;

create or replace volatile table _tage as (
select dat
from _marktbestand_erp_step01
group by 1
);

create or replace volatile table _min_tage as (
select min(dat) as min_dat
from _marktbestand_erp_step01
);

create or replace volatile table _art_wup_zu_per as (
select a.*,
       b.dat
from (select a.*
      from dbp_data.art_wup_zu_per_1 a
      join _min_tage b
        on a.dat_bis >= b.min_dat) a
join _tage b
  on b.dat between a.dat_von AND a.dat_bis
);

create or replace volatile table _mwst_per as (
select a.*,
       b.dat
from (select a.*
      from dbp_data.mwst_per_1 a
      join _min_tage b
        on a.dat_bis >= b.min_dat) a
join _tage b
  on b.dat between a.dat_von AND a.dat_bis
);

create or replace volatile table _art_per as (
select a.*,
       b.dat
from (select a.*
      from dbp_data.art_per_1 a
      join _min_tage b
        on a.dat_bis >= b.min_dat) a
join _tage b
  on b.dat between a.dat_von AND a.dat_bis
);

update _marktbestand_erp_step01 from (select a.mandant_id as _mandant_id,
                                             a.wup_id as _wup_id,
                                             a.art_id as _art_id,
                                             a.dat as _dat,
                                             b.posten_id as _posten_id,
                                             case when c.mwst is not null then cast(a.vk_brutto/(1+(c.mwst/100)) as decimal(18,6)) else a.vk_brutto end as _vk_netto
                                      from _art_wup_zu_per a
                                      left join _art_per b
                                        on a.mandant_id = b.mandant_id and
                                           a.art_id = b.art_id and
                                           a.dat = b.dat
                                      left join _mwst_per c
                                        on a.mandant_id = c.mandant_id and
                                           b.mwst_id = c.mwst_id and
                                           a.dat = c.dat) b
                                           
set vk_netto = _vk_netto,
    betrag_vk_netto_lgbest_erp_frei = menge_lgbest_erp_frei_bme * _vk_netto,
    betrag_vk_netto_lgbest_erp_qual = menge_lgbest_erp_qual_bme * _vk_netto,
    posten_id = _posten_id
    
where dat = _dat and
      mandant_id = _mandant_id and
      art_id = _art_id and
      wup_id = _wup_id
;

create or replace volatile table _marktbestand_erp_step02 as (
select a.mandant_id
      ,a.art_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.gp_id
      ,a.bezugsweg_id
      ,a.relevant_fg
      ,a.posten_id
      ,a.menge_lgbest_erp_frei_bme
      ,a.menge_lgbest_erp_qual_bme
      ,a.menge_lgbest_erp_gesp_bme
      ,a.wrg_id
      ,a.vk_netto
      ,a.betrag_vk_netto_lgbest_erp_frei
      ,a.betrag_vk_netto_lgbest_erp_qual
      ,a.vk_netto*d1.umrechnungskurs as vk_netto_konz
      ,a.betrag_vk_netto_lgbest_erp_frei*d1.umrechnungskurs as betrag_vk_netto_lgbest_erp_frei_konz
      ,a.betrag_vk_netto_lgbest_erp_qual*d1.umrechnungskurs as betrag_vk_netto_lgbest_erp_qual_konz
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
      ,a.ek_mep_olk
      ,a.betrag_ek_mep_olk_lgbest_erp_frei
      ,a.betrag_ek_mep_olk_lgbest_erp_qual
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
from _marktbestand_erp_step01 a
join dbp_data.kurs_1 d1
  on a.wrg_id = d1.von_wrg_id and
     d1.dat_bis = '9999-12-31' and
     d1.nach_wrg_id = 'EUR' and
     d1.kurstyp_id = 3
);

delete from dbp_msi_data.marktbestand_erp_tag_sum_1
where dat between current_date-5 and current_date
;

insert into dbp_msi_data.marktbestand_erp_tag_sum_1 (mandant_id
                                                  ,art_id
                                                  ,wup_id
                                                  ,nb_id
                                                  ,dat
                                                  ,gp_id
                                                  ,bezugsweg_id
                                                  ,relevant_fg
                                                  ,posten_id
                                                  ,menge_lgbest_erp_frei_bme
                                                  ,menge_lgbest_erp_qual_bme
                                                  ,menge_lgbest_erp_gesp_bme
                                                  ,wrg_id
                                                  ,vk_netto
                                                  ,betrag_vk_netto_lgbest_erp_frei
                                                  ,betrag_vk_netto_lgbest_erp_qual
                                                  ,vk_netto_konz
                                                  ,betrag_vk_netto_lgbest_erp_frei_konz
                                                  ,betrag_vk_netto_lgbest_erp_qual_konz
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
                                                  ,umrechnungskurs_hist)
select mandant_id
      ,art_id
      ,wup_id
      ,nb_id
      ,dat
      ,gp_id
      ,bezugsweg_id
      ,relevant_fg
      ,posten_id
      ,menge_lgbest_erp_frei_bme
      ,menge_lgbest_erp_qual_bme
      ,menge_lgbest_erp_gesp_bme
      ,wrg_id
      ,vk_netto
      ,betrag_vk_netto_lgbest_erp_frei
      ,betrag_vk_netto_lgbest_erp_qual
      ,vk_netto_konz
      ,betrag_vk_netto_lgbest_erp_frei_konz
      ,betrag_vk_netto_lgbest_erp_qual_konz
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
      ,k.umrechnungskurs as umrechnungskurs_hist
from _marktbestand_erp_step02 a
left join dbp_data.kurs_1 k
  on a.wrg_id = k.von_wrg_id and
     a.dat between k.dat_von and k.dat_bis and
     k.nach_wrg_id = 'EUR' and 
     k.kurstyp_id = 3
where (a.mandant_id,a.wup_id) in (select mandant_id,wup_id from _tracker)
;

create or replace volatile table _zeitraum as (
select a.dat,
       a.kjmo
from dbp_data.tag a
join (select kjmo
      from dbp_data.tag
      where akt_mo between (select akt_mo from dbp_etl_process.fww_gld_zeitraum) and 0
      group by 1) b 
  on a.kjmo = b.kjmo
where a.dat < current_date
);

create or replace volatile table _perf1 as (
select t1.mandant_id,
       t1.art_id,
       t1.bewart_id,
       t1.bewart_det_id,
       t1.wup_id,
       t1.nb_id,
       t1.dat,
       sum(t1.umsatz_netto) as umsatz_netto,
       sum(t1.logkostenzuschlag) as logkostenzuschlag,
       sum(case
             when t1.mandant_id = 1
             then cast(t1.ek_mep as decimal(18,4))
             when t1.mandant_id > 1 and
                  t2.wg_id = 969 and
                  t2.wug_id between 1 and 4
             then cast(t1.ek_mep as decimal(18,4))
             else coalesce(t1.ek_gld,0)
           end) as ek_mep_einstandspreis,
       sum(case
             when t1.mandant_id = 1
             then cast(t1.ek_mep_vor_fwu as decimal(18,4))
             when t1.mandant_id > 1 and
                  t2.wg_id = 969 and
                  t2.wug_id between 1 and 4
             then cast(t1.ek_mep_vor_fwu as decimal(18,4))
             else coalesce(t1.ek_gld,0)
           end) as ek_mep_einstandspreis_fwu,
       sum(t1.menge) as menge
from dbp_data.artbew t1
join dbp_data.art_wg_zu_per t2
  on t1.mandant_id = t2.mandant_id and
     t1.art_id = t2.art_id and
     t2.arthiertyp_id = 2 and
     t2.dat_bis = '9999-12-31'
where t1.dat between (select min(dat) from _zeitraum) and (select max(dat) from _zeitraum)
group by 1,2,3,4,5,6,7
);

create or replace volatile table _perf2 as (
select x.mandant_id,
       x.art_id,
       x.dat_von,
       x.dat_bis,
       x.betrag_kmep_einh as bonus_stk,
       x.betrag_kmep_einh_o_fwu as bonus_stk_fwu
from (select u.*
      from dbp_etl_process.ekc_artbew_kmep u
      where u.zeitraum_kz = 'KM') x
);

create or replace volatile table _perf3 as (
select x.mandant_id,
       x.art_id,
       x.dat_von,
       x.dat_bis,
       x.betrag_kmep_einh as bonus_stk,
       x.betrag_kmep_einh_o_fwu as bonus_stk_fwu
from (select u.*
      from dbp_etl_process.ekc_artbew_kmep u
      where u.zeitraum_kz = 'KW') x
);

create or replace volatile table _perf4 as (
select x.mandant_id,
       x.art_id,
       x.dat_von,
       x.dat_bis,
       x.betrag_kmep_einh as bonus_stk,
       x.betrag_kmep_einh_o_fwu as bonus_stk_fwu
from (select u.*
      from dbp_etl_process.ekc_artbew_kmep u
      where u.zeitraum_kz = 'WW') x
);

create or replace volatile table _perf5 as (
select a.mandant_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       sum(a.umsatz_netto) as umsatz_netto_,
       sum(a.logkostenzuschlag) as logkostenzuschlag,
       sum(a.ek_mep_einstandspreis) as ek_mep_einstandspreis_,
       sum(a.menge) as menge_,
       sum(coalesce(b.bonus_stk,0)) as bonus_stk_,
       sum(coalesce(c.bonus_stk,0)) as bonus_stk_kw_,
       sum(coalesce(d.bonus_stk,0)) as bonus_stk_ww_,
       umsatz_netto_-ek_mep_einstandspreis_+(menge_*bonus_stk_) as ek_mep_einstandspreis__,
       umsatz_netto_-ek_mep_einstandspreis_+(menge_*bonus_stk_kw_) as wa_kalk_kw_,
       umsatz_netto_-ek_mep_einstandspreis_+(menge_*bonus_stk_ww_) as wa_kalk_ww_,
       sum(coalesce(b.bonus_stk_fwu,0)) as bonus_stk_fwu_,
       sum(coalesce(c.bonus_stk_fwu,0)) as bonus_stk_fwu_kw_,
       sum(coalesce(d.bonus_stk_fwu,0)) as bonus_stk_fwu_ww_,
       umsatz_netto_-sum(a.ek_mep_einstandspreis_fwu)+(menge_*bonus_stk_fwu_) as ek_mep_einstandspreis_fwu__,
       umsatz_netto_-sum(a.ek_mep_einstandspreis_fwu)+(menge_*bonus_stk_fwu_kw_) as wa_kalk_fwu_kw_,
       umsatz_netto_-sum(a.ek_mep_einstandspreis_fwu)+(menge_*bonus_stk_fwu_ww_) as wa_kalk_fwu_ww_
from _perf1 a
left join _perf2 b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.dat between b.dat_von and b.dat_bis
left join _perf3 c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     a.dat between c.dat_von and c.dat_bis
left join _perf4 d
  on a.mandant_id = d.mandant_id and
     a.art_id = d.art_id and
     a.dat between d.dat_von and d.dat_bis
group by 1,2,3,4,5,6,7
);

delete from dbp_etl_process.ekc_artbew
where dat between (select min(dat) from _zeitraum) and (select max(dat) from _zeitraum)
;

insert into dbp_etl_process.ekc_artbew (mandant_id
                                       ,art_id
                                       ,bewart_id
                                       ,bewart_det_id
                                       ,wup_id
                                       ,nb_id
                                       ,dat
                                       ,umsatz_netto_
                                       ,logkostenzuschlag
                                       ,ek_mep_einstandspreis_
                                       ,menge_
                                       ,bonus_stk_
                                       ,bonus_stk_kw_
                                       ,bonus_stk_ww_
                                       ,ek_mep_einstandspreis__
                                       ,wa_kalk_kw_
                                       ,wa_kalk_ww_ 
                                       ,bonus_stk_fwu_
                                       ,bonus_stk_fwu_kw_
                                       ,bonus_stk_fwu_ww_
                                       ,ek_mep_einstandspreis_fwu__
                                       ,wa_kalk_fwu_kw_
                                       ,wa_kalk_fwu_ww_)
select mandant_id
      ,art_id
      ,bewart_id
      ,bewart_det_id
      ,wup_id
      ,nb_id
      ,dat
      ,umsatz_netto_
      ,logkostenzuschlag
      ,ek_mep_einstandspreis_
      ,menge_
      ,bonus_stk_
      ,bonus_stk_kw_
      ,bonus_stk_ww_
      ,ek_mep_einstandspreis__
      ,wa_kalk_kw_
      ,wa_kalk_ww_ 
      ,bonus_stk_fwu_
      ,bonus_stk_fwu_kw_
      ,bonus_stk_fwu_ww_
      ,ek_mep_einstandspreis_fwu__
      ,wa_kalk_fwu_kw_
      ,wa_kalk_fwu_ww_
from _perf5
;

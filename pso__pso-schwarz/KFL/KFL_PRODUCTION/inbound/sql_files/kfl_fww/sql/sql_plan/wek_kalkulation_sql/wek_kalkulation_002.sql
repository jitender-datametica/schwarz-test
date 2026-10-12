create or replace table dbp_etl.tag_wa_kalk_final_pl (
      mandant_id byteint,
      art_id integer,
      bewart_id smallint,
      bewart_det_id integer,
      wup_id integer,
      nb_id smallint,
      dat date,
      wrg_id char(3) collate 'en-ci',
      zek_id varchar(3),
      eigenmarke_fg byteint,
      wup_bereinigt_fg byteint,
      umsatz_netto decimal(18,4),
      umsatz_netto_vj decimal(18,4),
      umsatz_netto_vj_km decimal(18,4),
      logkostenzuschlag decimal(18,4),
      logkostenzuschlag_vj decimal(18,4),
      logkostenzuschlag_vj_km decimal(18,4),
      betrag_kmep_km float,
      betrag_kmep_km_vj float,
      betrag_kmep_kw float,
      betrag_kmep_kw_vj float,
      betrag_kmep_ww float,
      betrag_kmep_ww_vj float,
      werbe_abschrift_netto decimal(18,4) not null,
      werbe_abschrift_netto_vj decimal(18,4) not null,
      werbe_abschrift_netto_vj_km decimal(18,4) not null,
      preis_abschrift_netto decimal(18,4) not null,
      preis_abschrift_netto_vj decimal(18,4) not null,
      preis_abschrift_netto_vj_km decimal(18,4) not null,
      betrag_kmep_o_fwu_km float,
      betrag_kmep_o_fwu_km_vj float,
      betrag_kmep_o_fwu_kw float,
      betrag_kmep_o_fwu_kw_vj float,
      betrag_kmep_o_fwu_ww float,
      betrag_kmep_o_fwu_ww_vj float,
      umrechnungskurs_hist number(38,5)
);

create or replace table dbp_etl.monat_wa_kalk_final_pl (
    mandant_id number(38,0),
    art_id number(38,0),
    bewart_id number(38,0),
    wup_id number(38,0),
    nb_id number(38,0),
    kjmo number(38,0),
    wrg_id varchar(3) collate 'en-ci',
    posten_id varchar(2) collate 'en-ci',
    wup_bereinigt_fg number(38,0),
    zek_id varchar(3),
    eigenmarke_fg number(38,0),
    gp_id number(38,0),
    umsatz_netto number(18,4),
    umsatz_netto_vj number(18,4),
    betrag_kmep number(18,4),
    betrag_kmep_vj number(18,4),
    logkostenzuschlag number(18,4),
    logkostenzuschlag_vj number(18,4),
    werbe_abschrift_netto number(18,4),
    werbe_abschrift_netto_vj number(18,4),
    preis_abschrift_netto number(18,2),
    preis_abschrift_netto_vj number(18,2),
    bewart_det_id number(38,0),
    betrag_kmep_o_fwu number(18,4),
    betrag_kmep_o_fwu_vj number(18,4),
    umrechnungskurs_hist number(38,5)
);

insert into dbp_etl.tag_wa_kalk_final_pl (mandant_id
                                         ,art_id
                                         ,bewart_id
                                         ,bewart_det_id
                                         ,wup_id
                                         ,nb_id
                                         ,dat
                                         ,wrg_id
                                         ,zek_id
                                         ,eigenmarke_fg
                                         ,wup_bereinigt_fg
                                         ,umrechnungskurs_hist
                                         ,umsatz_netto
                                         ,umsatz_netto_vj
                                         ,umsatz_netto_vj_km
                                         ,logkostenzuschlag
                                         ,logkostenzuschlag_vj
                                         ,logkostenzuschlag_vj_km
                                         ,betrag_kmep_km
                                         ,betrag_kmep_km_vj
                                         ,betrag_kmep_kw
                                         ,betrag_kmep_kw_vj
                                         ,betrag_kmep_ww
                                         ,betrag_kmep_ww_vj
                                         ,werbe_abschrift_netto
                                         ,werbe_abschrift_netto_vj
                                         ,werbe_abschrift_netto_vj_km
                                         ,preis_abschrift_netto
                                         ,preis_abschrift_netto_vj
                                         ,preis_abschrift_netto_vj_km
                                         ,betrag_kmep_o_fwu_km
                                         ,betrag_kmep_o_fwu_km_vj
                                         ,betrag_kmep_o_fwu_kw
                                         ,betrag_kmep_o_fwu_kw_vj
                                         ,betrag_kmep_o_fwu_ww
                                         ,betrag_kmep_o_fwu_ww_vj)
select z.mandant_id
      ,z.art_id
      ,z.bewart_id
      ,z.bewart_det_id
      ,z.wup_id
      ,z.nb_id
      ,z.dat
      ,z.wrg_id
      ,z.zek_id
      ,z.eigenmarke_fg
      ,z.wup_bereinigt_fg
      ,sum(0)
      ,sum(z.umsatz_netto)
      ,sum(z.umsatz_netto_vj)
      ,sum(z.umsatz_netto_vj_km)
      ,sum(z.logkostenzuschlag)
      ,sum(z.logkostenzuschlag_vj)
      ,sum(z.logkostenzuschlag_vj_km)
      ,sum(z.betrag_kmep_km)
      ,sum(z.betrag_kmep_km_vj)
      ,sum(z.betrag_kmep_kw)
      ,sum(z.betrag_kmep_kw_vj)
      ,sum(z.betrag_kmep_ww)
      ,sum(z.betrag_kmep_ww_vj)
      ,sum(z.werbe_abschrift_netto)
      ,sum(z.werbe_abschrift_netto_vj)
      ,sum(z.werbe_abschrift_netto_vj_km)
      ,sum(z.preis_abschrift_netto)
      ,sum(z.preis_abschrift_netto_vj)
      ,sum(z.preis_abschrift_netto_vj_km)
      ,sum(z.betrag_kmep_o_fwu_km)
      ,sum(z.betrag_kmep_o_fwu_km_vj)
      ,sum(z.betrag_kmep_o_fwu_kw)
      ,sum(z.betrag_kmep_o_fwu_kw_vj)
      ,sum(z.betrag_kmep_o_fwu_ww)
      ,sum(z.betrag_kmep_o_fwu_ww_vj)
from (
select a.mandant_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       b.default_wrg as wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 as wup_bereinigt_fg,
       a.umsatz_netto_ as umsatz_netto,
       cast(0 as decimal(18,4)) as umsatz_netto_vj,
       cast(0 as decimal(18,4)) as umsatz_netto_vj_km,
       a.logkostenzuschlag,
       cast(0 as decimal(18,4)) as logkostenzuschlag_vj,
       cast(0 as decimal(18,4)) as logkostenzuschlag_vj_km,
       a.umsatz_netto_-a.ek_mep_einstandspreis__ as betrag_kmep_km,
       cast(0 as float) as betrag_kmep_km_vj,
       a.umsatz_netto_-a.wa_kalk_kw_ as betrag_kmep_kw,
       cast(0 as float) as betrag_kmep_kw_vj,
       a.umsatz_netto_-a.wa_kalk_ww_ as betrag_kmep_ww,
       cast(0 as float) as betrag_kmep_ww_vj,
       cast(0 as decimal(18,4)) as werbe_abschrift_netto,
       cast(0 as decimal(18,4)) as werbe_abschrift_netto_vj,
       cast(0 as decimal(18,4)) as werbe_abschrift_netto_vj_km,
       cast(0 as decimal(18,4)) as preis_abschrift_netto,
       cast(0 as decimal(18,4)) as preis_abschrift_netto_vj,
       cast(0 as decimal(18,4)) as preis_abschrift_netto_vj_km,
       a.umsatz_netto_-a.ek_mep_einstandspreis_fwu__ as betrag_kmep_o_fwu_km,
       cast(0 as float) as betrag_kmep_o_fwu_km_vj,
       a.umsatz_netto_-a.wa_kalk_fwu_kw_ as betrag_kmep_o_fwu_kw,
       cast(0 as float) as betrag_kmep_o_fwu_kw_vj,
       a.umsatz_netto_-a.wa_kalk_fwu_ww_ as betrag_kmep_o_fwu_ww,
       cast(0 as float) as betrag_kmep_o_fwu_ww_vj
from dbp_etl_process.ekc_artbew a
join dbp_data.mandant b
  on a.mandant_id = b.mandant_id
join dbp_etl_process.ekc_zek c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id
where a.dat between (select min(dat) from dbp_etl.zeitraum_fww_kmo_gld) and (select max(dat) from dbp_etl.zeitraum_fww_kmo_gld) and
      a.mandant_id = 3
union all
select a.mandant_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.wup_id,
       a.nb_id,
       a.dat+364 as dat,
       b.default_wrg as wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 as wup_bereinigt_fg,
       0 as umsatz_netto,
       a.umsatz_netto_ as umsatz_netto_vj,
       0 as umsatz_netto_vj_km,
       0 as logkostenzuschlag,
       a.logkostenzuschlag as logkostenzuschlag_vj,
       0 as logkostenzuschlag_vj_km,
       0 as betrag_kmep_km,
       0 as betrag_kmep_km_vj,
       0 as betrag_kmep_kw,
       a.umsatz_netto_-a.wa_kalk_kw_ as betrag_kmep_kw_vj,
       0 as betrag_kmep_ww,
       a.umsatz_netto_-a.wa_kalk_ww_ as betrag_kmep_ww_vj,
       0 as werbe_abschrift_netto,
       0 as werbe_abschrift_netto_vj,
       0 as werbe_abschrift_netto_vj_km,
       0 as preis_abschrift_netto,
       0 as preis_abschrift_netto_vj,
       0 as preis_abschrift_netto_vj_km,
       0 as betrag_kmep_o_fwu_km,
       0 as betrag_kmep_o_fwu_km_vj,
       0 as betrag_kmep_o_fwu_kw,
       a.umsatz_netto_-a.wa_kalk_fwu_kw_ as betrag_kmep_o_fwu_kw_vj,
       0 as betrag_kmep_o_fwu_ww,
       a.umsatz_netto_-a.wa_kalk_fwu_ww_ as betrag_kmep_o_fwu_ww_vj
from dbp_etl_process.ekc_artbew a
join dbp_data.mandant b
  on a.mandant_id = b.mandant_id
join dbp_etl_process.ekc_zek c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id
where a.dat between (select min(dat)-364 from dbp_etl.zeitraum_fww_kmo_gld) and (select max(dat)-364 from dbp_etl.zeitraum_fww_kmo_gld) and
      a.mandant_id = 3
union all
select a.mandant_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.wup_id,
       a.nb_id,
       a.dat+x.days_back as dat,
       b.default_wrg as wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 as wup_bereinigt_fg,
       0 as umsatz_netto,
       0 as umsatz_netto_vj,
       a.umsatz_netto_ as umsatz_netto_vj_km,
       0 as logkostenzuschlag,
       0 as logkostenzuschlag_vj,
       a.logkostenzuschlag as logkostenzuschlag_vj_km,
       0 as betrag_kmep_km,
       a.umsatz_netto_-a.ek_mep_einstandspreis__ as betrag_kmep_km_vj,
       0 as betrag_kmep_kw,
       0 as betrag_kmep_kw_vj,
       0 as betrag_kmep_ww,
       0 as betrag_kmep_ww_vj,
       0 as werbe_abschrift_netto,
       0 as werbe_abschrift_netto_vj,
       0 as werbe_abschrift_netto_vj_km,
       0 as preis_abschrift_netto,
       0 as preis_abschrift_netto_vj,
       0 as preis_abschrift_netto_vj_km,
       0 as betrag_kmep_o_fwu_km,
       a.umsatz_netto_-a.ek_mep_einstandspreis_fwu__ as betrag_kmep_o_fwu_km_vj,
       0 as betrag_kmep_o_fwu_kw,
       0 as betrag_kmep_o_fwu_kw_vj,
       0 as betrag_kmep_o_fwu_ww,
       0 as betrag_kmep_o_fwu_ww_vj
from dbp_etl_process.ekc_artbew a
join dbp_data.mandant b
  on a.mandant_id = b.mandant_id
join dbp_etl_process.ekc_zek c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id
join dbp_etl.zeitraum_fww_kmo_gld x
  on a.dat = x.dat-x.days_back
where a.dat+x.days_back not in (select dat from dbp_etl.zeitraum_fww_kmo_gld where sj = 1) and
      a.mandant_id = 3
union all
select a.mandant_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.wup_id,
       a.nb_id,
       a.dat+x.days_back-1 as dat,
       b.default_wrg as wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 as wup_bereinigt_fg,
       0 as umsatz_netto,
       0 as umsatz_netto_vj,
       a.umsatz_netto_ as umsatz_netto_vj_km,
       0 as logkostenzuschlag,
       0 as logkostenzuschlag_vj,
       a.logkostenzuschlag as logkostenzuschlag_vj_km,
       0 as betrag_kmep_km,
       a.umsatz_netto_-a.ek_mep_einstandspreis__ as betrag_kmep_km_vj,
       0 as betrag_kmep_kw,
       0 as betrag_kmep_kw_vj,
       0 as betrag_kmep_ww,
       0 as betrag_kmep_ww_vj,
       0 as werbe_abschrift_netto,
       0 as werbe_abschrift_netto_vj,
       0 as werbe_abschrift_netto_vj_km,
       0 as preis_abschrift_netto,
       0 as preis_abschrift_netto_vj,
       0 as preis_abschrift_netto_vj_km,
       0 as betrag_kmep_o_fwu_km,
       a.umsatz_netto_-a.ek_mep_einstandspreis_fwu__ as betrag_kmep_o_fwu_km_vj,
       0 as betrag_kmep_o_fwu_kw,
       0 as betrag_kmep_o_fwu_kw_vj,
       0 as betrag_kmep_o_fwu_ww,
       0 as betrag_kmep_o_fwu_ww_vj
from dbp_etl_process.ekc_artbew a
join dbp_data.mandant b
  on a.mandant_id = b.mandant_id
join dbp_etl_process.ekc_zek c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id
join dbp_etl.zeitraum_fww_kmo_gld x
  on a.dat = x.dat-x.days_back+1 and
     x.sj = -1
where a.mandant_id = 3) z
group by 1,2,3,4,5,6,7,8,9,10,11
;

insert into dbp_etl.tag_wa_kalk_final_pl (mandant_id
                                         ,art_id
                                         ,bewart_id
                                         ,bewart_det_id
                                         ,wup_id
                                         ,nb_id
                                         ,dat
                                         ,wrg_id
                                         ,wup_bereinigt_fg
                                         ,zek_id
                                         ,eigenmarke_fg
                                         ,umrechnungskurs_hist
                                         ,umsatz_netto
                                         ,umsatz_netto_vj
                                         ,umsatz_netto_vj_km
                                         ,logkostenzuschlag
                                         ,logkostenzuschlag_vj
                                         ,logkostenzuschlag_vj_km
                                         ,betrag_kmep_km
                                         ,betrag_kmep_km_vj
                                         ,betrag_kmep_kw
                                         ,betrag_kmep_kw_vj
                                         ,betrag_kmep_ww
                                         ,betrag_kmep_ww_vj
                                         ,werbe_abschrift_netto
                                         ,werbe_abschrift_netto_vj
                                         ,werbe_abschrift_netto_vj_km
                                         ,preis_abschrift_netto
                                         ,preis_abschrift_netto_vj
                                         ,preis_abschrift_netto_vj_km
                                         ,betrag_kmep_o_fwu_km
                                         ,betrag_kmep_o_fwu_km_vj
                                         ,betrag_kmep_o_fwu_kw
                                         ,betrag_kmep_o_fwu_kw_vj
                                         ,betrag_kmep_o_fwu_ww
                                         ,betrag_kmep_o_fwu_ww_vj)
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.wrg_id
      ,1 as wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.umrechnungskurs_hist
      ,a.umsatz_netto
      ,a.umsatz_netto_vj
      ,a.umsatz_netto_vj_km
      ,a.logkostenzuschlag
      ,a.logkostenzuschlag_vj
      ,a.logkostenzuschlag_vj_km
      ,a.betrag_kmep_km
      ,a.betrag_kmep_km_vj
      ,a.betrag_kmep_kw
      ,a.betrag_kmep_kw_vj
      ,a.betrag_kmep_ww
      ,a.betrag_kmep_ww_vj
      ,a.werbe_abschrift_netto
      ,a.werbe_abschrift_netto_vj
      ,a.werbe_abschrift_netto_vj_km
      ,a.preis_abschrift_netto
      ,a.preis_abschrift_netto_vj
      ,a.preis_abschrift_netto_vj_km
      ,a.betrag_kmep_o_fwu_km
      ,a.betrag_kmep_o_fwu_km_vj
      ,a.betrag_kmep_o_fwu_kw
      ,a.betrag_kmep_o_fwu_kw_vj
      ,a.betrag_kmep_o_fwu_ww
      ,a.betrag_kmep_o_fwu_ww_vj
from dbp_etl.tag_wa_kalk_final_pl a
join dbp_data.tag x1
  on a.dat = x1.dat
join dbp_data.wup x2
  on a.mandant_id = x2.mandant_id and 
     a.nb_id = x2.nb_id and 
     a.wup_id = x2.wup_id
where x1.wo_dat_von >= add_months(x2.dat_von,12) and
      x1.wo_dat_bis <= x2.dat_bis
;

insert into dbp_etl.tag_wa_kalk_final_pl (mandant_id
                                         ,art_id
                                         ,bewart_id
                                         ,bewart_det_id
                                         ,wup_id
                                         ,nb_id
                                         ,dat
                                         ,wrg_id
                                         ,wup_bereinigt_fg
                                         ,zek_id
                                         ,eigenmarke_fg
                                         ,umrechnungskurs_hist
                                         ,umsatz_netto
                                         ,umsatz_netto_vj
                                         ,umsatz_netto_vj_km
                                         ,logkostenzuschlag
                                         ,logkostenzuschlag_vj
                                         ,logkostenzuschlag_vj_km
                                         ,betrag_kmep_km
                                         ,betrag_kmep_km_vj
                                         ,betrag_kmep_kw
                                         ,betrag_kmep_kw_vj
                                         ,betrag_kmep_ww
                                         ,betrag_kmep_ww_vj
                                         ,werbe_abschrift_netto
                                         ,werbe_abschrift_netto_vj
                                         ,werbe_abschrift_netto_vj_km
                                         ,preis_abschrift_netto
                                         ,preis_abschrift_netto_vj
                                         ,preis_abschrift_netto_vj_km
                                         ,betrag_kmep_o_fwu_km
                                         ,betrag_kmep_o_fwu_km_vj
                                         ,betrag_kmep_o_fwu_kw
                                         ,betrag_kmep_o_fwu_kw_vj
                                         ,betrag_kmep_o_fwu_ww
                                         ,betrag_kmep_o_fwu_ww_vj)
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat
      ,'EUR' as wrg_id
      ,a.wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,a.umrechnungskurs_hist
      ,a.umsatz_netto*d1.umrechnungskurs
      ,a.umsatz_netto_vj*d1.umrechnungskurs
      ,a.umsatz_netto_vj_km*d1.umrechnungskurs
      ,a.logkostenzuschlag*d1.umrechnungskurs
      ,a.logkostenzuschlag_vj*d1.umrechnungskurs
      ,a.logkostenzuschlag_vj_km*d1.umrechnungskurs
      ,a.betrag_kmep_km*d1.umrechnungskurs
      ,a.betrag_kmep_km_vj*d1.umrechnungskurs
      ,a.betrag_kmep_kw*d1.umrechnungskurs
      ,a.betrag_kmep_kw_vj*d1.umrechnungskurs
      ,a.betrag_kmep_ww*d1.umrechnungskurs
      ,a.betrag_kmep_ww_vj*d1.umrechnungskurs
      ,a.werbe_abschrift_netto*d1.umrechnungskurs
      ,a.werbe_abschrift_netto_vj*d1.umrechnungskurs
      ,a.werbe_abschrift_netto_vj_km*d1.umrechnungskurs
      ,a.preis_abschrift_netto*d1.umrechnungskurs
      ,a.preis_abschrift_netto_vj*d1.umrechnungskurs
      ,a.preis_abschrift_netto_vj_km*d1.umrechnungskurs
      ,a.betrag_kmep_o_fwu_km*d1.umrechnungskurs
      ,a.betrag_kmep_o_fwu_km_vj*d1.umrechnungskurs
      ,a.betrag_kmep_o_fwu_kw*d1.umrechnungskurs
      ,a.betrag_kmep_o_fwu_kw_vj*d1.umrechnungskurs
      ,a.betrag_kmep_o_fwu_ww*d1.umrechnungskurs
      ,a.betrag_kmep_o_fwu_ww_vj*d1.umrechnungskurs
from dbp_etl.tag_wa_kalk_final_pl a
join dbp_data.kurs d1
  on a.wrg_id = d1.von_wrg_id and
     d1.dat_bis = '9999-12-31' and
     d1.nach_wrg_id = 'EUR' and
     d1.kurstyp_id = 3
where a.mandant_id = 3
;

insert into dbp_etl.monat_wa_kalk_final_pl (mandant_id
                                           ,art_id
                                           ,bewart_id
                                           ,bewart_det_id
                                           ,wup_id
                                           ,nb_id
                                           ,kjmo
                                           ,wrg_id
                                           ,posten_id
                                           ,wup_bereinigt_fg
                                           ,zek_id
                                           ,eigenmarke_fg
                                           ,gp_id
                                           ,umrechnungskurs_hist
                                           ,umsatz_netto
                                           ,umsatz_netto_vj
                                           ,betrag_kmep
                                           ,betrag_kmep_vj
                                           ,logkostenzuschlag
                                           ,logkostenzuschlag_vj
                                           ,werbe_abschrift_netto
                                           ,werbe_abschrift_netto_vj
                                           ,preis_abschrift_netto
                                           ,preis_abschrift_netto_vj
                                           ,betrag_kmep_o_fwu
                                           ,betrag_kmep_o_fwu_vj)
select a.mandant_id
      ,a.art_id
      ,a.bewart_id
      ,a.bewart_det_id
      ,a.wup_id
      ,a.nb_id
      ,to_number(substring(to_varchar(a.dat,'yyyymmdd'),1,6)) AS kjmo
      ,a.wrg_id
      ,b.posten_id
      ,a.wup_bereinigt_fg
      ,a.zek_id
      ,a.eigenmarke_fg
      ,c.gp_id
      ,sum(a.umrechnungskurs_hist)
      ,sum(a.umsatz_netto)
      ,sum(a.umsatz_netto_vj_km)
      ,sum(a.betrag_kmep_km)
      ,sum(a.betrag_kmep_km_vj)
      ,sum(a.logkostenzuschlag)
      ,sum(a.logkostenzuschlag_vj_km)
      ,sum(a.werbe_abschrift_netto)
      ,sum(a.werbe_abschrift_netto_vj_km)
      ,sum(a.preis_abschrift_netto)
      ,sum(a.preis_abschrift_netto_vj_km)
      ,sum(a.betrag_kmep_o_fwu_km)
      ,sum(a.betrag_kmep_o_fwu_km_vj)
from dbp_etl.tag_wa_kalk_final_pl a
join dbp_data.art_per b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.dat between b.dat_von and b.dat_bis
left join dbp_etl.art_gp_nm_zu_per_fww c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.art_id = c.art_id and
     a.dat = c.dat
where a.preis_abschrift_netto = 0 and
      a.preis_abschrift_netto_vj_km = 0 and
      a.werbe_abschrift_netto = 0 and
      a.werbe_abschrift_netto_vj_km = 0
group by 1,2,3,4,5,6,7,8,9,10,11,12,13
;

-- 13.03.25, -dbay-
--
-- Ab hier die Umrechnungskurse. Zunaechst (1) werden die Landeswaehrungen verwendet,
-- um den historischen durch den aktuellen Kurs zu teilen und als historischen
-- Kursfaktor auf die EUR-Waehrung festzuschreiben. Dann (2) werden die Restanten
-- der Landeswaehrung ganz normal mit dem jeweiligen Umrechnungskurs bestueckt.

-- (1)
update dbp_etl.tag_wa_kalk_final_pl from (
select d.mandant_id,
       a.dat,
       'EUR' as wrg_id,
       b.umrechnungskurs/c.umrechnungskurs as umrechnungskurs_hist
from dbp_data.tag a
join dbp_data.mandant d
  on 1 = 1
join dbp_data.kurs b
  on d.default_wrg = b.von_wrg_id and
     a.dat between b.dat_von and b.dat_bis and
     b.nach_wrg_id = 'EUR' and
     b.kurstyp_id = 3
join dbp_data.kurs c
  on d.default_wrg = c.von_wrg_id and
     c.dat_bis = '9999-12-31' and
     c.nach_wrg_id = 'EUR' and
     c.kurstyp_id = 3
where d.mandant_id in (3) and
      a.akt_mo between -13 and 0
group by 1,2,3,4
) b

set umrechnungskurs_hist = b.umrechnungskurs_hist

where dbp_etl.tag_wa_kalk_final_pl.mandant_id = b.mandant_id and
      dbp_etl.tag_wa_kalk_final_pl.dat = b.dat and
      dbp_etl.tag_wa_kalk_final_pl.wrg_id = b.wrg_id
;

update dbp_etl.monat_wa_kalk_final_pl from (
select d.mandant_id,
       a.kjmo,
       'EUR' as wrg_id,
       b.umrechnungskurs/c.umrechnungskurs as umrechnungskurs_hist
from dbp_data.tag a
join dbp_data.monat e
  on a.kjmo = e.kjmo
join dbp_data.mandant d
  on 1 = 1
join dbp_data.kurs b
  on d.default_wrg = b.von_wrg_id and
     e.min_dat between b.dat_von and b.dat_bis and
     b.nach_wrg_id = 'EUR' and
     b.kurstyp_id = 3
join dbp_data.kurs c
  on d.default_wrg = c.von_wrg_id and
     c.dat_bis = '9999-12-31' and
     c.nach_wrg_id = 'EUR' and
     c.kurstyp_id = 3
where d.mandant_id in (3) and
      a.akt_mo between -13 and 0
group by 1,2,3,4
) b

set umrechnungskurs_hist = b.umrechnungskurs_hist

where dbp_etl.monat_wa_kalk_final_pl.mandant_id = b.mandant_id and
      dbp_etl.monat_wa_kalk_final_pl.kjmo = b.kjmo and
      dbp_etl.monat_wa_kalk_final_pl.wrg_id = b.wrg_id
;

-- (2)
update dbp_etl.tag_wa_kalk_final_pl
from dbp_data.kurs k

set umrechnungskurs_hist = k.umrechnungskurs

where dbp_etl.tag_wa_kalk_final_pl.wrg_id = k.von_wrg_id
  and dbp_etl.tag_wa_kalk_final_pl.dat between k.dat_von and k.dat_bis
  and k.nach_wrg_id = 'EUR'
  and k.kurstyp_id = 3
  and dbp_etl.tag_wa_kalk_final_pl.umrechnungskurs_hist = 0
;

update dbp_etl.monat_wa_kalk_final_pl
from dbp_data.kurs k,dbp_data.monat x

set umrechnungskurs_hist = k.umrechnungskurs

where dbp_etl.monat_wa_kalk_final_pl.wrg_id = k.von_wrg_id
  and dbp_etl.monat_wa_kalk_final_pl.kjmo = x.kjmo
  and x.min_dat between k.dat_von and k.dat_bis
  and k.nach_wrg_id = 'EUR'
  and k.kurstyp_id = 3
  and dbp_etl.monat_wa_kalk_final_pl.umrechnungskurs_hist = 0
;


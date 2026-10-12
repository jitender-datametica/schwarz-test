execute immediate $$
begin
  if (exists(select * 
             from information_schema.columns 
             where table_name = 'AS_FOOD_TMP_1' 
               and table_schema = 'DBP_ETL_1'
               and column_name = 'WRG_ID')) then
    alter table if exists dbp_etl.as_food_tmp_1 drop column wrg_id;
  end if;
end;
$$
;

create or replace table dbp_etl.as_food_tmp_2_1  (
      art_id integer not null
     ,mandant_id byteint not null
     ,nb_id smallint not null 
     ,wup_id integer not null
     ,dat_auslistung date not null
     ,gp_id integer not null default -1
     ,phase_status byteint not null default -1  
     ,erl_fg byteint /*check ( (erl_fg >=  0 ) and  (erl_fg <=  1 ) )*/ not null default 0  
     ,dat_final date
     ,menge_startbestand decimal(18,3) not null default 0.000
     ,vk_netto decimal(18,4) not null default 0.0000
     ,phase_id byteint
     ,kjwo integer
     ,weeks integer
     ,alweek integer
     ,week01 integer
     ,week02 integer
     ,week03 integer
     ,week04 integer
     ,week05 integer
     ,vknorm decimal(9,2)
     ,vkpr01 decimal(9,2)
     ,vkpr02 decimal(9,2)
     ,vkpr03 decimal(9,2)
     ,vkpr04 decimal(9,2)
     ,vkpr05 decimal(9,2)
     ,aedat date
     ,erl_kz char(1) collate 'de-ci' not null default ''
     ,td_insert timestamp_ltz(9)
     ,wrg_id varchar(3) collate 'en-ci'
);

-- kopfdaten

create or replace table dbp_etl.as_food_final_1  (
      art_id integer not null,
      mandant_id byteint not null,
      nb_id smallint not null  ,
      wup_id integer not null,
      dat_auslistung date not null,
      gp_id integer not null default -1 ,
      phase_status byteint not null default -1  ,
      erl_fg byteint /*check ( (erl_fg >=  0 ) and  (erl_fg <=  1 ) )*/ not null default 0  ,
      dat_final date ,
      menge_startbestand decimal(18,3) not null default 0.000 ,
      vk_netto decimal(18,4) not null default 0.0000 ,
      menge_endbestand decimal(18,3) not null default 0.000,
      erl_kz char(1) collate 'de-ci' not null default '',
      dat_aend date,
      wrg_id varchar(3)
) ;

-- positionen
create or replace table dbp_etl.as_food_det_final_tmp_1  (
      art_id integer not null,
      mandant_id byteint not null,
      nb_id smallint not null  ,
      wup_id integer not null,
      dat_auslistung date not null,
      phase_id byteint not null,
      kjwo integer not null,
      phase_wo integer not null,
      phase_vk_brutto decimal(9,2) not null default 0.00 ,
      phase_vk_netto decimal(18,4) not null default 0.00 ,
      menge_abschrift_22 integer not null default 0   ,
      abschriftbetrag_netto_22 decimal(18,4) not null default 0.00   ,
      menge_abschrift_122 integer not null default 0   ,
      abschriftbetrag_netto_122 decimal(18,4) not null default 0.00   ,
      diff_wert_bestand_netto decimal(18,4) not null default 0.00   ,
      menge_berechnet decimal(18,3) not null default 0.000  ,
      menge_endbestand_phase decimal(18,3) not null default 0.000, 
      menge decimal(18,3) not null default 0.000, 
      umsatz_netto decimal(18,4) not null default 0.000,
      mwst_id byteint not null,
      wtag_phasenbeginn byteint,
      wrg_id varchar(3) collate 'en-ci'
);

create or replace table dbp_etl.as_food_det_final_1  (
      art_id integer not null,
      mandant_id byteint not null,
      nb_id smallint not null  ,
      wup_id integer not null,
      dat_auslistung date not null,
      phase_id byteint not null,
      kjwo integer not null,
      phase_wo integer not null,
      phase_vk_brutto decimal(9,2) not null default 0.00 ,
      phase_vk_netto decimal(18,4) not null default 0.00 ,
      menge_abschrift_22 integer not null default 0   ,
      abschriftbetrag_netto_22 decimal(18,4) not null default 0.00   ,
      menge_abschrift_122 integer not null default 0   ,
      abschriftbetrag_netto_122 decimal(18,4) not null default 0.00   ,
      diff_wert_bestand_netto decimal(18,4) not null default 0.00   ,
      menge_berechnet decimal(18,3) not null default 0.000  ,
      menge_endbestand_phase decimal(18,3) not null default 0.000, 
      menge decimal(18,3) not null default 0.000, 
      umsatz_netto decimal(18,4) not null default 0.000,
      mwst_id byteint not null,
      wtag_phasenbeginn byteint,
      dat_von date,
      dat_bis date,
      wrg_id varchar(3) collate 'en-ci',
      DAT_FINAL DATE, 
      ERL_KZ VARCHAR(1) NOT NULL COLLATE 'en-ci' DEFAULT ' ', 
      AS_FINAL_STATUS_ID NUMBER(38,0),
      betrag_ek_nettonetto decimal(18,4) not null default 0.00,
      betrag_ek_mep decimal(18,4) not null default 0.00,
      betrag_einstandspreis decimal(18,4) not null default 0.00,
      betrag_logkostenzuschlag decimal(18,4) not null default 0.00,
      betrag_ek_mep_vor_fwu decimal(18,4) not null default 0.00
);

create or replace table dbp_etl.as_food_det_tmp_1 (
      art_id integer not null,
      mandant_id byteint not null,
      kjwo integer not null,
      wtag_phasenbeginn byteint,
      dat_von date,
      dat_bis date
);

/*
#------------------------------------------------------------------------------
# 2.) Einfuegen der Deltadaten in temporaere Tabelle.
#------------------------------------------------------------------------------
*/

insert into dbp_etl.as_food_tmp_2_1
select tmp.*,b.default_wrg as wrg_id 
from dbp_etl.as_food_tmp_1 tmp
join dbp_data.mandant_1 b
  on tmp.mandant_id = b.mandant_id
;

-- 09.01.2018, -dbay-
--
-- Filter nach ungueltig gepflegten Saetzen aufgrund eines Abbruchs.

delete from dbp_etl.as_food_tmp_2_1
where week01 is null
;
						  
/*
#------------------------------------------------------------------------------
# 3.) Befuellung der temporaeren Kopftabelle.
#------------------------------------------------------------------------------
*/

create or replace volatile table _distinkte_kombis as (
select mandant_id,
       wup_id,
       art_id,
       dat_auslistung,
       dat_final,
       erl_kz,
       aedat as dat_aend
from dbp_etl.as_food_tmp_2_1
group by 1,2,3,4,5,6,7
);

insert into dbp_etl.as_food_final_1
select a.art_id,
       a.mandant_id,
       a.nb_id,
       a.wup_id,
       a.dat_auslistung,
       a.gp_id,
       a.phase_status,
       a.erl_fg,
       a.dat_final,
       coalesce(b.menge_lgbest_erp_frei_bme,0) as menge_startbestand, -- (quantity_start_stock) based on marktbestand_erp_1 from dat_auslistung
       coalesce(c.vk_netto,0) as vk_netto, -- (net_sales_price) based on marktbestand_erp_zu_1 from from dat_auslistung
       coalesce(d.menge_lgbest_erp_frei_bme,e.menge_lgbest_erp_frei_bme,0) as menge_endbestand, -- (quantity_end_stock) based on marktbestand_erp_1 from dat_final-1 or aedat-1
       a.erl_kz,
       a.aedat as dat_aend,
       c.wrg_id  as wrg_id
from dbp_etl.as_food_tmp_2_1 a
left join (select *
           from dbp_data.marktbestand_erp_1
           where (mandant_id,dat,wup_id,art_id) in (select mandant_id,dat_auslistung,wup_id,art_id from _distinkte_kombis)) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.nb_id = b.nb_id and
     a.dat_auslistung = b.dat and
     a.art_id = b.art_id
left join dbp_data.marktbestand_erp_zu_1 c
  on b.bestand_id = c.bestand_id
  and b.mandant_id = c.mandant_id
left join (select *
           from dbp_data.marktbestand_erp_1
	   where (mandant_id,dat,wup_id,art_id) in (select mandant_id,dat_final-1,wup_id,art_id from _distinkte_kombis where dat_final is not null)) d
  on a.mandant_id = d.mandant_id and
     a.wup_id = d.wup_id and
     a.nb_id = d.nb_id and
     a.dat_final-1 = d.dat and
     a.art_id = d.art_id
left join (select *
           from dbp_data.marktbestand_erp_1
           where (mandant_id,dat,wup_id,art_id) in (select mandant_id,dat_aend-1,wup_id,art_id from _distinkte_kombis where dat_aend is not null and erl_kz = 'X')) e
  on a.mandant_id = e.mandant_id and
     a.wup_id = e.wup_id and
     a.nb_id = e.nb_id and
     a.aedat-1 = e.dat and
     a.art_id = e.art_id
;

						  
/*
#------------------------------------------------------------------------------
# 4.) Abgeschlossene und abgebrochene Vorgaenge protokollieren.
#------------------------------------------------------------------------------
*/

-- abgebrochene ohne dat_final


create or replace volatile table _test1 as (
select a.mandant_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.dat_auslistung,
       a.alweek,
       min(coalesce(a.week01,a.week02,a.week03,a.week04,a.week05)) as min_woche,
       max(b.kjwo) as max_woche
from dbp_etl.as_food_tmp_2_1 a
join dbp_data.tag_1 b
  on a.aedat = dat
where erl_fg = 1 and ----with stock and dat_final=null, max_woche is calculated based on (aedat)
      dat_final is null
group by 1,2,3,4,5,6
);

insert into _test1 (mandant_id,
                    art_id,
                    wup_id,
                    nb_id,
                    dat_auslistung,
                    alweek,
                    min_woche,
                    max_woche)
select a.mandant_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.dat_auslistung,
       a.alweek,
       min(coalesce(a.week01,a.week02,a.week03,a.week04,a.week05)) as min_woche,
       max(d.kjwo) as max_woche
from dbp_etl.as_food_tmp_2_1 a
join dbp_data.tag_1 b
  on a.dat_final-1 = dat
join dbp_data.tag_1 c
  on b.akt_wo = c.akt_wo
join dbp_data.tag_1 d
  on d.akt_wo between c.akt_wo and c.akt_wo+3
where erl_fg = 1 and  ----with stock and dat_final=not null, max_woche is calculated based on (dat_final-1)
      dat_final is not null
group by 1,2,3,4,5,6
;

-- abgebrochene mit dat_final

insert into _test1 (mandant_id,
                    art_id,
                    wup_id,
                    nb_id,
                    dat_auslistung,
                    alweek,
                    min_woche,
                    max_woche)
select a.mandant_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.dat_auslistung,
       a.alweek,
       min(coalesce(a.week01,a.week02,a.week03,a.week04,a.week05)) as min_woche,
       max(d.kjwo) as max_woche
from dbp_etl.as_food_tmp_2_1 a
join dbp_data.tag_1 b
  on a.dat_final-1 = dat
join dbp_data.tag_1 c
  on b.akt_wo = c.akt_wo
join dbp_data.tag_1 d
  on d.akt_wo between c.akt_wo and c.akt_wo+3
where dat_final is not null and
      erl_fg = 0 --without stock but with dat_final, max_woche is calculated based on (dat_final-1)
group by 1,2,3,4,5,6
;

/*
#------------------------------------------------------------------------------
# 5.) Offene Vorgaenge protokollieren.
#------------------------------------------------------------------------------
*/

create or replace volatile table _test2 as (
select mandant_id,
       art_id,
       wup_id,
       nb_id,
       dat_auslistung,
       alweek,
       min(coalesce(week01,week02,week03,week04,week05)) as min_woche,
       max(coalesce(week05,week04,week03,week02,week01)) as max_woche
from dbp_etl.as_food_tmp_2_1
where erl_fg = 0 and  -- without stock and without dat_final, max_woche is calculated based on (week05,week04,week03,week02,week01)
      dat_final is null
group by 1,2,3,4,5,6
) ;

/*
#------------------------------------------------------------------------------
# 6.) Befuellung der temporaeren Positionstabelle.
#------------------------------------------------------------------------------
*/

-- abgebrochene und abgeschlossene

insert into dbp_etl.as_food_det_final_tmp_1
select a.art_id,
       a.mandant_id,
       a.nb_id,
       a.wup_id,
       a.dat_auslistung,
       case
         when b.kjwo < a.week01
         then 0
         when b.kjwo >= a.week01 and b.kjwo < coalesce(a.week02,999999)
         then 1
         when b.kjwo >= a.week02 and b.kjwo < coalesce(a.week03,999999)
         then 2
         when b.kjwo >= a.week03 and b.kjwo < coalesce(a.week04,999999)
         then 3
         when b.kjwo >= a.week04 and b.kjwo < coalesce(a.week05,999999)
         then 4
         when b.kjwo >= a.week05
         then 5
       end as phase_id_,
       d.kjwo,
       case
         when phase_id_ = 0
         then a.alweek
         when phase_id_ = 1
         then a.week01
         when phase_id_ = 2
         then a.week02
         when phase_id_ = 3
         then a.week03
         when phase_id_ = 4
         then a.week04
         when phase_id_ = 5
         then a.week05
       end as phase_wo,
       case
         when phase_id_ = 0
         then a.vknorm
         when phase_id_ = 1
         then a.vkpr01
         when phase_id_ = 2 
         then a.vkpr02
         when phase_id_ = 3
         then a.vkpr03
         when phase_id_ = 4
         then a.vkpr04
         when phase_id_ = 5
         then a.vkpr05
       end as phase_vk_brutto,
       0 as phase_vk_netto,
       0 as menge_abschrift_22,
       0 as abschriftbetrag_netto_22,
       0 as menge_abschrift_122,
       0 as abschriftbetrag_netto_122,
       0 as diff_wert_bestand_netto,
       0 as menge_berechnet,
       0 as menge_endbestand_phase,
       0 as menge,
       0 as umsatz_netto,
       e.mwst_id,
       null as wtag_phasenbeginn,
       a.wrg_id
from dbp_etl.as_food_tmp_2_1 a
join (select b.kjwo,
             a.*
      from _test1 a
      join dbp_data.woche_1 b
        on b.kjwo between a.alweek and a.max_woche) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.wup_id = b.wup_id and
     a.nb_id = b.nb_id and
     a.dat_auslistung = b.dat_auslistung
join dbp_data.woche_1 c
  on b.kjwo = c.kjwo 
join dbp_data.woche_1 d
  on c.akt_wo+1 = d.akt_wo
join dbp_data.art_1 e
  on a.mandant_id = e.mandant_id and
     a.art_id = e.art_id
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22
;

-- offene

insert into dbp_etl.as_food_det_final_tmp_1
select a.art_id,
       a.mandant_id,
       a.nb_id,
       a.wup_id,
       a.dat_auslistung,
       case
         when b.kjwo < a.week01
         then 0
         when b.kjwo >= a.week01 and b.kjwo < coalesce(a.week02,999999)
         then 1
         when b.kjwo >= a.week02 and b.kjwo < coalesce(a.week03,999999)
         then 2
         when b.kjwo >= a.week03 and b.kjwo < coalesce(a.week04,999999)
         then 3
         when b.kjwo >= a.week04 and b.kjwo < coalesce(a.week05,999999)
         then 4
         when b.kjwo >= a.week05
         then 5
       end as phase_id_,
       d.kjwo,
       case
         when phase_id_ = 0
         then a.alweek
         when phase_id_ = 1
         then a.week01
         when phase_id_ = 2
         then a.week02
         when phase_id_ = 3
         then a.week03
         when phase_id_ = 4
         then a.week04
         when phase_id_ = 5
         then a.week05
       end as phase_wo,
       case
         when phase_id_ = 0
         then a.vknorm
         when phase_id_ = 1
         then a.vkpr01
         when phase_id_ = 2 
         then a.vkpr02
         when phase_id_ = 3
         then a.vkpr03
         when phase_id_ = 4
         then a.vkpr04
         when phase_id_ = 5
         then a.vkpr05
       end as phase_vk_brutto,
       0 as phase_vk_netto,
       0 as menge_abschrift_22,
       0 as abschriftbetrag_netto_22,
       0 as menge_abschrift_122,
       0 as abschriftbetrag_netto_122,
       0 as diff_wert_bestand_netto,
       0 as menge_berechnet,
       0 as menge_endbestand_phase,
       0 as menge,
       0 as umsatz_netto,
       e.mwst_id,
       null as wtag_phasenbeginn,
       a.wrg_id
from dbp_etl.as_food_tmp_2_1 a
join (select b.kjwo,
             a.*
      from _test2 a
      join dbp_data.woche_1 b
        on b.kjwo between a.alweek and (select a.kjwo                       ---- display current_week 
		                           from dbp_data.woche_1 a
                                           join (select wtag_id
                                                 from dbp_data.tag_1
                                                 where dat = current_date) b
                                             on 1 = 1
                                           where akt_wo = case
                                                            when b.wtag_id = 1
                                                            then 1
                                                            else 0
                                                          end)) b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.wup_id = b.wup_id and
     a.nb_id = b.nb_id and
     a.dat_auslistung = b.dat_auslistung
join dbp_data.woche_1 c
  on b.kjwo = c.kjwo 
join dbp_data.woche_1 d
  on c.akt_wo+1 = d.akt_wo
join dbp_data.art_1 e
  on a.mandant_id = e.mandant_id and
     a.art_id = e.art_id
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22
;

-- add wtag_phasenbeginn
create or replace volatile table _tag as (
select
tt.kjwo,
tt.wtag_id,
tt.dat as dat_von,
(tt.dat+6) as dat_bis
from (select kjwo from dbp_data.tag_1
	group by kjwo) t -- take only weeks
inner join dbp_data.tag_1 tt
on t.kjwo = tt.kjwo
);

insert into dbp_etl.as_food_det_tmp_1
select  
af.art_id,
af.mandant_id,
af.kjwo,
coalesce(p.wtag_phasenbeginn,1) as wtag_phasenbeginn,
case when wtag_phasenbeginn=7 then t.dat_von-7 else t.dat_von end,
case when wtag_phasenbeginn=7 then t.dat_bis-7 else t.dat_bis end
from
(select mandant_id, 
	art_id, kjwo
from dbp_etl.as_food_det_final_tmp_1
group by 1,2,3) af
join dbp_data.art_1 a
on a.mandant_id = af.mandant_id 
and a.art_id = af.art_id 

left join dbp_data.art_wg_zu_per_1 awz  -- there were less rows in test_1 due to not found correspondence on art_wg_zu_per_1, hence left join here !!!
on a.mandant_id = awz.mandant_id 
and a.art_id = awz.art_id 
and awz.arthiertyp_id = 2 
and awz.dat_bis = to_date('9999-12-31', 'yyyy-mm_1-dd')

left join dbp_data.as_phasen_1 p
on p.mandant_id = a.mandant_id 
and p.posten_kz_sap = a.posten_kz_sap
and p.wg_id = awz.wg_id

inner join _tag t
on af.kjwo = t.kjwo
and coalesce(p.wtag_phasenbeginn,1) = t.wtag_id

group by 1,2,3,4,5,6
;


insert into dbp_etl.as_food_det_final_1
select
      m.art_id,
      m.mandant_id,
      nb_id,
      wup_id,
      dat_auslistung,
      phase_id,
      m.kjwo,
      phase_wo,
      phase_vk_brutto,
      phase_vk_netto,
      menge_abschrift_22,
      abschriftbetrag_netto_22,
      menge_abschrift_122 ,
      abschriftbetrag_netto_122,
      diff_wert_bestand_netto,
      menge_berechnet,
      menge_endbestand_phase, 
      menge, 
      umsatz_netto,
      mwst_id,
      t.wtag_phasenbeginn,
      t.dat_von,
      t.dat_bis,
      m.wrg_id,
      NULL as DAT_FINAL,
      ' ' as ERL_KZ,
      0 as AS_FINAL_STATUS_ID,
      0 as betrag_ek_nettonetto,
      0 as betrag_ek_mep,
      0 as betrag_einstandspreis,
      0 as betrag_logkostenzuschlag,
      0 as betrag_ek_mep_vor_fwu
from dbp_etl.as_food_det_final_tmp_1 m
inner join dbp_etl.as_food_det_tmp_1 t
on  m.mandant_id = t.mandant_id and
    m.art_id = t.art_id
    and m.kjwo = t.kjwo
;
	
update dbp_etl.as_food_det_final_1 
set phase_vk_netto = phase_vk_brutto/(mwst_ / 100+1) 
from (select mandant_id as mandant_id_
             ,mwst_id as mwst_id_
             ,dat_von as dat_von_
             ,mwst as mwst_
             ,dat_bis as dat_bis_
       from dbp_data.mwst_per_1) dt1 
where dat_auslistung between dat_von_ and dat_bis_
  and mwst_id = mwst_id_
  and mandant_id = mandant_id_
;

update dbp_etl.as_food_det_final_1
set menge_endbestand_phase = b.menge_endbestand
from (select a.mandant_id,
       a.art_id,
       a.wup_id,
       a.dat_auslistung,
       a.phase_id,
       a.max_kjwo,
       coalesce(d.menge_lgbest_erp_frei_bme,0) as menge_endbestand
from (select mandant_id,
             art_id,
             wup_id,
             dat_auslistung,
             phase_id,
             wtag_phasenbeginn,
             max(kjwo) as max_kjwo
          from dbp_etl.as_food_det_final_1
          group by 1,2,3,4,5,6) a  --- maxim(kjwo) for each phase
       inner join dbp_etl.as_food_det_final_1 b
         on a.mandant_id = b.mandant_id
         and a.art_id = b.art_id
         and a.wup_id = b.wup_id
         and a.dat_auslistung = b.dat_auslistung
         and a.phase_id = b.phase_id
         and a.max_kjwo = b.kjwo
         and a.wtag_phasenbeginn = b.wtag_phasenbeginn
      left join dbp_data.marktbestand_erp_1 d
         on a.mandant_id = d.mandant_id
         and a.wup_id = d.wup_id
         and a.art_id = d.art_id
         and b.dat_bis = d.dat) b -- take 'menge' from last day
where dbp_etl.as_food_det_final.mandant_id = b.mandant_id and
      dbp_etl.as_food_det_final.kjwo = b.max_kjwo and
      dbp_etl.as_food_det_final.dat_auslistung = b.dat_auslistung and
      dbp_etl.as_food_det_final.wup_id = b.wup_id and
      dbp_etl.as_food_det_final.art_id = b.art_id and
      dbp_etl.as_food_det_final.phase_id = b.phase_id
;

update dbp_etl.as_food_det_final_1
set menge = coalesce(b.menge,0),
    umsatz_netto = coalesce(b.umsatz_netto,0),
    wrg_id = b.wrg_1,
    betrag_ek_nettonetto = coalesce(b.ek_nettonetto,0),
    betrag_ek_mep = coalesce(b.ek_mep,0),
    betrag_einstandspreis = coalesce(b.einstandspreis,0),
    betrag_logkostenzuschlag = coalesce(b.logkostenzuschlag,0),
    betrag_ek_mep_vor_fwu = coalesce(b.ek_mep_vor_fwu,0)
from (select a.mandant_id,
             a.kjwo,
             a.art_id,
             a.wup_id,
             a.nb_id,
             d.wrg_1,
             sum(d.menge) as menge,     
             sum(d.umsatz_netto) as umsatz_netto,
             sum(d.ek_nettonetto) as ek_nettonetto,
             sum(d.ek_mep) as ek_mep,
             sum(d.einstandspreis) as einstandspreis,
             sum(d.logkostenzuschlag) as logkostenzuschlag,
             sum(d.ek_mep_vor_fwu) as ek_mep_vor_fwu
      from dbp_etl.as_food_det_final_1 a
      join dbp_data.artbew_1 d
        on a.mandant_id = d.mandant_id and
           a.art_id = d.art_id and
           a.wup_id = d.wup_id and
           a.nb_id = d.nb_id and
           d.dat between a.dat_von and a.dat_bis
      group by 1,2,3,4,5,6) b	
where dbp_etl.as_food_det_final.mandant_id = b.mandant_id and
      dbp_etl.as_food_det_final.kjwo = b.kjwo and
      dbp_etl.as_food_det_final.wup_id = b.wup_id and
      dbp_etl.as_food_det_final.nb_id = b.nb_id and
      dbp_etl.as_food_det_final.art_id = b.art_id
;

create or replace volatile table _markets as (
select wtag_phasenbeginn,
       dat_von,
       dat_bis,
       kjwo,
       mandant_id,
       wup_id,
       nb_id,
       art_id
from dbp_etl.as_food_det_final_1
group by 1,2,3,4,5,6,7,8
);

create or replace volatile table _abschriften as (
select a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       d.wrg_id,
       sum(case when d.abschriftart_id = 22 then d.menge_abschrift else 0 end) as menge_abschrift_22,
       sum(case when d.abschriftart_id = 22 then d.abschriftbetrag_netto else 0 end) as abschriftbetrag_netto_22,
       sum(case when d.abschriftart_id in (23,122) then d.menge_abschrift else 0 end) as menge_abschrift_122,
       sum(case when d.abschriftart_id in (23,122) then d.abschriftbetrag_netto else 0 end) as abschriftbetrag_netto_122
from _markets a
join dbp_data.marktabschriften_1 d
  on a.wup_id = d.wup_id and
     a.mandant_id = d.mandant_id and
     a.nb_id = d.nb_id and
     a.art_id = d.art_id and
     --d.dat  between a.dat_von and a.dat_bis -- take whole week           
	 a.kjwo = d.woche_id    
where d.mandant_id = 1 and  
      d.abschriftart_id in (22,23,122)
group by 1,2,3,4,5,6
);

update dbp_etl.as_food_det_final_1 
set menge_abschrift_22 = b.menge_abschrift_22,
    abschriftbetrag_netto_22 = b.abschriftbetrag_netto_22,
    menge_abschrift_122 = b.menge_abschrift_122,
    abschriftbetrag_netto_122 = b.abschriftbetrag_netto_122,
    wrg_id = b.wrg_id
from (select *
      from _abschriften) b
where dbp_etl.as_food_det_final.mandant_id = b.mandant_id and
      dbp_etl.as_food_det_final.wup_id = b.wup_id and
      dbp_etl.as_food_det_final.nb_id = b.nb_id and
      dbp_etl.as_food_det_final.art_id = b.art_id and
      dbp_etl.as_food_det_final.kjwo = b.kjwo
;

----new abschriften_1 fuer kmo ----
create or replace table dbp_etl._markets_kmo_1 as (
select wtag_phasenbeginn,
       dat_von,
       dat_bis,
       kjwo,
       mandant_id,
       wup_id,
       nb_id,
       art_id,
       dat_auslistung
from dbp_etl.as_food_det_final_1
where mandant_id <> 1
group by 1,2,3,4,5,6,7,8,9
);

create or replace table dbp_etl._kmoabschriften_1 as (
select a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung,
       d.wrg_id,
       sum(case when d.abschriftart_id = 953 then d.menge_abschrift else 0 end) as menge_abschrift_122,
       sum(case when d.abschriftart_id = 953 then d.abschriftbetrag_netto else 0 end) as abschriftbetrag_netto_122
from dbp_etl._markets_kmo_1 a
join dbp_data.marktabschriften_1 d
  on a.wup_id = d.wup_id and
     a.mandant_id = d.mandant_id and
     a.nb_id = d.nb_id and
     a.art_id = d.art_id and
     --d.dat  between a.dat_von and a.dat_bis     
     a.kjwo = d.woche_id
where d.mandant_id <> 1 and  
      d.abschriftart_id = 953
group by 1,2,3,4,5,6,7
);

create or replace table dbp_etl._kmoabschriften_max_kjwo_1 as (
select 
       max(a.kjwo) as kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung  
from dbp_etl._markets_kmo_1 a
group by 2,3,4,5,6
);

create or replace table dbp_etl._kmoabschriften_max_pjwo1_1 as 
(
select 
       a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung,
       max(b.pjwo) as pjwo
from dbp_etl._kmoabschriften_max_kjwo_1 a
join dbp_data.tag_1 b
  on a.kjwo = b.kjwo
group by 1,2,3,4,5,6)
;

create or replace table dbp_etl._kmoabschriften_max_pjwo2_1 as 
(
select 
       a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung,
       max(b.pjwo) as pjwo
from dbp_etl._kmoabschriften_max_pjwo1_1 a
join dbp_data.tag_1 b
  on a.pjwo = b.kjwo
group by 1,2,3,4,5,6)
;

create or replace table dbp_etl._kmoabschriften_kjwo1_1 as (
select a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung,
       d.wrg_id,
       sum(case when d.abschriftart_id = 953 then d.menge_abschrift else 0 end) as menge_abschrift_122,
       sum(case when d.abschriftart_id = 953 then d.abschriftbetrag_netto else 0 end) as abschriftbetrag_netto_122
from dbp_data.marktabschriften_1 d
join dbp_etl._kmoabschriften_max_pjwo1_1 a
on a.wup_id = d.wup_id and
     a.mandant_id = d.mandant_id and
     a.nb_id = d.nb_id and
     a.art_id = d.art_id and
     d.woche_id = a.pjwo
where d.abschriftart_id = 953
group by 1,2,3,4,5,6,7
);

create or replace table dbp_etl._kmoabschriften_kjwo2_1 as (
select a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung,  
       d.wrg_id,
       sum(case when d.abschriftart_id = 953 then d.menge_abschrift else 0 end) as menge_abschrift_122,
       sum(case when d.abschriftart_id = 953 then d.abschriftbetrag_netto else 0 end) as abschriftbetrag_netto_122
from dbp_data.marktabschriften_1 d
join dbp_etl._kmoabschriften_max_pjwo2_1 a
on a.wup_id = d.wup_id and
     a.mandant_id = d.mandant_id and
     a.nb_id = d.nb_id and
     a.art_id = d.art_id and
     d.woche_id = a.pjwo
where d.abschriftart_id = 953
group by 1,2,3,4,5,6,7
);

create or replace table dbp_etl._kmoabschriften_final_1 as (
select kjwo,
       mandant_id,
       wup_id,
       nb_id,
       art_id,
       dat_auslistung,
       wrg_id,  
       sum(menge_abschrift_122) as menge_abschrift_122,
       sum(abschriftbetrag_netto_122) as abschriftbetrag_netto_122
from (
  select * from dbp_etl._kmoabschriften_1
  union all
  select * from dbp_etl._kmoabschriften_kjwo1_1
  union all
  select * from dbp_etl._kmoabschriften_kjwo2_1
  )
group by 1,2,3,4,5,6,7
);

-- new logic - update for data where dat_aulistung>='2022-03-07'

update dbp_etl.as_food_det_final_1 
set menge_abschrift_122 = b.menge_abschrift_122,
    abschriftbetrag_netto_122 = b.abschriftbetrag_netto_122,
    wrg_id = b.wrg_id
from (select *
      from dbp_etl._kmoabschriften_final_1) b
where dbp_etl.as_food_det_final.mandant_id = b.mandant_id and
      dbp_etl.as_food_det_final.wup_id = b.wup_id and
      dbp_etl.as_food_det_final.nb_id = b.nb_id and
      dbp_etl.as_food_det_final.art_id = b.art_id and
      dbp_etl.as_food_det_final.kjwo = b.kjwo and
      dbp_etl.as_food_det_final.dat_auslistung = b.dat_auslistung and 
      dbp_etl.as_food_det_final.dat_auslistung >= '2022-03-07'
;

-- old logic - update for data where dat_aulistung<'2022-03-07'

update  dbp_etl.as_food_det_final_1 
   set  menge_abschrift_122 = case when b.abschriftbetrag_netto_122 <> 0 then 1 else 0 end,
        abschriftbetrag_netto_122 = b.abschriftbetrag_netto_122,
        wrg_id= b.wrg_id

from (  select  a.mandant_id,
                a.art_id,
                a.wup_id,
                a.nb_id,
                a.dat_auslistung,
                b.kjwo,
                b.wrg_id,
                a.menge_endbestand*b.phase_vk_netto*-1 as abschriftbetrag_netto_122
        from    dbp_etl.as_food_final_1 a
        join (  select  mandant_id,
                        art_id,
                        wup_id,
                        nb_id,
                        dat_auslistung,
                        wrg_id,
                        max(case when phase_id = 0 then phase_vk_netto else 0 end) as phase_vk_netto,
                        max(kjwo) as kjwo
                from    dbp_etl.as_food_det_final_1
                where   mandant_id > 1
                group by 1,2,3,4,5,6
             ) b
          on    a.mandant_id = b.mandant_id and
                a.art_id = b.art_id and
                a.wup_id = b.wup_id and
                a.nb_id = b.nb_id and
                a.dat_auslistung = b.dat_auslistung
        where   a.dat_final is not null and
                a.dat_final <= current_date and
                a.mandant_id > 1) b
										  
where dbp_etl.as_food_det_final.mandant_id = b.mandant_id and
      dbp_etl.as_food_det_final.wup_id = b.wup_id and
      dbp_etl.as_food_det_final.nb_id = b.nb_id and
      dbp_etl.as_food_det_final.art_id = b.art_id and
      dbp_etl.as_food_det_final.kjwo = b.kjwo and
      dbp_etl.as_food_det_final.dat_auslistung = b.dat_auslistung and 
      dbp_etl.as_food_det_final.dat_auslistung < '2022-03-07'
;

-- update preisaenderung fuer kmo
update  dbp_etl.as_food_det_final_1 										 
   set  menge_abschrift_22 = case when b.diff_wert_bestand_netto <> 0 then 1 else 0 end,
        abschriftbetrag_netto_22 = b.diff_wert_bestand_netto,
        menge_berechnet = case when b.diff_wert_bestand_netto <> 0 then 1 else 0 end,
        diff_wert_bestand_netto = b.diff_wert_bestand_netto
from (  select  a.mandant_id,
                a.art_id,
                a.wup_id,
                a.nb_id,
                a.kjwo,
                a.dat_auslistung,
                (a.phase_vk_netto-b.phase_vk_netto)*a.menge as diff_wert_bestand_netto
        from    dbp_etl.as_food_det_final_1 a
        join    (select mandant_id,
                        art_id, 
                        wup_id,
                        nb_id,
                        dat_auslistung,
                        phase_vk_netto
                  from  dbp_etl.as_food_det_final_1
                 where  phase_id = 0 and
                        mandant_id > 1
                group by 1,2,3,4,5,6
                ) b
          on    a.mandant_id = b.mandant_id and
                a.art_id = b.art_id and
                a.wup_id = b.wup_id and
                a.nb_id = b.nb_id and
                a.dat_auslistung = b.dat_auslistung
       group by 1,2,3,4,5,6,7) b	
where dbp_etl.as_food_det_final.mandant_id = b.mandant_id and
      dbp_etl.as_food_det_final.wup_id = b.wup_id and
      dbp_etl.as_food_det_final.nb_id = b.nb_id and
      dbp_etl.as_food_det_final.art_id = b.art_id and
      dbp_etl.as_food_det_final.kjwo = b.kjwo and
      dbp_etl.as_food_det_final.dat_auslistung = b.dat_auslistung
;

create or replace volatile table _snapshot_1 as (
select c.kjwo as kjwo_kill,  --- determine last week until today from dat_final or aedat
       a.dat_final as dat_final_,
       a.dat_aend,
       b.*
from dbp_etl.as_food_final_1 a
join dbp_data.tag_1 c
  on coalesce(a.dat_final,a.dat_aend) = c.dat -- join on dat_final or aedat
join dbp_etl.as_food_det_final_1 b
  on a.art_id = b.art_id and
     a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.dat_auslistung = b.dat_auslistung and
     b.kjwo >= c.kjwo  --- take all weeks >= week from dat_final or aedat
where (a.erl_fg = 1 or   --- with stock or dat_final <=current_date
      (a.dat_final is not null and
       a.dat_final <= current_date))
);

create or replace volatile table _absatz_konsolidiert as (
select  d.mandant_id,
        a.kjwo_kill as kjwo,
        d.art_id,
        d.wup_id,
        d.wrg_1,
        sum(d.menge) as menge,
        sum(d.umsatz_netto) as umsatz_netto,
        sum(d.ek_nettonetto) as ek_nettonetto,
        sum(d.ek_mep) as ek_mep,
        sum(d.einstandspreis) as einstandspreis,
        sum(d.logkostenzuschlag) as logkostenzuschlag,
        sum(d.ek_mep_vor_fwu) as ek_mep_vor_fwu
from (select kjwo_kill,
             mandant_id,
             wup_id,
             art_id,
             dat_auslistung,
             dat_final,
             dat_aend,
             wtag_phasenbeginn,
             dat_von,
             dat_bis
      from _snapshot_1
      group by 1,2,3,4,5,6,7,8,9,10) a
join dbp_data.artbew_1 d						   
  on a.mandant_id = d.mandant_id and 
     a.art_id = d.art_id and 
     a.wup_id = d.wup_id and 
     d.dat  between a.dat_von and a.dat_bis -- take whole week  
 and d.dat <= coalesce(a.dat_final,a.dat_aend)
group by 1,2,3,4,5
);

create or replace volatile table _abschrift_konsolidiert as (
select  d.mandant_id,
        a.kjwo_kill as kjwo,
        d.art_id,
        d.wup_id,
        d.wrg_id,
        sum(case when d.abschriftart_id = 22 then d.menge_abschrift else 0 end) as menge_abschrift_22,
        sum(case when d.abschriftart_id = 22 then d.abschriftbetrag_netto else 0 end) as abschriftbetrag_netto_22,
        sum(case when d.abschriftart_id in (23,122) then d.menge_abschrift else 0 end) as menge_abschrift_122,
        sum(case when d.abschriftart_id in (23,122) then d.abschriftbetrag_netto else 0 end) as abschriftbetrag_netto_122
  from  (
        select  kjwo_kill,
                mandant_id,
                wup_id,
                art_id,
                dat_auslistung,
                dat_final,
                dat_aend,
                wtag_phasenbeginn,
                dat_von,
                dat_bis
          from  _snapshot_1
         group by 1,2,3,4,5,6,7,8,9,10
        ) a
  join  dbp_data.marktabschriften_1 d	
    on  d.mandant_id = a.mandant_id and
        d.art_id = a.art_id and
        d.wup_id = a.wup_id and
        d.dat <= coalesce(a.dat_final,a.dat_aend) and
        d.dat  between a.dat_von and a.dat_bis 	 
 where  d.mandant_id = 1 and
        d.abschriftart_id in (22,23,122)
group by 1,2,3,4,5
);

update _snapshot_1 
set /*menge = 0 ,*/
    umsatz_netto = 0,
    betrag_ek_nettonetto = 0,
    betrag_ek_mep = 0,
    betrag_einstandspreis = 0,
    betrag_logkostenzuschlag = 0,
    betrag_ek_mep_vor_fwu = 0,
    menge_abschrift_22 = 0,
    abschriftbetrag_netto_22 = 0,
    menge_abschrift_122 = 0, 
    abschriftbetrag_netto_122 = 0
where mandant_id = 1
;

update _snapshot_1 
set /*menge = 0 ,*/
    umsatz_netto = 0,
    betrag_ek_nettonetto = 0,
    betrag_ek_mep = 0,
    betrag_einstandspreis = 0,
    betrag_logkostenzuschlag = 0,
    betrag_ek_mep_vor_fwu = 0
where mandant_id > 1
;

update  _snapshot_1 
   set  menge = b.menge,
        umsatz_netto = b.umsatz_netto,
        wrg_id = b.wrg_1,
        betrag_ek_nettonetto = b.ek_nettonetto,
        betrag_ek_mep = b.ek_mep,
        betrag_einstandspreis = b.einstandspreis,
        betrag_logkostenzuschlag = b.logkostenzuschlag,
        betrag_ek_mep_vor_fwu = b.ek_mep_vor_fwu
  from  (select * from _absatz_konsolidiert) b
 where  _snapshot.mandant_id = b.mandant_id and
        _snapshot.kjwo = b.kjwo and
        _snapshot.wup_id = b.wup_id and
        _snapshot.art_id = b.art_id
;

update  _snapshot_1 
   set  menge_abschrift_22       = b.menge_abschrift_22,
        abschriftbetrag_netto_22 = b.abschriftbetrag_netto_22,
        menge_abschrift_122      = b.menge_abschrift_122,
        abschriftbetrag_netto_122= b.abschriftbetrag_netto_122,
        wrg_id                   = b.wrg_id
  from (select * from _abschrift_konsolidiert) b
 where  _snapshot.mandant_id = b.mandant_id and
        _snapshot.kjwo = b.kjwo and
        _snapshot.wup_id = b.wup_id and
        _snapshot.art_id = b.art_id
;

update  dbp_etl.as_food_det_final_1
   set  menge = b.menge,
        umsatz_netto = b.umsatz_netto,
        menge_abschrift_22 = b.menge_abschrift_22,
        abschriftbetrag_netto_22 = b.abschriftbetrag_netto_22,
        menge_abschrift_122 = b.menge_abschrift_122,
        abschriftbetrag_netto_122 = b.abschriftbetrag_netto_122,
        wrg_id = b.wrg_id
  from (select *
        from _snapshot_1) b	
 where  dbp_etl.as_food_det_final.mandant_id    = b.mandant_id and
        dbp_etl.as_food_det_final.kjwo          = b.kjwo and
        dbp_etl.as_food_det_final.wup_id        = b.wup_id and
        dbp_etl.as_food_det_final.art_id        = b.art_id and
        dbp_etl.as_food_det_final.dat_auslistung= b.dat_auslistung
;

-- kmo (preisaenderung fuer abgeschlossene)
update  dbp_etl.as_food_det_final_1
   set  menge_abschrift_22      = case when b.diff_wert_bestand_netto <> 0 then 1 else 0 end,
        abschriftbetrag_netto_22= b.diff_wert_bestand_netto,
        menge_berechnet         = case when b.diff_wert_bestand_netto <> 0 then 1 else 0 end,
        diff_wert_bestand_netto = b.diff_wert_bestand_netto,
        wrg_id                  = b.wrg_id
  from (select  a.mandant_id,
                a.art_id,
                a.wup_id,
                a.nb_id,
                a.kjwo,
                a.dat_auslistung,
                b.wrg_id,
                (a.phase_vk_netto-b.phase_vk_netto)*a.menge as diff_wert_bestand_netto
	  from _snapshot_1 a
	  join (select  mandant_id,
                        art_id,
                        wup_id,
                        nb_id,
                        dat_auslistung, 
                        max(wrg_id) wrg_id,
                        phase_vk_netto
			from dbp_etl.as_food_det_final_1
			where phase_id = 0 and
				  mandant_id > 1
			group by 1,2,3,4,5,7
                ) b
            on  a.mandant_id = b.mandant_id and
                a.art_id = b.art_id and
                a.wup_id = b.wup_id and
                a.nb_id = b.nb_id and
                a.dat_auslistung = b.dat_auslistung
        ) b
where dbp_etl.as_food_det_final.mandant_id      = b.mandant_id and
      dbp_etl.as_food_det_final.wup_id          = b.wup_id and
      dbp_etl.as_food_det_final.nb_id           = b.nb_id and
      dbp_etl.as_food_det_final.art_id          = b.art_id and
      dbp_etl.as_food_det_final.kjwo            = b.kjwo and
      dbp_etl.as_food_det_final.dat_auslistung  = b.dat_auslistung
;

/*select dat_final*/
create or replace table dbp_etl.as_food_upd_1 as 
select 
   max(dat_auslistung) as dat_auslistung, max(kjwo) as kjwo, mandant_id, wup_id, nb_id, art_id, dat_final from dbp_etl.as_food_final_1
join dbp_data.tag_1 
 on dat_final = dat
where dat_final is not null
and dat_final > dat_auslistung 
group by all;


/*set dat_final*/
update dbp_etl.as_food_det_final_1
set dat_final = dat_final_
    from (select 
            t1.kjwo as dat_final_woche_, 
            t1.mandant_id as mandant_id_,
            t1.wup_id as wup_id_,
            t1.nb_id as nb_id_,
            t1.art_id as art_id_,
            t1.dat_final as dat_final_,
            t1.dat_auslistung as dat_auslistung_
          from dbp_etl.as_food_upd_1 t1_1
         ) dt1 
where
    mandant_id = mandant_id_
and wup_id = wup_id_
and art_id = art_id_
and kjwo = dat_final_woche_
and dat_auslistung = dat_auslistung_
;


/*set dat_final for next kjwo where dat_final > dat_auslistung and erl_kz = 'D'*/
create or replace table dbp_etl.as_food_upd_1 as
select
    mandant_id, 
    wup_id,
    nb_id,
    art_id,
    dat_final, 
    erl_kz,
    dat_auslistung,
    kjwo,
    ROW_NUMBER() OVER (PARTITION BY mandant_id,wup_id,nb_id,art_id order by dat_final desc,dat_auslistung desc,kjwo desc) AS rn
  from dbp_etl.as_food_final_1
join dbp_data.tag_1 
 on dat_final = dat
where dat_final is not null
--and erl_kz <> 'D' --
and erl_kz = 'D' 
and dat_final > dat_auslistung
;


update dbp_etl.as_food_det_final_1
	set dat_final = dat_final_
	    from (select 
	            t1.kjwo as dat_final_woche_, 
	            t1.mandant_id as mandant_id_,
	            t1.wup_id as wup_id_,
	            t1.nb_id as nb_id_,
	            t1.art_id as art_id_,
	            t1.dat_final as dat_final_,
	            t1.dat_auslistung as dat_auslistung_,
	            t1.erl_kz as erl_kz_
	          from dbp_etl.as_food_upd_1 t1_1
	          where rn = 1 
	         ) dt1 
	where
	    mandant_id = mandant_id_
	and wup_id = wup_id_
	and art_id = art_id_
	and kjwo >= dat_final_woche_
    and dat_final_ > dat_auslistung
    /*and dat_final > dat_auslistung*/ 
;

/* set erkl_kz = 'D' where dat_final is not null*/
create or replace table dbp_etl.as_food_upd_1 as 
 select
    mandant_id, 
    wup_id,
    nb_id,
    art_id,
    dat_final, 
    erl_kz,
    dat_auslistung,
    kjwo,
    ROW_NUMBER() OVER (PARTITION BY mandant_id,wup_id,nb_id,art_id order by dat_final desc,dat_auslistung desc,kjwo desc) AS rn
  from  dbp_etl.as_food_final_1 
join dbp_data.tag_1 
 on dat_final = dat
where dat_final is not null
and erl_kz = 'D' 
and dat_final > dat_auslistung
;


update dbp_etl.as_food_det_final_1
set erl_kz = erl_kz_
    from (select 
           -- t1.rn,
            t1.kjwo as dat_final_woche_, 
            t1.mandant_id as mandant_id_,
            t1.wup_id as wup_id_,
            t1.nb_id as nb_id_,
            t1.art_id as art_id_,
            t1.dat_final as dat_final_,
            t1.dat_auslistung as dat_auslistung_,
            t1.erl_kz as erl_kz_
          from dbp_etl.as_food_upd_1 t1_1
          where rn = 1
         ) dt1 
where
    mandant_id = mandant_id_
and wup_id = wup_id_
and art_id = art_id_
and kjwo >= dat_final_woche_
and dat_final > dat_auslistung_
;

/* update erl_kz where dat_final is null*/
create or replace table dbp_etl.as_food_upd_1 as 
 select
    mandant_id, 
    wup_id,
    nb_id,
    art_id,
    dat_final, 
    erl_kz,
    dat_auslistung,
    kjwo,
    ROW_NUMBER() OVER (PARTITION BY mandant_id,wup_id,nb_id,art_id order by dat_aend desc,dat_auslistung desc,kjwo desc) AS rn
  from dbp_etl.as_food_final_1
join dbp_data.tag_1 
 on dat_aend = dat
where dat_final is null
;

update dbp_etl.as_food_det_final_1
set erl_kz = erl_kz_
    from (select 
            t1.kjwo as dat_final_woche_, 
            t1.mandant_id as mandant_id_,
            t1.wup_id as wup_id_,
            t1.nb_id as nb_id_,
            t1.art_id as art_id_,
            t1.dat_auslistung as dat_auslistung_,
            t1.erl_kz as erl_kz_
          from dbp_etl.as_food_upd_1 t1_1
         ) dt1 
where
    mandant_id = mandant_id_
and wup_id = wup_id_
and art_id = art_id_
and kjwo = dat_final_woche_
and dat_auslistung = dat_auslistung_
;
																							   
/*set as_final_status_id = 2*/

update dbp_etl.as_food_det_final_1

set as_final_status_id = 2

from (select t3.kjwo as dat_final_woche_,
             t4.kjwo as max_woche_,
             t1.mandant_id as mandant_id_,
             t1.wup_id as wup_id_,
             t1.nb_id as nb_id_,
             t1.art_id as art_id_,
             t1.dat_final as dat_final_,
             t1.erl_kz as erl_kz_
      from dbp_etl.as_food_final_1 t1_1
      join dbp_data.tag_1 t3
        on t1.dat_final = t3.dat
      join dbp_data.woche_1 t4
        on t3.akt_wo+1 = t4.akt_wo 
      where t1.erl_kz <> 'D' and 
            t1.dat_final is not null) dt1 
where mandant_id = mandant_id_ and 
      wup_id = wup_id_ and 
      art_id = art_id_ and 
      erl_kz <> 'D' and 
      dat_final is not null and 
      kjwo between dat_final_woche_ and max_woche_
;

delete from dbp_data.as_food_1
where (mandant_id,wup_id,nb_id,art_id,dat_auslistung) in (select mandant_id,wup_id,nb_id,art_id,dat_auslistung from dbp_etl.as_food_final_1)
;

insert into dbp_data.as_food_1 (art_id
                             ,mandant_id
                             ,nb_id
                             ,wup_id
                             ,dat_auslistung
                             ,gp_id
                             ,phase_status
                             ,erl_fg
                             ,dat_final
                             ,menge_startbestand
                             ,vk_netto
                             ,menge_endbestand
                             ,erl_kz
                             ,dat_aend
                             ,wrg_id
                             ,td_insert
                             ,td_update)
select a.art_id
      ,a.mandant_id
      ,a.nb_id
      ,a.wup_id
      ,a.dat_auslistung
      ,a.gp_id
      ,a.phase_status
      ,a.erl_fg
      ,a.dat_final
      ,a.menge_startbestand
      ,a.vk_netto
      ,a.menge_endbestand
      ,a.erl_kz
      ,a.dat_aend
      ,b.default_wrg as wrg_id
      ,current_timestamp
      ,current_timestamp
from dbp_etl.as_food_final_1 a
join dbp_data.mandant_1 b
  on a.mandant_id = b.mandant_id
;

delete from dbp_data.as_food_det_1
where (mandant_id,wup_id,nb_id,art_id,dat_auslistung,kjwo) in (select mandant_id,wup_id,nb_id,art_id,dat_auslistung,kjwo from dbp_etl.as_food_det_final_1)
;

insert into dbp_data.as_food_det_1 (art_id
                                 ,mandant_id
                                 ,nb_id
                                 ,wup_id
                                 ,dat_auslistung
                                 ,phase_id
                                 ,kjwo
                                 ,phase_wo
                                 ,phase_vk_brutto
                                 ,phase_vk_netto
                                 ,menge_totalabschrift
                                 ,betrag_totalabschrift_netto
                                 ,menge_preisabschrift
                                 ,betrag_preisabschrift_netto
                                 ,menge_endbestand_phase
                                 ,menge_absatz
                                 ,umsatz_netto
                                 ,td_insert
                                 ,td_update
                                 ,wrg_id
                                 ,dat_final
                                 ,erl_kz
                                 ,as_final_status_id
                                 ,betrag_ek_nettonetto
                                 ,betrag_ek_mep
                                 ,betrag_einstandspreis
                                 ,betrag_logkostenzuschlag
                                 ,betrag_ek_mep_vor_fwu)
select a.art_id
      ,a.mandant_id
      ,a.nb_id
      ,a.wup_id
      ,a.dat_auslistung
      ,a.phase_id
      ,a.kjwo
      ,a.phase_wo
      ,a.phase_vk_brutto
      ,a.phase_vk_netto
      ,case when a.mandant_id = 1 then a.menge_abschrift_122 else -1*abs(a.menge_abschrift_122) end as menge_totalabschrift
      ,case when a.mandant_id = 1 then a.abschriftbetrag_netto_122 else -1*abs(a.abschriftbetrag_netto_122) end as betrag_totalabschrift_netto
      ,a.menge_abschrift_22 as menge_preisabschrift
      ,a.abschriftbetrag_netto_22 as betrag_preisabschrift_netto
      ,a.menge_endbestand_phase
      ,a.menge as menge_absatz
      ,a.umsatz_netto
      ,current_timestamp as td_insert
      ,current_timestamp as td_update
      ,c.default_wrg as wrg_id
      ,a.dat_final
      ,a.erl_kz
      ,a.as_final_status_id
      ,a.betrag_ek_nettonetto
      ,a.betrag_ek_mep
      ,a.betrag_einstandspreis
      ,a.betrag_logkostenzuschlag
      ,a.betrag_ek_mep_vor_fwu
from dbp_etl.as_food_det_final_1 a
join (select max(kjwo_kl) as kjwo_kl, kjwo from dbp_data.woche_kj_kl_1 group by kjwo) b
  on a.kjwo = b.kjwo
join dbp_data.mandant_1 c
  on a.mandant_id = c.mandant_id
;

-- vorbereitung fuers bestandstracking

create or replace volatile table _sonntag as (
select dat,
       kjwo
from dbp_data.tag_1
where wtag_id = 7 and
      akt_wo between -2 and 0
group by 1,2
);

create or replace volatile table _mbst as (
select a.mandant_id,
       a.wup_id,
       a.art_id,
       b.kjwo,
       a.menge_lgbest_erp_frei_bme
from dbp_data.marktbestand_erp_1 a
join _sonntag b
  on a.dat = b.dat
group by 1,2,3,4,5
);

delete from dbp_etl_process.as_food_mbst_1
where kjwo in (select kjwo from _mbst)
;

insert into dbp_etl_process.as_food_mbst_1 (mandant_id
                                         ,wup_id
                                         ,art_id
                                         ,kjwo
                                         ,menge_lgbest_erp_frei_bme)
select mandant_id
      ,wup_id
      ,art_id
      ,kjwo
      ,menge_lgbest_erp_frei_bme
from _mbst
;

update dbp_data.as_food_det_1 from (select *
                                  from dbp_etl_process.as_food_mbst_1
                                  where kjwo < (select kjwo from dbp_data.woche_1 where akt_wo = 0)) b
                                                  
set menge_endbestand = b.menge_lgbest_erp_frei_bme

where dbp_data.as_food_det.mandant_id = b.mandant_id and
      dbp_data.as_food_det.wup_id = b.wup_id and
      dbp_data.as_food_det.art_id = b.art_id and
      dbp_data.as_food_det.kjwo = b.kjwo
;

create or replace volatile table _gestern as (
select dat,
       kjwo
from dbp_data.tag_1
where dat = current_date-1
group by 1,2
);

create or replace volatile table _mbst as (
select a.mandant_id,
       a.wup_id,
       a.art_id,
       b.kjwo,
       a.menge_lgbest_erp_frei_bme
from dbp_data.marktbestand_erp_1 a
join _gestern b
  on a.dat = b.dat
group by 1,2,3,4,5
);

update dbp_data.as_food_det_1 from (select *
                                  from _mbst) b
                                                  
set menge_endbestand = b.menge_lgbest_erp_frei_bme

where dbp_data.as_food_det.mandant_id = b.mandant_id and
      dbp_data.as_food_det.wup_id = b.wup_id and
      dbp_data.as_food_det.art_id = b.art_id and
      dbp_data.as_food_det.kjwo = b.kjwo
;

-- as_final_status_id-updates

update dbp_data.as_food_det_1 set as_final_status_id = 0;

create or replace table dbp_etl.asf_1  as (
select mandant_id, 
       wup_id,
       nb_id,
       art_id,
       dat_final, 
       erl_kz,
       dat_auslistung,
       kjwo,
       ROW_NUMBER() OVER (PARTITION BY mandant_id,wup_id,nb_id,art_id,dat_auslistung order by kjwo,dat_final) as rn
from dbp_data.as_food_det_1
where dat_final is not null and 
      erl_kz = 'D' and 
      dat_final > dat_auslistung
);

create or replace table dbp_etl.update_as__1 as (
select t3.*,
       t2.kjwo as kjwo_artbew
from dbp_data.artbew_1 t1_1
join dbp_data.tag_1 t2
  on t1.dat = t2.dat
join dbp_etl.asf_1 t3
  on t1.art_id = t3.art_id and 
     t1.mandant_id = t3.mandant_id and 
     t1.wup_id = t3.wup_id
where t2.kjwo between t3.kjwo+1 and t3.kjwo+5 and
      t1.menge > 0 and 
      t3.rn = 1
group by all
);

update dbp_data.as_food_det_1
set as_final_status_id = 1
from (select distinct
             t1.kjwo_artbew as dat_final_woche_, 
             t1.mandant_id as mandant_id_,
             t1.wup_id as wup_id_,
             t1.nb_id as nb_id_,
             t1.art_id as art_id_,
             t1.dat_final as dat_final_,
             t1.dat_auslistung as dat_auslistung_,
             t1.erl_kz as erl_kz_
      from dbp_etl.update_as__1 t1_1) dt1 
where mandant_id = mandant_id_ and
      wup_id = wup_id_ and
      art_id = art_id_ and
      nb_id = nb_id_ and 
      dat_final = dat_final_ and
      dat_auslistung = dat_auslistung_ and
      kjwo = dat_final_woche_ and
      erl_kz = erl_kz_ and
      menge_absatz > 0
;

create or replace volatile table _schrott as (
select mandant_id,
       dat_auslistung,
       min(kjwo) as kjwo,
       wup_id,
       art_id,
       dat_final
from dbp_data.as_food_det_1
where dat_final is not null
group by all
);

update dbp_data.as_food_det_1 from (select *
                                  from _schrott) b
                                  
set dat_final = b.dat_final

where dbp_data.as_food_det.mandant_id = b.mandant_id and
      dbp_data.as_food_det.wup_id = b.wup_id and
      dbp_data.as_food_det.art_id = b.art_id and
      dbp_data.as_food_det.dat_auslistung = b.dat_auslistung and
      dbp_data.as_food_det.kjwo > b.kjwo and
      coalesce(dbp_data.as_food_det.dat_final,'9999-12-31') <> b.dat_final
;

update dbp_data.as_food_det_1
set as_final_status_id = 2
from (select t3.kjwo as dat_final_woche_,
             t5.kjwo as max_woche_,
             t1.mandant_id as mandant_id_,
             t1.wup_id as wup_id_,
             t1.nb_id as nb_id_,
             t1.art_id as art_id_,
             t1.dat_auslistung as dat_auslistung_,
             t1.dat_final as dat_final_
      from dbp_data.as_food_det_1 t1_1
      join dbp_data.as_food_1 t2
        on t1.mandant_id = t2.mandant_id and
           t1.art_id = t2.art_id and
           t1.wup_id = t2.wup_id and
           t1.dat_auslistung = t2.dat_auslistung
      join dbp_data.tag_1 t3
        on t1.dat_final = t3.dat
      join dbp_data.woche_1 t4
        on t3.akt_wo = t4.akt_wo
      join (select mandant_id,
                   wup_id,
                   art_id,
                   kjwo
            from dbp_data.as_food_det_1
            where kjwo <= (select distinct kjwo from dbp_data.woche_1 where akt_wo = 0)
            group by 1,2,3,4) t5
        on t1.mandant_id = t5.mandant_id and
           t1.art_id = t5.art_id and
           t1.wup_id = t5.wup_id and
           t1.kjwo = t5.kjwo
      where t1.erl_kz <> 'D' and 
            t1.dat_final is not null and
            t1.menge_endbestand > 0
      group by all) dt1 
where mandant_id = mandant_id_ and
      wup_id = wup_id_ and
      art_id = art_id_ and
      erl_kz <> 'D' and 
      dat_auslistung = dat_auslistung_ and
      dat_final is not null and
      kjwo = max_woche_
;

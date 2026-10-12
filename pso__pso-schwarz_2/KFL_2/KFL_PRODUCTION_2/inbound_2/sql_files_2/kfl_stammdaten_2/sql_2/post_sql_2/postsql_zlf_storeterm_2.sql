create or replace table dbp_etl.zlf_storeterm_xxx_2 (
 mandant_id                     byteint
,wup_id                         integer
,nb_id                          smallint
,kunde_id                       integer
,wg_id                          smallint
,arthiertyp_id                  byteint
,sortimentslistenart_id         char(1) collate 'en-ci'
,terminierungsgruppe_1_id       char(3) collate 'en-ci'
,terminierungsgruppe_2_id       char(2) collate 'en-ci'
,terminierungsgruppe_3_id       char(2) collate 'en-ci'
,kwoab                          date
,kwobi                          date
,auslieferungsgruppe_id         char(4) collate 'en-ci'
,disposition_rhythmus_ltf_id    char(3) collate 'en-ci'
,we_bearbeitungszeit            smallint
,planlieferzeit                 smallint
,td_insert                      timestamp_ltz(9)
);

insert into dbp_etl.zlf_storeterm_xxx_2 (mandant_id,
                                       wup_id,
                                       nb_id,
                                       kunde_id,
                                       wg_id,
                                       arthiertyp_id,
                                       sortimentslistenart_id,
                                       terminierungsgruppe_1_id,
                                       terminierungsgruppe_2_id,
                                       terminierungsgruppe_3_id,
                                       kwoab,
                                       kwobi,
                                       auslieferungsgruppe_id,
                                       disposition_rhythmus_ltf_id,
                                       we_bearbeitungszeit,
                                       planlieferzeit)
select a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.kunde_id,
       b.wg_id,
       a.arthiertyp_id,
       b.sortimentslistenart_id,
       a.terminierungsgruppe_1_id,
       a.terminierungsgruppe_2_id,
       a.terminierungsgruppe_3_id,
       coalesce(c.wo_dat_von,to_date('1900-01-01','yyyy-mm_2-dd')) ,
       coalesce(d.wo_dat_bis,to_date('9999-12-31','yyyy-mm_2-dd')) ,
       a.auslieferungsgruppe_id,
       a.disposition_rhythmus_ltf_id,
       a.we_bearbeitungszeit,
       a.planlieferzeit
from ${TEMP_TABLE} a
join (select auslieferungsgruppe_id,
             wg_id,
             sortimentslistenart_id
      from dbp_etl.zlf_auslfel_zwischenspeicher_2
      group by 1,2,3) b
  on a.auslieferungsgruppe_id = b.auslieferungsgruppe_id
left join dbp_data.woche_2 c
  on a.kwoab = c.kjwo
left join dbp_data.woche_2 d
  on a.kwobi = d.kjwo
where a.nb_id = -111
;

delete from dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_2
where (mandant_id,wup_id,kunde_id,wg_id,terminierungsgruppe_1_id,terminierungsgruppe_2_id,terminierungsgruppe_3_id,auslieferungsgruppe_id) in (select mandant_id,
                                                                                                                                                      wup_id,
                                                                                                                                                      kunde_id,
                                                                                                                                                      wg_id,
                                                                                                                                                      terminierungsgruppe_1_id,
                                                                                                                                                      terminierungsgruppe_2_id,
                                                                                                                                                      terminierungsgruppe_3_id,
                                                                                                                                                      auslieferungsgruppe_id
                                                                                                                                               from dbp_etl.zlf_storeterm_xxx_2)
;

insert into dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_2 (mandant_id,
                                                            wup_id,
                                                            nb_id,
                                                            kunde_id,
                                                            wg_id,
                                                            arthiertyp_id,
                                                            sortimentslistenart_id,
                                                            terminierungsgruppe_1_id,
                                                            terminierungsgruppe_2_id,
                                                            terminierungsgruppe_3_id,
                                                            dat_von,
                                                            dat_bis,
                                                            auslieferungsgruppe_id,
                                                            disposition_rhythmus_ltf_id,
                                                            we_bearbeitungszeit,
                                                            planlieferzeit)
select mandant_id,
       wup_id,
       nb_id,
       kunde_id,
       wg_id,
       arthiertyp_id,
       min(sortimentslistenart_id) as sortimentslistenart_id,
       terminierungsgruppe_1_id,
       terminierungsgruppe_2_id,
       terminierungsgruppe_3_id,
       kwoab,
       kwobi,
       auslieferungsgruppe_id,
       max(disposition_rhythmus_ltf_id) as disposition_rhythmus_ltf_id,
       max(we_bearbeitungszeit) as we_bearbeitungszeit,
       max(planlieferzeit) as planlieferzeit
from dbp_etl.zlf_storeterm_xxx_2
group by 1,2,3,4,5,6,8,9,10,11,12,13
;

update dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_2
set   dat_bis = dt1.dat_bis
from
(
select l.mandant_id,
       l.wg_id,
       l.wup_id,
       l.kunde_id,
       l.terminierungsgruppe_1_id,
       l.terminierungsgruppe_2_id,
       l.terminierungsgruppe_3_id,
       l.auslieferungsgruppe_id,
       l.dat_von,
       case
         when (sum(to_number(to_char(dat_von,'yyyymmdd'))) over (partition by mandant_id,wup_id,wg_id,kunde_id,terminierungsgruppe_1_id,terminierungsgruppe_2_id,terminierungsgruppe_3_id,auslieferungsgruppe_id order by dat_von desc nulls last rows between 1 preceding and current row) - to_number(to_char(dat_von,'yyyymmdd'))) = 0 
         then to_date('9999-12-31','yyyy-mm_2-dd')
         else dateadd(day,-1,to_date(to_char((sum(to_number(to_char(dat_von,'yyyymmdd'))) over (partition by mandant_id,wup_id,wg_id,kunde_id,terminierungsgruppe_1_id,terminierungsgruppe_2_id,terminierungsgruppe_3_id,auslieferungsgruppe_id order by dat_von desc nulls last rows between 1 preceding and current row) - to_number(to_char(dat_von,'yyyymmdd')))),'yyyymmdd'))
       end as dat_bis
  from dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_2 l
  group by 1,2,3,4,5,6,7,8,9
) dt1
where dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.mandant_id  = dt1.mandant_id
  and dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.wup_id  = dt1.wup_id
  and dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.kunde_id = dt1.kunde_id
  and dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.wg_id = dt1.wg_id
  and dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.terminierungsgruppe_1_id = dt1.terminierungsgruppe_1_id
  and dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.terminierungsgruppe_2_id = dt1.terminierungsgruppe_2_id
  and dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.terminierungsgruppe_3_id = dt1.terminierungsgruppe_3_id
  and dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.auslieferungsgruppe_id = dt1.auslieferungsgruppe_id
  and dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.dat_von = dt1.dat_von
  and dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per.dat_bis <> dt1.dat_bis
;

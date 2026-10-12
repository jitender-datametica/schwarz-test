create or replace volatile table _zwischen1_2 as (
select mandant_id,
       wup_id,
       nb_id,
       dat,
       wup_abschrift_id,
       positionsnummer_id,
       abschriftart_id,
       art_id,
       max(wrg_id) as wrg_id,
       max(woche_id) as woche_id,
       max(wv_kz) as wv_kz,
       max(wv_grund_id) as wv_grund_id,
       max(abschrift_menge_einh_id) as abschrift_menge_einh_id,
       max(lastupd_dat) as lastupd_dat,
       sum(menge_abschrift) as menge_abschrift,
       sum(abschriftbetrag_netto) as abschriftbetrag_netto,
       sum(abschriftbetrag_brutto) as abschriftbetrag_brutto,
       max(vk_aktion_brutto) as vk_aktion_brutto,
       max(vk_brutto) as vk_brutto
from ${TEMP_TABLE}
group by 1,2,3,4,5,6,7,8
);

delete from dbp_data.marktabschriften_2
where (wup_id,wup_abschrift_id,positionsnummer_id,nb_id,dat,mandant_id,abschriftart_id,art_id) in (select wup_id,wup_abschrift_id,positionsnummer_id,nb_id,dat,mandant_id,abschriftart_id,art_id from _zwischen1_2)
;

insert into dbp_data.marktabschriften_2 (wup_id,
                                       wup_abschrift_id,
                                       positionsnummer_id,
                                       nb_id,
                                       dat,
                                       mandant_id,
                                       lastupd_dat,
                                       woche_id,
                                       menge_abschrift,
                                       abschriftart_id,
                                       art_id,
                                       abschriftbetrag_netto,
                                       abschriftbetrag_brutto,
                                       wrg_id,
                                       wv_kz,
                                       wv_grund_id,
                                       vk_aktion_brutto,
                                       vk_brutto,
                                       td_insert,
                                       td_update,
                                       abschrift_menge_einh_id)
select wup_id,
       wup_abschrift_id,
       positionsnummer_id,
       nb_id,
       dat,
       mandant_id,
       lastupd_dat,
       woche_id,
       menge_abschrift,
       abschriftart_id,
       art_id,
       abschriftbetrag_netto,
       abschriftbetrag_brutto,
       wrg_id,
       wv_kz,
       wv_grund_id,
       vk_aktion_brutto,
       vk_brutto,
       current_timestamp as td_insert,
       current_timestamp as td_update,
       abschrift_menge_einh_id
from _zwischen1_2
;

drop table if exists dbp_etl.marktabschriften_agg_dat_2;
create table dbp_etl.marktabschriften_agg_dat_2  (
  wup_id              integer not null,
  nb_id               smallint not null,
  dat                 date,
  mandant_id          byteint not null
);

insert into dbp_etl.marktabschriften_agg_dat_2 (wup_id            
                                             ,nb_id
                                             ,dat
                                             ,mandant_id)
select wup_id
      ,nb_id
      ,dat
      ,mandant_id
from ${TEMP_TABLE}
group by 1,2,3,4
;

delete from dbp_data.marktabschriften_wg_sum_2
where (wup_id,nb_id,dat,mandant_id) in (select wup_id,nb_id,dat,mandant_id from dbp_etl.marktabschriften_agg_dat_2)
;

insert into dbp_data.marktabschriften_wg_sum_2 (wup_id                
                                             ,nb_id
                                             ,dat
                                             ,mandant_id
                                             ,wg_id
                                             ,abschriftart_id
                                             ,wrg_id
                                             ,arthiertyp_id
                                             ,abschriftbetrag_netto
                                             ,abschriftbetrag_brutto)
select t1.wup_id
      ,t1.nb_id
      ,t1.dat
      ,t1.mandant_id
      ,t2.wg_id
      ,t1.abschriftart_id
      ,t1.wrg_id
      ,t2.arthiertyp_id
      ,sum(t1.abschriftbetrag_netto)
      ,sum(t1.abschriftbetrag_brutto)
from dbp_data.marktabschriften_2 t1_2
join dbp_data.art_wg_zu_per_2 t2
  on t1.mandant_id = t2.mandant_id and
     t1.art_id = t2.art_id and
     t1.dat between t2.dat_von and t2.dat_bis and 
     t2.arthiertyp_id = 2
where (t1.wup_id,t1.nb_id,t1.dat,t1.mandant_id) in (select wup_id,nb_id,dat,mandant_id from dbp_etl.marktabschriften_agg_dat_2)
group by 1,2,3,4,5,6,7,8
;

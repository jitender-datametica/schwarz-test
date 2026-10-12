update dbp_etl.marktbestand_erp_tmp from (select *
                                          from dbp_data.mandant) b

set wrg_id = b.default_wrg

where dbp_etl.marktbestand_erp_tmp.mandant_id = b.mandant_id
;                                       

insert into dbp_data.marktbestand_erp_zu (bestand_id,
                                          mandant_id,
                                          ek_netto,
                                          ek_netto_bnk,
                                          vk_netto,
                                          wrg_id,
                                          ek_nettonetto,
                                          einstandspreis,
                                          td_insert,
                                          td_update)
select b.bestand_id + row_number() over (partition by a.mandant_id order by null) as bestand_id,
       a.mandant_id,
       a.ek_netto,
       a.ek_netto_bnk,
       a.vk_netto,
       a.wrg_id,
       a.ek_nettonetto,
       a.einstandspreis,
       current_timestamp as td_insert,
       current_timestamp as td_update
from (select mandant_id,
             ek_netto,
             ek_netto_bnk,
             vk_netto,
             wrg_id,
             ek_nettonetto,
             einstandspreis
      from dbp_etl.marktbestand_erp_tmp
      where (mandant_id,ek_netto,ek_netto_bnk,vk_netto,wrg_id,ek_nettonetto,einstandspreis) not in (select mandant_id,ek_netto,ek_netto_bnk,vk_netto,wrg_id,ek_nettonetto,einstandspreis from dbp_data.marktbestand_erp_zu)
      group by 1,2,3,4,5,6,7) a
join (select mandant_id,
             max(bestand_id) as bestand_id
      from dbp_data.marktbestand_erp_zu
      group by 1) b
  on a.mandant_id = b.mandant_id
;

create or replace volatile table _perf as (
select mandant_id,
       ek_netto,
       ek_netto_bnk,
       vk_netto,
       ek_nettonetto,
       einstandspreis
from dbp_etl.marktbestand_erp_tmp
group by 1,2,3,4,5,6
);

update dbp_data.marktbestand_erp from (select t1.mandant_id _mandant_id
                                             ,t1.wup_id _wup_id
                                             ,t1.art_id _art_id
                                             ,t1.relevant_fg _relevant_fg
                                             ,t1.bezugsweg_id _bezugsweg_id
                                             ,max(t2.bestand_id) _bestand_id
                                       from dbp_etl.marktbestand_erp_tmp t1
                                       join (select *
                                             from dbp_data.marktbestand_erp_zu
                                             where (mandant_id,ek_netto,ek_netto_bnk,vk_netto,ek_nettonetto,einstandspreis) in (select mandant_id,ek_netto,ek_netto_bnk,vk_netto,ek_nettonetto,einstandspreis from _perf)) t2
                                         on t1.ek_netto = t2.ek_netto and 
                                            t1.ek_netto_bnk = t2.ek_netto_bnk and 
                                            t1.vk_netto = t2.vk_netto and 
                                            t1.wrg_id = t2.wrg_id and 
                                            t1.ek_nettonetto = t2.ek_nettonetto and
                                            t1.einstandspreis = t2.einstandspreis and
                                            t1.mandant_id = t2.mandant_id
                                       group by all) dt1

set relevant_fg = _relevant_fg
   ,bestand_id = _bestand_id
   ,bezugsweg_id = _bezugsweg_id
   ,td_update = current_timestamp 

where mandant_id = _mandant_id and 
      wup_id = _wup_id and 
      art_id = _art_id and 
      dat = current_date - ${LOOP_ID}
;

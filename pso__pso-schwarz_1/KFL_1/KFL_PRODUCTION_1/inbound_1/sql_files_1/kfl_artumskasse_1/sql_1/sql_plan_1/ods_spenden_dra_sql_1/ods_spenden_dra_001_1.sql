drop table if exists dbp_etl.dra_wup_tag_tmp_1;
create table dbp_etl.dra_wup_tag_tmp_1 like dbp_data.dra_wup_tag_1;
create or replace table dbp_etl.dra_wup_tag_dat_1 (bon_dat date not null);

insert into dbp_etl.dra_wup_tag_dat_1 (bon_dat)
select k.bon_dat as bon_dat
from dbp_ods.ods_bon_kopf_1 k 
join dbp_ods.ods_bon_financial_1 f
  on k.bon_id = f.bon_id and 
     k.mandant_id = f.mandant_id and 
     k.wup_id = f.wup_id and 
     k.bon_dat = f.bon_dat
join dbp_ods.ods_bon_transaction_1 t 
  on t.bon_id = k.bon_id and 
     t.mandant_id = k.mandant_id and 
     t.wup_id = k.wup_id and
     t.bon_dat = k.bon_dat
join dbp_ods.bon_load_status_1 b
  on b.xml_name = t.datei_name and 
     b.artbew_fg = 0  
where k.bon_dat <= current_date - 1 and 
      k.mandant_id = 1 and 
      b.parseBon_Time <= current_timestamp() - interval '10 minute' and 
      financial_grund_id = 112 and 
     (k.bon_id, k.bon_dat) not in (select bon_id,bon_dat from dbp_ods.ods_bon_storno_1) 
group by 1
;

insert into dbp_etl.dra_wup_tag_tmp_1 (mandant_id
                                    ,wup_id
                                    ,dat
                                    ,betrag_dra
                                    ,wrg_id
                                    ,anz_bon)
select k.mandant_id as _mandant_id
      ,k.wup_id as _wup_id
      ,k.bon_dat as _dat
      ,v.umsatz_brutto / v.menge as _betrag_dra
      ,wrg_id
      ,sum(v.menge) as _anz_bon
from dbp_ods.ods_bon_kopf_1 k
join dbp_ods.ods_bon_verkauf_1 v
  on k.mandant_id = v.mandant_id and 
     k.wup_id = v.wup_id and 
     k.bon_id = v.bon_id and
     k.bon_dat = v.bon_dat
join dbp_ods.ods_bon_transaction_1 t
  on t.bon_id = k.bon_id and 
     t.mandant_id = k.mandant_id and 
     t.wup_id = k.wup_id and
     t.bon_dat = k.bon_dat
join dbp_ods.bon_load_status_1 b
  on b.xml_name = t.datei_name
where k.mandant_id = 1 and 
      turnover_fg = 1 and 
      k.bon_dat in (select bon_dat from dbp_etl.dra_wup_tag_dat_1) and 
      b.parsebon_time <= current_timestamp() - interval '10 minute' and 
     (v.mandant_id, v.wg_id) in (select mandant_id, wg_id from dbp_data.wg_filter_zu_1 where arthiertyp_id = 2 and wg_filter_id = 9) and 
      k.kasse_nr not in (100,101) and 
     (k.bon_id, k.bon_dat) not in (select bon_id,bon_dat from dbp_ods.ods_bon_storno_1) 
group by 1,2,3,4,5
;

insert into dbp_etl.dra_wup_tag_tmp_1 (mandant_id
                                    ,wup_id
                                    ,dat
                                    ,betrag_dra
                                    ,wrg_id
                                    ,anz_bon)
select k.mandant_id as _mandant_id
      ,k.wup_id as _wup_id
      ,k.bon_dat as _dat
      ,v.umsatz_brutto / v.menge as _betrag_dra
      ,wrg_id as _wrg_id
      ,sum(v.menge) as _anz_bon
from dbp_ods.ods_bon_kopf_1 k 
join dbp_ods.ods_bon_retoure_1 v
  on k.mandant_id = v.mandant_id and 
     k.wup_id = v.wup_id and 
     k.bon_id = v.bon_id and
     k.bon_dat = v.bon_dat
join dbp_ods.ods_bon_transaction_1 t
  on t.bon_id = k.bon_id and 
     t.mandant_id = k.mandant_id and 
     t.wup_id = k.wup_id and
     t.bon_dat = k.bon_dat
join dbp_ods.bon_load_status_1 b
  on b.xml_name = t.datei_name
where k.mandant_id = 1 and 
      turnover_fg = 1 and 
      k.bon_dat in (select bon_dat from dbp_etl.dra_wup_tag_dat_1) and 
      b.parsebon_time <= current_timestamp() - interval '10 minute' and 
     (v.mandant_id, v.wg_id) in (select mandant_id, wg_id from dbp_data.wg_filter_zu_1 where arthiertyp_id=2 and wg_filter_id=9) and 
      k.kasse_nr not in (100,101) and 
     (k.bon_id, k.bon_dat) not in  (select bon_id,bon_dat from dbp_ods.ods_bon_storno_1) 
group by 1,2,3,4,5
;

insert into dbp_etl.dra_wup_tag_tmp_1 (mandant_id 
                                    ,wup_id
                                    ,dat
                                    ,betrag_dra
                                    ,wrg_id
                                    ,anz_bon)
select k.mandant_id as _mandant_id
      ,k.wup_id as _wup_id
      ,k.bon_dat as _dat
      ,f.umsatz_brutto as _betrag_dra
      ,k.wrg_id as _wrg_id
      ,count(*) as _anz_bon
from dbp_ods.ods_bon_kopf_1 k
join dbp_ods.ods_bon_financial_1 f
  on k.bon_id = f.bon_id and 
     k.mandant_id = f.mandant_id and 
     k.wup_id = f.wup_id and
     k.bon_dat = f.bon_dat
join dbp_ods.ods_bon_transaction_1 t
  on t.bon_id = k.bon_id and 
     t.mandant_id = k.mandant_id and 
     t.wup_id = k.wup_id and
     t.bon_dat = k.bon_dat
join dbp_ods.bon_load_status_1 b
  on b.xml_name = t.datei_name
where k.bon_dat in (select bon_dat from dbp_etl.dra_wup_tag_dat_1) and 
      k.mandant_id = 1 and 
      k.turnover_fg = 1 and 
      b.parseBon_Time <= current_timestamp() - interval '10 minute' and 
      financial_grund_id = 112 and 
     (k.bon_id, k.bon_dat) not in  (select bon_id,bon_dat from dbp_ods.ods_bon_storno_1) 
group by 1,2,3,4,5
;

delete from dbp_data.dra_wup_tag_1
where dat in (select distinct dat from dbp_etl.dra_wup_tag_tmp_1)
;

insert into dbp_data.dra_wup_tag_1 (mandant_id 
                                 ,wup_id
                                 ,dat
                                 ,betrag_dra
                                 ,wrg_id
                                 ,anz_bon
                                 ,td_insert
                                 ,td_update)
select mandant_id 
      ,wup_id  
      ,dat
      ,betrag_dra
      ,wrg_id
      ,sum(anz_bon)
      ,current_timestamp
      ,current_timestamp
from dbp_etl.dra_wup_tag_tmp_1
group by 1,2,3,4,5
;

-- Fehlerhafte Eingaben in der Staging pruefen.
delete from dbp_etl_process.rfi_zfi_fil_transfer_1;

-- 1. Pruefung - Bereits vorhandene Maerkte im Marktstamm werden geprueft.
insert into dbp_etl_process.rfi_zfi_fil_transfer_1
select a.*,
       'Markt vorhanden in dbp_data.wup_1' as rfi_bez
from dbp_etl.zfi_fil_transfer_1 a
where mandant_id = 1 and
      wup_id_neu in (select wup_id from dbp_data.wup_1 where mandant_id = 1 and dat_von <> '2090-12-31' and (orig_wup_id = aktuell_wup_id or wup_id = aktuell_wup_id) and wup_aenderung_grund_id in (0,1))
;

delete from dbp_etl.zfi_fil_transfer_1
where mandant_id = 1 and
      wup_id_neu in (select wup_id from dbp_data.wup_1 where mandant_id = 1 and dat_von <> '2090-12-31' and (orig_wup_id = aktuell_wup_id or wup_id = aktuell_wup_id) and wup_aenderung_grund_id in (0,1))
;

-- 2. Pruefung - Falls es eine_1 Umgliederung ist, muss sich der Buchungskreis aendern.
insert into dbp_etl_process.rfi_zfi_fil_transfer_1
select a.*,
       'Buchungskreis identisch bei Umgliederung' as rfi_bez
from dbp_etl.zfi_fil_transfer_1 a
where mandant_id = 1 and
      wup_aenderung_grund_id in (3,-3) and
      buchungskreis_id = buchungskreis_id_neu
;

delete from dbp_etl.zfi_fil_transfer_1
where mandant_id = 1 and
      wup_aenderung_grund_id in (3,-3) and
      buchungskreis_id = buchungskreis_id_neu
;

-- 3. Pruefung - Falls es ein Umzug/Abriss ist, darf sich der Buchungskreis nicht aendern.
insert into dbp_etl_process.rfi_zfi_fil_transfer_1
select a.*,
       'Buchungskreis unterschiedlich bei Umzug/Abriss' as rfi_bez
from dbp_etl.zfi_fil_transfer_1 a
where mandant_id = 1 and
      wup_aenderung_grund_id in (2,-2) and
      buchungskreis_id <> buchungskreis_id_neu
;

delete from dbp_etl.zfi_fil_transfer_1
where mandant_id = 1 and
      wup_aenderung_grund_id in (2,-2) and
      buchungskreis_id <> buchungskreis_id_neu
;

-- Pruefung Ende.

-- Falls es zukuenftige Eintraege sind, muss hier der Kehrwert als ID eingetragen werden.
update dbp_etl.zfi_fil_transfer_1 set wup_aenderung_grund_id = (-1)*wup_aenderung_grund_id
where dat_von > current_date
;

delete from dbp_etl_process.wup_transfer_per_1
where (mandant_id,wup_id,dat_von) in (select a.mandant_id
                                            ,a.wup_id
                                            ,a.dat_von
                                      from dbp_etl_process.wup_transfer_per_1 a
                                      join dbp_etl.zfi_fil_transfer_1 b
                                        on a.mandant_id = b.mandant_id and
                                           a.wup_id = b.wup_id and
                                           a.dat_von >= b.dat_von
                                      group by 1,2,3)
;
 
insert into dbp_etl_process.wup_transfer_per_1 (mandant_id
                                             ,buchungskreis_id
                                             ,wup_id
                                             ,buchungskreis_id_neu
                                             ,wup_id_neu
                                             ,dat_von
                                             ,dat_bis
                                             ,wup_aenderung_grund_id
                                             ,td_insert
                                             ,td_update)
select mandant_id
      ,buchungskreis_id
      ,wup_id
      ,buchungskreis_id_neu
      ,wup_id_neu
      ,dat_von
      ,dat_bis
      ,wup_aenderung_grund_id
      ,current_timestamp
      ,current_timestamp
from dbp_etl.zfi_fil_transfer_1
;

update dbp_etl_process.wup_transfer_per_1 from (select l.mandant_id
                                                    ,l.wup_id
                                                    ,l.dat_von
                                                    ,case
                                                       when (sum(to_number(to_char(dat_von,'yyyymmdd'))) over (partition by mandant_id,wup_id order by dat_von desc nulls last rows between 1 preceding and current row) - to_number(to_char(dat_von,'yyyymmdd'))) = 0 
                                                       then to_date('9999-12-31','yyyy-mm_1-dd')
                                                       else dateadd(day,-1,to_date(to_char((sum(to_number(to_char(dat_von,'yyyymmdd'))) over (partition by mandant_id,wup_id order by dat_von desc nulls last rows between 1 preceding and current row) - to_number(to_char(dat_von,'yyyymmdd')))),'yyyymmdd'))
                                                     end as dat_bis
                                              from dbp_etl_process.wup_transfer_per_1 l
                                              where mandant_id = 1
                                              group by 1,2,3) dt1

set dat_bis = dt1.dat_bis

where dbp_etl_process.wup_transfer_per.mandant_id  = dt1.mandant_id
  and dbp_etl_process.wup_transfer_per.wup_id  = dt1.wup_id
  and dbp_etl_process.wup_transfer_per.dat_von = dt1.dat_von
  and dbp_etl_process.wup_transfer_per.dat_bis <> dt1.dat_bis
;

-- Falls der Stichtag erreicht worden ist, genau andersrum.
update dbp_etl_process.wup_transfer_per_1 set wup_aenderung_grund_id = (-1)*wup_aenderung_grund_id
where dat_von <= current_date and
      wup_aenderung_grund_id < 0
;

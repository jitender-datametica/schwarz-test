-- 18.10.2024
--
-- Einfuegen und Aktualisieren der neuen Werbehierarchie. Am Ende laeuft es in die
-- wg_per_1 rein.

delete from dbp_data.l_werbeteam_1
where (mandant_id,werbeteam_cd) in (select mandant_id,werbeteam_cd from dbp_msi_data.ts_werbebereich_werbeteam_zu_1)
;

insert into dbp_data.l_werbeteam_1 (mandant_id
                                 ,werbeteam_cd
                                 ,werbebereich_cd
                                 ,werbeteam_bez
                                 ,td_update
                                 ,td_insert)
select mandant_id
      ,werbeteam_cd
      ,werbebereich_cd
      ,werbeteam_bez
      ,current_timestamp as td_update
      ,current_timestamp as td_insert
from dbp_msi_data.ts_werbebereich_werbeteam_zu_1
group by 1,2,3,4,5,6
;

delete from dbp_data.l_werbebereich_1
where (mandant_id,werbebereich_cd) in (select mandant_id,werbebereich_cd from dbp_msi_data.ts_werbebereich_werbeteam_zu_1)
;

insert into dbp_data.l_werbebereich_1 (mandant_id
                                    ,werbebereich_cd
                                    ,werbebereich_bez
                                    ,td_update
                                    ,td_insert)
select mandant_id
      ,werbebereich_cd
      ,werbebereich_cd as werbebereich_bez
      ,current_timestamp as td_update
      ,current_timestamp as td_insert
from dbp_msi_data.ts_werbebereich_werbeteam_zu_1
group by 1,2,3,4,5
;

update dbp_data.wg_per_1 set werbeteam_cd = 'nicht vorhanden';
update dbp_data.wg_per_1 from (select mandant_id
                                   ,wg_id
                                   ,werbeteam_cd
                             from dbp_msi_data.ts_werbebereich_werbeteam_zu_1
                             group by 1,2,3) b
                             
set werbeteam_cd = b.werbeteam_cd

where dbp_data.wg_per.mandant_id = b.mandant_id and
      dbp_data.wg_per.wg_id = b.wg_id and
      dbp_data.wg_per.arthiertyp_id = 2 and
      dbp_data.wg_per.dat_bis = '9999-12-31'
;

-- 06.11.2024
--
-- Hier die Aufbereitung der Aktionsthemen aus den Bondaten, die deutlich genauer sind als die Stammdaten.

create or replace volatile table _bon_aktion as (
select b.mandant_id,
       b.aktion_id,
       b.wup_id,
       b.kl_art_id,
       b.bon_dat
from dbp_ods.ods_bon_kopf_1 a 
join dbp_ods.ods_bon_verkauf_1 b 
  on a.mandant_id = b.mandant_id and 
     a.bon_id = b.bon_id and 
     a.wup_id = b.wup_id and 
     a.bon_dat = b.bon_dat
where a.turnover_fg = 1 and 
      a.kunde_fg = 1 and 
      a.suspended_fg = 0 and 
      b.zeilenstorno_fg = 0 and 
      b.aktion_id is not null and
      a.bon_dat between current_date-10 and current_date
group by 1,2,3,4,5
union
select a.mandant_id,
       b.aktion_id,
       a.wup_id,
       a.kl_art_id,
       a.bon_dat
from dbp_ods.ods_promotion_1 a
join (select b.mandant_id, 
             b.bonuskauf_id,
             max(a.aktion_id) aktion_id
      from dbp_data.aktion_1 a
      left join dbp_data.l_bonuskauf_1 b
        on a.aktion_id = b.aktion_id and 
           a.mandant_id = b.mandant_id
      group by 1,2) b
  on a.bonuskauf_id = b.bonuskauf_id and 
     a.mandant_id = b.mandant_id
where a.bon_dat between current_date-10 and current_date
);

create or replace volatile table _aktion_thema as (
select a.mandant_id,
       a.aktion_id,
       a.wup_id,
       a.kl_art_id,
       a.bon_dat,
       c.dat_von,
       c.dat_bis,
       cast(null as varchar(256)) as aktionsthema
from _bon_aktion a 
join dbp_data.aktion_1 c
  on a.mandant_id = c.mandant_id and 
     a.aktion_id = c.aktion_id
group by 1,2,3,4,5,6,7,8
);
 
create or replace volatile table _bon_aktion_thema as (
select a.mandant_id,
       a.aktion_id,
       a.wup_id,
       a.kl_art_id,
       a.bon_dat,
       a.dat_von,
       a.dat_bis,
       b.aktion_thema_id
from _aktion_thema a
join (select mandant_id,
             aktion_id,
             wup_id,
             case when mandant_id = 1 then floor(art_id/100) else floor(art_id/10) end as kl_art_id,
             aktion_thema_id 
      from dbp_data.aktion_art_wup_zu_1 b
      where nb_id = 0 
      group by 1,2,3,4,5) b
  on a.mandant_id = b.mandant_id and 
     a.aktion_id = b.aktion_id and 
     a.kl_art_id = b.kl_art_id and 
     a.wup_id = b.wup_id
group by 1,2,3,4,5,6,7,8
);
  
create or replace volatile table _bon_aktion_thema_group as (
select mandant_id,
       wup_id,
       kl_art_id,
       bon_dat,
       dat_von,
       dat_bis,
       aktion_thema_id
from _bon_aktion_thema
group by 1,2,3,4,5,6,7
);

delete from dbp_etl_process.bon_aktion_thema_group_1
where bon_dat between current_date-10 and current_date
;

insert into dbp_etl_process.bon_aktion_thema_group_1 (mandant_id,
                                                    wup_id,
                                                    kl_art_id,
                                                    bon_dat,
                                                    dat_von,
                                                    dat_bis,
                                                    aktion_thema_id)
select mandant_id,
       wup_id,
       kl_art_id,
       bon_dat,
       dat_von,
       dat_bis,
       aktion_thema_id
from _bon_aktion_thema_group
where bon_dat between current_date-10 and current_date
;

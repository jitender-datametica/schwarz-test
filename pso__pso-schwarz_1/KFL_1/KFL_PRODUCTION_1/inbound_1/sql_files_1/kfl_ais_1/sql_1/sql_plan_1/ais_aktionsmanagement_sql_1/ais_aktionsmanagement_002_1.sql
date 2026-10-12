-- 18.10.2024
--
-- Rueckwirkende Aktualisierung der Werbeteams und -bereiche im Aktionsmanagement.

create or replace volatile table _murks_1 as (
select mandant_id,
       kjwo_ww,
       kjwo,
       mutter_wb_id,
       gp_id,
       coalesce(konkat_aktion_thema_gruppe_id,'-1000') as konkat_aktion_thema_gruppe_id,
       cast(value as integer) as kind_wg_id,
       cast(null as integer) as mutter_wg_id,
       cast('' as varchar(100)) as konkat_werbeteam_cd,
       cast('' as varchar(500)) as konkat_werbeteam_bez,
       cast('' as varchar(500)) as werbebereich_cd
from dbp_data.aktionsmanagement_1,lateral split_to_table(konkat_wg_id,',')
where try_to_number(value) is not null and
      kjwo_ww between (select kjwo_ww from dbp_data.werbewoche_kl_1 where mandant_id = 1 and akt_kjwo_ww = -3 group by 1) and (select kjwo_ww from dbp_data.werbewoche_kl_1 where mandant_id = 1 and akt_kjwo_ww = 0 group by 1)
);

delete from _murks_1
where kind_wg_id is null
;

update _murks_1 from (select b.mandant_id,
                           b.art_id,
                           b.wg_id
                    from dbp_data.art_1 a
                    join dbp_data.art_wg_zu_per_1 b
                      on a.mandant_id = b.mandant_id and
                         a.art_id = b.art_id and
                         b.arthiertyp_id = 2 and
                         b.dat_bis = '9999-12-31'
                    where a.mandant_id = 1 and
                          a.dat_bis = '9999-12-31'
                    group by 1,2,3) b

set mutter_wg_id = b.wg_id

where _murks.mandant_id = b.mandant_id and
      _murks.mutter_wb_id = b.art_id
;

create or replace volatile table _wgs as (
select a.mandant_id,
       a.wg_id,
       a.werbeteam_cd,
       b.werbeteam_bez,
       b.werbebereich_cd
from dbp_data.wg_per_1 a
join dbp_data.l_werbeteam_1 b
  on a.mandant_id = b.mandant_id and
     a.werbeteam_cd = b.werbeteam_cd and
     a.arthiertyp_id = 2 and
     a.dat_bis = '9999-12-31'
where a.mandant_id = 1
);

update _murks_1 from (select *
                    from _wgs) b
                    
set konkat_werbeteam_cd = b.werbeteam_cd,
    konkat_werbeteam_bez = b.werbeteam_bez
    
where _murks.mandant_id = b.mandant_id and
      _murks.kind_wg_id = b.wg_id
;

update _murks_1 from (select *
                    from _wgs) b
                    
set werbebereich_cd = b.werbebereich_cd
    
where _murks.mandant_id = b.mandant_id and
      _murks.mutter_wg_id = b.wg_id
;

create or replace volatile table _upd1 as (
select mandant_id,
       kjwo_ww,
       kjwo,
       mutter_wb_id,
       gp_id,
       konkat_aktion_thema_gruppe_id,
       werbebereich_cd,
       rtrim((listagg(distinct konkat_werbeteam_cd , ',' ) within group (order by null)), ',') as konkat_werbeteam_cd_,
       rtrim((listagg(distinct konkat_werbeteam_bez , ',' ) within group (order by null)), ',') as konkat_werbeteam_bez_
from _murks_1
group by all
);

update dbp_data.aktionsmanagement_1 from (select *
                                        from _upd1) b
                                                        
set konkat_werbeteam_cd = b.konkat_werbeteam_cd_,
    konkat_werbeteam_bez = b.konkat_werbeteam_bez_,
    werbebereich_cd = b.werbebereich_cd
    
where dbp_data.aktionsmanagement.mandant_id = b.mandant_id and
      dbp_data.aktionsmanagement.kjwo_ww = b.kjwo_ww and
      dbp_data.aktionsmanagement.kjwo = b.kjwo and
      dbp_data.aktionsmanagement.mutter_wb_id = b.mutter_wb_id and
      dbp_data.aktionsmanagement.gp_id = b.gp_id and
      coalesce(dbp_data.aktionsmanagement.konkat_aktion_thema_gruppe_id,'-1000') = b.konkat_aktion_thema_gruppe_id
;

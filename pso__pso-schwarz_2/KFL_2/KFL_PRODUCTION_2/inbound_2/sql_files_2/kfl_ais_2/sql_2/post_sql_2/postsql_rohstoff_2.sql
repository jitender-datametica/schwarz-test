-- Befuellung LUs

insert into dbp_data.l_rohstoff_blend_2 (rohstoff_blend_kfl_cd
                                      ,rohstoff_blend_kfl_name)
select coalesce(rohstoff_blend_kfl_txt,'') as rohstoff_blend_kfl_cd,
       coalesce(rohstoff_blend_kfl_txt,'') as rohstoff_blend_kfl_name
from dbp_msi_data.ts_rohstoff_monitoring_anzeige_2
where rohstoff_blend_kfl_txt not in (select rohstoff_blend_kfl_name from dbp_data.l_rohstoff_blend_2)
group by 1,2
;

delete from dbp_data.l_rohstoff_gruppe_zuordnungstyp_2;
insert into dbp_data.l_rohstoff_gruppe_zuordnungstyp_2 values (1,'KFL Kategorie zu KFL Subkategorie',current_timestamp,current_timestamp);
insert into dbp_data.l_rohstoff_gruppe_zuordnungstyp_2 values (2,'KFL Subkategorie zu KFL Kategorie',current_timestamp,current_timestamp);

delete from dbp_data.rohstoff_gruppe_zuordnung_2;
insert into dbp_data.rohstoff_gruppe_zuordnung_2 (rohstoff_gruppe_typ_id
                                               ,rohstoff_gruppe_name
                                               ,zugeordnete_rohstoff_gruppe_typ_id
                                               ,zugeordnete_rohstoff_gruppe_name
                                               ,rohstoff_gruppe_zuordnungstyp_id
                                               ,dat_gueltig_von
                                               ,dat_gueltig_bis
                                               ,td_update
                                               ,td_insert)
select 2 as rohstoff_gruppe_typ_id,
       coalesce(rohstoff_kategorie_kfl_name,'') as rohstoff_gruppe_name,
       3 as zugeordnete_rohstoff_gruppe_typ_id,
       coalesce(rohstoff_subkategorie_kfl_name,'') as zugeordnete_rohstoff_gruppe_name,
       1 as rohstoff_gruppe_zuordnungstyp_id,
       dat_anzeige_von as dat_gueltig_von,
       dat_anzeige_bis as dat_gueltig_bis,
       current_timestamp as td_update,
       current_timestamp as td_insert
from dbp_msi_data.ts_rohstoff_monitoring_anzeige_2
group by 1,2,3,4,5,6,7,8,9
;

insert into dbp_data.rohstoff_gruppe_zuordnung_2
select 3 as rohstoff_gruppe_typ_id,
       coalesce(rohstoff_subkategorie_kfl_name,'') as rohstoff_gruppe_name,
       2 as zugeordnete_rohstoff_gruppe_typ_id,
       coalesce(rohstoff_kategorie_kfl_name,'') as zugeordnete_rohstoff_gruppe_name,
       2 as rohstoff_gruppe_zuordnungstyp_id,
       dat_anzeige_von as dat_gueltig_von,
       dat_anzeige_bis as dat_gueltig_bis,
       current_timestamp as td_update,
       current_timestamp as td_insert
from dbp_msi_data.ts_rohstoff_monitoring_anzeige_2
group by 1,2,3,4,5,6,7,8,9
;

delete from dbp_data.rohstoff_rohstoff_gruppe_zu_2;
insert into dbp_data.rohstoff_rohstoff_gruppe_zu_2 (rohstoff_nr
                                                 ,rohstoff_gruppe_typ_id
                                                 ,rohstoff_gruppe_name
                                                 ,rohstoff_blend_kfl_cd
                                                 ,rohstoff_cluster_id
                                                 ,td_update
                                                 ,td_insert)
select a.rohstoff_nr
      ,1 as rohstoff_gruppe_typ_id
      ,coalesce(b.rohstoff_gruppe_name,'') as rohstoff_gruppe_name
      ,null as rohstoff_blend_kfl_cd
      ,null as rohstoff_cluster_id
      ,current_timestamp as td_update
      ,current_timestamp as td_insert
from dbp_data.rohstoff_2 a
join dbp_etl_process.l_rohstoff_gruppe_2 b
  on a.rohstoff_qualitaet_txt = b.rohstoff_kurz_name
group by 1,2,3,4,5,6
;

insert into dbp_data.rohstoff_rohstoff_gruppe_zu_2 (rohstoff_nr
                                                 ,rohstoff_gruppe_typ_id
                                                 ,rohstoff_gruppe_name
                                                 ,rohstoff_blend_kfl_cd
                                                 ,rohstoff_cluster_id
                                                 ,td_update
                                                 ,td_insert)
select a.rohstoff_nr
      ,2 as rohstoff_gruppe_typ_id
      ,coalesce(a.rohstoff_kategorie_kfl_name,'') as rohstoff_gruppe_name
      ,b.rohstoff_blend_kfl_cd
      ,a.rohstoff_cluster_id as rohstoff_cluster_id
      ,current_timestamp as td_update
      ,current_timestamp as td_insert
from dbp_msi_data.ts_rohstoff_monitoring_anzeige_2 a
left join dbp_data.l_rohstoff_blend_2 b
  on a.rohstoff_blend_kfl_txt = b.rohstoff_blend_kfl_name
group by 1,2,3,4,5,6
;

insert into dbp_data.rohstoff_rohstoff_gruppe_zu_2 (rohstoff_nr
                                                 ,rohstoff_gruppe_typ_id
                                                 ,rohstoff_gruppe_name
                                                 ,rohstoff_blend_kfl_cd
                                                 ,rohstoff_cluster_id
                                                 ,td_update
                                                 ,td_insert)
select a.rohstoff_nr
      ,3 as rohstoff_gruppe_typ_id
      ,coalesce(a.rohstoff_subkategorie_kfl_name,'') as rohstoff_gruppe_name
      ,b.rohstoff_blend_kfl_cd
      ,null as rohstoff_cluster_id
      ,current_timestamp as td_update
      ,current_timestamp as td_insert
from dbp_msi_data.ts_rohstoff_monitoring_anzeige_2 a
join dbp_data.l_rohstoff_blend_2 b
  on a.rohstoff_blend_kfl_txt = b.rohstoff_blend_kfl_name
group by 1,2,3,4,5,6
;

update dbp_data.rohstoff_2 set rohstoff_qualitaet_txt = '';

update dbp_data.rohstoff_2 from (select rohstoff_nr,
                                      max(rohstoff_kfl_bez) as rohstoff_kfl_bez,
                                      max(rohstoff_qualitaet_txt) as rohstoff_qualitaet_txt,
                                      max(rohstoff_quell_bez) as rohstoff_quell_bez
                               from dbp_msi_data.ts_rohstoff_monitoring_anzeige_2
                               group by 1) b

set rohstoff_kfl_bez = b.rohstoff_kfl_bez,
    rohstoff_qualitaet_txt = b.rohstoff_qualitaet_txt,
    rohstoff_quell_bez = b.rohstoff_quell_bez
    
where dbp_data.rohstoff.rohstoff_nr = b.rohstoff_nr
;

delete from dbp_data.rohstoff_gruppe_2;
insert into dbp_data.rohstoff_gruppe_2 (rohstoff_gruppe_typ_id
                                     ,rohstoff_gruppe_name
                                     ,rohstoff_gruppe_kurz_name
                                     ,td_update
                                     ,td_insert)
select rohstoff_gruppe_typ_id
      ,rohstoff_gruppe_name
      ,rohstoff_gruppe_name
      ,current_timestamp
      ,current_timestamp
from dbp_data.rohstoff_rohstoff_gruppe_zu_2
where rohstoff_gruppe_typ_id in (2,3)
group by 1,2,3
;

insert into dbp_data.rohstoff_gruppe_2 (rohstoff_gruppe_typ_id
                                     ,rohstoff_gruppe_name
                                     ,rohstoff_gruppe_kurz_name
                                     ,td_update
                                     ,td_insert)
select 1 as rohstoff_gruppe_typ_id
      ,rohstoff_gruppe_name
      ,rohstoff_kurz_name as rohstoff_gruppe_kurz_name
      ,current_timestamp
      ,current_timestamp
from dbp_etl_process.l_rohstoff_gruppe_2
;

delete from dbp_data.rohstoff_gruppe_nachricht_2;
insert into dbp_data.rohstoff_gruppe_nachricht_2 (rohstoff_gruppe_typ_id
                                               ,rohstoff_gruppe_name
                                               ,nachricht_typ_id
                                               ,spr_id
                                               ,nachricht_titel_txt
                                               ,nachricht_inhalt_txt
                                               ,trend_typ_id
                                               ,dat_trend_von
                                               ,prognose_halbjahr_typ_id
                                               ,nachricht_link_txt
                                               ,preis_reduzierende_faktoren_txt
                                               ,preis_steigernde_faktoren_txt
                                               ,forecast_txt
                                               ,dat_gueltig_von
                                               ,dat_gueltig_bis
                                               ,td_update
                                               ,td_insert)
select 2 as rohstoff_gruppe_typ_id
      ,rohstoff_kategorie_kfl_name
      ,nachricht_typ_id
      ,spr_id
      ,nachricht_titel_txt
      ,nachricht_inhalt_txt
      ,trend_typ_id
      ,dat_trend_von
      ,prognose_halbjahr_typ_id
      ,nachricht_link_txt
      ,preis_reduzierende_faktoren_txt
      ,preis_steigernde_faktoren_txt
      ,forecast_txt
      ,dat_gueltig_von
      ,dat_gueltig_bis
      ,td_update
      ,td_insert
from dbp_msi_data.ts_rohstoff_monitoring_nachricht_2
;

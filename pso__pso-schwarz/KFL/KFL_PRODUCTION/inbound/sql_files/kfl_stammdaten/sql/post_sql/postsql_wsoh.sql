delete from dbp_etl.wsoh
where skopf = 0
;

delete from dbp_data.baustein_per
where (mandant_id) in (select man.mandant_id
                       from dbp_etl.wsoh
                       join dbp_data.mandant as man
                         on man.mandant_sap_id = wsoh.mandt)
;

delete from dbp_data.baustein_wup_zu_per
where (mandant_id) in (select man.mandant_id
                       from dbp_etl.wsoh
                       join dbp_data.mandant as man
                         on man.mandant_sap_id = wsoh.mandt)
;

delete from dbp_data.baustein_art_zu_per
where (mandant_id) in (select man.mandant_id
                       from dbp_etl.wsoh
                       join dbp_data.mandant as man
                         on man.mandant_sap_id = wsoh.mandt)
;

insert into dbp_data.baustein_per (mandant_id
                                  ,baustein_id
                                  ,spr_id
                                  ,baustein_bez
                                  ,dat_von
                                  ,dat_bis)
select man.mandant_id
      ,wsoh.skopf
      ,22
      ,wsoh.vtext
      ,wsoh.datab
      ,wsoh.datub
from dbp_etl.wsoh
join dbp_data.mandant as man
  on man.mandant_sap_id = wsoh.mandt
where lvorm <> 'X'
;

create or replace volatile table _dedup as (
select *
from ${TEMP_TABLE}
qualify row_number() over (partition by art_id,mandant_id,wup_id order by art_id,mandant_id,wup_id) = 1
);

insert into dbp_etl_process.mard_bcg_1
select a.mandant_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.menge_lgbest_erp_frei_bme,
       current_timestamp,
       current_timestamp
from _dedup a
join dbp_data.art_wg_zu_per_1 b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     b.arthiertyp_id = 2 and
     b.dat_bis = '9999-12-31'
join dbp_data.wg_per_1 d
  on a.mandant_id = d.mandant_id and
     b.wg_id = d.wg_id and
     b.arthiertyp_id = d.arthiertyp_id and
     d.dat_bis = '9999-12-31'
join dbp_data.wup_1 e
  on a.mandant_id = e.mandant_id and
     a.wup_id = e.wup_id
where a.mandant_id in (1,2) and
      d.owg_id in (1006,1010) and
      e.nb_id = 0
group by 1,2,3,4,5
;

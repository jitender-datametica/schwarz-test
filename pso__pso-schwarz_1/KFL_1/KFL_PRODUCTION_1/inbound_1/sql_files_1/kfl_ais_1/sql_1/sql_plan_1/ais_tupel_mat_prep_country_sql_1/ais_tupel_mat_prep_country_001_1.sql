delete from dbp_etl_process.tupel_mat_etl_1
where (mandant_id,a500_kjwo_update) in (select mandant_id,max(kjwo_update) from dbp_data.sortiment_leistung_1 group by 1)
;

insert into dbp_etl_process.tupel_mat_etl_1
select *
from dbp_msi_data.tupel_mat_1
where (mandant_id,a500_kjwo_update) in (select mandant_id,max(kjwo_update) from dbp_data.sortiment_leistung_1 group by 1) and
      (mandant_id,a500_kjwo_update) not in (select mandant_id,a500_kjwo_update from dbp_etl_process.tupel_mat_etl_1)
;

insert into dbp_etl_process.tupel_mat_etl_1
select *
from dbp_msi_data.tupel_mat_quarantaene_1
where (mandant_id,a500_kjwo_update) in (select mandant_id,max(kjwo_update) from dbp_data.sortiment_leistung_1 group by 1) and
      (mandant_id,a500_kjwo_update) not in (select mandant_id,a500_kjwo_update from dbp_etl_process.tupel_mat_etl_1)
;

delete from dbp_etl.art_matching_nielsen_per_1
where kjwo_update not in (select max(kjwo_update) from dbp_data.sortiment_leistung_1)
;

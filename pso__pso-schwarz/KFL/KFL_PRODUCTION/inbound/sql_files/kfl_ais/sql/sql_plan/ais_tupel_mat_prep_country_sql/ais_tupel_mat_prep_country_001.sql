delete from dbp_etl_process.tupel_mat_etl
where (mandant_id,a500_kjwo_update) in (select mandant_id,max(kjwo_update) from dbp_data.sortiment_leistung group by 1)
;

insert into dbp_etl_process.tupel_mat_etl
select *
from dbp_msi_data.tupel_mat
where (mandant_id,a500_kjwo_update) in (select mandant_id,max(kjwo_update) from dbp_data.sortiment_leistung group by 1) and
      (mandant_id,a500_kjwo_update) not in (select mandant_id,a500_kjwo_update from dbp_etl_process.tupel_mat_etl)
;

insert into dbp_etl_process.tupel_mat_etl
select *
from dbp_msi_data.tupel_mat_quarantaene
where (mandant_id,a500_kjwo_update) in (select mandant_id,max(kjwo_update) from dbp_data.sortiment_leistung group by 1) and
      (mandant_id,a500_kjwo_update) not in (select mandant_id,a500_kjwo_update from dbp_etl_process.tupel_mat_etl)
;

delete from dbp_etl.art_matching_nielsen_per
where kjwo_update not in (select max(kjwo_update) from dbp_data.sortiment_leistung)
;

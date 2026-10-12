--final updates with no impact on testing

create or replace volatile table _nielsen_group
as
(
  select
  mandant_id,
  art_matching_id
  from
  dbp_etl.art_matching_nielsen_per_kmo_1
  group by 1,2
  having count(distinct art_id)=1 and count(*) > 1
);

create or replace volatile table _mgtin_update
as
(
select mandant_id,
       art_matching_id,
       listagg(DISTINCT gtin_id,',') WITHIN GROUP (ORDER BY gtin_id) AS kombi_gtin_id
FROM dbp_etl.art_matching_nielsen_per_kmo_1
WHERE (mandant_id,art_matching_id) in (select distinct mandant_id,art_matching_id from _nielsen_group where art_id=-1)
GROUP BY 1,2
);


UPDATE dbp_etl_process.tupel_mat_etl_1 FROM (select * from _mgtin_update) b

SET nielsen_gtin = b.kombi_gtin_id

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.art_matching_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung_1)
;

UPDATE dbp_msi_data.tupel_mat_quarantaene_1 FROM (select * from _mgtin_update) b

SET nielsen_gtin = b.kombi_gtin_id

WHERE dbp_msi_data.tupel_mat_quarantaene.mandant_id = b.mandant_id AND
      dbp_msi_data.tupel_mat_quarantaene.matching_id = b.art_matching_id AND
      dbp_msi_data.tupel_mat_quarantaene.a500_kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung_1)
;

--only for front-end

--- check, if they exist...shouldn't be.
delete from dbp_etl.art_matching_nielsen_per_1
where (mandant_id,art_matching_id,kjwo_update) in (select mandant_id,art_matching_id,kjwo_update from dbp_etl.art_matching_nielsen_per_olds_1)
;

delete from dbp_etl.art_matching_nielsen_per_kmo_1
where (mandant_id,art_matching_id,kjwo_update) in (select mandant_id,art_matching_id,kjwo_update from dbp_etl.art_matching_nielsen_per_kmo_olds_1)
;

--- inserting the old ones.
insert into dbp_etl.art_matching_nielsen_per_1
select *
from dbp_etl.art_matching_nielsen_per_olds_1
;

insert into dbp_etl.art_matching_nielsen_per_kmo_1
select *
from dbp_etl.art_matching_nielsen_per_kmo_olds_1
;



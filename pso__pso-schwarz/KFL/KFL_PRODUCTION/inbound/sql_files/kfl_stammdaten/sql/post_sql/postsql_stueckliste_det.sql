DELETE FROM DBP_DATA.stueckliste_det using ${TEMP_TABLE}
WHERE DBP_DATA.stueckliste_det.mandant_id         = ${TEMP_TABLE}.mandant_id
  AND DBP_DATA.stueckliste_det.stueckliste_id     = ${TEMP_TABLE}.stueckliste_id 
  AND DBP_DATA.stueckliste_det.stueckliste_typ_id = ${TEMP_TABLE}.stueckliste_typ_id
  AND DBP_DATA.stueckliste_det.stueckliste_pos_id = ${TEMP_TABLE}.stueckliste_pos_id
  AND DBP_DATA.stueckliste_det.dat_von           >= ${TEMP_TABLE}.dat_von
;

INSERT INTO DBP_DATA.stueckliste_det
(    
   mandant_id
  ,stueckliste_id
  ,stueckliste_pos_id
  ,art_id
  ,stueckliste_typ_id
  ,komponentenmenge
  ,komponentenmenge_einh_id
  ,dat_von 
  ,dat_bis 
  ,td_insert
  ,td_update 
) 
SELECT 
   mandant_id
  ,stueckliste_id
  ,stueckliste_pos_id
  ,art_id
  ,stueckliste_typ_id
  ,komponentenmenge
  ,komponentenmenge_einh_id
  ,dat_von 
  ,dat_bis 
  ,localtimestamp
  ,localtimestamp
FROM ${TEMP_TABLE}
;

UPDATE DBP_DATA.stueckliste_det

SET   dat_bis = dt1.dat_bis

FROM
(
  SELECT
     mandant_id
    ,stueckliste_id
    ,stueckliste_pos_id 
    ,stueckliste_typ_id
    ,dat_von
    ,CASE
	 WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, stueckliste_id, stueckliste_pos_id, stueckliste_typ_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD'))) = 0 THEN TO_DATE('9999-12-31','YYYY-MM-DD')
	 ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, stueckliste_id, stueckliste_pos_id, stueckliste_typ_id  ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD')))),'YYYYMMDD'))
     END AS DAT_BIS   
  FROM DBP_DATA.stueckliste_det
  WHERE (mandant_id, stueckliste_id, stueckliste_pos_id, stueckliste_typ_id) IN (SELECT mandant_id,
                                                                                        stueckliste_id,
                                                                                        stueckliste_pos_id,
                                                                                        stueckliste_typ_id
                                                                                 FROM ${TEMP_TABLE})
) dt1 WHERE DBP_DATA.stueckliste_det.mandant_id = dt1.mandant_id
  AND DBP_DATA.stueckliste_det.stueckliste_id  = dt1.stueckliste_id
  AND DBP_DATA.stueckliste_det.stueckliste_pos_id  = dt1.stueckliste_pos_id
  AND DBP_DATA.stueckliste_det.stueckliste_typ_id  = dt1.stueckliste_typ_id
  AND DBP_DATA.stueckliste_det.dat_von = dt1.dat_von
  AND DBP_DATA.stueckliste_det.dat_bis <> dt1.dat_bis
;

UPDATE DBP_DATA.stueckliste_det SET dat_bis = CURRENT_DATE-1
WHERE dat_bis > CURRENT_DATE-1 AND
      mandant_id IN (SELECT mandant_id FROM ${TEMP_TABLE}) AND 
     (mandant_id, stueckliste_id, stueckliste_pos_id, stueckliste_typ_id) NOT IN (SELECT mandant_id,stueckliste_id,stueckliste_pos_id,stueckliste_typ_id FROM ${TEMP_TABLE})
;

-- Duplication for MD

create or replace volatile table _missings_md_det as (
select 4 as mandant_id,
       stueckliste_id,
       stueckliste_pos_id,
       dat_von,
       dat_bis,
       art_id,
       stueckliste_typ_id,
       komponentenmenge,
       komponentenmenge_einh_id,
       td_update,
       td_insert
from dbp_data.stueckliste_det
where (stueckliste_id,stueckliste_pos_id,dat_von) in (select stueckliste_id,
                                                             stueckliste_pos_id,
                                                             dat_von
                                                      from dbp_data.stueckliste_det
                                                      where mandant_id in (4,7)
                                                      group by 1,2,3
                                                      having count(*) = 1) and
       mandant_id = 7
);

insert into dbp_data.stueckliste_det (mandant_id
                                     ,stueckliste_id
                                     ,stueckliste_pos_id
                                     ,dat_von
                                     ,dat_bis
                                     ,art_id
                                     ,stueckliste_typ_id
                                     ,komponentenmenge
                                     ,komponentenmenge_einh_id
                                     ,td_update
                                     ,td_insert)
select mandant_id
      ,stueckliste_id
      ,stueckliste_pos_id
      ,dat_von
      ,dat_bis
      ,art_id
      ,stueckliste_typ_id
      ,komponentenmenge
      ,komponentenmenge_einh_id
      ,td_update
      ,td_insert
from _missings_md_det
;

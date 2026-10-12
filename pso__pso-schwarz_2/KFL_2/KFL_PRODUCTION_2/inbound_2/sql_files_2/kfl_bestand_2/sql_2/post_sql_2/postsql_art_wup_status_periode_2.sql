create volatile table _mist as 
select mandant_id,
       art_id,
       wup_id,
       gjmo,
       gjmo_bis,
       to_number(to_char(gjmo_bis * 100 + 1)) AS gjmo_bis_dat
from dbp_data.art_wup_status_periode_2
where (mandant_id,art_id,wup_id) in (select mandant_id,art_id,wup_id FROM ${TEMP_TABLE})
group by 1,2,3,4,5,6
;

update dbp_data.art_wup_status_periode_2 set gjmo = gjmo_ab_
from (select mandant_id,
             art_id,
             wup_id,
             gjmo,
             gjmo_bis,
             gjmo_bis_dat,
             sum(gjmo_bis_dat) over (partition by mandant_id,art_id,wup_id order by gjmo_bis_dat asc nulls last rows between 1 preceding and current row) - gjmo_bis_dat as test_2,
             case when test_2 = 0  then to_date(to_char(gjmo * 100 + 1),'yyyymmdd') end as test2,
             case when test_2 <> 0 then add_months(to_date(to_char(test_2),'yyyymmdd'), 1) end as test3,
             case when test_2  = 0 then to_char(test2) else to_char(test3) end as dat_ab,
             substr(dat_ab,1,4)||substr(dat_ab,6,2) as gjmo_ab_
      from _mist
      qualify gjmo <> gjmo_ab_) d 
where dbp_data.art_wup_status_periode.mandant_id = d.mandant_id
  and dbp_data.art_wup_status_periode.art_id = d.art_id
  and dbp_data.art_wup_status_periode.wup_id = d.wup_id
  and dbp_data.art_wup_status_periode.gjmo_bis = d.gjmo_bis
  and dbp_data.art_wup_status_periode.gjmo <> d.gjmo_ab_
;

UPDATE DBP_DATA.art_wup_status_periode_2 

SET vk_brutto = a.vk_brutto_

FROM (
	SELECT t2.mandant_id as mandant_id_, t2.art_id as art_id_, t2.wup_id as wup_id_, t1.vk_brutto as vk_brutto_, t2.gjmo_bis as gjmo_bis_
	FROM DBP_DATA.art_wup_zu_per_2 t1_2
	INNER JOIN ${TEMP_TABLE} t2
	ON t1.mandant_id = t2.mandant_id
	AND t1.art_id = t2.art_id
	AND t1.wup_id = t2.wup_id
	AND TO_DATE(TO_CHAR(t2.gjmo_bis), 'YYYYMM') BETWEEN t1.dat_von and t1.dat_bis 
        ) a
 WHERE  mandant_id = a.mandant_id_ AND
       art_id = a.art_id_ AND
       wup_id = a.wup_id_ AND
       gjmo_bis = a.gjmo_bis_
;

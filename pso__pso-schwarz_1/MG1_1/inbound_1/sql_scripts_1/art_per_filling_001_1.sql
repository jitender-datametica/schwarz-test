create  volatile table _art_per_tmp as (
select art_id,
       mandant_id,
       current_date as dat_von,
       '9999-12-31' as dat_bis,
       mutter_wb_id,
       posten_id,
       ipn_id,
       mwst_id,
       oug_id,
       localtimestamp as td_insert,
       localtimestamp as td_update
from dbp_data.art_1
where current_date > (select max(dat_von) from dbp_data.art_per_1)
group by 1,2,3,4,5,6,7,8,9
);

create  volatile table _art_per_new as (
select b.*
from dbp_data.art_per_1 a
join _art_per_tmp b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     a.dat_bis = to_date('9999-12-31','yyyy-mm_1-dd')
where coalesce(a.mutter_wb_id,-999) <> coalesce(b.mutter_wb_id,-999) 
   or a.posten_id <> b.posten_id
   or a.oug_id <> b.oug_id
   or a.mwst_id <> b.mwst_id
   or coalesce(a.ipn_id ,-999) <> coalesce(b.ipn_id,-999)
);

insert into _art_per_new
select *
from _art_per_tmp
where (art_id,mandant_id) not in (select art_id,mandant_id from dbp_data.art_per_1)
;

insert into dbp_data.art_per_1 (mandant_id,
                              art_id,
                              dat_von,
                              dat_bis,
                              mutter_wb_id,
                              posten_id,
                              ipn_id,
                              mwst_id,
                              oug_id,
                              td_insert,
                              td_update)
select mandant_id,
       art_id,
       dat_von,
       dat_bis,
       mutter_wb_id,
       posten_id,
       ipn_id,
       mwst_id,
       oug_id,
       td_insert,
       td_update
from _art_per_new
;

update dbp_data.art_per_1
set dat_bis = dt1.dat_bis
from (select mandant_id
            ,art_id
            ,dat_von
            ,coalesce(lead(dat_von - 1) over(partition by mandant_id,art_id order by dat_von), to_date('9999-12-31', 'yyyy-mm_1-dd')) as dat_bis
      from dbp_data.art_per_1) dt1
where dbp_data.art_per.mandant_id = dt1.mandant_id
  and dbp_data.art_per.art_id = dt1.art_id
  and dbp_data.art_per.dat_von = dt1.dat_von
  and dbp_data.art_per.dat_bis <> dt1.dat_bis
;

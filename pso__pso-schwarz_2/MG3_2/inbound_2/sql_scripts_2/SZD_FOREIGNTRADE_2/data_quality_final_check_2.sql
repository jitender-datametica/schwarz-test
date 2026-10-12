select case when sum(count_of_wrong_rows)>0 then 1/0 else 0 end as check_sum
from(                                                                                                 
select count(*) count_of_wrong_rows from etl.t_tf_cache_owim_2_check_owim_int_2
union all                                                                                                 
select count(*) count_of_wrong_rows from etl.t_tf_cache_excise_masterlist_2_check_excise_masterlist_int_2
union all                                                                                                 
select count(*) count_of_wrong_rows from etl.t_tf_cache_ceva_2_check_ceva_int_2
union all
select count(*) count_of_wrong_rows from etl.t_tf_cache_cds_item_2_check_cds_item_int_2);  

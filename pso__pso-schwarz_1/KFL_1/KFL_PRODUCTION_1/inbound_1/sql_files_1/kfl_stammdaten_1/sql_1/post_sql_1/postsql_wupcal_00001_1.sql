/*
USER STORY 489224
*/

update dbp_data.wupcal_1
   set offen = 0,
       td_update = current_timestamp
   where dat > current_date - 5 
         and offen = 1
         and (mandant_id, wup_id, dat) in
             (select 
                 mandant_id, wup_id, dat 
                from dbp_data.wupcal_ereignis_zu_1
               where offen = 0)
         and coalesce(bonanzahl_sug,0) = 0 
;

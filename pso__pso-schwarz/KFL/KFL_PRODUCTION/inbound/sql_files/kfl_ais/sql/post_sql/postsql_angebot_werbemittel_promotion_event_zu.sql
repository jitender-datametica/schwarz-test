delete from dbp_data.angebot_werbemittel_promotion_event_zu  
where (mandant_id, angebot_nr) in 
(select mandant_id, angebot_nr  
 from ${TEMP_TABLE}  
 group by mandant_id, angebot_nr  
)
;

insert into dbp_data.angebot_werbemittel_promotion_event_zu 
select ${TABLE_FIELDS}
from ${TEMP_TABLE}
;

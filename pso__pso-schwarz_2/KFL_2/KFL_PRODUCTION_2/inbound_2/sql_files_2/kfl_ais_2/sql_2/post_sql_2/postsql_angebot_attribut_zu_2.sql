delete from dbp_data.angebot_attribut_zu_2  
where (mandant_id, angebot_nr) in 
(select mandant_id, angebot_nr  
 from ${TEMP_TABLE}  
 group by mandant_id, angebot_nr  
)
;

insert into dbp_data.angebot_attribut_zu_2 
select ${TABLE_FIELDS}
from ${TEMP_TABLE}
;

delete from dbp_data.angebot_art_wup_zu  
where (mandant_id,wup_id,angebot_nr) in (select mandant_id,
                                                wup_id,
                                                angebot_nr
                                         from ${TEMP_TABLE})
;

insert into dbp_data.angebot_art_wup_zu 
select ${TABLE_FIELDS} 
from ${TEMP_TABLE} 
;

--should only be valid for kmo countries (interface lfm1_kmo+wyt1t_kmo)
--for mandant_id=1 used lfm2_de+wyt1t_de

DELETE FROM dbp_data.l_gp_teilsortiment tgt
WHERE ( tgt.mandant_id , tgt.gp_id , RTRIM(tgt.gp_teilsortiment_id) , tgt.einkaufsorganisation_id , tgt.zahlungsziel_id, tgt.zek_id )
IN (SELECT tmp.mandant_id , tmp.gp_id , RTRIM(tmp.gp_teilsortiment_id) , tmp.einkaufsorganisation_id , tmp.zahlungsziel_id, tmp.zek_id 
FROM ${TEMP_TABLE}  tmp) and tgt.mandant_id <> 1;


INSERT INTO dbp_data.l_gp_teilsortiment (mandant_id , gp_id , gp_teilsortiment_id , einkaufsorganisation_id , zahlungsziel_id , zek_id , td_update , td_insert)
SELECT tmp.mandant_id , tmp.gp_id , RTRIM(tmp.gp_teilsortiment_id) , tmp.einkaufsorganisation_id , tmp.zahlungsziel_id , tmp.zek_id , tmp.td_update , tmp.td_insert 
FROM ${TEMP_TABLE}  tmp
WHERE (mandant_id,gp_id) not in (SELECT mandant_id, gp_id FROM dbp_data.l_gp_teilsortiment) and mandant_id <> 1;

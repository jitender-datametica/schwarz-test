--should only be valid for kmo countries (interface lfm1_kmo+wyt1t_kmo)
--for mandant_id=1 used lfm2_de+wyt1t_de

DELETE FROM dbp_data.gp_teilsortiment_spr_zu tgt
WHERE ( tgt.mandant_id , tgt.gp_id , RTRIM(tgt.gp_teilsortiment_id) , tgt.einkaufsorganisation_id , tgt.spr_id )
IN (SELECT tmp.mandant_id , tmp.gp_id , RTRIM(tmp.gp_teilsortiment_id) , tmp.einkaufsorganisation_id , tmp.spr_id 
FROM ${TEMP_TABLE}  tmp) and tgt.mandant_id <> 1;


INSERT INTO dbp_data.gp_teilsortiment_spr_zu (mandant_id , gp_id , gp_teilsortiment_id , einkaufsorganisation_id , spr_id , gp_teilsortiment_bez , td_update , td_insert)
SELECT tmp.mandant_id , tmp.gp_id , RTRIM(tmp.gp_teilsortiment_id) , tmp.einkaufsorganisation_id , tmp.spr_id , RTRIM(tmp.gp_teilsortiment_bez) , tmp.td_update , tmp.td_insert 
FROM ${TEMP_TABLE}  tmp
WHERE (mandant_id,gp_id) not in (SELECT mandant_id,gp_id FROM dbp_data.gp_teilsortiment_spr_zu) and mandant_id <> 1;

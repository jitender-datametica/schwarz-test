update dbp_data.ek_infosatz_2 set loesch_fg = 1
where mandant_id = 1 and
     (mandant_id,ek_infosatz_id) not in (select mandant_id, ek_infosatz_id from ${TEMP_TABLE} where mandant_id = 1) and
      loesch_fg = 0
;

UPDATE dbp_data.ek_infosatz_2 FROM (
SELECT mandant_id,
       ek_infosatz_id
FROM dbp_data.ek_infosatz_2
WHERE 1 IN (SELECT 1 FROM ${TEMP_TABLE} WHERE mandant_id = 1) AND
     (mandant_id,ek_infosatz_id) NOT IN (SELECT mandant_id,ek_infosatz_id FROM ${TEMP_TABLE} WHERE mandant_id = 1) AND
      mandant_id = 1 AND
      dat_bis = '9999-12-31') b
       
SET dat_bis = CURRENT_DATE-1

WHERE dbp_data.ek_infosatz.mandant_id = b.mandant_id AND
      dbp_data.ek_infosatz.ek_infosatz_id = b.ek_infosatz_id 
;

insert into dbp_data.ek_infosatz_2 (mandant_id
                                 ,ek_infosatz_id
                                 ,art_id
                                 ,gp_id
                                 ,einkaufsorganisation_id
                                 ,dat_erstellung
                                 ,gp_art_id
                                 ,dat_von
                                 ,dat_bis
                                 ,regel_gp_fg
                                 ,loesch_fg
                                 ,gp_teilsortiment_id
                                 ,menge_einh_id
                                 ,td_update
                                 ,td_insert
                                 ,apollo_ian
                                 ,konditionsgruppe_id)
select 4 as mandant_id
      ,ek_infosatz_id
      ,art_id
      ,gp_id
      ,1040 as einkaufsorganisation_id
      ,dat_erstellung
      ,gp_art_id
      ,dat_von
      ,dat_bis
      ,regel_gp_fg
      ,loesch_fg
      ,gp_teilsortiment_id
      ,menge_einh_id
      ,td_update
      ,td_insert
      ,apollo_ian
      ,konditionsgruppe_id
from dbp_data.ek_infosatz_2
where mandant_id = 7 and
      ek_infosatz_id in (select ek_infosatz_id
                         from dbp_data.ek_infosatz_2
                         where mandant_id in (4,7)
                         group by 1
                         having count(*) <> 2)
;

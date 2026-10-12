update dbp_data.art set saison_id = '';
update dbp_data.art from (select *
                          from ${TEMP_TABLE}) b
set saison_id = b.saison_id
where dbp_data.art.mandant_id = b.mandant_id and
      dbp_data.art.art_id = b.art_id
;

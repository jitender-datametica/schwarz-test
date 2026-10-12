update dbp_data.art_spr_zu_2 from (select a.mandant_id,
                                        b.art_id,
                                        a.spr_id,
                                        a.int_art_bez
                                 from ${TEMP_TABLE} a
                                 join dbp_data.art_2 b
                                   on a.mandant_id = b.mandant_id and
                                      a.art_id = b.int_art_id) b

set int_art_bez = b.int_art_bez

where dbp_data.art_spr_zu.mandant_id = b.mandant_id and
      dbp_data.art_spr_zu.art_id = b.art_id and
      dbp_data.art_spr_zu.spr_id = b.spr_id
;

update dbp_data.art_spr_zu_2 from (select b.mandant_id,
                                        b.art_id,
                                        a.spr_id,
                                        a.int_art_bez
                                 from ${TEMP_TABLE} a
                                 join dbp_data.art_2 b
                                   on a.art_id = b.int_art_id
                                 where a.spr_id = 22
                                 group by 1,2,3,4) b

set int_art_bez = b.int_art_bez

where dbp_data.art_spr_zu.mandant_id = b.mandant_id and
      dbp_data.art_spr_zu.art_id = b.art_id and
      dbp_data.art_spr_zu.spr_id = b.spr_id
;

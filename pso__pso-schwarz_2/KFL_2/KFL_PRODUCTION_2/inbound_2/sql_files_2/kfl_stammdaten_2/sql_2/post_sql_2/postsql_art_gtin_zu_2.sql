-- rag picker for de/kmo for updating mara_2 with gtin!

update dbp_data.art_2 

set gtin_id = b.gtin_id

from (select a.mandant_id,
             a.art_id,
             a.gtin_id
      from dbp_data.art_gtin_zu_2 a
      join (select mandant_id,
                   art_id,
                   basismenge_einh_id
            from dbp_data.art_2) b
        on a.mandant_id = b.mandant_id and
           a.art_id = b.art_id and
           coalesce(a.altnv_menge_einh_id,'') = coalesce(b.basismenge_einh_id,'') and
           a.haupt_gtin_fg = 1
      qualify row_number() over (partition by a.mandant_id,a.art_id order by a.lfd_nr desc) = 1) b

where dbp_data.art.mandant_id = b.mandant_id and
      dbp_data.art.art_id = b.art_id
;

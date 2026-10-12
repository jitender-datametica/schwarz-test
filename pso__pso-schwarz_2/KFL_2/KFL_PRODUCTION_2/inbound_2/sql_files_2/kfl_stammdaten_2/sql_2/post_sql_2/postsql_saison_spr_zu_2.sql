UPDATE DBP_DATA.saison_spr_zu_2
   SET saison_bez = s.RO_saison_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.saison_id  as saison_id, 
                a.spr_id         as SPR_ID,
                b.saison_bez as RO_saison_bez
          FROM  DBP_DATA.saison_spr_zu_2 a
         INNER  JOIN DBP_DATA.saison_spr_zu_2 b
            ON  a.saison_id = b.saison_id 
           AND  a.spr_id        = b.spr_id
           AND  a.saison_id = b.saison_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.saison_bez <>b.saison_bez 
         GROUP  BY 1,2,3
) s
WHERE saison_spr_zu.mandant_id =4 
  AND saison_spr_zu.saison_id  = s.saison_id
  AND saison_spr_zu.spr_id         = s.SPR_ID
  AND saison_spr_zu.saison_bez <> s.RO_saison_bez
;

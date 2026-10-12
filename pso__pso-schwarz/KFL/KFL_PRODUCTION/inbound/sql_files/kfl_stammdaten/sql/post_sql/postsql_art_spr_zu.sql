UPDATE DBP_DATA.art_spr_zu
   SET art_bez = s.RO_ART_BEZ,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.art_id  as ART_ID, 
                a.spr_id  as SPR_ID,
                b.art_bez as RO_ART_BEZ
          FROM  DBP_DATA.art_spr_zu a
         INNER  JOIN DBP_DATA.art_spr_zu b
            ON  a.art_id=b.art_id and a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.art_bez <>b.art_bez
         GROUP  BY 1,2,3
) s
WHERE art_spr_zu.mandant_id =4 
  AND art_spr_zu.art_id  = s.ART_ID
  AND art_spr_zu.spr_id  = s.SPR_ID
  AND art_spr_zu.art_bez<> s.RO_ART_BEZ
;

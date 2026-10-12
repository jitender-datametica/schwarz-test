UPDATE DBP_DATA.geschaeftsvorfall_spr_zu
   SET geschaeftsvorfall_bez = s.RO_geschaeftsvorfall_BEZ
FROM (
        SELECT  a.geschaeftsvorfall_id  as geschaeftsvorfall_ID, 
                a.spr_id        as SPR_ID,
                b.geschaeftsvorfall_bez as RO_geschaeftsvorfall_BEZ
          FROM  DBP_DATA.geschaeftsvorfall_spr_zu a
         INNER  JOIN DBP_DATA.geschaeftsvorfall_spr_zu b
            ON  a.geschaeftsvorfall_id=b.geschaeftsvorfall_id 
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.geschaeftsvorfall_bez <>b.geschaeftsvorfall_bez
         GROUP  BY 1,2,3
) s
WHERE geschaeftsvorfall_spr_zu.mandant_id =4 
  AND geschaeftsvorfall_spr_zu.geschaeftsvorfall_id = s.geschaeftsvorfall_ID
  AND geschaeftsvorfall_spr_zu.spr_id = s.SPR_ID
;


UPDATE DBP_DATA.verkaufsorganisation_spr_zu
   SET verkaufsorganisation_bez = s.RO_verkaufsorganisation_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.verkaufsorganisation_id  as verkaufsorganisation_id, 
                a.spr_id        as SPR_ID,
                b.verkaufsorganisation_bez as RO_verkaufsorganisation_bez
          FROM  DBP_DATA.verkaufsorganisation_spr_zu a
         INNER  JOIN DBP_DATA.verkaufsorganisation_spr_zu b
            ON  a.verkaufsorganisation_id=b.verkaufsorganisation_id 
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.verkaufsorganisation_bez <>b.verkaufsorganisation_bez
         GROUP  BY 1,2,3
) s
WHERE verkaufsorganisation_spr_zu.mandant_id =4 
  AND verkaufsorganisation_spr_zu.verkaufsorganisation_id = s.verkaufsorganisation_id
  AND verkaufsorganisation_spr_zu.spr_id = s.SPR_ID
  AND verkaufsorganisation_spr_zu.verkaufsorganisation_bez <> s.RO_verkaufsorganisation_bez
;

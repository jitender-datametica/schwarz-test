UPDATE DBP_DATA.lief_typ_spr_zu
   SET lief_typ_bez = s.RO_lief_typ_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.lief_typ_id  as lief_typ_id, 
                a.spr_id        as SPR_ID,
                b.lief_typ_bez as RO_lief_typ_bez
          FROM  DBP_DATA.lief_typ_spr_zu a
         INNER  JOIN DBP_DATA.lief_typ_spr_zu b
            ON  a.lief_typ_id=b.lief_typ_id 
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.lief_typ_bez <>b.lief_typ_bez
         GROUP  BY 1,2,3
) s
WHERE lief_typ_spr_zu.mandant_id =4 
  AND lief_typ_spr_zu.lief_typ_id = s.lief_typ_id
  AND lief_typ_spr_zu.spr_id = s.SPR_ID
  AND lief_typ_spr_zu.lief_typ_bez <> s.RO_lief_typ_bez
;

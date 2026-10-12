UPDATE DBP_DATA.versandstelle_spr_zu
   SET versandstelle_bez = s.RO_versandstelle_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.versandstelle_id  as versandstelle_id, 
                a.spr_id        as SPR_ID,
                b.versandstelle_bez as RO_versandstelle_bez
          FROM  DBP_DATA.versandstelle_spr_zu a
         INNER  JOIN DBP_DATA.versandstelle_spr_zu b
            ON  a.versandstelle_id=b.versandstelle_id 
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.versandstelle_bez <>b.versandstelle_bez
         GROUP  BY 1,2,3
) s
WHERE versandstelle_spr_zu.mandant_id =4 
  AND versandstelle_spr_zu.versandstelle_id = s.versandstelle_id
  AND versandstelle_spr_zu.spr_id = s.SPR_ID
  AND versandstelle_spr_zu.versandstelle_bez <> s.RO_versandstelle_bez
;

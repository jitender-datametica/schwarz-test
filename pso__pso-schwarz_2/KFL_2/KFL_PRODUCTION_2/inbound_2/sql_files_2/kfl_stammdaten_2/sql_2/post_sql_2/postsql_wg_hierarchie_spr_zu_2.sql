--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.wg_hierarchie_spr_zu_2
WHERE mandant_id = 5 AND
      spr_id = 124
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.wg_hierarchie_spr_zu_2
WHERE spr_id = 24
;

UPDATE DBP_DATA.wg_hierarchie_spr_zu_2
   SET WG_HIERARCHIE_BEZ = s.RO_WG_HIERARCHIE_BEZ,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.WG_HIERARCHIE_EBENE_ID    as WG_HIERARCHIE_EBENE_ID, 
                a.WG_HIERARCHIE_ID          as WG_HIERARCHIE_ID, 
                a.ARTHIERTYP_ID             as ARTHIERTYP_ID, 
                a.spr_id                    as SPR_ID,
                b.WG_HIERARCHIE_BEZ         as RO_WG_HIERARCHIE_BEZ
          FROM  DBP_DATA.wg_hierarchie_spr_zu_2 a
         INNER  JOIN DBP_DATA.wg_hierarchie_spr_zu_2 b
            ON  a.WG_HIERARCHIE_EBENE_ID=b.WG_HIERARCHIE_EBENE_ID 
           AND  a.WG_HIERARCHIE_ID = b.WG_HIERARCHIE_ID
           AND  a.ARTHIERTYP_ID = b.ARTHIERTYP_ID
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.WG_HIERARCHIE_BEZ <>b.WG_HIERARCHIE_BEZ
         GROUP  BY 1,2,3,4,5
) s
WHERE wg_hierarchie_spr_zu.mandant_id = 4 
  AND wg_hierarchie_spr_zu.WG_HIERARCHIE_EBENE_ID   = s.WG_HIERARCHIE_EBENE_ID
  AND wg_hierarchie_spr_zu.WG_HIERARCHIE_ID         = s.WG_HIERARCHIE_ID
  AND wg_hierarchie_spr_zu.ARTHIERTYP_ID            = s.ARTHIERTYP_ID
  AND wg_hierarchie_spr_zu.spr_id                   = s.SPR_ID
  AND wg_hierarchie_spr_zu.WG_HIERARCHIE_BEZ        <> s.RO_WG_HIERARCHIE_BEZ
;




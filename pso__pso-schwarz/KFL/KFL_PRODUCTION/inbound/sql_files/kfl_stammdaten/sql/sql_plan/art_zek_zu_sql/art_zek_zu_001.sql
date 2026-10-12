--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBP_MSI_DATA.art_zek_zu
--WHERE mandant_id = 1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBP_MSI_DATA.art_zek_zu
WHERE mandant_id = 1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBP_MSI_DATA.art_zek_zu (art_id
--                                                  ,mandant_id
--                                                  ,zek_id)
--SELECT x.art_id,
--       x.mandant_id,
--       x.zek_id
--FROM (SELECT DISTINCT 
--             art_id,
--             mandant_id,
--             zek_id
--      FROM DBX_DATA.art
--      WHERE dat_bis = '9999-12-31' AND
--            mandant_id = 1
--      UNION
--      SELECT DISTINCT 
--             a.art_id,
--             a.mandant_id,
--             b.zek_id
--      FROM DBX_DATA.art a
--      JOIN (SELECT zek_id
--            FROM DBX_DATA.zek
--            WHERE mandant_id = 1 
--            GROUP BY 1) b
--        ON 1 = 1
--      WHERE a.dat_bis = '9999-12-31' AND
--            a.art_id = -1) x
--      
--      UNION
--
--      SELECT DISTINCT
--             a2.art_id,
--             a1.mandant_id,
--             a1.zek_id
--      FROM DBX_DATA.art a1
--      
--      JOIN DBX_DATA.art_wg_zu_per aw1
--        ON aw1.art_id = a1.art_id AND
--           aw1.mandant_id = a1.mandant_id
--      
--      JOIN DBX_DATA.art_wg_zu_per aw2
--        ON aw2.wg_id = aw1.wg_id AND
--           aw2.mandant_id = aw1.mandant_id AND
--           aw2.arthiertyp_id = aw1.arthiertyp_id
--      
--      JOIN DBX_DATA.art a2
--        ON  aw2.art_id = a2.art_id AND
--            aw2.mandant_id = a2.mandant_id AND
--            a2.wg_art_fg = 1
--      
--      WHERE aw1.dat_bis = '9999-12-31' AND
--            aw2.dat_bis = '9999-12-31' AND
--            a1.mandant_id = 1 AND
--            aw1.arthiertyp_id = 2
--      
--      UNION
--      
--      SELECT a2.art_id,
--             a2.mandant_id,
--             aw1.zek_id
--      FROM (SELECT aw.wug_id, 
--                   aw.wg_id, 
--                   a1.zek_id  
--            FROM DBX_DATA.art_wg_zu_per aw
--            
--            JOIN DBX_DATA.art a1  
--              ON aw.art_id = a1.art_id AND
--                 aw.mandant_id = a1.mandant_id
--   
--            WHERE aw.mandant_id = 1 AND 
--                  aw.dat_bis = 80991231 AND 
--                  a1.dat_bis='9999-12-31' AND 
--                  aw.arthiertyp_id = 2 
--            GROUP BY  1,2,3)  aw1
--            
--JOIN (SELECT * 
--      FROM DBX_DATA.art_wg_zu_per 
--      WHERE mandant_id = 1 AND 
--            dat_bis = 80991231 AND 
--            arthiertyp_id = 2) aw2
--  ON aw2.wg_id = aw1.wg_id AND
--     aw2.wug_id = aw1.wug_id 
--
--RIGHT JOIN DBX_DATA.art a2
--  ON aw2.art_id = a2.art_id AND
--     aw2.mandant_id = a2.mandant_id AND
--     a2.wg_art_fg = 0
--     
--WHERE aw1.zek_id IS NOT NULL
--
--GROUP BY a2.art_id, a2.mandant_id, aw1.zek_id
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBP_MSI_DATA.art_zek_zu (art_id
                                                  ,mandant_id
                                                  ,zek_id)
SELECT x.art_id,
       x.mandant_id,
       x.zek_id
FROM (SELECT DISTINCT 
             art_id,
             mandant_id,
             zek_id
      FROM DBP_DATA.art
      WHERE dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
            mandant_id = 1
      UNION
      SELECT DISTINCT 
             a.art_id,
             a.mandant_id,
             b.zek_id
      FROM DBP_DATA.art a
      JOIN (SELECT zek_id
            FROM DBP_DATA.zek
            WHERE mandant_id = 1 
            GROUP BY 1) b
        ON 1 = 1
      WHERE a.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
            a.art_id = -1) x
      
      UNION

      SELECT DISTINCT
             a2.art_id,
             a1.mandant_id,
             a1.zek_id
      FROM DBP_DATA.art a1
      
      JOIN DBP_DATA.art_wg_zu_per aw1
        ON aw1.art_id = a1.art_id AND
           aw1.mandant_id = a1.mandant_id
      
      JOIN DBP_DATA.art_wg_zu_per aw2
        ON aw2.wg_id = aw1.wg_id AND
           aw2.mandant_id = aw1.mandant_id AND
           aw2.arthiertyp_id = aw1.arthiertyp_id
      
      JOIN DBP_DATA.art a2
        ON  aw2.art_id = a2.art_id AND
            aw2.mandant_id = a2.mandant_id AND
            a2.wg_art_fg = 1
      
      WHERE aw1.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
            aw2.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND
            a1.mandant_id = 1 AND
            aw1.arthiertyp_id = 2
      
      UNION
      
      SELECT a2.art_id,
             a2.mandant_id,
             aw1.zek_id
      FROM (SELECT aw.wug_id, 
                   aw.wg_id, 
                   a1.zek_id  
            FROM DBP_DATA.art_wg_zu_per aw
            
            JOIN DBP_DATA.art a1  
              ON aw.art_id = a1.art_id AND
                 aw.mandant_id = a1.mandant_id
   
            WHERE aw.mandant_id = 1 AND 
                  aw.dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND 
                  a1.dat_bis= to_date('9999-12-31','YYYY-MM-DD') AND 
                  aw.arthiertyp_id = 2 
            GROUP BY  1,2,3)  aw1
            
JOIN (SELECT * 
      FROM DBP_DATA.art_wg_zu_per 
      WHERE mandant_id = 1 AND 
            dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND 
            arthiertyp_id = 2) aw2
  ON aw2.wg_id = aw1.wg_id AND
     aw2.wug_id = aw1.wug_id 

RIGHT JOIN DBP_DATA.art a2
  ON aw2.art_id = a2.art_id AND
     aw2.mandant_id = a2.mandant_id AND
     a2.wg_art_fg = 0
     
WHERE aw1.zek_id IS NOT NULL

GROUP BY a2.art_id, a2.mandant_id, aw1.zek_id
;


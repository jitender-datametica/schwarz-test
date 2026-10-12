--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM KFL_PRODUCTION.DBP_MSI_DATA.art_zek_zu_2
--WHERE mandant_id = 1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DELETE FROM dbp_msi_data.art_zek_zu_2
WHERE mandant_id = 1;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO KFL_PRODUCTION.DBP_MSI_DATA.art_zek_zu_2 (art_id
--                                                  ,mandant_id
--                                                  ,zek_id)
--SELECT x.art_id,
--       x.mandant_id,
--       x.zek_id
--FROM (SELECT DISTINCT 
--             art_id,
--             mandant_id,
--             zek_id
--      FROM KFL_PRODUCTION.DBX_DATA.art_2
--      WHERE dat_bis = '9999-12-31' AND
--            mandant_id = 1
--      UNION
--      SELECT DISTINCT 
--             a.art_id,
--             a.mandant_id,
--             b.zek_id
--      FROM KFL_PRODUCTION.DBX_DATA.art_2 a
--      JOIN (SELECT zek_id
--            FROM KFL_PRODUCTION.DBX_DATA.zek_2
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
--      FROM KFL_PRODUCTION.DBX_DATA.art_2 a1
--      
--      JOIN KFL_PRODUCTION.DBX_DATA.art_wg_zu_per_2 aw1
--        ON aw1.art_id = a1.art_id AND
--           aw1.mandant_id = a1.mandant_id
--      
--      JOIN KFL_PRODUCTION.DBX_DATA.art_wg_zu_per_2 aw2
--        ON aw2.wg_id = aw1.wg_id AND
--           aw2.mandant_id = aw1.mandant_id AND
--           aw2.arthiertyp_id = aw1.arthiertyp_id
--      
--      JOIN KFL_PRODUCTION.DBX_DATA.art_2 a2
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
--            FROM KFL_PRODUCTION.DBX_DATA.art_wg_zu_per_2 aw
--            
--            JOIN KFL_PRODUCTION.DBX_DATA.art_2 a1  
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
--      FROM KFL_PRODUCTION.DBX_DATA.art_wg_zu_per_2 
--      WHERE mandant_id = 1 AND 
--            dat_bis = 80991231 AND 
--            arthiertyp_id = 2) aw2
--  ON aw2.wg_id = aw1.wg_id AND
--     aw2.wug_id = aw1.wug_id 
--
--RIGHT JOIN KFL_PRODUCTION.DBX_DATA.art_2 a2
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
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


INSERT INTO dbp_msi_data.art_zek_zu_2 (art_id, mandant_id, zek_id)
(SELECT
    art_id,
    mandant_id,
    zek_id
FROM ((
    SELECT
        art_id,
        mandant_id,
        zek_id
    FROM (
        SELECT DISTINCT
            art_id,
            mandant_id,
            zek_id
        FROM dbp_data.art_2
        WHERE
            dat_bis = PARSE_DATE('%F', '9999-12-31')
            AND mandant_id = 1
        UNION DISTINCT
        SELECT DISTINCT
            A.art_id,
            A.mandant_id,
            b.zek_id
        FROM dbp_data.art_2 AS A
        INNER JOIN (
            SELECT zek_id
            FROM dbp_data.zek_2
            WHERE mandant_id = 1
            GROUP BY zek_id
        ) AS b
            ON TRUE
        WHERE
            A.dat_bis = PARSE_DATE('%F', '9999-12-31')
            AND A.art_id = -1
    ) AS x
    UNION DISTINCT
    SELECT DISTINCT
        A2.art_id,
        A1.mandant_id,
        A1.zek_id
    FROM dbp_data.art_2 AS A1
    INNER JOIN
        dbp_data.art_wg_zu_per_2 AS AW1
        ON A1.art_id = AW1.art_id AND A1.mandant_id = AW1.mandant_id

    INNER JOIN dbp_data.art_wg_zu_per_2 AS AW2
        ON
            AW1.wg_id = AW2.wg_id AND AW1.mandant_id = AW2.mandant_id
            AND AW1.arthiertyp_id = AW2.arthiertyp_id
    INNER JOIN dbp_data.art_2 AS A2
        ON
            AW2.art_id = A2.art_id
            AND AW2.mandant_id = A2.mandant_id
            AND A2.wg_art_fg
            = 1
    WHERE
        AW1.dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND AW2.dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND A1.mandant_id = 1
        AND AW1.arthiertyp_id = 2
)
UNION DISTINCT
SELECT
    A2.art_id,
    A2.mandant_id,
    aw1.zek_id
FROM (
    SELECT
        AW.wug_id,
        AW.wg_id,
        A1.zek_id
    FROM dbp_data.art_wg_zu_per_2 AS AW
    INNER JOIN
        dbp_data.art_2 AS A1
        ON AW.art_id = A1.art_id AND AW.mandant_id = A1.mandant_id
    WHERE
        AW.mandant_id = 1
        AND AW.dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND A1.dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND AW.arthiertyp_id = 2
    GROUP BY
        AW.wg_id,
        AW.wug_id,
        A1.zek_id
) AS aw1
INNER JOIN (
    SELECT *
    FROM dbp_data.art_wg_zu_per_2
    WHERE
        mandant_id = 1
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND arthiertyp_id = 2
) AS aw2
    ON aw1.wg_id = aw2.wg_id AND aw1.wug_id = aw2.wug_id
    RIGHT JOIN dbp_data.art_2 AS A2
        ON
            aw2.art_id = A2.art_id
            AND aw2.mandant_id = A2.mandant_id
            AND A2.wg_art_fg
            = 0
    WHERE aw1.zek_id IS NOT NULL
    GROUP BY
        A2.art_id,
        A2.mandant_id,
        aw1.zek_id
) AS t22);

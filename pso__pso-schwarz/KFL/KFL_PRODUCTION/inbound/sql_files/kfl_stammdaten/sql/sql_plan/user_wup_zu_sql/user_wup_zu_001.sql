--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_MSI_DATA.user_wup_zu;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_MSI_DATA.user_wup_zu;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
--original statement
--INSERT DBX_MSI_DATA.user_wup_zu
--(
--         user_id
--        ,mandant_id
--        ,wup_id
--)
--SELECT
--         v.user_id
--        ,v.mandant_id
--        ,v.wup_id
--FROM
--(
--        -- Hausleiter Ebene
--        SELECT
--                 user_id
--                ,hl_bm.mandant_id
--                ,wup_id
--        FROM DBX_MSI_DATA.user_vis_benchmark_zu hl_bm
--        INNER JOIN DBX_DATA.wup w
--        ON LOWER(hl_bm.hierarchie_ebene_id) = 'hl'
--        AND hl_bm.hierarchie_element_id = w.wup_id
--        AND hl_bm.mandant_id =  w.mandant_id
--
--        UNION
--
--        -- Verkaufsleiter Ebene
--        SELECT
--                user_id
--                ,vkl_bm.mandant_id
--                ,wup_id
--        FROM DBX_MSI_DATA.user_vis_benchmark_zu vkl_bm
--
--        INNER JOIN DBX_MSI_DATA.wup_denorm w
--        ON LOWER(vkl_bm.hierarchie_ebene_id)    = 'vkl'
--        AND vkl_bm.hierarchie_element_id        = w.vkl_id
--        AND vkl_bm.mandant_id                   = w.mandant_id
--
--        UNION
--
--        -- Vertriebsschiene (VS)  Ebene
--        SELECT
--                user_id
--                ,vs_bm.mandant_id
--                ,wup_id
--        FROM DBX_MSI_DATA.user_vis_benchmark_zu vs_bm
--        INNER JOIN DBX_DATA.wup w
--        ON LOWER(vs_bm.hierarchie_ebene_id)     = 'vs'
--        AND vs_bm.hierarchie_element_id         = w.vs_id
--        AND vs_bm.mandant_id                    = w.mandant_id
--
--        UNION
--
--        -- GF Ebene
--        SELECT
--                user_id
--                ,gf_bm.mandant_id
--                ,wup_id
--        FROM DBX_MSI_DATA.user_vis_benchmark_zu gf_bm
--
--        INNER JOIN DBX_MSI_DATA.wup_denorm w
--        ON LOWER(gf_bm.hierarchie_ebene_id)     = 'gf'
--        AND gf_bm.hierarchie_element_id         = w.gf_gbl_vertrieb_id
--        AND gf_bm.mandant_id                    = w.mandant_id
--
--        UNION
--
--        -- Vorstand  Ebene
--        SELECT
--                user_id
--                ,vst_bm.mandant_id
--                ,wup_id
--        FROM DBX_MSI_DATA.user_vis_benchmark_zu vst_bm
--
--        INNER JOIN DBX_DATA.wup w
--        ON LOWER(vst_bm.hierarchie_ebene_id) = 'land'
--        AND vst_bm.hierarchie_element_id = w.mandant_id
--
--        UNION
--
--        -- Vorstand Ebene  -1 bedeutet, alle Maerkte
--        SELECT
--                user_id
--                ,w.mandant_id
--                ,wup_id
--        FROM DBX_MSI_DATA.user_vis_benchmark_zu vst_bm
--
--        CROSS JOIN DBX_DATA.wup w
--        WHERE vst_bm.hierarchie_element_id = -1
--        AND LOWER(vst_bm.hierarchie_ebene_id) = 'land'
--
--        UNION
--
--        -- Vorstand Ebene  -2 bedeutet, alle KMO Maerkte
--        SELECT
--                user_id
--                ,w.mandant_id
--                ,wup_id
--        FROM  DBX_MSI_DATA.user_vis_benchmark_zu vst_bm
--
--        CROSS JOIN DBX_DATA.wup w
--        WHERE w.mandant_id <> 1
--        AND vst_bm.hierarchie_element_id = -2
--        AND LOWER(vst_bm.hierarchie_ebene_id) = 'land'
--) v
--
--INNER JOIN DBX_DATA.wup w
--ON      v.mandant_id    = w.mandant_id
--AND     v.wup_id        = w.wup_id
--
--WHERE   w.dat_eroeffnung IS NOT NULL
---- Maerkte bei denen Schliessungsdatum in letzten zwei Geschaeftsjahren liegt bzw. in der Zukunft (geoe ffnete MÃ¤rkte)
--AND CAST((EXTRACT(YEAR FROM DATE)) - CASE WHEN EXTRACT(MONTH FROM DATE) IN (1,2,3) THEN 3 ELSE 2 END || '-03-01' AS DATE) <= w.dat_bis
--AND  w.nb_id IN (0, -1) -- Maerkte und Zentralfilialen
--
--GROUP BY 1,2,3
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT DBX_MSI_DATA.user_wup_zu
(
         user_id
        ,mandant_id
        ,wup_id
)
SELECT
         v.user_id
        ,v.mandant_id
        ,v.wup_id
FROM
(
        -- Hausleiter Ebene
        SELECT
                 user_id
                ,hl_bm.mandant_id
                ,wup_id
        FROM DBX_MSI_DATA.user_vis_benchmark_zu hl_bm
        INNER JOIN DBP_DATA.wup w
        ON LOWER(hl_bm.hierarchie_ebene_id) = 'hl'
        AND hl_bm.hierarchie_element_id = w.wup_id
        AND hl_bm.mandant_id =  w.mandant_id

        UNION

        -- Verkaufsleiter Ebene
        SELECT
                user_id
                ,vkl_bm.mandant_id
                ,wup_id
        FROM DBX_MSI_DATA.user_vis_benchmark_zu vkl_bm

        INNER JOIN DBX_MSI_DATA.wup_denorm w
        ON LOWER(vkl_bm.hierarchie_ebene_id)    = 'vkl'
        AND vkl_bm.hierarchie_element_id        = w.vkl_id
        AND vkl_bm.mandant_id                   = w.mandant_id

        UNION

        -- Vertriebsschiene (VS)  Ebene
        SELECT
                user_id
                ,vs_bm.mandant_id
                ,wup_id
        FROM DBX_MSI_DATA.user_vis_benchmark_zu vs_bm
        INNER JOIN DBP_DATA.wup w
        ON LOWER(vs_bm.hierarchie_ebene_id)     = 'vs'
        AND vs_bm.hierarchie_element_id         = w.vs_id
        AND vs_bm.mandant_id                    = w.mandant_id

        UNION

        -- GF Ebene
        SELECT
                user_id
                ,gf_bm.mandant_id
                ,wup_id
        FROM DBX_MSI_DATA.user_vis_benchmark_zu gf_bm

        INNER JOIN DBX_MSI_DATA.wup_denorm w
        ON LOWER(gf_bm.hierarchie_ebene_id)     = 'gf'
        AND gf_bm.hierarchie_element_id         = w.gf_gbl_vertrieb_id
        AND gf_bm.mandant_id                    = w.mandant_id

        UNION

        -- Vorstand  Ebene
        SELECT
                user_id
                ,vst_bm.mandant_id
                ,wup_id
        FROM DBX_MSI_DATA.user_vis_benchmark_zu vst_bm

        INNER JOIN DBP_DATA.wup w
        ON LOWER(vst_bm.hierarchie_ebene_id) = 'land'
        AND vst_bm.hierarchie_element_id = w.mandant_id

        UNION

        -- Vorstand Ebene  -1 bedeutet, alle Maerkte
        SELECT
                user_id
                ,w.mandant_id
                ,wup_id
        FROM DBX_MSI_DATA.user_vis_benchmark_zu vst_bm

        CROSS JOIN DBP_DATA.wup w
        WHERE vst_bm.hierarchie_element_id = -1
        AND LOWER(vst_bm.hierarchie_ebene_id) = 'land'

        UNION

        -- Vorstand Ebene  -2 bedeutet, alle KMO Maerkte
        SELECT
                user_id
                ,w.mandant_id
                ,wup_id
        FROM  DBX_MSI_DATA.user_vis_benchmark_zu vst_bm

        CROSS JOIN DBP_DATA.wup w
        WHERE w.mandant_id <> 1
        AND vst_bm.hierarchie_element_id = -2
        AND LOWER(vst_bm.hierarchie_ebene_id) = 'land'
) v

INNER JOIN DBP_DATA.wup w
ON      v.mandant_id    = w.mandant_id
AND     v.wup_id        = w.wup_id

WHERE   w.dat_eroeffnung IS NOT NULL
-- Maerkte bei denen Schliessungsdatum in letzten zwei Geschaeftsjahren liegt bzw. in der Zukunft (geoe ffnete MÃ¤rkte)
AND CAST((EXTRACT(YEAR FROM CURRENT_DATE)) - CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) IN (1,2,3) THEN 3 ELSE 2 END || '-03-01' AS CURRENT_DATE) <= w.dat_bis
AND  w.nb_id IN (0, -1) -- Maerkte und Zentralfilialen

GROUP BY 1,2,3
;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_MSI_DATA.user_vis_benchmark_zu_2
--(
--user_id
--,mandant_id
--,hierarchie_element_id
--,hierarchie_ebene_id
--)
--SELECT
--         TRIM(m.land_id)||'_'||TRIM(w.wup_id) AS user_id
--        ,w.mandant_id   AS mandant_id
--        ,w.wup_id       AS hierarchie_element_id
--        ,'hl_2'           AS hierarchie_ebene_id
--FROM    DBX_DATA.wup_2 w
--INNER JOIN DBX_PROCESS.land_mandant_zu_2 m
--ON      w.mandant_id = m.mandant_id
--
--WHERE   w.dat_bis > DATE
--AND     w.nb_id = 0
--AND     (w.wup_id,w.mandant_id) NOT IN
--        (SELECT hierarchie_element_id,mandant_id
--         FROM DBX_MSI_DATA.user_vis_benchmark_zu_2
--         WHERE hierarchie_ebene_id = 'hl_2'
--        )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
INSERT INTO DBX_MSI_DATA.user_vis_benchmark_zu_2
(
user_id
,mandant_id
,hierarchie_element_id
,hierarchie_ebene_id
)
SELECT
         TRIM(m.land_id)||'_'||TRIM(w.wup_id) AS user_id
        ,w.mandant_id   AS mandant_id
        ,w.wup_id       AS hierarchie_element_id
        ,'hl_2'           AS hierarchie_ebene_id
FROM    DBP_DATA.wup_2 w
INNER JOIN DBX_PROCESS.land_mandant_zu_2 m
ON      w.mandant_id = m.mandant_id

WHERE   w.dat_bis > CURRENT_DATE
AND     w.nb_id = 0
AND     (w.wup_id,w.mandant_id) NOT IN
        (SELECT hierarchie_element_id,mandant_id
         FROM DBX_MSI_DATA.user_vis_benchmark_zu_2
         WHERE hierarchie_ebene_id = 'hl_2'
        )
;


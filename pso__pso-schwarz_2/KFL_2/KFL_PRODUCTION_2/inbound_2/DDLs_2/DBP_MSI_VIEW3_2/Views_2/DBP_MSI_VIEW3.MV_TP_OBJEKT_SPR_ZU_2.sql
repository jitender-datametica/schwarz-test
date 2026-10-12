CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TP_OBJEKT_SPR_ZU_2 AS 
--2020.11.04 [nwag2310] if no record in user language is available, display the text maintained in default language
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
    v00.mandant_id,
    v00.tp_objekt_id,
    v00.spr_id,
    v00.tp_objekt_bez
FROM
    (
        SELECT
            v01.mandant_id,
            v01.tp_objekt_id,
            v01.spr_id,
            v01.tp_objekt_bez,
            CASE
                WHEN v02.spr_id IS NOT NULL THEN 1
                WHEN v03.spr_id = v01.spr_id THEN 2
                ELSE 3
            END AS  prio,
            ROW_NUMBER() OVER (
                PARTITION BY v01.mandant_id,
                v01.tp_objekt_id
                ORDER BY
                    prio ASC
            ) AS rownum
        FROM
            dbp_view.v_tp_objekt_spr_zu_2 v01
            JOIN dbp_view.v_mandant_spr_zu_2 v03 
            ON v01.mandant_id = v03.mandant_id
            LEFT JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02 
            ON v01.spr_id = v02.spr_id
    ) v00
WHERE
    v00.rownum = 1;
--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DEL FROM KFL_PRODUCTION.DBX_DATA.art_art_gruppe_flw_2;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


TRUNCATE TABLE dbp_data.art_art_gruppe_flw_2;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO KFL_PRODUCTION.DBX_DATA.art_art_gruppe_flw_2
--SELECT
--t2.mandant_id,
--t2.art_id,
--Max(CASE WHEN t0.art_gruppe_id='FL001' THEN t0.art_attribut_id ELSE '-' END) AS art_gruppe_id,
--Max(CASE WHEN t0.art_gruppe_id='FL001' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt / not maintained' END) AS art_gruppe_bez,
--Max(CASE WHEN t0.art_gruppe_id='FL003' THEN t0.art_attribut_id ELSE '-' END) AS art_klasse_id,
--Max(CASE WHEN t0.art_gruppe_id='FL003' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_klasse_bez,
--Max(CASE WHEN t0.art_gruppe_id='FL002' THEN t0.art_attribut_id ELSE '-' END) AS art_rohstoff_id,
--Max(CASE WHEN t0.art_gruppe_id='FL002' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_rohstoff_bez
--FROM KFL_PRODUCTION.DBX_DATA.art_2 t2
--
--LEFT JOIN KFL_PRODUCTION.DBX_DATA.art_gruppe_attribut_zu_2 t0
--ON t2.mandant_id=t0.mandant_id
--AND t2.art_id=t0.art_id
--
--LEFT JOIN KFL_PRODUCTION.DBX_DATA.art_attribut_spr_zu_2 t1_2
--ON t0.art_attribut_id=t1.art_attribut_id
--
--WHERE t2.loesch_id <> 'L'
--AND (t2.mandant_id, t2.art_id) IN (sel mandant_id, art_id from KFL_PRODUCTION.DBX_DATA.art_wg_zu_per_2 where dat_bis=80991231 and (mandant_id, art_id) in ( SEL mandant_id, art_id FROM KFL_PRODUCTION.DBX_DATA.art_gruppe_attribut_zu_2))
--GROUP BY 1,2;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


-- t2.loesch_id <> 'L' NSR4462627
INSERT INTO dbp_data.art_art_gruppe_flw_2
(
    SELECT
        T2.mandant_id AS mandant_id,
        T2.art_id AS art_id,
        MAX(CASE
            WHEN T0.art_gruppe_id = 'FL001'
                THEN T0.art_attribut_id
            ELSE '-'
        END) AS art_gruppe_id,
        MAX(CASE
            WHEN T0.art_gruppe_id = 'FL001'
                THEN T1.art_attribut_bez
            ELSE '-/nicht gepflegt / not maintained'
        END) AS art_gruppe_bez,
        MAX(CASE
            WHEN T0.art_gruppe_id = 'FL003'
                THEN T0.art_attribut_id
            ELSE '-'
        END) AS art_klasse_id,
        MAX(CASE
            WHEN T0.art_gruppe_id = 'FL003'
                THEN T1.art_attribut_bez
            ELSE '-/nicht gepflegt/not maintained'
        END) AS art_klasse_bez,
        MAX(CASE
            WHEN T0.art_gruppe_id = 'FL002'
                THEN T0.art_attribut_id
            ELSE '-'
        END) AS art_rohstoff_id,
        MAX(CASE
            WHEN T0.art_gruppe_id = 'FL002'
                THEN T1.art_attribut_bez
            ELSE '-/nicht gepflegt/not maintained'
        END) AS art_rohstoff_bez,
        CURRENT_TIMESTAMP() AS td_insert,
        CURRENT_TIMESTAMP() AS td_update
    FROM dbp_data.art_2 AS T2
    LEFT JOIN
        dbp_data.art_gruppe_attribut_zu_2 AS T0
        ON T2.mandant_id = T0.mandant_id AND T2.art_id = T0.art_id

    LEFT JOIN
        dbp_data.art_attribut_spr_zu_2 AS T1_2
        ON T0.art_attribut_id = T1.art_attribut_id
    WHERE (
        T2.mandant_id, T2.art_id) IN (
        SELECT (mandant_id, art_id)
        FROM dbp_data.art_wg_zu_per_2
        WHERE
            dat_bis = PARSE_DATE('%F', '9999-12-31')
            AND (
                mandant_id, art_id) IN (
                SELECT (mandant_id, art_id)
                FROM dbp_data.art_gruppe_attribut_zu_2
            )
    )
    GROUP BY
        T2.mandant_id,
        T2.art_id
);

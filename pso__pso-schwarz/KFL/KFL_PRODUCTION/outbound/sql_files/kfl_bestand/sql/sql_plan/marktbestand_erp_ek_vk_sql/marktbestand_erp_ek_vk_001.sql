-- [OK]-----------------------------------------------------------------

UPDATE dbp_etl.marktbestand_erp_tmp
SET
    bezugsweg_id = t1.`_bezugsweg_id`,
    vk_netto = ROUND(CAST(t1.`_vk_netto` AS NUMERIC), 3),
    listung_id = t1.`_listung_id`,
    kdis = COALESCE(t1.`_kdis`, -1),
    wrg_id = t1.`_wrg_id`
FROM
    (
        SELECT
            T01.mandant_id AS `_mandant_id`,
            T01.wup_id AS `_wup_id`,
            T01.art_id AS `_art_id`,
            T02.bezugsweg_id AS `_bezugsweg_id`,
            T02.listung_id AS `_listung_id`,
            T02.kdis AS `_kdis`,
            CASE
                WHEN T04.mwst IS NOT NULL
                    THEN CAST(T02.vk_brutto / (1 + T04.mwst / 100) AS NUMERIC)
                ELSE T02.vk_brutto
            END AS `_vk_netto`,
            T02.wrg_id AS `_wrg_id`
        FROM dbp_etl.marktbestand_erp_tmp AS T01
        INNER JOIN dbp_data.art_wup_zu_per AS T02
            ON
                T01.mandant_id = T02.mandant_id
                AND T01.art_id = T02.art_id
                AND T01.wup_id = T02.wup_id
        LEFT JOIN dbp_data.art AS T03
            ON T01.mandant_id = T03.mandant_id AND T01.art_id = T03.art_id
        LEFT JOIN dbp_data.mwst_per AS T04
            ON
                T03.mandant_id = T04.mandant_id
                AND T03.mwst_id = T04.mwst_id
                AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
                BETWEEN T04.dat_von
                AND (T04.dat_bis)
        WHERE
            DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
            BETWEEN T02.dat_von
            AND (T02.dat_bis)
    ) AS t1
WHERE
    marktbestand_erp_tmp.mandant_id = t1.`_mandant_id`
    AND marktbestand_erp_tmp.wup_id = t1.`_wup_id`
    AND marktbestand_erp_tmp.art_id = t1.`_art_id`;

-- [OK]-----------------------------------------------------------------

UPDATE dbp_etl.marktbestand_erp_tmp
SET
    ek_netto = dt1.`_ek_netto`,
    ek_netto_bnk = dt1.`_ek_netto_bnk`,
    vz_wup_id = dt1.`_vz_wup_id`,
    wrg_id = dt1.`_wrg_id`
FROM
    (
        SELECT
            T01.mandant_id AS `_mandant_id`,
            T01.wup_id AS `_wup_id`,
            T01.art_id AS `_art_id`,
            MAX(COALESCE(E.ek_netto, EE.ek_netto, 0)) AS `_ek_netto`,
            MAX(COALESCE(E.ek_netto_bnk, EE.ek_netto_bnk, 0)) AS `_ek_netto_bnk`,
            MAX(COALESCE(Z.vz_wup_id, 6907)) AS `_vz_wup_id`,
            'EUR' AS `_wrg_id`
        FROM dbp_etl.marktbestand_erp_tmp AS T01
        LEFT JOIN dbp_data.art_gp_nm_zu_per AS Z
            ON
                T01.mandant_id = Z.mandant_id
                AND Z.mandant_id = 1
                AND T01.wup_id = Z.wup_id
                AND T01.art_id = Z.art_id
                AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
                BETWEEN Z.dat_von
                AND (Z.dat_bis)
        LEFT JOIN dbp_data.art_gp_wup_zu_per AS E
            ON
                Z.mandant_id = E.mandant_id
                AND Z.vz_wup_id = E.wup_id
                AND Z.art_id = E.art_id
                AND Z.gp_id = E.gp_id
                AND Z.bq_findung_id <> 25
                AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
                BETWEEN E.dat_von
                AND (E.dat_bis)
                AND E.mandant_id = 1
        LEFT JOIN dbp_data.art_gp_wup_zu_per AS EE
            ON
                Z.mandant_id = EE.mandant_id
                AND -1 = EE.wup_id
                AND Z.art_id
                = EE.art_id
                AND Z.gp_id = EE.gp_id
                AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
                BETWEEN EE.dat_von
                AND (EE.dat_bis)
                AND EE.mandant_id = 1
        WHERE T01.mandant_id = 1
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_art_id`
    ) AS dt1
WHERE
    marktbestand_erp_tmp.mandant_id = dt1.`_mandant_id`
    AND marktbestand_erp_tmp.wup_id = dt1.`_wup_id`
    AND marktbestand_erp_tmp.art_id = dt1.`_art_id`
    AND marktbestand_erp_tmp.mandant_id = 1;

-- [not OK] statement is not translated correctly-----------------------------------------------------------------
-- not updating wrg_id as update from itself

UPDATE dbp_etl.marktbestand_erp_tmp
SET
    ek_nettonetto = dt1.`_ek_nettonetto`,
    einstandspreis = dt1.`_einstandspreis`,
    gp_id = dt1.`_gp_id`
FROM
    (
        SELECT DISTINCT
            T01.mandant_id AS `_mandant_id`,
            T01.wup_id AS `_wup_id`,
            T01.art_id AS `_art_id`,
            CASE
                WHEN MA_MEP.ek_faktor IS NOT NULL
                    THEN ROUND(CAST(T01.vk_netto * MA_MEP.ek_faktor AS NUMERIC), 4)
                WHEN MA_EIN.ek_faktor IS NOT NULL
                    THEN ROUND(CAST(T01.vk_netto * MA_EIN.ek_faktor AS NUMERIC), 4)
                WHEN MS_MEP.ek_faktor IS NOT NULL
                    THEN ROUND(CAST(T01.vk_netto * MS_MEP.ek_faktor AS NUMERIC), 4)
                WHEN MS_EIN.ek_faktor IS NOT NULL
                    THEN ROUND(CAST(T01.vk_netto * MS_EIN.ek_faktor AS NUMERIC), 4)
                WHEN E.ek_nettonetto IS NOT NULL
                    THEN E.ek_nettonetto
                WHEN EE.ek_nettonetto IS NOT NULL
                    THEN EE.ek_nettonetto
                ELSE CAST(T01.vk_netto AS NUMERIC)
            END AS `_ek_nettonetto`,
            CASE
                WHEN MA_EIN.ek_faktor IS NOT NULL
                    THEN ROUND(CAST(T01.vk_netto * MA_EIN.ek_faktor AS NUMERIC), 4)
                WHEN MS_EIN.ek_faktor IS NOT NULL
                    THEN ROUND(CAST(T01.vk_netto * MS_EIN.ek_faktor AS NUMERIC), 4)
                WHEN E.einstandspreis IS NOT NULL
                    THEN E.einstandspreis
                WHEN EE.einstandspreis IS NOT NULL
                    THEN EE.einstandspreis
                ELSE CAST(T01.vk_netto AS NUMERIC)
            END AS `_einstandspreis`,
            COALESCE(Z.gp_id, -1) AS `_gp_id`
        FROM dbp_etl.marktbestand_erp_tmp AS T01
        LEFT JOIN dbp_data.art_gp_nm_zu_per AS Z
            ON
                T01.mandant_id = Z.mandant_id
                AND T01.wup_id = Z.wup_id
                AND T01.art_id = Z.art_id
                AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
                BETWEEN Z.dat_von
                AND (

                    Z.dat_bis  -- Betriebsspezifischer EK Preis
                )
                AND Z.mandant_id NOT IN (1)
        LEFT JOIN dbp_data.art_gp_wup_zu_per AS E
            ON
                Z.mandant_id = E.mandant_id
                AND Z.vz_wup_id = E.wup_id
                AND Z.art_id = E.art_id
                AND Z.gp_id = E.gp_id
                AND MOD(Z.bq_findung_id, 2) = 1
                /* ungerade BQ Findung ID Zugriff mit Wup */ AND Z.bq_findung_id <> 25
                AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
                BETWEEN E.dat_von
                AND (E.dat_bis)
                AND E.mandant_id NOT IN (1)
        LEFT JOIN dbp_data.art_gp_wup_zu_per AS EE
            ON
                Z.mandant_id = EE.mandant_id
                AND -1 = EE.wup_id
                AND Z.art_id
                = EE.art_id
                AND Z.gp_id = EE.gp_id
                AND MOD(Z.bq_findung_id, 2)
                = 0  /* gerade BQ Findung ID Zugriff ohne Wup */
                AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
                BETWEEN EE.dat_von
                AND (EE.dat_bis)
                AND EE.mandant_id NOT IN (1)
        LEFT JOIN dbp_data.art_man_spanne_per AS MS_EIN
            ON
                Z.mandant_id = MS_EIN.mandant_id
                AND Z.art_id = MS_EIN.art_id
                AND Z.bq_findung_id = 27
                AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
                BETWEEN MS_EIN.dat_von
                AND (MS_EIN.dat_bis)
                AND MS_EIN.konditionsart_id = 'ZWGS'  /* einstandspreis */
                AND MS_EIN.loesch_fg
                = 0  -- Zuerst betriebsuebergreifenden manuellen Spannenfaktoren (mep)
                AND MS_EIN.mandant_id NOT IN (1)
        LEFT JOIN dbp_data.art_man_spanne_per AS MS_MEP
            ON
                Z.mandant_id = MS_MEP.mandant_id
                AND Z.art_id = MS_MEP.art_id
                AND Z.bq_findung_id = 27
                AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
                BETWEEN MS_MEP.dat_von
                AND (MS_MEP.dat_bis)
                AND MS_MEP.konditionsart_id = 'ZWGM'  /* mep */
                AND MS_MEP.loesch_fg = 0
                -- Ermittlung Betriebsspezifischer manuelle Spannefaktoren (einstandspreis)
                AND MS_MEP.mandant_id NOT IN (1)
        LEFT JOIN dbp_data.art_wup_man_spanne_per AS MA_EIN
            ON
                Z.mandant_id = MA_EIN.mandant_id
                AND Z.art_id = MA_EIN.art_id
                AND Z.wup_id = MA_EIN.wup_id
                AND Z.bq_findung_id = 26
                AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
                BETWEEN MA_EIN.dat_von
                AND (MA_EIN.dat_bis)
                AND MA_EIN.konditionsart_id
                = 'ZWGS'  /* einstandspreis */
                AND MA_EIN.loesch_fg = 0
                -- Ermittlung Betriebsspezifischer manuelle Spannefaktoren  (mep)
                AND MA_EIN.mandant_id NOT IN (1)
        LEFT JOIN dbp_data.art_wup_man_spanne_per AS MA_MEP
            ON
                Z.mandant_id = MA_MEP.mandant_id
                AND Z.art_id = MA_MEP.art_id
                AND Z.wup_id = MA_MEP.wup_id
                AND Z.bq_findung_id = 26
                AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
                BETWEEN MA_MEP.dat_von
                AND (MA_MEP.dat_bis)
                AND MA_MEP.konditionsart_id
                = 'ZWGM'  /* mep */
                AND MA_MEP.loesch_fg = 0
                AND MA_MEP.mandant_id NOT IN (1)
        WHERE T01.mandant_id NOT IN (1)
    ) AS dt1
WHERE
    marktbestand_erp_tmp.mandant_id = dt1.`_mandant_id`
    AND marktbestand_erp_tmp.wup_id = dt1.`_wup_id`
    AND marktbestand_erp_tmp.art_id = dt1.`_art_id`
    AND marktbestand_erp_tmp.mandant_id NOT IN (1);

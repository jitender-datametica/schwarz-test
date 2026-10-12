UPDATE dbp_data.wup_1 SET
    wup_plz = dt1.`_wup_plz`,
    wup_stadt = dt1.`_wup_stadt`,
    wup_str = dt1.`_wup_str`,
    region_id = dt1.`_region_id`,
    land_id = dt1.`_land_id`,
    adresse_id = dt1.`_adresse_id`,
    mandant_id_ursprung = dt1.`_mandant_id_ursprung` FROM (SELECT
    mandant_id AS `_mandant_id`,
    wup_id AS `_wup_id`,
    wup_plz AS `_wup_plz`,
    wup_stadt AS `_wup_stadt`,
    wup_str AS `_wup_str`,
    region_id AS `_region_id`,
    land_id AS `_land_id`,
    adresse_id AS `_adresse_id`,
    mandant_id_ursprung AS `_mandant_id_ursprung`
FROM ${TEMP_TABLE}) AS dt1     /* dbp_etl.wup_temp*/
WHERE wup.mandant_id = dt1.`_mandant_id` AND wup.wup_id = dt1.`_wup_id`;


UPDATE dbp_data.wup_1 SET
    dat_eroeffnung = d.dateroffnung_cprojects,
    dat_von = d.dateroffnung_cprojects FROM (SELECT -- Aufgabe ist fuehrend vor Checkliste
    mandant_id AS mandant_id_,
    wup_id AS wup_id_,
    dateroffnung_cprojects
FROM (SELECT
    mandant_id,
    wup_id,
    MAX(dat_eroeffnung) AS dateroffnung_cprojects
FROM (
    SELECT DISTINCT
        mandant_id,
        wup_id,
        dat_eroeffnung
    FROM (
        SELECT
            MV03.mandant_id,
            MV03.wup_id,
            MV02.projekt_id,
            MV03.projekt_nr,
            MAX(CASE
                WHEN MV01.cpr_suchfeld_id = 'CPR_PRV_APLNAT'
                    THEN MV01.dat_termin
                ELSE NULL
            END) AS dat_freigabe,
            MAX(CASE
                WHEN MV01.cpr_suchfeld_id = 'EROEFFNUNGSABNAHME'
                    THEN MV01.dat_termin
                ELSE NULL
            END) AS dat_abnahme,
            MAX(CASE
                WHEN MV01.cpr_suchfeld_id = 'STILLE_EROEFFNUNG'
                    THEN MV01.dat_termin
                ELSE NULL
            END) AS dat_eroeffnung
        FROM dbp_msi_view_ios.mv_cpr_cl_punkt_1 AS MV01
        INNER JOIN dbp_msi_view_ios.mv_cpr_phase_1 AS MV02 ON MV01.projekt_phase_id = MV02.projekt_phase_id

        INNER JOIN dbp_msi_view_ios.mv_cpr_projekt_1 AS MV03 ON MV02.projekt_id = MV03.projekt_id
        WHERE
            MV03.massnahme_kz IN ('NB_1', 'UE') -- Neubau/Uebernahme

            AND MV03.cpr_systemstatus1_id IN (2) -- gueltige

            AND MV01.cpr_suchfeld_id IN ('CPR_PRV_APLNAT', 'EROEFFNUNGSABNAHME', 'STILLE_EROEFFNUNG')
            -- relevante suchfelder

            AND MV01.dat_termin IS NOT NULL
        GROUP BY
            MV03.mandant_id,
            MV03.wup_id,
            MV02.projekt_id,
            MV03.projekt_nr
    ) AS sub11
    WHERE
        wup_id IS NOT NULL
        AND dat_eroeffnung IS NOT NULL
) AS k
GROUP BY
    mandant_id,
    wup_id
HAVING dateroffnung_cprojects >= CURRENT_DATE("Europe/Berlin")) AS t8) AS d
WHERE wup.mandant_id = d.mandant_id_ AND wup.wup_id = d.wup_id_;


DELETE FROM dbp_data.wup_1
WHERE (
    mandant_id, wup_id, nb_id) IN (
    SELECT (mandant_id, wup_1, nb_id)
    FROM (
        SELECT DISTINCT
            mandant_id,
            gf_id AS wup_1,
            -1 AS nb_id
        FROM dbp_data.wup_1 AS WP
        WHERE
            mandant_id = 1
            AND nb_id = 0
            AND gf_id > 0
            AND dat_bis > CURRENT_DATE("Europe/Berlin")
            AND dat_von < CURRENT_DATE("Europe/Berlin")
    ) AS t1_1
);


-- Dummy_1 aus GF_1
INSERT INTO dbp_data.wup_1 (
    wup_id, nb_id, mandant_id, vw_id, vs_id, land_id, region_id,
    dat_von, wup_typ_id, wup_name_v, wup_name_e, wup_standort, vf_id, vkl_id, hl_id, dat_bis, wm_id, dat_eroeffnung,
    haupt_wup_id, gf_id, orig_wup_id, aktuell_wup_id
)
(
    SELECT
        WP.gf_id AS wup_id,
        -1 AS nb_id,
        WP.mandant_id,
        6 AS vw_id,
        MAX(WP.vs_id) AS vs_id,
        WP.land_id,
        -55 AS region_id,
        PARSE_DATE('%F', '2000-03-01') AS dat_von,
        0 AS wup_typ_id,
        'ZF/Maritz' || GF.ma_name || ' ' || GF.ma_vorname AS wup_name_v,
        SUBSTR('Zentralfiliale Maritz ' || GF.ma_name || ' ' || GF.ma_vorname, 1, 40) AS wup_name_e,
        'ZF/Maritz ' || GF.ma_name || ' ' || GF.ma_vorname AS wup_standort,
        2 AS vf_id,
        WP.gf_id AS vkl_id,
        -1 AS hl_id,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        -1 AS wm_id,
        PARSE_DATE('%F', '2000-03-01') AS dat_eroeffnung,
        WP.gf_id AS haupt_wup_id,
        WP.gf_id,
        WP.gf_id AS orig_wup_id,
        WP.gf_id AS aktuell_wup_id
    FROM dbp_data.wup_1 AS WP
    INNER JOIN dbp_data.ma_spr_zu_1 AS GF_1
        ON
            WP.mandant_id = GF.mandant_id AND WP.gf_id = GF.ma_id AND GF.spr_id
            = 22
    WHERE
        WP.mandant_id = 1
        AND WP.nb_id = 0
        AND WP.gf_id > 0
        AND WP.dat_bis > CURRENT_DATE("Europe/Berlin")
        AND WP.dat_von < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        WP.mandant_id,
        WP.land_id,
        WP.gf_id,
        GF.ma_name,
        GF.ma_vorname
);

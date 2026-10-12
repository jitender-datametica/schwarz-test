CREATE OR REPLACE TABLE dbp_etl.wup_denorm_tmp_2 LIKE dbp_msi_data.wup_denorm_2;


INSERT INTO dbp_etl.wup_denorm_tmp_2 (
    mandant_id, wup_id, bed_fleisch_fg, bed_fleisch_dat, bed_wurst_fg,
    bed_wurst_dat, bed_gefl_fg, bed_gefl_dat, bed_kaese_fg, bed_kaese_dat, bed_fisch_id, bed_fisch_dat, bed_feink_fg,
    bed_feink_dat, bed_bulk_fg, bed_bulk_dat, bed_bedins_fg, bed_bedins_dat, bed_imbiss_fg, bed_imbiss_dat, bed_backshop_fg,
    bed_backshop_dat, backshop_system, leergut_system, anz_leergutautomaten, glv_land_id, stv_glv_land_id, gl_vertrieb_id,
    gf_gbl_vertrieb_id, vkl_id, hausleiter_id, wbl_food_id, wbl_frische_id, wbl_nonfood_id, wbl_kasse_id,
    frische_manager_id, regionale_psb_id, tankstelle_vorh_fg, tankstelle_eigen_fg, ma_vermietung_id, eigentum_fg,
    dat_letzte_reorga, parkhaus_kz, getraenkemarkt_kz, anz_aufzuege, anz_rollsteige, anz_aufzuege_intern,
    anz_rollsteige_intern, untervermietung_kz, untervermietung_text, untervermietung_freitext, hausleiter_sperr_fg,
    vkl_sperr_fg, gf_gbl_vertrieb_sperr_fg
)
(
    SELECT
        W.mandant_id,
        W.wup_id,
        0 AS bed_fleisch_fg,
        CAST(NULL AS DATE) AS bed_fleisch_dat,
        0 AS bed_wurst_fg,
        CAST(NULL AS DATE) AS bed_wurst_dat,
        0 AS bed_gefl_fg,
        CAST(NULL AS DATE) AS bed_gefl_dat,
        0 AS bed_kaese_fg,
        CAST(NULL AS DATE) AS bed_kaese_dat,
        1 AS bed_fisch_id,
        CAST(NULL AS DATE) AS bed_fisch_dat,
        0 AS bed_feink_fg,
        CAST(NULL AS DATE) AS bed_feink_dat,
        0 AS bed_bulk_fg,
        CAST(NULL AS DATE) AS bed_bulk_dat,
        0 AS bed_bedins_fg,
        CAST(NULL AS DATE) AS bed_bedins_dat,
        0 AS bed_imbiss_fg,
        CAST(NULL AS DATE) AS bed_imbiss_dat,
        0 AS bed_backshop_fg,
        CAST(NULL AS DATE) AS bed_backshop_dat,
        '' AS backshop_system,
        '' AS leergut_system,
        0 AS anz_leergutautomaten,
        -1 AS glv_land_id,
        -1 AS stv_glv_land_id,
        -1 AS gl_vertrieb_id,
        -1 AS gf_gbl_vertrieb_id,
        -1 AS vkl_id,
        -1 AS hausleiter_id,
        -1 AS wbl_food_id,
        -1 AS wbl_frische_id,
        -1 AS wbl_nonfood_id,
        -1 AS wbl_kasse_id,
        -1 AS frische_manager_id,
        -1 AS regionale_psb_id,
        0 AS tankstelle_vorh_fg,
        -1 AS tankstelle_eigen_fg,
        -1 AS ma_vermietung_id,
        0 AS eigentum_fg,
        CAST(NULL AS DATE) AS dat_letzte_reorga,
        -1 AS parkhaus_kz,
        -1 AS getraenkemarkt_kz,
        0 AS anz_aufzuege,
        0 AS anz_rollsteige,
        0 AS anz_aufzuege_intern,
        0 AS anz_rollsteige_intern,
        '' AS untervermietung_kz,
        '' AS untervermietung_text,
        '' AS untervermietung_freitext,
        COALESCE(D.hausleiter_sperr_fg, 0) AS hausleiter_sperr_fg,
        COALESCE(D.vkl_sperr_fg, 0) AS vkl_sperr_fg,
        COALESCE(D.gf_gbl_vertrieb_sperr_fg, 0) AS gf_gbl_vertrieb_sperr_fg
    FROM dbp_data.wup_2 AS W
    LEFT JOIN dbp_msi_data.wup_denorm_2 AS D ON W.mandant_id = D.mandant_id AND W.wup_id = D.wup_id
    WHERE W.nb_id = 0
);


UPDATE dbp_etl.wup_denorm_tmp_2 SET
    bed_fleisch_fg = r.bed_fleisch_fg,
    bed_fleisch_dat = r.bed_fleisch_dat,
    bed_wurst_fg = r.bed_wurst_fg,
    bed_wurst_dat = r.bed_wurst_dat,
    bed_gefl_fg = r.bed_gefl_fg,
    bed_gefl_dat = r.bed_gefl_dat,
    bed_kaese_fg = r.bed_kaese_fg,
    bed_kaese_dat = r.bed_kaese_dat,
    bed_fisch_id = r.bed_fisch_id,
    bed_fisch_dat = CASE
        WHEN r.bed_fisch_id <> 1
            THEN r.bed_fisch_dat
        ELSE NULL
    END,
    bed_feink_fg = r.bed_feink_fg,
    bed_feink_dat = r.bed_feink_dat,
    bed_bulk_fg = r.bed_bulk_fg,
    bed_bulk_dat = r.bed_bulk_dat,
    bed_bedins_fg = r.bed_bedins_fg,
    bed_bedins_dat = r.bed_bedins_dat,
    bed_imbiss_fg = r.bed_imbiss_fg,
    bed_imbiss_dat = r.bed_imbiss_dat,
    bed_backshop_fg = r.bed_backshop_fg,
    bed_backshop_dat = r.bed_backshop_dat,
    backshop_system = COALESCE(r.backshop_system, ''),
    leergut_system = COALESCE(CASE
        WHEN r.leergut_system = 'Leergutautomaten'
            THEN 'Leergutautomat'
        ELSE r.leergut_system
    END, ''),
    anz_leergutautomaten = CAST(COALESCE(r.anz_leergutautomaten, 0) AS INTEGER) FROM (
    SELECT
        R.mandant_id,
        R.wup_id,
        MAX(CASE
            WHEN
                UPPER(K.bedienkonzept_bez) = 'ZPPM_FLEISCH' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%' AND B.dat_bedienkonzept
                < CURRENT_DATE("Europe/Berlin")
                THEN 1
            ELSE 0
        END) AS bed_fleisch_fg,
        MAX(CASE
            WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_FLEISCH' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%'
                THEN B.dat_bedienkonzept
            ELSE NULL
        END) AS bed_fleisch_dat,
        MAX(CASE
            WHEN
                UPPER(K.bedienkonzept_bez) = 'ZPPM_WURST' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%' AND B.dat_bedienkonzept
                < CURRENT_DATE("Europe/Berlin")
                THEN 1
            ELSE 0
        END) AS bed_wurst_fg,
        MAX(CASE
            WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_WURST' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%'
                THEN B.dat_bedienkonzept
            ELSE NULL
        END) AS bed_wurst_dat,
        MAX(CASE
            WHEN
                UPPER(K.bedienkonzept_bez) = 'ZPPM_GEFL' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%' AND B.dat_bedienkonzept
                < CURRENT_DATE("Europe/Berlin")
                THEN 1
            ELSE 0
        END) AS bed_gefl_fg,
        MAX(CASE
            WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_GEFL' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%'
                THEN B.dat_bedienkonzept
            ELSE NULL
        END) AS bed_gefl_dat,
        MAX(CASE
            WHEN
                UPPER(K.bedienkonzept_bez) = 'ZPPM_KAESE' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%' AND B.dat_bedienkonzept
                < CURRENT_DATE("Europe/Berlin")
                THEN 1
            ELSE 0
        END) AS bed_kaese_fg,
        MAX(CASE
            WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_KAESE' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%'
                THEN B.dat_bedienkonzept
            ELSE NULL
        END) AS bed_kaese_dat,
        MAX(CASE
            WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_FISCH' AND B.dat_bedienkonzept < CURRENT_DATE("Europe/Berlin")
                THEN B.bedienkonzept_auspr_id
            ELSE 1
        END) AS bed_fisch_id,
        MAX(CASE
            WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_FISCH'
                THEN B.dat_bedienkonzept
            ELSE NULL
        END) AS bed_fisch_dat,
        MAX(CASE
            WHEN
                UPPER(K.bedienkonzept_bez) = 'ZPPM_FEINK' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%' AND B.dat_bedienkonzept
                < CURRENT_DATE("Europe/Berlin")
                THEN 1
            ELSE 0
        END) AS bed_feink_fg,
        MAX(CASE
            WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_FEINK' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%'
                THEN B.dat_bedienkonzept
            ELSE NULL
        END) AS bed_feink_dat,
        MAX(CASE
            WHEN
                UPPER(K.bedienkonzept_bez) = 'ZPPM_BULK' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%' AND B.dat_bedienkonzept
                < CURRENT_DATE("Europe/Berlin")
                THEN 1
            ELSE 0
        END) AS bed_bulk_fg,
        MAX(CASE
            WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_BULK' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%bed%'
                THEN B.dat_bedienkonzept
            ELSE NULL
        END) AS bed_bulk_dat,
        MAX(CASE
            WHEN
                UPPER(K.bedienkonzept_bez) = 'ZPPM_BEDINS' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%ja%' AND B.dat_bedienkonzept
                < CURRENT_DATE("Europe/Berlin")
                THEN 1
            ELSE 0
        END) AS bed_bedins_fg,
        MAX(CASE
            WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_BEDINS' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%ja%'
                THEN B.dat_bedienkonzept
            ELSE NULL
        END) AS bed_bedins_dat,
        MAX(CASE
            WHEN R.mandant_id = 1
                THEN COALESCE(i.bed_imbiss_fg, 0)
            ELSE CASE
                WHEN
                    UPPER(K.bedienkonzept_bez) = 'ZPPM_IMBISS' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%ja%' AND B.dat_bedienkonzept
                    < CURRENT_DATE("Europe/Berlin")
                    THEN 1
                ELSE 0
            END
        END) AS bed_imbiss_fg,
        MAX(CASE
            WHEN R.mandant_id = 1
                THEN i.bed_imbiss_dat
            ELSE CASE
                WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_IMBISS' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%ja%'
                    THEN B.dat_bedienkonzept
                ELSE NULL
            END
        END) AS bed_imbiss_dat,
        MAX(CASE
            WHEN
                UPPER(K.bedienkonzept_bez) IN ('ZPPM_FRISCHB', 'ZPPM_DISCOUNT', 'ZPPM_BACKSHOPBED') AND LOWER(A.bedienkonzept_auspr_bez
                ) LIKE '%ja%' AND B.dat_bedienkonzept < CURRENT_DATE("Europe/Berlin")
                THEN 1
            ELSE 0
        END) AS bed_backshop_fg,
        MAX(CASE
            WHEN
                UPPER(K.bedienkonzept_bez) IN ('ZPPM_FRISCHB', 'ZPPM_DISCOUNT', 'ZPPM_BACKSHOPBED') AND LOWER(A.bedienkonzept_auspr_bez
                ) LIKE '%ja%'
                THEN B.dat_bedienkonzept
            ELSE NULL
        END) AS bed_backshop_dat,
        MAX(CASE
            WHEN
                UPPER(K.bedienkonzept_bez) = 'ZPPM_FRISCHB' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%ja%' AND B.dat_bedienkonzept
                < CURRENT_DATE("Europe/Berlin")
                THEN 'Frischebäcker'
            WHEN
                UPPER(K.bedienkonzept_bez) = 'ZPPM_DISCOUNT' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%ja%' AND B.dat_bedienkonzept
                < CURRENT_DATE("Europe/Berlin")
                THEN 'Discountbackshop'
            WHEN
                UPPER(K.bedienkonzept_bez) = 'ZPPM_BACKSHOPBED' AND LOWER(A.bedienkonzept_auspr_bez) LIKE '%ja%' AND B.dat_bedienkonzept
                < CURRENT_DATE("Europe/Berlin")
                THEN 'Backshop in Bedienung'
            ELSE ''
        END) AS backshop_system,
        MAX(CASE
            WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_LEERGUT'
                THEN A.bedienkonzept_auspr_bez
            ELSE NULL
        END) AS leergut_info,
        ROUND(SAFE_CAST(SUBSTR(MAX(CASE
            WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_LEERGUT'
                THEN A.bedienkonzept_auspr_bez
            ELSE NULL
        END), 1, 1) AS BIGNUMERIC), 0) AS anz_leergutautomaten,
        CASE
            WHEN
                ROUND(SAFE_CAST(SUBSTR(MAX(CASE
                    WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_LEERGUT'
                        THEN A.bedienkonzept_auspr_bez
                    ELSE NULL
                END), 1, 1) AS BIGNUMERIC), 0) IS NOT NULL
                THEN TRIM(SUBSTR(MAX(CASE
                    WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_LEERGUT'
                        THEN A.bedienkonzept_auspr_bez
                    ELSE NULL
                END), 2, 100))
            ELSE TRIM(MAX(CASE
                WHEN UPPER(K.bedienkonzept_bez) = 'ZPPM_LEERGUT'
                    THEN A.bedienkonzept_auspr_bez
                ELSE NULL
            END))
        END AS leergut_system
    FROM dbp_data.rpm_immobilie_per_2 AS R
    INNER JOIN dbp_data.rpm_hier_bed_konzept_zu_per_2 AS B
        ON
            R.rpm_hierarchie_id = B.rpm_hierarchie_id AND
            B.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.l_rpm_tab_2 AS T ON T.rpm_tab_id = 3 AND B.rpm_tab_id = T.rpm_tab_id
    INNER JOIN dbp_data.l_bedienkonzept_2 AS K ON B.bedienkonzept_id = K.bedienkonzept_id
    INNER JOIN dbp_data.bedienkonzept_auspr_spr_zu_2 AS A
        ON
            B.bedienkonzept_id = A.bedienkonzept_id AND B.bedienkonzept_auspr_id
            = A.bedienkonzept_auspr_id AND A.spr_id = 22
    LEFT JOIN (
        SELECT
            mandant_id,
            haupt_wup_id AS wup_id,
            MAX(CASE
                WHEN dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
                    THEN 1
                ELSE 0
            END) AS bed_imbiss_fg,
            MAX(dat_eroeffnung) AS bed_imbiss_dat
        FROM dbp_data.wup_2
        WHERE
            mandant_id = 1
            AND nb_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
            AND wup_id NOT IN (9902, 9892, 9882, 9872)
        GROUP BY
            mandant_id,
            wup_id
    ) AS i ON R.mandant_id = i.mandant_id AND R.wup_id = i.wup_id
    WHERE R.dat_bis = PARSE_DATE('%F', '9999-12-31')
    GROUP BY
        R.mandant_id,
        R.wup_id
) AS r
WHERE wup_denorm_tmp.mandant_id = r.mandant_id AND wup_denorm_tmp.wup_id = r.wup_id;


UPDATE dbp_etl.wup_denorm_tmp_2 SET
    glv_land_id = h.glv_land_id,
    stv_glv_land_id = h.stv_glv_land_id,
    gl_vertrieb_id = h.gl_vertrieb_id,
    gf_gbl_vertrieb_id = h.gf_gbl_vertrieb_id,
    vkl_id = h.vkl_id,
    wbl_food_id = h.wbl_food_id,
    wbl_frische_id = h.wbl_frische_id,
    wbl_nonfood_id = h.wbl_nonfood_id,
    wbl_kasse_id = h.wbl_kasse_id,
    frische_manager_id = h.frische_manager_id,
    regionale_psb_id = h.regionale_psb_id,
    hausleiter_id = h.hausleiter_id FROM (SELECT
    mandant_id,
    wup_id,
    glv_land_id,
    stv_glv_land_id,
    gl_vertrieb_id,
    gf_gbl_vertrieb_id,
    vkl_id,
    hausleiter_id,
    wbl_food_id,
    wbl_frische_id,
    wbl_nonfood_id,
    wbl_kasse_id,
    frische_manager_id,
    regionale_psb_id
FROM dbp_etl.ma_denorm_2) AS h
WHERE wup_denorm_tmp.mandant_id = h.mandant_id AND wup_denorm_tmp.wup_id = h.wup_id;


UPDATE dbp_etl.wup_denorm_tmp_2 SET
    eigentum_fg = u.eigentum_fg,
    ma_vermietung_id = u.ma_vermietung_id,
    tankstelle_vorh_fg = u.tankstelle_vorh_fg,
    tankstelle_eigen_fg = CASE
        WHEN u.tankstelle_vorh_fg = 0
            THEN -1
        ELSE 0
    END FROM (
    SELECT
        a.mandant_id,
        a.wup_id,
        CASE
            WHEN a.mandant_id <> 8
                THEN M.ma_id
            ELSE M1.ma_id
        END AS ma_vermietung_id,
        CASE
            WHEN a.eigentum_bez = 'Eigentum'
                THEN 1
            ELSE 0
        END AS eigentum_fg,
        COALESCE(a.tankstelle_vorh_fg, 0) AS tankstelle_vorh_fg
    FROM (
        SELECT
            T.mandant_id,
            INSTR(' ', T.tp_ol_vermietung) AS idx,
            CASE
                WHEN INSTR(' ', T.tp_ol_vermietung) > 0
                    THEN TRIM(SUBSTR(T.tp_ol_vermietung, INSTR(' ', T.tp_ol_vermietung) + 1, 100))
                ELSE T.tp_ol_vermietung
            END AS nachname,
            CASE
                WHEN INSTR(' ', T.tp_ol_vermietung) > 0
                    THEN TRIM(SUBSTR(T.tp_ol_vermietung, 1, INSTR(' ', T.tp_ol_vermietung)))
                ELSE ''
            END AS vorname,
            P.wup_id,
            T.eigentum_bez,
            T.tankstelle_vorh_fg
        FROM dbp_data.techn_platz_ebene_2_per_2 AS T
        INNER JOIN dbp_data.techn_platz_per_2 AS P
            ON
                T.mandant_id = P.mandant_id AND T.techn_platz_id = P.techn_platz_id
                AND P.dat_bis = PARSE_DATE('%F', '9999-12-31')
        WHERE
            T.dat_bis = PARSE_DATE('%F', '9999-12-31')
            AND T.mandant_id > 1
    ) AS a
    INNER JOIN dbp_data.l_ma_2 AS L ON a.mandant_id = L.mandant_id
    LEFT JOIN dbp_data.ma_spr_zu_2 AS M
        ON
            L.ma_id = M.ma_id AND COALESCE(a.nachname, '') = M.ma_name AND
            COALESCE(a.vorname, '') = M.ma_vorname AND M.spr_id = 22
    LEFT JOIN dbp_data.ma_spr_zu_2 AS M1
        ON
            L.ma_id = M1.ma_id AND COALESCE(a.nachname, '') = M1.ma_name AND
            COALESCE(a.vorname, '') = M1.ma_vorname AND M1.spr_id = 18
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY 1, 2 ORDER BY M.ma_anrede IS NULL DESC, M.ma_anrede DESC)) = 1
) AS u
WHERE wup_denorm_tmp.mandant_id = u.mandant_id AND wup_denorm_tmp.wup_id = u.wup_id;


UPDATE dbp_etl.wup_denorm_tmp_2 SET
    eigentum_fg = u.eigentum_fg,
    ma_vermietung_id = CAST(u.ma_vermietung_id AS INTEGER),
    tankstelle_vorh_fg = u.tankstelle_vorh_fg,
    tankstelle_eigen_fg = CASE
        WHEN u.tankstelle_vorh_fg = 0
            THEN -1
        ELSE 0
    END FROM (
    SELECT
        t5.mandant_id,
        t5.wup_id,
        MAX(t5.ma_vermietung_id) AS ma_vermietung_id,
        t5.tankstelle_vorh_fg,
        t5.eigentum_fg
    FROM (
        SELECT
            WE.mandant_id,
            WE.wirtschaftseinheit_id AS wup_id,
            COALESCE(CAST(v1.partner_id AS BIGNUMERIC), 0) AS ma_vermietung_id,
            MAX(CASE
                WHEN MO.branche_id = 150
                    THEN 1
                ELSE 0
            END) AS tankstelle_vorh_fg,
            MAX(CASE
                WHEN WE.besitzstatus_id = '3'
                    THEN 1
                ELSE 0
            END) AS eigentum_fg
        FROM dbp_data.immo_wirtschaftseinheit_2 AS WE
        LEFT JOIN dbp_data.immo_mietobjekt_2 AS MO ON WE.mandant_id = MO.mandant_id AND WE.we_intreno = MO.we_intreno

        LEFT JOIN (
            SELECT
                V00.partner_id,
                V01.we_intreno
            FROM dbp_data.immo_l_partner_2 AS V00
            INNER JOIN dbp_data.immo_we_partner_rolle_zu_per_2 AS V01 ON V00.partner_id = V01.partner_id
            WHERE
                CURRENT_DATE("Europe/Berlin") BETWEEN V01.dat_von AND V01.dat_bis
                AND V01.rolle_kz = 'ZI0104'
        ) AS v1 ON WE.we_intreno = v1.we_intreno
        WHERE
            WE.mandant_id = 1
            AND CURRENT_DATE("Europe/Berlin") BETWEEN WE.dat_we_gueltig_von AND WE.dat_we_gueltig_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN MO.dat_mo_gueltig_von AND MO.dat_mo_gueltig_bis
            AND COALESCE(CAST(v1.partner_id AS BIGNUMERIC), 0) <> 0
            AND WE.dat_eroeffnung < CURRENT_DATE("Europe/Berlin")
            AND (
                WE.mandant_id, WE.we_intreno) NOT IN (
                SELECT (mandant_id, we_intreno)
                FROM dbp_data.immo_wirtschaftseinheit_2
                WHERE
                    wirtschaftseinheit_bez LIKE '%paob%'
                    OR wirtschaftseinheit_bez LIKE '%UMGL%'
            )
        GROUP BY
            WE.mandant_id,
            wup_id,
            ma_vermietung_id
    ) AS t5
    GROUP BY
        t5.mandant_id,
        t5.wup_id,
        t5.tankstelle_vorh_fg,
        t5.eigentum_fg
) AS u
WHERE wup_denorm_tmp.mandant_id = u.mandant_id AND CAST(wup_denorm_tmp.wup_id AS STRING) = u.wup_id;


UPDATE dbp_etl.wup_denorm_tmp_2 SET
    tankstelle_eigen_fg = 1 FROM (
    SELECT
        mandant_id,
        haupt_wup_id
    FROM dbp_data.wup_2
    WHERE
        nb_id = 7
        AND dat_bis >= CURRENT_DATE("Europe/Berlin")
) AS u
WHERE
    wup_denorm_tmp.mandant_id = u.mandant_id AND wup_denorm_tmp.wup_id = u.haupt_wup_id AND wup_denorm_tmp.tankstelle_vorh_fg
    = 1;


UPDATE dbp_etl.wup_denorm_tmp_2 SET
    tankstelle_eigen_fg = 1,
    tankstelle_vorh_fg = 1
WHERE mandant_id = 1 AND wup_id IN (3000, 3070, 3180, 3230, 3300);


CREATE TEMPORARY TABLE IF NOT EXISTS _mv_projekt_bauabschnitt AS
SELECT
    V01.mandant_id,
    V01.cpr_ext_id
FROM dbp_data.cpr_projekt_per_2 AS V01
INNER JOIN dbp_data.cpr_phase_per_2 AS V02
    ON V01.projekt_id = V02.projekt_id AND V02.dat_bis = PARSE_DATE(
        '%F',
        '9999-12-31'
    ) AND V01.dat_bis = PARSE_DATE('%F', '9999-12-31'
    )
GROUP BY
    V01.mandant_id,
    V01.cpr_ext_id;


CREATE TEMPORARY TABLE IF NOT EXISTS _cpr_cl_punkt_termin AS
SELECT
    PT.mandant_id,
    COALESCE(PT.wup_id, 0) AS wup_id,
    MAX(PT.dat_ende_ist) AS dat_ende_ist
FROM dbp_data.cpr_cl_punkt_termin_2 AS PT
LEFT JOIN dbp_data.l_massnahme_2 AS MN ON PT.massnahme_id = MN.massnahme_id
LEFT JOIN dbp_data.cpr_projekt_per_2 AS PR
    ON PT.projekt_id = PR.projekt_id AND PR.dat_bis = PARSE_DATE(
        '%F',
        '9999-12-31'
    )
LEFT JOIN dbp_data.rpm_element_per_2 AS EL
    ON PR.projekt_id = EL.projekt_id AND EL.dat_bis = PARSE_DATE(
        '%F',
        '9999-12-31'
    )
LEFT JOIN dbp_data.massnahmentyp_spr_zu_2 AS MSZ
    ON
        EL.massnahmentyp_id = MSZ.massnahmentyp_id AND MSZ.spr_id
        = 22
LEFT JOIN dbp_data.cpr_phase_spr_zu_per_2 AS PH
    ON
        PT.projekt_phase_id = PH.projekt_phase_id AND PT.dat_ende_ist
        BETWEEN PH.dat_von AND PH.dat_bis AND PH.dat_bis = PARSE_DATE('%F', '9999-12-31') AND PH.spr_id = 22
LEFT JOIN dbp_data.cpr_aufgabe_per_2 AS AU
    ON
        PT.projekt_phase_id = AU.projekt_phase_id AND PT.dat_ende_ist
        BETWEEN AU.dat_von AND AU.dat_bis AND AU.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN `_mv_projekt_bauabschnitt` AS BAS ON PR.cpr_ext_id = BAS.cpr_ext_id
WHERE
    PR.cpr_systemstatus1_id <> 4
    OR PR.cpr_systemstatus1_id IS NULL AND PT.cpr_suchfeld = 'STILLE_EROEFFNUNG' AND PT.massnahme_id IN (
        'RE_2', 'ZPPM_RE',
        'RN', 'ZPPM_RN', 'ST', 'ZPPM_ST'
    )
GROUP BY
    PT.mandant_id,
    wup_id;


UPDATE dbp_etl.wup_denorm_tmp_2 SET
    dat_letzte_reorga = u.dat_letzte_reorga FROM (
    SELECT
        W.mandant_id,
        W.wup_id,
        t.dat_ende_ist AS dat_letzte_reorga
    FROM dbp_data.wup_2 AS W
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            MAX(dat_ende_ist) AS dat_ende_ist
        FROM `_cpr_cl_punkt_termin`
        GROUP BY
            mandant_id,
            wup_id
    ) AS t ON W.mandant_id = t.mandant_id AND W.wup_id = t.wup_id
    WHERE
        W.nb_id = 0
        AND W.umzugsfiliale_fg = 0
) AS u
WHERE wup_denorm_tmp.mandant_id = u.mandant_id AND wup_denorm_tmp.wup_id = u.wup_id;


UPDATE dbp_etl.wup_denorm_tmp_2 SET
    parkhaus_kz = u.parkhaus_kz FROM (
    SELECT
        T.mandant_id,
        T.wup_id,
        MAX(CASE
            WHEN G.techn_platz_id IS NOT NULL AND G.betreiberart_id = B.betreiberart_id
                THEN 1
            WHEN G.techn_platz_id IS NOT NULL
                THEN 0
            ELSE -1
        END) AS parkhaus_kz
    FROM dbp_data.techn_platz_per_2 AS T
    LEFT JOIN dbp_data.ginfo_betr_t_platz_zu_per_2 AS G
        ON
            T.techn_platz_id = G.techn_platz_id AND
            CURRENT_DATE("Europe/Berlin") BETWEEN G.dat_von AND G.dat_bis
    LEFT JOIN dbp_data.l_ginfo_betreiberart_2 AS B ON UPPER(B.betreiberart_bez) = 'PARKHAUS'
    WHERE
        T.mandant_id = 1
        AND CURRENT_DATE("Europe/Berlin") BETWEEN T.dat_von AND T.dat_bis
        AND T.techn_platz_ebene_id = 2
    GROUP BY
        T.mandant_id,
        T.wup_id
) AS u
WHERE wup_denorm_tmp.mandant_id = u.mandant_id AND wup_denorm_tmp.wup_id = u.wup_id;


UPDATE dbp_etl.wup_denorm_tmp_2 SET
    getraenkemarkt_kz = u.getraenkemarkt_kz FROM (
    SELECT
        T.mandant_id,
        T.wup_id,
        MAX(CASE
            WHEN G.techn_platz_id IS NOT NULL AND G.betreiberart_id = B.betreiberart_id
                THEN 1
            WHEN G.techn_platz_id IS NOT NULL
                THEN 0
            ELSE -1
        END) AS getraenkemarkt_kz
    FROM dbp_data.techn_platz_per_2 AS T
    LEFT JOIN dbp_data.ginfo_betr_t_platz_zu_per_2 AS G
        ON
            T.techn_platz_id = G.techn_platz_id AND
            CURRENT_DATE("Europe/Berlin") BETWEEN G.dat_von AND G.dat_bis
    LEFT JOIN dbp_data.l_ginfo_betreiberart_2 AS B
        ON
            UPPER(B.betreiberart_bez) =
            'SBW MIT SEPERATEM GETRÄNKEMARKT'
    WHERE
        T.mandant_id = 1
        AND CURRENT_DATE("Europe/Berlin") BETWEEN T.dat_von AND T.dat_bis
        AND T.techn_platz_ebene_id = 2
    GROUP BY
        T.mandant_id,
        T.wup_id
) AS u
WHERE wup_denorm_tmp.mandant_id = u.mandant_id AND wup_denorm_tmp.wup_id = u.wup_id;


UPDATE dbp_etl.wup_denorm_tmp_2 SET
    anz_aufzuege = dt1.anz_aufzuege,
    anz_aufzuege_intern = dt1.anz_aufzuege_intern,
    anz_rollsteige = dt1.anz_rollsteige,
    anz_rollsteige_intern = dt1.anz_rollsteige_intern FROM (
    SELECT
        T1.mandant_id,
        T3.wup_id,
        SUM(CASE
            WHEN T4.tp_merkmal_sap_id = 'CH_002_FM_002_006'
                THEN 1
            ELSE 0
        END) AS anz_aufzuege,
        SUM(CASE
            WHEN T4.tp_merkmal_sap_id = 'CH_002_FM_002_006' AND T1.tp_merkmalwert = '0001'
                THEN 1
            ELSE 0
        END) AS anz_aufzuege_intern,
        SUM(CASE
            WHEN T4.tp_merkmal_sap_id = 'CH_002_FM_016_006'
                THEN 1
            ELSE 0
        END) AS anz_rollsteige,
        SUM(CASE
            WHEN T4.tp_merkmal_sap_id = 'CH_002_FM_016_006' AND T1.tp_merkmalwert = '0001'
                THEN 1
            ELSE 0
        END) AS anz_rollsteige_intern
    FROM dbp_data.tp_objekt_merkmal_2 AS T1_2
    INNER JOIN dbp_data.tp_objekt_per_2 AS T2 ON T1.mandant_id = T2.mandant_id AND T1.tp_objekt_id = T2.tp_objekt_id

    INNER JOIN dbp_data.techn_platz_per_2 AS T3 ON T2.techn_platz_id = T3.techn_platz_id
    INNER JOIN dbp_data.l_tp_merkmal_2 AS T4 ON T1.tp_merkmal_id = T4.tp_merkmal_id
    WHERE
        T3.dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND T2.dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND T4.tp_merkmal_sap_id IN ('CH_002_FM_002_006', 'CH_002_FM_016_006')
    GROUP BY
        T1.mandant_id,
        T3.wup_id
) AS dt1
WHERE wup_denorm_tmp.mandant_id = dt1.mandant_id AND wup_denorm_tmp.wup_id = dt1.wup_id;


UPDATE dbp_etl.wup_denorm_tmp_2 SET
    untervermietung_kz = SUBSTR(u.untervermietung_kz, 1, 20),
    untervermietung_text = SUBSTR(u.untervermietung_text, 1, 160),
    untervermietung_freitext = SUBSTR(u.untervermietung_freitext, 1, 160) FROM (
    SELECT
        mandant_id,
        immo_objekt_bez AS wup_id,
        MAX(CASE
            WHEN zustimmung_id = 1
                THEN TRIM(SUBSTR(CAST(zustimmung_id AS STRING), 1, 10))
            ELSE ' '
        END) || MAX(CASE
            WHEN zustimmung_id = 2
                THEN ', ' || TRIM(SUBSTR(CAST(zustimmung_id AS STRING), 1, 10))
            ELSE ''
        END) || MAX(CASE
            WHEN zustimmung_id = 3
                THEN ', ' || TRIM(SUBSTR(CAST(zustimmung_id AS STRING), 1, 10))
            ELSE ''
        END) || MAX(CASE
            WHEN zustimmung_id = 4
                THEN ', ' || TRIM(SUBSTR(CAST(zustimmung_id AS STRING), 1, 10))
            ELSE ''
        END) || MAX(CASE
            WHEN zustimmung_id = 5
                THEN ', ' || TRIM(SUBSTR(CAST(zustimmung_id AS STRING), 1, 10))
            ELSE ''
        END) || MAX(CASE
            WHEN zustimmung_id = 6
                THEN ', ' || TRIM(SUBSTR(CAST(zustimmung_id AS STRING), 1, 10))
            ELSE ''
        END) AS untervermietung_kz,
        MAX(CASE
            WHEN zustimmung_id = 1
                THEN TRIM(zustimmung_bez)
            ELSE '  '
        END) || MAX(CASE
            WHEN zustimmung_id = 2
                THEN ' / ' || TRIM(zustimmung_bez)
            ELSE ''
        END) || MAX(CASE
            WHEN zustimmung_id = 3
                THEN ' / ' || TRIM(zustimmung_bez)
            ELSE ''
        END) || MAX(CASE
            WHEN zustimmung_id = 4
                THEN ' / ' || TRIM(zustimmung_bez)
            ELSE ''
        END) || MAX(CASE
            WHEN zustimmung_id = 5
                THEN ' / ' || TRIM(zustimmung_bez)
            ELSE ''
        END) || MAX(CASE
            WHEN zustimmung_id = 6
                THEN ' / ' || TRIM(zustimmung_bez)
            ELSE ''
        END) AS untervermietung_text,
        MAX(CASE
            WHEN zustimmung_id = 1
                THEN TRIM(zustimmung_bez)
            ELSE ' '
        END) || MAX(CASE
            WHEN zustimmung_id = 2
                THEN ' / ' || TRIM(zustimmung_bez)
            ELSE ' '
        END) || MAX(CASE
            WHEN zustimmung_id = 3
                THEN ' / ' || TRIM(zustimmung_bez)
            ELSE ' '
        END) || MAX(CASE
            WHEN zustimmung_id = 4
                THEN ' / ' || TRIM(zustimmung_bez)
            ELSE ' '
        END) || MAX(CASE
            WHEN zustimmung_id = 5
                THEN ' / ' || TRIM(zustimmung_bez)
            ELSE ' '
        END) || MAX(CASE
            WHEN zustimmung_id = 6
                THEN ' / ' || TRIM(zustimmung_bez)
            ELSE ' '
        END) AS untervermietung_freitext
    FROM (
        SELECT
            mandant_id,
            CAST(buchungskreis_id AS STRING FORMAT '9999') AS buchungskreis_id,
            immo_objekt_bez,
            objekt_name,
            0 AS zustimmung_id,
            ' ' AS zustimmung_bez
        FROM dbp_data.ivs_immo_objekt_per_2 AS P
        WHERE
            dat_bis = PARSE_DATE('%F', '9999-12-31')
            AND objekt_name NOT LIKE '%UMGL%'
            AND objekt_name NOT LIKE '%PAOB%'
            AND (
                mandant_id, immo_objekt_id) NOT IN (
                SELECT (mandant_id, immo_objekt_id)
                FROM dbp_data.ivs_immo_objekt_per_2
                WHERE
                    dat_bis = PARSE_DATE('%F', '9999-12-31')
                    AND (
                        dat_umgl > CURRENT_DATE("Europe/Berlin") OR status_umgl = 'UMGL' AND dat_umgl IS NULL AND (mandant_id, ref_immo_objekt_id)
                        IN (
                            SELECT (mandant_id, ref_immo_objekt_id)
                            FROM dbp_data.ivs_immo_objekt_per_2
                            WHERE
                                dat_umgl <= CURRENT_DATE("Europe/Berlin")
                                AND dat_bis = PARSE_DATE('%F', '9999-12-31')
                        )
                    )
            )
        GROUP BY
            mandant_id,
            buchungskreis_id,
            immo_objekt_bez,
            objekt_name,
            zustimmung_id,
            zustimmung_bez
    ) AS t5
    GROUP BY
        mandant_id,
        wup_id
) AS u
WHERE wup_denorm_tmp.mandant_id = u.mandant_id AND wup_denorm_tmp.wup_id = u.wup_id;


CREATE OR REPLACE TABLE dbp_etl.vis_security_changes_2 (
    mandant_id INTEGER,
    wup_id INTEGER,
    gf_gbl_vertrieb_id_alt INTEGER,
    gl_vertrieb_id_alt INTEGER,
    vkl_id_alt INTEGER,
    hausleiter_id_alt INTEGER,
    frische_manager_id_alt INTEGER,
    gf_gbl_vertrieb_id_neu INTEGER,
    gl_vertrieb_id_neu INTEGER,
    vkl_id_neu INTEGER,
    hausleiter_id_neu INTEGER,
    frische_manager_id_neu INTEGER
);


INSERT INTO dbp_etl.vis_security_changes_2 (
    mandant_id, wup_id, gf_gbl_vertrieb_id_alt, gl_vertrieb_id_alt,
    vkl_id_alt, hausleiter_id_alt, frische_manager_id_alt, gf_gbl_vertrieb_id_neu, gl_vertrieb_id_neu, vkl_id_neu,
    hausleiter_id_neu, frische_manager_id_neu
)
(
    SELECT
        COALESCE(D.mandant_id, T.mandant_id) AS mandant_id,
        COALESCE(D.wup_id, T.wup_id) AS wup_id,
        D.gf_gbl_vertrieb_id AS gf_gbl_vertrieb_id_alt,
        D.gl_vertrieb_id AS gl_vertrieb_id_alt,
        D.vkl_id AS vkl_id_alt,
        D.hausleiter_id AS hausleiter_id_alt,
        D.frische_manager_id AS frische_manager_id_alt,
        T.gf_gbl_vertrieb_id AS gf_gbl_vertrieb_id_neu,
        T.gl_vertrieb_id AS gl_vertrieb_id_neu,
        T.vkl_id AS vkl_id_neu,
        T.hausleiter_id AS hausleiter_id_neu,
        T.frische_manager_id AS frische_manager_id_neu
    FROM dbp_msi_data.wup_denorm_2 AS D
    RIGHT JOIN dbp_etl.wup_denorm_tmp_2 AS T ON D.mandant_id = T.mandant_id AND D.wup_id = T.wup_id
    WHERE
        COALESCE(D.gf_gbl_vertrieb_id, -9999) <> COALESCE(T.gf_gbl_vertrieb_id, -9999)
        OR COALESCE(D.gl_vertrieb_id, -9999) <> COALESCE(T.gl_vertrieb_id, -9999)
        OR COALESCE(D.vkl_id, -9999) <> COALESCE(T.vkl_id, -9999)
        OR COALESCE(D.hausleiter_id, -9999) = -9999 AND COALESCE(T.hausleiter_id, -9999) <> -9999
        OR COALESCE(D.frische_manager_id, -9999) <> COALESCE(T.frische_manager_id, -9999)
);


CREATE OR REPLACE TABLE dbp_etl.vis_security_changes_1_2 (
    mandant_id INTEGER,
    wup_id INTEGER,
    gf_id_alt INTEGER,
    gf_anrede_alt STRING(40),
    gf_name_alt STRING(40),
    gf_vorname_alt STRING(40),
    gf_ldap_alt STRING(40),
    gl_id_alt INTEGER,
    gl_anrede_alt STRING(40),
    gl_name_alt STRING(40),
    gl_vorname_alt STRING(40),
    gl_ldap_alt STRING(40),
    vkl_id_alt INTEGER,
    vkl_anrede_alt STRING(40),
    vkl_name_alt STRING(40),
    vkl_vorname_alt STRING(40),
    vkl_ldap_alt STRING(40),
    hl_id_alt INTEGER,
    hl_anrede_alt STRING(40),
    hl_name_alt STRING(40),
    hl_vorname_alt STRING(40),
    hl_ldap_alt STRING(40),
    fm_id_alt INTEGER,
    fm_anrede_alt STRING(40),
    fm_name_alt STRING(40),
    fm_vorname_alt STRING(40),
    fm_ldap_alt STRING(40),
    gf_id_neu INTEGER,
    gf_anrede_neu STRING(40),
    gf_name_neu STRING(40),
    gf_vorname_neu STRING(40),
    gf_ldap_neu STRING(40),
    gl_id_neu INTEGER,
    gl_anrede_neu STRING(40),
    gl_name_neu STRING(40),
    gl_vorname_neu STRING(40),
    gl_ldap_neu STRING(40),
    vkl_id_neu INTEGER,
    vkl_anrede_neu STRING(40),
    vkl_name_neu STRING(40),
    vkl_vorname_neu STRING(40),
    vkl_ldap_neu STRING(40),
    hl_id_neu INTEGER,
    hl_anrede_neu STRING(40),
    hl_name_neu STRING(40),
    hl_vorname_neu STRING(40),
    hl_ldap_neu STRING(40),
    fm_id_neu INTEGER,
    fm_anrede_neu STRING(40),
    fm_name_neu STRING(40),
    fm_vorname_neu STRING(40),
    fm_ldap_neu STRING(40)
);


INSERT INTO dbp_etl.vis_security_changes_1_2 (
    mandant_id, wup_id, gf_id_alt, gf_anrede_alt, gf_name_alt,
    gf_vorname_alt, gf_ldap_alt, gl_id_alt, gl_anrede_alt, gl_name_alt, gl_vorname_alt, gl_ldap_alt, vkl_id_alt,
    vkl_anrede_alt, vkl_name_alt, vkl_vorname_alt, vkl_ldap_alt, hl_id_alt, hl_anrede_alt, hl_name_alt, hl_vorname_alt,
    hl_ldap_alt, fm_id_alt, fm_anrede_alt, fm_name_alt, fm_vorname_alt, fm_ldap_alt, gf_id_neu, gf_anrede_neu, gf_name_neu,
    gf_vorname_neu, gf_ldap_neu, gl_id_neu, gl_anrede_neu, gl_name_neu, gl_vorname_neu, gl_ldap_neu, vkl_id_neu,
    vkl_anrede_neu, vkl_name_neu, vkl_vorname_neu, vkl_ldap_neu, hl_id_neu, hl_anrede_neu, hl_name_neu, hl_vorname_neu,
    hl_ldap_neu, fm_id_neu, fm_anrede_neu, fm_name_neu, fm_vorname_neu, fm_ldap_neu
)
(
    SELECT
        COALESCE(D.mandant_id, T.mandant_id) AS mandant_id,
        COALESCE(D.wup_id, T.wup_id) AS wup_id,
        D.gf_gbl_vertrieb_id AS gf_id_alt,
        COALESCE(MA_SPR_ZU_GF_ALT.ma_anrede, '') AS gf_anrede_alt,
        COALESCE(MA_SPR_ZU_GF_ALT.ma_name, '') AS gf_name_alt,
        COALESCE(MA_SPR_ZU_GF_ALT.ma_vorname, '') AS gf_vorname_alt,
        COALESCE(MA_SPR_ZU_GF_ALT.ma_ldap, '') AS gf_ldap_alt,
        D.gl_vertrieb_id AS gl_id_alt,
        COALESCE(MA_SPR_ZU_GL_ALT.ma_anrede, '') AS gl_anrede_alt,
        COALESCE(MA_SPR_ZU_GL_ALT.ma_name, '') AS gl_name_alt,
        COALESCE(MA_SPR_ZU_GL_ALT.ma_vorname, '') AS gl_vorname_alt,
        COALESCE(MA_SPR_ZU_GL_ALT.ma_ldap, '') AS gl_ldap_alt,
        D.vkl_id AS vkl_id_alt,
        COALESCE(MA_SPR_ZU_VKL_ALT.ma_anrede, '') AS vkl_anrede_alt,
        COALESCE(MA_SPR_ZU_VKL_ALT.ma_name, '') AS vkl_name_alt,
        COALESCE(MA_SPR_ZU_VKL_ALT.ma_vorname, '') AS vkl_vorname_alt,
        COALESCE(MA_SPR_ZU_VKL_ALT.ma_ldap, '') AS vkl_ldap_alt,
        D.hausleiter_id AS hl_id_alt,
        COALESCE(MA_SPR_ZU_HL_ALT.ma_anrede, '') AS hl_anrede_alt,
        COALESCE(MA_SPR_ZU_HL_ALT.ma_name, '') AS hl_name_alt,
        COALESCE(MA_SPR_ZU_HL_ALT.ma_vorname, '') AS hl_vorname_alt,
        COALESCE(MA_SPR_ZU_HL_ALT.ma_ldap, '') AS hl_ldap_alt,
        D.frische_manager_id AS fm_id_alt,
        COALESCE(MA_SPR_ZU_FM_ALT.ma_anrede, '') AS fm_anrede_alt,
        COALESCE(MA_SPR_ZU_FM_ALT.ma_name, '') AS fm_name_alt,
        COALESCE(MA_SPR_ZU_FM_ALT.ma_vorname, '') AS fm_vorname_alt,
        COALESCE(MA_SPR_ZU_FM_ALT.ma_ldap, '') AS fm_ldap_alt,
        T.gf_gbl_vertrieb_id AS gf_id_neu,
        COALESCE(MA_SPR_ZU_GF_NEU.ma_anrede, '') AS gf_anrede_neu,
        COALESCE(MA_SPR_ZU_GF_NEU.ma_name, '') AS gf_name_neu,
        COALESCE(MA_SPR_ZU_GF_NEU.ma_vorname, '') AS gf_vorname_neu,
        COALESCE(MA_SPR_ZU_GF_NEU.ma_ldap, '') AS gf_ldap_neu,
        T.gl_vertrieb_id AS gl_id_neu,
        COALESCE(MA_SPR_ZU_GL_NEU.ma_anrede, '') AS gl_anrede_neu,
        COALESCE(MA_SPR_ZU_GL_NEU.ma_name, '') AS gl_name_neu,
        COALESCE(MA_SPR_ZU_GL_NEU.ma_vorname, '') AS gl_vorname_neu,
        COALESCE(MA_SPR_ZU_GL_NEU.ma_ldap, '') AS gl_ldap_neu,
        T.vkl_id AS vkl_id_neu,
        COALESCE(MA_SPR_ZU_VKL_NEU.ma_anrede, '') AS vkl_anrede_neu,
        COALESCE(MA_SPR_ZU_VKL_NEU.ma_name, '') AS vkl_name_neu,
        COALESCE(MA_SPR_ZU_VKL_NEU.ma_vorname, '') AS vkl_vorname_neu,
        COALESCE(MA_SPR_ZU_VKL_NEU.ma_ldap, '') AS vkl_ldap_neu,
        T.hausleiter_id AS hl_id_neu,
        COALESCE(MA_SPR_ZU_HL_NEU.ma_anrede, '') AS hl_anrede_neu,
        COALESCE(MA_SPR_ZU_HL_NEU.ma_name, '') AS hl_name_neu,
        COALESCE(MA_SPR_ZU_HL_NEU.ma_vorname, '') AS hl_vorname_neu,
        COALESCE(MA_SPR_ZU_HL_NEU.ma_ldap, '') AS hl_ldap_neu,
        D.frische_manager_id AS fm_id_neu,
        COALESCE(MA_SPR_ZU_FM_NEU.ma_anrede, '') AS fm_anrede_neu,
        COALESCE(MA_SPR_ZU_FM_NEU.ma_name, '') AS fm_name_neu,
        COALESCE(MA_SPR_ZU_FM_NEU.ma_vorname, '') AS fm_vorname_neu,
        COALESCE(MA_SPR_ZU_FM_NEU.ma_ldap, '') AS fm_ldap_neu
    FROM dbp_msi_data.wup_denorm_2 AS D
    RIGHT JOIN dbp_etl.wup_denorm_tmp_2 AS T ON D.mandant_id = T.mandant_id AND D.wup_id = T.wup_id
    LEFT JOIN dbp_etl_process.ma_spr_zu_save_2 AS MA_SPR_ZU_GF_ALT
        ON D.gf_gbl_vertrieb_id = COALESCE(
            MA_SPR_ZU_GF_ALT.ma_id, -1
        ) AND COALESCE(D.mandant_id, T.mandant_id
        ) = MA_SPR_ZU_GF_ALT.mandant_id AND MA_SPR_ZU_GF_ALT.spr_id =
        22
    LEFT JOIN dbp_etl_process.ma_spr_zu_save_2 AS MA_SPR_ZU_GL_ALT
        ON D.gl_vertrieb_id = COALESCE(
            MA_SPR_ZU_GL_ALT.ma_id, -1
        ) AND COALESCE(D.mandant_id, T.mandant_id
        ) = MA_SPR_ZU_GL_ALT.mandant_id AND MA_SPR_ZU_GL_ALT.spr_id =
        22
    LEFT JOIN dbp_etl_process.ma_spr_zu_save_2 AS MA_SPR_ZU_VKL_ALT
        ON D.vkl_id = COALESCE(
            MA_SPR_ZU_VKL_ALT.ma_id, -1
        ) AND COALESCE(D.mandant_id, T.mandant_id
        ) = MA_SPR_ZU_VKL_ALT.mandant_id AND MA_SPR_ZU_VKL_ALT.spr_id =
        22
    LEFT JOIN dbp_etl_process.ma_spr_zu_save_2 AS MA_SPR_ZU_HL_ALT
        ON D.hausleiter_id = COALESCE(
            MA_SPR_ZU_HL_ALT.ma_id, -1
        ) AND COALESCE(D.mandant_id, T.mandant_id
        ) = MA_SPR_ZU_HL_ALT.mandant_id AND MA_SPR_ZU_HL_ALT.spr_id =
        22
    LEFT JOIN dbp_etl_process.ma_spr_zu_save_2 AS MA_SPR_ZU_FM_ALT
        ON D.frische_manager_id = COALESCE(
            MA_SPR_ZU_FM_ALT.ma_id, -1
        ) AND COALESCE(D.mandant_id, T.mandant_id
        ) = MA_SPR_ZU_FM_ALT.mandant_id AND MA_SPR_ZU_FM_ALT.spr_id =
        22
    LEFT JOIN dbp_data.ma_spr_zu_2 AS MA_SPR_ZU_GF_NEU
        ON T.gf_gbl_vertrieb_id = COALESCE(
            MA_SPR_ZU_GF_NEU.ma_id,
            -1
        ) AND COALESCE(D.mandant_id, T.mandant_id
        ) = MA_SPR_ZU_GF_NEU.mandant_id AND MA_SPR_ZU_GF_NEU.spr_id = 22
    LEFT JOIN dbp_data.ma_spr_zu_2 AS MA_SPR_ZU_GL_NEU
        ON T.gl_vertrieb_id = COALESCE(
            MA_SPR_ZU_GL_NEU.ma_id,
            -1
        ) AND COALESCE(D.mandant_id, T.mandant_id
        ) = MA_SPR_ZU_GL_NEU.mandant_id AND MA_SPR_ZU_GL_NEU.spr_id = 22
    LEFT JOIN dbp_data.ma_spr_zu_2 AS MA_SPR_ZU_VKL_NEU
        ON
            T.vkl_id = COALESCE(MA_SPR_ZU_VKL_NEU.ma_id, -1)
            AND COALESCE(D.mandant_id, T.mandant_id) = MA_SPR_ZU_VKL_NEU.mandant_id AND MA_SPR_ZU_VKL_NEU.spr_id = 22
    LEFT JOIN dbp_data.ma_spr_zu_2 AS MA_SPR_ZU_HL_NEU
        ON T.hausleiter_id = COALESCE(
            MA_SPR_ZU_HL_NEU.ma_id,
            -1
        ) AND COALESCE(D.mandant_id, T.mandant_id
        ) = MA_SPR_ZU_HL_NEU.mandant_id AND MA_SPR_ZU_HL_NEU.spr_id = 22
    LEFT JOIN dbp_data.ma_spr_zu_2 AS MA_SPR_ZU_FM_NEU
        ON T.frische_manager_id = COALESCE(
            MA_SPR_ZU_FM_NEU.ma_id,
            -1
        ) AND COALESCE(D.mandant_id, T.mandant_id
        ) = MA_SPR_ZU_FM_NEU.mandant_id AND MA_SPR_ZU_FM_NEU.spr_id = 22
    WHERE
        COALESCE(D.gf_gbl_vertrieb_id, -9999) <> COALESCE(T.gf_gbl_vertrieb_id, -9999)
        OR COALESCE(MA_SPR_ZU_GF_ALT.ma_anrede, '') <> COALESCE(MA_SPR_ZU_GF_NEU.ma_anrede, '')
        OR COALESCE(MA_SPR_ZU_GF_ALT.ma_name, '') <> COALESCE(MA_SPR_ZU_GF_NEU.ma_name, '')
        OR COALESCE(MA_SPR_ZU_GF_ALT.ma_vorname, '') <> COALESCE(MA_SPR_ZU_GF_NEU.ma_vorname, '')
        OR COALESCE(MA_SPR_ZU_GF_ALT.ma_ldap, '') <> COALESCE(MA_SPR_ZU_GF_NEU.ma_ldap, '')
        OR COALESCE(D.gl_vertrieb_id, -9999) <> COALESCE(T.gl_vertrieb_id, -9999)
        OR COALESCE(MA_SPR_ZU_GL_ALT.ma_anrede, '') <> COALESCE(MA_SPR_ZU_GL_NEU.ma_anrede, '')
        OR COALESCE(MA_SPR_ZU_GL_ALT.ma_name, '') <> COALESCE(MA_SPR_ZU_GL_NEU.ma_name, '')
        OR COALESCE(MA_SPR_ZU_GL_ALT.ma_vorname, '') <> COALESCE(MA_SPR_ZU_GL_NEU.ma_vorname, '')
        OR COALESCE(MA_SPR_ZU_GL_ALT.ma_ldap, '') <> COALESCE(MA_SPR_ZU_GL_NEU.ma_ldap, '')
        OR COALESCE(D.vkl_id, -9999) <> COALESCE(T.vkl_id, -9999)
        OR COALESCE(MA_SPR_ZU_VKL_ALT.ma_anrede, '') <> COALESCE(MA_SPR_ZU_VKL_NEU.ma_anrede, '')
        OR COALESCE(MA_SPR_ZU_VKL_ALT.ma_name, '') <> COALESCE(MA_SPR_ZU_VKL_NEU.ma_name, '')
        OR COALESCE(MA_SPR_ZU_VKL_ALT.ma_vorname, '') <> COALESCE(MA_SPR_ZU_VKL_NEU.ma_vorname, '')
        OR COALESCE(MA_SPR_ZU_VKL_ALT.ma_ldap, '') <> COALESCE(MA_SPR_ZU_VKL_NEU.ma_ldap, '')
        OR COALESCE(D.hausleiter_id, -9999) = -9999 AND COALESCE(T.hausleiter_id, -9999) <> -9999
        OR COALESCE(MA_SPR_ZU_HL_ALT.ma_anrede, '') <> COALESCE(MA_SPR_ZU_HL_NEU.ma_anrede, '')
        OR COALESCE(MA_SPR_ZU_HL_ALT.ma_name, '') <> COALESCE(MA_SPR_ZU_HL_NEU.ma_name, '')
        OR COALESCE(MA_SPR_ZU_HL_ALT.ma_vorname, '') <> COALESCE(MA_SPR_ZU_HL_NEU.ma_vorname, '')
        OR COALESCE(MA_SPR_ZU_HL_ALT.ma_ldap, '') <> COALESCE(MA_SPR_ZU_HL_NEU.ma_ldap, '')
        OR COALESCE(D.frische_manager_id, -9999) <> COALESCE(T.frische_manager_id, -9999)
        OR COALESCE(MA_SPR_ZU_FM_ALT.ma_anrede, '') <> COALESCE(MA_SPR_ZU_FM_NEU.ma_anrede, '')
        OR COALESCE(MA_SPR_ZU_FM_ALT.ma_name, '') <> COALESCE(MA_SPR_ZU_FM_NEU.ma_name, '')
        OR COALESCE(MA_SPR_ZU_FM_ALT.ma_vorname, '') <> COALESCE(MA_SPR_ZU_FM_NEU.ma_vorname, '')
        OR COALESCE(MA_SPR_ZU_FM_ALT.ma_ldap, '') <> COALESCE(MA_SPR_ZU_FM_NEU.ma_ldap, '')
);


SELECT
    mandant_id,
    wup_id,
    hierarchie_stufe,
    CAST(ma_id_alt AS STRING) AS ma_id_alt,
    CAST(TRIM(anrede_alt) AS STRING) AS anrede_alt,
    CAST(TRIM(vorname_alt) AS STRING) AS vorname_alt,
    CAST(TRIM(name_alt) AS STRING) AS name_alt,
    CAST(TRIM(ldap_alt) AS STRING) AS ldap_alt,
    CAST(ma_id_neu AS STRING) AS ma_id_neu,
    CAST(TRIM(anrede_neu) AS STRING) AS anrede_neu,
    CAST(TRIM(vorname_neu) AS STRING) AS vorname_neu,
    CAST(TRIM(name_neu) AS STRING) AS name_neu,
    CAST(TRIM(ldap_neu) AS STRING) AS ldap_neu
FROM ((
    SELECT
        mandant_id,
        wup_id,
        'GF_2 ' AS hierarchie_stufe,
        1 AS hierarchie_stufe_id,
        gf_id_alt AS ma_id_alt,
        gf_anrede_alt AS anrede_alt,
        gf_name_alt AS name_alt,
        gf_vorname_alt AS vorname_alt,
        gf_ldap_alt AS ldap_alt,
        gf_id_neu AS ma_id_neu,
        gf_anrede_neu AS anrede_neu,
        gf_name_neu AS name_neu,
        gf_vorname_neu AS vorname_neu,
        gf_ldap_neu AS ldap_neu
    FROM dbp_etl.vis_security_changes_1_2
    WHERE
        COALESCE(gf_id_alt, -9999) <> COALESCE(gf_id_neu, -9999)
        OR gf_vorname_alt <> gf_vorname_neu
        OR gf_ldap_alt <> gf_ldap_neu
    UNION DISTINCT
    SELECT
        mandant_id,
        wup_id,
        'GL' AS hierarchie_stufe,
        2 AS hierarchie_stufe_id,
        gl_id_alt AS ma_id_alt,
        gl_anrede_alt AS anrede_alt,
        gl_name_alt AS name_alt,
        gl_vorname_alt AS vorname_alt,
        gl_ldap_alt AS ldap_alt,
        gl_id_neu AS ma_id_neu,
        gl_anrede_neu AS anrede_neu,
        gl_name_neu AS name_neu,
        gl_vorname_neu AS vorname_neu,
        gl_ldap_neu AS ldap_neu
    FROM dbp_etl.vis_security_changes_1_2
    WHERE
        COALESCE(gl_id_alt, -9999) <> COALESCE(gl_id_neu, -9999)
        OR gl_vorname_alt <> gl_vorname_neu
        OR gl_ldap_alt <> gl_ldap_neu
)
UNION DISTINCT
SELECT
    mandant_id,
    wup_id,
    'VKL_2' AS hierarchie_stufe,
    3 AS hierarchie_stufe_id,
    vkl_id_alt AS ma_id_alt,
    vkl_anrede_alt AS anrede_alt,
    vkl_name_alt AS name_alt,
    vkl_vorname_alt AS vorname_alt,
    vkl_ldap_alt AS ldap_alt,
    vkl_id_neu AS ma_id_neu,
    vkl_anrede_neu AS anrede_neu,
    vkl_name_neu AS name_neu,
    vkl_vorname_neu AS vorname_neu,
    vkl_ldap_neu AS ldap_neu
FROM dbp_etl.vis_security_changes_1_2
WHERE
    COALESCE(vkl_id_alt, -9999) <> COALESCE(vkl_id_neu, -9999)
    OR vkl_vorname_alt <> vkl_vorname_neu
    OR vkl_ldap_alt <> vkl_ldap_neu
) AS a
WHERE
    COALESCE(anrede_alt, '') <> ''
    OR COALESCE(vorname_alt, '') <> ''
    OR COALESCE(name_alt, '') <> ''
    OR COALESCE(TRIM(ldap_alt), '') <> ''
    OR COALESCE(anrede_neu, '') <> ''
    OR COALESCE(vorname_neu, '') <> ''
    OR COALESCE(name_neu, '') <> ''
    OR COALESCE(TRIM(ldap_neu), '') <> ''
GROUP BY
    mandant_id,
    wup_id,
    hierarchie_stufe,
    ma_id_alt,
    anrede_alt,
    vorname_alt,
    name_alt,
    ldap_alt,
    ma_id_neu,
    anrede_neu,
    vorname_neu,
    name_neu,
    ldap_neu;


TRUNCATE TABLE dbp_msi_data.wup_denorm_2;


INSERT INTO dbp_msi_data.wup_denorm_2 (
    mandant_id, wup_id, bed_fleisch_fg, bed_fleisch_dat, bed_wurst_fg,
    bed_wurst_dat, bed_gefl_fg, bed_gefl_dat, bed_kaese_fg, bed_kaese_dat, bed_fisch_id, bed_fisch_dat, bed_feink_fg,
    bed_feink_dat, bed_bulk_fg, bed_bulk_dat, bed_bedins_fg, bed_bedins_dat, bed_imbiss_fg, bed_imbiss_dat, bed_backshop_fg,
    bed_backshop_dat, backshop_system, leergut_system, anz_leergutautomaten, glv_land_id, stv_glv_land_id, gl_vertrieb_id,
    gf_gbl_vertrieb_id, vkl_id, hausleiter_id, wbl_food_id, wbl_frische_id, wbl_nonfood_id, wbl_kasse_id,
    frische_manager_id, regionale_psb_id, tankstelle_vorh_fg, tankstelle_eigen_fg, ma_vermietung_id, eigentum_fg,
    dat_letzte_reorga, parkhaus_kz, getraenkemarkt_kz, anz_aufzuege, anz_rollsteige, anz_aufzuege_intern,
    anz_rollsteige_intern, untervermietung_kz, untervermietung_text, untervermietung_freitext, hausleiter_sperr_fg,
    vkl_sperr_fg, gf_gbl_vertrieb_sperr_fg
)
(SELECT
    mandant_id,
    wup_id,
    bed_fleisch_fg,
    bed_fleisch_dat,
    bed_wurst_fg,
    bed_wurst_dat,
    bed_gefl_fg,
    bed_gefl_dat,
    bed_kaese_fg,
    bed_kaese_dat,
    bed_fisch_id,
    bed_fisch_dat,
    bed_feink_fg,
    bed_feink_dat,
    bed_bulk_fg,
    bed_bulk_dat,
    bed_bedins_fg,
    bed_bedins_dat,
    bed_imbiss_fg,
    bed_imbiss_dat,
    bed_backshop_fg,
    bed_backshop_dat,
    backshop_system,
    leergut_system,
    anz_leergutautomaten,
    glv_land_id,
    stv_glv_land_id,
    gl_vertrieb_id,
    gf_gbl_vertrieb_id,
    vkl_id,
    hausleiter_id,
    wbl_food_id,
    wbl_frische_id,
    wbl_nonfood_id,
    wbl_kasse_id,
    frische_manager_id,
    regionale_psb_id,
    tankstelle_vorh_fg,
    tankstelle_eigen_fg,
    ma_vermietung_id,
    eigentum_fg,
    dat_letzte_reorga,
    parkhaus_kz,
    getraenkemarkt_kz,
    anz_aufzuege,
    anz_rollsteige,
    anz_aufzuege_intern,
    anz_rollsteige_intern,
    untervermietung_kz,
    untervermietung_text,
    untervermietung_freitext,
    hausleiter_sperr_fg,
    vkl_sperr_fg,
    gf_gbl_vertrieb_sperr_fg
FROM dbp_etl.wup_denorm_tmp_2);


UPDATE dbp_data.wup_2 SET
    vkl_id = WD.vkl_id,
    hl_id = WD.hausleiter_id,
    wm_id = WD.frische_manager_id,
    gf_id = WD.gf_gbl_vertrieb_id,
    td_update = CURRENT_TIMESTAMP()
FROM dbp_msi_data.wup_denorm_2 AS WD
WHERE
    wup.mandant_id = WD.mandant_id AND (wup.wup_id = WD.wup_id OR wup.nb_id IN (2, 7) AND wup.haupt_wup_id = WD.wup_id
    );


UPDATE dbp_data.wup_2 SET
    vkl_id = CASE
        WHEN COALESCE(wup.vkl_id, -1) IN (-1, 0)
            THEN (1000 + wup.mandant_id * 100 + wup.vs_id * 10) * -1
        ELSE wup.vkl_id
    END,
    hl_id = CASE
        WHEN COALESCE(wup.hl_id, -1) IN (-1, 0)
            THEN (1000 + wup.mandant_id * 100 + wup.vs_id * 10) * -1
        ELSE wup.hl_id
    END,
    gf_id = CASE
        WHEN COALESCE(wup.gf_id, -1) IN (-1, 0)
            THEN (1000 + wup.mandant_id * 100 + wup.vs_id * 10) * -1
        ELSE wup.gf_id
    END,
    td_update = CURRENT_TIMESTAMP()
WHERE nb_id IN (-2, -1) AND dat_eroeffnung > DATE '1900-01-01' AND wup_id <> -1;


TRUNCATE TABLE dbp_data.wm_2;


INSERT INTO dbp_data.wm_2 (wm_id, mandant_id, wm_name, td_insert)
(
    SELECT
        w.wm_id,
        w.mandant_id,
        CASE
            WHEN w.mandant_id <> 8
                THEN TRIM(MA1.ma_anrede) || ' ' || TRIM(MA1.ma_vorname) || ' ' || TRIM(MA1.ma_name)
            ELSE TRIM(MA2.ma_anrede) || ' ' || TRIM(MA2.ma_vorname) || ' ' || TRIM(MA2.ma_name)
        END,
        CURRENT_TIMESTAMP()
    FROM (
        SELECT
            mandant_id,
            wm_id
        FROM dbp_data.wup_2
        GROUP BY
            mandant_id,
            wm_id
    ) AS w
    INNER JOIN dbp_data.l_ma_2 AS L ON w.wm_id = L.ma_id AND w.mandant_id = L.mandant_id
    INNER JOIN dbp_data.ma_spr_zu_2 AS MA1 ON w.wm_id = MA1.ma_id AND MA1.spr_id = 22
    INNER JOIN dbp_data.mandant_spr_zu_2 AS MSZ ON w.mandant_id = MSZ.mandant_id
    LEFT JOIN dbp_data.ma_spr_zu_2 AS MA2 ON w.wm_id = MA2.ma_id AND MSZ.spr_id = MA2.spr_id
);


TRUNCATE TABLE dbp_data.vkl_2;


INSERT INTO dbp_data.vkl_2 (vkl_id, mandant_id, gf_id, vkl_name, td_insert)
(
    SELECT
        w.vkl_id,
        w.mandant_id,
        w.gf_gbl_vertrieb_id,
        CASE
            WHEN w.mandant_id <> 8
                THEN TRIM(MA1.ma_anrede) || ' ' || TRIM(MA1.ma_vorname) || ' ' || TRIM(MA1.ma_name)
            ELSE TRIM(MA2.ma_anrede) || ' ' || TRIM(MA2.ma_vorname) || ' ' || TRIM(MA2.ma_name)
        END,
        CURRENT_TIMESTAMP()
    FROM (SELECT
        mandant_id,
        vkl_id,
        gf_gbl_vertrieb_id
    FROM (SELECT
        mandant_id,
        vkl_id,
        gf_gbl_vertrieb_id,
        COUNT(*) AS anzahl
    FROM dbp_msi_data.wup_denorm_2
    GROUP BY
        mandant_id,
        gf_gbl_vertrieb_id,
        vkl_id
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, vkl_id ORDER BY anzahl IS NULL DESC, anzahl DESC)) = 1) AS t1_2

    UNION DISTINCT
    SELECT
        mandant_id,
        (1000 + mandant_id * 100 + vs_id * 10) * -1 AS vkl_id,
        (1000 + mandant_id * 100 + vs_id * 10) * -1 AS gf_id
    FROM dbp_data.vs_2) AS w
    INNER JOIN dbp_data.ma_spr_zu_2 AS MA1 ON w.vkl_id = MA1.ma_id AND MA1.spr_id = 22
    INNER JOIN dbp_data.mandant_spr_zu_2 AS MSZ ON w.mandant_id = MSZ.mandant_id
    LEFT JOIN dbp_data.ma_spr_zu_2 AS MA2 ON w.vkl_id = MA2.ma_id AND MSZ.spr_id = MA2.spr_id
);


TRUNCATE TABLE dbp_data.hl_2;


INSERT INTO dbp_data.hl_2 (hl_id, mandant_id, hl_name, td_insert)
(
    SELECT
        w.hl_id,
        w.mandant_id,
        CASE
            WHEN w.mandant_id <> 8
                THEN TRIM(MA1.ma_anrede) || ' ' || TRIM(MA1.ma_vorname) || ' ' || TRIM(MA1.ma_name)
            ELSE TRIM(MA2.ma_anrede) || ' ' || TRIM(MA2.ma_vorname) || ' ' || TRIM(MA2.ma_name)
        END,
        CURRENT_TIMESTAMP()
    FROM (
        SELECT
            mandant_id,
            hl_id
        FROM dbp_data.wup_2
        GROUP BY
            mandant_id,
            hl_id
    ) AS w
    INNER JOIN dbp_data.ma_spr_zu_2 AS MA1 ON w.hl_id = MA1.ma_id AND MA1.spr_id = 22
    INNER JOIN dbp_data.mandant_spr_zu_2 AS MSZ ON w.mandant_id = MSZ.mandant_id
    LEFT JOIN dbp_data.ma_spr_zu_2 AS MA2 ON w.hl_id = MA2.ma_id AND MSZ.spr_id = MA2.spr_id
);


DELETE FROM dbp_data.gf_2
WHERE ek_fg = 0;


INSERT INTO dbp_data.gf_2 (gf_id, mandant_id, ek_fg, gf_name, td_insert)
(
    SELECT DISTINCT
        t0.gf_id,
        t0.mandant_id,
        0 AS ek_fg,
        CASE
            WHEN t0.mandant_id <> 8
                THEN TRIM(MA1.ma_anrede) || ' ' || TRIM(MA1.ma_vorname) || ' ' || TRIM(MA1.ma_name)
            ELSE TRIM(MA2.ma_anrede) || ' ' || TRIM(MA2.ma_vorname) || ' ' || TRIM(MA2.ma_name)
        END,
        CURRENT_TIMESTAMP()
    FROM (
        SELECT
            gf_id,
            mandant_id
        FROM dbp_data.vkl_2
        GROUP BY
            mandant_id,
            gf_id
    ) AS t0
    INNER JOIN dbp_data.ma_spr_zu_2 AS MA1 ON t0.gf_id = MA1.ma_id AND MA1.spr_id = 22
    INNER JOIN dbp_data.mandant_spr_zu_2 AS MSZ ON t0.mandant_id = MSZ.mandant_id
    LEFT JOIN dbp_data.ma_spr_zu_2 AS MA2 ON t0.gf_id = MA2.ma_id AND MSZ.spr_id = MA2.spr_id
);


UPDATE dbp_data.wup_2 AS ZIEL SET
    verkaufsflaeche = CAST(quelle.fl_vk AS NUMERIC),
    betriebsflaeche = CAST(quelle.fl_betr AS NUMERIC),
    uebernahme_von = quelle.uebernahme_von,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        V02.mandant_id,
        V02.wup_id,
        v03.fl_vk,
        v03.fl_betr,
        COALESCE(SUBSTR(v04.uebernahme_von, 1, 20), '') AS uebernahme_von
    FROM dbp_data.techn_platz_per_2 AS V02
    INNER JOIN (
        SELECT
            mandant_id,
            techn_platz_id,
            SUM(CASE
                WHEN ginfo_flaeche_typ_id IN ('VKF') AND ginfo_flaeche_id IN ('02.01', '02.10', '02.08', '02.18', '02.02')
                    THEN ginfo_flaeche_brutto
                ELSE 0
            END) AS fl_vk,
            SUM(CASE
                WHEN
                    ginfo_flaeche_typ_id IN ('VKF') AND ginfo_flaeche_id IN ('02.01', '02.10', '02.08', '02.18', '02.02') OR
                    ginfo_flaeche_typ_id IN ('SNF', 'TF', 'VF_2', 'KOF', 'KOF-E')
                    THEN ginfo_flaeche_brutto
                ELSE 0
            END) AS fl_betr
        FROM dbp_data.ginfo_flaeche_per_2 AS S01
        WHERE CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        GROUP BY
            mandant_id,
            techn_platz_id
    ) AS v03 ON V02.techn_platz_id = v03.techn_platz_id
    LEFT JOIN (SELECT
        mandant_id,
        techn_platz_id,
        uebernahme_von
    FROM dbp_data.techn_platz_ebene_2_per_2 AS S01
    WHERE dat_bis = PARSE_DATE('%F', '9999-12-31')) AS v04 ON V02.techn_platz_id = v04.techn_platz_id
    WHERE
        V02.techn_platz_ebene_id = 2
        AND V02.dat_bis = PARSE_DATE('%F', '9999-12-31')
) AS quelle
WHERE ZIEL.mandant_id = quelle.mandant_id AND ZIEL.wup_id = quelle.wup_id AND (
    COALESCE(ZIEL.verkaufsflaeche, 0) <>
    COALESCE(
        quelle.fl_vk, 0) OR COALESCE(ZIEL.betriebsflaeche, 0) <> COALESCE(quelle.fl_betr, 0) OR COALESCE(
        ZIEL.uebernahme_von,
        ''
    ) <> quelle.uebernahme_von
);


INSERT INTO dbp_msi_data.user_vis_benchmark_zu_2 (
    user_id, mandant_id, hierarchie_element_id,
    hierarchie_ebene_id, td_insert, td_update
)
(
    SELECT
        TRIM(M.land_id) || TRIM(SUBSTR(CAST(W.wup_id AS STRING), 1, 10)) || 'HL_2' AS user_id,
        W.mandant_id,
        W.wup_id AS hierarchie_element_id,
        'hl_2' AS hierarchie_ebene_id,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.wup_2 AS W
    INNER JOIN dbp_etl_process.land_mandant_zu_2 AS M ON W.mandant_id = M.mandant_id
    WHERE
        W.dat_bis > CURRENT_DATE("Europe/Berlin")
        AND W.nb_id = 0
        AND (
            W.wup_id, W.mandant_id) NOT IN (
            SELECT (hierarchie_element_id, mandant_id)
            FROM dbp_msi_data.user_vis_benchmark_zu_2
            WHERE hierarchie_ebene_id = 'hl_2'
        )
);


TRUNCATE TABLE dbp_msi_data.user_wup_zu_2;


INSERT INTO dbp_msi_data.user_wup_zu_2 (user_id, mandant_id, wup_id, td_insert, td_update)
(
    SELECT
        v.user_id,
        v.mandant_id,
        v.wup_id,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM ((((((
        SELECT
            HL_BM.user_id,
            HL_BM.mandant_id,
            W.wup_id
        FROM dbp_msi_data.user_vis_benchmark_zu_2 AS HL_BM
        INNER JOIN dbp_data.wup_2 AS W
            ON
                LOWER(HL_BM.hierarchie_ebene_id) = 'hl_2' AND HL_BM.hierarchie_element_id
                = W.wup_id AND HL_BM.mandant_id = W.mandant_id
        UNION DISTINCT
        SELECT
            VKL_BM.user_id,
            VKL_BM.mandant_id,
            W.wup_id
        FROM dbp_msi_data.user_vis_benchmark_zu_2 AS VKL_BM
        INNER JOIN
            dbp_msi_data.wup_denorm_2
                AS W
            ON
                LOWER(VKL_BM.hierarchie_ebene_id) = 'vkl_2' AND VKL_BM.hierarchie_element_id = W.vkl_id AND VKL_BM.mandant_id = W.mandant_id
    )
    UNION DISTINCT
    SELECT
        VS_BM.user_id,
        VS_BM.mandant_id,
        W.wup_id
    FROM dbp_msi_data.user_vis_benchmark_zu_2 AS VS_BM
    INNER JOIN
        dbp_data.wup_2
            AS W
        ON
                LOWER(VS_BM.hierarchie_ebene_id) = 'vs_2' AND VS_BM.hierarchie_element_id
                = W.vs_id AND VS_BM.mandant_id = W.mandant_id
    )
    UNION DISTINCT
    SELECT
        GF_BM.user_id,
        GF_BM.mandant_id,
        W.wup_id
    FROM dbp_msi_data.user_vis_benchmark_zu_2 AS GF_BM
    INNER JOIN
        dbp_msi_data.wup_denorm_2
            AS W
        ON
                LOWER(GF_BM.hierarchie_ebene_id) = 'gf_2' AND GF_BM.hierarchie_element_id
                = W.gf_gbl_vertrieb_id AND GF_BM.mandant_id = W.mandant_id
    )
    UNION DISTINCT
    SELECT
        VST_BM.user_id,
        VST_BM.mandant_id,
        W.wup_id
    FROM dbp_msi_data.user_vis_benchmark_zu_2 AS VST_BM
    INNER JOIN
        dbp_data.wup_2
            AS W
        ON
                LOWER(VST_BM.hierarchie_ebene_id) = 'land_2' AND VST_BM.hierarchie_element_id
                = W.mandant_id
    )
    UNION DISTINCT
    SELECT
        VST_BM.user_id,
        W.mandant_id,
        W.wup_id
    FROM dbp_msi_data.user_vis_benchmark_zu_2 AS VST_BM
    INNER JOIN dbp_data.wup_2 AS W ON TRUE
        WHERE
            VST_BM.hierarchie_element_id = -1
            AND LOWER(VST_BM.hierarchie_ebene_id) = 'land_2'
    )
    UNION DISTINCT
    SELECT
        VST_BM.user_id,
        W.mandant_id,
        W.wup_id
    FROM dbp_msi_data.user_vis_benchmark_zu_2 AS VST_BM
    INNER JOIN dbp_data.wup_2 AS W ON TRUE
        WHERE
            W.mandant_id <> 1
            AND VST_BM.hierarchie_element_id = -2
            AND LOWER(VST_BM.hierarchie_ebene_id) = 'land_2'
    ) AS v
    INNER JOIN dbp_data.wup_2 AS W0 ON v.mandant_id = W0.mandant_id AND v.wup_id = W0.wup_id
    WHERE
        W0.dat_eroeffnung IS NOT NULL
        AND DATE(CAST(EXTRACT(YEAR FROM CURRENT_DATE("Europe/Berlin")) - CASE
            WHEN EXTRACT(MONTH FROM CURRENT_DATE("Europe/Berlin")) IN (1, 2, 3)
                THEN 3
            ELSE 2
        END AS STRING) || '-03-01') <= W0.dat_bis
        AND W0.nb_id IN (0, -1)
    GROUP BY
        v.user_id,
        v.mandant_id,
        v.wup_id
);


TRUNCATE TABLE dbp_etl_process.ma_spr_zu_save_2;


INSERT INTO dbp_etl_process.ma_spr_zu_save_2 (
    mandant_id, ma_id, spr_id, ma_anrede, ma_name, ma_vorname,
    email, mobil_tel, ma_ldap, td_update, td_insert
)
(SELECT
    mandant_id,
    ma_id,
    spr_id,
    ma_anrede,
    ma_name,
    ma_vorname,
    email,
    mobil_tel,
    ma_ldap,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
FROM dbp_data.ma_spr_zu_2);


UPDATE dbp_msi_data.wup_denorm_2 SET
    haeufigste_ultra_frische_listungsstufe_kz = b.haeufigste_ultra_frische_listungsstufe_kz,
    haeufigste_mopro_listungsstufe_kz = b.haeufigste_mopro_listungsstufe_kz,
    haeufigste_tiko_listungsstufe_kz = b.haeufigste_tiko_listungsstufe_kz,
    haeufigste_trocken_listungsstufe_kz = b.haeufigste_trocken_listungsstufe_kz,
    haeufigste_nonfood_listungsstufe_kz = b.haeufigste_nonfood_listungsstufe_kz FROM
    dbp_etl_process.wup_denorm_k_stufe_2
        AS b
WHERE wup_denorm.mandant_id = b.mandant_id AND wup_denorm.wup_id = b.wup_id;


UPDATE dbp_data.wup_2 SET
    verkaufsflaeche = 3159.39
WHERE mandant_id = 5 AND wup_id = 6520;

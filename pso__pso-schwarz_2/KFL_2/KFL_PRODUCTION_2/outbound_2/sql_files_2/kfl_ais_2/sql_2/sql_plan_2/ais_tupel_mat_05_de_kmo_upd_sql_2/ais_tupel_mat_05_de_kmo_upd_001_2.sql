/* 1st update with 1:n-supplier_2 logic */
UPDATE dbp_etl_process.tupel_mat_etl_2 SET a16_akt_lieferant_id = SUBSTR(CAST(b.akt_gp_id AS STRING), 1, 60)
FROM (
    SELECT
        mandant_id,
        art_id,
        MAX(akt_gp_id) AS akt_gp_id
    FROM dbp_msi_view2.mv_art_gp_nm_zu_aktuell_2 AS a
    GROUP BY
        art_id,
        mandant_id
    UNION DISTINCT
    SELECT
        mandant_id,
        art_id,
        MAX(akt_gp_id) AS akt_gp_id
    FROM dbp_msi_view_ais_kmo.tbl_mv_art_gp_nm_zu_aktuell_2
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id
    AND tupel_mat_etl.art_id = b.art_id
    AND tupel_mat_etl.a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_2
    );

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a16_akt_lieferant_id = SUBSTR(CAST(t1.akt_gp_id AS STRING), 1, 60)
FROM (
    SELECT
        mandant_id,
        art_id,
        MAX(gp_id) AS akt_gp_id
    FROM dbp_msi_view2.mv_art_gp_zu_per_2 AS a
    WHERE
        aktuell_fg = 'a'
    GROUP BY
        art_id,
        mandant_id
) AS t1_2
WHERE
    tupel_mat_etl.mandant_id = t1.mandant_id
    AND tupel_mat_etl.art_id = t1.art_id
    AND tupel_mat_etl.a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_2
    )
    AND tupel_mat_etl.a16_akt_lieferant_id IS NULL;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a419_hersteller_id = SUBSTR(CAST(b.herst_id AS STRING), 1, 60), a447_hersteller_bez_latein = b.gp_name
FROM (
    SELECT
        a.mandant_id,
        a.gp_id,
        a.art_id,
        a.herst_id,
        b.gp_name
    FROM dbp_data.art_gp_zu_per_2 AS a
    INNER JOIN dbp_data.gp_2 AS b
        ON a.mandant_id = b.mandant_id AND a.herst_id = b.gp_id
    WHERE
        a.mandant_id = 1 AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
    GROUP BY
        a.mandant_id,
        a.art_id,
        a.gp_id,
        a.herst_id,
        b.gp_name
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.art_id = b.art_id;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a37_listung_erster_markt = t1.min_dat
FROM (
    SELECT
        mandant_id,
        art_id,
        MIN(dat_von) AS min_dat
    FROM dbp_data.art_list_wup_zu_per_2
    WHERE
        list_quelle_id <> '2'
    GROUP BY
        art_id,
        mandant_id
) AS t1_2
WHERE
    tupel_mat_etl.mandant_id = t1.mandant_id AND tupel_mat_etl.art_id = t1.art_id;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a446_lieferant_bez_latein = b.gp_name
FROM (
    SELECT
        mandant_id,
        gp_id,
        gp_name
    FROM dbp_data.gp_2 AS a
    GROUP BY
        mandant_id,
        gp_id,
        gp_name
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id
    AND CAST(tupel_mat_etl.a16_akt_lieferant_id AS FLOAT64) = b.gp_id;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a406_letzte_listungsanderung_sst_ksst = b.dat_erst_listung_
FROM (
    SELECT
        b.mandant_id,
        b.art_matching_id,
        MIN(a.dat_erst_listung) AS dat_erst_listung_
    FROM dbp_data.art_vw_listung_von_2 AS a
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id,
            status_2
        FROM dbp_etl.art_matching_nielsen_per_2
        WHERE
            art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id,
            status_2
    ) AS b
        ON a.art_id = b.art_id AND a.mandant_id = b.mandant_id
    INNER JOIN dbp_etl_process.tupel_mat_etl_2 AS c
        ON b.art_matching_id = c.matching_id AND b.mandant_id = c.mandant_id
    WHERE
        a.mandant_id = 1
    GROUP BY
        b.mandant_id,
        b.art_matching_id
    UNION DISTINCT
    SELECT
        b.mandant_id,
        b.art_matching_id,
        MIN(a.dat_erst_listung) AS dat_erst_listung_
    FROM dbp_data.art_vw_listung_von_2 AS a
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id,
            status_2
        FROM dbp_etl.art_matching_nielsen_per_kmo_2
        WHERE
            art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id,
            status_2
    ) AS b
        ON a.art_id = b.art_id AND a.mandant_id = b.mandant_id
    INNER JOIN dbp_etl_process.tupel_mat_etl_2 AS c
        ON b.art_matching_id = c.matching_id AND b.mandant_id = c.mandant_id
    WHERE
        a.mandant_id > 1
    GROUP BY
        b.mandant_id,
        b.art_matching_id
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id
    AND tupel_mat_etl.matching_id = b.art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _einkaufspreisstamm AS
SELECT *
FROM dbp_msi_view2.mv_einkaufspreisstamm_2
WHERE
    NOT (mandant_id, art_id) IN (
        SELECT (mandant_id, art_id)
        FROM dbp_msi_view2.mv_einkaufspreisstamm_2
        GROUP BY
            mandant_id,
            art_id
        HAVING
            COUNT(*) > 1
    )
UNION DISTINCT
SELECT *
FROM dbp_msi_view2.mv_einkaufspreisstamm_2
WHERE
    (mandant_id, art_id) IN (
        SELECT (mandant_id, art_id)
        FROM dbp_msi_view2.mv_einkaufspreisstamm_2
        GROUP BY
            mandant_id,
            art_id
        HAVING
            COUNT(*) > 1
    )
    AND bezugsweg_id = 4;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a30_kb_olk_ek4ndz_stamm = b.a30_kb_olk_ek4ndz_stamm
FROM (
    SELECT DISTINCT
        mandant_id,
        art_id,
        ek_kal_basis,
        logistikkostenzuschlag,
        ek_kal_basis - logistikkostenzuschlag AS a30_kb_olk_ek4ndz_stamm
    FROM `_einkaufspreisstamm`
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id
    AND tupel_mat_etl.art_id = b.art_id
    AND tupel_mat_etl.a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_2
        WHERE
            mandant_id = 1
    );

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a30_kb_olk_ek4ndz_stamm = b.ek_kal_basis
FROM (
    SELECT
        mandant_id,
        art_id,
        kjmo,
        ek_kb_stamm AS ek_kal_basis
    FROM dbp_data.sal_kmo_2
    GROUP BY
        mandant_id,
        art_id,
        kjmo,
        ek_kal_basis
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id
    AND tupel_mat_etl.art_id = b.art_id
    AND tupel_mat_etl.a425_kjmo = b.kjmo;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET umrech_faktor = ROUND(CAST(b.umrech_faktor AS NUMERIC), 4)
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        MAX(umrech_faktor) AS umrech_faktor
    FROM dbp_etl.art_matching_nielsen_per_2
    WHERE
        art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id
    AND tupel_mat_etl.matching_id = b.art_matching_id;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a402_kolli_la = SUBSTR(CAST(b.koll_faktor_zl AS STRING), 1, 100), a401_kolli_bst = SUBSTR(CAST(b.kolli_faktor_dz AS STRING), 1, 100)
FROM (
    SELECT
        mandant_id,
        art_id,
        MAX(koll_faktor_zl) AS koll_faktor_zl,
        MAX(kolli_faktor_dz) AS kolli_faktor_dz
    FROM dbp_msi_view2.mv_kolli_faktor_dz_zl_2
    GROUP BY
        mandant_id,
        art_id
    UNION DISTINCT
    SELECT
        mandant_id,
        art_id,
        MAX(ausg_menge_einh_inhalt) AS koll_faktor_zl,
        MAX(best_menge_einh_inhalt) AS kolli_faktor_dz
    FROM dbp_msi_view_ais_kmo.mv_best_ausg_menge_einh_2
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.art_id = b.art_id;

UPDATE dbp_etl_process.tupel_mat_etl_2 AS tupel_mat_etl0 SET kassenumsatz_kl_absolut_netto_wg = t0.kassenumsatz_kl_absolut_netto_wg, totalabschriften_wert_netto_absolut_wg = t0.totalabschriften_wert_netto_absolut_wg, preisabschriften_preisanderungen_wert_netto_absolut_wg = t0.preisabschriften_preisanderungen_wert_netto_absolut_wg
FROM (
    SELECT
        a500_kjwo_update,
        mandant_id,
        a7_wg_id,
        SUM(a21_kassenumsatz_kl_absolut_netto) AS kassenumsatz_kl_absolut_netto_wg,
        SUM(a27_totalabschriften_wert_netto_absolut) AS totalabschriften_wert_netto_absolut_wg,
        SUM(a313_preisabschriften_preisanderungen_wert_netto_absolut) AS preisabschriften_preisanderungen_wert_netto_absolut_wg
    FROM dbp_etl_process.tupel_mat_etl_2
    GROUP BY
        mandant_id,
        a500_kjwo_update,
        a7_wg_id
) AS t0
WHERE
    tupel_mat_etl0.a500_kjwo_update = t0.a500_kjwo_update
    AND tupel_mat_etl0.mandant_id = t0.mandant_id
    AND tupel_mat_etl0.a7_wg_id = t0.a7_wg_id;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a14_art_status_de = ''
WHERE
    NOT art_id IS NULL AND a14_art_status_de IS NULL;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET
    a51_listung_sst_pflege = CASE
        WHEN TRIM(tupel_mat_etl.a51_listung_sst_pflege) = ''
            THEN NULL
        ELSE tupel_mat_etl.a51_listung_sst_pflege
    END, a52_listung_k_sst_pflege = CASE
        WHEN TRIM(tupel_mat_etl.a52_listung_k_sst_pflege) = ''
            THEN NULL
        ELSE tupel_mat_etl.a52_listung_k_sst_pflege
    END, a50_listungsaktion = CASE
        WHEN TRIM(tupel_mat_etl.a50_listungsaktion) = ''
            THEN NULL
        ELSE tupel_mat_etl.a50_listungsaktion
    END
WHERE
    TRUE;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a416_artikelrolle_id = b.artikelrolle_id
FROM (
    SELECT *
    FROM dbp_data.art_2
    WHERE
        TRIM(artikelrolle_id) <> ''
) AS b
WHERE
    NOT tupel_mat_etl.art_id IS NULL
    AND tupel_mat_etl.art_id = b.art_id
    AND tupel_mat_etl.mandant_id = b.mandant_id;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET art_bez_deutsch = b.art_bez, a389_zek_id = b.zek_id, a391_disc_pe = b.aldi_id, a392_disc_ohne_etikett = b.discount_id, a400_lcf = CASE WHEN b.lactose_fg = 1 THEN 'X' ELSE '' END, a393_vegan = CASE WHEN b.vegan_fg = 1 THEN 'X' ELSE '' END, a394_gluten = CASE WHEN b.gluten_fg = 1 THEN 'X' ELSE '' END, a395_bio = CASE WHEN b.bio_fg = 1 THEN 'X' ELSE '' END, a396_eigenmarke = b.eigenmarke_id, a397_tierwohl = b.tierwohl_kz, a398_posten_food = b.posten_kz_sap, a403_restlaufzeit_zl = b.mhd_zeitraum, a339_umsatzsteuer = b.mwst, sustain_concat = b.sustain_concat
FROM (
    SELECT DISTINCT
        a.mandant_id,
        a.art_id,
        b.art_bez,
        a.loesch_id,
        a.zek_id,
        a.aldi_id,
        a.discount_id,
        a.lactose_fg,
        a.vegan_fg,
        a.gluten_fg,
        a.bio_fg,
        a.eigenmarke_id,
        a.tierwohl_kz,
        COALESCE(x.mwst, 0) AS mwst,
        a.posten_kz_sap,
        a.mhd_zeitraum,
        a.sustain_concat
    FROM dbp_data.art_2 AS a
    INNER JOIN dbp_data.art_spr_zu_2 AS b
        ON a.art_id = b.art_id AND a.mandant_id = b.mandant_id AND b.spr_id = 22
    LEFT JOIN dbp_data.mwst_per_2 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.mwst_id = x.mwst_id
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
) AS b
WHERE
    NOT tupel_mat_etl.art_id IS NULL
    AND tupel_mat_etl.art_id = b.art_id
    AND tupel_mat_etl.mandant_id = b.mandant_id;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a14_art_status_de = b.loesch_id
FROM (
    SELECT DISTINCT
        mandant_id,
        art_id,
        loesch_id
    FROM dbp_data.art_2
    WHERE
        mandant_id = 1
) AS b
WHERE
    tupel_mat_etl.art_id = b.art_id
    AND tupel_mat_etl.mandant_id = b.mandant_id
    AND tupel_mat_etl.a500_kjwo_update = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE
            mandant_id = 1
    );

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a14_art_status_de = b.loesch_id
FROM (
    SELECT DISTINCT
        mandant_id,
        art_id,
        loesch_id
    FROM dbp_data.art_2
    WHERE
        mandant_id > 1
) AS b
WHERE
    tupel_mat_etl.art_id = b.art_id
    AND tupel_mat_etl.mandant_id = b.mandant_id
    AND tupel_mat_etl.a500_kjwo_update = (
        SELECT MAX(kjwo_update)
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE
            mandant_id > 1
    );

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a450_art_nielsen_nr = b.art_nielsen_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        MAX(kjwo_update) AS kjwo_update,
        MAX(art_nielsen_id) AS art_nielsen_id
    FROM dbp_etl.art_matching_nielsen_per_2
    WHERE
        art_nielsen_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id
    UNION DISTINCT
    SELECT
        mandant_id,
        art_matching_id,
        MAX(kjwo_update) AS kjwo_update,
        MAX(art_nielsen_id) AS art_nielsen_id
    FROM dbp_etl.art_matching_nielsen_per_kmo_2
    WHERE
        art_nielsen_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id
) AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id
    AND tupel_mat_etl.matching_id = b.art_matching_id
    AND tupel_mat_etl.a500_kjwo_update = b.kjwo_update;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a445_anz_tupel_listung_wgi = b.anz_artikel
FROM (
    SELECT
        mandant_id,
        kjwo_update,
        owg_id,
        wg_id,
        wug_id,
        SUM(CASE WHEN anz_maerkte_listung_gesamt > 0 THEN 1 ELSE 0 END) AS anz_artikel
    FROM dbp_data.sortiment_leistung_2
    WHERE
        kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.sortiment_leistung_2
        )
    GROUP BY
        mandant_id,
        kjwo_update,
        owg_id,
        wg_id,
        wug_id
) AS b
WHERE
    tupel_mat_etl.a5_owg_id = b.owg_id
    AND tupel_mat_etl.a7_wg_id = b.wg_id
    AND tupel_mat_etl.wug_id = b.wug_id
    AND tupel_mat_etl.a500_kjwo_update = b.kjwo_update
    AND tupel_mat_etl.mandant_id = b.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE _check_groups1_2 AS
SELECT
    mandant_id,
    a500_kjwo_update,
    matching_id,
    value AS art_id,
    0 AS art_gruppe_id
FROM (
    SELECT
        tupel_mat_etl.mandant_id,
        tupel_mat_etl.a500_kjwo_update,
        tupel_mat_etl.matching_id,
        tupel_mat_etl.a425_kjmo,
        tupel_mat_etl.wrg_id,
        tupel_mat_etl.a5_owg_id,
        tupel_mat_etl.a7_wg_id,
        tupel_mat_etl.wug_id,
        tupel_mat_etl.art_id,
        tupel_mat_etl.kl_art_id,
        tupel_mat_etl.a450_art_nielsen_nr,
        tupel_mat_etl.art_bez_deutsch,
        tupel_mat_etl.a14_art_status_de,
        tupel_mat_etl.nielsen_art_bez,
        tupel_mat_etl.nielsen_gtin,
        tupel_mat_etl.a58_rang_umsatz_owg,
        tupel_mat_etl.a2_rang_umsatz_wg,
        tupel_mat_etl.a59_rang_absatz_wg,
        tupel_mat_etl.a16_akt_lieferant_id,
        tupel_mat_etl.a419_hersteller_id,
        tupel_mat_etl.a446_lieferant_bez_latein,
        tupel_mat_etl.a447_hersteller_bez_latein,
        tupel_mat_etl.lieferant_nielsen,
        tupel_mat_etl.a389_zek_id,
        tupel_mat_etl.a391_disc_pe,
        tupel_mat_etl.a392_disc_ohne_etikett,
        tupel_mat_etl.a400_lcf,
        tupel_mat_etl.a393_vegan,
        tupel_mat_etl.a394_gluten,
        tupel_mat_etl.a395_bio,
        tupel_mat_etl.a396_eigenmarke,
        tupel_mat_etl.a397_tierwohl,
        tupel_mat_etl.a398_posten_food,
        tupel_mat_etl.a399_posten_nonfood,
        tupel_mat_etl.a339_umsatzsteuer,
        tupel_mat_etl.a36_gewichtete_distribution,
        tupel_mat_etl.a60_muki_vk_kz,
        tupel_mat_etl.a61_muki_vk_kl_art_id_verkettung,
        tupel_mat_etl.anzahl_markt_wochen_kombis_abverkauf_af,
        tupel_mat_etl.anzahl_markt_wochen_kombis_abverkauf_sa,
        tupel_mat_etl.anzahl_markt_wochen_kombis_abverkauf_af_vj,
        tupel_mat_etl.anzahl_markt_wochen_kombis_abverkauf_sa_vj,
        tupel_mat_etl.a273_kassenumsatz_kl_absolut_brutto,
        tupel_mat_etl.kassenumsatz_af_kl_absolut_brutto,
        tupel_mat_etl.kassenumsatz_sa_kl_absolut_brutto,
        tupel_mat_etl.kassenumsatz_kl_absolut_brutto_vj,
        tupel_mat_etl.kassenumsatz_af_kl_absolut_brutto_vj,
        tupel_mat_etl.kassenumsatz_sa_kl_absolut_brutto_vj,
        tupel_mat_etl.a21_kassenumsatz_kl_absolut_netto,
        tupel_mat_etl.kassenumsatz_af_kl_absolut_netto,
        tupel_mat_etl.kassenumsatz_sa_kl_absolut_netto,
        tupel_mat_etl.kassenumsatz_kl_absolut_netto_vj,
        tupel_mat_etl.kassenumsatz_af_kl_absolut_netto_vj,
        tupel_mat_etl.kassenumsatz_sa_kl_absolut_netto_vj,
        tupel_mat_etl.a17_absatz_kl,
        tupel_mat_etl.absatz_af_kl,
        tupel_mat_etl.absatz_sa_kl,
        tupel_mat_etl.absatz_kl_vj,
        tupel_mat_etl.absatz_af_kl_vj,
        tupel_mat_etl.absatz_sa_kl_vj,
        tupel_mat_etl.a76_absatz_sst1,
        tupel_mat_etl.a78_absatz_sst2,
        tupel_mat_etl.a80_absatz_sst3,
        tupel_mat_etl.a82_absatz_sst4,
        tupel_mat_etl.a84_absatz_sst5,
        tupel_mat_etl.a86_absatz_sst6,
        tupel_mat_etl.a88_absatz_sst7,
        tupel_mat_etl.a62_absatz_ksst1,
        tupel_mat_etl.a64_absatz_ksst2,
        tupel_mat_etl.a66_absatz_ksst3,
        tupel_mat_etl.a68_absatz_ksst4,
        tupel_mat_etl.a70_absatz_ksst5,
        tupel_mat_etl.a72_absatz_ksst6,
        tupel_mat_etl.a74_absatz_ksst7,
        tupel_mat_etl.a90_absatz_ost_basis,
        tupel_mat_etl.a92_absatz_ost_gross,
        tupel_mat_etl.a94_absatz_sued_ost,
        tupel_mat_etl.a96_absatz_sued_west,
        tupel_mat_etl.a98_absatz_west,
        tupel_mat_etl.a100_absatz_nord,
        tupel_mat_etl.markt_wochen_sst1,
        tupel_mat_etl.markt_wochen_sst2,
        tupel_mat_etl.markt_wochen_sst3,
        tupel_mat_etl.markt_wochen_sst4,
        tupel_mat_etl.markt_wochen_sst5,
        tupel_mat_etl.markt_wochen_sst6,
        tupel_mat_etl.markt_wochen_sst7,
        tupel_mat_etl.markt_wochen_ksst1,
        tupel_mat_etl.markt_wochen_ksst2,
        tupel_mat_etl.markt_wochen_ksst3,
        tupel_mat_etl.markt_wochen_ksst4,
        tupel_mat_etl.markt_wochen_ksst5,
        tupel_mat_etl.markt_wochen_ksst6,
        tupel_mat_etl.markt_wochen_ksst7,
        tupel_mat_etl.markt_wochen_ost_basis,
        tupel_mat_etl.markt_wochen_ost_gross,
        tupel_mat_etl.markt_wochen_sued_ost,
        tupel_mat_etl.markt_wochen_sued_west,
        tupel_mat_etl.markt_wochen_west,
        tupel_mat_etl.markt_wochen_nord,
        tupel_mat_etl.anzahl_markt_wochen_kombis_abverkauf_mit_listung,
        tupel_mat_etl.anzahl_markt_wochen_kombis_listung,
        tupel_mat_etl.a31_vk_brutto_kl_pk_1,
        tupel_mat_etl.a333_vk_brutto_kl_pk_2,
        tupel_mat_etl.a54_vk_brutto_kl_pk_3,
        tupel_mat_etl.a334_vk_brutto_kl_pk_4,
        tupel_mat_etl.a432_vk_brutto_kl_pk_5,
        tupel_mat_etl.a433_vk_brutto_kl_pk_6,
        tupel_mat_etl.a434_vk_brutto_kl_pk_7,
        tupel_mat_etl.a435_vk_brutto_kl_pk_8,
        tupel_mat_etl.a436_vk_brutto_kl_pk_9,
        tupel_mat_etl.a437_vk_brutto_kl_pk_10,
        tupel_mat_etl.a30_kb_olk_ek4ndz_stamm,
        tupel_mat_etl.a23_rohertrag_ekmep_olk_4n,
        tupel_mat_etl.a51_listung_sst_pflege,
        tupel_mat_etl.a52_listung_k_sst_pflege,
        tupel_mat_etl.a426_ost_basis_pflege,
        tupel_mat_etl.a427_ost_gross_pflege,
        tupel_mat_etl.a428_sued_ost_pflege,
        tupel_mat_etl.a429_sued_west_pflege,
        tupel_mat_etl.a430_west_pflege,
        tupel_mat_etl.a431_nord_pflege,
        tupel_mat_etl.a50_listungsaktion,
        tupel_mat_etl.a411_stk_rohertrag_pflege,
        tupel_mat_etl.a415_kannibalisierungsfaktor,
        tupel_mat_etl.a412_umsatz_brutto_hochrechnung,
        tupel_mat_etl.a413_absatz_hochrechnung,
        tupel_mat_etl.a414_rohertrag_hochrechnung,
        tupel_mat_etl.a36_gewichtete_distribution_nielsen,
        tupel_mat_etl.a32_umsatz_anteil_wgi_nielsen,
        tupel_mat_etl.a33_umsatz_anteil_wgi_kumuliert_nielsen,
        tupel_mat_etl.a34_vk_brutto_durchschnitt_nielsen,
        tupel_mat_etl.a35_umsatz_nielsen,
        tupel_mat_etl.anz_wochen_de_anz_monate_kmo_nielsen,
        tupel_mat_etl.absatz_nielsen,
        tupel_mat_etl.a376_kl_marktanteil_wg_nielsen,
        tupel_mat_etl.a380_marktanteilbewertung_nielsen,
        tupel_mat_etl.a377_durchschnitt_anz_maerkte_nielsen,
        tupel_mat_etl.a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen,
        tupel_mat_etl.a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
        tupel_mat_etl.a384_durchschn_preis_einheit_gl_normiert_nielsen,
        tupel_mat_etl.a385_numerische_distribution_nielsen,
        tupel_mat_etl.a386_inhaltsmengen_nielsen,
        tupel_mat_etl.a387_duft_geschmack_nielsen,
        tupel_mat_etl.a388_einheit_nielsen,
        tupel_mat_etl.eigenmarke_fg_nielsen,
        tupel_mat_etl.a39_listung_sst_mvke,
        tupel_mat_etl.a38_listung_k_sst_mvke,
        tupel_mat_etl.a40_ost_basis,
        tupel_mat_etl.a41_ost_gross,
        tupel_mat_etl.a42_sued_ost,
        tupel_mat_etl.a43_sued_west,
        tupel_mat_etl.a44_west,
        tupel_mat_etl.a45_nord,
        tupel_mat_etl.a37_listung_erster_markt,
        tupel_mat_etl.a59_anz_maerkte_sst,
        tupel_mat_etl.a449_anz_maerkte_k_sst,
        tupel_mat_etl.a46_max_anz_maerkte_sst,
        tupel_mat_etl.a47_max_anz_maerkte_k_sst,
        tupel_mat_etl.a53_anz_maerkte_listung_gesamt,
        tupel_mat_etl.a57_anz_maerkte_listung_einzel,
        tupel_mat_etl.anz_maerkte_baustein_sonstige,
        tupel_mat_etl.anz_bons_af,
        tupel_mat_etl.anz_bons_sa,
        tupel_mat_etl.anz_bons_gesamt,
        tupel_mat_etl.rohertrag_ekmep_olk_4n_vj,
        tupel_mat_etl.rohertrag_ekmep_olk_4n_af,
        tupel_mat_etl.rohertrag_ekmep_olk_4n_sa,
        tupel_mat_etl.rohertrag_ekmep_olk_4n_af_vj,
        tupel_mat_etl.rohertrag_ekmep_olk_4n_sa_vj,
        tupel_mat_etl.a381_preislagenverteilung,
        tupel_mat_etl.a27_totalabschriften_wert_netto_absolut,
        tupel_mat_etl.a313_preisabschriften_preisanderungen_wert_netto_absolut,
        tupel_mat_etl.totalabschriften_wert_netto_absolut_vj,
        tupel_mat_etl.preisabschriften_preisanderungen_wert_netto_absolut_vj,
        tupel_mat_etl.a402_kolli_la,
        tupel_mat_etl.a401_kolli_bst,
        tupel_mat_etl.a403_restlaufzeit_zl,
        tupel_mat_etl.a404_restlaufzeit_dz,
        tupel_mat_etl.a405_basismengeneinheit,
        tupel_mat_etl.a406_letzte_listungsanderung_sst_ksst,
        tupel_mat_etl.a407_verhandler,
        tupel_mat_etl.a408_display_komponente_kz,
        tupel_mat_etl.a409_kl_art_id_display,
        tupel_mat_etl.a416_artikelrolle_id,
        tupel_mat_etl.kassenumsatz_kl_absolut_netto_wg,
        tupel_mat_etl.anz_bons_tupel,
        tupel_mat_etl.restbon_summe,
        tupel_mat_etl.totalabschriften_wert_netto_absolut_wg,
        tupel_mat_etl.preisabschriften_preisanderungen_wert_netto_absolut_wg,
        tupel_mat_etl.anz_bons_af_markt_tag,
        tupel_mat_etl.anz_bons_sa_markt_tag,
        tupel_mat_etl.cpq_tupel,
        tupel_mat_etl.cp_bons_af,
        tupel_mat_etl.cp_bons_sa,
        tupel_mat_etl.umrech_faktor,
        tupel_mat_etl.lagerprozent,
        tupel_mat_etl.absatz_af_kl_listungswochen,
        tupel_mat_etl.absatz_af_kl_vj_listungswochen,
        tupel_mat_etl.absatz_sa_kl_listungswochen,
        tupel_mat_etl.absatz_sa_kl_vj_listungswochen,
        tupel_mat_etl.kassenumsatz_af_kl_absolut_netto_listungswochen,
        tupel_mat_etl.kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
        tupel_mat_etl.kassenumsatz_sa_kl_absolut_netto_listungswochen,
        tupel_mat_etl.kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
        tupel_mat_etl.rohertrag_ekmep_olk_4n_af_listungswochen,
        tupel_mat_etl.rohertrag_ekmep_olk_4n_af_vj_listungswochen,
        tupel_mat_etl.rohertrag_ekmep_olk_4n_sa_listungswochen,
        tupel_mat_etl.rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
        tupel_mat_etl.a445_anz_tupel_listung_wgi,
        tupel_mat_etl.td_insert,
        tupel_mat_etl.td_update,
        tupel_mat_etl.sustain_concat,
        tupel_mat_etl.check_fg,
        tupel_mat_etl.tupel_typ,
        tupel_mat_etl.a471_marke_nielsen_bez,
        tupel_mat_etl.a515_bio_organic_nielsen_kz,
        tupel_mat_etl.a516_veggy_split_nielsen_kz,
        tupel_mat_etl.a517_laktosefrei_nielsen_kz,
        tupel_mat_etl.a518_glutenfrei_nielsen_kz,
        tupel_mat_etl.a510_muki_ek_kz,
        tupel_mat_etl.a511_muki_ek_kl_art_id_verkettung,
        tupel_mat_etl.a512_muki_wb_kz,
        tupel_mat_etl.a513_muki_wb_kl_art_id_verkettung,
        tupel_mat_etl.a519_umsatz_anteil_wg_nielsen,
        tupel_mat_etl.a520_umsatz_anteil_wg_kumuliert_nielsen,
        tupel_mat_etl.a521_inhalt_menge,
        t.seq,
        ordinality + 1 AS index,
        value AS value
    FROM dbp_etl_process.tupel_mat_etl_2
    INNER JOIN (
        SELECT 1 AS seq
    ) AS t
        ON TRUE
    INNER JOIN UNNEST(SPLIT(tupel_mat_etl.kl_art_id, ',')) AS value WITH OFFSET AS ordinality
        ON TRUE
) AS t1_2
WHERE
    t1.a500_kjwo_update IN (
        SELECT MAX(a500_kjwo_update) AS a1581216993
        FROM dbp_etl_process.tupel_mat_etl_2
        WHERE
            mandant_id = 1
    )
    AND t1.mandant_id = 1
    AND (t1.mandant_id, t1.matching_id) IN (
        SELECT (mandant_id, art_matching_id)
        FROM dbp_etl_process.art_art_nielsen_groups_2
    );

UPDATE `_check_groups1_2` SET art_id = SUBSTR(CAST(b.art_id AS STRING), 1, 1000)
FROM (
    SELECT *
    FROM dbp_data.art_2
    WHERE
        mandant_id = 1 AND dat_bis = CAST('9999-12-31' AS DATE)
) AS b
WHERE
    `_check_groups1_2`.mandant_id = b.mandant_id
    AND CAST(`_check_groups1_2`.art_id AS FLOAT64) = b.kl_art_id;

UPDATE `_check_groups1_2` SET art_gruppe_id = b.art_gruppe_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        art_gruppe_id
    FROM dbp_etl_process.art_art_nielsen_groups_2
    WHERE
        mandant_id = 1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_gruppe_id
) AS b
WHERE
    `_check_groups1_2`.mandant_id = b.mandant_id
    AND `_check_groups1_2`.matching_id = b.art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _groups_diff_2 AS
SELECT
    x.art_matching_id,
    a.art_gruppe_id,
    x.anz AS anz_am,
    t5.anz AS anz_ag
FROM (
    SELECT
        art_matching_id,
        art_gruppe_id
    FROM dbp_etl_process.art_art_nielsen_groups_2
    GROUP BY
        art_matching_id,
        art_gruppe_id
) AS a
INNER JOIN (
    SELECT
        matching_id AS art_matching_id,
        COUNT(DISTINCT art_id) AS anz
    FROM `_check_groups1_2`
    GROUP BY
        art_matching_id
) AS x
    ON a.art_matching_id = x.art_matching_id
INNER JOIN (
    SELECT
        b.art_gruppe_id,
        COUNT(*) AS anz
    FROM dbp_data.art_gruppe_2 AS a
    INNER JOIN dbp_data.art_gruppe_art_zu_2 AS b
        ON a.art_gruppe_id = b.art_gruppe_id
    WHERE
        a.art_gruppe_kategorie = 'sortimentstool' AND b.mandant_id = 1
    GROUP BY
        b.art_gruppe_id
) AS t5
    ON a.art_gruppe_id = t5.art_gruppe_id AND x.anz <> t5.anz;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET kl_art_id = b.kl_art_id
FROM (
    SELECT
        a.art_matching_id,
        substr(
            replace(
                TRIM(
                    STRING_AGG(

                        LPAD(
                            substr(
                                CAST(round(
                                    CAST(LPAD(substr(CAST(FLOOR(b_0.art_id / 100) AS STRING), 1, 600), 8, '0') AS BIGNUMERIC),
                                    0
                                ) AS STRING),
                                1,
                                8
                            ),
                            8,
                            '0'
                        ),
                        ','

                        ORDER BY
                            IF(FLOOR(b_0.art_id / 100) IS NULL, 0, 1) DESC,
                            FLOOR(b_0.art_id / 100)
                    ),
                    ','
                ),
                ' ',
                ''
            ),
            1,
            300
        ) AS kl_art_id
    FROM `_groups_diff_2` AS a
    INNER JOIN dbp_etl_process.art_art_nielsen_groups_2 AS b_0
        ON a.art_matching_id = b_0.art_matching_id
    GROUP BY
        1
) AS b
WHERE
    tupel_mat_etl.mandant_id = 1
    AND tupel_mat_etl.a500_kjwo_update IN (
        SELECT MAX(a500_kjwo_update)
        FROM dbp_etl_process.tupel_mat_etl_2 AS tupel_mat_etl_0
        WHERE
            mandant_id = 1
    )
    AND tupel_mat_etl.matching_id = b.art_matching_id;

CREATE OR REPLACE TEMPORARY TABLE _update_kl_art_id_1 AS
SELECT
    mandant_id,
    art_matching_id,
    LPAD(CAST(CAST(FLOOR(art_id / 100) AS INT64) AS STRING), 8, '0') AS art_id
FROM dbp_etl.art_matching_nielsen_per_2
WHERE
    art_id <> -1
    AND kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_etl.art_matching_nielsen_per_2
    )
GROUP BY
    mandant_id,
    art_matching_id,
    art_id;

CREATE OR REPLACE TEMPORARY TABLE _update_kl_art_id_2 AS
SELECT
    mandant_id,
    art_matching_id,
    STRING_AGG(
        art_id, ','
        ORDER BY
            art_id IS NULL,
            art_id
    ) AS kl_art_id
FROM (
    SELECT DISTINCT
        mandant_id,
        art_matching_id,
        art_id
    FROM `_update_kl_art_id_1`
)
GROUP BY
    mandant_id,
    art_matching_id;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET kl_art_id = b.kl_art_id
FROM `_update_kl_art_id_2` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id
    AND tupel_mat_etl.matching_id = b.art_matching_id
    AND tupel_mat_etl.a500_kjwo_update = (
        SELECT MAX(kjwo_update)
        FROM dbp_etl.art_matching_nielsen_per_2
    );

CREATE OR REPLACE TEMPORARY TABLE _dup_free_2 AS
SELECT
    mandant_id,
    a500_kjwo_update,
    matching_id,
    a425_kjmo,
    MAX(wrg_id) AS wrg_id,
    MAX(a5_owg_id) AS a5_owg_id,
    MAX(a7_wg_id) AS a7_wg_id,
    MAX(wug_id) AS wug_id,
    MAX(art_id) AS art_id,
    MAX(kl_art_id) AS kl_art_id,
    MAX(a450_art_nielsen_nr) AS a450_art_nielsen_nr,
    MAX(art_bez_deutsch) AS art_bez_deutsch,
    MAX(a14_art_status_de) AS a14_art_status_de,
    MAX(nielsen_art_bez) AS nielsen_art_bez,
    MAX(nielsen_gtin) AS nielsen_gtin,
    MAX(a58_rang_umsatz_owg) AS a58_rang_umsatz_owg,
    MAX(a2_rang_umsatz_wg) AS a2_rang_umsatz_wg,
    MAX(a59_rang_absatz_wg) AS a59_rang_absatz_wg,
    MAX(a16_akt_lieferant_id) AS a16_akt_lieferant_id,
    MAX(a419_hersteller_id) AS a419_hersteller_id,
    MAX(a446_lieferant_bez_latein) AS a446_lieferant_bez_latein,
    MAX(a447_hersteller_bez_latein) AS a447_hersteller_bez_latein,
    MAX(lieferant_nielsen) AS lieferant_nielsen,
    MAX(a389_zek_id) AS a389_zek_id,
    MAX(a391_disc_pe) AS a391_disc_pe,
    MAX(a392_disc_ohne_etikett) AS a392_disc_ohne_etikett,
    MAX(a400_lcf) AS a400_lcf,
    MAX(a393_vegan) AS a393_vegan,
    MAX(a394_gluten) AS a394_gluten,
    MAX(a395_bio) AS a395_bio,
    MAX(a396_eigenmarke) AS a396_eigenmarke,
    MAX(a397_tierwohl) AS a397_tierwohl,
    MAX(a398_posten_food) AS a398_posten_food,
    MAX(a399_posten_nonfood) AS a399_posten_nonfood,
    MAX(a339_umsatzsteuer) AS a339_umsatzsteuer,
    MAX(a36_gewichtete_distribution) AS a36_gewichtete_distribution,
    MAX(a60_muki_vk_kz) AS a60_muki_vk_kz,
    MAX(a61_muki_vk_kl_art_id_verkettung) AS a61_muki_vk_kl_art_id_verkettung,
    MAX(anzahl_markt_wochen_kombis_abverkauf_af) AS anzahl_markt_wochen_kombis_abverkauf_af,
    MAX(anzahl_markt_wochen_kombis_abverkauf_sa) AS anzahl_markt_wochen_kombis_abverkauf_sa,
    MAX(anzahl_markt_wochen_kombis_abverkauf_af_vj) AS anzahl_markt_wochen_kombis_abverkauf_af_vj,
    MAX(anzahl_markt_wochen_kombis_abverkauf_sa_vj) AS anzahl_markt_wochen_kombis_abverkauf_sa_vj,
    MAX(a273_kassenumsatz_kl_absolut_brutto) AS a273_kassenumsatz_kl_absolut_brutto,
    MAX(kassenumsatz_af_kl_absolut_brutto) AS kassenumsatz_af_kl_absolut_brutto,
    MAX(kassenumsatz_sa_kl_absolut_brutto) AS kassenumsatz_sa_kl_absolut_brutto,
    MAX(kassenumsatz_kl_absolut_brutto_vj) AS kassenumsatz_kl_absolut_brutto_vj,
    MAX(kassenumsatz_af_kl_absolut_brutto_vj) AS kassenumsatz_af_kl_absolut_brutto_vj,
    MAX(kassenumsatz_sa_kl_absolut_brutto_vj) AS kassenumsatz_sa_kl_absolut_brutto_vj,
    MAX(a21_kassenumsatz_kl_absolut_netto) AS a21_kassenumsatz_kl_absolut_netto,
    MAX(kassenumsatz_af_kl_absolut_netto) AS kassenumsatz_af_kl_absolut_netto,
    MAX(kassenumsatz_sa_kl_absolut_netto) AS kassenumsatz_sa_kl_absolut_netto,
    MAX(kassenumsatz_kl_absolut_netto_vj) AS kassenumsatz_kl_absolut_netto_vj,
    MAX(kassenumsatz_af_kl_absolut_netto_vj) AS kassenumsatz_af_kl_absolut_netto_vj,
    MAX(kassenumsatz_sa_kl_absolut_netto_vj) AS kassenumsatz_sa_kl_absolut_netto_vj,
    MAX(a17_absatz_kl) AS a17_absatz_kl,
    MAX(absatz_af_kl) AS absatz_af_kl,
    MAX(absatz_sa_kl) AS absatz_sa_kl,
    MAX(absatz_kl_vj) AS absatz_kl_vj,
    MAX(absatz_af_kl_vj) AS absatz_af_kl_vj,
    MAX(absatz_sa_kl_vj) AS absatz_sa_kl_vj,
    MAX(a76_absatz_sst1) AS a76_absatz_sst1,
    MAX(a78_absatz_sst2) AS a78_absatz_sst2,
    MAX(a80_absatz_sst3) AS a80_absatz_sst3,
    MAX(a82_absatz_sst4) AS a82_absatz_sst4,
    MAX(a84_absatz_sst5) AS a84_absatz_sst5,
    MAX(a86_absatz_sst6) AS a86_absatz_sst6,
    MAX(a88_absatz_sst7) AS a88_absatz_sst7,
    MAX(a62_absatz_ksst1) AS a62_absatz_ksst1,
    MAX(a64_absatz_ksst2) AS a64_absatz_ksst2,
    MAX(a66_absatz_ksst3) AS a66_absatz_ksst3,
    MAX(a68_absatz_ksst4) AS a68_absatz_ksst4,
    MAX(a70_absatz_ksst5) AS a70_absatz_ksst5,
    MAX(a72_absatz_ksst6) AS a72_absatz_ksst6,
    MAX(a74_absatz_ksst7) AS a74_absatz_ksst7,
    MAX(a90_absatz_ost_basis) AS a90_absatz_ost_basis,
    MAX(a92_absatz_ost_gross) AS a92_absatz_ost_gross,
    MAX(a94_absatz_sued_ost) AS a94_absatz_sued_ost,
    MAX(a96_absatz_sued_west) AS a96_absatz_sued_west,
    MAX(a98_absatz_west) AS a98_absatz_west,
    MAX(a100_absatz_nord) AS a100_absatz_nord,
    MAX(markt_wochen_sst1) AS markt_wochen_sst1,
    MAX(markt_wochen_sst2) AS markt_wochen_sst2,
    MAX(markt_wochen_sst3) AS markt_wochen_sst3,
    MAX(markt_wochen_sst4) AS markt_wochen_sst4,
    MAX(markt_wochen_sst5) AS markt_wochen_sst5,
    MAX(markt_wochen_sst6) AS markt_wochen_sst6,
    MAX(markt_wochen_sst7) AS markt_wochen_sst7,
    MAX(markt_wochen_ksst1) AS markt_wochen_ksst1,
    MAX(markt_wochen_ksst2) AS markt_wochen_ksst2,
    MAX(markt_wochen_ksst3) AS markt_wochen_ksst3,
    MAX(markt_wochen_ksst4) AS markt_wochen_ksst4,
    MAX(markt_wochen_ksst5) AS markt_wochen_ksst5,
    MAX(markt_wochen_ksst6) AS markt_wochen_ksst6,
    MAX(markt_wochen_ksst7) AS markt_wochen_ksst7,
    MAX(markt_wochen_ost_basis) AS markt_wochen_ost_basis,
    MAX(markt_wochen_ost_gross) AS markt_wochen_ost_gross,
    MAX(markt_wochen_sued_ost) AS markt_wochen_sued_ost,
    MAX(markt_wochen_sued_west) AS markt_wochen_sued_west,
    MAX(markt_wochen_west) AS markt_wochen_west,
    MAX(markt_wochen_nord) AS markt_wochen_nord,
    MAX(anzahl_markt_wochen_kombis_abverkauf_mit_listung) AS anzahl_markt_wochen_kombis_abverkauf_mit_listung,
    MAX(anzahl_markt_wochen_kombis_listung) AS anzahl_markt_wochen_kombis_listung,
    MAX(a31_vk_brutto_kl_pk_1) AS a31_vk_brutto_kl_pk_1,
    MAX(a333_vk_brutto_kl_pk_2) AS a333_vk_brutto_kl_pk_2,
    MAX(a54_vk_brutto_kl_pk_3) AS a54_vk_brutto_kl_pk_3,
    MAX(a334_vk_brutto_kl_pk_4) AS a334_vk_brutto_kl_pk_4,
    MAX(a432_vk_brutto_kl_pk_5) AS a432_vk_brutto_kl_pk_5,
    MAX(a433_vk_brutto_kl_pk_6) AS a433_vk_brutto_kl_pk_6,
    MAX(a434_vk_brutto_kl_pk_7) AS a434_vk_brutto_kl_pk_7,
    MAX(a435_vk_brutto_kl_pk_8) AS a435_vk_brutto_kl_pk_8,
    MAX(a436_vk_brutto_kl_pk_9) AS a436_vk_brutto_kl_pk_9,
    MAX(a437_vk_brutto_kl_pk_10) AS a437_vk_brutto_kl_pk_10,
    MAX(a30_kb_olk_ek4ndz_stamm) AS a30_kb_olk_ek4ndz_stamm,
    MAX(a23_rohertrag_ekmep_olk_4n) AS a23_rohertrag_ekmep_olk_4n,
    MAX(a51_listung_sst_pflege) AS a51_listung_sst_pflege,
    MAX(a52_listung_k_sst_pflege) AS a52_listung_k_sst_pflege,
    MAX(a426_ost_basis_pflege) AS a426_ost_basis_pflege,
    MAX(a427_ost_gross_pflege) AS a427_ost_gross_pflege,
    MAX(a428_sued_ost_pflege) AS a428_sued_ost_pflege,
    MAX(a429_sued_west_pflege) AS a429_sued_west_pflege,
    MAX(a430_west_pflege) AS a430_west_pflege,
    MAX(a431_nord_pflege) AS a431_nord_pflege,
    MAX(a50_listungsaktion) AS a50_listungsaktion,
    MAX(a411_stk_rohertrag_pflege) AS a411_stk_rohertrag_pflege,
    MAX(a415_kannibalisierungsfaktor) AS a415_kannibalisierungsfaktor,
    MAX(a412_umsatz_brutto_hochrechnung) AS a412_umsatz_brutto_hochrechnung,
    MAX(a413_absatz_hochrechnung) AS a413_absatz_hochrechnung,
    MAX(a414_rohertrag_hochrechnung) AS a414_rohertrag_hochrechnung,
    MAX(a36_gewichtete_distribution_nielsen) AS a36_gewichtete_distribution_nielsen,
    MAX(a32_umsatz_anteil_wgi_nielsen) AS a32_umsatz_anteil_wgi_nielsen,
    MAX(a33_umsatz_anteil_wgi_kumuliert_nielsen) AS a33_umsatz_anteil_wgi_kumuliert_nielsen,
    MAX(a34_vk_brutto_durchschnitt_nielsen) AS a34_vk_brutto_durchschnitt_nielsen,
    MAX(a35_umsatz_nielsen) AS a35_umsatz_nielsen,
    MAX(anz_wochen_de_anz_monate_kmo_nielsen) AS anz_wochen_de_anz_monate_kmo_nielsen,
    MAX(absatz_nielsen) AS absatz_nielsen,
    MAX(a376_kl_marktanteil_wg_nielsen) AS a376_kl_marktanteil_wg_nielsen,
    MAX(a380_marktanteilbewertung_nielsen) AS a380_marktanteilbewertung_nielsen,
    MAX(a377_durchschnitt_anz_maerkte_nielsen) AS a377_durchschnitt_anz_maerkte_nielsen,
    MAX(a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen) AS a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen,
    MAX(a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen) AS a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
    MAX(a384_durchschn_preis_einheit_gl_normiert_nielsen) AS a384_durchschn_preis_einheit_gl_normiert_nielsen,
    MAX(a385_numerische_distribution_nielsen) AS a385_numerische_distribution_nielsen,
    MAX(a386_inhaltsmengen_nielsen) AS a386_inhaltsmengen_nielsen,
    MAX(a387_duft_geschmack_nielsen) AS a387_duft_geschmack_nielsen,
    MAX(a388_einheit_nielsen) AS a388_einheit_nielsen,
    MAX(eigenmarke_fg_nielsen) AS eigenmarke_fg_nielsen,
    MAX(a39_listung_sst_mvke) AS a39_listung_sst_mvke,
    MAX(a38_listung_k_sst_mvke) AS a38_listung_k_sst_mvke,
    MAX(a40_ost_basis) AS a40_ost_basis,
    MAX(a41_ost_gross) AS a41_ost_gross,
    MAX(a42_sued_ost) AS a42_sued_ost,
    MAX(a43_sued_west) AS a43_sued_west,
    MAX(a44_west) AS a44_west,
    MAX(a45_nord) AS a45_nord,
    MAX(a37_listung_erster_markt) AS a37_listung_erster_markt,
    MAX(a59_anz_maerkte_sst) AS a59_anz_maerkte_sst,
    MAX(a449_anz_maerkte_k_sst) AS a449_anz_maerkte_k_sst,
    MAX(a46_max_anz_maerkte_sst) AS a46_max_anz_maerkte_sst,
    MAX(a47_max_anz_maerkte_k_sst) AS a47_max_anz_maerkte_k_sst,
    MAX(a53_anz_maerkte_listung_gesamt) AS a53_anz_maerkte_listung_gesamt,
    MAX(a57_anz_maerkte_listung_einzel) AS a57_anz_maerkte_listung_einzel,
    MAX(anz_maerkte_baustein_sonstige) AS anz_maerkte_baustein_sonstige,
    MAX(anz_bons_af) AS anz_bons_af,
    MAX(anz_bons_sa) AS anz_bons_sa,
    MAX(anz_bons_gesamt) AS anz_bons_gesamt,
    MAX(rohertrag_ekmep_olk_4n_vj) AS rohertrag_ekmep_olk_4n_vj,
    MAX(rohertrag_ekmep_olk_4n_af) AS rohertrag_ekmep_olk_4n_af,
    MAX(rohertrag_ekmep_olk_4n_sa) AS rohertrag_ekmep_olk_4n_sa,
    MAX(rohertrag_ekmep_olk_4n_af_vj) AS rohertrag_ekmep_olk_4n_af_vj,
    MAX(rohertrag_ekmep_olk_4n_sa_vj) AS rohertrag_ekmep_olk_4n_sa_vj,
    MAX(a381_preislagenverteilung) AS a381_preislagenverteilung,
    MAX(a27_totalabschriften_wert_netto_absolut) AS a27_totalabschriften_wert_netto_absolut,
    MAX(a313_preisabschriften_preisanderungen_wert_netto_absolut) AS a313_preisabschriften_preisanderungen_wert_netto_absolut,
    MAX(totalabschriften_wert_netto_absolut_vj) AS totalabschriften_wert_netto_absolut_vj,
    MAX(preisabschriften_preisanderungen_wert_netto_absolut_vj) AS preisabschriften_preisanderungen_wert_netto_absolut_vj,
    MAX(a402_kolli_la) AS a402_kolli_la,
    MAX(a401_kolli_bst) AS a401_kolli_bst,
    MAX(a403_restlaufzeit_zl) AS a403_restlaufzeit_zl,
    MAX(a404_restlaufzeit_dz) AS a404_restlaufzeit_dz,
    MAX(a405_basismengeneinheit) AS a405_basismengeneinheit,
    MAX(a406_letzte_listungsanderung_sst_ksst) AS a406_letzte_listungsanderung_sst_ksst,
    MAX(a407_verhandler) AS a407_verhandler,
    MAX(a408_display_komponente_kz) AS a408_display_komponente_kz,
    MAX(a409_kl_art_id_display) AS a409_kl_art_id_display,
    MAX(a416_artikelrolle_id) AS a416_artikelrolle_id,
    MAX(kassenumsatz_kl_absolut_netto_wg) AS kassenumsatz_kl_absolut_netto_wg,
    MAX(anz_bons_tupel) AS anz_bons_tupel,
    MAX(restbon_summe) AS restbon_summe,
    MAX(totalabschriften_wert_netto_absolut_wg) AS totalabschriften_wert_netto_absolut_wg,
    MAX(preisabschriften_preisanderungen_wert_netto_absolut_wg) AS preisabschriften_preisanderungen_wert_netto_absolut_wg,
    MAX(anz_bons_af_markt_tag) AS anz_bons_af_markt_tag,
    MAX(anz_bons_sa_markt_tag) AS anz_bons_sa_markt_tag,
    MAX(cpq_tupel) AS cpq_tupel,
    MAX(cp_bons_af) AS cp_bons_af,
    MAX(cp_bons_sa) AS cp_bons_sa,
    MAX(umrech_faktor) AS umrech_faktor,
    MAX(lagerprozent) AS lagerprozent,
    MAX(absatz_af_kl_listungswochen) AS absatz_af_kl_listungswochen,
    MAX(absatz_af_kl_vj_listungswochen) AS absatz_af_kl_vj_listungswochen,
    MAX(absatz_sa_kl_listungswochen) AS absatz_sa_kl_listungswochen,
    MAX(absatz_sa_kl_vj_listungswochen) AS absatz_sa_kl_vj_listungswochen,
    MAX(kassenumsatz_af_kl_absolut_netto_listungswochen) AS kassenumsatz_af_kl_absolut_netto_listungswochen,
    MAX(kassenumsatz_af_kl_absolut_netto_vj_listungswochen) AS kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
    MAX(kassenumsatz_sa_kl_absolut_netto_listungswochen) AS kassenumsatz_sa_kl_absolut_netto_listungswochen,
    MAX(kassenumsatz_sa_kl_absolut_netto_vj_listungswochen) AS kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
    MAX(rohertrag_ekmep_olk_4n_af_listungswochen) AS rohertrag_ekmep_olk_4n_af_listungswochen,
    MAX(rohertrag_ekmep_olk_4n_af_vj_listungswochen) AS rohertrag_ekmep_olk_4n_af_vj_listungswochen,
    MAX(rohertrag_ekmep_olk_4n_sa_listungswochen) AS rohertrag_ekmep_olk_4n_sa_listungswochen,
    MAX(rohertrag_ekmep_olk_4n_sa_vj_listungswochen) AS rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
    MAX(a445_anz_tupel_listung_wgi) AS a445_anz_tupel_listung_wgi,
    MAX(td_insert) AS td_insert,
    MAX(td_update) AS td_update,
    MAX(sustain_concat) AS sustain_concat,
    MAX(check_fg) AS check_fg,
    MAX(tupel_typ) AS tupel_typ,
    MAX(a471_marke_nielsen_bez) AS a471_marke_nielsen_bez,
    MAX(a515_bio_organic_nielsen_kz) AS a515_bio_organic_nielsen_kz,
    MAX(a516_veggy_split_nielsen_kz) AS a516_veggy_split_nielsen_kz,
    MAX(a517_laktosefrei_nielsen_kz) AS a517_laktosefrei_nielsen_kz,
    MAX(a518_glutenfrei_nielsen_kz) AS a518_glutenfrei_nielsen_kz,
    MAX(a510_muki_ek_kz) AS a510_muki_ek_kz,
    MAX(a511_muki_ek_kl_art_id_verkettung) AS a511_muki_ek_kl_art_id_verkettung,
    MAX(a512_muki_wb_kz) AS a512_muki_wb_kz,
    MAX(a513_muki_wb_kl_art_id_verkettung) AS a513_muki_wb_kl_art_id_verkettung,
    MAX(a519_umsatz_anteil_wg_nielsen) AS a519_umsatz_anteil_wg_nielsen,
    MAX(a520_umsatz_anteil_wg_kumuliert_nielsen) AS a520_umsatz_anteil_wg_kumuliert_nielsen,
    MAX(a521_inhalt_menge) AS a521_inhalt_menge
FROM dbp_etl_process.tupel_mat_etl_2
WHERE
    a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_2
    )
GROUP BY
    mandant_id,
    a500_kjwo_update,
    matching_id,
    a425_kjmo;

DELETE FROM dbp_etl_process.tupel_mat_etl_2
WHERE
    a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_2
    );

INSERT INTO dbp_etl_process.tupel_mat_etl_2 (
    mandant_id,
    a500_kjwo_update,
    matching_id,
    a425_kjmo,
    wrg_id,
    a5_owg_id,
    a7_wg_id,
    wug_id,
    art_id,
    kl_art_id,
    a450_art_nielsen_nr,
    art_bez_deutsch,
    a14_art_status_de,
    nielsen_art_bez,
    nielsen_gtin,
    a58_rang_umsatz_owg,
    a2_rang_umsatz_wg,
    a59_rang_absatz_wg,
    a16_akt_lieferant_id,
    a419_hersteller_id,
    a446_lieferant_bez_latein,
    a447_hersteller_bez_latein,
    lieferant_nielsen,
    a389_zek_id,
    a391_disc_pe,
    a392_disc_ohne_etikett,
    a400_lcf,
    a393_vegan,
    a394_gluten,
    a395_bio,
    a396_eigenmarke,
    a397_tierwohl,
    a398_posten_food,
    a399_posten_nonfood,
    a339_umsatzsteuer,
    a36_gewichtete_distribution,
    a60_muki_vk_kz,
    a61_muki_vk_kl_art_id_verkettung,
    anzahl_markt_wochen_kombis_abverkauf_af,
    anzahl_markt_wochen_kombis_abverkauf_sa,
    anzahl_markt_wochen_kombis_abverkauf_af_vj,
    anzahl_markt_wochen_kombis_abverkauf_sa_vj,
    a273_kassenumsatz_kl_absolut_brutto,
    kassenumsatz_af_kl_absolut_brutto,
    kassenumsatz_sa_kl_absolut_brutto,
    kassenumsatz_kl_absolut_brutto_vj,
    kassenumsatz_af_kl_absolut_brutto_vj,
    kassenumsatz_sa_kl_absolut_brutto_vj,
    a21_kassenumsatz_kl_absolut_netto,
    kassenumsatz_af_kl_absolut_netto,
    kassenumsatz_sa_kl_absolut_netto,
    kassenumsatz_kl_absolut_netto_vj,
    kassenumsatz_af_kl_absolut_netto_vj,
    kassenumsatz_sa_kl_absolut_netto_vj,
    a17_absatz_kl,
    absatz_af_kl,
    absatz_sa_kl,
    absatz_kl_vj,
    absatz_af_kl_vj,
    absatz_sa_kl_vj,
    a76_absatz_sst1,
    a78_absatz_sst2,
    a80_absatz_sst3,
    a82_absatz_sst4,
    a84_absatz_sst5,
    a86_absatz_sst6,
    a88_absatz_sst7,
    a62_absatz_ksst1,
    a64_absatz_ksst2,
    a66_absatz_ksst3,
    a68_absatz_ksst4,
    a70_absatz_ksst5,
    a72_absatz_ksst6,
    a74_absatz_ksst7,
    a90_absatz_ost_basis,
    a92_absatz_ost_gross,
    a94_absatz_sued_ost,
    a96_absatz_sued_west,
    a98_absatz_west,
    a100_absatz_nord,
    markt_wochen_sst1,
    markt_wochen_sst2,
    markt_wochen_sst3,
    markt_wochen_sst4,
    markt_wochen_sst5,
    markt_wochen_sst6,
    markt_wochen_sst7,
    markt_wochen_ksst1,
    markt_wochen_ksst2,
    markt_wochen_ksst3,
    markt_wochen_ksst4,
    markt_wochen_ksst5,
    markt_wochen_ksst6,
    markt_wochen_ksst7,
    markt_wochen_ost_basis,
    markt_wochen_ost_gross,
    markt_wochen_sued_ost,
    markt_wochen_sued_west,
    markt_wochen_west,
    markt_wochen_nord,
    anzahl_markt_wochen_kombis_abverkauf_mit_listung,
    anzahl_markt_wochen_kombis_listung,
    a31_vk_brutto_kl_pk_1,
    a333_vk_brutto_kl_pk_2,
    a54_vk_brutto_kl_pk_3,
    a334_vk_brutto_kl_pk_4,
    a432_vk_brutto_kl_pk_5,
    a433_vk_brutto_kl_pk_6,
    a434_vk_brutto_kl_pk_7,
    a435_vk_brutto_kl_pk_8,
    a436_vk_brutto_kl_pk_9,
    a437_vk_brutto_kl_pk_10,
    a30_kb_olk_ek4ndz_stamm,
    a23_rohertrag_ekmep_olk_4n,
    a51_listung_sst_pflege,
    a52_listung_k_sst_pflege,
    a426_ost_basis_pflege,
    a427_ost_gross_pflege,
    a428_sued_ost_pflege,
    a429_sued_west_pflege,
    a430_west_pflege,
    a431_nord_pflege,
    a50_listungsaktion,
    a411_stk_rohertrag_pflege,
    a415_kannibalisierungsfaktor,
    a412_umsatz_brutto_hochrechnung,
    a413_absatz_hochrechnung,
    a414_rohertrag_hochrechnung,
    a36_gewichtete_distribution_nielsen,
    a32_umsatz_anteil_wgi_nielsen,
    a33_umsatz_anteil_wgi_kumuliert_nielsen,
    a34_vk_brutto_durchschnitt_nielsen,
    a35_umsatz_nielsen,
    anz_wochen_de_anz_monate_kmo_nielsen,
    absatz_nielsen,
    a376_kl_marktanteil_wg_nielsen,
    a380_marktanteilbewertung_nielsen,
    a377_durchschnitt_anz_maerkte_nielsen,
    a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen,
    a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
    a384_durchschn_preis_einheit_gl_normiert_nielsen,
    a385_numerische_distribution_nielsen,
    a386_inhaltsmengen_nielsen,
    a387_duft_geschmack_nielsen,
    a388_einheit_nielsen,
    eigenmarke_fg_nielsen,
    a39_listung_sst_mvke,
    a38_listung_k_sst_mvke,
    a40_ost_basis,
    a41_ost_gross,
    a42_sued_ost,
    a43_sued_west,
    a44_west,
    a45_nord,
    a37_listung_erster_markt,
    a59_anz_maerkte_sst,
    a449_anz_maerkte_k_sst,
    a46_max_anz_maerkte_sst,
    a47_max_anz_maerkte_k_sst,
    a53_anz_maerkte_listung_gesamt,
    a57_anz_maerkte_listung_einzel,
    anz_maerkte_baustein_sonstige,
    anz_bons_af,
    anz_bons_sa,
    anz_bons_gesamt,
    rohertrag_ekmep_olk_4n_vj,
    rohertrag_ekmep_olk_4n_af,
    rohertrag_ekmep_olk_4n_sa,
    rohertrag_ekmep_olk_4n_af_vj,
    rohertrag_ekmep_olk_4n_sa_vj,
    a381_preislagenverteilung,
    a27_totalabschriften_wert_netto_absolut,
    a313_preisabschriften_preisanderungen_wert_netto_absolut,
    totalabschriften_wert_netto_absolut_vj,
    preisabschriften_preisanderungen_wert_netto_absolut_vj,
    a402_kolli_la,
    a401_kolli_bst,
    a403_restlaufzeit_zl,
    a404_restlaufzeit_dz,
    a405_basismengeneinheit,
    a406_letzte_listungsanderung_sst_ksst,
    a407_verhandler,
    a408_display_komponente_kz,
    a409_kl_art_id_display,
    a416_artikelrolle_id,
    kassenumsatz_kl_absolut_netto_wg,
    anz_bons_tupel,
    restbon_summe,
    totalabschriften_wert_netto_absolut_wg,
    preisabschriften_preisanderungen_wert_netto_absolut_wg,
    anz_bons_af_markt_tag,
    anz_bons_sa_markt_tag,
    cpq_tupel,
    cp_bons_af,
    cp_bons_sa,
    umrech_faktor,
    lagerprozent,
    absatz_af_kl_listungswochen,
    absatz_af_kl_vj_listungswochen,
    absatz_sa_kl_listungswochen,
    absatz_sa_kl_vj_listungswochen,
    kassenumsatz_af_kl_absolut_netto_listungswochen,
    kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
    kassenumsatz_sa_kl_absolut_netto_listungswochen,
    kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
    rohertrag_ekmep_olk_4n_af_listungswochen,
    rohertrag_ekmep_olk_4n_af_vj_listungswochen,
    rohertrag_ekmep_olk_4n_sa_listungswochen,
    rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
    a445_anz_tupel_listung_wgi,
    td_insert,
    td_update,
    sustain_concat,
    check_fg,
    tupel_typ,
    a471_marke_nielsen_bez,
    a515_bio_organic_nielsen_kz,
    a516_veggy_split_nielsen_kz,
    a517_laktosefrei_nielsen_kz,
    a518_glutenfrei_nielsen_kz,
    a510_muki_ek_kz,
    a511_muki_ek_kl_art_id_verkettung,
    a512_muki_wb_kz,
    a513_muki_wb_kl_art_id_verkettung,
    a519_umsatz_anteil_wg_nielsen,
    a520_umsatz_anteil_wg_kumuliert_nielsen,
    a521_inhalt_menge
)
(
    SELECT
        mandant_id,
        a500_kjwo_update,
        matching_id,
        a425_kjmo,
        wrg_id,
        a5_owg_id,
        a7_wg_id,
        wug_id,
        art_id,
        kl_art_id,
        a450_art_nielsen_nr,
        art_bez_deutsch,
        a14_art_status_de,
        nielsen_art_bez,
        nielsen_gtin,
        a58_rang_umsatz_owg,
        a2_rang_umsatz_wg,
        a59_rang_absatz_wg,
        a16_akt_lieferant_id,
        a419_hersteller_id,
        a446_lieferant_bez_latein,
        a447_hersteller_bez_latein,
        lieferant_nielsen,
        a389_zek_id,
        a391_disc_pe,
        a392_disc_ohne_etikett,
        a400_lcf,
        a393_vegan,
        a394_gluten,
        a395_bio,
        a396_eigenmarke,
        a397_tierwohl,
        a398_posten_food,
        a399_posten_nonfood,
        a339_umsatzsteuer,
        a36_gewichtete_distribution,
        a60_muki_vk_kz,
        a61_muki_vk_kl_art_id_verkettung,
        anzahl_markt_wochen_kombis_abverkauf_af,
        anzahl_markt_wochen_kombis_abverkauf_sa,
        anzahl_markt_wochen_kombis_abverkauf_af_vj,
        anzahl_markt_wochen_kombis_abverkauf_sa_vj,
        a273_kassenumsatz_kl_absolut_brutto,
        kassenumsatz_af_kl_absolut_brutto,
        kassenumsatz_sa_kl_absolut_brutto,
        kassenumsatz_kl_absolut_brutto_vj,
        kassenumsatz_af_kl_absolut_brutto_vj,
        kassenumsatz_sa_kl_absolut_brutto_vj,
        a21_kassenumsatz_kl_absolut_netto,
        kassenumsatz_af_kl_absolut_netto,
        kassenumsatz_sa_kl_absolut_netto,
        kassenumsatz_kl_absolut_netto_vj,
        kassenumsatz_af_kl_absolut_netto_vj,
        kassenumsatz_sa_kl_absolut_netto_vj,
        a17_absatz_kl,
        absatz_af_kl,
        absatz_sa_kl,
        absatz_kl_vj,
        absatz_af_kl_vj,
        absatz_sa_kl_vj,
        a76_absatz_sst1,
        a78_absatz_sst2,
        a80_absatz_sst3,
        a82_absatz_sst4,
        a84_absatz_sst5,
        a86_absatz_sst6,
        a88_absatz_sst7,
        a62_absatz_ksst1,
        a64_absatz_ksst2,
        a66_absatz_ksst3,
        a68_absatz_ksst4,
        a70_absatz_ksst5,
        a72_absatz_ksst6,
        a74_absatz_ksst7,
        a90_absatz_ost_basis,
        a92_absatz_ost_gross,
        a94_absatz_sued_ost,
        a96_absatz_sued_west,
        a98_absatz_west,
        a100_absatz_nord,
        markt_wochen_sst1,
        markt_wochen_sst2,
        markt_wochen_sst3,
        markt_wochen_sst4,
        markt_wochen_sst5,
        markt_wochen_sst6,
        markt_wochen_sst7,
        markt_wochen_ksst1,
        markt_wochen_ksst2,
        markt_wochen_ksst3,
        markt_wochen_ksst4,
        markt_wochen_ksst5,
        markt_wochen_ksst6,
        markt_wochen_ksst7,
        markt_wochen_ost_basis,
        markt_wochen_ost_gross,
        markt_wochen_sued_ost,
        markt_wochen_sued_west,
        markt_wochen_west,
        markt_wochen_nord,
        anzahl_markt_wochen_kombis_abverkauf_mit_listung,
        anzahl_markt_wochen_kombis_listung,
        a31_vk_brutto_kl_pk_1,
        a333_vk_brutto_kl_pk_2,
        a54_vk_brutto_kl_pk_3,
        a334_vk_brutto_kl_pk_4,
        a432_vk_brutto_kl_pk_5,
        a433_vk_brutto_kl_pk_6,
        a434_vk_brutto_kl_pk_7,
        a435_vk_brutto_kl_pk_8,
        a436_vk_brutto_kl_pk_9,
        a437_vk_brutto_kl_pk_10,
        a30_kb_olk_ek4ndz_stamm,
        a23_rohertrag_ekmep_olk_4n,
        a51_listung_sst_pflege,
        a52_listung_k_sst_pflege,
        a426_ost_basis_pflege,
        a427_ost_gross_pflege,
        a428_sued_ost_pflege,
        a429_sued_west_pflege,
        a430_west_pflege,
        a431_nord_pflege,
        a50_listungsaktion,
        a411_stk_rohertrag_pflege,
        a415_kannibalisierungsfaktor,
        a412_umsatz_brutto_hochrechnung,
        a413_absatz_hochrechnung,
        a414_rohertrag_hochrechnung,
        a36_gewichtete_distribution_nielsen,
        a32_umsatz_anteil_wgi_nielsen,
        a33_umsatz_anteil_wgi_kumuliert_nielsen,
        a34_vk_brutto_durchschnitt_nielsen,
        a35_umsatz_nielsen,
        anz_wochen_de_anz_monate_kmo_nielsen,
        absatz_nielsen,
        a376_kl_marktanteil_wg_nielsen,
        a380_marktanteilbewertung_nielsen,
        a377_durchschnitt_anz_maerkte_nielsen,
        a382_sales_units_absatz_verkaufsartikel_in_1000_nielsen,
        a383_sales_units_verkaufseinheiten_gl_in_1000_normiert_nielsen,
        a384_durchschn_preis_einheit_gl_normiert_nielsen,
        a385_numerische_distribution_nielsen,
        a386_inhaltsmengen_nielsen,
        a387_duft_geschmack_nielsen,
        a388_einheit_nielsen,
        eigenmarke_fg_nielsen,
        a39_listung_sst_mvke,
        a38_listung_k_sst_mvke,
        a40_ost_basis,
        a41_ost_gross,
        a42_sued_ost,
        a43_sued_west,
        a44_west,
        a45_nord,
        a37_listung_erster_markt,
        a59_anz_maerkte_sst,
        a449_anz_maerkte_k_sst,
        a46_max_anz_maerkte_sst,
        a47_max_anz_maerkte_k_sst,
        a53_anz_maerkte_listung_gesamt,
        a57_anz_maerkte_listung_einzel,
        anz_maerkte_baustein_sonstige,
        anz_bons_af,
        anz_bons_sa,
        anz_bons_gesamt,
        rohertrag_ekmep_olk_4n_vj,
        rohertrag_ekmep_olk_4n_af,
        rohertrag_ekmep_olk_4n_sa,
        rohertrag_ekmep_olk_4n_af_vj,
        rohertrag_ekmep_olk_4n_sa_vj,
        a381_preislagenverteilung,
        a27_totalabschriften_wert_netto_absolut,
        a313_preisabschriften_preisanderungen_wert_netto_absolut,
        totalabschriften_wert_netto_absolut_vj,
        preisabschriften_preisanderungen_wert_netto_absolut_vj,
        a402_kolli_la,
        a401_kolli_bst,
        a403_restlaufzeit_zl,
        a404_restlaufzeit_dz,
        a405_basismengeneinheit,
        a406_letzte_listungsanderung_sst_ksst,
        a407_verhandler,
        a408_display_komponente_kz,
        a409_kl_art_id_display,
        a416_artikelrolle_id,
        kassenumsatz_kl_absolut_netto_wg,
        anz_bons_tupel,
        restbon_summe,
        totalabschriften_wert_netto_absolut_wg,
        preisabschriften_preisanderungen_wert_netto_absolut_wg,
        anz_bons_af_markt_tag,
        anz_bons_sa_markt_tag,
        cpq_tupel,
        cp_bons_af,
        cp_bons_sa,
        umrech_faktor,
        lagerprozent,
        absatz_af_kl_listungswochen,
        absatz_af_kl_vj_listungswochen,
        absatz_sa_kl_listungswochen,
        absatz_sa_kl_vj_listungswochen,
        kassenumsatz_af_kl_absolut_netto_listungswochen,
        kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
        kassenumsatz_sa_kl_absolut_netto_listungswochen,
        kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
        rohertrag_ekmep_olk_4n_af_listungswochen,
        rohertrag_ekmep_olk_4n_af_vj_listungswochen,
        rohertrag_ekmep_olk_4n_sa_listungswochen,
        rohertrag_ekmep_olk_4n_sa_vj_listungswochen,
        a445_anz_tupel_listung_wgi,
        td_insert,
        td_update,
        sustain_concat,
        check_fg,
        tupel_typ,
        a471_marke_nielsen_bez,
        a516_veggy_split_nielsen_kz,
        a517_laktosefrei_nielsen_kz,
        a515_bio_organic_nielsen_kz,
        a518_glutenfrei_nielsen_kz,
        a510_muki_ek_kz,
        a511_muki_ek_kl_art_id_verkettung,
        a512_muki_wb_kz,
        a513_muki_wb_kl_art_id_verkettung,
        a519_umsatz_anteil_wg_nielsen,
        a520_umsatz_anteil_wg_kumuliert_nielsen,
        a521_inhalt_menge
    FROM `_dup_free_2`
);

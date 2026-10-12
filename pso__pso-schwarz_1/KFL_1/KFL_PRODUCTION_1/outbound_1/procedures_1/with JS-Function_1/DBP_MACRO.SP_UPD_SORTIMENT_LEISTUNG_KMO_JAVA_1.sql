CREATE OR REPLACE PROCEDURE `dbp_macro.sp_upd_sortiment_leistung_kmo_java`(
    in_mandant_id FLOAT64,
    in_matching_id FLOAT64,
    in_art_id FLOAT64,
    in_gtin STRING,
    in_stk_re_pflege STRING,
    in_vorschlag STRING,
    in_produktwissen_pflege STRING,
    in_lieferantenwissen_pflege STRING,
    in_listung_sst_pflege STRING,
    in_listung_k_sst_pflege STRING,
    in_kjmo FLOAT64,
    in_n_k_artikel FLOAT64,
    in_nl_art_bez STRING,
    in_kjwo_update FLOAT64,
    OUT result_msg STRING
)
BEGIN
   

    DECLARE var_matching_id FLOAT64;
    DECLARE var_art_id FLOAT64;
    DECLARE var_gtin STRING;
    DECLARE var_stk_re_pflege STRING;
    DECLARE var_vorschlag STRING;
    DECLARE var_vorschlag_hr STRING;
    DECLARE var_produktwissen_pflege STRING;
    DECLARE var_lieferantenwissen_pflege STRING;
    DECLARE var_listung_sst_pflege STRING;
    DECLARE var_listung_k_sst_pflege STRING;
    DECLARE var_kjmo FLOAT64;
    DECLARE var_n_k_artikel FLOAT64;
    DECLARE var_nl_art_bez STRING;
    DECLARE var_kjwo_update FLOAT64;
    DECLARE var_sst_tool_fg STRING;
    DECLARE var_special_nl INT64;

    SET var_matching_id = in_matching_id;
    SET var_art_id = in_art_id;
    SET var_gtin = in_gtin;
    SET var_stk_re_pflege = in_stk_re_pflege;
    SET var_vorschlag = in_vorschlag;
    SET var_vorschlag_hr = in_vorschlag;
    -- Replicating the exact mapping from the original script
    SET var_produktwissen_pflege = in_lieferantenwissen_pflege;
    SET var_lieferantenwissen_pflege = in_lieferantenwissen_pflege;
    SET var_listung_sst_pflege = in_listung_sst_pflege;
    SET var_listung_k_sst_pflege = in_listung_k_sst_pflege;
    SET var_kjmo = in_kjmo;
    SET var_n_k_artikel = in_n_k_artikel;
    SET var_nl_art_bez = in_nl_art_bez;
    SET var_kjwo_update = in_kjwo_update;

    IF COALESCE(var_listung_sst_pflege, '') != '' THEN
        SET var_special_nl = CAST(var_listung_sst_pflege AS INT64);
    ELSEIF COALESCE(var_listung_k_sst_pflege, '') != '' AND CAST(SUBSTR(var_listung_k_sst_pflege, 2, 1) AS INT64) IS NOT NULL THEN
        SET var_special_nl = CAST(SUBSTR(var_listung_k_sst_pflege, 2, 1) AS INT64);
    ELSE
        SET var_special_nl = 4;
    END IF;

    IF (COALESCE(var_listung_sst_pflege, '') = '') AND 
       (COALESCE(var_listung_k_sst_pflege, '') = '') AND 
       (COALESCE(var_produktwissen_pflege, '') = '') AND 
       (COALESCE(var_lieferantenwissen_pflege, '') = '') AND 
       (COALESCE(var_vorschlag, '') = '') THEN
       
        SET var_nl_art_bez = in_nl_art_bez;
        
    ELSE
        IF var_gtin IS NULL OR var_gtin NOT IN ('-9999', '-9998') THEN
            IF var_vorschlag = 'Zurücksetzen' THEN
                UPDATE `dbp_msi_data.tupel_mat_1` 
                SET a411_stk_rohertrag_pflege = NULL,
                    a50_listungsaktion = NULL,
                    a51_listung_sst_pflege = NULL,
                    a52_listung_k_sst_pflege = NULL,
                    a412_umsatz_brutto_hochrechnung = NULL,
                    a413_absatz_hochrechnung = NULL,
                    a414_rohertrag_hochrechnung = NULL
                WHERE matching_id = in_matching_id 
                  AND a425_kjmo = in_kjmo 
                  AND mandant_id = in_mandant_id 
                  AND a500_kjwo_update = in_kjwo_update;

                DELETE FROM `dbp_msi_data.erwartete_entwicklung_1`
                WHERE matching_id = in_matching_id 
                  AND kjmo = in_kjmo 
                  AND mandant_id = in_mandant_id;
                  
            ELSEIF var_vorschlag = 'Keine Veränderung setzen' THEN
                UPDATE `dbp_msi_data.tupel_mat_1` 
                SET a411_stk_rohertrag_pflege = NULL,
                    a50_listungsaktion = 'Keine Veränderung',
                    a51_listung_sst_pflege = NULL,
                    a52_listung_k_sst_pflege = NULL,
                    a412_umsatz_brutto_hochrechnung = NULL,
                    a413_absatz_hochrechnung = NULL,
                    a414_rohertrag_hochrechnung = NULL
                WHERE matching_id = in_matching_id 
                  AND a425_kjmo = in_kjmo 
                  AND mandant_id = in_mandant_id 
                  AND a500_kjwo_update = in_kjwo_update 
                  AND (a50_listungsaktion IS NULL OR a50_listungsaktion = '');
                  
            ELSEIF var_vorschlag = 'Keine Veränderung' THEN
                UPDATE `dbp_msi_data.tupel_mat_1` 
                SET a411_stk_rohertrag_pflege = NULL,
                    a50_listungsaktion = 'Keine Veränderung',
                    a51_listung_sst_pflege = NULL,
                    a52_listung_k_sst_pflege = NULL,
                    a412_umsatz_brutto_hochrechnung = NULL,
                    a413_absatz_hochrechnung = NULL,
                    a414_rohertrag_hochrechnung = NULL
                WHERE matching_id = in_matching_id 
                  AND a425_kjmo = in_kjmo 
                  AND mandant_id = in_mandant_id 
                  AND a500_kjwo_update = in_kjwo_update;
                  
            ELSEIF var_vorschlag = 'Keine Veränderung zurücksetzen' THEN
                UPDATE `dbp_msi_data.tupel_mat_1` 
                SET a50_listungsaktion = NULL
                WHERE matching_id = in_matching_id 
                  AND a425_kjmo = in_kjmo 
                  AND mandant_id = in_mandant_id 
                  AND a500_kjwo_update = in_kjwo_update 
                  AND a50_listungsaktion = 'Keine Veränderung';
                  
            ELSE
                IF var_vorschlag_hr IN ('Wiedereinlistung', 'Neulistung KL-Artikel_1', 'Einlistung') THEN
                    SET var_vorschlag_hr = 'Listung erweitern';
                END IF;

                IF var_vorschlag_hr = 'Einlistung Potenzial' THEN
                    SET var_vorschlag_hr = 'Einlistung Potenzialartikel';
                END IF;

                IF COALESCE(var_listung_sst_pflege, '') = '' AND COALESCE(var_listung_k_sst_pflege, '') = '' THEN
                    SET var_vorschlag_hr = 'Auslistung';
                END IF;

                UPDATE `dbp_msi_data.tupel_mat_1` 
                SET a411_stk_rohertrag_pflege = in_stk_re_pflege,
                    a51_listung_sst_pflege = TRIM(in_listung_sst_pflege),
                    a52_listung_k_sst_pflege = TRIM(var_listung_k_sst_pflege),
                    a50_listungsaktion = in_vorschlag
                WHERE matching_id = in_matching_id 
                  AND a425_kjmo = in_kjmo 
                  AND mandant_id = in_mandant_id 
                  AND a500_kjwo_update = in_kjwo_update;

                IF COALESCE(var_listung_sst_pflege, '') != '' OR COALESCE(var_listung_k_sst_pflege, '') != '' OR var_vorschlag_hr = 'Auslistung' THEN
                    
                    IF var_vorschlag_hr = 'Auslistung' THEN
                        SET var_listung_sst_pflege = '0';
                        SET var_listung_k_sst_pflege = 'K0';
                    END IF;

                    IF COALESCE(var_listung_sst_pflege, '') = '' AND COALESCE(var_listung_k_sst_pflege, '') = '' THEN
                        SET var_vorschlag_hr = 'Auslistung';
                        SET var_listung_sst_pflege = '0';
                        SET var_listung_k_sst_pflege = 'K0';
                    END IF;

                    IF COALESCE(var_listung_sst_pflege, '') = '' THEN
                        SET var_listung_sst_pflege = '-1';
                    END IF;

                    IF COALESCE(var_listung_k_sst_pflege, '') = '' THEN
                        SET var_listung_k_sst_pflege = 'KK';
                    END IF;

                    INSERT INTO `dbp_msi_data.sortiment_art_kmo_1` (mandant_id, art_id, gtin_id, status_1, kjwo_update)
                    SELECT a.mandant_id,
                           a.art_id,
                           MAX(CAST(CAST(a.gtin_id AS INT64) AS STRING)) AS gtin_id,
                           MAX(a.status_1) AS status_1,
                           CAST(in_kjwo_update AS INT64) AS kjwo_update
                    FROM `dbp_etl.art_matching_nielsen_per_kmo_1` a
                    WHERE a.art_matching_id = in_matching_id 
                      AND a.mandant_id = in_mandant_id 
                      AND CASE
                              WHEN a.status_1 <> 'N' AND a.list_kz = 'A' THEN 1
                              WHEN a.status_1 = 'N' THEN 1
                              ELSE 0
                          END = 1
                    GROUP BY 1, 2;

                    --------------------------------------------------------------------------------------------------------
                    --   (I) UPDATE FUER SORTIMENT_LEISTUNG_1 (K-Stufen)
                    --------------------------------------------------------------------------------------------------------
                    UPDATE `dbp_msi_data.tupel_mat_1` tm
                    SET a412_umsatz_brutto_hochrechnung = x2.umsatz,
                        a413_absatz_hochrechnung = x2.absatz,
                        a414_rohertrag_hochrechnung = CAST(x2.rohertrag AS NUMERIC),
                        a50_listungsaktion = CASE WHEN var_vorschlag_hr = 'Auslistung' THEN 'Auslistung' ELSE x2.vorschlag END 
                    FROM (
                        SELECT
                             CASE
                                WHEN CASE
                                         WHEN MAX(x.vorschlag_) <> 'dynamic' THEN MAX(x.vorschlag_)
                                         WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                                         WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                         ELSE 'SOLL-Listung = IST-Listung'
                                     END = 'SOLL-Listung = IST-Listung' THEN 0
                                ELSE COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END, 0)
                             END AS umsatz,
                             CASE
                               WHEN CASE
                                         WHEN MAX(x.vorschlag_) <> 'dynamic' THEN MAX(x.vorschlag_)
                                         WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                                         WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                         ELSE 'SOLL-Listung = IST-Listung'
                                    END = 'SOLL-Listung = IST-Listung' THEN 0
                               ELSE COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END, 0)
                             END AS absatz,
                             CASE
                               WHEN CASE
                                         WHEN MAX(x.vorschlag_) <> 'dynamic' THEN MAX(x.vorschlag_)
                                         WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                                         WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                                         WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                         ELSE 'SOLL-Listung = IST-Listung'
                                    END = 'SOLL-Listung = IST-Listung' THEN 0
                               ELSE COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END, 0)
                             END AS rohertrag,
                             SUM(x.anzahl_reduktion) AS anzahl_reduktion_,
                             SUM(x.anzahl_erweiterung) AS anzahl_erweiterung_,
                             MAX(x.vorschlag_) AS vorschlag__,
                             CASE
                                    WHEN MAX(x.vorschlag_) <> 'dynamic' THEN MAX(x.vorschlag_)
                                    WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                    WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                    WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                                    WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                                    WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                                    WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                                    WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                    ELSE 'SOLL-Listung = IST-Listung'
                             END AS vorschlag
                      FROM (-- K-Sicht fuer KL (SST)
                             SELECT a.mandant_id,
                                    a.art_id,
                                    MAX(b.status_1) AS status_1,
                                    MIN(a.list_kz) AS list_kz_,
                                    SUM(a.umsatz_hr) AS umsatz_,
                                    SUM(a.absatz_hr) AS absatz_,
                                    SUM(a.rohertrag_hr) AS rohertrag_,
                                    CAST(0 AS INT64) AS anzahl_reduktion,
                                    SUM(erweiterung_fg) AS anzahl_erweiterung,
                                    CASE 
                                       WHEN var_vorschlag_hr = 'Auslistung' THEN 'Auslistung' 
                                       WHEN MIN(a.list_kz) IN ('B','C1','C2','D1','D2') THEN 'Einlistung Kauflandartikel' 
                                       ELSE 'dynamic' 
                                    END AS vorschlag_
                             FROM `dbp_msi_data.kl_listung_kmo_1` a
                             JOIN `dbp_msi_data.sortiment_art_kmo_1` b
                                    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                             WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                               AND a.listung_art = 'Listung erweitern' 
                               AND a.kjwo_update = in_kjwo_update 
                               AND a.mandant_id = in_mandant_id 
                               AND a.sm_id_selected = CAST(NULLIF(TRIM(var_listung_sst_pflege), '') AS INT64) 
                               AND a.ksm_id IS NULL
                             GROUP BY 1,2
                             
                             UNION ALL
                             
                             SELECT a.mandant_id,
                                    a.art_id,
                                    MAX(b.status_1) AS status_1,
                                    MIN(a.list_kz) AS list_kz_,
                                    SUM(a.umsatz_hr) AS umsatz_,
                                    SUM(a.absatz_hr) AS absatz_,
                                    SUM(a.rohertrag_hr) AS rohertrag_,
                                    SUM(reduktion_fg) AS anzahl_reduktion,
                                    CAST(0 AS INT64) AS anzahl_erweiterung,
                                    CASE WHEN var_vorschlag_hr = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                             FROM `dbp_msi_data.kl_listung_kmo_1` a
                             JOIN `dbp_msi_data.sortiment_art_kmo_1` b
                                    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                             WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                               AND a.listung_art = 'Listung reduzieren' 
                               AND a.kjwo_update = in_kjwo_update 
                               AND a.mandant_id = in_mandant_id 
                               AND a.sm_id_selected = CAST(NULLIF(TRIM(var_listung_sst_pflege), '') AS INT64) 
                               AND a.sm_id < CAST(NULLIF(TRIM(var_listung_sst_pflege), '') AS INT64) 
                               AND a.ksm_id IS NULL
                             GROUP BY 1,2
                             
                             UNION ALL
                             
                             SELECT a.mandant_id,
                                    a.art_id,
                                    MAX(b.status_1) AS status_1,
                                    MIN(a.list_kz) AS list_kz_,
                                    SUM(a.umsatz_hr) AS umsatz_,
                                    SUM(a.absatz_hr) AS absatz_,
                                    SUM(a.rohertrag_hr) AS rohertrag_,
                                    CAST(0 AS INT64) AS anzahl_reduktion,
                                    SUM(erweiterung_fg) AS anzahl_erweiterung,
                                    CASE WHEN var_vorschlag_hr = 'Auslistung' THEN 'Auslistung' WHEN MIN(a.list_kz) IN ('B','C1','C2','D1','D2') THEN 'Einlistung Kauflandartikel' ELSE 'dynamic' END AS vorschlag_
                             FROM `dbp_msi_data.kl_listung_kmo_1` a
                             JOIN `dbp_msi_data.sortiment_art_kmo_1` b 
                                    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                             WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                               AND a.listung_art = 'Listung erweitern' 
                               AND a.kjwo_update = in_kjwo_update 
                               AND a.mandant_id = in_mandant_id 
                               AND TRIM(a.ksm_id_selected) = TRIM(var_listung_k_sst_pflege) 
                               AND a.sm_id IS NULL
                             GROUP BY 1,2
                             
                             UNION ALL
                             
                             SELECT a.mandant_id,
                                    a.art_id,
                                    MAX(b.status_1) AS status_1,
                                    MIN(a.list_kz) AS list_kz_,
                                    SUM(a.umsatz_hr) AS umsatz_,
                                    SUM(a.absatz_hr) AS absatz_,
                                    SUM(a.rohertrag_hr) AS rohertrag_,
                                    SUM(reduktion_fg) AS anzahl_reduktion,
                                    CAST(0 AS INT64) AS anzahl_erweiterung,
                                    CASE WHEN var_vorschlag_hr = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                             FROM `dbp_msi_data.kl_listung_kmo_1` a
                             JOIN `dbp_msi_data.sortiment_art_kmo_1` b 
                                    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                             WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                               AND a.listung_art = 'Listung reduzieren' 
                               AND a.kjwo_update = in_kjwo_update 
                               AND a.mandant_id = in_mandant_id 
                               AND TRIM(a.ksm_id_selected) = TRIM(var_listung_k_sst_pflege) 
                               AND CAST(SUBSTR(TRIM(a.ksm_id), 2, 1) AS INT64) < CAST(SUBSTR(TRIM(var_listung_k_sst_pflege), 2, 1) AS INT64) 
                               AND a.sm_id IS NULL
                             GROUP BY 1,2
                             
                             UNION ALL
                             
                             SELECT a.mandant_id,
                                    a.art_id,
                                    MAX(b.status_1) AS status_1,
                                    MIN(a.list_kz) AS list_kz_,
                                    SUM(a.umsatz_hr) AS umsatz_,
                                    SUM(a.absatz_hr) AS absatz_,
                                    SUM(a.rohertrag_hr) AS rohertrag_,
                                    SUM(reduktion_fg) AS anzahl_reduktion,
                                    CAST(0 AS INT64) AS anzahl_erweiterung,
                                    CASE WHEN var_vorschlag_hr = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                             FROM `dbp_msi_data.kl_listung_kmo_1` a
                             JOIN `dbp_msi_data.sortiment_art_kmo_1` b 
                                    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                             WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                               AND a.listung_art = 'Auslistung' 
                               AND a.kjwo_update = in_kjwo_update 
                               AND a.mandant_id = in_mandant_id 
                               AND a.sm_id_selected = CAST(NULLIF(TRIM(var_listung_sst_pflege), '') AS INT64) 
                               AND a.ksm_id IS NULL
                             GROUP BY 1,2
                             
                             UNION ALL
                             
                             SELECT a.mandant_id,
                                    a.art_id,
                                    MAX(b.status_1) AS status_1,
                                    MIN(a.list_kz) AS list_kz_,
                                    SUM(a.umsatz_hr) AS umsatz_,
                                    SUM(a.absatz_hr) AS absatz_,
                                    SUM(a.rohertrag_hr) AS rohertrag_,
                                    SUM(reduktion_fg) AS anzahl_reduktion,
                                    CAST(0 AS INT64) AS anzahl_erweiterung,
                                    CASE WHEN var_vorschlag_hr = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                             FROM `dbp_msi_data.kl_listung_kmo_1` a
                             JOIN `dbp_msi_data.sortiment_art_kmo_1` b 
                                    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                             WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                               AND a.listung_art = 'Auslistung' 
                               AND a.kjwo_update = in_kjwo_update 
                               AND a.mandant_id = in_mandant_id 
                               AND TRIM(a.ksm_id_selected) = TRIM(var_listung_k_sst_pflege) 
                               AND a.sm_id IS NULL
                             GROUP BY 1,2
                             
                             UNION ALL
                             
                             SELECT a.mandant_id,
                                    1 AS art_id,
                                    'N' AS status_1,
                                    'A' AS list_kz,
                                    SUM(a.umsatz_hr) AS umsatz_,
                                    SUM(a.absatz_hr) AS absatz_,
                                    SUM(a.absatz_hr) * CAST(REPLACE(var_stk_re_pflege, ',', '.') AS FLOAT64) AS rohertrag_,
                                    CAST(0 AS INT64) AS anzahl_reduktion,
                                    COUNT(*) AS anzahl_erweiterung,
                                    'Einlistung Potenzialartikel' AS vorschlag_
                             FROM `dbp_msi_data.nl_listung_kmo_1` a
                             WHERE a.gtin NOT IN (SELECT CAST(CAST(gtin_id AS INT64) AS STRING) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                               AND a.gtin = in_gtin 
                               AND a.listung_art = 'Einlistung Potenzialartikel' 
                               AND a.kjwo_update = in_kjwo_update 
                               AND a.art_nielsen_bez = in_nl_art_bez 
                               AND a.sm_id_selected = var_special_nl
                             GROUP BY 1,2
                        ) x
                    ) x2
                    WHERE (tm.art_id = in_art_id AND tm.a425_kjmo = in_kjmo AND tm.mandant_id = in_mandant_id AND tm.a500_kjwo_update = in_kjwo_update) 
                       OR (--tm.gtin = in_gtin AND 
                       tm.a425_kjmo = in_kjmo AND tm.mandant_id = in_mandant_id AND tm.nielsen_art_bez = in_nl_art_bez AND tm.a500_kjwo_update = in_kjwo_update);

                    UPDATE `dbp_msi_data.tupel_mat_1` t
                    SET a50_listungsaktion = z.a50_listungsaktion 
                    FROM (
                        SELECT CASE
                                   WHEN a50_listungsaktion = 'Auslistung' THEN a50_listungsaktion
                                   WHEN (a51_listung_sst_pflege <> 'N/A' OR a52_listung_k_sst_pflege <> 'N/A') AND
                                         a449_anz_maerkte_k_sst = 0 AND a59_anz_maerkte_sst = 0 AND
                                         anz_maerkte_baustein_sonstige = 0 AND
                                         a57_anz_maerkte_listung_einzel = 0 AND
                                         a53_anz_maerkte_listung_gesamt = 0 THEN 'Einlistung Kauflandartikel'
                                   ELSE a50_listungsaktion
                               END AS a50_listungsaktion
                        FROM `dbp_msi_data.tupel_mat_1`
                        WHERE mandant_id = in_mandant_id 
                          AND art_id IS NOT NULL 
                          AND a425_kjmo = in_kjmo 
                          AND a500_kjwo_update = in_kjwo_update 
                          AND matching_id = in_matching_id
                    ) z
                    WHERE t.mandant_id = in_mandant_id 
                      AND t.a425_kjmo = in_kjmo 
                      AND t.a500_kjwo_update = in_kjwo_update 
                      AND t.matching_id = in_matching_id;

                    --------------------------------------------------------------------------------------------------------
                    --   (II) INSERT FUER ERWARTETE ENTWICKLUNG (K-Stufen)
                    --------------------------------------------------------------------------------------------------------
                    IF COALESCE(var_vorschlag_hr, '') != 'Keine Veränderung' THEN
                        DELETE FROM `dbp_msi_data.erwartete_entwicklung_1`
                        WHERE matching_id = in_matching_id 
                          AND kjmo = in_kjmo 
                          AND mandant_id = in_mandant_id;
                          
                        INSERT INTO `dbp_msi_data.erwartete_entwicklung_1` (mandant_id, kjmo, matching_id, kjwo_update, wrg_id, kl_wg_id, kl_owg_id, kl_uwg_id, owg_id, wg_id, wug_id, sm_id, ksm_id, umsatz_hr, absatz_hr, rohertrag_hr)
                        SELECT CAST(in_mandant_id AS INT64),
                               CAST(in_kjmo AS INT64) AS kjmo,
                               CAST(in_matching_id AS INT64),
                               CAST(in_kjwo_update AS INT64) AS kjwo_update,
                               z3.default_wrg AS wrg_id,
                               y3.kl_wg_id,
                               y3.kl_owg_id,
                               y3.kl_uwg_id,
                               y3.kl_wg_id AS owg_id,
                               y3.kl_owg_id AS wg_id,
                               y3.kl_uwg_id AS wug_id,
                               x3.sm_id,
                               x3.ksm_id,
                               COALESCE(SUM(x3.umsatz_)/CASE WHEN MAX(x3.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x3.art_id) END, 0) AS umsatz,
                               COALESCE(SUM(x3.absatz_)/CASE WHEN MAX(x3.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x3.art_id) END, 0) AS absatz,
                               COALESCE(SUM(x3.rohertrag_)/CASE WHEN MAX(x3.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x3.art_id) END, 0) AS rohertrag
                        FROM (
                            -- K-Sicht fuer KL (SST)
                            SELECT in_mandant_id AS mandant_id,
                                   in_matching_id AS matching_id,
                                   a4.sm_id,
                                   '  ' AS ksm_id,
                                   a4.art_id,
                                   MAX(b4.status_1) AS status_1,
                                   SUM(a4.umsatz_hr) AS umsatz_,
                                   SUM(a4.absatz_hr) AS absatz_,
                                   SUM(a4.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_kmo_1` a4
                            JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id
                            WHERE (a4.mandant_id, a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                              AND a4.listung_art = 'Listung erweitern' 
                              AND a4.kjwo_update = in_kjwo_update 
                              AND a4.mandant_id = in_mandant_id 
                              AND a4.sm_id_selected = CAST(NULLIF(TRIM(var_listung_sst_pflege), '') AS INT64) 
                              AND a4.ksm_id IS NULL
                            GROUP BY 1,2,3,4,5
                            HAVING umsatz_ <> 0
                            
                            UNION ALL
                            
                            SELECT in_mandant_id AS mandant_id,
                                   in_matching_id AS matching_id,
                                   a4.sm_id,
                                   '  ' AS ksm_id,
                                   a4.art_id,
                                   MAX(b4.status_1) AS status_1,
                                   SUM(a4.umsatz_hr) AS umsatz_,
                                   SUM(a4.absatz_hr) AS absatz_,
                                   SUM(a4.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_kmo_1` a4
                            JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id
                            WHERE (a4.mandant_id, a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                              AND a4.listung_art = 'Listung reduzieren' 
                              AND a4.kjwo_update = in_kjwo_update 
                              AND a4.mandant_id = in_mandant_id 
                              AND a4.sm_id_selected = CAST(NULLIF(TRIM(var_listung_sst_pflege), '') AS INT64) 
                              AND a4.sm_id < CAST(NULLIF(TRIM(var_listung_sst_pflege), '') AS INT64) 
                              AND a4.ksm_id IS NULL
                            GROUP BY 1,2,3,4,5
                            HAVING umsatz_ <> 0
                            
                            UNION ALL
                            
                            SELECT in_mandant_id AS mandant_id,
                                   in_matching_id AS matching_id,
                                   -1 AS sm_id,
                                   TRIM(a4.ksm_id) AS ksm_id,
                                   a4.art_id,
                                   MAX(b4.status_1) AS status_1,
                                   SUM(a4.umsatz_hr) AS umsatz_,
                                   SUM(a4.absatz_hr) AS absatz_,
                                   SUM(a4.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_kmo_1` a4
                            JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id
                            WHERE (a4.mandant_id, a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                              AND a4.listung_art = 'Listung erweitern' 
                              AND a4.kjwo_update = in_kjwo_update 
                              AND a4.mandant_id = in_mandant_id 
                              AND TRIM(a4.ksm_id_selected) = TRIM(var_listung_k_sst_pflege) 
                              AND a4.sm_id IS NULL
                            GROUP BY 1,2,3,4,5
                            HAVING umsatz_ <> 0
                            
                            UNION ALL
                            
                            SELECT in_mandant_id AS mandant_id,
                                   in_matching_id AS matching_id,
                                   -1 AS sm_id,
                                   TRIM(a4.ksm_id) AS ksm_id,
                                   a4.art_id,
                                   MAX(b4.status_1) AS status_1,
                                   SUM(a4.umsatz_hr) AS umsatz_,
                                   SUM(a4.absatz_hr) AS absatz_,
                                   SUM(a4.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_kmo_1` a4
                            JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id
                            WHERE (a4.mandant_id, a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                              AND a4.listung_art = 'Listung reduzieren' 
                              AND a4.kjwo_update = in_kjwo_update 
                              AND a4.mandant_id = in_mandant_id 
                              AND TRIM(a4.ksm_id_selected) = TRIM(var_listung_k_sst_pflege) 
                              AND CAST(SUBSTR(TRIM(a4.ksm_id), 2, 1) AS INT64) < CAST(SUBSTR(TRIM(var_listung_k_sst_pflege), 2, 1) AS INT64) 
                              AND a4.sm_id IS NULL
                            GROUP BY 1,2,3,4,5
                            HAVING umsatz_ <> 0
                            
                            UNION ALL
                            
                            SELECT in_mandant_id AS mandant_id,
                                   in_matching_id AS matching_id,
                                   -1 AS sm_id,
                                   TRIM(a4.ksm_id) AS ksm_id,
                                   a4.art_id,
                                   MAX(b4.status_1) AS status_1,
                                   SUM(a4.umsatz_hr) AS umsatz_,
                                   SUM(a4.absatz_hr) AS absatz_,
                                   SUM(a4.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_kmo_1` a4
                            JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id
                            WHERE (a4.mandant_id, a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                              AND a4.listung_art = 'Auslistung' 
                              AND a4.kjwo_update = in_kjwo_update 
                              AND a4.mandant_id = in_mandant_id 
                              AND TRIM(a4.ksm_id_selected) = TRIM(var_listung_k_sst_pflege) 
                              AND a4.sm_id IS NULL
                            GROUP BY 1,2,3,4,5
                            HAVING umsatz_ <> 0
                            
                            UNION ALL
                            
                            SELECT in_mandant_id AS mandant_id,
                                   in_matching_id AS matching_id,
                                   a4.sm_id,
                                   '  ' AS ksm_id,
                                   a4.art_id,
                                   MAX(b4.status_1) AS status_1,
                                   SUM(a4.umsatz_hr) AS umsatz_,
                                   SUM(a4.absatz_hr) AS absatz_,
                                   SUM(a4.rohertrag_hr) AS rohertrag_
                            FROM `dbp_msi_data.kl_listung_kmo_1` a4
                            JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id
                            WHERE (a4.mandant_id, a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) 
                              AND a4.listung_art = 'Auslistung' 
                              AND a4.kjwo_update = in_kjwo_update 
                              AND a4.mandant_id = in_mandant_id 
                              AND a4.sm_id_selected = CAST(NULLIF(TRIM(var_listung_sst_pflege), '') AS INT64) 
                              AND a4.ksm_id IS NULL
                            GROUP BY 1,2,3,4,5
                            HAVING umsatz_ <> 0
                        ) x3
                        JOIN (SELECT mandant_id, art_matching_id, MAX(kl_wg_id) AS kl_wg_id, MAX(kl_owg_id) AS kl_owg_id, MAX(kl_uwg_id) AS kl_uwg_id
                              FROM `dbp_etl.art_matching_nielsen_per_kmo_1`
                              GROUP BY 1,2) y3 
                              ON x3.matching_id = y3.art_matching_id AND x3.mandant_id = y3.mandant_id
                        JOIN `dbp_data.mandant_1` z3 ON in_mandant_id = z3.mandant_id
                        GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13;
                    END IF;
                    
                    DELETE FROM `dbp_msi_data.sortiment_art_kmo_1`
                    WHERE (mandant_id, art_id, CAST(gtin_id AS STRING), kjwo_update) IN (
                        SELECT DISTINCT ( a.mandant_id,
                               a.art_id,
                               CAST(CAST(a.gtin_id AS INT64) AS STRING) ,
                               CAST(in_kjwo_update AS INT64) )
                        FROM `dbp_etl.art_matching_nielsen_per_kmo_1` a
                        WHERE a.art_matching_id = in_matching_id 
                          AND a.mandant_id = in_mandant_id
                    );
                END IF;
            END IF;
            
            -- This explicitly captures the inner dead-code loop from the original JS exactly as built structurally. 
            IF var_vorschlag = 'Zurücksetzen' THEN
                DELETE FROM `dbp_data.art_kl_preislage_zu_per_neu_1`
                WHERE kjmo = in_kjmo 
                  AND kjwo_update = in_kjwo_update 
                  AND art_matching_id = in_matching_id 
                  AND mandant_id = in_mandant_id;

                INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_1` 
                SELECT *
                FROM `dbp_data.art_kl_preislage_zu_per_1`
                WHERE kjmo = in_kjmo 
                  AND kjwo_update = in_kjwo_update 
                  AND art_matching_id = in_matching_id 
                  AND mandant_id = in_mandant_id;
            ELSE
                INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_1` (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id, sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa)
                SELECT a.mandant_id,
                       a.matching_id AS art_matching_id,
                       a.a425_kjmo,
                       a.a500_kjwo_update,
                       x.default_wrg AS wrg_id,
                       TRIM(CAST(b.k AS STRING)) AS sm_id,
                       '' AS ksm_id,
                       a.a5_owg_id,
                       a.a7_wg_id,
                       a.wug_id,
                       a.a31_vk_brutto_kl_pk_1 AS vk_brutto_pk_1,
                       a.a34_vk_brutto_durchschnitt_nielsen AS durchschnitt_preis_kasse,
                       c.umsatz_brutto,
                       c.umsatz_brutto_af,
                       c.umsatz_brutto_sa,
                       c.menge,
                       c.menge_af,
                       c.menge_sa
                FROM `dbp_msi_data.tupel_mat_1` a
                JOIN `dbp_data.art_kl_preislage_zu_per_neu_1` c ON a.mandant_id = c.mandant_id AND a.a425_kjmo = c.kjmo AND a.matching_id = c.art_matching_id AND a.a39_listung_sst_mvke = c.sm_id
                JOIN (SELECT wtag_id AS k FROM `dbp_data.tag_1` WHERE wtag_id BETWEEN 1 AND 5 GROUP BY 1) b ON CAST(TRIM(a.a51_listung_sst_pflege) AS INT64) <= b.k AND b.k < CASE WHEN a.a39_listung_sst_mvke = 'N/A' THEN 6 ELSE CAST(a.a39_listung_sst_mvke AS INT64) END
                JOIN `dbp_data.mandant_1` x ON a.mandant_id = x.mandant_id
                WHERE a.a412_umsatz_brutto_hochrechnung IS NOT NULL 
                  AND a.mandant_id = in_mandant_id 
                  AND a.a425_kjmo IN (SELECT kjmo FROM `dbp_data.monat_1` WHERE kjmo = in_kjmo) 
                  AND a.a50_listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') 
                  AND (a.mandant_id, a.matching_id, a.a425_kjmo, b.k) NOT IN (
                      SELECT (mandant_id, art_matching_id, kjmo, CAST(sm_id AS INT64) ) 
                      FROM `dbp_data.art_kl_preislage_zu_per_neu_1` 
                      WHERE sm_id NOT IN ('N/A','-1') 
                        AND mandant_id = in_mandant_id
                  );

                INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_1` (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id, sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa)
                SELECT a.mandant_id,
                       a.matching_id AS art_matching_id,
                       a.a425_kjmo,
                       a.a500_kjwo_update,
                       x.default_wrg AS wrg_id,
                       TRIM(CAST(b.k AS STRING)) AS sm_id,
                       '' AS ksm_id,
                       a.a5_owg_id,
                       a.a7_wg_id,
                       a.wug_id,
                       a.a31_vk_brutto_kl_pk_1 AS vk_brutto_pk_1,
                       a.a34_vk_brutto_durchschnitt_nielsen AS durchschnitt_preis_kasse,
                       c.umsatz_brutto,
                       c.umsatz_brutto_af,
                       c.umsatz_brutto_sa,
                       c.menge,
                       c.menge_af,
                       c.menge_sa
                FROM `dbp_msi_data.tupel_mat_1` a
                JOIN `dbp_data.art_kl_preislage_zu_per_neu_1` c ON a.mandant_id = c.mandant_id AND a.a425_kjmo = c.kjmo AND a.matching_id = c.art_matching_id AND a.a38_listung_k_sst_mvke = c.ksm_id
                JOIN (SELECT akt_tag AS k FROM `dbp_data.tag_1` WHERE akt_tag BETWEEN 1 AND 9 GROUP BY 1) b ON CAST(TRIM(SUBSTR(a.a52_listung_k_sst_pflege, 2, 1)) AS INT64) <= b.k AND b.k < CASE WHEN a.a38_listung_k_sst_mvke = 'N/A' THEN 10 ELSE CAST(SUBSTR(a.a38_listung_k_sst_mvke, 2, 1) AS INT64) END
                JOIN `dbp_data.mandant_1` x ON a.mandant_id = x.mandant_id
                WHERE a.a412_umsatz_brutto_hochrechnung IS NOT NULL 
                  AND a.mandant_id = in_mandant_id 
                  AND a.a425_kjmo IN (SELECT kjmo FROM `dbp_data.monat_1` WHERE kjmo = in_kjmo) 
                  AND a.a50_listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') 
                  AND (a.mandant_id, a.matching_id, a.a425_kjmo, b.k) NOT IN (
                      SELECT ( mandant_id, art_matching_id, kjmo, CAST(SUBSTR(ksm_id, 2, 1) AS INT64) ) 
                      FROM `dbp_data.art_kl_preislage_zu_per_neu_1` 
                      WHERE ksm_id NOT IN ('') 
                        AND mandant_id = in_mandant_id
                  );

                INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_1` (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id, sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa)
                SELECT a.mandant_id,
                       a.matching_id AS art_matching_id,
                       a.a425_kjmo,
                       a.a500_kjwo_update,
                       x.default_wrg AS wrg_id,
                       '-1' AS sm_id,
                       CONCAT('K', TRIM(CAST(b.k AS STRING))) AS ksm_id,
                       a.a5_owg_id,
                       a.a7_wg_id,
                       a.wug_id,
                       a.a31_vk_brutto_kl_pk_1 AS vk_brutto_pk_1,
                       a.a34_vk_brutto_durchschnitt_nielsen AS durchschnitt_preis_kasse,
                       c.umsatz_brutto,
                       c.umsatz_brutto_af,
                       c.umsatz_brutto_sa,
                       c.menge,
                       c.menge_af,
                       c.menge_sa
                FROM `dbp_msi_data.tupel_mat_1` a
                JOIN `dbp_data.art_kl_preislage_zu_per_neu_1` c ON a.mandant_id = c.mandant_id AND a.a500_kjwo_update = c.kjwo_update AND a.matching_id = c.art_matching_id AND a.a38_listung_k_sst_mvke = c.ksm_id
                JOIN (SELECT akt_tag AS k FROM `dbp_data.tag_1` WHERE akt_tag BETWEEN 1 AND 9 GROUP BY 1) b ON CAST(TRIM(SUBSTR(COALESCE(a.a52_listung_k_sst_pflege, 'K9'), 2, 1)) AS INT64) <= b.k AND b.k < CAST(SUBSTR(COALESCE(a.a38_listung_k_sst_mvke, 'K9'), 2, 1) AS INT64)
                JOIN `dbp_data.mandant_1` x ON a.mandant_id = x.mandant_id
                WHERE a.a412_umsatz_brutto_hochrechnung IS NOT NULL 
                  AND a.mandant_id = in_mandant_id 
                  AND a.a500_kjwo_update = in_kjwo_update 
                  AND a.a50_listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') 
                  AND (a.mandant_id, a.matching_id, a.a500_kjwo_update, b.k) NOT IN (
                      SELECT (mandant_id, art_matching_id, kjwo_update, CAST(SUBSTR(ksm_id, 2, 1) AS INT64) )
                      FROM `dbp_data.art_kl_preislage_zu_per_neu_1` 
                      WHERE ksm_id IS NOT NULL 
                        AND ksm_id <> '' 
                        AND kjwo_update = in_kjwo_update 
                        AND mandant_id = in_mandant_id
                  );

                DELETE FROM `dbp_data.art_kl_preislage_zu_per_neu_1`
                WHERE (mandant_id, art_matching_id, kjmo, ksm_id, kjwo_update) IN (
                    SELECT (a.mandant_id,
                           a.matching_id,
                           a.a425_kjmo,
                           CONCAT('K', CAST(b.k AS STRING)),
                           a.a500_kjwo_update )
                    FROM `dbp_msi_data.tupel_mat_1` a
                    JOIN (SELECT akt_tag AS k FROM `dbp_data.tag_1` WHERE akt_tag BETWEEN 1 AND 9 GROUP BY 1) b ON CAST(SUBSTR(COALESCE(a.a52_listung_k_sst_pflege, 'K9'), 2, 1) AS INT64) > b.k AND b.k <= CAST(SUBSTR(COALESCE(a.a38_listung_k_sst_mvke, 'K9'), 2, 1) AS INT64)
                    WHERE a.a500_kjwo_update = in_kjwo_update 
                      AND a.a412_umsatz_brutto_hochrechnung IS NOT NULL 
                      AND a.mandant_id = in_mandant_id 
                      AND a.a50_listungsaktion IN ('Listung reduzieren','Listung reduzieren und erweitern','Listung erweitern und reduzieren')
                );

                INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_1` (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id, sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa)
                SELECT a.mandant_id,
                       a.matching_id AS art_matching_id,
                       a.a425_kjmo,
                       a.a500_kjwo_update,
                       x.default_wrg AS wrg_id,
                       '-1' AS sm_id,
                       CONCAT('K', TRIM(CAST(b.k AS STRING))) AS ksm_id,
                       a.a5_owg_id,
                       a.a7_wg_id,
                       a.wug_id,
                       a.a31_vk_brutto_kl_pk_1 AS vk_brutto_pk_1,
                       a.a34_vk_brutto_durchschnitt_nielsen AS durchschnitt_preis_kasse,
                       c.umsatz_brutto,
                       c.umsatz_brutto_af,
                       c.umsatz_brutto_sa,
                       c.menge,
                       c.menge_af,
                       c.menge_sa
                FROM `dbp_msi_data.tupel_mat_1` a
                JOIN `dbp_data.art_nielsen_preislage_zu_per_1` c ON a.mandant_id = c.mandant_id AND a.a425_kjmo = c.kjmo AND a.matching_id = c.art_matching_id AND a.a500_kjwo_update = in_kjwo_update
                JOIN (SELECT akt_tag AS k FROM `dbp_data.tag_1` WHERE akt_tag BETWEEN 1 AND 9 GROUP BY 1) b ON CAST(TRIM(SUBSTR(COALESCE(a.a52_listung_k_sst_pflege, 'K9'), 2, 1)) AS INT64) <= b.k
                JOIN `dbp_data.mandant_1` x ON a.mandant_id = x.mandant_id
                WHERE a.a412_umsatz_brutto_hochrechnung IS NOT NULL 
                  AND a.mandant_id = in_mandant_id 
                  AND a.a500_kjwo_update = in_kjwo_update 
                  AND a.a50_listungsaktion = 'Einlistung Potenzialartikel' 
                  AND (a.mandant_id, a.matching_id, a.a500_kjwo_update, b.k) NOT IN (
                      SELECT (mandant_id, art_matching_id, kjwo_update, CAST(SUBSTR(ksm_id, 2, 1) AS INT64) )
                      FROM `dbp_data.art_kl_preislage_zu_per_neu_1` 
                      WHERE ksm_id IS NOT NULL 
                        AND ksm_id <> '' 
                        AND kjwo_update = in_kjwo_update 
                        AND mandant_id = in_mandant_id
                  );

                DELETE FROM `dbp_data.art_kl_preislage_zu_per_neu_1`
                WHERE (mandant_id, art_matching_id, kjwo_update) IN (
                    SELECT (a.mandant_id, a.matching_id, a.a500_kjwo_update )
                    FROM `dbp_msi_data.tupel_mat_1` a
                    WHERE a.a500_kjwo_update = in_kjwo_update 
                      AND a.mandant_id = in_mandant_id 
                      AND a.a412_umsatz_brutto_hochrechnung IS NOT NULL 
                      AND a.a50_listungsaktion = 'Auslistung'
                );
            END IF;
        END IF;
    END IF;

    UPDATE `dbp_msi_data.tupel_mat_1` 
    SET a50_listungsaktion = CASE
        WHEN a50_listungsaktion = 'Keine Listungsaktion'             THEN '0'
        WHEN a50_listungsaktion = 'Keine Veränderung'                THEN '1'
        WHEN a50_listungsaktion = 'nicht möglich'                    THEN '2'
        WHEN a50_listungsaktion = 'SOLL-Listung = IST-Listung'       THEN '3'
        WHEN a50_listungsaktion = 'Neulistung KL-Artikel_1'            THEN '4'
        WHEN a50_listungsaktion = 'Einlistung Kauflandartikel'       THEN '5'
        WHEN a50_listungsaktion = 'Einlistung Potenzialartikel'      THEN '6'
        WHEN a50_listungsaktion = 'Auslistung'                       THEN '7'
        WHEN a50_listungsaktion = 'Listung erweitern'                THEN '8'
        WHEN a50_listungsaktion = 'Listung reduzieren'               THEN '9'
        WHEN a50_listungsaktion = 'Listung erweitern und reduzieren' THEN '10'
        WHEN a50_listungsaktion = 'Listung reduzieren und erweitern' THEN '11'
        ELSE a50_listungsaktion
    END
    WHERE a500_kjwo_update = in_kjwo_update 
      AND mandant_id = in_mandant_id;

    IF var_gtin IN ('-9999', '-9998') THEN
        UPDATE `dbp_msi_data.tupel_mat_1` 
        SET a50_listungsaktion = '13'
        WHERE a500_kjwo_update = in_kjwo_update 
          AND mandant_id = in_mandant_id 
          AND matching_id = in_matching_id;
    END IF;

    UPDATE `dbp_msi_data.tupel_mat_1` 
    SET a50_listungsaktion = '12'
    WHERE a500_kjwo_update = in_kjwo_update 
      AND in_kjwo_update NOT IN (SELECT kjwo_update FROM `dbp_msi_data.nl_listung_kmo_1`) 
      AND mandant_id = in_mandant_id 
      AND matching_id = in_matching_id;
      
    SET result_msg = 'Success';
END;
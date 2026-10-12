CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.mv_art_nielsen_wug_zu_pflege 
--filter auf kjwo_update ist wichtig, Service Layer kennt nur MATs ab 202001, wenn was von davor kommt kracht es
(
    mandant_id
    ,art_nielsen_id
    ,art_nielsen_bez
    ,wg_id
    ,wug_id
    ,nielsen_abteilung_bez
    ,nielsen_wg_bez
    ,nielsen_uwg1_bez
    ,nielsen_uwg2_bez
    ,wg_id_vorschl
    ,wug_id_vorschl
    ,gtin_id
    ,umsatz_nielsen
    ,rang_umsatz_owg
    ,A36_gewichtete_distribution
    ,kjmo_date
    ,wo_dat_von
    ,wo_dat_von_vj
    ,kjmo_datenstand
    ,datenstand
    ,a425_kjmo_date
    ,Umsatz_6Monate
) AS
SELECT
    v01.mandant_id
    ,v01.art_nielsen_id
    ,v01.art_nielsen_bez
    ,v01.fb_pflege_wg_id
    ,v01.fb_pflege_wug_id
    ,v01.nielsen_abteilung_bez
    ,v01.nielsen_wg_bez
    ,v01.nielsen_uwg1_bez
    ,v01.nielsen_uwg2_bez
    ,v01.kalk_vorschl_wg_id
    ,v01.kalk_vorschl_wug_id
    ,v02.gtin_id
    ,v03.a35_umsatz_nielsen
    ,v03.a58_rang_umsatz_owg
    ,CAST(v03.A36_gewichtete_distribution_nielsen AS DECIMAL(18, 1))  AS A36_gewichtete_distribution
,CASE
        WHEN nf.kjmo > 0 THEN TO_DATE(CAST(nf.kjmo AS VARCHAR(8)), 'YYYYMM')
    END AS kjmo_date
    ,nf_w.wo_dat_von
    ,nf_w.wo_dat_von - 364 AS wo_dat_von_vj
    ,v03.a425_kjmo
    ,CONCAT('Datenstand MAT ', MONTHNAME(TO_DATE(CAST(v03.a425_kjmo AS VARCHAR(8)), 'YYYYMM')),' ',SUBSTR(v03.a425_kjmo,0, 4))
    ,CASE WHEN v03.a425_kjmo > 0 THEN TO_DATE(CAST(v03.a425_kjmo AS VARCHAR(8)), 'YYYYMM') END AS a425_kjmo_date
,CASE
	    WHEN nf.umsatz_brutto > 0 
	    AND kjmo_date > ADD_MONTHS(a425_kjmo_date, -6) 
	    OR nf_w.umsatz_brutto > 0 
	    AND wo_dat_von > ADD_MONTHS(a425_kjmo_date, -6) 
	    THEN 'X' 
	    ELSE CAST(NULL AS VARCHAR(1))
	END AS Umsatz_6Monate
FROM
    dbp_view.v_art_nielsen_wug_zu_pflege v01
    JOIN dbp_view.v_art_nielsen v02 ON (
        v01.mandant_id = v02.mandant_id AND v01.art_nielsen_id = v02.art_nielsen_id
    ) 
    --15.02.2021 sgro2903: join auf das aktuelle MAT der tupel_mat, damit die Anwender keine Potentialartikel zuordnen die nicht mehr relevant sind
    --13.04.2020 sgro2903: join erweitert um mandant_id statt auf Tabelle kjmo_sort gehen wir über die view damit die richtigen Wochen gezogen werden
    JOIN dbp_msi_v_view.v_tupel_mat v03 ON v01.mandant_id = v03.mandant_id
    AND v01.art_nielsen_id = v03.a450_art_nielsen_nr
    AND (v03.mandant_id, v03.a500_kjwo_update) IN (
        SELECT
            mandant_id
            ,MAX(kjwo_update) AS a500_kjwo_update
        FROM
            dbp_msi_view_ek_sort.java_mat_kjwo_update
        GROUP BY
            1
    )
    LEFT JOIN (
        SELECT
            neu1.mandant_id AS mandant_id
            ,art_nielsen_id AS art_nielsen_id
            ,MAX(kjmo) AS kjmo
            ,SUM (umsatz_brutto) AS umsatz_brutto
        FROM
            dbp_view.v_art_nielsen_fakten_kjmo AS neu1
            JOIN dbp_view.v_nielsen_market nm ON neu1.mandant_id = nm.mandant_id
            AND neu1.nielsen_market_id = nm.nielsen_market_id
        WHERE
            ((
                nm.mandant_id = 1 AND nielsen_market_cluster_id = 2
            )
            OR (
                nm.mandant_id > 1 AND nielsen_market_cluster_id = 1
            ))
        AND TO_DATE(CAST(neu1.kjmo AS VARCHAR(8)), 'YYYYMM') > ADD_MONTHS(CURRENT_DATE, -6)
        GROUP BY
            1
            ,2
    ) AS nf ON v01.mandant_id = nf.mandant_id
    AND v01.art_nielsen_id = nf.art_nielsen_id
    LEFT JOIN (
        SELECT
            neu2.mandant_id AS mandant_id
            ,art_nielsen_id AS art_nielsen_id
            ,MAX(w1.wo_dat_von) AS wo_dat_von
            ,MAX(neu2.kjwo) AS kjwo
            ,SUM (umsatz_brutto) AS umsatz_brutto
        FROM
            dbp_view.v_art_nielsen_fakten_kjwo AS neu2
            JOIN dbp_view.v_nielsen_market nm ON neu2.mandant_id = nm.mandant_id
            AND neu2.nielsen_market_id = nm.nielsen_market_id
            INNER JOIN dbp_view.v_woche w1 ON neu2.kjwo = w1.kjwo
        WHERE
            ((
                nm.mandant_id = 1 AND nielsen_market_cluster_id = 2
            )
            OR (
                nm.mandant_id > 1 AND nielsen_market_cluster_id = 1
            ))
        AND w1.wo_dat_von > ADD_MONTHS(CURRENT_DATE, -6)
        GROUP BY
            1
            ,2
    ) AS nf_w ON v01.mandant_id = nf_w.mandant_id AND v01.art_nielsen_id = nf_w.art_nielsen_id;
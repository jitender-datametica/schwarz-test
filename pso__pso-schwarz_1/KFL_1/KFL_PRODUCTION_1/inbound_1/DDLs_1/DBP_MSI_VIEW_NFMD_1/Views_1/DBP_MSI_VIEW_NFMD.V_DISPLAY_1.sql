CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.V_DISPLAY_1 
AS
SELECT
    t1.mandant_id,
    t1.stueckliste_id,
    t1.art_id AS Art_id_display,
    t2.art_id AS art_id_komponente,
    t2.komponentenmenge,
    t2.komponentenmenge_einh_id,
    COALESCE(SUM(CASE WHEN t3.nb_id = -111 THEN t3.menge_lgbest_erp_frei_bme ELSE 0 END), 0) AS bestand_vz,
    COALESCE(SUM(CASE WHEN t3.nb_id = 0 THEN t3.menge_lgbest_erp_frei_bme ELSE 0 END), 0) AS bestand_markt,
    CASE
        WHEN COALESCE(SUM(CASE WHEN t3.nb_id = -111 THEN t3.menge_lgbest_erp_frei_bme ELSE 0 END), 0) = 0 THEN NULL
        ELSE ROUND(SUM(CASE WHEN t3.nb_id = -111 THEN t3.menge_lgbest_erp_frei_bme ELSE 0 END / t2.komponentenmenge ), 0)
    END AS display_vz,
    CASE
        WHEN COALESCE(SUM(CASE WHEN t3.nb_id = 0 THEN t3.menge_lgbest_erp_frei_bme ELSE 0 END), 0) = 0 THEN NULL
        ELSE ROUND(SUM(CASE WHEN t3.nb_id = 0 THEN t3.menge_lgbest_erp_frei_bme ELSE 0 END / t2.komponentenmenge ), 0)
    END AS display_markt
FROM
    dbp_data.stueckliste_1 t1_1
JOIN
    dbp_data.stueckliste_det_1 t2 ON t1.mandant_id = t2.mandant_id AND t1.stueckliste_id = t2.stueckliste_id
LEFT JOIN
    dbp_data.marktbestand_erp_1 t3 ON t2.art_id = t3.art_id AND t3.nb_id IN (-111, 0)
    
WHERE t2.dat_bis>(Current_date)  AND t3.dat = Current_date-1 
GROUP BY
    t1.mandant_id,
    t1.stueckliste_id,
    t1.art_id,
    t2.art_id,
    t2.komponentenmenge,
    t2.komponentenmenge_einh_id;
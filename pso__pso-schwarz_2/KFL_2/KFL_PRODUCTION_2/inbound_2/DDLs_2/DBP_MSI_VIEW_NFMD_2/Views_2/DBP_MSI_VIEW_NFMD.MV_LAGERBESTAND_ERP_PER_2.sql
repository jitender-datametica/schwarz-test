CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_LAGERBESTAND_ERP_PER_2
AS
-- Nur die Artikel_2 die wirklich in der JF Tabelle vorhanden sind 
WITH relevante_art AS (
    SELECT DISTINCT art_id,
            display_art_id,
            mandant_id
    FROM  dbp_data.nfmd_art_promotion_2
),
-- Stueckliste_2 Infos um die Komponentenmenge zu erhalten, da dies nicht von AI gesendet wird. 
steuckliste AS (
    SELECT v0.mandant_id, 
        v0.art_id AS display_art_id,
        v1.art_id AS art_id,
        v1.komponentenmenge
    FROM dbp_view.v_stueckliste_2 v0
    JOIN dbp_view.v_stueckliste_det_2 v1
    ON v0.mandant_id = v1.mandant_id
    AND v0.stueckliste_id = v1.stueckliste_id
    WHERE v1.dat_bis > CURRENT_DATE
)
SELECT
v00.art_id,
v00.mandant_id,
v00.display_art_id ,
v02.komponentenmenge,
SUM(v01.menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
SUM(v01.menge_lgbest_erp_gesp_bme + v01.menge_lgbest_erp_qual_bme + v01.menge_lgbest_erp_ret_gesp_bme) AS menge_lgbest_erp_gesperrt_bme,
--Display Komponente - Wie viele Displays kann ich mit meinem vorhanden VZ Bestand befuellen
--  -- Erste Kennzahl auf Komponenten Ebene
COALESCE(SUM(v01.menge_lgbest_erp_frei_bme),0)/v02.komponentenmenge AS menge_lgbest_display_komponenten,
--  -- Zweite Kennzahl auf Display Ebene - Anhand des MIN kann festgestellt werden, wie viele Displays ich aktuell befüllen kann. 
MIN(menge_lgbest_display_komponenten) OVER (PARTITION BY v00.mandant_id, v00.display_art_id) AS menge_lgbest_min_display_komponente

FROM  relevante_art v00 
LEFT JOIN     dbp_view.v_lagerbestand_erp_per_2 v01
ON v00.mandant_id = v01.mandant_id
 AND v00.art_id = v01.art_id   
 AND  CURRENT_DATE - 1 BETWEEN v01.dat_von AND v01.dat_bis -- nur den aktuellen Bestand
 -- Komponenteeinheit dazu fuegen 
LEFT JOIN steuckliste v02
ON v00.mandant_id = v02.mandant_id
 AND v00.art_id = v02.art_id  
 AND v00.display_art_id = v02.display_art_id
GROUP BY v00.art_id,
v00.mandant_id,
v02.komponentenmenge,
v00.display_art_id;
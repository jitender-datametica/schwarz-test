CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene1_spr_zu_1 (abschriftgruppe_id_ebene1,
abschriftgruppe_ebene1_bez) AS SELECT V01.abschriftgruppe_id AS abschriftgruppe_id_ebene1,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.abschriftgruppe_bez
    ELSE NULL
    END), 'N/A') AS abschriftgruppe_ebene1_bez
FROM kfl_production_dbp_view.v_abschriftgruppe_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_abschriftgruppe_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.abschriftgruppe_id
    = V02.abschriftgruppe_id
WHERE CAST(V02.abschriftgruppe_ebene_kz AS FLOAT64) = 1
GROUP BY V01.abschriftgruppe_id;
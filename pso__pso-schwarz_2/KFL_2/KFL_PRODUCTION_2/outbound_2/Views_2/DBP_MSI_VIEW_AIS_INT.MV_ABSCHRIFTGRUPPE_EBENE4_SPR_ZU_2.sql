CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene4_spr_zu_2 (abschriftgruppe_id_ebene4,
abschriftgruppe_ebene4_bez) AS SELECT V01.abschriftgruppe_id AS abschriftgruppe_id_ebene4,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.abschriftgruppe_bez
    ELSE NULL
    END), 'N/A') AS abschriftgruppe_ebene4_bez
FROM kfl_production_dbp_view.v_abschriftgruppe_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_abschriftgruppe_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.abschriftgruppe_id
    = V02.abschriftgruppe_id
WHERE CAST(V02.abschriftgruppe_ebene_kz AS FLOAT64) = 4
GROUP BY V01.abschriftgruppe_id;
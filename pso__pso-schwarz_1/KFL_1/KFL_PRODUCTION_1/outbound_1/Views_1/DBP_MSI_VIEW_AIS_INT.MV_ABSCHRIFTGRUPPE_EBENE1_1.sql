CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene1_1 (abschriftgruppe_id_ebene1,
abschriftgruppe_id_ebene2) AS SELECT V02.abschriftgruppe_id AS abschriftgruppe_id_ebene1,
 V02.uebergeordnete_abschriftgruppe_id AS abschriftgruppe_id_ebene2
FROM kfl_production_dbp_view.v_abschriftgruppe_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_abschriftgruppe_hierarchie_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.abschriftgruppe_id
    = V02.abschriftgruppe_id
WHERE CAST(V01.abschriftgruppe_ebene_kz AS FLOAT64) = 1
GROUP BY abschriftgruppe_id_ebene1,
 abschriftgruppe_id_ebene2;
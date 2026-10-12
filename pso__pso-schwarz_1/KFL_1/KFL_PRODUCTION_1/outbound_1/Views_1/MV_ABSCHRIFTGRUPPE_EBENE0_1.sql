CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene0_1 (abschriftenart_id,
abschriftgruppe_id_ebene0, abschriftgruppe_id_ebene1) AS SELECT abschriftenart_id,
 abschriftgruppe_id_ebene0,
 abschriftgruppe_id_ebene1
FROM (SELECT CAST(V01.preis_aend_grund_id AS STRING) AS abschriftenart_id,
    V01.abschriftgruppe_id AS abschriftgruppe_id_ebene0,
    V02.abschriftgruppe_id_ebene1
   FROM kfl_production_dbp_view.v_l_preis_aenderung_1 AS V01
    INNER JOIN kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene1_1 AS V02 ON V01.abschriftgruppe_id = V02.abschriftgruppe_id_ebene1
     
   UNION ALL
   SELECT CAST(V01.abschriftart_id AS STRING) AS abschriftenart_id,
    V01.abschriftgruppe_id AS abschriftgruppe_id_ebene0,
    V02.abschriftgruppe_id_ebene1
   FROM kfl_production_dbp_view.v_l_abschriftart_1 AS V01
    INNER JOIN kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene1_1 AS V02 ON V01.abschriftgruppe_id = V02.abschriftgruppe_id_ebene1
     
   UNION ALL
   SELECT CAST(V01.lager_bewart_id AS STRING) AS abschriftenart_id,
    V01.abschriftgruppe_id AS abschriftgruppe_id_ebene0,
    V02.abschriftgruppe_id_ebene1
   FROM kfl_production_dbp_view.v_l_lager_bewart_1 AS V01
    INNER JOIN kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene1_1 AS V02 ON V01.abschriftgruppe_id = V02.abschriftgruppe_id_ebene1
     
   WHERE V01.system_id <> 13) AS t3
GROUP BY abschriftenart_id,
 abschriftgruppe_id_ebene0,
 abschriftgruppe_id_ebene1;
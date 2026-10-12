CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene0 (abschriftenart_id,
abschriftgruppe_id_ebene0, abschriftgruppe_id_ebene1) AS SELECT *
FROM (SELECT TRIM(CAST(V01.preis_aend_grund_id AS STRING)) AS abschriftenart_id,
    V01.abschriftgruppe_id AS abschriftgruppe_id_ebene0,
    V02.abschriftgruppe_id_ebene1
   FROM kfl_production_dbp_data.l_preis_aenderung AS V01
    INNER JOIN kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene1 AS V02 ON V01.abschriftgruppe_id = V02.abschriftgruppe_id_ebene1
     
   UNION ALL
   SELECT TRIM(CAST(V010.abschriftart_id AS STRING)) AS clean_id,
    V010.abschriftgruppe_id AS abschriftgruppe_id_ebene0,
    V020.abschriftgruppe_id_ebene1
   FROM kfl_production_dbp_data.l_abschriftart AS V010
    INNER JOIN kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene1 AS V020 ON V010.abschriftgruppe_id = V020.abschriftgruppe_id_ebene1
     
   UNION ALL
   SELECT TRIM(CAST(V011.lager_bewart_id AS STRING)) AS clean_id,
    V011.abschriftgruppe_id AS abschriftgruppe_id_ebene0,
    V021.abschriftgruppe_id_ebene1
   FROM kfl_production_dbp_data.l_lager_bewart AS V011
    INNER JOIN kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene1 AS V021 ON V011.abschriftgruppe_id = V021.abschriftgruppe_id_ebene1
     
   WHERE V011.system_id <> 13)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY abschriftenart_id ORDER BY abschriftgruppe_id_ebene0 NULLS LAST)) = 1;
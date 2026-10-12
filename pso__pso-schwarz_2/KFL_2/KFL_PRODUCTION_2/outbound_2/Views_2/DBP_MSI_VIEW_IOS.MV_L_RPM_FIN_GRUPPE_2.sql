CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_rpm_fin_gruppe_2 (fin_gruppe_id, fin_kategorie_id,
fin_gruppe_version_id, fin_gruppe_version_dat) AS SELECT V01.fin_gruppe_id,
 V01.fin_kategorie_id,
 V02.fin_gruppe_version_id,
 V02.fin_gruppe_version_dat
FROM kfl_production_dbp_view.v_l_rpm_fin_gruppe_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_rpm_fin_gruppe_2 AS V02 ON V01.fin_gruppe_id = V02.fin_gruppe_id AND V01.fin_kategorie_id
    = V02.fin_kategorie_id
GROUP BY V01.fin_gruppe_id,
 V01.fin_kategorie_id,
 V02.fin_gruppe_version_id,
 V02.fin_gruppe_version_dat;
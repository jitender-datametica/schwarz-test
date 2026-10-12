CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_feld_auspr_1 (rpm_feld_id, rpm_feld_bez, rpm_immobilie_id,
rpm_feld_auspr_bez, rpm_feld_auspr_id, rpm_gewichtung, dat_von, dat_bis) AS SELECT V02.rpm_feld_id,
 V02.rpm_feld_bez,
 V01.rpm_hierarchie_id AS rpm_immobilie_id,
 V04.rpm_feld_auspr_bez,
 V03.rpm_feld_auspr_id,
 V01.rpm_gewichtung,
 V01.dat_von,
 V01.dat_bis
FROM kfl_production_dbp_view.v_rpm_feld_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_l_rpm_feld_1 AS V02 ON V01.rpm_feld_id = V02.rpm_feld_id
 INNER JOIN kfl_production_dbp_view.v_rpm_feld_auspr_zu_1 AS V03 ON V02.rpm_feld_id = V03.rpm_feld_id AND V01.rpm_tab_id =
    V03.rpm_tab_id AND V01.rpm_feld_auspr_id = V03.rpm_feld_auspr_id
 INNER JOIN kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_1 AS V04 ON V03.rpm_feld_id = V04.rpm_feld_id AND V03.rpm_tab_id
     = V04.rpm_tab_id AND V03.rpm_feld_auspr_id = V04.rpm_feld_auspr_id
 LEFT JOIN kfl_production_dbp_view.v_l_rpm_tab_1 AS V05 ON V05.rpm_tab_bez = 'INM_INITIATIVE' AND V01.rpm_tab_id = V05.rpm_tab_id
   
WHERE V04.spr_id = 22
 AND V01.dat_bis = DATE '9999-12-31';
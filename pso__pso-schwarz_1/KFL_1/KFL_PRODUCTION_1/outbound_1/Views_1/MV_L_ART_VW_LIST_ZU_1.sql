CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_art_vw_list_zu_1 (in_art_id, in_art_nr, vw_id, mandant_id,
list_durchg_fg) AS -- ,  V03.SYSTEM_ID
 -- MARA_1
 SELECT V03.flw_art_id AS in_art_id,
 V03.flw_art_nr AS in_art_nr,
 V01.vw_id,
 V01.mandant_id,
 MAX(V01.list_durchg_fg) AS list_durchg_fg
FROM kfl_production_dbp_view.v_sternchen_logik_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V03 ON V02.art_id = V03.art_id AND V02.mandant_id = V03.mandant_id
WHERE V01.mandant_id = 1
 AND CURRENT_DATE BETWEEN V01.dat_von AND V01.dat_bis
 AND V02.dat_bis = DATE '9999-12-31'
GROUP BY in_art_id,
 in_art_nr,
 V01.vw_id,
 V01.mandant_id;
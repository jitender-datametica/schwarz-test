CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gp_spr_zu_2 (gp_id, mandant_id, gp_name, gp_name_de, gp_name_cz
, gp_name_pl, gp_name_md, gp_name_sk, gp_name_hr, gp_name_ro, gp_name_bg) AS SELECT V01.gp_id,
 V01.mandant_id,
 V01.gp_name_lat AS gp_name,
 V01.gp_name_lat AS gp_name_de,
 V01.gp_name_lat AS gp_name_cz,
 V01.gp_name_lat AS gp_name_pl,
 V01.gp_name_lat AS gp_name_md,
 V01.gp_name_lat AS gp_name_sk,
 V01.gp_name_lat AS gp_name_hr,
 V01.gp_name_lat AS gp_name_ro,
 V01.gp_name AS gp_name_bg
FROM kfl_production_dbp_view.v_gp_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_region_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.land_id = V02.land_id AND
   V01.region_id = V02.region_id
WHERE V01.gp_id NOT BETWEEN 10000 AND 999999;
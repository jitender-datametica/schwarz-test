CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_vkl_2 (vkl_id, gf_id, vkl_name, mandant_id) AS SELECT V01.vkl_id
 ,
 V01.gf_id,
 TRIM(V02.ma_anrede || ' ' || V02.ma_vorname || ' ' || V02.ma_name) AS vkl_name,
 V01.mandant_id
FROM kfl_production_dbp_view.v_vkl_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_ma_spr_zu_2 AS V02 ON V01.vkl_id = V02.ma_id AND V01.mandant_id = V02.mandant_id AND
   V02.spr_id = 22;
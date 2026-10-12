CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_werk_2 (werk_id, mandant_id, werk_nr, werk_name,
laengengrad, breitengrad) AS SELECT V01.werk_id,
 V01.mandant_id,
 V01.werk_nr,
 V01.werk_name,
 V02.laengengrad,
 V02.breitengrad
FROM kfl_production_dbp_view.v_flw_werk_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON CAST(V01.werk_nr AS FLOAT64) = V02.wup_id AND V01.mandant_id = V02.mandant_id
   
WHERE V01.werk_nr IN ('6912', '6916', '6921', '9800', '6922', '6911');
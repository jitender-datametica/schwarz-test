CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_consignor_stream_parent_1 (consignor_stream_cd, consignor_stream_name,
consignor_stream_cd_parent, consignor_stream_name_parent) AS SELECT consignor_stream_cd,
 consignor_stream_name,
  CASE
  WHEN consignor_stream_cd = '-1'
  THEN 'EXTERNAL'
  ELSE consignor_stream_cd
  END AS consignor_stream_cd_parent,
  CASE
  WHEN consignor_stream_name = 'Unknown'
  THEN 'External Company'
  ELSE consignor_stream_name
  END AS consignor_stream_name_parent
FROM szd_core.t_dim_consignor_stream_1
ORDER BY consignor_stream_cd NULLS LAST;
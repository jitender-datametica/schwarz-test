CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_INFO_GP
(
  mandant_id
, gp_id
, gp_name
, zek_id
) AS 

SELECT 
  v01.mandant_id
, v01.gp_id
, v01.gp_name
, v01.zek_id

FROM dbp_view.v_gp v01
WHERE v01.mandant_id = 1
AND v01.gp_id > 999999;
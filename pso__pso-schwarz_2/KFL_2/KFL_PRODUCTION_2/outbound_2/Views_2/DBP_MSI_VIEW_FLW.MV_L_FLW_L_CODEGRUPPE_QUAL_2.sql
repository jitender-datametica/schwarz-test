CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_l_codegruppe_qual_2 (mandant_id, katalogart_id,
codegruppe_id, codehgrp_id) AS SELECT mandant_id,
 katalogart_id,
 codegruppe_id,
 SUBSTR(codegruppe_id, 3, 1) AS codehgrp_id
FROM kfl_production_dbp_view.v_flw_l_codegruppe_2 AS V01
WHERE katalogart_id = '9';
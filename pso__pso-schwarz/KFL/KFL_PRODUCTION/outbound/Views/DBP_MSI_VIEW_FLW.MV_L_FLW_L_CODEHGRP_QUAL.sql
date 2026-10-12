CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_l_codehgrp_qual (mandant_id, codehgrp_id) AS SELECT
 mandant_id,
 SUBSTR(codegruppe_id, LENGTH(COLLATE(TRIM(COLLATE(codegruppe_id, ''), ''), 'en-ci-trim')), 1) AS codehgrp_id
FROM kfl_production_dbp_view.v_flw_l_codegruppe AS V01
WHERE katalogart_id = '9'
 AND SUBSTR(codegruppe_id, 1, 1) = 'Z'
 AND SUBSTR(codegruppe_id, LENGTH(COLLATE(TRIM(COLLATE(codegruppe_id, ''), ''), 'en-ci-trim')), 1) BETWEEN '0' AND '9'
GROUP BY mandant_id,
 codehgrp_id;
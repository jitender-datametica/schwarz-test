CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_codehgrp_spr_qual_2 (mandant_id, codehgrp_id
, spr_id, codegruppe_bez) AS SELECT V01.mandant_id,
 SUBSTR(V01.codegruppe_id, 3, 1) AS codehgrp_id,
 V01.spr_id,
 MAX(V01.codegruppe_bez) AS codegruppe_bez
FROM kfl_production_dbp_view.v_flw_codegruppe_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.katalogart_id = '9'
 AND SUBSTR(V01.codegruppe_id, 1, 1) = 'Z'
 AND SUBSTR(V01.codegruppe_id, 3, 1) BETWEEN '0' AND '9'
GROUP BY V01.mandant_id,
 codehgrp_id,
 V01.spr_id;
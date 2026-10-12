CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_dispo_group AS SELECT REF_C.country_id AS client_id,
 REF_C.country_iso_cd,
 DISPOGRP.dispo_group_id AS dispo_group_nr,
 DISPOGRP.language_id,
 DISPOGRP.dispo_group_desc AS description
FROM ldl_p_lew_core_ac.v_wawi_ref_country AS REF_C
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_itm_dispo_group AS DISPOGRP ON REF_C.country_id = DISPOGRP.client_id
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON DISPOGRP.client_id = MIG.client_id
WHERE CURRENT_DATE BETWEEN DISPOGRP.dat_rec_start AND DISPOGRP.dat_rec_end
 AND DISPOGRP.dispo_group_id > 0;
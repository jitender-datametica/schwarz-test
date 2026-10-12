CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_itemfamilies_2 AS SELECT C.country_iso_cd,
 FGRP.subitemgroup_id,
 FGRP.family_cd,
 FGRP.item_family_short_desc,
 FGRP.item_family_desc,
 FGRP.language_id
FROM ldl_p_lew_core_ac.v_wawi_itm_familygroup_2 AS FGRP
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS CC ON FGRP.client_id = CC.client_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_2 AS C ON CC.country_id = C.country_id
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON FGRP.client_id = MIG.client_id
WHERE CURRENT_DATE BETWEEN FGRP.dat_rec_start AND FGRP.dat_rec_end
 AND FGRP.item_familygroup_id > 0
 AND (CURRENT_DATE < MIG.migration_dat_valid_from OR CURRENT_DATE > MIG.migration_dat_valid_to)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY C.country_iso_cd, CAST(FGRP.subitemgroup_id AS STRING), CAST(FGRP.family_cd AS STRING)
      , CAST(FGRP.language_id AS STRING) ORDER BY FGRP.item_familygroup_id IS NULL DESC, FGRP.item_familygroup_id DESC)
   ) = 1;
CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEMFAMILIES_2
AS
   SELECT
   c.country_iso_cd
   ,fgrp.subitemgroup_id
   ,fgrp.family_cd
   ,fgrp.item_family_short_desc
   ,fgrp.item_family_desc
   ,fgrp.language_id
  FROM p_lew_core_ac.v_wawi_itm_familygroup_2 AS fgrp
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_country_2 AS cc
   ON fgrp.client_id = cc.client_id
   INNER JOIN p_lew_core_ac.v_wawi_ref_country_2 AS c
   ON cc.country_id = c.country_id
   INNER JOIN p_lew_core_ac.v_client_migration_per_2 AS mig
   ON mig.client_id = fgrp.client_id

   WHERE Current_Date BETWEEN fgrp.dat_rec_start AND fgrp.dat_rec_end
     AND fgrp.item_familygroup_id > 0
     AND (    Current_Date < mig.migration_dat_valid_from
           OR Current_Date > mig.migration_dat_valid_to
         )
   QUALIFY ROW_NUMBER() OVER (PARTITION BY c.country_iso_cd, fgrp.subitemgroup_id, fgrp.family_cd, fgrp.language_id ORDER BY fgrp.item_familygroup_id DESC) = 1
;
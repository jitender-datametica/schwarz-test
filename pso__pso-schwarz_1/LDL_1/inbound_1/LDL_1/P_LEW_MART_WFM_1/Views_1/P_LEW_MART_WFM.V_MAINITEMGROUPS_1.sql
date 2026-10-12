CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_MAINITEMGROUPS_1
AS
   SELECT
      cl.country_cd AS country_iso_cd
     ,CASE
         WHEN sig.src_subitemgrp_cd < 0 THEN -1000
         WHEN sig.src_subitemgrp_cd BETWEEN 0 AND 9 THEN 0
         WHEN sig.src_subitemgrp_cd BETWEEN 10 AND 19 THEN 1
         WHEN sig.src_subitemgrp_cd BETWEEN 20 AND 29 THEN 2
         WHEN sig.src_subitemgrp_cd BETWEEN 30 AND 39 THEN 3
         WHEN sig.src_subitemgrp_cd BETWEEN 40 AND 49 THEN 4
         WHEN sig.src_subitemgrp_cd BETWEEN 50 AND 59 THEN 5
         WHEN sig.src_subitemgrp_cd BETWEEN 60 AND 69 THEN 6
         WHEN sig.src_subitemgrp_cd BETWEEN 70 AND 79 THEN 7
         WHEN sig.src_subitemgrp_cd BETWEEN 80 AND 89 THEN 8
         WHEN sig.src_subitemgrp_cd BETWEEN 90 AND 97 THEN 9
         WHEN sig.src_subitemgrp_cd = 98 THEN 4
         WHEN sig.src_subitemgrp_cd = 99 THEN 99
         WHEN sig.src_subitemgrp_cd BETWEEN 100 AND 399 THEN 10
         WHEN sig.src_subitemgrp_cd BETWEEN 400 AND 990 THEN 990
         WHEN sig.src_subitemgrp_cd > 990 THEN 999
         END AS mainitemgroup_id
     ,CASE
         WHEN mainitemgroup_id < 0 THEN 'Verkauf, Artikel_1 nicht in WaWi angelegt'
         WHEN mainitemgroup_id = 0 THEN 'neu 0 - 9'
         WHEN mainitemgroup_id = 1 THEN 'Obst/Gemüse/Blumen'
         WHEN mainitemgroup_id = 2 THEN 'Tiko'
         WHEN mainitemgroup_id = 3 THEN 'Kühlung'
         WHEN mainitemgroup_id = 4 THEN 'Nahrungsmittel'
         WHEN mainitemgroup_id = 5 THEN 'Konserven'
         WHEN mainitemgroup_id = 6 THEN 'Getränke'
         WHEN mainitemgroup_id = 7 THEN 'Brot/Back-/Süßwaren/OTC'
         WHEN mainitemgroup_id = 8 THEN 'Nonfood Sortiment'
         WHEN mainitemgroup_id = 9 THEN 'Geflügel/Fleisch/Fisch'
         WHEN mainitemgroup_id = 99  THEN 'neu 99'
         WHEN mainitemgroup_id = 10  THEN 'Non-Food Aktion_1 / Spezial'
         WHEN mainitemgroup_id = 990 THEN 'neu 400 - 990'
         WHEN mainitemgroup_id = 999 THEN 'Verbrauchsgüter/Leergut'
         END AS mainitemgroup_short_desc
     ,mainitemgroup_short_desc AS mainitemgroup_desc
     ,mapp.language_id AS language_id
   FROM p_lew_core_ac.v_subitemgroup_1 AS sig
   INNER JOIN p_lew_core_ac.v_subitemgroup_descr_1 AS sig_descr
   ON sig.client_id = sig_descr.client_id
   AND sig.sub_item_grp_sid = sig_descr.sub_item_grp_sid
   INNER JOIN p_lew_core_ac.v_client_1 AS cl
   ON sig.client_id = cl.client_id
   INNER JOIN p_lew_core_ac.v_report_language_1 AS rlang
   ON sig_descr.lang_sid = rlang.lang_sid
   INNER JOIN p_lew_core_ac.v_map_lang_spras_1 AS mapp
   ON mapp.sap_spras = rlang.src_spras
   INNER JOIN p_lew_core_ac.v_client_migration_per_1 AS mig
   ON sig.client_id = mig.client_id

   WHERE (mapp.language_id = sig.client_id OR mapp.language_id = 7)
   AND CURRENT_DATE BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to
   AND sig.src_node IS NOT NULL
   GROUP BY 1,2,3,4,5

   UNION ALL

   SELECT
      c.country_iso_cd
     ,main.mainitemgroup_id
     ,main.mainitemgroup_short_desc
     ,main.mainitemgroup_desc
     ,main.language_id
   FROM p_lew_core_ac.v_wawi_itm_mainitemgroup_1 AS main
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_country_1 AS cc
   ON main.client_id = cc.client_id
   INNER JOIN p_lew_core_ac.v_wawi_ref_country_1 AS c
   ON cc.country_id = c.country_id
   INNER JOIN p_lew_core_ac.v_client_migration_per_1 AS mig
   ON mig.client_id = main.client_id
   WHERE main.mainitemgroup_id > 0
     AND CURRENT_DATE BETWEEN main.dat_rec_start AND main.dat_rec_end
     AND (    CURRENT_DATE < mig.migration_dat_valid_from
           OR CURRENT_DATE > mig.migration_dat_valid_to
         )
;
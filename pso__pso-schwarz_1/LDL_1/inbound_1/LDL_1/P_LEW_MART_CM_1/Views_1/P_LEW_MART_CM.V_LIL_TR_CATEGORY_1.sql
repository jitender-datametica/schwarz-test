CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_TR_CATEGORY_1
      (
        client_id
      , src_subitemgrp_cd
      , src_familygrp_cd
      )
      AS
         SELECT
         ifg.client_id,
         CAST(src_subitemgrp_cd AS INTEGER) AS src_subitemgrp_cd,
         CASE /* extraktion des familycodes aus Kompositfeld, Datentypangleichung */
                WHEN CHARINDEX('.', fam.src_familygrp_cd) > 0 AND CHARINDEX('.', src_familygrp_cd) < LENGTH(fam.src_familygrp_cd)
         THEN CAST(TO_NUMBER(SUBSTRING(fam.src_familygrp_cd, CHARINDEX('.', fam.src_familygrp_cd) +1)) AS INTEGER)
         ELSE NULL
    END AS src_familygrp_cd
         FROM p_lew_process_mstr_ac.v_lil_tr_category_ifg_1 AS ifg
         INNER JOIN p_lew_bil_ac.v_item_familygroup_1 AS fam
         ON fam.item_fam_grp_sid = ifg.item_fam_grp_sid
         AND fam.sub_item_grp_sid = ifg.sub_item_grp_sid
         INNER JOIN p_lew_core_ac.v_subitemgroup_1 AS sg
         ON sg.sub_item_grp_sid = ifg.sub_item_grp_sid

         WHERE ifg.active_fg = 1

         UNION ALL
         SELECT
         sig.client_id,
         CAST(src_subitemgrp_cd AS INTEGER) AS src_subitemgrp_cd,
         NULL AS src_familygrp_cd
         FROM p_lew_process_mstr_ac.v_lil_tr_category_sig_1 AS sig
         INNER JOIN p_lew_core_ac.v_subitemgroup_1 AS sg
         ON sg.sub_item_grp_sid = sig.sub_item_grp_sid

         WHERE sig.active_fg = 1;
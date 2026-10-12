CREATE OR REPLACE VIEW P_LEW_PROCESS.V_SUBITEMGROUP_NAME_1
      AS
         SELECT
              client_id,
         sub_item_grp_sid,
         Max (CASE WHEN iso_cd = '@' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name,
         Max (CASE WHEN iso_cd = 'BG' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_BG,
         Max (CASE WHEN iso_cd = 'CS' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_CS,
         Max (CASE WHEN iso_cd = 'DA'  THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_DA,
         Max (CASE WHEN iso_cd = 'DE' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_DE,
         Max (CASE WHEN iso_cd = 'EL' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_EL,
         Max (CASE WHEN iso_cd = 'EN' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_EN,
         Max (CASE WHEN iso_cd = 'ES' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_ES,
         Max (CASE WHEN iso_cd = 'FI' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_FI,
         Max (CASE WHEN iso_cd = 'FR' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_FR,
         Max (CASE WHEN iso_cd = 'HR' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_HR,
         Max (CASE WHEN iso_cd = 'HU' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_HU,
         Max (CASE WHEN iso_cd = 'IT' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_IT,
         Max (CASE WHEN iso_cd = 'LT' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_LT,
         Max (CASE WHEN iso_cd = 'NL' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_NL,
         Max (CASE WHEN iso_cd = 'PL' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_PL,
         Max (CASE WHEN iso_cd = 'PT' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_PT,
         Max (CASE WHEN iso_cd = 'RO' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_RO,
         Max (CASE WHEN iso_cd = 'SH' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_SH,
         Max (CASE WHEN iso_cd = 'SK' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_SK,
         Max (CASE WHEN iso_cd = 'SL' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_SL,
         Max (CASE WHEN iso_cd = 'SV' THEN sub_item_grp_descr ELSE NULL END) AS sub_item_grp_name_SV
         FROM p_lew_core_ac.v_subitemgroup_descr_1 AS subitemgr_descr
         INNER JOIN p_lew_core_ac.v_report_language_1 AS rlang
         ON subitemgr_descr.lang_sid = rlang.lang_sid
         GROUP BY client_id, sub_item_grp_sid;
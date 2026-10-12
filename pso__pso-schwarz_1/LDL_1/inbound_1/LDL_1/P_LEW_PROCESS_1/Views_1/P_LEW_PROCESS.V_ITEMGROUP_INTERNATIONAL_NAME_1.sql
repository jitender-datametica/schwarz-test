CREATE OR REPLACE VIEW P_LEW_PROCESS.V_ITEMGROUP_INTERNATIONAL_NAME_1
AS
   SELECT
        client_id,
   item_grp_int_sid,
   Max (CASE WHEN iso_cd = '@' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name,
   Max (CASE WHEN iso_cd = 'BG' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_BG,
   Max (CASE WHEN iso_cd = 'CS' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_CS,
   Max (CASE WHEN iso_cd = 'DA'  THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_DA,
   Max (CASE WHEN iso_cd = 'DE' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_DE,
   Max (CASE WHEN iso_cd = 'EL' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_EL,
   Max (CASE WHEN iso_cd = 'EN' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_EN,
   Max (CASE WHEN iso_cd = 'ES' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_ES,
   Max (CASE WHEN iso_cd = 'FI' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_FI,
   Max (CASE WHEN iso_cd = 'FR' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_FR,
   Max (CASE WHEN iso_cd = 'HR' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_HR,
   Max (CASE WHEN iso_cd = 'HU' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_HU,
   Max (CASE WHEN iso_cd = 'IT' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_IT,
   Max (CASE WHEN iso_cd = 'LT' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_LT,
   Max (CASE WHEN iso_cd = 'NL' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_NL,
   Max (CASE WHEN iso_cd = 'PL' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_PL,
   Max (CASE WHEN iso_cd = 'PT' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_PT,
   Max (CASE WHEN iso_cd = 'RO' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_RO,
   Max (CASE WHEN iso_cd = 'SH' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_SH,
   Max (CASE WHEN iso_cd = 'SK' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_SK,
   Max (CASE WHEN iso_cd = 'SL' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_SL,
   Max (CASE WHEN iso_cd = 'SV' THEN item_grp_int_descr ELSE NULL END) AS item_grp_int_name_SV
   FROM p_lew_core_ac.v_itemgroup_international_descr_1 AS itemgroup_international_descr
   INNER JOIN p_lew_core_ac.v_report_language_1 AS rlang
   ON itemgroup_international_descr.lang_sid = rlang.lang_sid
   GROUP BY client_id, item_grp_int_sid;
CREATE OR REPLACE VIEW P_LEW_PROCESS.V_ITEM_NAME_2
      AS
         SELECT
              client_id,
         item_sid,
         Max (CASE WHEN iso_cd = '@' THEN item_descr ELSE NULL END) AS item_name,
         Max (CASE WHEN iso_cd = 'BG' THEN item_descr ELSE NULL END) AS item_name_BG,
         Max (CASE WHEN iso_cd = 'CS' THEN item_descr ELSE NULL END) AS item_name_CS,
         Max (CASE WHEN iso_cd = 'DA'  THEN item_descr ELSE NULL END) AS item_name_DA,
         Max (CASE WHEN iso_cd = 'DE' THEN item_descr ELSE NULL END) AS item_name_DE,
         Max (CASE WHEN iso_cd = 'EL' THEN item_descr ELSE NULL END) AS item_name_EL,
         Max (CASE WHEN iso_cd = 'EN' THEN item_descr ELSE NULL END) AS item_name_EN,
         Max (CASE WHEN iso_cd = 'ES' THEN item_descr ELSE NULL END) AS item_name_ES,
         Max (CASE WHEN iso_cd = 'FI' THEN item_descr ELSE NULL END) AS item_name_FI,
         Max (CASE WHEN iso_cd = 'FR' THEN item_descr ELSE NULL END) AS item_name_FR,
         Max (CASE WHEN iso_cd = 'HR' THEN item_descr ELSE NULL END) AS item_name_HR,
         Max (CASE WHEN iso_cd = 'HU' THEN item_descr ELSE NULL END) AS item_name_HU,
         Max (CASE WHEN iso_cd = 'IT' THEN item_descr ELSE NULL END) AS item_name_IT,
         Max (CASE WHEN iso_cd = 'LT' THEN item_descr ELSE NULL END) AS item_name_LT,
         Max (CASE WHEN iso_cd = 'NL' THEN item_descr ELSE NULL END) AS item_name_NL,
         Max (CASE WHEN iso_cd = 'PL' THEN item_descr ELSE NULL END) AS item_name_PL,
         Max (CASE WHEN iso_cd = 'PT' THEN item_descr ELSE NULL END) AS item_name_PT,
         Max (CASE WHEN iso_cd = 'RO' THEN item_descr ELSE NULL END) AS item_name_RO,
         Max (CASE WHEN iso_cd = 'SH' THEN item_descr ELSE NULL END) AS item_name_SH,
         Max (CASE WHEN iso_cd = 'SK' THEN item_descr ELSE NULL END) AS item_name_SK,
         Max (CASE WHEN iso_cd = 'SL' THEN item_descr ELSE NULL END) AS item_name_SL,
         Max (CASE WHEN iso_cd = 'SV' THEN item_descr ELSE NULL END) AS item_name_SV
         FROM p_lew_core_ac.v_item_descr_2 descr
         INNER JOIN p_lew_core_ac.v_report_language_2 rlang
         ON descr.lang_sid = rlang.lang_sid
         GROUP BY client_id, item_sid;
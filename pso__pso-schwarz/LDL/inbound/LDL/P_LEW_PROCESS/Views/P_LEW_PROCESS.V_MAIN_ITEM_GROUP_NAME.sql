CREATE OR REPLACE VIEW P_LEW_PROCESS.V_MAIN_ITEM_GROUP_NAME
AS
   SELECT
       mainitemgroup.mainitemgroup_id AS mainitemgroup_id,
   MAX (CASE WHEN lang.language_iso_cd = 'DE' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name,
   MAX (CASE WHEN lang.language_iso_cd = 'BG' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_bg,
   MAX (CASE WHEN lang.language_iso_cd = 'CZ' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_cs,
   MAX (CASE WHEN lang.language_iso_cd = 'DE' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_de,
   MAX (CASE WHEN lang.language_iso_cd = 'DK' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_da,
   MAX (CASE WHEN lang.language_iso_cd = 'GR' THEN mainitemgroup.mainitemgroup_short_desc ELSE NULL END) AS mainitemgroup_name_el,
   MAX (CASE WHEN lang.language_iso_cd = 'GB' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_en,
   MAX (CASE WHEN lang.language_iso_cd = 'ES' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_es,
   MAX (CASE WHEN lang.language_iso_cd = 'FI' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_fi,
   MAX (CASE WHEN lang.language_iso_cd = 'FR' THEN mainitemgroup.mainitemgroup_short_desc ELSE NULL END) AS mainitemgroup_name_fr,
   MAX (CASE WHEN lang.language_iso_cd = 'HR' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_hr,
   MAX (CASE WHEN lang.language_iso_cd = 'HU' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_hu,
   MAX (CASE WHEN lang.language_iso_cd = 'IT' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_it,
   MAX (CASE WHEN lang.language_iso_cd = 'LT' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_lt,
   MAX (CASE WHEN lang.language_iso_cd = 'NL' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_nl,
   MAX (CASE WHEN lang.language_iso_cd = 'PL' THEN mainitemgroup.mainitemgroup_short_desc ELSE NULL END) AS mainitemgroup_name_pl,
   MAX (CASE WHEN lang.language_iso_cd = 'PT' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_pt,
   MAX (CASE WHEN lang.language_iso_cd = 'RO' THEN mainitemgroup.mainitemgroup_short_desc ELSE NULL END) AS mainitemgroup_name_ro,
   MAX (CASE WHEN lang.language_iso_cd = 'RS' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_sh,
   MAX (CASE WHEN lang.language_iso_cd = 'SK' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_sk,
   MAX (CASE WHEN lang.language_iso_cd = 'SI' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_sl,
   MAX (CASE WHEN lang.language_iso_cd = 'SE' THEN mainitemgroup.mainitemgroup_desc ELSE NULL END) AS mainitemgroup_name_sv
       FROM p_lew_core_ac.v_wawi_itm_mainitemgroup mainitemgroup
   INNER JOIN p_lew_core_ac.v_wawi_ref_language lang
   ON mainitemgroup.language_id = lang.language_id
   WHERE  mainitemgroup.dat_rec_end = CAST('12/31/9999' AS VARCHAR)
   GROUP BY  mainitemgroup.mainitemgroup_id;
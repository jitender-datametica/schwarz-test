/*
#----------------------------------------------------------------------------
# Description:
# This table provides the lookup for section selection. "Section selection" is a technical information for special requirement in dossier (selection yes and no in "übersicht EK" visualization)
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_spaceman_section_selection (int_org_sid, spaceman_section_sid,
src_section_nr, section_selection_id, section_sid_selection, selection_flag, section_selection_name_be,
section_selection_name_be_fr, section_selection_name_bg, section_selection_name_cy, section_selection_name_cz,
section_selection_name, section_selection_name_dk, section_selection_name_ee, section_selection_name_es,
section_selection_name_fi, section_selection_name_fr, section_selection_name_gb, section_selection_name_gr,
section_selection_name_hr, section_selection_name_hu, section_selection_name_ie, section_selection_name_it,
section_selectionn_name_lt, section_selection_name_lv, section_selection_name_nl, section_selection_name_pl,
section_selection_name_pt, section_selection_name_ro, section_selection_name_rs, section_selection_name_se,
section_selection_name_si, section_selection_name_sk, section_selection_name_us, section_selection_name_ni,
section_selection_name_mt, section_selection_name_cs) AS SELECT SEC.int_org_sid,
 SEC.spaceman_section_sid,
 CAST(ROUND(CAST(SEC.src_section_nr AS BIGNUMERIC), 0) AS BIGNUMERIC) AS src_section_nr,
   SEC.spaceman_section_sid * 1000 + selection.selection_nr AS section_selection_id,
 CONCAT(SEC.spaceman_section_sid, ' - ', selection.selection) AS section_sid_selection,
 selection.selection AS selection_flag,
  CASE
  WHEN INTORG.int_org_nr = 'BE'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_be,
  CASE
  WHEN INTORG.int_org_nr = 'BE'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_be_fr,
  CASE
  WHEN INTORG.int_org_nr = 'BG'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_bg,
  CASE
  WHEN INTORG.int_org_nr = 'CY'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_cy,
  CASE
  WHEN INTORG.int_org_nr = 'CZ'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_cz,
  CASE
  WHEN INTORG.int_org_nr = 'AT' OR INTORG.int_org_nr = 'CH' OR INTORG.int_org_nr = 'DE'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE CASE
   WHEN SECHIST.section_name_de = 'NULL'
   THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
   ELSE CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name_de)
   END
  END AS section_selection_name,
  CASE
  WHEN INTORG.int_org_nr = 'DK'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_dk,
  CASE
  WHEN INTORG.int_org_nr = 'EE'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_ee,
  CASE
  WHEN INTORG.int_org_nr = 'ES'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_es,
  CASE
  WHEN INTORG.int_org_nr = 'FI'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_fi,
  CASE
  WHEN INTORG.int_org_nr = 'FR'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_fr,
  CASE
  WHEN INTORG.int_org_nr = 'GB'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_gb,
  CASE
  WHEN INTORG.int_org_nr = 'GR'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_gr,
  CASE
  WHEN INTORG.int_org_nr = 'HR'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_hr,
  CASE
  WHEN INTORG.int_org_nr = 'HU'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_hu,
  CASE
  WHEN INTORG.int_org_nr = 'IE'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_ie,
  CASE
  WHEN INTORG.int_org_nr = 'IT'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_it,
  CASE
  WHEN INTORG.int_org_nr = 'LT'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_lt,
  CASE
  WHEN INTORG.int_org_nr = 'LV'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_lv,
  CASE
  WHEN INTORG.int_org_nr = 'NL'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_nl,
  CASE
  WHEN INTORG.int_org_nr = 'PL'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_pl,
  CASE
  WHEN INTORG.int_org_nr = 'PT'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_pt,
  CASE
  WHEN INTORG.int_org_nr = 'RO'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_ro,
  CASE
  WHEN INTORG.int_org_nr = 'RS'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_rs,
  CASE
  WHEN INTORG.int_org_nr = 'SE'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_se,
  CASE
  WHEN INTORG.int_org_nr = 'SI'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_si,
  CASE
  WHEN INTORG.int_org_nr = 'SK'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_sk,
  CASE
  WHEN INTORG.int_org_nr = 'US'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_us,
  CASE
  WHEN INTORG.int_org_nr = 'IE'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_ni,
  CASE
  WHEN INTORG.int_org_nr = 'IT'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_mt,
  CASE
  WHEN INTORG.int_org_nr = 'ES'
  THEN CONCAT(SEC.src_section_nr, ' ', SECHIST.section_name)
  ELSE ''
  END AS section_selection_name_cs
FROM ldl_p_lew_core_ac.v_spaceman_section AS SEC
 INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_hist AS SECHIST ON SEC.spaceman_section_sid = SECHIST.spaceman_section_sid
  
 INNER JOIN ldl_p_lew_core_ac.v_internal_organisation AS INTORG ON SEC.int_org_sid = INTORG.int_org_sid
 INNER JOIN (SELECT 1 AS selection_nr,
    'YES' AS selection
   UNION ALL
   SELECT 2 AS selection_nr,
    'NO' AS selection) AS selection ON TRUE
WHERE SECHIST.dwh_valid_to = DATE '9999-12-30'
 AND SECHIST.deleted_fg = 0;
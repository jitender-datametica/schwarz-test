/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup table for sections.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  1.1     08.04.2024      Simeon NIkolaev          Updated transaltion for GB,US,NI,IE
#  1.1     23.04.2024      Simeon NIkolaev          Updated _BE_FR
#  2.0     12.06.2024      Simeon NIkolaev          added section_update_dt
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_2 (src_section_nr, int_org_sid, spaceman_section_sid
, section_group_level_5_nr, section_status_cd, section_update_dt, section_name_be, section_name_be_fr, section_name_bg,
section_name_cy, section_name_cz, section_name, section_name_dk, section_name_ee, section_name_es, section_name_fi,
section_name_fr, section_name_gb, section_name_gr, section_name_hr, section_name_hu, section_name_ie, section_name_it,
section_name_lt, section_name_lv, section_name_nl, section_name_pl, section_name_pt, section_name_ro, section_name_rs,
section_name_se, section_name_si, section_name_sk, section_name_us, section_name_ni, section_name_mt, section_name_cs,
section_width_meas) AS SELECT CAST(ROUND(CAST(SEC.src_section_nr AS BIGNUMERIC), 0) AS BIGNUMERIC) AS src_section_nr,
 SEC.int_org_sid,
 SECHIST.spaceman_section_sid,
 SECHIST.section_group_level_5_nr,
 SECHIST.section_status_cd,
 SECHIST.section_update_dt,
  CASE
  WHEN INTORG.int_org_nr = 'BE'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_be,
  CASE
  WHEN INTORG.int_org_nr = 'BE'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_be_fr,
  CASE
  WHEN INTORG.int_org_nr = 'BG'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_bg,
  CASE
  WHEN INTORG.int_org_nr = 'CY'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_cy,
  CASE
  WHEN INTORG.int_org_nr = 'CZ'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_cz,
  CASE
  WHEN INTORG.int_org_nr = 'AT' OR INTORG.int_org_nr = 'CH' OR INTORG.int_org_nr = 'DE'
  THEN SECHIST.section_name
  ELSE CASE
   WHEN SECHIST.section_name_de = 'NULL'
   THEN SECHIST.section_name
   ELSE SECHIST.section_name_de
   END
  END AS section_name,
  CASE
  WHEN INTORG.int_org_nr = 'DK'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_dk,
  CASE
  WHEN INTORG.int_org_nr = 'EE'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_ee,
  CASE
  WHEN INTORG.int_org_nr = 'ES'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_es,
  CASE
  WHEN INTORG.int_org_nr = 'FI'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_fi,
  CASE
  WHEN INTORG.int_org_nr = 'FR'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_fr,
 SECHIST.section_name AS section_name_gb,
  CASE
  WHEN INTORG.int_org_nr = 'GR'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_gr,
  CASE
  WHEN INTORG.int_org_nr = 'HR'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_hr,
  CASE
  WHEN INTORG.int_org_nr = 'HU'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_hu,
 SECHIST.section_name AS section_name_ie,
  CASE
  WHEN INTORG.int_org_nr = 'IT'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_it,
  CASE
  WHEN INTORG.int_org_nr = 'LT'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_lt,
  CASE
  WHEN INTORG.int_org_nr = 'LV'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_lv,
  CASE
  WHEN INTORG.int_org_nr = 'NL'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_nl,
  CASE
  WHEN INTORG.int_org_nr = 'PL'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_pl,
  CASE
  WHEN INTORG.int_org_nr = 'PT'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_pt,
  CASE
  WHEN INTORG.int_org_nr = 'RO'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_ro,
  CASE
  WHEN INTORG.int_org_nr = 'RS_2'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_rs,
  CASE
  WHEN INTORG.int_org_nr = 'SE'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_se,
  CASE
  WHEN INTORG.int_org_nr = 'SI'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_si,
  CASE
  WHEN INTORG.int_org_nr = 'SK'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_sk,
 SECHIST.section_name AS section_name_us,
 SECHIST.section_name AS section_name_ni,
  CASE
  WHEN INTORG.int_org_nr = 'IT'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_mt,
  CASE
  WHEN INTORG.int_org_nr = 'ES'
  THEN SECHIST.section_name
  ELSE ''
  END AS section_name_cs,
 SECHIST.section_width_meas
FROM ldl_p_lew_core_ac.v_spaceman_section_2 AS SEC
 INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_hist_2 AS SECHIST ON SEC.spaceman_section_sid = SECHIST.spaceman_section_sid
  
 INNER JOIN ldl_p_lew_core_ac.v_internal_organisation_2 AS INTORG ON SEC.int_org_sid = INTORG.int_org_sid
WHERE SECHIST.dwh_valid_to = DATE '9999-12-30'
 AND SECHIST.deleted_fg = 0
 AND SECHIST.section_status_cd = 'RELEASED';
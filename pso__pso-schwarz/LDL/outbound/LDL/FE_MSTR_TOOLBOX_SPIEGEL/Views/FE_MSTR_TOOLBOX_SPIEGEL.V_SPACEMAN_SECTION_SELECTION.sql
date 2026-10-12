/*
#----------------------------------------------------------------------------
# Description:
# # This view provides the lookup for section selection. "Section selection" is a technical information for special requirement in dossier (selection yes and no in "übersicht EK" visualization)
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  1.1     09.04.2025      Simeon Nikolaev          Fix for DE/AT/CH
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_selection (int_org_sid, spaceman_section_sid,
src_section_nr, section_selection_id, section_sid_selection, selection_flag, section_selection_name_be,
section_selection_name_be_fr, section_selection_name_bg, section_selection_name_cy, section_selection_name_cz,
section_selection_name, section_selection_name_de, section_selection_name_at, section_selection_name_ch,
section_selection_name_dk, section_selection_name_ee, section_selection_name_es, section_selection_name_fi,
section_selection_name_fr, section_selection_name_gb, section_selection_name_gr, section_selection_name_hr,
section_selection_name_hu, section_selection_name_ie, section_selection_name_it, section_selectionn_name_lt,
section_selection_name_lv, section_selection_name_nl, section_selection_name_pl, section_selection_name_pt,
section_selection_name_ro, section_selection_name_rs, section_selection_name_se, section_selection_name_si,
section_selection_name_sk, section_selection_name_us, section_selection_name_ni, section_selection_name_mt,
section_selection_name_cs) AS SELECT int_org_sid,
 spaceman_section_sid,
 src_section_nr,
 section_selection_id,
 section_sid_selection,
 selection_flag,
 section_selection_name_be,
 section_selection_name_be_fr,
 section_selection_name_bg,
 section_selection_name_cy,
 section_selection_name_cz,
 section_selection_name,
 section_selection_name AS section_selection_name_de,
 section_selection_name AS section_selection_name_ch,
 section_selection_name AS section_selection_name_at,
 section_selection_name_dk,
 section_selection_name_ee,
 section_selection_name_es,
 section_selection_name_fi,
 section_selection_name_fr,
 section_selection_name_gb,
 section_selection_name_gr,
 section_selection_name_hr,
 section_selection_name_hu,
 section_selection_name_ie,
 section_selection_name_it,
 section_selectionn_name_lt,
 section_selection_name_lv,
 section_selection_name_nl,
 section_selection_name_pl,
 section_selection_name_pt,
 section_selection_name_ro,
 section_selection_name_rs,
 section_selection_name_se,
 section_selection_name_si,
 section_selection_name_sk,
 section_selection_name_us,
 section_selection_name_ni,
 section_selection_name_mt,
 section_selection_name_cs
FROM ldl_fe_mstr_toolbox_spiegel.t_spaceman_section_selection;
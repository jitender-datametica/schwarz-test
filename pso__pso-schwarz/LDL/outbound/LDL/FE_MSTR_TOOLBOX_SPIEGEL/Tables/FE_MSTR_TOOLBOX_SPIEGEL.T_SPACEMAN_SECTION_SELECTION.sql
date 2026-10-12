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


CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_spaceman_section_selection (
int_org_sid BIGNUMERIC(38,0),
spaceman_section_sid BIGNUMERIC(38,0),
src_section_nr BIGNUMERIC(38,0),
section_selection_id BIGNUMERIC(38,0),
section_sid_selection STRING(16777216),
selection_flag STRING(3),
section_selection_name_be STRING(201) COLLATE 'und:ci',
section_selection_name_be_fr STRING(201) COLLATE 'und:ci',
section_selection_name_bg STRING(201) COLLATE 'und:ci',
section_selection_name_cy STRING(201) COLLATE 'und:ci',
section_selection_name_cz STRING(201) COLLATE 'und:ci',
section_selection_name STRING(201) COLLATE 'und:ci',
section_selection_name_dk STRING(201) COLLATE 'und:ci',
section_selection_name_ee STRING(201) COLLATE 'und:ci',
section_selection_name_es STRING(201) COLLATE 'und:ci',
section_selection_name_fi STRING(201) COLLATE 'und:ci',
section_selection_name_fr STRING(201) COLLATE 'und:ci',
section_selection_name_gb STRING(201) COLLATE 'und:ci',
section_selection_name_gr STRING(201) COLLATE 'und:ci',
section_selection_name_hr STRING(201) COLLATE 'und:ci',
section_selection_name_hu STRING(201) COLLATE 'und:ci',
section_selection_name_ie STRING(201) COLLATE 'und:ci',
section_selection_name_it STRING(201) COLLATE 'und:ci',
section_selectionn_name_lt STRING(201) COLLATE 'und:ci',
section_selection_name_lv STRING(201) COLLATE 'und:ci',
section_selection_name_nl STRING(201) COLLATE 'und:ci',
section_selection_name_pl STRING(201) COLLATE 'und:ci',
section_selection_name_pt STRING(201) COLLATE 'und:ci',
section_selection_name_ro STRING(201) COLLATE 'und:ci',
section_selection_name_rs STRING(201) COLLATE 'und:ci',
section_selection_name_se STRING(201) COLLATE 'und:ci',
section_selection_name_si STRING(201) COLLATE 'und:ci',
section_selection_name_sk STRING(201) COLLATE 'und:ci',
section_selection_name_us STRING(201) COLLATE 'und:ci',
section_selection_name_ni STRING(201) COLLATE 'und:ci',
section_selection_name_mt STRING(201) COLLATE 'und:ci',
section_selection_name_cs STRING(201) COLLATE 'und:ci'
);
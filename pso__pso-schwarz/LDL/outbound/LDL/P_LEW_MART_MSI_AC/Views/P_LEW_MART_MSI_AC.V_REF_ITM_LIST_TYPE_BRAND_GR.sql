/* #----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.2  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.3  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.6  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.7  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.8  25.04.2018    Wieber.Harald            Update Release 3.5
#  1.9  03.05.2018    Wieber.Harald            Release 3.6
# 1.10  17.05.2018    Wieber,Harald            Update Release 3.8
# 1.11  07.08.2020    Roy,Ritanjal             Introduce new country Latviya
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr 
#                                              https://jira.schwarz/browse/REP4-7173
# 1.13  27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_itm_list_type_brand_gr (brand_type_group_id
OPTIONS(description='Guppen Markenart ID'), brand_type_group_desc_at
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  AT'), brand_type_group_desc_be
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  BE'), brand_type_group_desc_be_fr
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  BE_FR'), brand_type_group_desc_bg
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  BG'), brand_type_group_desc_ch
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  CH'), brand_type_group_desc_cy
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  CY'), brand_type_group_desc_cz
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  CZ'), brand_type_group_desc
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart'), brand_type_group_desc_dk
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  DK'), brand_type_group_desc_ee
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  EE'), brand_type_group_desc_es
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  ES'), brand_type_group_desc_fi
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  FI'), brand_type_group_desc_fr
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  FR'), brand_type_group_desc_gb
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  GB'), brand_type_group_desc_gr
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  GR'), brand_type_group_desc_hr
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  HR'), brand_type_group_desc_hu
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  HU'), brand_type_group_desc_ie
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  IE'), brand_type_group_desc_it
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  IT'), brand_type_group_desc_lt
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  LT'), brand_type_group_desc_lv
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  LV'), brand_type_group_desc_ni
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  NI'), brand_type_group_desc_nl
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  NL'), brand_type_group_desc_de
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  DE'), brand_type_group_desc_pl
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  PL'), brand_type_group_desc_pt
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  PT'), brand_type_group_desc_ro
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  RO'), brand_type_group_desc_se
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  SE'), brand_type_group_desc_si
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  SI'), brand_type_group_desc_sk
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  SK'), brand_type_group_desc_cs
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  CS'), brand_type_group_desc_mt
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  MT'), brand_type_group_desc_us
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  US'), brand_type_group_desc_rs
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe der Markenart  RS'))
OPTIONS(DESCRIPTION = `MULTISPRACHE MARKENARTGRUPPEN REFERENZ`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ref_itm_list_type_brand_gr;
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
#  1.10 17.05.2018    Wieber,Harald            Update Release 3.8
#  1.11 07.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
#  1.12 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.13 27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#  1.14 23.08.2024    Malec, Marcin            Added column vs_sort, with an additional country_2 sorting logic; User Story 665161
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_country_lead_2 (int_id OPTIONS(description='Lidl International ID'),
country_id OPTIONS(description='Landeskennzeichen'), country_iso_cd OPTIONS(description='Landes ISO Code'),
country_group_id OPTIONS(description='Cluster ID'), lisy_sort OPTIONS(description='Lisy Sort Wert'), vs_sort
OPTIONS(description='VS_2 sort'), dashboard_relevant_fg OPTIONS(description='Dashboeard relevant Flag'), country_desc_at
OPTIONS(description='Landesspezifische Bezeichnung des Landes AT'), country_desc_be
OPTIONS(description='Landesspezifische Bezeichnung des Landes BE'), country_desc_be_fr
OPTIONS(description='Landesspezifische Bezeichnung des Landes BE_FR'), country_desc_bg
OPTIONS(description='Landesspezifische Bezeichnung des Landes BG'), country_desc_ch
OPTIONS(description='Landesspezifische Bezeichnung des Landes CH'), country_desc_cy
OPTIONS(description='Landesspezifische Bezeichnung des Landes CY'), country_desc_cz
OPTIONS(description='Landesspezifische Bezeichnung des Landes CZ'), country_desc
OPTIONS(description='Bezeichnung des Landes'), country_desc_dk
OPTIONS(description='Landesspezifische Bezeichnung des Landes DK'), country_desc_ee
OPTIONS(description='Landesspezifische Bezeichnung des Landes EE'), country_desc_es
OPTIONS(description='Landesspezifische Bezeichnung des Landes ES'), country_desc_fi
OPTIONS(description='Landesspezifische Bezeichnung des Landes FI'), country_desc_fr
OPTIONS(description='Landesspezifische Bezeichnung des Landes FR'), country_desc_gb
OPTIONS(description='Landesspezifische Bezeichnung des Landes GB'), country_desc_gr
OPTIONS(description='Landesspezifische Bezeichnung des Landes GR'), country_desc_hr
OPTIONS(description='Landesspezifische Bezeichnung des Landes HR'), country_desc_hu
OPTIONS(description='Landesspezifische Bezeichnung des Landes HU'), country_desc_ie
OPTIONS(description='Landesspezifische Bezeichnung des Landes IE'), country_desc_it
OPTIONS(description='Landesspezifische Bezeichnung des Landes IT'), country_desc_lt
OPTIONS(description='Landesspezifische Bezeichnung des Landes LT'), country_desc_lv
OPTIONS(description='Landesspezifische Bezeichnung des Landes LV'), country_desc_ni
OPTIONS(description='Landesspezifische Bezeichnung des Landes NI'), country_desc_nl
OPTIONS(description='Landesspezifische Bezeichnung des Landes NL'), country_desc_de
OPTIONS(description='Landesspezifische Bezeichnung des Landes DE'), country_desc_pl
OPTIONS(description='Landesspezifische Bezeichnung des Landes PL'), country_desc_pt
OPTIONS(description='Landesspezifische Bezeichnung des Landes PT'), country_desc_ro
OPTIONS(description='Landesspezifische Bezeichnung des Landes RO'), country_desc_se
OPTIONS(description='Landesspezifische Bezeichnung des Landes SE'), country_desc_si
OPTIONS(description='Landesspezifische Bezeichnung des Landes SI'), country_desc_sk
OPTIONS(description='Landesspezifische Bezeichnung des Landes SK'), country_desc_cs
OPTIONS(description='Landesspezifische Bezeichnung des Landes CS'), country_desc_mt
OPTIONS(description='Landesspezifische Bezeichnung des Landes MT'), country_desc_us
OPTIONS(description='Landesspezifische Bezeichnung des Landes US'), country_desc_rs
OPTIONS(description='Landesspezifische Bezeichnung des Landes RS_2'))
OPTIONS(DESCRIPTION = `Lead Project - Multi language Country_2 reference`) AS SELECT int_id,
 country_id,
 country_iso_cd,
 country_group_id,
 lisy_sort,
 vs_sort,
 dashboard_relevant_fg,
 country_desc_at,
 country_desc_be,
 country_desc_be_fr,
 country_desc_bg,
 country_desc_ch,
 country_desc_cy,
 country_desc_cz,
 country_desc,
 country_desc_dk,
 country_desc_ee,
 country_desc_es,
 country_desc_fi,
 country_desc_fr,
 country_desc_gb,
 country_desc_gr,
 country_desc_hr,
 country_desc_hu,
 country_desc_ie,
 country_desc_it,
 country_desc_lt,
 country_desc_lv,
 country_desc_ni,
 country_desc_nl,
 country_desc_de,
 country_desc_pl,
 country_desc_pt,
 country_desc_ro,
 country_desc_se,
 country_desc_si,
 country_desc_sk,
 country_desc_cs,
 country_desc_mt,
 country_desc_us,
 country_desc_rs
FROM ldl_p_lew_mart_msi.v_ref_country_lead_2;
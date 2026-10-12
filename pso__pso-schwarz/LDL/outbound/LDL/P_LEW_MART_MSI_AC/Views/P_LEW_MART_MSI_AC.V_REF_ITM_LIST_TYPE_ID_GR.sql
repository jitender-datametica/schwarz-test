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
#  1.13 28.12.2021    Zied Nanaa               Add languages BE_FR and EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_itm_list_type_id_gr (listing_type_group_id
OPTIONS(description='Guppe Einlistungstype Id'), listing_type_group_desc_at
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung AT'), listing_type_group_desc_be
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung BE'), listing_type_group_desc_be_fr
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung BE_FR'), listing_type_group_desc_bg
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung BG'), listing_type_group_desc_ch
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung CH'), listing_type_group_desc_cy
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung CY'), listing_type_group_desc_cz
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung CZ'), listing_type_group_desc
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung'), listing_type_group_desc_dk
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung DK'), listing_type_group_desc_ee
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung EE'), listing_type_group_desc_es
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung ES'), listing_type_group_desc_fi
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung FI'), listing_type_group_desc_fr
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung FR'), listing_type_group_desc_gb
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung GB'), listing_type_group_desc_gr
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung GR'), listing_type_group_desc_hr
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung HR'), listing_type_group_desc_hu
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung HU'), listing_type_group_desc_ie
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung IE'), listing_type_group_desc_it
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung IT'), listing_type_group_desc_lt
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung LT'), listing_type_group_desc_lv
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung LV'), listing_type_group_desc_ni
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung NI'), listing_type_group_desc_nl
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung NL'), listing_type_group_desc_de
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung DE'), listing_type_group_desc_pl
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung PL'), listing_type_group_desc_pt
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung PT'), listing_type_group_desc_ro
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung RO'), listing_type_group_desc_se
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung SE'), listing_type_group_desc_si
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung SI'), listing_type_group_desc_sk
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung SK'), listing_type_group_desc_cs
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung CS'), listing_type_group_desc_mt
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung MT'), listing_type_group_desc_us
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung US'), listing_type_group_desc_rs
OPTIONS(description='Gruppe Einlistungstype Landesspezifische Bezeichnung RS'))
OPTIONS(DESCRIPTION = `MULTISPRACHE EINLISTUNGSTYPE GRUPPEN REFERENZ`) AS SELECT listing_type_group_id,
 listing_type_group_desc_be AS listing_type_group_desc_at,
 listing_type_group_desc_at AS listing_type_group_desc_be,
 listing_type_group_desc_be_fr,
 listing_type_group_desc_bg,
 listing_type_group_desc_ch,
 listing_type_group_desc_cy,
 listing_type_group_desc_cz,
 listing_type_group_desc,
 listing_type_group_desc_dk,
 listing_type_group_desc_ee,
 listing_type_group_desc_es,
 listing_type_group_desc_fi,
 listing_type_group_desc_fr,
 listing_type_group_desc_gb,
 listing_type_group_desc_gr,
 listing_type_group_desc_hr,
 listing_type_group_desc_hu,
 listing_type_group_desc_ie,
 listing_type_group_desc_it,
 listing_type_group_desc_lt,
 listing_type_group_desc_lv,
 listing_type_group_desc_ni,
 listing_type_group_desc_nl,
 listing_type_group_desc_de,
 listing_type_group_desc_pl,
 listing_type_group_desc_pt,
 listing_type_group_desc_ro,
 listing_type_group_desc_se,
 listing_type_group_desc_si,
 listing_type_group_desc_sk,
 listing_type_group_desc_cs,
 listing_type_group_desc_mt,
 listing_type_group_desc_us,
 listing_type_group_desc_rs
FROM ldl_p_lew_mart_msi.v_ref_itm_list_type_id_gr;
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
#  2.0  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
#  2.1  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  2.2  28.12.2021    Zied Nanaa               Add languages BE_FR and EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_itm_list_type_id_1 (listing_type_id
OPTIONS(description='Einlistungstype Id'), listing_type_desc_at
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung AT'), listing_type_desc_be
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung BE'), listing_type_desc_be_fr
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung BE_FR'), listing_type_desc_bg
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung BG'), listing_type_desc_ch
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung CH'), listing_type_desc_cy
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung CY'), listing_type_desc_cz
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung CZ'), listing_type_desc
OPTIONS(description='Einlistungstype Beschreibung'), listing_type_desc_dk
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung DK'), listing_type_desc_ee
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung EE'), listing_type_desc_es
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung ES'), listing_type_desc_fi
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung FI'), listing_type_desc_fr
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung FR'), listing_type_desc_gb
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung GB'), listing_type_desc_gr
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung GR'), listing_type_desc_hr
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung HR'), listing_type_desc_hu
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung HU'), listing_type_desc_ie
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung IE'), listing_type_desc_it
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung IT'), listing_type_desc_lt
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung LT'), listing_type_desc_lv
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung LV'), listing_type_desc_ni
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung NI'), listing_type_desc_nl
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung NL'), listing_type_desc_de
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung DE'), listing_type_desc_pl
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung PL'), listing_type_desc_pt
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung PT'), listing_type_desc_ro
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung RO'), listing_type_desc_se
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung SE'), listing_type_desc_si
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung SI'), listing_type_desc_sk
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung SK'), listing_type_desc_cs
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung CS'), listing_type_desc_mt
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung MT'), listing_type_desc_us
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung US'), listing_type_desc_rs
OPTIONS(description='Einlistungstype Landesspezifische Bezeichnung RS_1'))
OPTIONS(DESCRIPTION = `MULTISPRACHE EINLISTUNGSTYPEN REFERENZ`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ref_itm_list_type_id_1;
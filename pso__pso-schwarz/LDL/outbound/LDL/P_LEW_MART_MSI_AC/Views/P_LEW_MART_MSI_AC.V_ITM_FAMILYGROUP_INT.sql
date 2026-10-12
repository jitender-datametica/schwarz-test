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
#  1.8  03.05.2018    Wieber.Harald            Release 3.6
#  1.9  17.05.2018    Wieber,Harald            Update Release 3.8
#  1.10 07.08.2020    Roy,Ritanjal             Introduce new country Latviya
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.12 27.12.2021     Zied Nanaa               Add languages BE_FR and EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_familygroup_int (subitemgroup_id OPTIONS(description='WAWI CD'),
family_cd OPTIONS(description='Artikelfamile Landesspezifischer Code WAWI'), item_family_desc
OPTIONS(description='Artikelfamile Bezeichnung Lang'), item_family_desc_at
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang AT'), item_family_desc_be
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang BE'), item_family_desc_be_fr
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang BE_FR'), item_family_desc_bg
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang BG'), item_family_desc_ch
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang CH'), item_family_desc_cy
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang CY'), item_family_desc_cz
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang CZ'), item_family_desc_dk
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang DK'), item_family_desc_ee
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang EE'), item_family_desc_es
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang ES'), item_family_desc_fi
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang FI'), item_family_desc_fr
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang FR'), item_family_desc_gb
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang GB'), item_family_desc_gr
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang GR'), item_family_desc_hr
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang HR'), item_family_desc_hu
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang HU'), item_family_desc_ie
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang IE'), item_family_desc_it
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang IT'), item_family_desc_lt
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang LT'), item_family_desc_lv
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang LV'), item_family_desc_ni
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang NI'), item_family_desc_nl
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang NL'), item_family_desc_de
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang DE'), item_family_desc_pl
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang PL'), item_family_desc_pt
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang PT'), item_family_desc_ro
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang RO'), item_family_desc_se
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang SE'), item_family_desc_si
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang SI'), item_family_desc_sk
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang SK'), item_family_desc_cs
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang CS'), item_family_desc_mt
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang MT'), item_family_desc_us
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang US'), item_family_desc_rs
OPTIONS(description='Artikelfamile Landesspezifische Bezeichnung Lang RS'), item_family_short_desc
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung'), item_family_short_desc_at
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung AT'), item_family_short_desc_be
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung BE'), item_family_short_desc_be_fr
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung BE_FR'), item_family_short_desc_bg
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung BG'), item_family_short_desc_ch
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung CH'), item_family_short_desc_cy
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung CY'), item_family_short_desc_cz
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung CZ'), item_family_short_desc_dk
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung DK'), item_family_short_desc_ee
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung EE'), item_family_short_desc_es
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung ES'), item_family_short_desc_fi
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung FI'), item_family_short_desc_fr
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung FR'), item_family_short_desc_gb
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung GB'), item_family_short_desc_gr
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung GR'), item_family_short_desc_hr
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung HR'), item_family_short_desc_hu
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung HU'), item_family_short_desc_ie
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung IE'), item_family_short_desc_it
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung IT'), item_family_short_desc_lt
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung LT'), item_family_short_desc_lv
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung LV'), item_family_short_desc_ni
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung NI'), item_family_short_desc_nl
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung NL'), item_family_short_desc_de
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung DE'), item_family_short_desc_pl
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung PL'), item_family_short_desc_pt
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung PT'), item_family_short_desc_ro
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung RO'), item_family_short_desc_se
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung SE'), item_family_short_desc_si
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung SI'), item_family_short_desc_sk
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung SK'), item_family_short_desc_cs
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung CS'), item_family_short_desc_mt
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung MT'), item_family_short_desc_us
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung US'), item_family_short_desc_rs
OPTIONS(description='Artikelfamile Landesspezifische Kurzbezeichnung RS'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE INTERNATIONAL ITEM FAMILY GROUP DESCRIPTIONS`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_familygroup_int;
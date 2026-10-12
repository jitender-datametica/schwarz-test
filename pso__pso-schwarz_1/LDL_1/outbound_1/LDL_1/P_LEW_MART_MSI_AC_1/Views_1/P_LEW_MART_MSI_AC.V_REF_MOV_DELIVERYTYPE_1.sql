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
# 1.11  07.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_mov_deliverytype_1 (client_id OPTIONS(description='Landeskennzeichen'),
deliverytype_id OPTIONS(description='Anlieferart - Konstanten: 1 = Zuteilungen / 2 = Kommisionierlisten'),
deliverytype_desc_at OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung AT'), deliverytype_desc_be
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung BE'), deliverytype_desc_be_fr
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung BE_FR'), deliverytype_desc_bg
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung BG'), deliverytype_desc_ch
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung CH'), deliverytype_desc_cy
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung CY'), deliverytype_desc_cz
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung CZ'), deliverytype_desc
OPTIONS(description='Anlieferart - Bezeichnung'), deliverytype_desc_dk
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung DK'), deliverytype_desc_ee
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung EE'), deliverytype_desc_es
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung ES'), deliverytype_desc_fi
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung FI'), deliverytype_desc_fr
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung FR'), deliverytype_desc_gb
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung GB'), deliverytype_desc_gr
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung GR'), deliverytype_desc_hr
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung HR'), deliverytype_desc_hu
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung HU'), deliverytype_desc_ie
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung IE'), deliverytype_desc_it
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung IT'), deliverytype_desc_lt
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung LT'), deliverytype_desc_lv
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung LV'), deliverytype_desc_ni
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung NI'), deliverytype_desc_nl
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung NL'), deliverytype_desc_de
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung DE'), deliverytype_desc_pl
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung PL'), deliverytype_desc_pt
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung PT'), deliverytype_desc_ro
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung RO'), deliverytype_desc_se
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung SE'), deliverytype_desc_si
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung SI'), deliverytype_desc_sk
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung SK'), deliverytype_desc_cs
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung CS'), deliverytype_desc_mt
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung MT'), deliverytype_desc_us
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung US'), deliverytype_desc_rs
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung RS_1'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE DELIVERY TYPE REFERENCE VIEW`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ref_mov_deliverytype_1;
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
#  1.10 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              Patch: 20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 28.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_cal_week_partial_week_desc_1 (cy_week_partial_week_id1
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Id - Zusammenfesetzte ID aus Jahr/KW'), cy_week_partial_week_id2
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche - Wochenart Id- 1 = erster Teil - 2 = zweiter Teil - 9 = ganze Woche_1'),
cy_week_partial_week_id
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Id - Zusammenfesetzte ID aus Jahr/KW/Wochenart - 1 = erster Teil - 2 = zweiter Teil - 9 = ganze Woche_1'),
cy_week_partial_week_desc_at OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung AT'),
cy_week_partial_week_desc_be OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE'),
cy_week_partial_week_desc_be_fr
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE_FR'), cy_week_partial_week_desc_bg
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BG'), cy_week_partial_week_desc_ch
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CH'), cy_week_partial_week_desc_cy
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CY'), cy_week_partial_week_desc_cz
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CZ'), cy_week_partial_week_desc
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Bezeichnung'), cy_week_partial_week_desc_dk
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DK'), cy_week_partial_week_desc_ee
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung EE'), cy_week_partial_week_desc_es
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung ES'), cy_week_partial_week_desc_fi
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FI'), cy_week_partial_week_desc_fr
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FR'), cy_week_partial_week_desc_gb
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GB'), cy_week_partial_week_desc_gr
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GR'), cy_week_partial_week_desc_hr
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HR'), cy_week_partial_week_desc_hu
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HU'), cy_week_partial_week_desc_ie
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IE'), cy_week_partial_week_desc_it
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IT'), cy_week_partial_week_desc_lt
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LT'), cy_week_partial_week_desc_lv
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LV'), cy_week_partial_week_desc_ni
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NI'), cy_week_partial_week_desc_nl
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NL'), cy_week_partial_week_desc_de
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DE'), cy_week_partial_week_desc_pl
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PL'), cy_week_partial_week_desc_pt
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PT'), cy_week_partial_week_desc_ro
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RO'), cy_week_partial_week_desc_se
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SE'), cy_week_partial_week_desc_si
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SI'), cy_week_partial_week_desc_sk
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SK'), cy_week_partial_week_desc_cs
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CS'), cy_week_partial_week_desc_mt
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung MT'), cy_week_partial_week_desc_us
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung US'), cy_week_partial_week_desc_rs
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RS_1'), cy_week_partial_week_desc_s_at
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung AT kurz'),
cy_week_partial_week_desc_s_be
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE kurz'),
cy_week_partial_week_desc_s_be_fr
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE_FR kurz'),
cy_week_partial_week_desc_s_bg
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BG kurz'),
cy_week_partial_week_desc_s_ch
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CH kurz'),
cy_week_partial_week_desc_s_cy
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CY kurz'),
cy_week_partial_week_desc_s_cz
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CZ kurz'),
cy_week_partial_week_desc_s OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Kurzbezeichnung'),
cy_week_partial_week_desc_s_dk
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DK kurz'),
cy_week_partial_week_desc_s_ee
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung EE kurz'),
cy_week_partial_week_desc_s_es
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung ES kurz'),
cy_week_partial_week_desc_s_fi
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FI kurz'),
cy_week_partial_week_desc_s_fr
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FR kurz'),
cy_week_partial_week_desc_s_gb
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GB kurz'),
cy_week_partial_week_desc_s_gr
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GR kurz'),
cy_week_partial_week_desc_s_hr
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HR kurz'),
cy_week_partial_week_desc_s_hu
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HU kurz'),
cy_week_partial_week_desc_s_ie
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IE kurz'),
cy_week_partial_week_desc_s_it
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IT kurz'),
cy_week_partial_week_desc_s_lt
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LT kurz'),
cy_week_partial_week_desc_s_lv
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LV kurz'),
cy_week_partial_week_desc_s_ni
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NI kurz'),
cy_week_partial_week_desc_s_nl
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NL kurz'),
cy_week_partial_week_desc_s_de
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DE kurz'),
cy_week_partial_week_desc_s_pl
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PL kurz'),
cy_week_partial_week_desc_s_pt
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PT kurz'),
cy_week_partial_week_desc_s_ro
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RO kurz'),
cy_week_partial_week_desc_s_se
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SE kurz'),
cy_week_partial_week_desc_s_si
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SI kurz'),
cy_week_partial_week_desc_s_sk
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SK kurz'),
cy_week_partial_week_desc_s_cs
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CS kurz'),
cy_week_partial_week_desc_s_mt
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung MT kurz'),
cy_week_partial_week_desc_s_us
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung US kurz'),
cy_week_partial_week_desc_s_rs
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RS_1 kurz'), desc_wo_year
OPTIONS(description='Default Teilwoche Bezeichnung ohne Geschäftsjahr'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE PARZTIAL WEEK DECSRIPTIONS`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_cal_week_partial_week_desc_1;
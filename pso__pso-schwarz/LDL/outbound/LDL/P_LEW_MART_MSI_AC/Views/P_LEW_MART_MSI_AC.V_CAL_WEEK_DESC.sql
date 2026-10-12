/* #----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            ReleASe 1.1
#  1.2  17.01.2018    Wieber,Harald            ReleASe 2.2
#  1.3  30.07.2020    Morris, Michael          20200730_2551_Litauen_lang_ref_data (INC2047852) REP4-6910
#                                              Kalenderwoche-Kurzel auf 'KS' geändert für Litauen LT
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  16.09.2021    Jaroslaw Syrokosz        Change from v_wawi_cal_week to v_cal_week https://jira.schwarz/browse/REP2-10367
#                                              OVERwrite previous changes AS agreed in https://jira.schwarz/browse/REP4-7173
#  1.6  23.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_cal_week_desc (cy_week
OPTIONS(description='Geschäftsjahr - Woche Id - Format JJJJMM'), cy_week_desc_at
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung AT'), cy_week_desc_be
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung BE'), cy_week_desc_be_fr
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung BE_FR'), cy_week_desc_bg
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung BG'), cy_week_desc_ch
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung CH'), cy_week_desc_cy
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung CY'), cy_week_desc_cz
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung CZ'), cy_week_desc
OPTIONS(description='Geschäftsjahr - Woche Bezeichnung'), cy_week_desc_dk
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung DK'), cy_week_desc_ee
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung EE'), cy_week_desc_es
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung ES'), cy_week_desc_fi
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung FI'), cy_week_desc_fr
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung FR'), cy_week_desc_gb
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung GB'), cy_week_desc_gr
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung GR'), cy_week_desc_hr
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung HR'), cy_week_desc_hu
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung HU'), cy_week_desc_ie
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung IE'), cy_week_desc_it
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung IT'), cy_week_desc_lt
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung LT'), cy_week_desc_lv
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung LV'), cy_week_desc_ni
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung NI'), cy_week_desc_nl
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung NL'), cy_week_desc_de
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung DE'), cy_week_desc_pl
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung PL'), cy_week_desc_pt
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung PT'), cy_week_desc_ro
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung RO'), cy_week_desc_se
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung SE'), cy_week_desc_si
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung SI'), cy_week_desc_sk
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung SK'), cy_week_desc_cs
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung CS'), cy_week_desc_mt
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung MT'), cy_week_desc_us
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung US'), cy_week_desc_rs
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Bezeichnung RS'), cy_week_desc_short_at
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung AT'), cy_week_desc_short_be
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung BE'), cy_week_desc_short_be_fr
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung BE_FR'), cy_week_desc_short_bg
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung BG'), cy_week_desc_short_ch
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung CH'), cy_week_desc_short_cy
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung CY'), cy_week_desc_short_cz
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung CZ'), cy_week_desc_short
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung'), cy_week_desc_short_dk
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung DK'), cy_week_desc_short_ee
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung EE'), cy_week_desc_short_es
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung ES'), cy_week_desc_short_fi
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung FI'), cy_week_desc_short_fr
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung FR'), cy_week_desc_short_gb
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung GB'), cy_week_desc_short_gr
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung GR'), cy_week_desc_short_hr
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung HR'), cy_week_desc_short_hu
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung HU'), cy_week_desc_short_ie
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung IE'), cy_week_desc_short_it
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung IT'), cy_week_desc_short_lt
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung LT'), cy_week_desc_short_lv
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung LV'), cy_week_desc_short_ni
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung NI'), cy_week_desc_short_nl
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung NL'), cy_week_desc_short_de
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung DE'), cy_week_desc_short_pl
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung PL'), cy_week_desc_short_pt
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung PT'), cy_week_desc_short_ro
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung RO'), cy_week_desc_short_se
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung SE'), cy_week_desc_short_si
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung SI'), cy_week_desc_short_sk
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung SK'), cy_week_desc_short_cs
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung CS'), cy_week_desc_short_mt
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung MT'), cy_week_desc_short_us
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung US'), cy_week_desc_short_rs
OPTIONS(description='Geschäftsjahr - Woche Landesspezifische Kurzbezeichnung RS'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE WEEK DESCRIPTIONS`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_cal_week_desc;
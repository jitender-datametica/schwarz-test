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
#  1.10 10.08.2020    Roy,Ritanjal             Introduce new country Latviya
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              Patch: 20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 23.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_cal_week_partial_week (cy_week_partial_week_id1
OPTIONS(description='Geschäftsjahr - Woche/Teilwoche Id - Zusammenfesetzte ID aus Jahr/KW'), cy_week_partial_week_id2
OPTIONS(description='Geschäftsjahr - Woche/Teilwoche - Wochenart Id- 1 = erster Teil - 2 = zweiter Teil - 9 = ganze Woche'),
cy_week_partial_week_name
OPTIONS(description='Geschäftsjahr - Woche/Teilwoche - Name der Woche - Format = JJJJ KW 99 plus /1 für den ersten Teil oder /2 für den zweiten Teil der Woche'),
cy_month OPTIONS(description='Monat des Geschäftsjahres im Format JJJJMM'), byr OPTIONS(description='Käufer'),
cy_week_partial_week_id
OPTIONS(description='Geschäftsjahr - Woche/Teilwoche Id - Zusammenfesetzte ID aus Jahr/KW/Wochenart - 1 = erster Teil - 2 = zweiter Teil - 9 = ganze Woche'),
partialweek_in_mth_seq_asc OPTIONS(description='Partialk Bez. Einheit asc'), partialweek_in_mth_seq_desc
OPTIONS(description='Partialk Bez. Einheit desc'), cy_partial_week_short_desc_at
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung AT'), cy_partial_week_short_desc_be
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung BE'), cy_partial_week_short_desc_be_fr
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung BE_FR'), cy_partial_week_short_desc_bg
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung BG'), cy_partial_week_short_desc_ch
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung CH'), cy_partial_week_short_desc_cy
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung CY'), cy_partial_week_short_desc_cz
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung CZ'), cy_partial_week_short_desc
OPTIONS(description='Geschäftsjahr - Teilwoche Kurzbezeichnung'), cy_partial_week_short_desc_dk
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung DK'), cy_partial_week_short_desc_ee
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung EE'), cy_partial_week_short_desc_es
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung ES'), cy_partial_week_short_desc_fi
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung FI'), cy_partial_week_short_desc_fr
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung FR'), cy_partial_week_short_desc_gb
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung GB'), cy_partial_week_short_desc_gr
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung GR'), cy_partial_week_short_desc_hr
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung HR'), cy_partial_week_short_desc_hu
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung HU'), cy_partial_week_short_desc_ie
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung IE'), cy_partial_week_short_desc_it
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung IT'), cy_partial_week_short_desc_lt
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung LT'), cy_partial_week_short_desc_lv
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung LV'), cy_partial_week_short_desc_ni
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung NI'), cy_partial_week_short_desc_nl
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung NL'), cy_partial_week_short_desc_de
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung DE'), cy_partial_week_short_desc_pl
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung PL'), cy_partial_week_short_desc_pt
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung PT'), cy_partial_week_short_desc_ro
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung RO'), cy_partial_week_short_desc_se
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung SE'), cy_partial_week_short_desc_si
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung SI'), cy_partial_week_short_desc_sk
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung SK'), cy_partial_week_short_desc_cs
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung CS'), cy_partial_week_short_desc_mt
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung MT'), cy_partial_week_short_desc_us
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung US'), cy_partial_week_short_desc_rs
OPTIONS(description='Geschäftsjahr - Teilwoche kurz Landesspezifische Bezeichnung RS'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE PARTIAL WEEK DESCRIPTIONS`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_cal_week_partial_week;
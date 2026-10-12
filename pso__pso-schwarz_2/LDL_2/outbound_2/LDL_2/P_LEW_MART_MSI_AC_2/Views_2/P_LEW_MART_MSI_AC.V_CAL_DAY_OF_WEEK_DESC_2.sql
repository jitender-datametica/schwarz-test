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
#  1.9  17.05.2018    Wieber.Harald            Update Release 3.8
# 1.10  16.01.2019    Mike Davis               Slight reformat + comments.
# 1.11  19.11.2019    Meister,Ulrich           Patch 20191118_2292_Persistierung_Kalender_DWH20 (IDMO-2460, DWH-4137)
# 1.12  07.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
# 1.13  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.14  22.12.2021    Zied Nanaa               Add language Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_cal_day_of_week_desc_2 (day_of_week OPTIONS(description='Wochentag'),
day_of_week_desc_at OPTIONS(description='Wochentag Landesspezifische Bezeichnung AT'), day_of_week_desc_be
OPTIONS(description='Wochentag Landesspezifische Bezeichnung BE'), day_of_week_desc_be_fr
OPTIONS(description='Wochentag Landesspezifische Bezeichnung BE_FR'), day_of_week_desc_bg
OPTIONS(description='Wochentag Landesspezifische Bezeichnung BG'), day_of_week_desc_ch
OPTIONS(description='Wochentag Landesspezifische Bezeichnung CH'), day_of_week_desc_cy
OPTIONS(description='Wochentag Landesspezifische Bezeichnung CY'), day_of_week_desc_cz
OPTIONS(description='Wochentag Landesspezifische Bezeichnung CZ'), day_of_week_desc
OPTIONS(description='Wochentag Bezeichnung'), day_of_week_desc_dk
OPTIONS(description='Wochentag Landesspezifische Bezeichnung DK'), day_of_week_desc_ee
OPTIONS(description='Wochentag Landesspezifische Bezeichnung EE'), day_of_week_desc_es
OPTIONS(description='Wochentag Landesspezifische Bezeichnung ES'), day_of_week_desc_fi
OPTIONS(description='Wochentag Landesspezifische Bezeichnung FI'), day_of_week_desc_fr
OPTIONS(description='Wochentag Landesspezifische Bezeichnung FR'), day_of_week_desc_gb
OPTIONS(description='Wochentag Landesspezifische Bezeichnung GB'), day_of_week_desc_gr
OPTIONS(description='Wochentag Landesspezifische Bezeichnung GR'), day_of_week_desc_hr
OPTIONS(description='Wochentag Landesspezifische Bezeichnung HR'), day_of_week_desc_hu
OPTIONS(description='Wochentag Landesspezifische Bezeichnung HU'), day_of_week_desc_ie
OPTIONS(description='Wochentag Landesspezifische Bezeichnung IE'), day_of_week_desc_it
OPTIONS(description='Wochentag Landesspezifische Bezeichnung IT'), day_of_week_desc_lt
OPTIONS(description='Wochentag Landesspezifische Bezeichnung LT'), day_of_week_desc_lv
OPTIONS(description='Wochentag Landesspezifische Bezeichnung LV'), day_of_week_desc_ni
OPTIONS(description='Wochentag Landesspezifische Bezeichnung NI'), day_of_week_desc_nl
OPTIONS(description='Wochentag Landesspezifische Bezeichnung NL'), day_of_week_desc_de
OPTIONS(description='Wochentag Landesspezifische Bezeichnung DE'), day_of_week_desc_pl
OPTIONS(description='Wochentag Landesspezifische Bezeichnung PL'), day_of_week_desc_pt
OPTIONS(description='Wochentag Landesspezifische Bezeichnung PT'), day_of_week_desc_ro
OPTIONS(description='Wochentag Landesspezifische Bezeichnung RO'), day_of_week_desc_se
OPTIONS(description='Wochentag Landesspezifische Bezeichnung SE'), day_of_week_desc_si
OPTIONS(description='Wochentag Landesspezifische Bezeichnung SI'), day_of_week_desc_sk
OPTIONS(description='Wochentag Landesspezifische Bezeichnung SK'), day_of_week_desc_cs
OPTIONS(description='Wochentag Landesspezifische Bezeichnung CS'), day_of_week_desc_mt
OPTIONS(description='Wochentag Landesspezifische Bezeichnung MT'), day_of_week_desc_us
OPTIONS(description='Wochentag Landesspezifische Bezeichnung US'), day_of_week_desc_rs
OPTIONS(description='Wochentag Landesspezifische Bezeichnung RS_2'), day_of_week_desc_short_at
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung AT'), day_of_week_desc_short_be
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung BE'), day_of_week_desc_short_be_fr
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung BE_FR'), day_of_week_desc_short_bg
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung BG'), day_of_week_desc_short_ch
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung CH'), day_of_week_desc_short_cy
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung CY'), day_of_week_desc_short_cz
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung CZ'), day_of_week_desc_short
OPTIONS(description='Wochentag Kurzeschreibung'), day_of_week_desc_short_dk
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung DK'), day_of_week_desc_short_ee
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung EE'), day_of_week_desc_short_es
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung ES'), day_of_week_desc_short_fi
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung FI'), day_of_week_desc_short_fr
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung FR'), day_of_week_desc_short_gb
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung GB'), day_of_week_desc_short_gr
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung GR'), day_of_week_desc_short_hr
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung HR'), day_of_week_desc_short_hu
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung HU'), day_of_week_desc_short_ie
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung IE'), day_of_week_desc_short_it
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung IT'), day_of_week_desc_short_lt
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung LT'), day_of_week_desc_short_lv
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung LT'), day_of_week_desc_short_ni
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung NI'), day_of_week_desc_short_nl
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung NL'), day_of_week_desc_short_de
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung DE'), day_of_week_desc_short_pl
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung PL'), day_of_week_desc_short_pt
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung PT'), day_of_week_desc_short_ro
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung RO'), day_of_week_desc_short_se
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung SE'), day_of_week_desc_short_si
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung SI'), day_of_week_desc_short_sk
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung SK'), day_of_week_desc_short_cs
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung CS'), day_of_week_desc_short_mt
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung MT'), day_of_week_desc_short_us
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung US'), day_of_week_desc_short_rs
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung RS_2'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE DAY OF WEEK DESCRIPTIONS`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_cal_day_of_week_desc_2;
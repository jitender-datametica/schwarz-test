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
#  1.10 07.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_mainitemgroup_1 (mainitemgroup_id
OPTIONS(description='WAWI Quellschluessel'), mainitemgroup_desc_at
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit AT'), mainitemgroup_desc_be
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit BE'), mainitemgroup_desc_be_fr
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit BE_FR'), mainitemgroup_desc_bg
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit BG'), mainitemgroup_desc_ch
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit CH'), mainitemgroup_desc_cy
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit CY'), mainitemgroup_desc_cz
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit CZ'), mainitemgroup_desc
OPTIONS(description='Mainitek generische Bezeichnung'), mainitemgroup_desc_dk
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit DK'), mainitemgroup_desc_ee
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit EE'), mainitemgroup_desc_es
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit ES'), mainitemgroup_desc_fi
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit FI'), mainitemgroup_desc_fr
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit FR'), mainitemgroup_desc_gb
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit GB'), mainitemgroup_desc_gr
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit GR'), mainitemgroup_desc_hr
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit HR'), mainitemgroup_desc_hu
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit HU'), mainitemgroup_desc_ie
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit IE'), mainitemgroup_desc_it
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit IT'), mainitemgroup_desc_lt
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit LT'), mainitemgroup_desc_lv
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit LV'), mainitemgroup_desc_ni
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit NI'), mainitemgroup_desc_nl
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit NL'), mainitemgroup_desc_de
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit DE'), mainitemgroup_desc_pl
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit PL'), mainitemgroup_desc_pt
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit PT'), mainitemgroup_desc_ro
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit RO'), mainitemgroup_desc_se
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit SE'), mainitemgroup_desc_si
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit SI'), mainitemgroup_desc_sk
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit SK'), mainitemgroup_desc_cs
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit CS'), mainitemgroup_desc_mt
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit MT'), mainitemgroup_desc_us
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit US'), mainitemgroup_desc_rs
OPTIONS(description='Mainitek Landesspezifische Bezeichnung Einheit RS_1'), mainitemgroup_short_desc_at
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit AT'), mainitemgroup_short_desc_be
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit BE'), mainitemgroup_short_desc_be_fr
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit BE_FR'), mainitemgroup_short_desc_bg
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit BG'), mainitemgroup_short_desc_ch
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit CH'), mainitemgroup_short_desc_cy
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit CY'), mainitemgroup_short_desc_cz
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit CZ'), mainitemgroup_short_desc
OPTIONS(description='Mainitek generische Kurzbezeichnung'), mainitemgroup_short_desc_dk
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit DK'), mainitemgroup_short_desc_ee
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit EE'), mainitemgroup_short_desc_es
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit ES'), mainitemgroup_short_desc_fi
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit FI'), mainitemgroup_short_desc_fr
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit FR'), mainitemgroup_short_desc_gb
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit GB'), mainitemgroup_short_desc_gr
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit GR'), mainitemgroup_short_desc_hr
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit HR'), mainitemgroup_short_desc_hu
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit HU'), mainitemgroup_short_desc_ie
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit IE'), mainitemgroup_short_desc_it
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit IT'), mainitemgroup_short_desc_lt
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit LT'), mainitemgroup_short_desc_lv
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit LV'), mainitemgroup_short_desc_ni
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit NI'), mainitemgroup_short_desc_nl
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit NL'), mainitemgroup_short_desc_de
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit DE'), mainitemgroup_short_desc_pl
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit PL'), mainitemgroup_short_desc_pt
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit PT'), mainitemgroup_short_desc_ro
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit RO'), mainitemgroup_short_desc_se
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit SE'), mainitemgroup_short_desc_si
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit SI'), mainitemgroup_short_desc_sk
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit SK'), mainitemgroup_short_desc_cs
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit CS'), mainitemgroup_short_desc_mt
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit MT'), mainitemgroup_short_desc_us
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit US'), mainitemgroup_short_desc_rs
OPTIONS(description='Mainitek Landesspezifische Kurzbezeichnung Einheit RS_1'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE MAINITEK BEZEICHNUNGEN`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_mainitemgroup_1;
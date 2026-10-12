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
#  2.1  08.06.2020    Roy, Ritanjal            Introduce new country Latviya
#  2.2  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  2.3  28.12.2021    Zied Nanaa               Add languages BE_FR and EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_itm_logist_unit (logistic_unit_cd
OPTIONS(description='Kennz. Einheit (Liter, Kilo etc)'), client_id OPTIONS(description='Landeskennzeichen'),
logistic_unit_desc_at OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit AT'), logistic_unit_desc_be
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit BE'), logistic_unit_desc_be_fr
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit BE_FR'), logistic_unit_desc_bg
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit BG'), logistic_unit_desc_ch
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit CH'), logistic_unit_desc_cy
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit CY'), logistic_unit_desc_cz
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit CZ'), logistic_unit_desc
OPTIONS(description='Bezinh Einheit'), logistic_unit_desc_dk
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit DK'), logistic_unit_desc_ee
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit EE'), logistic_unit_desc_es
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit ES'), logistic_unit_desc_fi
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit FI'), logistic_unit_desc_fr
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit FR'), logistic_unit_desc_gb
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit GB'), logistic_unit_desc_gr
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit GR'), logistic_unit_desc_hr
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit HR'), logistic_unit_desc_hu
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit HU'), logistic_unit_desc_ie
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit IE'), logistic_unit_desc_it
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit IT'), logistic_unit_desc_lt
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit LT'), logistic_unit_desc_lv
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit LV'), logistic_unit_desc_ni
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit NI'), logistic_unit_desc_nl
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit NL'), logistic_unit_desc_de
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit DE'), logistic_unit_desc_pl
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit PL'), logistic_unit_desc_pt
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit PT'), logistic_unit_desc_ro
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit RO'), logistic_unit_desc_se
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit SE'), logistic_unit_desc_si
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit SI'), logistic_unit_desc_sk
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit SK'), logistic_unit_desc_cs
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit CS'), logistic_unit_desc_mt
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit MT'), logistic_unit_desc_us
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit US'), logistic_unit_desc_rs
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit RS'), logistic_base_unit
OPTIONS(description='Logistik Basiseinheit (1kg)'), logistic_base_factor
OPTIONS(description='Logistik Basisfaktor (1000)'), logistic_base_unit_int
OPTIONS(description='Logistik Internationale Einheit (g)'), logistic_base_factor_int
OPTIONS(description='Logistik Internationaler faktor (1000)'))
OPTIONS(DESCRIPTION = `MULTISPRACHE LOGISTIKEINHEITEN REFERENZ`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ref_itm_logist_unit;
/* #----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-03-12 Barbara Seneta         Initial version
#  1.1 07.08.2020 Roy,Ritanjal           Introduce new country Latviya
#  1.2 04.01.2022 Michael Morris         Added Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_country_lead (int_id OPTIONS(description='Lidl International ID'),
country_id OPTIONS(description='Landeskennzeichen'), country_iso_cd OPTIONS(description='Landeskürzel'),
country_group_id OPTIONS(description='Landesgruppen Kennzeichen'), lisy_sort OPTIONS(description='Lisy sort Wert'),
dashboard_relevant_fg OPTIONS(description='Dashboardrelevant'), country_desc_at
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung AT'), country_desc_be
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung BE'), country_desc_bg
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung BG'), country_desc_ch
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung CH'), country_desc_cy
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung CY'), country_desc_cz
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung CZ'), country_desc
OPTIONS(description='Filial-Land Bezeichnung'), country_desc_dk
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung DK'), country_desc_ee
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung EE'), country_desc_es
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung ES'), country_desc_fi
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung FI'), country_desc_fr
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung FR'), country_desc_gb
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung GB'), country_desc_gr
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung GR'), country_desc_hr
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung HR'), country_desc_hu
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung HU'), country_desc_ie
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung IE'), country_desc_it
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung IT'), country_desc_lt
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung LT'), country_desc_lv
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung LV'), country_desc_ni
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung NI'), country_desc_nl
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung NL'), country_desc_de
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung DE'), country_desc_pl
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung PL'), country_desc_pt
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung PT'), country_desc_ro
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung RO'), country_desc_se
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung SE'), country_desc_si
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung SI'), country_desc_sk
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung SK'), country_desc_cs
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung CS'), country_desc_mt
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung MT'), country_desc_us
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung US'), country_desc_rs
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung RS'))
OPTIONS(DESCRIPTION = `LEAD PROJECT - COUNTRY LEAD REFERENCE VIEW`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_ref_country_lead;
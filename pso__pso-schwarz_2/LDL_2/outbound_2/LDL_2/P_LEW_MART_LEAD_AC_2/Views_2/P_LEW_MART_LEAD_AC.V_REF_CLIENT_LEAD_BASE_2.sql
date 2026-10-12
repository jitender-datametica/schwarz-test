/* #----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-03-12 Barbara Seneta         Initial version
#  1.1 2020-08-07 Roy, Ritanjal          Introduce new country_2 Latviya
#  1.2 04.01.2022 Michael Morris         Added Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_client_lead_base_2 (int_id
OPTIONS(description='Lidl International ID'), client_id OPTIONS(description='Mandant_2'), country_iso_cd
OPTIONS(description='Landeskürzel'), country_group_id OPTIONS(description='Landesgruppen Kennzeichen'), lisy_sort
OPTIONS(description='lisy sort'), dashboard_relevant_fg OPTIONS(description='Dashboardrelevant'), country_desc_at
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung AT'), country_desc_be
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung BE'), country_desc_bg
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung BG'), country_desc_ch
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung CH'), country_desc_cy
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung CY'), country_desc_cz
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung CZ'), country_desc
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung'), country_desc_dk
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung DK'), country_desc_ee
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung EE'), country_desc_es
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung ES'), country_desc_fi
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung FI'), country_desc_fr
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung FR'), country_desc_gb
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung GB'), country_desc_gr
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung GR'), country_desc_hr
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung HR'), country_desc_hu
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung HU'), country_desc_ie
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung IE'), country_desc_it
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung IT'), country_desc_lt
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung LT'), country_desc_lv
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung LV'), country_desc_ni
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung NI'), country_desc_nl
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung NL'), country_desc_de
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung DE'), country_desc_pl
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung PL'), country_desc_pt
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung PT'), country_desc_ro
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung RO'), country_desc_se
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung SE'), country_desc_si
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung SI'), country_desc_sk
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung SK'), country_desc_cs
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung CS'), country_desc_mt
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung MT'), country_desc_us
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung US'), country_desc_rs
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung RS_2'), country_opening_date
OPTIONS(description='Eröffnungsdatum Land_2')) OPTIONS(DESCRIPTION = `LEAD PROJECT - CLIENT LEAD BASE REFERENCE VIEW`) AS
SELECT *
FROM ldl_p_lew_mart_lead.v_ref_client_lead_base_2;
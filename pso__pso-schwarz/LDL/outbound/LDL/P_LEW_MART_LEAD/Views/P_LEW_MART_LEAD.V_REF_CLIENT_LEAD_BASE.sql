/* #----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- ----------------------------------
#  1.0 2020-03-12 Barbara Seneta         Initial version
#  1.1 08.06.2020 Roy,Ritanjal           Introduce new country latviya
#  1.2 03.01.2022 Morris, Michael        Added Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_client_lead_base (int_id OPTIONS(description='Lidl International ID'),
client_id OPTIONS(description='Mandant'), country_iso_cd OPTIONS(description='Landeskürzel'), country_group_id
OPTIONS(description='Landesgruppen Kennzeichen'), lisy_sort OPTIONS(description='lisy sort'), dashboard_relevant_fg
OPTIONS(description='Dashboardrelevant'), country_desc_at
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung AT'), country_desc_be
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung BE'), country_desc_bg
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung BG'), country_desc_ch
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung CH'), country_desc_cy
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung CY'), country_desc_cz
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung CZ'), country_desc
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung'), country_desc_dk
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
OPTIONS(description='Filial-Land Landesspezifische Bezeichnung RS'), country_opening_date
OPTIONS(description='Eröffnungsdatum Land')) OPTIONS(DESCRIPTION = `LEAD PROJECT - CLIENT LEAD BASE REFERENCE VIEW`) AS
/* Referenzierung des Landes */ SELECT int_id,
 country_id AS client_id,
 country_iso_cd /* Country ISO_Code, Landeskürzel */,
 country_group_id /* techn. DWH- Schlüssel zur Referenzierung der Vorstandsregion */,
 lisy_sort /* Sortierung aus dem Vorsystem Lisy */,
 dashboard_relevant_fg /* Für Lead Dashboard relevant */,
 country_desc_at,
 country_desc_be,
 country_desc_bg,
 country_desc_ch,
 country_desc_cy,
 country_desc_cz,
 country_desc,
 country_desc_dk,
 country_desc_ee,
 country_desc_es,
 country_desc_fi,
 country_desc_fr,
 country_desc_gb,
 country_desc_gr,
 country_desc_hr,
 country_desc_hu,
 country_desc_ie,
 country_desc_it,
 country_desc_lt,
 country_desc_lv,
 country_desc_ni,
 country_desc_nl,
 country_desc_de,
 country_desc_pl,
 country_desc_pt,
 country_desc_ro,
 country_desc_se,
 country_desc_si,
 country_desc_sk,
 country_desc_cs,
 country_desc_mt,
 country_desc_us,
 country_desc_rs,
  CASE
  WHEN country_id = 23
  THEN '1973'
  WHEN country_id = 12
  THEN '04/1989'
  WHEN country_id = 18
  THEN '03/1992'
  WHEN country_id = 10
  THEN '04/1994'
  WHEN country_id = 13
  THEN '11/1994'
  WHEN country_id = 2
  THEN '04/1995'
  WHEN country_id = 25
  THEN '07/1995'
  WHEN country_id = 22
  THEN '10/1997'
  WHEN country_id = 1
  THEN '11/1998'
  WHEN country_id = 21
  THEN '05/1999'
  WHEN country_id = 14
  THEN '06/1999'
  WHEN country_id = 17
  THEN '07/2000'
  WHEN country_id = 24
  THEN '04/2002'
  WHEN country_id = 11
  THEN '08/2002'
  WHEN country_id = 6
  THEN '06/2003'
  WHEN country_id = 27
  THEN '09/2003'
  WHEN country_id = 29
  THEN '09/2004'
  WHEN country_id = 16
  THEN '11/2004'
  WHEN country_id = 8
  THEN '09/2005'
  WHEN country_id = 15
  THEN '11/2006'
  WHEN country_id = 28
  THEN '03/2007'
  WHEN country_id = 32
  THEN '04/2008'
  WHEN country_id = 4
  THEN '03/2009'
  WHEN country_id = 31
  THEN '02/2010'
  WHEN country_id IN (3, 26)
  THEN '01/2010'
  WHEN country_id = 5
  THEN '11/2010'
  WHEN country_id = 19
  THEN '03/2016'
  WHEN country_id = 33
  THEN '01/2017'
  WHEN country_id = 34
  THEN '03/2018'
  WHEN country_id = 20
  THEN '01/2020'
  WHEN country_id = 9
  THEN '03/2022'
  ELSE '01/1900'
  END AS country_opening_date
FROM ldl_p_lew_mart_lead.v_ref_country_lead;
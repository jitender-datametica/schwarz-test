
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017  -                 Generiert aus Teradata
#  1.1  15.11.2017  Wieber,Harald     Release 1.1
#  1.2  17.01.2018  Wieber,Harald     Release 2.2
#  1.3  09.10.2018  J. Graeff         20181009_1854_RS_Korrektur_Landesnamen
#                                     correct US and RS_2 value for country_opening_date
#  1.3  2018-10-09    Joerg  Gräff    adapt country_opening_date for serbia and us
#                                     20181009_1854_RS_Korrektur_Landesnamen
#  1.4  06.08.2020    Roy, Ritanjal   Introduce new country_2 Latviya
#  1.5  17.12.2021  Michael Morris    Added Estonia EE
#  1.6  23.08.2024  Malec, Marcin     Added column vs_sort, with an additional country_2 sorting logic; User Story 665161
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_ref_client_lead_2 AS SELECT int_id,
 country_id AS client_id,
 country_iso_cd,
 country_group_id,
 lisy_sort,
 vs_sort,
 dashboard_relevant_fg,
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
 country_desc_ni,
 country_desc_nl,
 country_desc_de,
 country_desc_lv,
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
  THEN '04/2021'
  WHEN country_id = 9
  THEN '03/2022'
  ELSE '01/1900'
  END AS country_opening_date
FROM ldl_p_lew_mart_msi.v_ref_country_lead_2;
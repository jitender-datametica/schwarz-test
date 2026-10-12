CREATE OR REPLACE VIEW ldl_p_lew_bil.v_ref_client_lead (int_id, client_id, country_iso_cd, country_group_id, lisy_sort,
dashboard_relevant_fg, country_desc_at, country_desc_be, country_desc_be_fr, country_desc_bg, country_desc_ch,
country_desc_cy, country_desc_cz, country_desc, country_desc_dk, country_desc_ee, country_desc_es, country_desc_fi,
country_desc_fr, country_desc_gb, country_desc_gr, country_desc_hr, country_desc_hu, country_desc_ie, country_desc_it,
country_desc_lt, country_desc_ni, country_desc_nl, country_desc_de, country_desc_lv, country_desc_pl, country_desc_pt,
country_desc_ro, country_desc_se, country_desc_si, country_desc_sk, country_desc_cs, country_desc_mt, country_desc_us,
country_desc_rs, country_opening_date) AS /* Referenzierung des Landes */ SELECT int_id,
 country_id AS client_id,
 country_iso_cd /* Country ISO_Code, Landeskürzel */,
 country_group_id /* techn. DWH- Schlüssel zur Referenzierung der Vorstandsregion */,
 lisy_sort /* Sortierung aus dem Vorsystem Lisy */,
 dashboard_relevant_fg /* Für Lead Dashboard relevant */,
 country_desc_at,
 country_desc_be,
 country_desc_be_fr,
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
 country_desc_lv AS country_desc_de,
 country_desc_de AS country_desc_lv,
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
  WHEN country_id = 20
  THEN '04/2020'
  WHEN country_id = 33
  THEN '01/2017'
  WHEN country_id = 34
  THEN '03/2018'
  WHEN country_id = 9
  THEN '03/2022'
  ELSE '01/1900'
  END AS country_opening_date
FROM ldl_p_lew_bil.v_ref_country_lead;
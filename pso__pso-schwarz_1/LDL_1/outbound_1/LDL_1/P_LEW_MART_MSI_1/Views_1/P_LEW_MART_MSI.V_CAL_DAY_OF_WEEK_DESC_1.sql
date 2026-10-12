/* #----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL FOR P_LEW_MART_MSI.V_CAL_DAY_OF_WEEK_DESC_1 .
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            ReleASe 1.1
#  1.2  17.01.2018    Wieber,Harald            ReleASe 2.2
#  1.3  06.08.2020    Roy,Ritanjal             Introduce new country_1 LV
#  1.4  27.11.2020    Morris, Michael          Add Column(s) FOR _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.2  16.09.2021    Jaroslaw Syrokosz        Change from using CORE v_wawi_cal_day_of_week_desc_1 to view from BIL https://jira.schwarz/browse/REP2-10367
#                                              OVERwrite previous changes AS agreed in https://jira.schwarz/browse/REP4-7173
#  1.3  15.12.2021    Michael Morris           Added Estonia EE & BE_FR
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_day_of_week_desc_1 (day_of_week OPTIONS(description='Wochentag'),
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
OPTIONS(description='Wochentag Landesspezifische Bezeichnung RS_1'), day_of_week_desc_short_at
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
OPTIONS(description='Wochentag Landesspezifische Kurzbezeichnung RS_1'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE DAY OF WEEK DESCRIPTIONS`) AS SELECT day_of_week,
 day_of_week_name_de AS day_of_week_desc_at,
 day_of_week_name_nl AS day_of_week_desc_be,
 day_of_week_name_fr AS day_of_week_desc_be_fr,
  CASE
  WHEN day_of_week = 1
  THEN 'Понеделник'
  WHEN day_of_week = 2
  THEN 'Вторник'
  WHEN day_of_week = 3
  THEN 'Сряда'
  WHEN day_of_week = 4
  THEN 'Четвъртък'
  WHEN day_of_week = 5
  THEN 'Петък'
  WHEN day_of_week = 6
  THEN 'Събота'
  WHEN day_of_week = 7
  THEN 'Неделя'
  ELSE NULL
  END AS day_of_week_desc_bg,
 day_of_week_name_de AS day_of_week_desc_ch,
 day_of_week_name_el AS day_of_week_desc_cy,
 day_of_week_name_cs AS day_of_week_desc_cz,
 day_of_week_name AS day_of_week_desc,
 day_of_week_name_da AS day_of_week_desc_dk,
  CASE
  WHEN day_of_week = 1
  THEN 'Esmaspäev'
  WHEN day_of_week = 2
  THEN 'Teisipäev'
  WHEN day_of_week = 3
  THEN 'Kolmapäev'
  WHEN day_of_week = 4
  THEN 'Neljapäev'
  WHEN day_of_week = 5
  THEN 'Reede'
  WHEN day_of_week = 6
  THEN 'Laupäev'
  WHEN day_of_week = 7
  THEN 'Pühapäev'
  ELSE NULL
  END AS day_of_week_desc_ee,
 day_of_week_name_es AS day_of_week_desc_es,
 day_of_week_name_fi AS day_of_week_desc_fi,
 day_of_week_name_fr AS day_of_week_desc_fr,
 day_of_week_name_en AS day_of_week_desc_gb,
 day_of_week_name_el AS day_of_week_desc_gr,
 day_of_week_name_hr AS day_of_week_desc_hr,
 day_of_week_name_hu AS day_of_week_desc_hu,
 day_of_week_name_en AS day_of_week_desc_ie,
 day_of_week_name_it AS day_of_week_desc_it,
  UPPER(SUBSTR(day_of_week_name_lt, 1, 1)) || SUBSTR(day_of_week_name_lt, 2) AS day_of_week_desc_lt,
  CASE
  WHEN day_of_week = 1
  THEN 'Pirmdiena'
  WHEN day_of_week = 2
  THEN 'Otrdiena'
  WHEN day_of_week = 3
  THEN 'Tresdiena'
  WHEN day_of_week = 4
  THEN 'Ceturtdiena'
  WHEN day_of_week = 5
  THEN 'Piektdiena'
  WHEN day_of_week = 6
  THEN 'Sestdiena'
  WHEN day_of_week = 7
  THEN 'Svetdiena'
  ELSE NULL
  END AS day_of_week_desc_lv,
 day_of_week_name_en AS day_of_week_desc_ni,
 day_of_week_name_nl AS day_of_week_desc_nl,
 day_of_week_name_de AS day_of_week_desc_de,
 day_of_week_name_pl AS day_of_week_desc_pl,
 day_of_week_name_pt AS day_of_week_desc_pt,
 day_of_week_name_ro AS day_of_week_desc_ro,
 day_of_week_name_sv AS day_of_week_desc_se,
  CASE
  WHEN day_of_week = 4
  THEN 'Četrtek'
  ELSE day_of_week_name_sl
  END AS day_of_week_desc_si,
  CASE
  WHEN day_of_week = 7
  THEN 'Nedeľa'
  ELSE day_of_week_name_sk
  END AS day_of_week_desc_sk,
 day_of_week_name_es AS day_of_week_desc_cs,
 day_of_week_name_en AS day_of_week_desc_mt,
 day_of_week_name_en AS day_of_week_desc_us,
  CASE
  WHEN day_of_week = 1
  THEN 'Ponedeljak'
  WHEN day_of_week = 2
  THEN 'Utorak'
  WHEN day_of_week = 3
  THEN 'Sreda'
  WHEN day_of_week = 4
  THEN 'Cetvrtak'
  WHEN day_of_week = 5
  THEN 'Petak'
  WHEN day_of_week = 6
  THEN 'Subota'
  WHEN day_of_week = 7
  THEN 'Nedelja'
  ELSE NULL
  END AS day_of_week_desc_rs,
 SUBSTR(day_of_week_name_de, 1, 2) AS day_of_week_desc_short_at,
 SUBSTR(day_of_week_name_nl, 1, 2) AS day_of_week_desc_short_be,
 SUBSTR(day_of_week_name_fr, 1, 2) AS day_of_week_desc_short_be_fr,
 SUBSTR(CASE
   WHEN day_of_week = 1
   THEN 'Понеделник'
   WHEN day_of_week = 2
   THEN 'Вторник'
   WHEN day_of_week = 3
   THEN 'Сряда'
   WHEN day_of_week = 4
   THEN 'Четвъртък'
   WHEN day_of_week = 5
   THEN 'Петък'
   WHEN day_of_week = 6
   THEN 'Събота'
   WHEN day_of_week = 7
   THEN 'Неделя'
   ELSE NULL
   END, 1, 2) AS day_of_week_desc_short_bg,
 SUBSTR(day_of_week_name_de, 1, 2) AS day_of_week_desc_short_ch,
 SUBSTR(day_of_week_name_el, 1, 2) AS day_of_week_desc_short_cy,
 SUBSTR(day_of_week_name_cs, 1, 2) AS day_of_week_desc_short_cz,
 SUBSTR(day_of_week_name, 1, 2) AS day_of_week_desc_short,
 SUBSTR(day_of_week_name_da, 1, 2) AS day_of_week_desc_short_dk,
 SUBSTR(CASE
   WHEN day_of_week = 1
   THEN 'Esmaspäev'
   WHEN day_of_week = 2
   THEN 'Teisipäev'
   WHEN day_of_week = 3
   THEN 'Kolmapäev'
   WHEN day_of_week = 4
   THEN 'Neljapäev'
   WHEN day_of_week = 5
   THEN 'Reede'
   WHEN day_of_week = 6
   THEN 'Laupäev'
   WHEN day_of_week = 7
   THEN 'Pühapäev'
   ELSE NULL
   END, 1, 2) AS day_of_week_desc_short_ee,
 SUBSTR(day_of_week_name_es, 1, 2) AS day_of_week_desc_short_es,
 SUBSTR(day_of_week_name_fi, 1, 2) AS day_of_week_desc_short_fi,
 SUBSTR(day_of_week_name_fr, 1, 2) AS day_of_week_desc_short_fr,
 SUBSTR(day_of_week_name_en, 1, 2) AS day_of_week_desc_short_gb,
 SUBSTR(day_of_week_name_el, 1, 2) AS day_of_week_desc_short_gr,
 SUBSTR(day_of_week_name_hr, 1, 2) AS day_of_week_desc_short_hr,
 SUBSTR(day_of_week_name_hu, 1, 2) AS day_of_week_desc_short_hu,
 SUBSTR(day_of_week_name_en, 1, 2) AS day_of_week_desc_short_ie,
 SUBSTR(day_of_week_name_it, 1, 2) AS day_of_week_desc_short_it,
 SUBSTR(UPPER(SUBSTR(day_of_week_name_lt, 1, 1)) || SUBSTR(day_of_week_name_lt, 2), 1, 2) AS day_of_week_desc_short_lt,
 SUBSTR(day_of_week_name_de, 1, 2) AS day_of_week_desc_short_lv,
 SUBSTR(day_of_week_name_en, 1, 2) AS day_of_week_desc_short_ni,
 SUBSTR(day_of_week_name_nl, 1, 2) AS day_of_week_desc_short_nl,
 SUBSTR(day_of_week_name_de, 1, 2) AS day_of_week_desc_short_de,
 SUBSTR(day_of_week_name_pl, 1, 2) AS day_of_week_desc_short_pl,
 SUBSTR(day_of_week_name_pt, 1, 2) AS day_of_week_desc_short_pt,
 SUBSTR(day_of_week_name_ro, 1, 2) AS day_of_week_desc_short_ro,
 SUBSTR(day_of_week_name_sv, 1, 2) AS day_of_week_desc_short_se,
 SUBSTR(CASE
   WHEN day_of_week = 4
   THEN 'Četrtek'
   ELSE day_of_week_name_sl
   END, 1, 2) AS day_of_week_desc_short_si,
 SUBSTR(CASE
   WHEN day_of_week = 7
   THEN 'Nedeľa'
   ELSE day_of_week_name_sk
   END, 1, 2) AS day_of_week_desc_short_sk,
 SUBSTR(day_of_week_name_es, 1, 2) AS day_of_week_desc_short_cs,
 SUBSTR(day_of_week_name_en, 1, 2) AS day_of_week_desc_short_mt,
 SUBSTR(day_of_week_name_en, 1, 2) AS day_of_week_desc_short_us,
 SUBSTR(CASE
   WHEN day_of_week = 1
   THEN 'Ponedeljak'
   WHEN day_of_week = 2
   THEN 'Utorak'
   WHEN day_of_week = 3
   THEN 'Sreda'
   WHEN day_of_week = 4
   THEN 'Cetvrtak'
   WHEN day_of_week = 5
   THEN 'Petak'
   WHEN day_of_week = 6
   THEN 'Subota'
   WHEN day_of_week = 7
   THEN 'Nedelja'
   ELSE NULL
   END, 1, 2) AS day_of_week_desc_short_rs
FROM ldl_p_lew_bil_ac.v_dim_cal_day_of_week_1
WHERE day_of_week <> - 1;
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_month_desc_1 (month_id
OPTIONS(description='Month number in calendar_1 year: i.e. in range 1-12.'), cy_month
OPTIONS(description='Calendar_1 month in form YYYYMM.'), cy OPTIONS(description='Calendar_1 year in form YYYY.'), byr
OPTIONS(description='Business year in form YYYY.'), cy_month_name_at
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code AT.'),
cy_month_name_be
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code BE.'),
cy_month_name_be_fr
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code BE_FR.'),
cy_month_name_bg
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code BG.'),
cy_month_name_ch
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code CH.'),
cy_month_name_cy
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code CY.'),
cy_month_name_cz
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code CZ.'),
cy_month_name
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the organization (German).'),
cy_month_name_dk
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code DK.'),
cy_month_name_ee
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code EE.'),
cy_month_name_es
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code ES.'),
cy_month_name_fi
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code FI.'),
cy_month_name_fr
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code FR.'),
cy_month_name_gb
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code GB.'),
cy_month_name_gr
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code GR.'),
cy_month_name_hr
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code HR.'),
cy_month_name_hu
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code HU.'),
cy_month_name_ie
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code IE.'),
cy_month_name_it
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code IT.'),
cy_month_name_lt
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code LT.'),
cy_month_name_lv
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code LV.'),
cy_month_name_ni
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code NI.'),
cy_month_name_nl
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code NL.'),
cy_month_name_de
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code DE.'),
cy_month_name_pl
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code PL.'),
cy_month_name_pt
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code PT.'),
cy_month_name_ro
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code RO.'),
cy_month_name_se
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code SE.'),
cy_month_name_si
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code SI.'),
cy_month_name_sk
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code SK.'),
cy_month_name_cs
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code CS.'),
cy_month_name_mt
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code MT.'),
cy_month_name_us
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code US.'),
cy_month_name_rs
OPTIONS(description='Month name + Calendar_1 year in the form "Name YYYY" where "Name" is the name of the month in the language associated with the country_1 of code RS.'),
cy_month_name_short_at
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code AT.'),
cy_month_name_short_be
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code BE.'),
cy_month_name_short_be_fr
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code BE_fr.'),
cy_month_name_short_bg
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code BG.'),
cy_month_name_short_ch
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code CH.'),
cy_month_name_short_cy
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code CY.'),
cy_month_name_short_cz
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code CZ.'),
cy_month_name_short
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the  organization (German).'),
cy_month_name_short_dk
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code DK.'),
cy_month_name_short_ee
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code EE.'),
cy_month_name_short_es
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code ES.'),
cy_month_name_short_fi
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code FI.'),
cy_month_name_short_fr
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code FR.'),
cy_month_name_short_gb
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code GB.'),
cy_month_name_short_gr
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code GR.'),
cy_month_name_short_hr
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code HR.'),
cy_month_name_short_hu
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code HU.'),
cy_month_name_short_ie
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code IE.'),
cy_month_name_short_it
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code IT.'),
cy_month_name_short_lt
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code LT.'),
cy_month_name_short_lv
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code LV.'),
cy_month_name_short_ni
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code NI.'),
cy_month_name_short_nl
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code NL.'),
cy_month_name_short_de
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code DE.'),
cy_month_name_short_pl
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code PL.'),
cy_month_name_short_pt
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code PT.'),
cy_month_name_short_ro
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code RO.'),
cy_month_name_short_se
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code SE.'),
cy_month_name_short_si
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code SI.'),
cy_month_name_short_sk
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code SK.'),
cy_month_name_short_cs
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code CS.'),
cy_month_name_short_mt
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code MT.'),
cy_month_name_short_us
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code US.'),
cy_month_name_short_rs
OPTIONS(description='Short month name in the form "MMM" where "MMM" are the first 3 characters of the name of the month in the language associated with the country_1 of code RS.'),
month_name_at
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code AT.'),
month_name_be
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code BE.'),
month_name_be_fr
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code BE_fr.'),
month_name_bg
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code BG.'),
month_name_ch
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code CH.'),
month_name_cy
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code CY.'),
month_name_cz
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code CZ.'),
month_name
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the organization (German).'),
month_name_dk
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code DK.'),
month_name_ee
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code EE.'),
month_name_es
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code ES.'),
month_name_fi
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code FI.'),
month_name_fr
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code FR.'),
month_name_gb
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code GB.'),
month_name_gr
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code GR.'),
month_name_hr
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code HR.'),
month_name_hu
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code HU.'),
month_name_ie
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code IE.'),
month_name_it
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code IT.'),
month_name_lt
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code LT.'),
month_name_lv
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code LV.'),
month_name_ni
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code NI.'),
month_name_nl
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code NL.'),
month_name_de
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code DE.'),
month_name_pl
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code PL.'),
month_name_pt
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code PT.'),
month_name_ro
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code RO.'),
month_name_se
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code SE.'),
month_name_si
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code SI.'),
month_name_sk
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code SK.'),
month_name_cs
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code CS.'),
month_name_mt
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code MT.'),
month_name_us
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code US.'),
month_name_rs
OPTIONS(description='Month name only in the form "Name" where "Name" is the name of the month in the language associated with the country_1 of code RS.'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE MONTH NAME REFERENCE`) AS SELECT month_id,
 cy_month,
 cy,
 byr,
 cy_month_name_at,
 cy_month_name_be,
 cy_month_name_fr AS cy_month_name_be_fr,
 cy_month_name_bg,
 cy_month_name_ch,
 cy_month_name_cy,
 cy_month_name_cz,
 cy_month_name,
 cy_month_name_dk,
 cy_month_name_ee,
 cy_month_name_es,
 cy_month_name_fi,
 cy_month_name_fr,
 cy_month_name_gb,
 cy_month_name_gr,
 cy_month_name_hr,
 cy_month_name_hu,
 cy_month_name_ie,
 cy_month_name_it,
 cy_month_name_lt,
 cy_month_name_lv,
 cy_month_name_ni,
 cy_month_name_nl,
 cy_month_name_de,
 cy_month_name_pl,
 cy_month_name_pt,
 cy_month_name_ro,
 cy_month_name_se,
 cy_month_name_si,
 cy_month_name_sk,
 cy_month_name_cs,
 cy_month_name_mt,
 cy_month_name_us,
 cy_month_name_rs,
 cy_month_name_short_at,
 cy_month_name_short_be,
 cy_month_name_short_fr AS cy_month_name_short_be_fr,
 cy_month_name_short_bg,
 cy_month_name_short_ch,
 cy_month_name_short_cy,
 cy_month_name_short_cz,
 cy_month_name_short,
 cy_month_name_short_dk,
 cy_month_name_short_ee,
 cy_month_name_short_es,
 cy_month_name_short_fi,
 cy_month_name_short_fr,
 cy_month_name_short_gb,
 cy_month_name_short_gr,
 cy_month_name_short_hr,
 cy_month_name_short_hu,
 cy_month_name_short_ie,
 cy_month_name_short_it,
 cy_month_name_short_lt,
 cy_month_name_short_lv,
 cy_month_name_short_ni,
 cy_month_name_short_nl,
 cy_month_name_short_de,
 cy_month_name_short_pl,
 cy_month_name_short_pt,
 cy_month_name_short_ro,
 cy_month_name_short_se,
 cy_month_name_short_si,
 cy_month_name_short_sk,
 cy_month_name_short_cs,
 cy_month_name_short_mt,
 cy_month_name_short_us,
 cy_month_name_short_rs,
 month_name_at,
 month_name_be,
 month_name_fr AS month_name_be_fr,
 month_name_bg,
 month_name_ch,
 month_name_cy,
 month_name_cz,
 month_name,
 month_name_dk,
 month_name_ee,
 month_name_es,
 month_name_fi,
 month_name_fr,
 month_name_gb,
 month_name_gr,
 month_name_hr,
 month_name_hu,
 month_name_ie,
 month_name_it,
 month_name_lt,
 month_name_lv,
 month_name_ni,
 month_name_nl,
 month_name_de,
 month_name_pl,
 month_name_pt,
 month_name_ro,
 month_name_se,
 month_name_si,
 month_name_sk,
 month_name_cs,
 month_name_mt,
 month_name_us,
 month_name_rs
FROM ldl_p_lew_mart_msi.t_cal_month_desc_1;
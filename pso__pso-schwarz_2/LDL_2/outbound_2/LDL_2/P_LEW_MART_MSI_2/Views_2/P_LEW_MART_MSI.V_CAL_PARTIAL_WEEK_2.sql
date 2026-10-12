CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_partial_week_2 (cy_week
OPTIONS(description='Iso week number in form YYYYWW. Iso week number uses the calendar_2 year in which the Thursday of the week lies and the count of Thursdays so far in that calendar_2 year (inclusive).'),
cy_partial_week
OPTIONS(description='Component number of the partial week in the week. If a week lies wholly in 1 month then it has 1 component (1 partial week) of component number 1. If it straddles 2 months then the component in the 1st month is 1 and in the second month is 2'),
cy_partial_week_name
OPTIONS(description='Name of partial week in form "TW WW/ P  YYYY" where TW=TW WW=01-53 P=1or2 YYYY=cy.'),
cy_partial_week_short_name OPTIONS(description='Shorter version of cy_week_part name in form "TW WW/ P".'), cy_month
OPTIONS(description='Month in which the partial week lies. In the form year+month ie. YYYYMM.'), cy
OPTIONS(description='Calendar_2 year.'), byr
OPTIONS(description='Business year. I.e. from beginning of March to end of the following February inclusively.'),
dat_valid_from OPTIONS(description='Calendar_2 date of the first day in the partial week.'), dat_valid_until
OPTIONS(description='Calendar_2 date of the last day in the partial week.'), partialweek_in_mth_seq_asc
OPTIONS(description='Sequence number of the partial week in the calendar_2 month (in cy_month) in ascending order starting at 1.'),
partialweek_in_mth_seq_desc
OPTIONS(description='Sequence number of the partial week in the calendar_2 month (in cy_month) in descending order finishing at 1.'),
cy_partial_week_short_desc_at
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation AT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_be
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation BE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_be_fr
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation BE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_bg
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation BG of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_ch
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation CH of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_cy
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation CY of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_cz
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation CZ of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the organizational language (German) of the first and last weekdays in the format "DD - DD". For example "Mo - Do" for Monday to Thursday.'),
cy_partial_week_short_desc_dk
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation DK of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_ee
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation EE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_es
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation ES of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_fi
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation FI of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_fr
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation FR of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_gb
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation GB of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_gr
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation GR of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_hr
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation HR of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_hu
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation HU of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_ie
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation IE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_it
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation IT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_lt
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation LT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_lv
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation LV of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_ni
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation NI of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_nl
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation NL of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_de
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation DE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_pl
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation PL of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_pt
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation PT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_ro
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation RO of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_se
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation SE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_si
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation SI of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_sk
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation SK of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_cs
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation CS of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_mt
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation MT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_us
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation US of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_rs
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country_2 abbreviation RS_2 of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE PARTIAL WEEK REFERENCE`) AS SELECT cy_week,
 cy_partial_week,
 cy_partial_week_name,
 cy_partial_week_short_name,
 cy_month,
 cy,
 byr,
 dat_valid_from,
 dat_valid_until,
 partialweek_in_mth_seq_asc,
 partialweek_in_mth_seq_desc,
 cy_partial_week_short_desc_at,
 cy_partial_week_short_desc_be,
 cy_partial_week_short_desc_fr AS cy_partial_week_short_desc_be_fr,
 cy_partial_week_short_desc_bg,
 cy_partial_week_short_desc_ch,
 cy_partial_week_short_desc_cy,
 cy_partial_week_short_desc_cz,
 cy_partial_week_short_desc,
 cy_partial_week_short_desc_dk,
 cy_partial_week_short_desc_ee,
 cy_partial_week_short_desc_es,
 cy_partial_week_short_desc_fi,
 cy_partial_week_short_desc_fr,
 cy_partial_week_short_desc_gb,
 cy_partial_week_short_desc_gr,
 cy_partial_week_short_desc_hr,
 cy_partial_week_short_desc_hu,
 cy_partial_week_short_desc_ie,
 cy_partial_week_short_desc_it,
 cy_partial_week_short_desc_lt,
 cy_partial_week_short_desc_lv,
 cy_partial_week_short_desc_ni,
 cy_partial_week_short_desc_nl,
 cy_partial_week_short_desc_de,
 cy_partial_week_short_desc_pl,
 cy_partial_week_short_desc_pt,
 cy_partial_week_short_desc_ro,
 cy_partial_week_short_desc_se,
 cy_partial_week_short_desc_si,
 cy_partial_week_short_desc_sk,
 cy_partial_week_short_desc_cs,
 cy_partial_week_short_desc_mt,
 cy_partial_week_short_desc_us,
 cy_partial_week_short_desc_rs
FROM ldl_p_lew_mart_msi.t_cal_partial_week_2;
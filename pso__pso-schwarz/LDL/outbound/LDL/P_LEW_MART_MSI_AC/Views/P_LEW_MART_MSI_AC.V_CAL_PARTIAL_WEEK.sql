CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_cal_partial_week (cy_week
OPTIONS(description='Iso week number in form YYYYWW. Iso week number uses the calendar year in which the Thursday of the week lies and the count of Thursdays so far in that calendar year (inclusive).'),
cy_partial_week
OPTIONS(description='Component number of the partial week in the week. If a week lies wholly in 1 month then it has 1 component (1 partial week) of component number 1. If it straddles 2 months then the component in the 1st month is 1 and in the second month is 2'),
cy_partial_week_name
OPTIONS(description='Name of partial week in form "TW WW/ P  YYYY" where TW=TW WW=01-53 P=1or2 YYYY=cy.'),
cy_partial_week_short_name OPTIONS(description='Shorter version of cy_week_part name in form "TW WW/ P".'), cy_month
OPTIONS(description='Month in which the partial week lies. In the form year+month ie. YYYYMM.'), cy
OPTIONS(description='Calendar year.'), byr
OPTIONS(description='Business year. I.e. from beginning of March to end of the following February inclusively.'),
dat_valid_from OPTIONS(description='Calendar date of the first day in the partial week.'), dat_valid_until
OPTIONS(description='Calendar date of the last day in the partial week.'), partialweek_in_mth_seq_asc
OPTIONS(description='Sequence number of the partial week in the calendar month (in cy_month) in ascending order starting at 1.'),
partialweek_in_mth_seq_desc
OPTIONS(description='Sequence number of the partial week in the calendar month (in cy_month) in descending order finishing at 1.'),
cy_partial_week_short_desc_at
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation AT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_be
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation BE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_be_fr
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation BE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_bg
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation BG of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_ch
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation CH of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_cy
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation CY of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_cz
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation CZ of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the organizational language (German) of the first and last weekdays in the format "DD - DD". For example "Mo - Do" for Monday to Thursday.'),
cy_partial_week_short_desc_dk
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation DK of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_ee
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation EE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_es
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation ES of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_fi
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation FI of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_fr
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation FR of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_gb
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation GB of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_gr
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation GR of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_hr
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation HR of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_hu
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation HU of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_ie
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation IE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_it
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation IT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_lt
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation LT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_lv
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation LT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_ni
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation NI of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_nl
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation NL of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_de
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation DE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_pl
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation PL of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_pt
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation PT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_ro
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation RO of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_se
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation SE of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_si
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation SI of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_sk
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation SK of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_cs
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation CS of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_mt
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation MT of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_us
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation US of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'),
cy_partial_week_short_desc_rs
OPTIONS(description='If partial week is a full week then Null. If partial week is not a full week then a description in the language associated with the country abbreviation RS of the first and last weekdays in the format "DD - DD".See cy_partial_week_short_desc for example.'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE PARTIAL WEEK REFERENCE`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_cal_partial_week;
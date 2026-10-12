CREATE OR REPLACE VIEW s_conl.v_cal_week_partial_week_2
AS
/* 
#DescStart# 
#$Revision: 6244 $, $LastChangedBy: hwieber $ 
#SubjectAreas#: Kalender 
#DescEnd# 
*/
SELECT
cy_week_partial_week_id1,
cy_week_partial_week_id2,
cy_week_partial_week_name,
cy_month,
busyear AS byr,
cy_week_partial_week_id,
partialweek_in_mth_seq_asc,
partialweek_in_mth_seq_desc,
cy_partial_week_short_desc_AT,
cy_partial_week_short_desc_BE,
cy_partial_week_short_desc_BG,
cy_partial_week_short_desc_CH,
cy_partial_week_short_desc_CY,
cy_partial_week_short_desc_CZ,
cy_partial_week_short_desc,
cy_partial_week_short_desc_DK,
cy_partial_week_short_desc_ES,
cy_partial_week_short_desc_FI,
cy_partial_week_short_desc_FR,
cy_partial_week_short_desc_GB,
cy_partial_week_short_desc_GR,
cy_partial_week_short_desc_HR,
cy_partial_week_short_desc_HU,
cy_partial_week_short_desc_IE,
cy_partial_week_short_desc_IT,
cy_partial_week_short_desc_LT,
cy_partial_week_short_desc_NI,
cy_partial_week_short_desc_NL,
cy_partial_week_short_desc_DE,
cy_partial_week_short_desc_PL,
cy_partial_week_short_desc_PT,
cy_partial_week_short_desc_RO,
cy_partial_week_short_desc_SE,
cy_partial_week_short_desc_SI,
cy_partial_week_short_desc_SK,
cy_partial_week_short_desc_CS,
cy_partial_week_short_desc_MT,
cy_partial_week_short_desc_US,
cy_partial_week_short_desc_RS
FROM p_lew_core_ac.v_wawi_cal_week_partial_week_2;

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_core_ac.v_wawi_cal_week_partial_week_rel_2" ***/


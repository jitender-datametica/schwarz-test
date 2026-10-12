CREATE OR REPLACE VIEW s_conl.v_cal_month_desc
AS
/* 
#DescStart# 
#$Revision: 6244 $, $LastChangedBy: hwieber $ 
#SubjectAreas#: Kalender 
#DescEnd# 
*/
(
SELECT
month_id,
cy_month,
cy,
byr,
MAX(CASE
WHEN language_id = 1 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_AT,
MAX(CASE
WHEN language_id = 2 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_BE,
MAX(CASE
WHEN language_id = 3 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_BG,
MAX(CASE
WHEN language_id = 4 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_CH,
MAX(CASE
WHEN language_id = 5 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_CY,
MAX(CASE
WHEN language_id = 6 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_CZ,
MAX(CASE
WHEN language_id = 7 THEN cy_month_name
ELSE NULL END ) AS cy_month_name,
MAX(CASE
WHEN language_id = 8 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_DK,
MAX(CASE
WHEN language_id = 10 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_ES,
MAX(CASE
WHEN language_id = 11 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_FI,
MAX(CASE
WHEN language_id = 12 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_FR,
MAX(CASE
WHEN language_id = 13 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_GB,
MAX(CASE
WHEN language_id = 14 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_GR,
MAX(CASE
WHEN language_id = 15 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_HR,
MAX(CASE
WHEN language_id = 16 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_HU,
MAX(CASE
WHEN language_id = 17 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_IE,
MAX(CASE
WHEN language_id = 18 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_IT,
MAX(CASE
WHEN language_id = 19 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_LT,
MAX(CASE
WHEN language_id = 21 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_NI,
MAX(CASE
WHEN language_id = 22 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_NL,
MAX(CASE
WHEN language_id = 23 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_DE,
MAX(CASE
WHEN language_id = 24 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_PL,
MAX(CASE
WHEN language_id = 25 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_PT,
MAX(CASE
WHEN language_id = 26 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_RO,
MAX(CASE
WHEN language_id = 27 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_SE,
MAX(CASE
WHEN language_id = 28 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_SI,
MAX(CASE
WHEN language_id = 29 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_SK,
MAX(CASE
WHEN language_id = 31 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_CS,
MAX(CASE
WHEN language_id = 32 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_MT,
MAX(CASE
WHEN language_id = 33 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_US,
MAX(CASE
WHEN language_id = 34 THEN cy_month_name
ELSE NULL END ) AS cy_month_name_RS,
MAX(CASE
WHEN language_id = 1 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_AT,
MAX(CASE
WHEN language_id = 2 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_BE,
MAX(CASE
WHEN language_id = 3 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_BG,
MAX(CASE
WHEN language_id = 4 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_CH,
MAX(CASE
WHEN language_id = 5 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_CY,
MAX(CASE
WHEN language_id = 6 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_CZ,
MAX(CASE
WHEN language_id = 7 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short,
MAX(CASE
WHEN language_id = 8 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_DK,
MAX(CASE
WHEN language_id = 10 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_ES,
MAX(CASE
WHEN language_id = 11 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_FI,
MAX(CASE
WHEN language_id = 12 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_FR,
MAX(CASE
WHEN language_id = 13 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_GB,
MAX(CASE
WHEN language_id = 14 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_GR,
MAX(CASE
WHEN language_id = 15 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_HR,
MAX(CASE
WHEN language_id = 16 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_HU,
MAX(CASE
WHEN language_id = 17 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_IE,
MAX(CASE
WHEN language_id = 18 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_IT,
MAX(CASE
WHEN language_id = 19 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_LT,
MAX(CASE
WHEN language_id = 21 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_NI,
MAX(CASE
WHEN language_id = 22 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_NL,
MAX(CASE
WHEN language_id = 23 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_DE,
MAX(CASE
WHEN language_id = 24 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_PL,
MAX(CASE
WHEN language_id = 25 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_PT,
MAX(CASE
WHEN language_id = 26 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_RO,
MAX(CASE
WHEN language_id = 27 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_SE,
MAX(CASE
WHEN language_id = 28 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_SI,
MAX(CASE
WHEN language_id = 29 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_SK,
MAX(CASE
WHEN language_id = 31 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_CS,
MAX(CASE
WHEN language_id = 32 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_MT,
MAX(CASE
WHEN language_id = 33 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_US,
MAX(CASE
WHEN language_id = 34 THEN cy_month_name_short
ELSE NULL END ) AS cy_month_name_short_RS,
MAX(CASE
WHEN language_id = 1 THEN month_name
ELSE NULL END ) AS month_name_AT,
MAX(CASE
WHEN language_id = 2 THEN month_name
ELSE NULL END ) AS month_name_BE,
MAX(CASE
WHEN language_id = 3 THEN month_name
ELSE NULL END ) AS month_name_BG,
MAX(CASE
WHEN language_id = 4 THEN month_name
ELSE NULL END ) AS month_name_CH,
MAX(CASE
WHEN language_id = 5 THEN month_name
ELSE NULL END ) AS month_name_CY,
MAX(CASE
WHEN language_id = 6 THEN month_name
ELSE NULL END ) AS month_name_CZ,
MAX(CASE
WHEN language_id = 7 THEN month_name
ELSE NULL END ) AS month_name,
MAX(CASE
WHEN language_id = 8 THEN month_name
ELSE NULL END ) AS month_name_DK,
MAX(CASE
WHEN language_id = 10 THEN month_name
ELSE NULL END ) AS month_name_ES,
MAX(CASE
WHEN language_id = 11 THEN month_name
ELSE NULL END ) AS month_name_FI,
MAX(CASE
WHEN language_id = 12 THEN month_name
ELSE NULL END ) AS month_name_FR,
MAX(CASE
WHEN language_id = 13 THEN month_name
ELSE NULL END ) AS month_name_GB,
MAX(CASE
WHEN language_id = 14 THEN month_name
ELSE NULL END ) AS month_name_GR,
MAX(CASE
WHEN language_id = 15 THEN month_name
ELSE NULL END ) AS month_name_HR,
MAX(CASE
WHEN language_id = 16 THEN month_name
ELSE NULL END ) AS month_name_HU,
MAX(CASE
WHEN language_id = 17 THEN month_name
ELSE NULL END ) AS month_name_IE,
MAX(CASE
WHEN language_id = 18 THEN month_name
ELSE NULL END ) AS month_name_IT,
MAX(CASE
WHEN language_id = 19 THEN month_name
ELSE NULL END ) AS month_name_LT,
MAX(CASE
WHEN language_id = 21 THEN month_name
ELSE NULL END ) AS month_name_NI,
MAX(CASE
WHEN language_id = 22 THEN month_name
ELSE NULL END ) AS month_name_NL,
MAX(CASE
WHEN language_id = 23 THEN month_name
ELSE NULL END ) AS month_name_DE,
MAX(CASE
WHEN language_id = 24 THEN month_name
ELSE NULL END ) AS month_name_PL,
MAX(CASE
WHEN language_id = 25 THEN month_name
ELSE NULL END ) AS month_name_PT,
MAX(CASE
WHEN language_id = 26 THEN month_name
ELSE NULL END ) AS month_name_RO,
MAX(CASE
WHEN language_id = 27 THEN month_name
ELSE NULL END ) AS month_name_SE,
MAX(CASE
WHEN language_id = 28 THEN month_name
ELSE NULL END ) AS month_name_SI,
MAX(CASE
WHEN language_id = 29 THEN month_name
ELSE NULL END ) AS month_name_SK,
MAX(CASE
WHEN language_id = 31 THEN month_name
ELSE NULL END ) AS month_name_CS,
MAX(CASE
WHEN language_id = 32 THEN month_name
ELSE NULL END ) AS month_name_MT,
MAX(CASE
WHEN language_id = 33 THEN month_name
ELSE NULL END ) AS month_name_US,
MAX(CASE
WHEN language_id = 34 THEN month_name
ELSE NULL END ) AS month_name_RS
FROM
(SELECT
c1.month_id,
c2.cy_month,
c2.cy,
c2.busyear  AS  byr,
c1.language_id,
c1.month_name || ' ' || TRIM(c2.cy)  AS cy_month_name,
c1.month_name_short AS cy_month_name_short,
c1.month_name
FROM p_lew_core_ac.v_wawi_cal_month_desc c1

INNER JOIN p_lew_core_ac.v_wawi_cal_month AS c2
ON c1.month_id = c2.month_id
) x

GROUP BY
month_id
, cy_month
, cy
, byr
);

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_core_ac.v_wawi_cal_partial_week" ***/


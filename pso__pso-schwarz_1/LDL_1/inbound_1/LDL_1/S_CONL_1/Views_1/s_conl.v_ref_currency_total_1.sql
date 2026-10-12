CREATE OR REPLACE VIEW s_conl.v_ref_currency_total_1
AS
/* 
#DescStart# 
#$Revision: 6244 $, $LastChangedBy: hwieber $ 
#SubjectAreas#: Währung 
#DescEnd# 
*/
SELECT
CASE
WHEN currency_iso_cd = 'EUR' THEN 0
WHEN currency_iso_cd = 'GBP' THEN 40
ELSE client_id END AS curr_tot_id,
currency_iso_cd,
currency_desc
FROM p_lew_core_ac.v_wawi_ref_currency_act_1
GROUP BY
curr_tot_id
, currency_iso_cd
, currency_desc;

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_ref_gl_region_1", "p_lew_core_ac.v_wawi_ref_client_country_1", "p_lew_core_ac.v_wawi_ref_country_1" ***/


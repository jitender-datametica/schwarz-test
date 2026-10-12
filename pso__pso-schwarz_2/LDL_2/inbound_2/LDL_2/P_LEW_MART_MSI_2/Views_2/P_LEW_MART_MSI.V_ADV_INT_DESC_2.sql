CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ADV_INT_DESC_2
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  19.10.2017    Klamann,Norbertmulti-language descriptions amendedd d d
#  1.2  10.11.2017    Toth,Gabriel             cy_week added
#  1.3  15.11.2017    Wieber,Harald            Release 1.1
#  1.4  17.01.2018    Wieber,Harald            Release 2.2
#  1.5  21.12.2021    Morris, Michael          Add Column(s) for _BE_fr
#----------------------------------------------------------------------------
*/
(
        cy
      , adv_week_int
      , adv_wt_nr_int
      , adv_desc_int
      , adv_short_desc_int
      , adv_desc_int_AT
      , adv_short_desc_int_AT
      , adv_desc_int_BE
      , adv_short_desc_int_BE
      , adv_desc_int_BE_fr
      , adv_short_desc_int_BE_fr
      , adv_desc_int_BG
      , adv_short_desc_int_BG
      , adv_desc_int_CH
      , adv_short_desc_int_CH
      , adv_desc_int_CY
      , adv_short_desc_int_CY
      , adv_desc_int_CZ
      , adv_short_desc_int_CZ
      , adv_desc_int_DK
      , adv_short_desc_int_DK
      , adv_desc_int_EE
      , adv_short_desc_int_EE
      , adv_desc_int_ES
      , adv_short_desc_int_ES
      , adv_desc_int_FI
      , adv_short_desc_int_FI
      , adv_desc_int_FR
      , adv_short_desc_int_FR
      , adv_desc_int_GB
      , adv_short_desc_int_GB
      , adv_desc_int_GR
      , adv_short_desc_int_GR
      , adv_desc_int_HR
      , adv_short_desc_int_HR
      , adv_desc_int_HU
      , adv_short_desc_int_HU
      , adv_desc_int_IE
      , adv_short_desc_int_IE
      , adv_desc_int_IT
      , adv_short_desc_int_IT
      , adv_desc_int_LT
      , adv_short_desc_int_LT
      , adv_desc_int_LV
      , adv_short_desc_int_LV
      , adv_desc_int_NI
      , adv_short_desc_int_NI
      , adv_desc_int_NL
      , adv_short_desc_int_NL
      , adv_desc_int_DE
      , adv_short_desc_int_DE
      , adv_desc_int_PL
      , adv_short_desc_int_PL
      , adv_desc_int_PT
      , adv_short_desc_int_PT
      , adv_desc_int_RO
      , adv_short_desc_int_RO
      , adv_desc_int_SE
      , adv_short_desc_int_SE
      , adv_desc_int_SI
      , adv_short_desc_int_SI
      , adv_desc_int_SK
      , adv_short_desc_int_SK
      , adv_desc_int_CS
      , adv_short_desc_int_CS
      , adv_desc_int_MT
      , adv_short_desc_int_MT
      , adv_desc_int_US
      , adv_short_desc_int_US
      , adv_desc_int_RS
      , adv_short_desc_int_RS
      , cy_week
)
AS
SELECT   TRUNC(wk.cy_week / 100) AS cy
       , MOD( wk.cy_week, 100) AS adv_week_int
       , t.adv_wt_nr_int
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_de.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_de.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_at.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_AT
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_at.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_AT
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_be.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_BE
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_be.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_BE
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_fr.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_BE_fr
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_fr.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_BE_fr
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_bg.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_BG
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_bg.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_BG
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_ch.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_CH
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_ch.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_CH
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_cy.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_CY
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_cy.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_CY
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_cz.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_CZ
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_cz.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_CZ
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_dk.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_DK
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_dk.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_DK
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_ee.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_EE
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_ee.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_EE
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_es.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_ES
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_es.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_ES
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_fi.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_FI
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_fi.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_FI
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_fr.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_FR
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_fr.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_FR
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_gb.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_GB
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_gb.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_GB
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_gr.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_GR
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_gr.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_GR
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_hr.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_HR
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_hr.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_HR
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_hu.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_HU
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_hu.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_HU
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_ie.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_IE
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_ie.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_IE
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_it.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_IT
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_it.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_IT
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_lt.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_LT
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_lt.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_LT
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_lv.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_LV
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_lv.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_LV
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_ni.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_NI
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_ni.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_NI
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_nl.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_NL
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_nl.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_NL
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_de.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_DE
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_de.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_DE
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_pl.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_PL
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_pl.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_PL
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_pt.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_PT
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_pt.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_PT
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_ro.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_RO
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_ro.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_RO
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_se.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_SE
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_se.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_SE
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_si.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_SI
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_si.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_SI
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_sk.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_SK
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_sk.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_SK
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_cs.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_CS
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_cs.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_CS
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_mt.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_MT
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_mt.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_MT
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_us.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_US
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_us.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_US
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(TO_VARCHAR(cy, '9999') || ' ' || t_rs.kw_name || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_desc_int_RS
       , CASE WHEN t.adv_wt_nr_int IN (-1,0) THEN ' ' ELSE TRIM(t_rs.kw_name_short || ' ' || TO_VARCHAR(adv_week_int) || ' / ' || TO_VARCHAR(adv_wt_nr_int) ) END AS adv_short_desc_int_RS
       , CASE WHEN t.adv_wt_nr_int = 0 THEN wk.cy_week * 10 ELSE wk.cy_week END AS cy_week
  FROM P_LEW_CORE_AC.v_wawi_cal_week_2 AS wk
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_at
    ON t_at.language_id = 1
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_be
    ON t_be.language_id = 2
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_bg
    ON t_bg.language_id = 3
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_ch
    ON t_ch.language_id = 4
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_cy
    ON t_cy.language_id = 5
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_cz
    ON t_cz.language_id = 6
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_dk
    ON t_dk.language_id = 8
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_ee
    ON t_ee.language_id = 9
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_es
    ON t_es.language_id = 10
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_fi
    ON t_fi.language_id = 11
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_fr
    ON t_fr.language_id = 12
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_gb
    ON t_gb.language_id = 13
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_gr
    ON t_gr.language_id = 14
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_hr
    ON t_hr.language_id = 15
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_hu
    ON t_hu.language_id = 16
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_ie
    ON t_ie.language_id = 17
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_it
    ON t_it.language_id = 18
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_lt
    ON t_lt.language_id = 19
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_lv
    ON t_lv.language_id = 20
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_ni
    ON t_ni.language_id = 21
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_nl
    ON t_nl.language_id = 22
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_de
    ON t_de.language_id = 23
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_pl
    ON t_pl.language_id = 24
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_pt
    ON t_pt.language_id = 25
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_ro
    ON t_ro.language_id = 26
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_se
    ON t_se.language_id = 27
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_si
    ON t_si.language_id = 28
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_sk
    ON t_sk.language_id = 29
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_cs
    ON t_cs.language_id = 31
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_mt
    ON t_mt.language_id = 32
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_us
    ON t_us.language_id = 33
 INNER JOIN P_LEW_CORE_AC.v_wawi_cal_kw_desc_2 AS t_rs
    ON t_rs.language_id = 34
 CROSS JOIN
   (
    SELECT adv_wt_nr_int
      FROM (SELECT -1 AS adv_wt_nr_int) AS t_1
     UNION ALL SELECT adv_wt_nr_int FROM (SELECT 0 AS adv_wt_nr_int) AS t0
     UNION ALL SELECT adv_wt_nr_int FROM (SELECT 1 AS adv_wt_nr_int) AS t1_2
     UNION ALL SELECT adv_wt_nr_int FROM (SELECT 2 AS adv_wt_nr_int) AS t2
     UNION ALL SELECT adv_wt_nr_int FROM (SELECT 3 AS adv_wt_nr_int) AS t3
   ) AS t
;
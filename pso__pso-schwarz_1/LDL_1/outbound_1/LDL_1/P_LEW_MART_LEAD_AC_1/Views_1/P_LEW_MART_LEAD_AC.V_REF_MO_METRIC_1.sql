/*
#-----------------------------------------------------------------------------
# History:
#  1.0     23.06.2023      Stephane Djiomou Tonga            Initial Version.
#  1.1     21.07.2023      Stefan Sockel		             Added BE_FR.
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_mo_metric_1 (kpi_id OPTIONS(description='The ID of the KPI'),
metric_id OPTIONS(description='The ID of the METRIC'), metric_month_desc
OPTIONS(description='MAIN Metric Month description field'), metric_week_desc
OPTIONS(description='MAIN Metric Week in depending country_1 language'), metric_month_var_desc
OPTIONS(description='MAIN METRIC Month Var description in depending country_1 language'), metric_week_var_desc
OPTIONS(description='MAIN METRIC Week Var description in depending country_1 language'), kpi_desc
OPTIONS(description='Main KPI description field'), kpi_desc_at
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_be
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_be_fr
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_bg
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_ch
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_cy
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_cz
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_dk
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_ee
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_es
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_fi
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_fr
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_gb
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_gr
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_hr
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_hu
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_ie
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_it
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_lt
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_lv
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_ni
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_nl
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_de
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_pl
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_pt
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_ro
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_se
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_si
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_sk
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_cs
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_mt
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_us
OPTIONS(description='KPI description in depending country_1 language'), kpi_desc_rs
OPTIONS(description='KPI description in depending country_1 language'), metric_desc
OPTIONS(description='MAIN METRIC description field'), metric_desc_at
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_be
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_be_fr
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_bg
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_ch
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_cy
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_cz
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_dk
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_ee
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_es
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_fi
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_fr
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_gb
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_gr
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_hr
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_hu
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_ie
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_it
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_lt
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_lv
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_ni
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_nl
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_de
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_pl
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_pt
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_ro
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_se
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_si
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_sk
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_cs
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_mt
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_us
OPTIONS(description='METRIC description in depending country_1 language'), metric_desc_rs
OPTIONS(description='METRIC description in depending country_1 language'), zeit_id
OPTIONS(description='The ID of the Zeit_1'), zeit_desc OPTIONS(description='MAIN ZEIT_1 description field'), zeit_desc_at
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_be
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_be_fr
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_bg
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_ch
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_cy
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_cz
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_dk
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_ee
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_es
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_fi
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_fr
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_gb
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_gr
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_hr
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_hu
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_ie
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_it
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_lt
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_lv
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_ni
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_nl
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_de
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_pl
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_pt
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_ro
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_se
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_si
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_sk
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_cs
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_mt
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_us
OPTIONS(description='ZEIT_1 description in depending country_1 language'), zeit_desc_rs
OPTIONS(description='ZEIT_1 description in depending country_1 language'), metric_month_desc_at
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_be
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_be_fr
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_bg
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_ch
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_cy
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_cz
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_dk
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_ee
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_es
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_fi
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_fr
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_gb
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_gr
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_hr
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_hu
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_ie
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_it
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_lt
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_lv
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_ni
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_nl
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_de
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_pl
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_pt
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_ro
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_se
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_si
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_sk
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_cs
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_mt
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_us
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_month_desc_rs
OPTIONS(description='METRIC_MONTH description in depending country_1 language'), metric_week_desc_at
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_be
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_be_fr
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_bg
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_ch
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_cy
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_cz
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_dk
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_ee
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_es
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_fi
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_fr
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_gb
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_gr
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_hr
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_hu
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_ie
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_it
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_lt
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_lv
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_ni
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_nl
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_de
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_pl
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_pt
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_ro
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_se
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_si
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_sk
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_cs
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_mt
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_us
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_week_desc_rs
OPTIONS(description='METRIC  Week description in depending country_1 language'), metric_month_var_desc_at
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_be
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_be_fr
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_bg
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_ch
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_cy
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_cz
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_dk
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_ee
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_es
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_fi
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_fr
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_gb
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_gr
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_hr
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_hu
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_ie
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_it
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_lt
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_lv
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_ni
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_nl
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_de
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_pl
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_pt
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_ro
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_se
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_si
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_sk
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_cs
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_mt
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_us
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_month_var_desc_rs
OPTIONS(description='METRIC Month Var description in depending country_1 language'), metric_week_var_desc_at
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_be
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_be_fr
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_bg
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_ch
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_cy
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_cz
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_dk
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_ee
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_es
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_fi
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_fr
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_gb
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_gr
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_hr
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_hu
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_ie
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_it
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_lt
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_lv
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_ni
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_nl
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_de
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_pl
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_pt
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_ro
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_se
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_si
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_sk
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_cs
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_mt
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_us
OPTIONS(description='METRIC Week Var description in depending country_1 language'), metric_week_var_desc_rs
OPTIONS(description='METRIC Week Var description in depending country_1 language'), topic
OPTIONS(description='Topic description in depending country_1 language'))
OPTIONS(DESCRIPTION = `KPI, METRIC, METRIC MONTH, METRIC WEEK, METRIC MONTH VAR, METRIC WEEK VAR AND ZEIT_1 DESCRIPTION TABLE`)
AS SELECT kpi_id,
 metric_id,
 metric_month_desc,
 metric_week_desc,
 metric_month_var_desc,
 metric_week_var_desc,
 kpi_desc,
 kpi_desc_at,
 kpi_desc_be,
 kpi_desc_be_fr,
 kpi_desc_bg,
 kpi_desc_ch,
 kpi_desc_cy,
 kpi_desc_cz,
 kpi_desc_dk,
 kpi_desc_ee,
 kpi_desc_es,
 kpi_desc_fi,
 kpi_desc_fr,
 kpi_desc_gb,
 kpi_desc_gr,
 kpi_desc_hr,
 kpi_desc_hu,
 kpi_desc_ie,
 kpi_desc_it,
 kpi_desc_lt,
 kpi_desc_lv,
 kpi_desc_ni,
 kpi_desc_nl,
 kpi_desc_de,
 kpi_desc_pl,
 kpi_desc_pt,
 kpi_desc_ro,
 kpi_desc_se,
 kpi_desc_si,
 kpi_desc_sk,
 kpi_desc_cs,
 kpi_desc_mt,
 kpi_desc_us,
 kpi_desc_rs,
 metric_desc,
 metric_desc_at,
 metric_desc_be,
 metric_desc_be_fr,
 metric_desc_bg,
 metric_desc_ch,
 metric_desc_cy,
 metric_desc_cz,
 metric_desc_dk,
 metric_desc_ee,
 metric_desc_es,
 metric_desc_fi,
 metric_desc_fr,
 metric_desc_gb,
 metric_desc_gr,
 metric_desc_hr,
 metric_desc_hu,
 metric_desc_ie,
 metric_desc_it,
 metric_desc_lt,
 metric_desc_lv,
 metric_desc_ni,
 metric_desc_nl,
 metric_desc_de,
 metric_desc_pl,
 metric_desc_pt,
 metric_desc_ro,
 metric_desc_se,
 metric_desc_si,
 metric_desc_sk,
 metric_desc_cs,
 metric_desc_mt,
 metric_desc_us,
 metric_desc_rs,
 zeit_id,
 zeit_desc,
 zeit_desc_at,
 zeit_desc_be,
 zeit_desc_be_fr,
 zeit_desc_bg,
 zeit_desc_ch,
 zeit_desc_cy,
 zeit_desc_cz,
 zeit_desc_dk,
 zeit_desc_ee,
 zeit_desc_es,
 zeit_desc_fi,
 zeit_desc_fr,
 zeit_desc_gb,
 zeit_desc_gr,
 zeit_desc_hr,
 zeit_desc_hu,
 zeit_desc_ie,
 zeit_desc_it,
 zeit_desc_lt,
 zeit_desc_lv,
 zeit_desc_ni,
 zeit_desc_nl,
 zeit_desc_de,
 zeit_desc_pl,
 zeit_desc_pt,
 zeit_desc_ro,
 zeit_desc_se,
 zeit_desc_si,
 zeit_desc_sk,
 zeit_desc_cs,
 zeit_desc_mt,
 zeit_desc_us,
 zeit_desc_rs,
 metric_month_desc_at,
 metric_month_desc_be,
 metric_month_desc_be_fr,
 metric_month_desc_bg,
 metric_month_desc_ch,
 metric_month_desc_cy,
 metric_month_desc_cz,
 metric_month_desc_dk,
 metric_month_desc_ee,
 metric_month_desc_es,
 metric_month_desc_fi,
 metric_month_desc_fr,
 metric_month_desc_gb,
 metric_month_desc_gr,
 metric_month_desc_hr,
 metric_month_desc_hu,
 metric_month_desc_ie,
 metric_month_desc_it,
 metric_month_desc_lt,
 metric_month_desc_lv,
 metric_month_desc_ni,
 metric_month_desc_nl,
 metric_month_desc_de,
 metric_month_desc_pl,
 metric_month_desc_pt,
 metric_month_desc_ro,
 metric_month_desc_se,
 metric_month_desc_si,
 metric_month_desc_sk,
 metric_month_desc_cs,
 metric_month_desc_mt,
 metric_month_desc_us,
 metric_month_desc_rs,
 metric_week_desc_at,
 metric_week_desc_be,
 metric_week_desc_be_fr,
 metric_week_desc_bg,
 metric_week_desc_ch,
 metric_week_desc_cy,
 metric_week_desc_cz,
 metric_week_desc_dk,
 metric_week_desc_ee,
 metric_week_desc_es,
 metric_week_desc_fi,
 metric_week_desc_fr,
 metric_week_desc_gb,
 metric_week_desc_gr,
 metric_week_desc_hr,
 metric_week_desc_hu,
 metric_week_desc_ie,
 metric_week_desc_it,
 metric_week_desc_lt,
 metric_week_desc_lv,
 metric_week_desc_ni,
 metric_week_desc_nl,
 metric_week_desc_de,
 metric_week_desc_pl,
 metric_week_desc_pt,
 metric_week_desc_ro,
 metric_week_desc_se,
 metric_week_desc_si,
 metric_week_desc_sk,
 metric_week_desc_cs,
 metric_week_desc_mt,
 metric_week_desc_us,
 metric_week_desc_rs,
 metric_month_var_desc_at,
 metric_month_var_desc_be,
 metric_month_var_desc_be_fr,
 metric_month_var_desc_bg,
 metric_month_var_desc_ch,
 metric_month_var_desc_cy,
 metric_month_var_desc_cz,
 metric_month_var_desc_dk,
 metric_month_var_desc_ee,
 metric_month_var_desc_es,
 metric_month_var_desc_fi,
 metric_month_var_desc_fr,
 metric_month_var_desc_gb,
 metric_month_var_desc_gr,
 metric_month_var_desc_hr,
 metric_month_var_desc_hu,
 metric_month_var_desc_ie,
 metric_month_var_desc_it,
 metric_month_var_desc_lt,
 metric_month_var_desc_lv,
 metric_month_var_desc_ni,
 metric_month_var_desc_nl,
 metric_month_var_desc_de,
 metric_month_var_desc_pl,
 metric_month_var_desc_pt,
 metric_month_var_desc_ro,
 metric_month_var_desc_se,
 metric_month_var_desc_si,
 metric_month_var_desc_sk,
 metric_month_var_desc_cs,
 metric_month_var_desc_mt,
 metric_month_var_desc_us,
 metric_month_var_desc_rs,
 metric_week_var_desc_at,
 metric_week_var_desc_be,
 metric_week_var_desc_be_fr,
 metric_week_var_desc_bg,
 metric_week_var_desc_ch,
 metric_week_var_desc_cy,
 metric_week_var_desc_cz,
 metric_week_var_desc_dk,
 metric_week_var_desc_ee,
 metric_week_var_desc_es,
 metric_week_var_desc_fi,
 metric_week_var_desc_fr,
 metric_week_var_desc_gb,
 metric_week_var_desc_gr,
 metric_week_var_desc_hr,
 metric_week_var_desc_hu,
 metric_week_var_desc_ie,
 metric_week_var_desc_it,
 metric_week_var_desc_lt,
 metric_week_var_desc_lv,
 metric_week_var_desc_ni,
 metric_week_var_desc_nl,
 metric_week_var_desc_de,
 metric_week_var_desc_pl,
 metric_week_var_desc_pt,
 metric_week_var_desc_ro,
 metric_week_var_desc_se,
 metric_week_var_desc_si,
 metric_week_var_desc_sk,
 metric_week_var_desc_cs,
 metric_week_var_desc_mt,
 metric_week_var_desc_us,
 metric_week_var_desc_rs,
 topic
FROM ldl_p_lew_mart_lead.t_ref_mo_metric_1;
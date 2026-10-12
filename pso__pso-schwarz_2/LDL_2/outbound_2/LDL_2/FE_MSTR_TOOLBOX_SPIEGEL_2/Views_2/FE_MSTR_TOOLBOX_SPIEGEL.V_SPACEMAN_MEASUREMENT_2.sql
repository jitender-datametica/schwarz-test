/*
#----------------------------------------------------------------------------
# Description:
# This view provides static values for measurement calculations on measurement level (cm and inch).
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  2.0     10.10.2024      Simeon Nikolaev          PAS_TYPE
#  3.0     20.11.2024      Simeon Nikolaev          METRIC_SYSTEM_DESC_FULL with transaltion
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_spaceman_measurement_2 (metric_system_id, metric_system_name,
shelf_meter, higher_meas, pas_type, metric_system_desc_full, metric_system_desc_full_de, metric_system_desc_full_ch,
metric_system_desc_full_at, metric_system_desc_full_be, metric_system_desc_full_be_fr, metric_system_desc_full_bg,
metric_system_desc_full_cy, metric_system_desc_full_cz, metric_system_desc_full_dk, metric_system_desc_full_ee,
metric_system_desc_full_es, metric_system_desc_full_fi, metric_system_desc_full_fr, metric_system_desc_full_gb,
metric_system_desc_full_gr, metric_system_desc_full_hr, metric_system_desc_full_hu, metric_system_desc_full_ie,
metric_system_desc_full_it, metric_system_desc_full_lt, metric_system_desc_full_lv, metric_system_desc_full_ni,
metric_system_desc_full_nl, metric_system_desc_full_pl, metric_system_desc_full_pt, metric_system_desc_full_ro,
metric_system_desc_full_se, metric_system_desc_full_si, metric_system_desc_full_sk, metric_system_desc_full_cs,
metric_system_desc_full_mt, metric_system_desc_full_us, metric_system_desc_full_rs) AS SELECT metric_system_id,
 metric_system_name,
 shelf_meter,
 higher_meas,
 pas_type,
 metric_system_desc_full,
 metric_system_desc_full AS metric_system_desc_full_de,
 metric_system_desc_full AS metric_system_desc_full_ch,
 metric_system_desc_full AS metric_system_desc_full_at,
 metric_system_desc_full_en AS metric_system_desc_full_be,
 metric_system_desc_full_en AS metric_system_desc_full_be_fr,
 metric_system_desc_full_en AS metric_system_desc_full_bg,
 metric_system_desc_full_en AS metric_system_desc_full_cy,
 metric_system_desc_full_en AS metric_system_desc_full_cz,
 metric_system_desc_full_en AS metric_system_desc_full_dk,
 metric_system_desc_full_en AS metric_system_desc_full_ee,
 metric_system_desc_full_en AS metric_system_desc_full_es,
 metric_system_desc_full_en AS metric_system_desc_full_fi,
 metric_system_desc_full_en AS metric_system_desc_full_fr,
 metric_system_desc_full_en AS metric_system_desc_full_gb,
 metric_system_desc_full_en AS metric_system_desc_full_gr,
 metric_system_desc_full_en AS metric_system_desc_full_hr,
 metric_system_desc_full_en AS metric_system_desc_full_hu,
 metric_system_desc_full_en AS metric_system_desc_full_ie,
 metric_system_desc_full_en AS metric_system_desc_full_it,
 metric_system_desc_full_en AS metric_system_desc_full_lt,
 metric_system_desc_full_en AS metric_system_desc_full_lv,
 metric_system_desc_full_en AS metric_system_desc_full_ni,
 metric_system_desc_full_en AS metric_system_desc_full_nl,
 metric_system_desc_full_en AS metric_system_desc_full_pl,
 metric_system_desc_full_en AS metric_system_desc_full_pt,
 metric_system_desc_full_en AS metric_system_desc_full_ro,
 metric_system_desc_full_en AS metric_system_desc_full_se,
 metric_system_desc_full_en AS metric_system_desc_full_si,
 metric_system_desc_full_en AS metric_system_desc_full_sk,
 metric_system_desc_full_en AS metric_system_desc_full_cs,
 metric_system_desc_full_en AS metric_system_desc_full_mt,
 metric_system_desc_full_en AS metric_system_desc_full_us,
 metric_system_desc_full_en AS metric_system_desc_full_rs
FROM ldl_fe_mstr_toolbox_spiegel.t_spaceman_measurement_2;
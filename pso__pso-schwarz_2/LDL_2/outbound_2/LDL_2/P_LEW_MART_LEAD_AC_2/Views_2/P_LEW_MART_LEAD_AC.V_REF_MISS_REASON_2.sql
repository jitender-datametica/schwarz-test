CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_miss_reason_2 (reason_id, reason_desc, reason_desc_at, reason_desc_be
, reason_desc_bg, reason_desc_ch, reason_desc_cy, reason_desc_cz, reason_desc_de, reason_desc_dk, reason_desc_es,
reason_desc_fi, reason_desc_fr, reason_desc_gb, reason_desc_gr, reason_desc_hr, reason_desc_hu, reason_desc_ie,
reason_desc_it, reason_desc_lt, reason_desc_lv, reason_desc_ni, reason_desc_nl, reason_desc_pl, reason_desc_pt,
reason_desc_ro, reason_desc_se, reason_desc_si, reason_desc_sk, reason_desc_cs, reason_desc_mt, reason_desc_us) AS
SELECT *
FROM ldl_p_lew_mart_lead.v_ref_miss_reason_2;
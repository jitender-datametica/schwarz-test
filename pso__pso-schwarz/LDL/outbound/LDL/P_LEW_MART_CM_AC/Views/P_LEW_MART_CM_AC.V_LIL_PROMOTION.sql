CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_promotion (prom_id, prom_desc, prom_desc_en, prom_short_desc,
prom_short_desc_en, prom_lvl, liam1_srt_cd, lift1_srt_cd) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_promotion;
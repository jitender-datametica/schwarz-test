CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_lago_itemfamily_1 (client_id, country_iso_cd, dat_rec_start, dat_rec_end,
item_familygroup_id, itemfamily_cd, desc_short, desc_long, language_id, cs_updated, cs_created, cs_load_id) AS SELECT *
FROM ldl_p_lew_mart_cs.v_lago_itemfamily_1 AS A;
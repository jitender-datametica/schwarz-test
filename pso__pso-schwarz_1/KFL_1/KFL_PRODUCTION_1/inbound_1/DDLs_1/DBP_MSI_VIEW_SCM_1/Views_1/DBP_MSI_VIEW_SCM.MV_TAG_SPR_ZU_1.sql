CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TAG_SPR_ZU_1 (
	DAT,
	WTAG_ID,
	WTAG_BEZ,
	WTAG_BEZ_DE,
	WTAG_BEZ_CZ,
	WTAG_BEZ_PL,
	WTAG_BEZ_SK,
	WTAG_BEZ_HR,
	WTAG_BEZ_RO,
	WTAG_BEZ_BG,
	WTAG_KBEZ,
	WTAG_KBEZ_DE,
	WTAG_KBEZ_CZ,
	WTAG_KBEZ_PL,
	WTAG_KBEZ_SK,
	WTAG_KBEZ_HR,
	WTAG_KBEZ_RO,
	WTAG_KBEZ_BG
) AS
--2025-03-04, dknop, NSR5156678, three letters for SK for wtag_kbez_sk to avoid dupliactes
   SELECT
   tag.dat, tag.wtag_id, MAX(CASE WHEN spr_id =  22 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez      --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_de   --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_cz   --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_pl   --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_sk   --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_hr   --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_ro   --rumå¯©sch
   , MAX(CASE WHEN spr_id =  18 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_bg   --bulgarisch
   , MAX(CASE WHEN spr_id =  22 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez      --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_de   --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_cz   --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_pl   --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_sk   --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_hr   --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_ro   --rumå¯©sch
   , MAX(CASE WHEN spr_id =  18 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_bg   --bulgarisch
   FROM dbp_view.v_tag_1  tag_1
   JOIN dbp_view.v_wtag_spr_zu_1 spr_1
   ON tag.wtag_id = spr.wtag_id
   WHERE
   akt_gj BETWEEN -10 AND 1
   GROUP BY
   tag.dat
   , tag.wtag_id;
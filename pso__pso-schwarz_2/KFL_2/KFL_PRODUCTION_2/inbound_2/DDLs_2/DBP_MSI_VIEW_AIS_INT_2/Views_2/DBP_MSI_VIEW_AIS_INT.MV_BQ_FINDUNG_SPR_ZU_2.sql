CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_BQ_FINDUNG_SPR_ZU_2(
	MANDANT_ID,
	BQ_FINDUNG_ID,
	BQ_FINDUNG_BEZ,
	BQ_FINDUNG_BEZ_DE,
	BQ_FINDUNG_BEZ_CZ,
	BQ_FINDUNG_BEZ_SK,
	BQ_FINDUNG_BEZ_HR,
	BQ_FINDUNG_BEZ_PL,
	BQ_FINDUNG_BEZ_RO,
	BQ_FINDUNG_BEZ_BG
) AS
SELECT
    v01.mandant_id,
    v01.bq_findung_id,
    COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.bq_findung_bez END), 'N/A') AS bq_findung_bez,
    COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.bq_findung_bez END), 'N/A') AS bq_findung_bez_de,
    COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_cz,
    COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_sk,
    COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_hr,
    COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_pl,
    COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_ro,
    COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_bg
FROM
    dbp_view.v_bq_findung_spr_zu_2 v01
GROUP BY
    v01.mandant_id,
    v01.bq_findung_id;
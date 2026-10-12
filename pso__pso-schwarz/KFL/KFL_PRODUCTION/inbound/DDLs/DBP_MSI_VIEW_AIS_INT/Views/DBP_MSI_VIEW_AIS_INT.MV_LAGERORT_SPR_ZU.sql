CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_LAGERORT_SPR_ZU AS
SELECT
    v01.lagerort_id,
    v01.mandant_id,
    v01.nb_id,
    v01.wup_id,
    COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.wup_id || ' ' || v01.lagerort_bez END),'N/A') AS lagerort_bez,
    COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.wup_id || ' ' || v01.lagerort_bez END), 'N/A') AS lagerort_bez_de,
    COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.wup_id || ' ' || v01.lagerort_bez END),lagerort_bez_de) AS lagerort_bez_cz,
    COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.wup_id || ' ' || v01.lagerort_bez END),lagerort_bez_de) AS lagerort_bez_sk,
    COALESCE(MAX(CASE WHEN v01.spr_id = 65 THEN v01.wup_id || ' ' || v01.lagerort_bez END),lagerort_bez_de) AS lagerort_bez_hr,
    COALESCE(MAX(CASE WHEN v01.spr_id = 90 THEN v01.wup_id || ' ' || v01.lagerort_bez END),lagerort_bez_de) AS lagerort_bez_pl,
    COALESCE(MAX(CASE WHEN v01.spr_id = 95 THEN v01.wup_id || ' ' || v01.lagerort_bez END),lagerort_bez_de) AS lagerort_bez_ro,
    COALESCE(MAX(CASE WHEN v01.spr_id = 18 THEN v01.wup_id || ' ' || v01.lagerort_bez END),lagerort_bez_de) AS lagerort_bez_bg
FROM
    dbp_view.v_lagerort_spr_zu v01
WHERE
    v01.lagerort_id NOT IN ('-1', '-2', '-3')
GROUP BY
    v01.lagerort_id,
    v01.mandant_id,
    v01.nb_id,
    v01.wup_id;
CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_LAGERORT_2 AS
SELECT
    lagerort_id,
    mandant_id,
    nb_id,
    wup_id,
    lagernummer_id
FROM
    dbp_view.v_l_lagerort_2
WHERE
    lagerort_id NOT IN ('-1', '-2', '-3');
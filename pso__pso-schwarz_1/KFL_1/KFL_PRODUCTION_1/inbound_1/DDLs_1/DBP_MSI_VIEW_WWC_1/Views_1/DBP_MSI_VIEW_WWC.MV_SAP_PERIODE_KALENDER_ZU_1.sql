CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_SAP_PERIODE_KALENDER_ZU_1 (
    mandant_id,
    mandant_kbez,
    krk_id,
    buchungsperiode_id,
    sap_buchungs_jahr,
    LFGJAMON,
    LFGJAMON_MANDT,
    mandant_LFGJAMON,
    kjmo
) AS
SELECT
    v01.mandant_id,
    v02.mandant_kbez,
    v01.krk_id,
    v01.buchungsperiode_id,
    v01.sap_buchungs_jahr,
    (v01.sap_buchungs_jahr * 100) + v01.buchungsperiode_id AS LFGJAMON,
    CAST(LFGJAMON AS CHAR(6)) || ' ' || CAST(trim(v02.mandant_kbez) AS CHAR(2)) AS LFGJAMON_MANDT,
    1,
    v01.kjmo
FROM
    dbp_view.v_sap_periode_kalender_zu_1 v01
    INNER JOIN dbp_view.v_mandant_1 v02 ON v01.mandant_id = v02.mandant_id
WHERE
    v01.buchungsperiode_id <= 12
    AND v01.krk_id <> 'DE02';
CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_MKPF_1 -- 10.04.2018, AP0021792, srom0404, lagerbew_beleg_id und lagerbew_beleg_pos_id zusätzlich als numerisches Feld ausführen
-- sonst werden bei JOIN zu mv_bestellentwicklung_1 num und char vermischt und es gibt einen Fehler
(
    mandant_id,
    MBLNR,
    MBLNR_NUM,
    MJAHR,
    VGART,
    BUDAT,
    USNAM,
    XBLNR,
    BLDAT,
    CPUDT,
    CPUDT_CPUTM,
    CPUDT_CPUTM_STR,
    BLART,
    BKTXT,
    XABLN,
    TCODE2
) AS
SELECT
    v01.mandant_id,
    TO_VARCHAR(v01.lagerbew_beleg_id, 'FM0000000000') AS MBLNR,
    v01.lagerbew_beleg_id AS MBLNR_NUM,
    v01.kj AS MJAHR,
    v01.vorgangsart_id AS VGART,
    v01.dat_buch AS BUDAT,
    v01.beleg_user_name AS USNAM,
    v01.ref_lagerbew_beleg_id AS XBLNR,
    v01.dat_beleg AS BLDAT,
    v01.dat_erfasst AS CPUDT,
    TIMESTAMP_FROM_PARTS(v01.dat_erfasst, v01.zeit_erfasst) AS CPUDT_CPUTM,
    CAST(v01.dat_erfasst AS CHAR(11)) || ' ' || CAST(v01.zeit_erfasst AS CHAR(8)) AS CPUDT_CPUTM_STR,
    v01.belegart_id AS BLART,
    v01.belegkopftext AS BKTXT,
    v01.waren_begl_schein_id AS XABLN,
    v01.transaktion_code AS TCODE2
FROM
    dbp_view.v_lagerbew_1 v01;
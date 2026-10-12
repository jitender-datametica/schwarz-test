CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_UMBEWERTUNG -- 02.06.2014 twie: Kopftabelle Umbewertungen
-- 25.06.2014 twie: pae_beleg_id von Decimal 18 auf 10 verkürzt, da auch in SAP nur 10 Stellen
(
    mandant_id,
    pae_beleg_id,
    kj,
    dat_beleg,
    dat_erfasst,
    zeit_erfasst,
    dat_zeit_erfasst,
    beleg_user_name
) AS
SELECT
    v01.mandant_id,
    CAST(v01.pae_beleg_id AS DECIMAL(10)) AS pae_beleg_id,
    v01.kj,
    v01.dat_beleg,
    v01.dat_erfasst,
    v01.zeit_erfasst,
    TIMESTAMP_FROM_PARTS(v01.dat_erfasst, v01.zeit_erfasst) AS dat_zeit_erfasst,
    v01.beleg_user_name
FROM
    dbp_view.v_umbewertung v01;
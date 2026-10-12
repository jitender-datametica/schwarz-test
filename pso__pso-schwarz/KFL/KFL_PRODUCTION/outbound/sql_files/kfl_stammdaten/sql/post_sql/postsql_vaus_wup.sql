--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.vaus_wup SET
    -- Aufgabe ist fuehrend vor Checkliste
    dat_eroeffnung = d.dateroffnung_cprojects FROM (SELECT
    mandant_id
        AS
        mandant_id_,
    wup_id AS wup_id_,
    dateroffnung_cprojects
FROM (SELECT
    mandant_id,
    wup_id,
    MAX(dat_eroeffnung) AS dateroffnung_cprojects
FROM (
    SELECT DISTINCT
        mandant_id,
        wup_id,
        dat_eroeffnung
    FROM (
        SELECT
            MV03.mandant_id,
            MV03.wup_id,
            MV02.projekt_id,
            MV03.projekt_nr,
            MAX(CASE
                WHEN MV01.cpr_suchfeld_id = 'CPR_PRV_APLNAT'
                    THEN MV01.dat_termin
                ELSE NULL
            END) AS dat_freigabe,
            MAX(CASE
                WHEN MV01.cpr_suchfeld_id = 'EROEFFNUNGSABNAHME'
                    THEN MV01.dat_termin
                ELSE NULL
            END) AS dat_abnahme,
            MAX(CASE
                WHEN MV01.cpr_suchfeld_id = 'STILLE_EROEFFNUNG'
                    THEN MV01.dat_termin
                ELSE NULL
            END) AS dat_eroeffnung
        FROM dbp_msi_view_ios.mv_cpr_cl_punkt AS MV01
        INNER JOIN
            dbp_msi_view_ios.mv_cpr_phase AS MV02
            ON MV01.projekt_phase_id = MV02.projekt_phase_id

        INNER JOIN
            dbp_msi_view_ios.mv_cpr_projekt AS MV03
            ON MV02.projekt_id = MV03.projekt_id
        WHERE
            MV03.massnahme_kz IN ('NB', 'UE') -- Neubau/Uebernahme

            AND MV03.cpr_systemstatus1_id IN (2) -- gueltige

            AND MV01.cpr_suchfeld_id IN (
                'CPR_PRV_APLNAT', 'EROEFFNUNGSABNAHME', 'STILLE_EROEFFNUNG'
            )
            -- relevante suchfelder

            AND MV01.dat_termin IS NOT NULL
        GROUP BY
            MV03.mandant_id,
            MV03.wup_id,
            MV02.projekt_id,
            MV03.projekt_nr
    ) AS sub11
    WHERE
        wup_id IS NOT NULL
        AND dat_eroeffnung IS NOT NULL
) AS k
GROUP BY
    mandant_id,
    wup_id
HAVING dateroffnung_cprojects >= CURRENT_DATE("Europe/Berlin")) AS t8) AS d
WHERE vaus_wup.mandant_id = d.mandant_id_ AND vaus_wup.wup_id = d.wup_id_;

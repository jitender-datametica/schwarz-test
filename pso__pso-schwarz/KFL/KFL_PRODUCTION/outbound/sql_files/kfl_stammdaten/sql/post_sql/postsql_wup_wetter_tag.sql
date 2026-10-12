DELETE FROM dbp_data.wup_wetter_tag AS WFC
WHERE EXISTS (
    SELECT *
    FROM dbp_data.wup AS W
    WHERE
        WFC.mandant_id = mandant_id
        AND WFC.wup_id = wup_id
        AND WFC.dat > dat_bis
        AND wup_id <> aktuell_wup_id
);

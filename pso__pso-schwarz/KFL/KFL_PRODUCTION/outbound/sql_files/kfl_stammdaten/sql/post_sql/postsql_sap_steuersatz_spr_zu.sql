UPDATE dbp_data.sap_steuersatz_spr_zu SET
    sap_steuer_bez = s.ro_sap_steuer_bez,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.sap_steuer_id,
        A.steuer_typ_id,
        A.spr_id,
        B.sap_steuer_bez AS ro_sap_steuer_bez
    FROM dbp_data.sap_steuersatz_spr_zu AS A
    INNER JOIN dbp_data.sap_steuersatz_spr_zu AS B
        ON
            A.sap_steuer_id = B.sap_steuer_id AND A.steuer_typ_id
            = B.steuer_typ_id AND A.spr_id = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.sap_steuer_bez <> B.sap_steuer_bez
    GROUP BY
        A.sap_steuer_id,
        A.steuer_typ_id,
        A.spr_id,
        ro_sap_steuer_bez
) AS s
WHERE
    sap_steuersatz_spr_zu.mandant_id = 4
    AND sap_steuersatz_spr_zu.sap_steuer_id = s.sap_steuer_id
    AND sap_steuersatz_spr_zu.steuer_typ_id = s.steuer_typ_id AND sap_steuersatz_spr_zu.spr_id = s.spr_id
    AND sap_steuersatz_spr_zu.sap_steuer_bez <> s.ro_sap_steuer_bez;

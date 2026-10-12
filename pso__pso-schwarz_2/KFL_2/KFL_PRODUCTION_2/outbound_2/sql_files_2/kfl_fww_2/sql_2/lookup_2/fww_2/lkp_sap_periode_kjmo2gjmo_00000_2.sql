--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    A.mandant_id,
    A.krk_id,
    A.buchungsperiode_id,
    A.sap_buchungs_jahr,
    A.kjmo,
    B.gjmo
FROM dbp_data.sap_periode_kalender_zu_2 AS A
INNER JOIN dbp_data.monat_2 AS B ON A.kjmo = B.kjmo;

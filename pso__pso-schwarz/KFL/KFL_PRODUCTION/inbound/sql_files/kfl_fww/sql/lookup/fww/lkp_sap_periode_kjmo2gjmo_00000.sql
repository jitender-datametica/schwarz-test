--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT a.mandant_id ,a.krk_id ,a.buchungsperiode_id ,a.sap_buchungs_jahr,a.kjmo,b.gjmo FROM DBP_DATA.sap_periode_kalender_zu a INNER JOIN DBP_DATA.monat b ON a.kjmo = b.kjmo;


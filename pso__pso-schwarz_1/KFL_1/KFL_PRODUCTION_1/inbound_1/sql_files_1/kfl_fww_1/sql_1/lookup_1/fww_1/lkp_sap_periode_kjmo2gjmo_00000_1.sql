--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT a.mandant_id ,a.krk_id ,a.buchungsperiode_id ,a.sap_buchungs_jahr,a.kjmo,b.gjmo FROM DBP_DATA.sap_periode_kalender_zu_1 a INNER JOIN DBP_DATA.monat_1 b ON a.kjmo = b.kjmo;


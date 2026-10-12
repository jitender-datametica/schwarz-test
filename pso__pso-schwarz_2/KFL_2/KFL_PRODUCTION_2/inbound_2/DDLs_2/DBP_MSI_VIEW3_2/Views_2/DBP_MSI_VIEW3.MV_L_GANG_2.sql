CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_GANG_2 as
   SELECT DISTINCT
   mandant_id, nb_id, wup_id, lagernummer_id, CASE WHEN SUBSTR(lagerplatz_id,4,1) = '-' THEN LEFT(lagerplatz_id,3) ELSE 'kein Gang' END AS gang_id
   FROM dbp_view.v_l_lagerplatz_2
   WHERE  dat_bis='9999-12-31';
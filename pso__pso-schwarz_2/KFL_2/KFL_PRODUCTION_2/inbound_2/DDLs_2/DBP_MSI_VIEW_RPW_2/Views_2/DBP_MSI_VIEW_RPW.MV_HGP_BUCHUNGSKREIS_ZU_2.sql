CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_HGP_BUCHUNGSKREIS_ZU_2
 (
 mandant_id
 ,hgp_id
 ,einkaufsorganisation_id
 ,buchungskreis_id
 ,zahlsperre_id
 ,system_id
 )
 AS
    SELECT
    mandant_id,
    gp_id,
    einkaufsorganisation_id,
    buchungskreis_id,
    zahlsperre_id,
    7
    FROM dbp_view.v_gp_buchungskreis_zu_2
    WHERE mandant_id = 1
    AND gp_id < 1000000;
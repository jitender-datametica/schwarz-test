CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_GP_BUCHUNGSKREIS_ZU
    (
    mandant_id
    ,gp_id
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
       FROM dbp_view.v_gp_buchungskreis_zu
       WHERE mandant_id = 1;
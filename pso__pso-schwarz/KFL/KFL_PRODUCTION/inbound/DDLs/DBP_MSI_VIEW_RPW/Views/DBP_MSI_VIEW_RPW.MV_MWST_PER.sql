CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_MWST_PER
    (
    dat_von
    ,mwst_id
    ,mwst
    ,dat_bis
    ,mwst_bez
    ,mandant_id
    ,system_id
    )
    AS
       SELECT
       dat_von,
       mwst_id,
       mwst,
       dat_bis,
       mwst_bez,
       mandant_id,
       7
       FROM dbp_view.v_mwst_per
       WHERE dat_bis = '9999-12-31'
       AND mandant_id = 1;
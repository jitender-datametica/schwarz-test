CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_MWST_PER_1 AS
SELECT  
    mandant_id,
    mwst_id, 
    mwst, 
    dat_von, 
    dat_bis
FROM dbp_view.v_mwst_per_1
WHERE DAT_BIS = '9999-12-31'
;
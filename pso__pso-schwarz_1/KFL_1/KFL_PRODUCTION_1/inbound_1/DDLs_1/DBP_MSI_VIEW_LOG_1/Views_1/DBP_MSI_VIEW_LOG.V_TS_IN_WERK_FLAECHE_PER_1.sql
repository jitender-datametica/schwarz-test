CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.V_TS_IN_WERK_FLAECHE_PER_1 AS 
    SELECT 
        mandant_id
        ,werk_id
        ,gebaeude_bez
        ,gebaeudeteil_bez
        ,flaeche_qm
        ,dat_von
        ,dat_bis


FROM DBP_MSI_VIEW_LOG.TS_IN_WERK_FLAECHE_PER_1 ;
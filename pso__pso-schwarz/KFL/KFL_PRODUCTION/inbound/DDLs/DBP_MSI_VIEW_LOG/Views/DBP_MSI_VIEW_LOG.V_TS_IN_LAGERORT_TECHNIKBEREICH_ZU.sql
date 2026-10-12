CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.V_TS_IN_LAGERORT_TECHNIKBEREICH_ZU AS 
    SELECT 
        mandant_id
        ,werk_id
        ,in_lagerort_id
        ,technikbereich_bez


FROM DBP_MSI_VIEW_LOG.ts_in_lagerort_technikbereich_zu ;
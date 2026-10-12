/* GROUP BY mandant_id,sap_mwst_id
QUALIFY CSUM(1, dat_bis DESC) = 1 order by mandant_id, sap_mwst_id desc; */ SELECT DISTINCT
    mandant_id,
    sap_mwst_id,
    mwst_id,
    dat_von,
    dat_bis
FROM dbp_data.mwst_per
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        mandant_id, sap_mwst_id ORDER BY
        mandant_id IS NULL, mandant_id, sap_mwst_id
        IS NULL DESC, sap_mwst_id DESC
)) = 1;

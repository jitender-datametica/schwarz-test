CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_sqlvariable(p_user_id STRING) AS
SELECT 
    V02.user_id,
    V02.kurstyp_id
FROM kfl_production_dbp_msi_data.akt_msi_user AS V01
INNER JOIN kfl_production_dbp_msi_v_view.v_user_kurstyp_zu AS V02 
    ON V01.user_id = V02.user_id 
WHERE V01.user_id = p_user_id  
GROUP BY 1, 2;

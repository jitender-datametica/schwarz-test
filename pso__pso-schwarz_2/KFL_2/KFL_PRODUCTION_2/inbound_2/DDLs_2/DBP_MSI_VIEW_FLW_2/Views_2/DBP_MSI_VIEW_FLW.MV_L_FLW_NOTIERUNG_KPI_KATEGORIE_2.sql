CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_NOTIERUNG_KPI_KATEGORIE_2 AS
-- 20220317 SPEC0054764 richternic: kuenstliche Lookup View erstellt - relevant fuer die Notierung 
SELECT ROW_NUMBER() OVER (ORDER BY 'DUMMY_2') AS KPI_Kategorie_ID, 
    CASE WHEN KPI_Kategorie_ID = 1 THEN 'Notierung'
    WHEN KPI_Kategorie_ID = 2 THEN 'Notierung - Plan'
    ELSE 'Preis'
    END AS KPI_Kategorie_BEZ
FROM TABLE(GENERATOR(ROWCOUNT => 3)) v 
 ;
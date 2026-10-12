create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_NOTIERUNG_KPI_KATEGORIE_1(
	KPI_KATEGORIE_ID,
	KPI_KATEGORIE_BEZ
) as
-- 20220317 SPEC0054764 richternic: kuenstliche Lookup View erstellt - relevant fuer die Notierung 
SELECT ROW_NUMBER() OVER (ORDER BY 'DUMMY_1') AS KPI_Kategorie_ID, 
    CASE WHEN KPI_Kategorie_ID = 1 THEN 'Notierung'
    WHEN KPI_Kategorie_ID = 2 THEN 'Notierung - Plan'
    ELSE 'Preis'
    END AS KPI_Kategorie_BEZ
FROM TABLE(GENERATOR(ROWCOUNT => 3)) v;
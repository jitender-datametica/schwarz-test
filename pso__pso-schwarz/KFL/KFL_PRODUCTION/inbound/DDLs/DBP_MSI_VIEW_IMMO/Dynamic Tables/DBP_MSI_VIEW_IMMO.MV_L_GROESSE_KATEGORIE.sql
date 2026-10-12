CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_GROESSE_KATEGORIE(
	GROESSE_KATEGORIE,
	GROESSE_VON,
	GROESSE_BIS
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT DISTINCT '01' AS groesse_kategorie, CAST(0 AS DECIMAL (18,2)) AS groesse_von, CAST(150 AS DECIMAL (18,2)) AS groesse_bis FROM dbp_view.v_mandant
   UNION ALL
   SELECT DISTINCT '02' AS groesse_kategorie, CAST(150.01 AS DECIMAL (18,2)) AS groesse_von, CAST(999999 AS DECIMAL(18,2)) AS groesse_bis FROM dbp_view.v_mandant
   UNION ALL
   SELECT DISTINCT '03' AS groesse_kategorie, CAST(0 AS DECIMAL (18,2)) AS groesse_von, CAST(80 AS DECIMAL (18,2)) AS groesse_bis FROM dbp_view.v_mandant
   UNION ALL
   SELECT DISTINCT '04' AS groesse_kategorie, CAST(80.01 AS DECIMAL (18,2)) AS groesse_von, CAST(150 AS DECIMAL (18,2)) AS groesse_bis FROM dbp_view.v_mandant
   UNION ALL
   SELECT DISTINCT '05' AS groesse_kategorie, CAST(0 AS DECIMAL (18,2)) AS groesse_von, CAST(100 AS DECIMAL (18,2)) AS groesse_bis FROM dbp_view.v_mandant
   UNION ALL
   SELECT DISTINCT '06' AS groesse_kategorie, CAST(100.01 AS DECIMAL (18,2)) AS groesse_von, CAST(200 AS DECIMAL (18,2)) AS groesse_bis FROM dbp_view.v_mandant
   UNION ALL
   SELECT DISTINCT '07' AS groesse_kategorie, CAST(0 AS DECIMAL (18,2)) AS groesse_von, CAST(999999 AS DECIMAL (18,2)) AS groesse_bis FROM dbp_view.v_mandant
   UNION ALL
   SELECT DISTINCT '08' AS groesse_kategorie, CAST(0 AS DECIMAL (18,2)) AS groesse_von, CAST(200 AS DECIMAL (18,2)) AS groesse_bis FROM dbp_view.v_mandant;
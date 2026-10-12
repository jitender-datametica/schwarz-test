CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_WSA_KPI_ZU_HILF_2(
	MANDANT_ID,
	REGION_ID,
	BRANCHE_ID,
	GROESSE_KATEGORIE,
	WRG_ID,
	UMSATZ_PRODUKTIVITAET,
	KUNDE_UMSATZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, CASE
   WHEN v1.region_id='1' THEN ('0'||v1.region_id)
   WHEN v1.region_id='2' THEN ('0'||v1.region_id)
   WHEN v1.region_id='3' THEN ('0'||v1.region_id)
   WHEN v1.region_id='4' THEN ('0'||v1.region_id)
   WHEN v1.region_id='5' THEN ('0'||v1.region_id)
   WHEN v1.region_id='6' THEN ('0'||v1.region_id)
   WHEN v1.region_id='7' THEN ('0'||v1.region_id)
   WHEN v1.region_id='8' THEN ('0'||v1.region_id)
   WHEN v1.region_id='9' THEN ('0'||v1.region_id)
   ELSE v1.region_id END AS region_id, branche_id, groesse_kategorie, wrg_id, umsatz_produktivitaet, kunde_umsatz
   FROM dbp_view.v_immo_wsa_kpi_2 AS v1;
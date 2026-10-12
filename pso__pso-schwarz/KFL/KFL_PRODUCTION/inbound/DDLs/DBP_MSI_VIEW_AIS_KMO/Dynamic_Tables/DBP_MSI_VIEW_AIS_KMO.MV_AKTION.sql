CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_AKTION 
(
   AKTION_ID,
   MANDANT_ID,
   AKTIONSART_ID,
   DAT_VON,
   DAT_BIS,
   WW_KJWO
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   -- 04.09.2013 AL bei der Ermittlung ww_kjwo, mandant_id in Partition by aufgenommen
   -- 23.10.2013 sschuecke Aktion_Vortag, kjwo und join auf mv_tag entfernt, Berechnung ww_kjwo in Tabelle
   -- SPEC0014769 Ausbau sap_aktion_id; sschuecke 25.10.2016

   SELECT DISTINCT
   v01.aktion_id AS aktion_id,
   v01.mandant_id AS mandant_id,
   v01.aktionsart_id AS aktionsart_id,
   v01.dat_von AS dat_von,
   v01.dat_bis AS dat_bis,
   v01.kjwo_von AS ww_kjwo

  FROM dbp_view.v_aktion v01

  WHERE mandant_id <> 1;
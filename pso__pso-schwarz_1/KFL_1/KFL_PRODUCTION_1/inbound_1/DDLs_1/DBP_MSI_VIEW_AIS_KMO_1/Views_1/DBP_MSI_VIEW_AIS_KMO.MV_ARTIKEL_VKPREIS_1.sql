CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTIKEL_VKPREIS_1
(
   ART_ID,
	MANDANT_ID,
	VKPK1,
	VKPK1_NETTO,
	VKPK2,
	VKPK3,
	VKPK4,
	VKPK4_NETTO,
	VKPK5,
	VKPK6,
	VKPK7,
	VKPK8,
	VKPK9,
	VKPK10,
	MWST
) -- AL 23.04.2012 Anzeige nicht vorhandenen Werte als NULL
-- Ergänzen um mwst, art_1 als führende Tabelle
-- TB 22.01.2013 Erweitert um VKPK4_Netto
--SSchü 16.01.2014 Erweiterung VKPK6 - 10 - Projekt P0713
AS
SELECT
   v01.art_id,
   v01.mandant_id,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / in diesem Fall nur Umstellung auf akt. Berichtskurs, da immer aktueller Preis - sschuecke 10.01.2025 
   --CASE WHEN v200.wrg_typ_id = 1 THEN 1.00 ELSE v01.umrechnungskurs END umrechnungskurs_,
  CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK1 *umrechnungskurs 
              ELSE _VKPK1 END AS DECIMAL(12,5)) AS VKPK1,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK1 *umrechnungskurs / (1.000 + mwst/100.000)
              ELSE _VKPK1 / (1.000 + mwst/100.000) END AS DECIMAL(12,5)) AS VKPK1_NETTO,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK2 *umrechnungskurs 
              ELSE _VKPK2 END AS DECIMAL(12,5)) AS VKPK2,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK3 *umrechnungskurs 
              ELSE _VKPK3 END AS DECIMAL(12,5)) AS VKPK3,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK4 *umrechnungskurs 
              ELSE _VKPK4 END AS DECIMAL(12,5)) AS VKPK4,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK4 *umrechnungskurs / (1.000 + mwst/100.000)
              ELSE _VKPK4 / (1.000 + mwst/100.000) END AS DECIMAL(12,5)) AS VKPK4_NETTO,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK5 *umrechnungskurs 
              ELSE _VKPK5 END AS DECIMAL(12,5)) AS VKPK5,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK6 *umrechnungskurs 
              ELSE _VKPK6 END AS DECIMAL(12,5)) AS VKPK6,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK7 *umrechnungskurs 
              ELSE _VKPK7 END AS DECIMAL(12,5)) AS VKPK7,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK8 *umrechnungskurs 
              ELSE _VKPK8 END AS DECIMAL(12,5)) AS VKPK8,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK9 *umrechnungskurs 
              ELSE _VKPK9 END AS DECIMAL(12,5)) AS VKPK9,   
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK10 *umrechnungskurs 
              ELSE _VKPK10 END AS DECIMAL(12,5)) AS VKPK10,
   mwst
FROM
   DBP_MSI_VIEW_AIS_KMO.tbl_MV_ARTIKEL_VKPREIS_1 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200;
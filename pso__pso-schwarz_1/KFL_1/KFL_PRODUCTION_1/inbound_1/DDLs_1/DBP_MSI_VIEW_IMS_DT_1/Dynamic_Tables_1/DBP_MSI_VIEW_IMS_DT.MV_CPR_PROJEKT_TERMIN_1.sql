CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_CPR_PROJEKT_TERMIN_1
(
	PROJEKT_ID,
	PROJEKT_EXT_ID,
	IN_PROJEKT_ID,
	MANDANT_ID,
	TECHN_PLATZ_ID,
	TECHN_PLATZ_EBENE_ID,
	MASSNAHME_KZ,
	CPR_KATEGORIE_ID,
	PROJEKT_ANLASS_ID,
	PROJEKTART_ID,
	CPR_PROJEKT_GRUPPE_ID,
	DAT_FREIGABE,
	BAUBEGINN,
	KBE_BAUGENEHMIGUNG_RECHTSK,
	BEGINN_EINRICHTUNG,
	CPR_BAUABNAHME,
	STILLE_EROEFFNUNG
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 08.08.2013 twie: Anlage_1 zur Ermittlung Datum Baubeginn/genehmigung in Anlehnung an IOS Views
--                  Ausgabe aller Projekte aus IND und Ergänzung von Datum aus CPR per Left Outer Join
-- 09.07.2014 twie: Datum für BEGINN_EINRICHTUNG ausgeben, IOS Anfo 601003 wie in IOS View berücksichtigen
-- 18.11.2016 twie: SPEC0015681 2 neue Terminfelder Bauabnahme und stille Eröffnung, ebenfalls mit Logik: wenn vorhanden IST Termin, sonst SOLL Termin, sonst leer
-- 06.03.2018 srom0404: AP0026346, SPEC0034717 - Umstellung auf Aggregat

   SELECT
   pr.projekt_id,
   pr.cpr_ext_id AS projekt_ext_id,
   inpr.in_projekt_id,
   inpr.mandant_id,
   TRIM(pr.techn_platz_id) AS techn_platz_id,
   2 AS techn_platz_ebene_id,
   pr.massnahme_id AS massnahme_kz,
   pr.cpr_kategorie_id,
   pr.projekt_anlass_id,
   pr.projektart_id,
   CAST(NULL AS VARCHAR(40)) AS cpr_projekt_gruppe_id,
   pr.dat_freigabe,
   MIN(CASE WHEN bau.cpr_suchfeld_id IN (2, 407) THEN bau.dat_ips ELSE NULL END) AS BAUBEGINN,
   MIN(CASE WHEN bau.cpr_suchfeld_id IN (84, 392) THEN bau.dat_ips ELSE NULL END) AS KBE_BAUGENEHMIGUNG_RECHTSK,
   MIN(CASE WHEN bau.cpr_suchfeld_id IN (3, 408) THEN bau.dat_ips ELSE NULL END) AS BEGINN_EINRICHTUNG,
   MAX (CASE WHEN bau.cpr_suchfeld_id = 123 THEN bau.dat_ips ELSE NULL END) AS CPR_BAUABNAHME,
   MAX (CASE WHEN bau.cpr_suchfeld_id IN (113, 410) THEN bau.dat_ips ELSE NULL END) AS STILLE_EROEFFNUNG

   FROM dbp_view.v_in_projekt_1 inpr
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_cpr_projekt_per_1 t
   WHERE t.dat_bis = '9999-12-31'
   )  pr
   ON inpr.projekt_ext_id = pr.cpr_ext_id
   -- Teile aus .mv_projekt_termin
   LEFT JOIN (
   SELECT cpr_ext_id,
   cpr_suchfeld_id,
   CASE WHEN dat_ende_ist > '2010' THEN dat_ende_ist WHEN dat_ende_vorhersage > '2010' THEN dat_ende_vorhersage WHEN dat_ende_einschraenkung > '2010' THEN dat_ende_einschraenkung ELSE NULL END AS dat_ips
   FROM dbp_view.v_cpr_projekt_bauabschnitt_zu_1
   WHERE sort_id = 1
   AND cpr_suchfeld_id IN (3, 84, 113, 123, 392, 407, 408, 410)) bau
   ON inpr.projekt_ext_id =  bau.cpr_ext_id
   GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
   ;
CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IN_PROJEKT_ABRG_DAT_ZU
(
	MANDANT_ID,
	IN_PROJEKT_ID,
	IN_PROJEKT_ID_CHAR,
	DAT_,
	ABRG_DAT
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- AL  20.06.2013 Init
-- Logik wenn alle PSP Elemente von einem Projekt eine dat_asbschluss enthalten ==> nehme maximale
-- wenn mindestens ein PSP Element NULL in dem Feld dat_asbschluss enthält ==> abgr_dat =101 und über Lookup ausgeblendet als ''

   SELECT v01.mandant_id,
   v01. in_projekt_id,
   MAX(in_projekt_id_char) AS in_projekt_id_char,
   MAX(COALESCE(dat_abschluss, '9999-12-31')) AS dat_,
   CASE WHEN dat_='9999-12-31'
   THEN '2001'
   ELSE dat_
   END AS abrg_dat

   FROM dbp_view.v_in_projekt v01
   JOIN dbp_view.v_in_psp_element v02
   ON
   v01.in_projekt_id = v02.in_projekt_id AND
   v01.mandant_id  =  v02.mandant_id

   WHERE statistisch_fg=1
   GROUP BY  v01.mandant_id,
   v01. in_projekt_id
;
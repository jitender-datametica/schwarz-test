CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_KONZESSIONAER_PER_2(
	MANDANT_ID,
	KONZESSIONAER_ID,
	K_006,
	K_003,
	K_LEN,
	KONZESSIONAER_NAME,
	KONZ_GRUPPE_ID,
	KONZESSIONAER_HOLDING_ID,
	DAT_VON,
	DAT_BIS,
	KONZESSIONAER_BRANCHE_ID,
	INTERN_FG,
	LAND_ID,
	KONZESSIONAER_PLZ,
	KONZESSIONAER_ORT,
	KONZESSIONAER_STRASSE,
	KONZESSIONAER_RECHTSFORM,
	DAT_INSOLVENZ_EINTRITT,
	KONZESSIONAER_TOPMIETER_FG,
	ROW_NR
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
---------------------------------------------------------------
-- Lookup Stammdaten Konzessionaer (Ebene Debitor)
-- 2011KW34 konzessionaer_id von 0 auf '0' umgestellt.
-- 2011KW50 Update Verbundkennz1 (konzessionaer_gruppe)
-- 2013KW13 Transkription ergaenzt
-- 20200710 SPEC0081244 sanadze: Initialisierung
-- 20201223 SPEC0089773 twie1305: Behebung Datenfehler in Tabelle (temporär)
--					Es gibt pro Konzessionär mehrere Einträge mit dat_bis = 31.12.9999, deshalb nur den mit höchstem dat_von ausgeben
---------------------------------------------------------------

SELECT
   mandant_id
  ,konzessionaer_id
    ,SUBSTRING(dbp_process.transcriptc(konzessionaer_name) , 1 , 6) AS k_006
  ,SUBSTRING(dbp_process.transcriptc(konzessionaer_name) , 1 , 3) AS k_003
  ,LENGTH(konzessionaer_name) AS k_len
  ,dbp_process.transcriptc
   (
     CASE WHEN konzessionaer_id = '0' THEN ' ' 
          WHEN k_006 = 'KK MB ' OR k_006 = 'KK  MB' THEN TRIM(SUBSTRING(konzessionaer_name , 7 , k_len - 7))
          WHEN k_003 = 'KK ' OR k_003 = 'MB ' THEN TRIM(SUBSTRING(konzessionaer_name , 4 , k_len - 3))
          ELSE konzessionaer_name 
     END
   )       AS konzessionaer_name
  ,CASE WHEN konzessionaer_id = '0' THEN '0' ELSE konzessionaer_gruppe_id END  AS konz_gruppe_id
  ,CASE WHEN konzessionaer_id = '0' THEN '0' ELSE konzessionaer_holding_id END AS konzessionaer_holding_id
  ,dat_von
  ,dat_bis
  ,CAST(COALESCE(konzessionaer_branche_id, '000') AS CHAR(3))                         AS konzessionaer_branche_id
  ,CAST(CASE WHEN konzessionaer_id = '0' THEN 'E' ELSE intern_fg END AS CHAR(1))      AS intern_fg
  ,land_id
  ,konzessionaer_plz
  ,dbp_process.transcriptc(konzessionaer_ort) AS konzessionaer_ort
  ,dbp_process.transcriptc(konzessionaer_strasse) AS konzessionaer_strasse
  ,konzessionaer_rechtsform
  ,dat_insolvenz_eintritt
  ,konzessionaer_topmieter_fg
   -- hilfsspalten
   --Pro Konzessionär absteigend nach dat_von sortieren
  ,ROW_NUMBER() OVER (PARTITION BY konzessionaer_id ORDER BY dat_von DESC) AS row_nr
FROM dbp_view.v_ivs_konzessionaer_per_2
WHERE dat_bis = '9999-12-31'
QUALIFY row_nr =1;
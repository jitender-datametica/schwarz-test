CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_IVS_KONZESSIONAER_PER
AS
   -- Lookup Stammdaten Konzessionaer (Ebene Debitor)
   -- 2012KW25 : Initial von IVS nach VIS
   -- 2013KW03 Transkription
select
mandant_id
, konzessionaer_id
, konzessionaer_name
, konz_gruppe_id
, konzessionaer_holding_id
, dat_von
, dat_bis
, konzessionaer_branche_id
, intern_fg
, land_id
, konzessionaer_plz
, konzessionaer_ort
, konzessionaer_strasse
, konzessionaer_rechtsform
, dat_insolvenz_eintritt
, konzessionaer_topmieter_fg
, k_006
, k_003
, k_len
from
(
   SELECT
   mandant_id
   , konzessionaer_id
   , SUBSTRING(dbp_process.transcriptc(konzessionaer_name), 1, 3) AS k_003
   , SUBSTRING(dbp_process.transcriptc(konzessionaer_name), 1, 6) AS k_006
   , length(konzessionaer_name) AS k_len
   , dbp_process.transcriptc
   (
   CASE
   WHEN konzessionaer_id = '0' THEN ' '
   WHEN 
 k_006 = 'KK MB ' OR 
 k_006 = 'KK  MB' THEN TRIM(SUBSTRING(konzessionaer_name, 7, 
 k_len - 7))
   WHEN 
 k_003 = 'KK ' OR 
 k_003 = 'MB ' THEN TRIM(SUBSTRING(konzessionaer_name, 4, 
 k_len - 3))
   ELSE konzessionaer_name
   END
   ) AS konzessionaer_name
   , CASE WHEN konzessionaer_id = '0' THEN '0' ELSE konzessionaer_gruppe_id END  AS konz_gruppe_id
   , CASE WHEN konzessionaer_id = '0' THEN '0' ELSE konzessionaer_holding_id END AS konzessionaer_holding_id
   , dat_von
   , dat_bis
   , COALESCE(konzessionaer_branche_id, '000')::CHAR(3)                            AS konzessionaer_branche_id
   , CASE WHEN konzessionaer_id = '0' THEN 'E' ELSE intern_fg END::CHAR(1)      AS intern_fg
   , land_id, konzessionaer_plz
   , dbp_process.transcriptc(konzessionaer_ort) AS konzessionaer_ort
   , dbp_process.transcriptc(konzessionaer_strasse) AS konzessionaer_strasse
   , konzessionaer_rechtsform, dat_insolvenz_eintritt
   , konzessionaer_topmieter_fg
   --, SUBSTRING(dbp_process.transcriptc(konzessionaer_name), 1, 6) AS k_006
   --, SUBSTRING(dbp_process.transcriptc(konzessionaer_name), 1, 3) AS k_003
   --, CHARACTER(konzessionaer_name) AS k_len

   FROM dbp_view.v_ivs_konzessionaer_per
   WHERE dat_bis = '9999-12-31'
  )
;
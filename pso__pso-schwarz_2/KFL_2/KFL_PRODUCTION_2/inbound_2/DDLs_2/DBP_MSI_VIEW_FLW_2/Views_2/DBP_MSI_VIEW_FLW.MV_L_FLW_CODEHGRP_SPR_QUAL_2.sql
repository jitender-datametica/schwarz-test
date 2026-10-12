CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_CODEHGRP_SPR_QUAL_2
(
mandant_id
, codehgrp_id
, spr_id
, codegruppe_bez
)
AS
   SELECT
   v01.mandant_id, SUBSTRING(codegruppe_id, 3, 1) AS codehgrp_id, v01.spr_id, MAX(v01.codegruppe_bez) AS codegruppe_bez
   FROM dbp_view.v_flw_codegruppe_spr_zu_2 v01
   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id
   --katalogart_id = 9 entspricht  Qualitaetsmeldung/Anlieferungsbewertung/Kopfbewertung
   WHERE v01.katalogart_id = '9'
   --Fleischwerk relevante Codegruppen (laut Konzept eingeschraenkt)
   --beginnen mit Z und enden mit einem Ziffer
   AND
   SUBSTR( codegruppe_id, 1, 1) = 'Z'
   AND codehgrp_id BETWEEN '0'AND '9'
   GROUP BY
   v01.mandant_id
   , codehgrp_id
   , v01.spr_id;
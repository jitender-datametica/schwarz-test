create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_CODEHGRP_SPR_QUAL(
	MANDANT_ID,
	CODEHGRP_ID,
	SPR_ID,
	CODEGRUPPE_BEZ
) as

   SELECT

   v01.mandant_id, SUBSTRING(codegruppe_id, 3, 1) AS codehgrp_id, v01.spr_id, MAX(v01.codegruppe_bez) AS codegruppe_bez

   FROM dbp_view.v_flw_codegruppe_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02

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
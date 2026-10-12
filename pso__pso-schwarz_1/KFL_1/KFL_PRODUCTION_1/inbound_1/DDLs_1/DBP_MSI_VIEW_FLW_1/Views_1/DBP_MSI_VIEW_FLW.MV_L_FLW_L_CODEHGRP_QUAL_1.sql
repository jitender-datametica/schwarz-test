CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_CODEHGRP_QUAL_1
(

mandant_id
, codehgrp_id
)
AS
   SELECT

   v01.mandant_id, 

  SUBSTRING(codegruppe_id, LENGTH (COLLATE(TRIM(COLLATE(codegruppe_id,''),''), 'en-ci-trim')), 1) AS codehgrp_id

   FROM dbp_view.v_flw_l_codegruppe_1 v01

   WHERE
   --katalogart_id = 9 entspricht  Qualitaetsmeldung/Anlieferungsbewertung/Kopfbewertung
   v01.katalogart_id = '9'

   --Fleischwerk relevante Codegruppen (laut Konzept eingeschraenkt)
   --beginnen mit Z und enden mit einem Ziffer
   AND
   SUBSTR( codegruppe_id, 1, 1) = 'Z'
   AND codehgrp_id between '0' and '9'
   GROUP BY   v01.mandant_id, codehgrp_id;
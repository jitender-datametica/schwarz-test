CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_CODEGRUPPE_QUAL_1
-- 26.10.2011 system_id entfernt
(
--  system_id
mandant_id
, katalogart_id
, codegruppe_id
, codehgrp_id
)
AS
   SELECT
   --  v01.system_id
   v01.mandant_id, v01.katalogart_id, 
   v01.codegruppe_id, 
   SUBSTRING(codegruppe_id, 3, 1) AS codehgrp_id
   FROM dbp_view.v_flw_l_codegruppe_1 v01
   --katalogart_id = 9 entspricht  Qualitaetsmeldung/Anlieferungsbewertung/Kopfbewertung
   WHERE v01.katalogart_id = '9';
CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_CODEGRUPPE_LOS_2
-- 26.10.2011 system_id entfernt
(
--  system_id
mandant_id
, katalogart_id
, codegruppe_id
)
AS
   SELECT
   --  v01.system_id
   v01.mandant_id, v01.katalogart_id, v01.codegruppe_id

   FROM dbp_view.v_flw_l_codegruppe_2 v01
   --katalogart_id = 1 entspricht  Prueflosebene/Produktbewertung
   WHERE v01.katalogart_id = '1';
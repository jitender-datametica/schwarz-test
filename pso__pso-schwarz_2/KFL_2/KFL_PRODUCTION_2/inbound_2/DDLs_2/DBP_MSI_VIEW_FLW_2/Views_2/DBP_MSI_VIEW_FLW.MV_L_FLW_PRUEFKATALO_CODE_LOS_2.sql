CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_PRUEFKATALO_CODE_LOS_2
-- 26.10.2011 system_id entfernt
(
--  system_id
mandant_id
, katalogart_id
, codegruppe_id
, werk_id
, pruefcode_id
, auswahlmenge
)
AS
   SELECT
   --  v01.system_id
   v01.mandant_id, v01.katalogart_id, v01.codegruppe_id, v01.werk_id, v01.pruefcode_id, v01.auswahlmenge

   FROM dbp_view.v_flw_l_pruefkatalog_code_2 v01
   --katalogart_id = 1 entspricht  Prueflosebene/Produktbewertung
   WHERE v01.katalogart_id = '1';
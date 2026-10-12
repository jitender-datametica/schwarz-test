CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_HANDLING_UNIT_1
--14.09.2018 mmzy2302: Neuanlegen der View mit explizitem Ausweis aller Felder
--05.02.2019 twie: flw_kunde_id in in_kunde_id umbenannt
(
mandant_id
, handling_unit_id
, in_kunde_id
, handling_unit_id_ext
, ntvol_ladung
, brtvol_ladung
, ntgew_ladung
, brtgew_ladung
, hu_voleinh_id
, hu_geweinh_id
--,Anzahl_Pal
)

AS
   SELECT
  mandant_id, handling_unit_id, flw_kunde_id AS in_kunde_id, handling_unit_id_ext, ntvol_ladung, brtvol_ladung, ntgew_ladung, brtgew_ladung, hu_voleinh_id, hu_geweinh_id
   --,1 AS Anzahl_Pal
   FROM
   dbp_view.v_flw_handling_unit_1;
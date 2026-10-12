CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_HANDLING_UNIT_DET_1
--14.09.2018 mmzy2302: Neuanlegen der View mit explizitem Ausweis aller Felder
(
mandant_id
, handling_unit_id
, handling_unit_pos_id
, anz_verk_menge_einh
, verk_menge_einh_id
)
AS
   SELECT
  mandant_id, handling_unit_id, handling_unit_pos_id, anz_verk_menge_einh, verk_menge_einh_id
   FROM dbp_view.v_flw_handling_unit_det_1;
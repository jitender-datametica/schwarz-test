CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_OWG_SPR_ZU
as 
SELECT
   owg_id,
   arthiertyp_id,
   mandant_id,
   owg_bez,
spr_id
   FROM dbp_view.v_owg_spr_zu v01
   WHERE mandant_id >1;
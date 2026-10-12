CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_OWG_SPR_ZU_2
as 
SELECT
   owg_id,
   arthiertyp_id,
   mandant_id,
   owg_bez,
spr_id
   FROM dbp_view.v_owg_spr_zu_2 v01
   WHERE mandant_id >1;
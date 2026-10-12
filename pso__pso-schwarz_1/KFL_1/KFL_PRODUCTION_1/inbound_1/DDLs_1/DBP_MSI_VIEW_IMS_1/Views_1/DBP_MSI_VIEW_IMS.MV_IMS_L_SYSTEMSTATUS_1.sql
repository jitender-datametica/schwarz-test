CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IMS_L_SYSTEMSTATUS_1 AS
-- 20.08.2013 twie: Erstellung Lookupview Systemstatus

   SELECT
   systemstatus_id,
   mandant_id

   FROM dbp_view.v_ims_l_systemstatus_1
;
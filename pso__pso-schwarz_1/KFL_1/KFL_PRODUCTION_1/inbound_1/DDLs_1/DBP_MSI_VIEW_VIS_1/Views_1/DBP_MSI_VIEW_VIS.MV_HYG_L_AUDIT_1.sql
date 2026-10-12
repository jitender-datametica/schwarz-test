CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HYG_L_AUDIT_1 as
   -- LOOKUP Hygienecheck - Audit/Instanz
   -- 20140325 Initial
   -- 2015KW26 Update GJ-Abhaengigkeit

   SELECT
   hyg_audit_id, audit_instance_id, audit_instance_bez, notes, gj
   FROM dbp_view.v_hyg_audit_1
;
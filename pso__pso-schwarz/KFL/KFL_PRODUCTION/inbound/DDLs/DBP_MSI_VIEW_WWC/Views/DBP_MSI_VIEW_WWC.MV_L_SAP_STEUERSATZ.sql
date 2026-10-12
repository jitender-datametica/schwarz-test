CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_L_SAP_STEUERSATZ as
   SELECT
   steuer_typ_id, sap_steuer_id, mandant_id
   FROM dbp_view.v_l_sap_steuersatz
;
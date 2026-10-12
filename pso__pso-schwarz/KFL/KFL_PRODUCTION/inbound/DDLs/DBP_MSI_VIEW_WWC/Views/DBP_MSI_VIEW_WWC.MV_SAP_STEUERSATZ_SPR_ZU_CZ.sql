CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_SAP_STEUERSATZ_SPR_ZU_CZ as
   SELECT
   steuer_typ_id, sap_steuer_id, mandant_id, sap_steuer_bez
   FROM dbp_view.v_sap_steuersatz_spr_zu
   WHERE spr_id = 124
;
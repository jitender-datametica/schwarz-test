CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_SAP_STEUERSATZ_SPR_ZU_PL_2 as
   SELECT
   steuer_typ_id, sap_steuer_id, mandant_id, sap_steuer_bez
   FROM dbp_view.v_sap_steuersatz_spr_zu_2
   WHERE spr_id = 90
;
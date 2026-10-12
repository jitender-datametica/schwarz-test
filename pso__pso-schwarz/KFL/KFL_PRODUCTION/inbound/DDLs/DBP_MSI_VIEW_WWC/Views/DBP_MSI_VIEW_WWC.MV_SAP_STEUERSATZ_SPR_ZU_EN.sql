CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_SAP_STEUERSATZ_SPR_ZU_EN as
   SELECT
   steuer_typ_id, sap_steuer_id, mandant_id, COALESCE(MAX(CASE WHEN spr_id = 24 THEN sap_steuer_bez END),
   MAX(CASE WHEN spr_id = 22 THEN sap_steuer_bez END)
   ) AS sap_steuer_bez
   FROM dbp_view.v_sap_steuersatz_spr_zu
   WHERE spr_id IN (22,24) -- deutsch, englisch
   GROUP BY 1,2,3
;
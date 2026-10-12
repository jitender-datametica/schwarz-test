CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_GEPLANTE_AKTION_1
-- SPEC0014769 Ausbau sap-aktion_id; sschuecke 25.10.2016
(
geplante_aktion_id
, geplante_sap_aktion_id
, mandant_id
)
AS
   SELECT
   plan_aktion_id, aktion_id, mandant_id

   FROM dbp_view.v_aktion_art_aktion_zu_1
  
   WHERE mandant_id <>1
    GROUP BY 1,2,3;
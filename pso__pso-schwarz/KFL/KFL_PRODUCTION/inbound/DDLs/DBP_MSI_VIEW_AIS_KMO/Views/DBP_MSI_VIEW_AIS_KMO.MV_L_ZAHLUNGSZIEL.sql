CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_ZAHLUNGSZIEL
(
mandant_id
, zahlungsziel_id
, zahlungsziel_1_tage
, zahlungsziel_1_prozent
)
AS

   SELECT v01.mandant_id,
   v01.zahlungsziel_id,
   v01.zahlungsziel_1_tage,
   v01.zahlungsziel_1_prozent

  FROM dbp_view.v_l_zahlungsziel v01

   WHERE v01.mandant_id <> 1;
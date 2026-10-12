CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_L_QUELLE
-- 20180528 twie: SPEC0038139 Neuanlage Lookup Quelle in KMR
--                           Quelle wird in DWH generiert, existiert nicht im Quellsystem

(
kmr_quelle_id
,kmr_quelle_bez
)
AS
   SELECT

   kmr_quelle_id, kmr_quelle_bez

   FROM dbp_view.v_kmr_l_quelle
;
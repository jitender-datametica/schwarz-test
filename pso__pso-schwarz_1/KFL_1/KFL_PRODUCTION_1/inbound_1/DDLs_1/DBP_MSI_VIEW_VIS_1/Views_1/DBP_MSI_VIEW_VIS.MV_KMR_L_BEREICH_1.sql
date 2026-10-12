CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_L_BEREICH_1
-- 20180528 twie: SPEC0038139 Neuanlage Lookup übergreifender Bereich in KMR
--                           Bereich wird in DWH generiert, existiert nicht im Quellsystem

(
kmr_bereich_id
)
AS
   SELECT

   kmr_bereich_id

   FROM dbp_view.v_kmr_l_bereich_1
;
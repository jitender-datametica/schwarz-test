CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MA_PERSONALBEREICH_ZU_PER_1
(
mandant_id
,system_id
,buchungskreis_id
,mitarbeiter_id
,kjmo

)
AS
   SELECT
   mandant_id, system_id, buchungskreis_id, mitarbeiter_id, kjmo


   FROM dbp_view.v_ma_personalbereich_zu_per_1;
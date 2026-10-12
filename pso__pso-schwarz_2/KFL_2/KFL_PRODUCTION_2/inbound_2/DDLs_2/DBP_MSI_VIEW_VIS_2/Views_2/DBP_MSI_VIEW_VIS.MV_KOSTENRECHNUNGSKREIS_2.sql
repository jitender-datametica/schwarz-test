CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KOSTENRECHNUNGSKREIS_2
(
krk_bez
,krk_id
,mandant_id
,system_id
,mandant_bez
)
AS
   SELECT
  k.krk_bez, k.krk_id, k.mandant_id, k.system_id, m.mandant_bez
   FROM dbp_view.v_l_kostenrechnungskreis_2 k
   INNER JOIN dbp_view.v_mandant_2 m
   ON
   k.mandant_id=m.mandant_id;
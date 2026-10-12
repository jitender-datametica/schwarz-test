CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_BEST_BELOS_VORGANG_ZU
(
belos_vorgang_id
,best_beleg_id
,mandant_id
)
AS
   SELECT
  belos_vorgang_id, best_beleg_id, mandant_id

   FROM dbp_view.v_besch_best_belos_vorgang_zu;
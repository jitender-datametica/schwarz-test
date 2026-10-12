CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VORGART_BEST_ENTW
(
mandant_id,
vorgart_best_entw_id
)
AS
   SELECT
  mandant_id, vorgart_best_entw_id
   FROM dbp_view.v_l_vorgart_best_entw;